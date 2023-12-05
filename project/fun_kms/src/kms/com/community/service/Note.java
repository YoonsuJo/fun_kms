package kms.com.community.service;

/**
 * @Class Name : TblNotesendVO.java
 * @Description : TblNotesend VO class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class Note{
    private static final long serialVersionUID = 1L;
    
    /** NO */
    private String noteId;
    
    /** SENDER_NO */
    private int senderNo;
    
    /** MAIL_CN */
    private String noteCn;
    
    /** SEND_DT */
    private String sendDt;
    
    /** ATCH_FILE_ID */
    private String atchFileId;
    
    /** DELETE_YN */
    private String deleteYn;
    
    private String recieverList;
    private String[] recieverIdList;
    
    private String senderId;
    private String senderNm;
    private String readDt;

    private String recieverId;
    private String recieverNm;
    private String recieverNo;
    private int recieverCount;
    
    private String currentUserOnly = "";
    private String mobilePush = "";
    
    private String recieveMode = "";
    
    
    public String getNoteId() {
        return this.noteId;
    }
    
    public void setNoteId(String noteId) {
        this.noteId = noteId;
    }
    
    public int getSenderNo() {
        return this.senderNo;
    }
    
    public void setSenderNo(int senderNo) {
        this.senderNo = senderNo;
    }
    
    public String getNoteCn() {
        return this.noteCn;
    }
    public String getNoteCnShort() {
    	if(noteCn != null && noteCn.length() > 50)
    		return this.noteCn.substring(0, 50) + "...";
    	else
    		return this.noteCn;
    }
    
    public void setNoteCn(String noteCn) {
        this.noteCn = noteCn;
    }
    
    public String getSendDt() {
        return this.sendDt;
    }
    
    public void setSendDt(String sendDt) {
        this.sendDt = sendDt;
    }
    
    public String getAtchFileId() {
        return this.atchFileId;
    }
    
    public void setAtchFileId(String atchFileId) {
        this.atchFileId = atchFileId;
    }
    
    public String getDeleteYn() {
    	return this.deleteYn;
    }
    
    public void setDeleteYn(String deleteYn) {
    	this.deleteYn = deleteYn;
    }
    
    public String getRecieverList() {
    	return this.recieverList;
    }
    
    public void setRecieverList(String recieverList) {
    	this.recieverList = recieverList;
    }
    
    public String[] getRecieverIdList() {
    	return this.recieverIdList;
    }
    
    public void setRecieverIdList(String[] recieverIdList) {
    	this.recieverIdList = recieverIdList;
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
	 * @return the recieverNm
	 */
	public String getRecieverNo() {
		return recieverNo;
	}
	
	/**
	 * @param recieverNm the recieverNm to set
	 */
	public void setRecieverNo(String recieverNo) {
		this.recieverNo = recieverNo;
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

	public String getCurrentUserOnly() {
		return currentUserOnly;
	}

	public void setCurrentUserOnly(String currentUserOnly) {
		this.currentUserOnly = currentUserOnly;
	}

	public String getRecieveMode() {
		return recieveMode;
	}

	public void setRecieveMode(String recieveMode) {
		this.recieveMode = recieveMode;
	}

	public void setMobilePush(String mobilePush) {
		this.mobilePush = mobilePush;
	}

	public String getMobilePush() {
		return mobilePush;
	}

    
}
