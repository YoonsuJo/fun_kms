package kms.com.admin.score.service;

import java.io.Serializable;

/**
 * @Class Name : TblScoreVO.java
 * @Description : TblScore VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class Score implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** SCORE_ID */
    private String scoreId;
    
    /** CATEGORY */
    private String category;
    
    /** CODE */
    private String code;
    
    /** ACT */
    private String act;
    
    /** POINT */
    private int point;
    
    private String compareDt;
    
   /** for key */
    private String key1;
    private String key2;
   
    public String getScoreId() {
        return this.scoreId;
    }
    
    public void setScoreId(String scoreId) {
        this.scoreId = scoreId;
    }
    
    public String getCategory() {
        return this.category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getCode() {
        return this.code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    public String getAct() {
        return this.act;
    }
    
    public void setAct(String act) {
        this.act = act;
    }
    
    public int getPoint() {
        return this.point;
    }
    
    public void setPoint(int point) {
        this.point = point;
    }

	public void setCompareDt(String compareDt) {
		this.compareDt = compareDt;
	}

	public String getCompareDt() {
		return compareDt;
	}


	public void setKey1(String key1) {
		this.key1 = key1;
	}

	public String getKey1() {
		return key1;
	}

	public void setKey2(String key2) {
		this.key2 = key2;
	}

	public String getKey2() {
		return key2;
	}
    
}
