package kms.com.support.service;

import java.io.Serializable;

import kms.com.common.utils.CalendarUtil;

/**
 * @Class Name : TblCardVO.java
 * @Description : TblCard VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.11.15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class Card implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** CARD_ID */
    private String cardId;
    private String beforeCardId;
    
    /** EXPIRY_DT */
    private int expiryYear = CalendarUtil.getYear();
    private int expiryMonth =CalendarUtil.getMonth();
    
    /** COMPANY_ID */
    private String companyCd;
    private String companyNm;
    
    /** LIMIT_SPEND */
    private int limitSpend;
    
    /** STAT */
    private String stat;
    private String statNm;
    
    /** CARD_CT */
    private String cardCt;
    
    /** USER_NO */
    private Integer userNo;
    private String userId;
    private String userNm;
    private String userMix;
    
    private String note;
    public String getCardId() {
        return this.cardId;
    }
    
    public void setCardId(String cardId) {
        this.cardId = cardId;
    }
 
    public String getBeforeCardId() {
		return beforeCardId;
	}

	public void setBeforeCardId(String beforeCardId) {
		this.beforeCardId = beforeCardId;
	}

	public String getCompanyCd() {
        return this.companyCd;
    }
    
    public void setCompanyCd(String companyCd) {
        this.companyCd = companyCd;
    }
    
    public int getLimitSpend() {
        return this.limitSpend;
    }
    
    public void setLimitSpend(int limitSpend) {
        this.limitSpend = limitSpend;
    }
    
    public String getStat() {
        return this.stat;
    }
    
    public void setStat(String stat) {
        this.stat = stat;
    }
    
    public String getCardCt() {
        return this.cardCt;
    }
    
    public void setCardCt(String cardCt) {
        this.cardCt = cardCt;
    }
    
    public Integer getUserNo() {
        return this.userNo;
    }
    
    public void setUserNo(Integer userNo) {
        this.userNo = userNo;
    }

	public void setExpiryMonth(int expiryMonth) {
		this.expiryMonth = expiryMonth;
	}

	public int getExpiryMonth() {
		return expiryMonth;
	}

	public void setExpiryYear(int expiryYear) {
		this.expiryYear = expiryYear;
	}

	public int getExpiryYear() {
		return expiryYear;
	}

	public void setStatNm(String statNm) {
		this.statNm = statNm;
	}

	public String getStatNm() {
		return statNm;
	}

	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}

	public String getCompanyNm() {
		return companyNm;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserMix(String userMix) {
		this.userMix = userMix;
	}

	public String getUserMix() {
		return userMix;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getNote() {
		return note;
	}
    
}
