package kms.com.admin.score.service;

import java.io.Serializable;

/**
 * @Class Name : TblScoreDetailVO.java
 * @Description : TblScoreDetail VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ScoreDetail implements Serializable {
    private static final long serialVersionUID = 1L;
    
    /** NO */
    private int no;
    
    /** SCORE_ID */
    private java.lang.String scoreId;
    
    /** USER_NO */
    private java.lang.String userNo;
    
    /** REG_DT */
    private java.util.Date regDt;
    
    /** POINT */
    private int point;
    
    public int getNo() {
        return this.no;
    }
    
    public void setNo(int no) {
        this.no = no;
    }
    
    public java.lang.String getScoreId() {
        return this.scoreId;
    }
    
    public void setScoreId(java.lang.String scoreId) {
        this.scoreId = scoreId;
    }
    
    public java.lang.String getUserNo() {
        return this.userNo;
    }
    
    public void setUserNo(java.lang.String userNo) {
        this.userNo = userNo;
    }
    
    public java.util.Date getRegDt() {
        return this.regDt;
    }
    
    public void setRegDt(java.util.Date regDt) {
        this.regDt = regDt;
    }
    
    public int getPoint() {
        return this.point;
    }
    
    public void setPoint(int point) {
        this.point = point;
    }
    
}
