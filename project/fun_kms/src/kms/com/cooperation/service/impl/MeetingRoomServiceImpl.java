package kms.com.cooperation.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.cooperation.service.MeetingRoom;
import kms.com.cooperation.service.MeetingRoomComment;
import kms.com.cooperation.service.MeetingRoomRecieve;
import kms.com.cooperation.service.MeetingRoomService;
import kms.com.cooperation.service.MeetingRoomVO;
import kms.com.member.service.impl.MemberDAO;

@Service("KmsMeetingRoomService")
public class MeetingRoomServiceImpl implements MeetingRoomService {

	@Resource(name = "KmsMeetingRoomDAO")
	private MeetingRoomDAO mtDAO;
	
	@Resource(name = "KmsMemberDAO")
	private MemberDAO memberDAO;
	
	@Resource(name = "kmsMeetingRoomIdGnrService")
	private EgovIdGnrService idGnrService;
	
	@Override
	public List<MeetingRoomVO> selectMeetingRoomList(MeetingRoomVO meetingRoomVO) throws Exception {
		/* [2015/02/26, dwkim] 모든 회의실 목록보기, 임시로 추가(김태연 부장님, 박현준과장님) */
		if ("all".equals(meetingRoomVO.getInputType())) {
			return mtDAO.tmpSelectMeetingRoomList(meetingRoomVO);
		}
		return mtDAO.selectMeetingRoomList(meetingRoomVO);
	}

	@Override
	public int selectMeetingRoomListTotCnt(MeetingRoomVO meetingRoomVO) throws Exception {
		/* [2015/02/26, dwkim] 모든 회의실 목록보기, 임시로 추가(김태연 부장님, 박현준과장님) */
		if ("all".equals(meetingRoomVO.getInputType())) {
			return mtDAO.tmpSelectMeetingRoomListTotCnt(meetingRoomVO);
		}
		return mtDAO.selectMeetingRoomListTotCnt(meetingRoomVO);
	}

	@Override
	public MeetingRoomVO selectMeetingRoom(MeetingRoomVO meetingRoomVO) throws Exception {
		/* [2015/02/26, dwkim] 모든 회의실 목록보기, 임시로 추가(김태연 부장님, 박현준과장님) */
		if (!"all".equals(meetingRoomVO.getInputType())) {
			mtDAO.setReadtime(meetingRoomVO);
		}
		MeetingRoomVO result = mtDAO.selectMeetingRoom(meetingRoomVO);
		List<MeetingRoomRecieve> rList = selectMeetingRoomRecieve(meetingRoomVO);
		
		for (int i=0; i<rList.size(); i++) {
			MeetingRoomRecieve r = rList.get(i);
			if (r.getRecieveTyp().equals("RE")) {
				result.addRecieveList(r);
			}
			else if (r.getRecieveTyp().equals("RF")) {
				result.addReferenceList(r);
			}
		}
		
		return result;
	}

	@Override
	public List<MeetingRoomRecieve> selectMeetingRoomRecieve(MeetingRoomVO meetingRoomVO) throws Exception {
		return mtDAO.selectMeetingRoomRecieve(meetingRoomVO);
	}

	@Override
	public String insertMeetingRoom(MeetingRoom meetingRoom, MeetingRoomRecieve meetingRoomRecieve) throws Exception {
		String mtId = idGnrService.getNextStringId();
		meetingRoom.setMtId(mtId);
		meetingRoomRecieve.setMtId(mtId);
		
		mtDAO.insertMeetingRoom(meetingRoom);
		insertMeetingRoomRecieve(meetingRoomRecieve);
		
		return mtId;
	}

	@Override
	public void updateMeetingRoom(MeetingRoom meetingRoom) throws Exception {
		mtDAO.updateMeetingRoom(meetingRoom);
	}
	
	@Override
	public void updateMeetingResult(MeetingRoom meetingRoom) throws Exception {
		mtDAO.updateMeetingResult(meetingRoom);
		mtDAO.updateMeetingReadTime(meetingRoom);
	}
	
