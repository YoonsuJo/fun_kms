package kms.com.app.service;

import kms.com.common.utils.CommonUtil;

import java.io.Serializable;

/**
 * @Class Name : TblEappHolVO.java
 * @Description : TblEappHol VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.10.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 *  templtId = 5
 */
public class ApprovalHolVO implements Serializable{
    private static final long serialVersionUID = 1L;
    
    private String docId;
    /** HOL_NO */
    private int holNo;
    private int userNo;
    private String userId;
    private String userNm;
    
    /** PRJ_ID */
    private String prjId;
    private String prjNm;
    private String prjCd;
    
    /** PERIOD */
    private double period =1.0;
    
    /** ST_DT */
    private String stDt;
    
    /** ST_TM */
    private String stTm;
    
    /** ED_DT */
    private String edDt;
    
    /** ED_TM */
    private String edTm;
    
    private String cost;
    
    private String exceedManage = "N";
    
    public int getHolNo() {
        return this.holNo;
    }
    
    public void setHolNo(int holNo) {
        this.holNo = holNo;
    }
    
    public String getPrjId() {
        return this.prjId;
    }
    
    public void setPrjId(String prjId) {
        this.prjId = prjId;
    }
    
    public double getPeriod() {
        return this.period;
    }
    
    public void setPeriod(double period) {
        this.period = period;
    }
    
    public String getStDt() {
        return this.stDt;
    }
    
    public String getStDtPrint() {
        return CommonUtil.getDateType(this.stDt);
    }
    
    public void setStDt(String stDt) {
        this.stDt = stDt;
    }
    
    public String getStTm() {
        return this.stTm;
    }
    
    public void setStTm(String stTm) {
        this.stTm = stTm;
    }
    
    public String getEdDt() {
        return this.edDt;
    }
    
    public String getEdDtPrint() {
        return CommonUtil.getDateType(this.stDt);
    }
    
    public void setEdDt(String edDt) {
        this.edDt = edDt;
    }
    
    public String getEdTm() {
        return this.edTm;
    }
    
    public void setEdTm(String edTm) {
        this.edTm = edTm;
    }

	public void setDocId(String docId) {
		this.docId = docId;
	}

	public String getDocId() {
		return docId;
	}

	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}

	public String getPrjNm() {
		return prjNm;
	}

	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}

	public String getPrjCd() {
		return prjCd;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getUserNo() {
		return userNo;
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

	/**
	 * @return the cost
	 */
	public String getCost() {
		return cost;
	}

	/**
	 * @param cost the cost to set
	 */
	public void setCost(String cost) {
		this.cost = cost;
	}

	/**
	 * @return the exceedManage
	 */
	public String getExceedManage() {
		return exceedManage;
	}

	/**
	 * @param exceedManage the exceedManage to set
	 */
	public void setExceedManage(String exceedManage) {
		this.exceedManage = exceedManage;
	}

	
	
	
    
}
