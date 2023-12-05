package kms.com.cooperation.service;

import java.io.Serializable;

/**
 * @Class Name : TblPrjInputVO.java
 * @Description : TblPrjInput VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.10.11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ProjectInput implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** PRJ_ID */
    private java.lang.String prjId;
    
    /** USER_NO */
    private int userNo;
    private String userId;
    private int userNm;
    
    /** YEAR */
    private java.lang.String year;
    
    /** MONTH */
    private java.lang.String month;
    
    /** REG_DT */
    private java.util.Date regDt;
    
    /** WRITER_ID */
    private int writerId;
    private int writerNo;
    
    public java.lang.String getPrjId() {
        return this.prjId;
    }
    
    public void setPrjId(java.lang.String prjId) {
        this.prjId = prjId;
    }
    
    public int getUserNo() {
        return this.userNo;
    }
    
    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }
    
    public java.lang.String getYear() {
        return this.year;
    }
    
    public void setYear(java.lang.String year) {
        this.year = year;
    }
    
    public java.lang.String getMonth() {
        return this.month;
    }
    
    public void setMonth(java.lang.String month) {
        this.month = month;
    }
    
    public java.util.Date getRegDt() {
        return this.regDt;
    }
    
    public void setRegDt(java.util.Date regDt) {
        this.regDt = regDt;
    }
    
    public int getWriterId() {
        return this.writerId;
    }
    
    public void setWriterId(int writerId) {
        this.writerId = writerId;
    }

	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
	}

	public int getWriterNo() {
		return writerNo;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserNm(int userNm) {
		this.userNm = userNm;
	}

	public int getUserNm() {
		return userNm;
	}
	
	
    
}
