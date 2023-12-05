package kms.com.community.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.community.service.Note;
import kms.com.community.service.NoteVO;
import kms.com.member.service.MemberVO;

/**
 * @Class Name : TblNotesendDAO.java
 * @Description : TblNotesend DAO Class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("KmsNoteDAO")
public class NoteDAO extends EgovAbstractDAO {
	
	/**
	 * TBL_MAILSEND을 등록한다.
	 * @param vo - 등록할 정보가 담긴 TblNotesendVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertNotesend(Note vo) throws Exception {
        return (String)insert("noteDAO.insertNotesend", vo);
    }
    
    public String getTokenInfo(String userId) throws Exception {
        return (String)getSqlMapClientTemplate().queryForObject("noteDAO.getTokenInfo", userId);
    }
    
    public String getPhoneNo(String userId) throws Exception {
        return (String)getSqlMapClientTemplate().queryForObject("noteDAO.getPhoneNo", userId);
    }

    public String getDeviceType(String userId) throws Exception {
    	return (String)getSqlMapClientTemplate().queryForObject("noteDAO.getDeviceType", userId);
    }
    
    public String getUserNm(String userId) throws Exception {
    	return (String)getSqlMapClientTemplate().queryForObject("noteDAO.getUserNm", userId);
    }
    
    /**
     * TBL_MAILSEND을 등록한다.
     * @param vo - 등록할 정보가 담긴 TblNotesendVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertNoterecieve(Note vo) throws Exception {
    	return (String)insert("noteDAO.insertNoterecieve", vo);
    }
    
    public String insertNoterecieveMobile(Note vo) throws Exception {
    	return (String)insert("noteDAO.insertNoterecieveMobile", vo);
    }
    
    public List<NoteVO> selectRecieveNoteList(NoteVO searchVO) throws Exception {
    	return list("noteDAO.selectRecieveNoteList", searchVO);
    }
    public List<NoteVO> selectSendNoteList(NoteVO searchVO) throws Exception {
    	return list("noteDAO.selectSendNoteList", searchVO);
    }
    
    public int selectRecieveNoteListTotCnt(NoteVO searchVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("noteDAO.selectRecieveNoteListTotCnt", searchVO);
    }
    public int selectSendNoteListTotCnt(NoteVO searchVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("noteDAO.selectSendNoteListTotCnt", searchVO);
    }

    
    public List<NoteVO> selectNote(NoteVO vo) throws Exception {
        return list("noteDAO.selectNote", vo);
    }
    public void setReadDt(NoteVO vo) throws Exception {
        update("noteDAO.setReadDt", vo);
    }    
    
    public void deleteSendNote(NoteVO vo) throws Exception {
    	update("noteDAO.deleteSendNote", vo);
    }
    public void deleteRecieveNote(NoteVO vo) throws Exception {
    	update("noteDAO.deleteRecieveNote", vo);
    }    
    
    public Note getResendNote(NoteVO vo) throws Exception {
    	return (Note)selectByPk("noteDAO.getResendNote", vo);
    }

	public List<String> getNoteIdList(MemberVO user) {
		return list("noteDAO.getNoteIdList", user);
	}
	
	List selectFailPushLogList() throws Exception {
		return list("noteDAO.selectFailPushLogList", null);
	}
    
	void insertPushLog(Map<String, Object> param) throws Exception {
    	insert("noteDAO.insertPushLog", param);
    }
    
    void updateTmPushLog(Map<String, Object> param) throws Exception {
    	update("noteDAO.updateTmPushLog", param);
    }
    
    void updateSuccessPushLog(Map<String, Object> param) throws Exception {
    	update("noteDAO.updateSuccessPushLog", param);
    }
}
