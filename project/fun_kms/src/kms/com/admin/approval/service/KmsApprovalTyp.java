package kms.com.admin.approval.service;

import java.io.Serializable;

/**
 * @Class Name : KmsEappDoctypVO.java
 * @Description : KmsEappDoctyp VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class KmsApprovalTyp implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** 회사구분 */
    private String companyId;
    private String companyNm;
    
    /** TEMPLT_ID */
    private Integer templtId;
    private String templtNm;
    
    /** DOC_ORD */
    private int docOrd = 0;
    
    /** KOR_TYPE */
    private String docSj;
    
    /** ENG_TYPE */
    private String decideLineDesc;
    
    /** DOC_CT */
    private String docCt;
    
    /** DOC_ICON */
    private String docIcon ="";
    
    /** READER_AUTO_CMT */
    private String readerAutoCmt;
    
    /** COOP_MIXS */
    private String coopMixs;
    
    /** REFER_MIXS */
    private String referMixs;
    
    /** HANDLER_MIXS */
    private String handlerMixs;
    
    /** DECIDER_RULE1 */
    private int deciderRule1 =1;
    
    /** DICIDER_RULE2 */
    private int deciderRule2 =1;
    
    /** DICIDER_RULE3 */
    private int deciderRule3 = 1;
    /** DICIDER_RULE4 */
    private String deciderRule4 ;
    
    /** DICIDER_RULE4 */
    private int deciderRule5 =1;
    private int useYn = 1;
    
    /** DECIDER_MIX */
    private String deciderMix;
    
    public Integer getTempltId() {
        return this.templtId;
    }
    
    public void setTempltId(Integer templtId) {
        this.templtId = templtId;
    }
    
    public int getDocOrd() {
        return this.docOrd;
    }
    
    public void setDocOrd(int docOrd) {
        this.docOrd = docOrd;
    }
    
    
    
    public String getDocCt() {
        return this.docCt;
    }
    
    public void setDocCt(String docCt) {
        this.docCt = docCt;
    }
    
    public String getDocIcon() {
        return this.docIcon;
    }
    
    public void setDocIcon(String docIcon) {
        this.docIcon = docIcon;
    }
    
    public String getReaderAutoCmt() {
        return this.readerAutoCmt;
    }
    
    public void setReaderAutoCmt(String readerAutoCmt) {
        this.readerAutoCmt = readerAutoCmt;
    }
    
    public String getCoopMixs() {
        return this.coopMixs;
    }
    
    public void setCoopMixs(String coopMixs) {
        this.coopMixs = coopMixs;
    }
    
    public String getReferMixs() {
        return this.referMixs;
    }
    
    public void setReferMixs(String referMixs) {
        this.referMixs = referMixs;
    }
    
    public String getHandlerMixs() {
        return this.handlerMixs;
    }
    
    public void setHandlerMixs(String handlerMixs) {
        this.handlerMixs = handlerMixs;
    }
    
    public int getDeciderRule1() {
        return this.deciderRule1;
    }
    
    public void setDeciderRule1(int deciderRule1) {
        this.deciderRule1 = deciderRule1;
    }
    
   
	public void setUseYn(int useYn) {
		this.useYn = useYn;
	}

	public int getUseYn() {
		return useYn;
	}

	public void setDocSj(String docSj) {
		this.docSj = docSj;
	}

	public String getDocSj() {
		return docSj;
	}

	public void setDecideLineDesc(String decideLineDesc) {
		this.decideLineDesc = decideLineDesc;
	}

	public String getDecideLineDesc() {
		return decideLineDesc;
	}

	public int getDeciderRule2() {
		return deciderRule2;
	}

	public void setDeciderRule2(int deciderRule2) {
		this.deciderRule2 = deciderRule2;
	}

	public int getDeciderRule3() {
		return deciderRule3;
	}

	public void setDeciderRule3(int deciderRule3) {
		this.deciderRule3 = deciderRule3;
	}

	public String getDeciderRule4() {
		return deciderRule4;
	}

	public void setDeciderRule4(String deciderRule4) {
		this.deciderRule4 = deciderRule4;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public void setDeciderRule5(int deciderRule5) {
		this.deciderRule5 = deciderRule5;
	}

	public int getDeciderRule5() {
		return deciderRule5;
	}

	public void setTempltNm(String templtNm) {
		this.templtNm = templtNm;
	}

	public String getTempltNm() {
		return templtNm;
	}

	/**
	 * @param companyId the companyId to set
	 */
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	/**
	 * @return the companyId
	 */
	public String getCompanyId() {
		return companyId;
	}

	/**
	 * @param companyNm the companyNm to set
	 */
	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}

	/**
	 * @return the companyNm
	 */
	public String getCompanyNm() {
		return companyNm;
	}

	public String getDeciderMix() {
		return deciderMix;
	}

	public void setDeciderMix(String deciderMix) {
		this.deciderMix = deciderMix;
	}
    
}
