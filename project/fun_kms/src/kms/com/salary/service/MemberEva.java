package kms.com.salary.service;

import java.io.Serializable;

import kms.com.common.utils.CommonUtil;

/**
 * @Class Name : MemberEva.java
 * @Description : Member Evaluation for Deciding Salary class
 * @Modification Information
 *
 * @author 박기현
 * @since 2012.11.27
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class MemberEva implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** TBL_USER_EVA attributes */
    private String userNo;
    private String year;
    private String grade;
    private String eva1;
    private String eva2;
    private String eva3;
    private String eva1Nm;
    private String eva2Nm;
    private String eva3Nm;    
    private String score1;
    private String score2;
    private String score3;
    
    /** Record history attributes */
    private String expCompId;
    private String compnyId;
    private String orgnztId;
    private String rankId;
    private String position;
    private String workSt;
    private String degree;
    private String promotionYear;
    private String careerLength;
    private String scoreSelf;
    
    
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getYear() {
		return year;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getGrade() {
		return grade;
	}
	public void setEva1(String eva1) {
		this.eva1 = eva1;
	}
	public String getEva1() {
		return eva1;
	}
	public void setEva2(String eva2) {
		this.eva2 = eva2;
	}
	public String getEva2() {
		return eva2;
	}
	public void setEva3(String eva3) {
		this.eva3 = eva3;
	}
	public String getEva3() {
		return eva3;
	}
	public void setScore1(String score1) {
		this.score1 = score1;
	}
	public String getScore1() {
		return score1;
	}
	public void setScore2(String score2) {
		this.score2 = score2;
	}
	public String getScore2() {
		return score2;
	}
	public void setScore3(String score3) {
		this.score3 = score3;
	}
	public String getScore3() {
		return score3;
	}
	public void setExpCompId(String expCompId) {
		this.expCompId = expCompId;
	}
	public String getExpCompId() {
		return expCompId;
	}
	public void setCompnyId(String compnyId) {
		this.compnyId = compnyId;
	}
	public String getCompnyId() {
		return compnyId;
	}
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	public String getOrgnztId() {
		return orgnztId;
	}
	public void setRankId(String rankId) {
		this.rankId = rankId;
	}
	public String getRankId() {
		return rankId;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getPosition() {
		return position;
	}
	public void setWorkSt(String workSt) {
		this.workSt = workSt;
	}
	public String getWorkSt() {
		return workSt;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getDegree() {
		return degree;
	}
	public void setPromotionYear(String promotionYear) {
		this.promotionYear = promotionYear;
	}
	public String getPromotionYear() {
		return promotionYear;
	}
	public void setCareerLength(String careerLength) {
		this.careerLength = careerLength;
	}
	public void setCareerLength(int careerLength) {
		this.careerLength = Integer.toString(careerLength);
	}
	public String getCareerLength() {
		return careerLength;
	}
	public void setScoreSelf(String scoreSelf) {
		this.scoreSelf = scoreSelf;
	}
	public String getScoreSelf() {
		return scoreSelf;
	}
	public void setEva1Nm(String eva1Nm) {
		this.eva1Nm = eva1Nm;
	}
	public String getEva1Nm() {
		return eva1Nm;
	}
	public void setEva2Nm(String eva2Nm) {
		this.eva2Nm = eva2Nm;
	}
	public String getEva2Nm() {
		return eva2Nm;
	}
	public void setEva3Nm(String eva3Nm) {
		this.eva3Nm = eva3Nm;
	}
	public String getEva3Nm() {
		return eva3Nm;
	}
    
}