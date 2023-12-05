package kms.com.community.service;

import java.util.List;
import java.util.Map;

import kms.com.common.push.PushVO;
import kms.com.community.service.NoteVO;
import kms.com.community.service.Note;
import kms.com.member.service.MemberVO;

/**
 * @Class Name : TblNotesendService.java
 * @Description : TblNotesend Business class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface NoteService {
	

    /**
     * MAIL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 Note
	 * @return 등록 결과
	 * @exception Exception
     */
    String sendNote(Note vo) throws Exception;
    
    String sendNoteMobile(Note vo) throws Exception;
    
	void sendNote(int userNo, String[] reciverIdList, String noteCn) throws Exception;

    /**
	 * 보낸 Note 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return TBL_MAILSEND 목록
	 * @exception Exception
	 */
    List<NoteVO> selectSendNoteList(NoteVO searchVO) throws Exception;
    
    /**
	 * 보낸 Note 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return TBL_MAILSEND 총 갯수
	 * @exception
	 */
    int selectSendNoteListTotCnt(NoteVO searchVO) throws Exception;
    
    /**
     * 받은 Note 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 VO
     * @return TBL_MAILSEND 목록
     * @exception Exception
     */
    List<NoteVO> selectRecieveNoteList(NoteVO searchVO) throws Exception;
    
    /**
     * 받은 Note 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 VO
     * @return TBL_MAILSEND 총 갯수
     * @exception
     */
    int selectRecieveNoteListTotCnt(NoteVO searchVO) throws Exception;
    
    /**
	 * TBL_MAILSEND을 조회한다.
	 * @param vo - 조회할 정보가 담긴 TblNotesendVO
	 * @return 조회한 TBL_MAILSEND
	 * @exception Exception
	 */
    List<NoteVO> selectNote(NoteVO vo) throws Exception;
    
    void setReadDt(NoteVO vo) throws Exception;
    
    void deleteSendNote(NoteVO vo) throws Exception;
    void deleteRecieveNote(NoteVO vo) throws Exception;

    void resendNote(NoteVO vo) throws Exception;

	List<String> getNoteIdList(MemberVO user) throws Exception;

    String tokenInfo(String userNo) throws Exception;
    String phoneNo(String userNo) throws Exception;
    String deviceType(String userNo) throws Exception;
    String userNm(String userNo) throws Exception;
    
    List selectFailPushLogList() throws Exception;
    void insertPushLog(Map<String, Object> param) throws Exception;
    void insertPushLog(String type, PushVO pushVO) throws Exception;
    void updateTmPushLog(Map<String, Object> param) throws Exception;
    void updateSuccessPushLog(Map<String, Object> param) throws Exception;
}
