package kms.com.community.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import kms.com.common.push.PushVO;
import kms.com.community.service.NoteService;
import kms.com.community.service.NoteVO;
import kms.com.community.service.Note;
import kms.com.community.service.impl.NoteDAO;
import kms.com.member.service.MemberVO;

/**
 * @Class Name : TblNotesendServiceImpl.java
 * @Description : TblNotesend Business Implement class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("KmsNoteService")
public class NoteServiceImpl extends AbstractServiceImpl implements
        NoteService {

    @Resource(name="KmsNoteDAO")
    private NoteDAO noteDAO;
    
    /** ID Generation */
    @Resource(name="kmsNoteIdGnrService")    
    private EgovIdGnrService idGnrService;

    

	@Override
	public String sendNote(Note vo) throws Exception {
		String noteId = idGnrService.getNextStringId();
		
		vo.setNoteId(noteId);
    	
    	noteDAO.insertNotesend(vo);
    	noteDAO.insertNoterecieve(vo);
		return noteId;
	}

	@Override
	public void sendNote(int userNo, String[] reciverIdList, String noteCn) throws Exception {
		Note note = new Note();
		String no = idGnrService.getNextStringId();
		
		note.setNoteId(no);
		
		note.setSenderNo(userNo);
		note.setRecieverIdList(reciverIdList);
		note.setNoteCn(noteCn);
    	
    	noteDAO.insertNotesend(note);
    	noteDAO.insertNoterecieve(note);
	}
	
	@Override
	public String sendNoteMobile(Note vo) throws Exception {
		String noteId = idGnrService.getNextStringId();
		
		vo.setNoteId(noteId);
    	
    	noteDAO.insertNotesend(vo);
    	noteDAO.insertNoterecieveMobile(vo);
		return noteId;
	}
	

	@Override
	public List<NoteVO> selectRecieveNoteList(NoteVO searchVO) throws Exception {
		return noteDAO.selectRecieveNoteList(searchVO);
	}


	@Override
	public int selectRecieveNoteListTotCnt(NoteVO searchVO) throws Exception {
		return noteDAO.selectRecieveNoteListTotCnt(searchVO);
	}


	@Override
	public List<NoteVO> selectSendNoteList(NoteVO searchVO) throws Exception {
		return noteDAO.selectSendNoteList(searchVO);
	}


	@Override
	public int selectSendNoteListTotCnt(NoteVO searchVO) throws Exception {
		return noteDAO.selectSendNoteListTotCnt(searchVO);
	}
	
    /**
	 * TBL_MAILSEND을 조회한다.
	 * @param vo - 조회할 정보가 담긴 TblNotesendVO
	 * @return 조회한 TBL_MAILSEND
	 * @exception Exception
	 */
	@Override
    public List<NoteVO> selectNote(NoteVO vo) throws Exception {
		return noteDAO.selectNote(vo);
	}
	
	@Override
	public void setReadDt(NoteVO vo) throws Exception {
        if (vo.getReadDt() == null || "".equals(vo.getReadDt())) {
			noteDAO.setReadDt(vo);
		}
	}
	
	@Override
	public void deleteSendNote(NoteVO vo) throws Exception {
		String noteIds = vo.getNoteId();
		vo.setNoteIdList(noteIds.split(","));
		
		noteDAO.deleteSendNote(vo);
	}
	
	@Override
    public void deleteRecieveNote(NoteVO vo) throws Exception {
		String noteIds = vo.getNoteId();
		vo.setNoteIdList(noteIds.split(","));
		
		noteDAO.deleteRecieveNote(vo);
	}

	@Override
	public void resendNote(NoteVO noteVO) throws Exception {
		Note vo = noteDAO.getResendNote(noteVO);
		
		String mailId = idGnrService.getNextStringId();
		vo.setNoteId(mailId);
		
		String[] tmp = {noteVO.getRecieverId()};
    	vo.setRecieverIdList(tmp);
    	
    	noteDAO.insertNotesend(vo);
    	noteDAO.insertNoterecieve(vo);
	}

	@Override
	public List<String> getNoteIdList(MemberVO user) throws Exception {
		return noteDAO.getNoteIdList(user);
	}

	@Override
	public String tokenInfo(String userId) throws Exception {
		String token = noteDAO.getTokenInfo(userId);
		return token;
	}
	
	@Override
	public String phoneNo(String userId) throws Exception {
		String token = noteDAO.getPhoneNo(userId);
		return token;
	}

	@Override
	public String deviceType(String userId) throws Exception {
		String deviceType = noteDAO.getDeviceType(userId);
		return deviceType;
	}

	@Override
	public String userNm(String userId) throws Exception {
		String userNm = noteDAO.getUserNm(userId);
		return userNm;
	}
	
	@Override
	public void insertPushLog(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		noteDAO.insertPushLog(param);
	}
	
	@Override
	public void insertPushLog(String type, PushVO pushVO) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("fromUserId", pushVO.getSenderVO().getUserId());
		param.put("toUserId", "");
		param.put("noteNo", "");
		param.put("message", pushVO.getMsg());
		param.put("pushKey", "");
		param.put("test", "");
		param.put("type", type);
		param.put("success", "Y");
		
		for (String rPhoneNo : pushVO.getrPhoneList()) {
			param.put("toUserPhoneNo", rPhoneNo);
			insertPushLog(param);
		}
	}

	@Override
	public List selectFailPushLogList() throws Exception {
		// TODO Auto-generated method stub
		return noteDAO.selectFailPushLogList();
	}

	@Override
	public void updateSuccessPushLog(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		noteDAO.updateSuccessPushLog(param);
	}

	@Override
	public void updateTmPushLog(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		noteDAO.updateTmPushLog(param);
	}
	
}
