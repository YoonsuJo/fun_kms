package kms.com.community.service;

/**
 * @Class Name : TblMailsendVO.java
 * @Description : TblMailsend VO class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class Mail{

	private String mailId;
    private String mailIdEx;

    private String senderId;
    private String senderNm;
    private int senderNo;
    
    private String mailSj;
    private String mailCn;
    
    private String mailSend;
    private String smsSend;
   
    //2013.08.20 김대현 PUSH 적용
    private String pushSend;
    
    
    private String atchFileId;

    private String sendDt;
    private String readDt;
    
    private String deleteYn;
    private String isSend;
    
    private String recieverList;
    private String[] recieverIdList;

    private String recieverId;
    private String recieverNm;
    private String recieverNo;

    private String recieverNoList;

    private int readCount = 0;
    private int recieverCount = 0;
    
    /** 외부 메일 전송용 속성 Reference ID, Out bound e-mail address **/
    private String refId = "";
    //SMTP email address
    private String emailAddr = "";
    //SMTP email send flag
    private String sendFlag = "";    
    

	/**
	 * @return the mailId
	 */
	public String getMailId() {
		return mailId;
	}

	/**
	 * @param mailId the mailId to set
	 */
	public void setMailId(String mailId) {
		this.mailId = mailId;
	}

	/**
	 * @return the mailIdEx
	 */
	public String getMailIdEx() {
		return mailIdEx;
	}

	/**
	 * @param mailIdEx the mailIdEx to set
	 */
	public void setMailIdEx(String mailIdEx) {
		this.mailIdEx = mailIdEx;
	}

	/**
	 * @return the senderId
	 */
	public String getSenderId() {
		return senderId;
	}

	/**
	 * @param senderId the senderId to set
	 */
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}

	/**
	 * @return the senderNm
	 */
	public String getSenderNm() {
		return senderNm;
	}

	/**
	 * @param senderNm the senderNm to set
	 */
	public void setSenderNm(String senderNm) {
		this.senderNm = senderNm;
	}

	/**
	 * @return the senderNo
	 */
	public int getSenderNo() {
		return senderNo;
	}

	/**
	 * @param senderNo the senderNo to set
	 */
	public void setSenderNo(int senderNo) {
		this.senderNo = senderNo;
	}

	/**
	 * @return the mailSj
	 */
	public String getMailSj() {
		return mailSj;
	}

	/**
	 * @param mailSj the mailSj to set
	 */
	public void setMailSj(String mailSj) {
		this.mailSj = mailSj;
	}

	/**
	 * @return the mailCn
	 */
	public String getMailCn() {
		return mailCn;
	}

	/**
	 * @param mailCn the mailCn to set
	 */
	public void setMailCn(String mailCn) {
		this.mailCn = mailCn;
	}

	/**
	 * @return the mailSend
	 */
	public String getMailSend() {
		return mailSend;
	}

	/**
	 * @param mailSend the mailSend to set
	 */
	public void setMailSend(String mailSend) {
		this.mailSend = mailSend;
	}

	/**
	 * @return the smsSend
	 */
	public String getSmsSend() {
		return smsSend;
	}

	/**
	 * @param smsSend the smsSend to set
	 */
	public void setSmsSend(String smsSend) {
		this.smsSend = smsSend;
	}

	/**
	 * @return the atchFileId
	 */
	public String getAtchFileId() {
		return atchFileId;
	}

	/**
	 * @param atchFileId the atchFileId to set
	 */
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	/**
	 * @return the sendDt
	 */
	public String getSendDt() {
		return sendDt;
	}

	/**
	 * @param sendDt the sendDt to set
	 */
	public void setSendDt(String sendDt) {
		this.sendDt = sendDt;
	}

	/**
	 * @return the readDt
	 */
	public String getReadDt() {
		return readDt;
	}

	/**
	 * @param readDt the readDt to set
	 */
	public void setReadDt(String readDt) {
		this.readDt = readDt;
	}

	/**
	 * @return the deleteYn
	 */
	public String getDeleteYn() {
		return deleteYn;
	}

	/**
	 * @param deleteYn the deleteYn to set
	 */
	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}

	/**
	 * @return the isSend
	 */
	public String getIsSend() {
		return isSend;
	}

	/**
	 * @param isSend the isSend to set
	 */
	public void setIsSend(String isSend) {
		this.isSend = isSend;
	}

	/**
	 * @return the recieverList
	 */
	public String getRecieverList() {
		return recieverList;
	}

	/**
	 * @param recieverList the recieverList to set
	 */
	public void setRecieverList(String recieverList) {
		this.recieverList = recieverList;
	}

	/**
	 * @return the recieverIdList
	 */
	public String[] getRecieverIdList() {
		return recieverIdList;
	}

	/**
	 * @param recieverIdList the recieverIdList to set
	 */
	public void setRecieverIdList(String[] recieverIdList) {
		this.recieverIdList = recieverIdList;
	}

	/**
	 * @return the recieverId
	 */
	public String getRecieverId() {
		return recieverId;
	}

	/**
	 * @param recieverId the recieverId to set
	 */
	public void setRecieverId(String recieverId) {
		this.recieverId = recieverId;
	}

	/**
	 * @return the recieverNm
	 */
	public String getRecieverNm() {
		return recieverNm;
	}

	/**
	 * @param recieverNm the recieverNm to set
	 */
	public void setRecieverNm(String recieverNm) {
		this.recieverNm = recieverNm;
	}

	/**
	 * @return the recieverNo
	 */
	public String getRecieverNo() {
		return recieverNo;
	}

	/**
	 * @param recieverNo the recieverNo to set
	 */
	public void setRecieverNo(String recieverNo) {
		this.recieverNo = recieverNo;
	}

	/**
	 * @return the recieverNoList
	 */
	public String getRecieverNoList() {
		return recieverNoList;
	}

	/**
	 * @param recieverNoList the recieverNoList to set
	 */
	public void setRecieverNoList(String recieverNoList) {
		this.recieverNoList = recieverNoList;
	}

	/**
	 * @return the readCount
	 */
	public int getReadCount() {
		return readCount;
	}

	/**
	 * @param readCount the readCount to set
	 */
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	/**
	 * @return the recieverCount
	 */
	public int getRecieverCount() {
		return recieverCount;
	}

	/**
	 * @param recieverCount the recieverCount to set
	 */
	public void setRecieverCount(int recieverCount) {
		this.recieverCount = recieverCount;
	}

	public void setRefId(String refId) {
		this.refId = refId;
	}

	public String getRefId() {
		return refId;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setSendFlag(String sendFlag) {
		this.sendFlag = sendFlag;
	}

	public String getSendFlag() {
		return sendFlag;
	}

	public void setPushSend(String pushSend) {
		this.pushSend = pushSend;
	}

	public String getPushSend() {
		return pushSend;
	}

}
