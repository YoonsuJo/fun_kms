package kms.com.app.service;

import java.io.Serializable;

/**
 * @Class Name : TblEappJobgVO.java
 * @Description : TblEappJobg VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ApprovalJobgVO implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** DOC_ID */
    private String docId;
    
    /** TEAM_ID */
    private String orgnztId;
    private String orgnztNm;
    
    /** MNG_TSK */
    private String mngTsk;
    
    /** CAR_CD */
    private int carCd = 1;
    
    /** CAR_MIN_YEAR */
    private int carMinYear;
    
    /** CAR_MAX_YEAR */
    private int carMaxYear;
    
    /** MON_PAY_MIN */
    private int monPayMin;
    
    /** MON_PAY_MAX */
    private int monPayMax;
    
    /** EDUCATION */
    private String education;
    
    /** AGE_MIN */
    private int ageMin;
    
    /** AGE_MAX */
    private int ageMax;
    
    /** RANK_ID */
    private String rankId ;
    
    /** GEND_CD */
    private String gendCd ;
    
    /** DSD_FR_WK */
    private String dsdFrWk;
    
    /** KEYWD */
    private String keywd;
    
    /** OTR_CON */
    private String otrCon;
    
    /** for list*/
    private String[] educationList;
    private String[] rankIdList;
    
    public String getDocId() {
        return this.docId;
    }
    
    public void setDocId(String docId) {
        this.docId = docId;
    }
    
    public String getMngTsk() {
        return this.mngTsk;
    }
    
    public void setMngTsk(String mngTsk) {
        this.mngTsk = mngTsk;
    }
    
    public int getCarCd() {
        return this.carCd;
    }
    
    public void setCarCd(int carCd) {
        this.carCd = carCd;
    }
    
    public int getCarMinYear() {
        return this.carMinYear;
    }
    
    public void setCarMinYear(int carMinYear) {
        this.carMinYear = carMinYear;
    }
    
    public int getCarMaxYear() {
        return this.carMaxYear;
    }
    
    public void setCarMaxYear(int carMaxYear) {
        this.carMaxYear = carMaxYear;
    }
    
    public int getMonPayMin() {
        return this.monPayMin;
    }
    
    public void setMonPayMin(int monPayMin) {
        this.monPayMin = monPayMin;
    }
    
    public int getMonPayMax() {
        return this.monPayMax;
    }
    
    public void setMonPayMax(int monPayMax) {
        this.monPayMax = monPayMax;
    }
    
    public String getEducation() {
        return this.education;
    }
    
    public void setEducation(String education) {
        this.education = education;
    }
    
    public int getAgeMin() {
        return this.ageMin;
    }
    
    public void setAgeMin(int ageMin) {
        this.ageMin = ageMin;
    }
    
    public int getAgeMax() {
        return this.ageMax;
    }
    
    public void setAgeMax(int ageMax) {
        this.ageMax = ageMax;
    }
    
    public String getRankId() {
        return this.rankId;
    }
    
    public void setRankId(String rankId) {
        this.rankId = rankId;
    }
    
    public String getGendCd() {
        return this.gendCd;
    }
    
    public void setGendCd(String gendCd) {
        this.gendCd = gendCd;
    }
    
    public String getDsdFrWk() {
        return this.dsdFrWk;
    }
    
    public void setDsdFrWk(String dsdFrWk) {
        this.dsdFrWk = dsdFrWk;
    }
    
    public String getKeywd() {
        return this.keywd;
    }
    
    public void setKeywd(String keywd) {
        this.keywd = keywd;
    }
    
    public String getOtrCon() {
        return this.otrCon;
    }
    
    public void setOtrCon(String otrCon) {
        this.otrCon = otrCon;
    }

	public void setEducationList(String[] educationList) {
		this.educationList = educationList;
	}

	public String[] getEducationList() {
		return educationList;
	}

	public void setRankIdList(String[] rankIdList) {
		this.rankIdList = rankIdList;
	}

	public String[] getRankIdList() {
		return rankIdList;
	}

	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}

	public String getOrgnztId() {
		return orgnztId;
	}

	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}

	public String getOrgnztNm() {
		return orgnztNm;
	}
    
}
