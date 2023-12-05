package kms.com.app.service;

import java.io.Serializable;


/**
 * @Class Name : TblAccountVO.java
 * @Description : TblAccount VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.10.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class Account implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** ACC_ID */
    private String accId;
    
    /** ACC_NM */
    private String accNm;
    
    /** ACC_LV */
    private int accLv;
    
    /** PRNT_ACC_ID */
    private String prntAccId;
    private String prntAccNm;
    
    /** ACC_CT */
    private String accCt;
    private int accOrd;
    
    /** USE_AT */
    private String useAt="Y";
    
    private String prntTyp ="E";
    private String prntTypNm ="업무경비";
    private String childTyp;
    private String childTypNm;
    private String searchChildTyp;
    public String getAccId() {
        return this.accId;
    }
    
    public void setAccId(String accId) {
        this.accId = accId;
    }
    
    public String getAccNm() {
        return this.accNm;
    }
    
    public void setAccNm(String accNm) {
        this.accNm = accNm;
    }
    
    public int getAccLv() {
        return this.accLv;
    }
    
    public void setAccLv(int accLv) {
        this.accLv = accLv;
    }
    
    public String getPrntAccId() {
        return this.prntAccId;
    }
    
    public void setPrntAccId(String prntAccId) {
        this.prntAccId = prntAccId;
    }
    
    public String getAccCt() {
        return this.accCt;
    }
    
    public void setAccCt(String accCt) {
        this.accCt = accCt;
    }
    
    public String getUseAt() {
        return this.useAt;
    }
    
    public void setUseAt(String useAt) {
        this.useAt = useAt;
    }

	public void setPrntAccNm(String prntAccNm) {
		this.prntAccNm = prntAccNm;
	}

	public String getPrntAccNm() {
		return prntAccNm;
	}

	public void setAccOrd(int accOrd) {
		this.accOrd = accOrd;
	}

	public int getAccOrd() {
		return accOrd;
	}

	public void setPrntTyp(String prntTyp) {
		this.prntTyp = prntTyp;
	}

	public String getPrntTyp() {
		return prntTyp;
	}

	public void setChildTyp(String childTyp) {
		this.childTyp = childTyp;
	}

	public String getChildTyp() {
		return childTyp;
	}

	public void setPrntTypNm(String prntTypNm) {
		this.prntTypNm = prntTypNm;
	}

	public String getPrntTypNm() {
		return prntTypNm;
	}

	public void setChildTypNm(String childTypNm) {
		this.childTypNm = childTypNm;
	}

	public String getChildTypNm() {
		return childTypNm;
	}

	public void setSearchChildTyp(String searchChildTyp) {
		this.searchChildTyp = searchChildTyp;
	}

	public String getSearchChildTyp() {
		return searchChildTyp;
	}
    
}
