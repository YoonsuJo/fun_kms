package kms.com.app.service;

import java.io.Serializable;


/**
 * @Class Name : TblEappOfficialVO.java
 * @Description : TblEappOfficial VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ApprovalOfficialVO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    /** DOC_ID */
    private String docId;
    
    /** OFFICIAL_ID */
    private String officialId;
    private String officialYear;
    private String officialNm;
    
    /** COMPANY_ID */
    private String companyId;
    private String companyNm;
    
    /** DESTN */
    private String destn;
    
    public String getDocId() {
        return this.docId;
    }
    
    public void setDocId(String docId) {
        this.docId = docId;
    }
    
    public String getOfficialId() {
        return this.officialId;
    }
    
    public void setOfficialId(String officialId) {
        this.officialId = officialId;
    }
    
    public String getCompanyId() {
        return this.companyId;
    }
    
    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }
    
    public String getDestn() {
        return this.destn;
    }
    
    public void setDestn(String destn) {
        this.destn = destn;
    }

	public void setOfficialYear(String officialYear) {
		this.officialYear = officialYear;
	}

	public String getOfficialYear() {
		return officialYear;
	}

	public void setOfficialNm(String officialNm) {
		this.officialNm = officialNm;
	}

	public String getOfficialNm() {
		return officialNm;
	}

	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}

	public String getCompanyNm() {
		return companyNm;
	}
    
}