	@Override
	public void updateMeetingRoom(MeetingRoom meetingRoom, MeetingRoomRecieve meetingRoomRecieve) throws Exception {
		mtDAO.updateMeetingRoom(meetingRoom);
		
		List<Integer> userList = mtDAO.selectInterestUserNoList(meetingRoomRecieve);
		mtDAO.deleteMeetingRoomRecieve(meetingRoomRecieve);
		
		if (CommonUtil.isMixedId(meetingRoomRecieve.getRecUserMixes())) {
			meetingRoomRecieve.setRecUserIdList(CommonUtil.parseIdFromMixs(meetingRoomRecieve.getRecUserMixes()));
		}
		if (CommonUtil.isMixedId(meetingRoomRecieve.getRefUserMixes())) {
			meetingRoomRecieve.setRefUserIdList(CommonUtil.parseIdFromMixs(meetingRoomRecieve.getRefUserMixes()));
		}
		mtDAO.insertMeetingRoomRecieve(meetingRoomRecieve);
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("mtId", meetingRoomRecieve.getMtId());
		param.put("userList", userList);
		mtDAO.setInterestBc(param);
	}

	@Override
	public void insertMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) throws Exception {
		if (CommonUtil.isMixedId(meetingRoomRecieve.getRecUserMixes())) {
			meetingRoomRecieve.setRecUserIdList(CommonUtil.parseIdFromMixs(meetingRoomRecieve.getRecUserMixes()));
		}
		if (CommonUtil.isMixedId(meetingRoomRecieve.getRefUserMixes())) {
			meetingRoomRecieve.setRefUserIdList(CommonUtil.parseIdFromMixs(meetingRoomRecieve.getRefUserMixes()));
		}
		mtDAO.insertMeetingRoomRecieve(meetingRoomRecieve);
	}
	
	@Override
	public void updateMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) throws Exception {
		mtDAO.updateMeetingRoomRecieve(meetingRoomRecieve);
	}
	
	@Override
	public void deleteMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) throws Exception {
		mtDAO.deleteMeetingRoomRecieve(meetingRoomRecieve);
	}
	
	@Override
	public void changeMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) throws Exception {

		List<Integer> userList = mtDAO.selectInterestUserNoList(meetingRoomRecieve);
		mtDAO.deleteMeetingRoomRecieve(meetingRoomRecieve);
		
		if (CommonUtil.isMixedId(meetingRoomRecieve.getRecUserMixes())) {
			meetingRoomRecieve.setRecUserIdList(CommonUtil.parseIdFromMixs(meetingRoomRecieve.getRecUserMixes()));
		}
		if (CommonUtil.isMixedId(meetingRoomRecieve.getRefUserMixes())) {
			meetingRoomRecieve.setRefUserIdList(CommonUtil.parseIdFromMixs(meetingRoomRecieve.getRefUserMixes()));
		}
		mtDAO.insertMeetingRoomRecieve(meetingRoomRecieve);
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("mtId", meetingRoomRecieve.getMtId());
		param.put("userList", userList);
		mtDAO.setInterestBc(param);
	}
	
	@Override
	public void changeMeetingRoomWriter(MeetingRoomRecieve meetingRoomRecieve) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchUserNm", meetingRoomRecieve.getWrtUser());
		int no = memberDAO.selectUserNo(param);
		meetingRoomRecieve.setNo(no);
		mtDAO.updateMeetingRoomWriter(meetingRoomRecieve);
	}
	
	@Override
	public List<MeetingRoomComment> selectMeetingRoomCommentList(MeetingRoomComment meetingRoomComment) throws Exception {
		return mtDAO.selectMeetingRoomCommentList(meetingRoomComment);
	}
	
	@Override
	public MeetingRoomComment selectMeetingRoomComment(MeetingRoomComment meetingRoomComment) throws Exception {
		List<MeetingRoomComment> list = selectMeetingRoomCommentList(meetingRoomComment);
		
		if (list.size() == 1)
			return list.get(0);
		else
			return new MeetingRoomComment();
	}
	
	@Override
	public void insertMeetingRoomComment(MeetingRoomComment meetingRoomComment) throws Exception {
		mtDAO.insertMeetingRoomComment(meetingRoomComment);
		mtDAO.deleteReadTime(meetingRoomComment);
	}
	
	@Override
	public void updateMeetingRoomComment(MeetingRoomComment meetingRoomComment) throws Exception {
		mtDAO.updateMeetingRoomComment(meetingRoomComment);
		mtDAO.deleteReadTime(meetingRoomComment);
	}

	@Override
	public List<MeetingRoomVO> selectMeetingRoomListHeadSearch(MeetingRoomVO mtVO) throws Exception {
		return mtDAO.selectMeetingRoomListHeadSearch(mtVO);
	}

	@Override
	public int selectMeetingRoomListTotCntHeadSearch(MeetingRoomVO mtVO) throws Exception {
		return mtDAO.selectMeetingRoomListTotCntHeadSearch(mtVO);
	}
}
