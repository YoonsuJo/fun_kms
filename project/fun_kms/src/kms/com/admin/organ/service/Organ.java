package kms.com.admin.organ.service;

import java.io.Serializable;

/**
 * 조직관리 모델 클래스
 * @author 민형식
 * @since 2011.09.07
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */
public class  Organ implements Serializable {
	
	/********************추가 코드 ************************/
	   
    /** ORGNZT_ID(조직 아이디) */
    private java.lang.String orgnztId;
    
    /** ORGNZT_NM(조직명) */
    private java.lang.String orgnztNm;
    private java.lang.String orgnztSnm;
    
    /** ORGNZT_DC(조직설명) */
    private java.lang.String orgnztDc;
    
    /** ORG_UP(상위조직) */
    private java.lang.String orgUp;
    private java.lang.String prntOrgnztId;
    private java.lang.String prntOrgnztNm;
    private java.lang.String prntOrgnztSnm;
    
    /** ORD(정렬번호) */
    private Integer ord;
    /** ORG_LV(조직레벨) */
    private java.lang.String orgLv;
    
    /** USE_YN(사용여부) */
    private java.lang.String useYn;
    /** 인사발령 자동 업데이트 사용여부 */
    private java.lang.String memberPositionUpdateYn;
    
    /** FRST_REGISTER_PNTTM(등록일) */
    private java.sql.Date frstRegisterPnttm;
    
    /** LAST_UPDUSR_PNTTM(수정일) */
    private java.sql.Date lastUpdusrPnttm;
    
    /** FRST_REGISTER_ID(등록자 아이디) */
    private java.lang.String frstRegisterId;
    
    /** LAST_UPDUSR_ID(수정자 아이디) */
    private java.lang.String lastUpdusrId;
    /* 수정자 */
    private Integer userNo;
    
    /** POSTCP_NM(부서장명칭) */
    private java.lang.String postcpNm;
    
    /** POSTCP_RNM(수서장대행명칭) */
    private java.lang.String postcpRnm;
    
    /** ORG_HIS_ID(변경이력 일련번호) */
    private java.lang.String orghisId;
    
	/** HGR_STAT(변경 상태(저장,수정,사용중지) */
    private java.lang.String orgStat;      
    
	/** DCount(하위 조직의 존재 수) */
    private java.lang.String dCount;    
    
    //organ snm변경시 prjCd값 변경을 위한 변수
    private String beforeOrgSnm;
    private String curOrgSnm;
    
    private String defaultPrjId;
    private String defaultPrjNm;
    
    private String bfrCompId;
    private String aftCompId;
    
    public java.lang.String getDCount() {
		return dCount;
	}

	public void setDCount(java.lang.String count) {
		dCount = count;
	}

	public java.lang.String getOrghisId() {
		return orghisId;
	}

	public void setOrghisId(java.lang.String orghisId) {
		this.orghisId = orghisId;
	}

	public java.lang.String getOrgStat() {
		return orgStat;
	}

	public void setOrgStat(java.lang.String orgStat) {
		this.orgStat = orgStat;
	}
    
   public java.lang.String getOrgnztId() {
        return this.orgnztId;
    }
    
    public void setOrgnztId(java.lang.String orgnztId) {
        this.orgnztId = orgnztId;
    }
    
    public java.lang.String getOrgnztNm() {
        return this.orgnztNm;
    }
    
    public void setOrgnztNm(java.lang.String orgnztNm) {
        this.orgnztNm = orgnztNm;
    }
    
    public java.lang.String getOrgnztDc() {
        return this.orgnztDc;
    }
    
    public void setOrgnztDc(java.lang.String orgnztDc) {
        this.orgnztDc = orgnztDc;
    }
    
    public java.lang.String getOrgUp() {
        return this.orgUp;
    }
    
    public void setOrgUp(java.lang.String orgUp) {
        this.orgUp = orgUp;
    }
    
    public java.lang.String getOrgLv() {
        return this.orgLv;
    }
    
    public void setOrgLv(java.lang.String orgLv) {
        this.orgLv = orgLv;
    }
    
    public java.lang.String getUseYn() {
        return this.useYn;
    }
    
    public void setUseYn(java.lang.String useYn) {
        this.useYn = useYn;
    }
    
