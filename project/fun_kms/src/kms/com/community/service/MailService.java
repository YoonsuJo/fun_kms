package kms.com.community.service;

import java.util.List;
import kms.com.community.service.MailVO;
import kms.com.community.service.Mail;

/**
 * @Class Name : TblMailsendService.java
 * @Description : TblMailsend Business class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MailService {
	

    /**
     * MAIL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 Mail
	 * @return 등록 결과
	 * @exception Exception
     */
	String sendMail(Mail vo) throws Exception;
	
	String sendMailOut(Mail vo) throws Exception;	
	String insertMailOut(Mail vo) throws Exception;
	String setMailOut(Mail vo) throws Exception;
	List<MailVO> selectMailOutList(MailVO searchVO) throws Exception;
	List<String> selectSMTPMailList(MailVO searchVO) throws Exception;
	
    /**
	 * 보낸 Mail 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return TBL_MAILSEND 목록
	 * @exception Exception
	 */
    List<MailVO> selectSendMailList(MailVO searchVO) throws Exception;
    
    /**
	 * 보낸 Mail 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return TBL_MAILSEND 총 갯수
	 * @exception
	 */
    int selectSendMailListTotCnt(MailVO searchVO) throws Exception;
    
    /**
     * 받은 Mail 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 VO
     * @return TBL_MAILSEND 목록
     * @exception Exception
     */
    List<MailVO> selectRecieveMailList(MailVO searchVO) throws Exception;
    
    /**
     * 받은 Mail 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 VO
     * @return TBL_MAILSEND 총 갯수
     * @exception
     */
    int selectRecieveMailListTotCnt(MailVO searchVO) throws Exception;
    
    /**
	 * TBL_MAILSEND을 조회한다.
	 * @param vo - 조회할 정보가 담긴 TblMailsendVO
	 * @return 조회한 TBL_MAILSEND
	 * @exception Exception
	 */
	List<MailVO> readMail(MailVO vo) throws Exception;
    
	void resendMail(MailVO mailVO) throws Exception;
	
	void deleteSendMail(MailVO vo) throws Exception;	
    void deleteRecieveMail(MailVO vo) throws Exception;
    void cancelSendMail(MailVO vo) throws Exception;

	List<MailVO> selectSendMailState(MailVO searchVO) throws Exception;
	int selectSendMailStateTotCnt(MailVO searchVO) throws Exception;
	
	public int sendMailSMTPOut(MailVO mailVO) throws Exception;
	
    
    

}
