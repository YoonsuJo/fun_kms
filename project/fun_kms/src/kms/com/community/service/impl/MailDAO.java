package kms.com.community.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.community.service.Mail;
import kms.com.community.service.MailVO;
import kms.com.member.service.MemberVO;

/**
 * @Class Name : TblMailsendDAO.java
 * @Description : TblMailsend DAO Class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("KmsMailDAO")
public class MailDAO extends EgovAbstractDAO {
	
	/**
	 * TBL_MAILSEND을 등록한다.
	 * @param vo - 등록할 정보가 담긴 TblMailsendVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertMailsend(Mail vo) throws Exception {
        return (String)insert("mailDAO.insertMailsend", vo);
    }
  
    public void insertMailOut(Mail vo) throws Exception {
        insert("mailDAO.insertMailOut", vo);
    }
    public void setMailOut(Mail vo) throws Exception {
        update("mailDAO.setMailOut", vo);
    }
    public List<MailVO> selectMailOutList(MailVO searchVO) throws Exception {
    	return list("mailDAO.selectMailOutList", searchVO);
    }
    public List<String> selectSMTPMailList(MailVO searchVO) throws Exception {
    	return list("mailDAO.selectSMTPMailList", searchVO);
    }
    
    /**
     * TBL_MAILRECIEVE를 등록한다.
     * @param vo - 등록할 정보가 담긴 TblMailsendVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertMailrecieve(Mail vo) throws Exception {
    	return (String)insert("mailDAO.insertMailrecieve", vo);
    }
      
    public List<MailVO> selectRecieveMailList(MailVO searchVO) throws Exception {
    	return list("mailDAO.selectRecieveMailList", searchVO);
    }
    public List<MailVO> selectSendMailList(MailVO searchVO) throws Exception {
    	return list("mailDAO.selectSendMailList", searchVO);
    }
    
    public int selectRecieveMailListTotCnt(MailVO searchVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("mailDAO.selectRecieveMailListTotCnt", searchVO);
    }
    public int selectSendMailListTotCnt(MailVO searchVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("mailDAO.selectSendMailListTotCnt", searchVO);
    }

    
    public List<MailVO> selectMail(MailVO vo) throws Exception {
        return list("mailDAO.selectMail", vo);
    }
    public void setReadDt(MailVO vo) throws Exception {
        update("mailDAO.setReadDt", vo);
    }
 
    public void insertMailsendR(Mail vo) throws Exception {
        insert("mailDAO.insertMailsendR", vo);
    }
    public void insertMailrecieveR(Mail vo) throws Exception {
    	insert("mailDAO.insertMailrecieveR", vo);
    }

	public void deleteRecieveMail(MailVO vo) {
		update("mailDAO.deleteRecieveMail", vo);
	}

	public void deleteSendMail(MailVO vo) {
		update("mailDAO.deleteSendMail", vo);
	}
	
	public void cancelSendMail(MailVO vo) {
		update("mailDAO.cancelSendMail", vo);
	}

	public List<MailVO> selectSendMailState(MailVO searchVO) {
		return list("mailDAO.selectSendMailState", searchVO);
	}

	public int selectSendMailStateTotCnt(MailVO searchVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("mailDAO.selectSendMailStateTotCnt", searchVO);
	}

	public List<MailVO> getNewMailList(MemberVO user) {
		return list("mailDAO.selectNewMailList", user);
	}

    
}
