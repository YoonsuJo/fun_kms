package kms.com.app.service;

import java.io.Serializable;

/**
 * @Class Name : TblEappExpDefaultVO.java
 * @Description : TblEappExp Default VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.10.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ApprovalExpenseVO implements Serializable {
    
	private String docId;
	private int templtId;//10, 11, 12
	
    /** EXP_ID*/
    private String expId;
    
    /** PRESET_ID */
    private String presetId;
    
    private int expSpendTyp;
    
    /** ACC_ID */
    private String accId;
    
    /** PRJ_ID */
    private String prjId;
    private String prjNm;
    
    /** COMPANY_CD */
    private String companyCd;
    private String companyNm;
    
    /** EXP_DT */
    private String expDt;
    
    /** EXP_SPEND */
    private int expSpend;
    
    /** EXP_CT */
    private String expCt;
    
    /** PAYING_DUE_DATE */
    private String payingDueDate;
    
    /** CARD_SPEND_NO */
    private int cardSpendNo;
    
    private String expenseArrayJ;
    
    private int writerNo = 0;   
    
    private int save = 0;
    
    public String getPresetId() {
        return this.presetId;
    }
    
    public void setPresetId(String presetId) {
        this.presetId = presetId;
    }
  
    
    public String getAccId() {
        return this.accId;
    }
    
    public void setAccId(String accId) {
        this.accId = accId;
    }
    
    public String getPrjId() {
        return this.prjId;
    }
    
    public void setPrjId(String prjId) {
        this.prjId = prjId;
    }
    
    public String getCompanyCd() {
        return this.companyCd;
    }
    
    public void setCompanyCd(String companyCd) {
        this.companyCd = companyCd;
    }
    
    public String getExpDt() {
        return this.expDt;
    }
    
    public void setExpDt(String expDt) {
        this.expDt = expDt;
    }
    
    public int getExpSpend() {
        return this.expSpend;
    }
    
    public void setExpSpend(int expSpend) {
        this.expSpend = expSpend;
    }
    
    public String getExpCt() {
        return this.expCt;
    }
    
    public void setExpCt(String expCt) {
        this.expCt = expCt;
    }
    
    public String getPayingDueDate() {
        return this.payingDueDate;
    }
    
    public void setPayingDueDate(String payingDueDate) {
        this.payingDueDate = payingDueDate;
    }
    
    public int getCardSpendNo() {
        return this.cardSpendNo;
    }
    
    public void setCardSpendNo(int cardSpendNo) {
        this.cardSpendNo = cardSpendNo;
    }

	public void setDocId(String docId) {
		this.docId = docId;
	}

	public String getDocId() {
		return docId;
	}

	public void setExpenseArrayJ(String expenseArrayJ) {
		this.expenseArrayJ = expenseArrayJ;
	}

	public String getExpenseArrayJ() {
		return expenseArrayJ;
	}

	public void setExpSpendTyp(int expSpendTyp) {
		this.expSpendTyp = expSpendTyp;
	}

	public int getExpSpendTyp() {
		return expSpendTyp;
	}

	public void setTempltId(int templtId) {
		this.templtId = templtId;
	}

	public int getTempltId() {
		return templtId;
	}

	public void setExpId(String expId) {
		this.expId = expId;
	}

	public String getExpId() {
		return expId;
	}

	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}

	public String getCompanyNm() {
		return companyNm;
	}

	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}

	public String getPrjNm() {
		return prjNm;
	}

	public int getWriterNo() {
		return writerNo;
	}

	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
	}

	public int getSave() {
		return save;
	}

	public void setSave(int save) {
		this.save = save;
	}
}
