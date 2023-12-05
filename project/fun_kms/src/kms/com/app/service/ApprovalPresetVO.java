package kms.com.app.service;

import java.io.Serializable;

/**
 * @Class Name : TblEappPresetVO.java
 * @Description : TblEappPreset VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.10.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ApprovalPresetVO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    /** PRESET_ID */
    private String presetId;
    
    /** PRESET_NM */
    private String presetNm;
    
    private String presetTyp;
    
    /** PRJ_ID */
    private String prjId;
    private String prjNm;
    private String prjFnm;
    
    /** ACC_ID */
    private String accId;
    private String accNm;
    
    /** WRITER_NO */
    private int writerNo;
    
    /** REG_DT */
    private java.util.Date regDt;
    
    /** USE_AT */
    private String useAt;
    
    public String getPresetId() {
        return this.presetId;
    }
    
    public void setPresetId(String presetId) {
        this.presetId = presetId;
    }
    
    public String getPresetNm() {
        return this.presetNm;
    }
    
    public void setPresetNm(String presetNm) {
        this.presetNm = presetNm;
    }
    
    public String getPrjId() {
        return this.prjId;
    }
    
    public void setPrjId(String prjId) {
        this.prjId = prjId;
    }
    
    public String getAccId() {
        return this.accId;
    }
    
    public void setAccId(String accId) {
        this.accId = accId;
    }
    
    public int getWriterNo() {
        return this.writerNo;
    }
    
    public void setWriterNo(int writerNo) {
        this.writerNo = writerNo;
    }
    
    public java.util.Date getRegDt() {
        return this.regDt;
    }
    
    public void setRegDt(java.util.Date regDt) {
        this.regDt = regDt;
    }
    
    public String getUseAt() {
        return this.useAt;
    }
    
    public void setUseAt(String useAt) {
        this.useAt = useAt;
    }

	public void setPresetTyp(String presetTyp) {
		this.presetTyp = presetTyp;
	}

	public String getPresetTyp() {
		return presetTyp;
	}

	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}

	public String getPrjNm() {
		return prjNm;
	}

	public void setPrjFnm(String prjFnm) {
		this.prjFnm = prjFnm;
	}

	public String getPrjFnm() {
		return prjFnm;
	}

	public void setAccNm(String accNm) {
		this.accNm = accNm;
	}

	public String getAccNm() {
		return accNm;
	}
    
}