    public java.sql.Date getFrstRegisterPnttm() {
        return this.frstRegisterPnttm;
    }
    
    public void setFrstRegisterPnttm(java.sql.Date frstRegisterPnttm) {
        this.frstRegisterPnttm = frstRegisterPnttm;
    }
    
    public java.sql.Date getLastUpdusrPnttm() {
        return this.lastUpdusrPnttm;
    }
    
    public void setLastUpdusrPnttm(java.sql.Date lastUpdusrPnttm) {
        this.lastUpdusrPnttm = lastUpdusrPnttm;
    }
    
    public java.lang.String getFrstRegisterId() {
        return this.frstRegisterId;
    }
    
    public void setFrstRegisterId(java.lang.String frstRegisterId) {
        this.frstRegisterId = frstRegisterId;
    }
    
    public java.lang.String getLastUpdusrId() {
        return this.lastUpdusrId;
    }
    
    public void setLastUpdusrId(java.lang.String lastUpdusrId) {
        this.lastUpdusrId = lastUpdusrId;
    }
    
    public java.lang.String getPostcpNm() {
        return this.postcpNm;
    }
    
    public void setPostcpNm(java.lang.String postcpNm) {
        this.postcpNm = postcpNm;
    }
    
    public java.lang.String getPostcpRnm() {
        return this.postcpRnm;
    }
    
    public void setPostcpRnm(java.lang.String postcpRnm) {
        this.postcpRnm = postcpRnm;
    }

	public void setOrgnztSnm(java.lang.String orgnztSnm) {
		this.orgnztSnm = orgnztSnm;
	}

	public java.lang.String getOrgnztSnm() {
		return orgnztSnm;
	}

	public void setBeforeOrgSnm(String beforeOrgSnm) {
		this.beforeOrgSnm = beforeOrgSnm;
	}

	public String getBeforeOrgSnm() {
		return beforeOrgSnm;
	}

	public void setCurOrgSnm(String curOrgSnm) {
		this.curOrgSnm = curOrgSnm;
	}

	public String getCurOrgSnm() {
		return curOrgSnm;
	}

	/**
	 * @return the defaultPrjId
	 */
	public String getDefaultPrjId() {
		return defaultPrjId;
	}

	/**
	 * @param defaultPrjId the defaultPrjId to set
	 */
	public void setDefaultPrjId(String defaultPrjId) {
		this.defaultPrjId = defaultPrjId;
	}

	/**
	 * @return the defaultPrjNm
	 */
	public String getDefaultPrjNm() {
		return defaultPrjNm;
	}

	/**
	 * @param defaultPrjNm the defaultPrjNm to set
	 */
	public void setDefaultPrjNm(String defaultPrjNm) {
		this.defaultPrjNm = defaultPrjNm;
	}

	public void setPrntOrgnztId(java.lang.String prntOrgnztId) {
		this.prntOrgnztId = prntOrgnztId;
	}

	public java.lang.String getPrntOrgnztId() {
		return prntOrgnztId;
	}

	public void setPrntOrgnztNm(java.lang.String prntOrgnztNm) {
		this.prntOrgnztNm = prntOrgnztNm;
	}

	public java.lang.String getPrntOrgnztNm() {
		return prntOrgnztNm;
	}

	public void setPrntOrgnztSnm(java.lang.String prntOrgnztSnm) {
		this.prntOrgnztSnm = prntOrgnztSnm;
	}

	public java.lang.String getPrntOrgnztSnm() {
		return prntOrgnztSnm;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public String getBfrCompId() {
		return bfrCompId;
	}

	public void setBfrCompId(String bfrCompId) {
		this.bfrCompId = bfrCompId;
	}

	public String getAftCompId() {
		return aftCompId;
	}

	public void setAftCompId(String aftCompId) {
		this.aftCompId = aftCompId;
	}

	public void setOrd(Integer ord) {
		this.ord = ord;
	}

	public Integer getOrd() {
		return ord;
	}

	public void setMemberPositionUpdateYn(java.lang.String memberPositionUpdateYn) {
		this.memberPositionUpdateYn = memberPositionUpdateYn;
	}

	public java.lang.String getMemberPositionUpdateYn() {
		return memberPositionUpdateYn;
	}
	    	

}
