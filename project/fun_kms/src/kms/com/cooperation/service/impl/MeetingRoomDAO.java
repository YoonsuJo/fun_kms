package kms.com.cooperation.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.cooperation.service.MeetingRoomRecieve;
import kms.com.cooperation.service.MeetingRoom;
import kms.com.cooperation.service.MeetingRoomComment;
import kms.com.cooperation.service.MeetingRoomRecieve;
import kms.com.cooperation.service.MeetingRoomVO;
import kms.com.cooperation.service.MeetingRoomVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("KmsMeetingRoomDAO")
public class MeetingRoomDAO extends EgovAbstractDAO {

	public List<MeetingRoomVO> selectMeetingRoomList(MeetingRoomVO meetingRoomVO) {
		return list("MeetingRoomDAO.selectMeetingRoomList", meetingRoomVO);
	}
	
	public int selectMeetingRoomListTotCnt(MeetingRoomVO meetingRoomVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MeetingRoomDAO.selectMeetingRoomListTotCnt", meetingRoomVO);
	}

	public MeetingRoomVO selectMeetingRoom(MeetingRoomVO meetingRoomVO) {
		return (MeetingRoomVO)selectByPk("MeetingRoomDAO.selectMeetingRoom", meetingRoomVO);
	}

	public List<MeetingRoomRecieve> selectMeetingRoomRecieve(MeetingRoomVO meetingRoomVO) {
		return list("MeetingRoomDAO.selectMeetingRoomRecieve", meetingRoomVO);
	}

	public void insertMeetingRoom(MeetingRoom meetingRoom) {
		insert("MeetingRoomDAO.insertMeetingRoom", meetingRoom);
	}

	public void updateMeetingRoom(MeetingRoom meetingRoom) {
		update("MeetingRoomDAO.updateMeetingRoom", meetingRoom);
	}

	public void updateMeetingResult(MeetingRoom meetingRoom) {
		update("MeetingRoomDAO.updateMeetingResult", meetingRoom);
	}

	public void deleteMeetingRoom(MeetingRoom meetingRoom) {
		update("MeetingRoomDAO.deleteMeetingRoom", meetingRoom);
	}

	public void insertMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) {
		insert("MeetingRoomDAO.insertMeetingRoomRecieve", meetingRoomRecieve);
	}

	public void updateMeetingRoomWriter(MeetingRoomRecieve meetingRoomRecieve) {
		update("MeetingRoomDAO.updateMeetingRoomWriter", meetingRoomRecieve);
	}
	
	public void updateMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) {
		update("MeetingRoomDAO.updateMeetingRoomRecieve", meetingRoomRecieve);
	}

	public void deleteMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) {
		delete("MeetingRoomDAO.deleteMeetingRoomRecieve", meetingRoomRecieve);
	}

	public void updateMeetingReadTime(MeetingRoom meetingRoom) {
		delete("MeetingRoomDAO.updateMeetingReadTime", meetingRoom);
	}

	public void setReadtime(MeetingRoomVO meetingRoomVO) {
		update("MeetingRoomDAO.setReadtime", meetingRoomVO);
	}

	public void deleteReadTime(MeetingRoomComment meetingRoomComment) {
		update("MeetingRoomDAO.deleteReadtime", meetingRoomComment);
	}
	
	public List<MeetingRoomComment> selectMeetingRoomCommentList(MeetingRoomComment meetingRoomComment) {
		return list("MeetingRoomDAO.selectMeetingRoomCommentList", meetingRoomComment);
	}

	public void insertMeetingRoomComment(MeetingRoomComment meetingRoomComment) {
		insert("MeetingRoomDAO.insertMeetingRoomComment", meetingRoomComment);
	}

	public void updateMeetingRoomComment(MeetingRoomComment meetingRoomComment) {
		update("MeetingRoomDAO.updateMeetingRoomComment", meetingRoomComment);		
	}

	public List<MeetingRoomVO> selectMeetingRoomListHeadSearch(MeetingRoomVO bcVO) {
		return list("MeetingRoomDAO.selectMeetingRoomListHeadSearch", bcVO);
	}

	public int selectMeetingRoomListTotCntHeadSearch(MeetingRoomVO bcVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MeetingRoomDAO.selectMeetingRoomListTotCntHeadSearch", bcVO);
	}

	public List<Integer> selectInterestUserNoList(MeetingRoomRecieve meetingRoomRecieve) {
		return list("MeetingRoomDAO.selectInterestUserNoList", meetingRoomRecieve);
	}

	public void setInterestBc(Map<String,Object> param) {
		update("MeetingRoomDAO.setInterestBc", param);
	}
	
	/* [2015/02/26, dwkim] 모든 회의실 목록보기, 임시로 추가(김태연 부장님, 박현준과장님) */
	public List<MeetingRoomVO> tmpSelectMeetingRoomList(MeetingRoomVO meetingRoomVO) {
		return list("MeetingRoomDAO.tmpSelectMeetingRoomList", meetingRoomVO);
	}
	
	public int tmpSelectMeetingRoomListTotCnt(MeetingRoomVO meetingRoomVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MeetingRoomDAO.tmpSelectMeetingRoomListTotCnt", meetingRoomVO);
	}
	/* [2015/02/26, dwkim] 모든 회의실 목록보기, 임시로 추가(김태연 부장님, 박현준과장님) 끝 */
}
