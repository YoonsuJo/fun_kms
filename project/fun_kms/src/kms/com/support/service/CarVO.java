package kms.com.support.service;

import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class CarVO {
	private String carId;
	private String carTyp;
	private String userTyp;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String insComp;
	private String insCallNo;
	private String insEdate;
	private Integer insAge;
	private String insLicTyp;
	private String compnyId;
	private String compnyNm;
	private String imgFileId;
	
	public String getUserPrint() {
		if (userTyp == null || userTyp.equals("")) return "공용";
		
		if (userTyp.equals("C")) return "공용";
		else if (userTyp.equals("U")) return userNm;
		
		else return userTyp + "/" + userNm;
	}
	
	/**
	 * @return the carId
	 */
	public String getCarId() {
		return carId;
	}
	/**
	 * @param carId the carId to set
	 */
	public void setCarId(String carId) {
		this.carId = carId;
	}
	/**
	 * @return the carTyp
	 */
	public String getCarTyp() {
		return carTyp;
	}
	/**
	 * @param carTyp the carTyp to set
	 */
	public void setCarTyp(String carTyp) {
		this.carTyp = carTyp;
	}
	/**
	 * @return the userTyp
	 */
	public String getUserTyp() {
		return userTyp;
	}
	/**
	 * @param userTyp the userTyp to set
	 */
	public void setUserTyp(String userTyp) {
		this.userTyp = userTyp;
	}
	/**
	 * @return the userNo
	 */
	public Integer getUserNo() {
		return userNo;
	}
	/**
	 * @param userNo the userNo to set
	 */
	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}
	/**
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the insComp
	 */
	public String getInsComp() {
		return insComp;
	}
	/**
	 * @param insComp the insComp to set
	 */
	public void setInsComp(String insComp) {
		this.insComp = insComp;
	}
	/**
	 * @return the insCallNo
	 */
	public String getInsCallNo() {
		return insCallNo;
	}
	/**
	 * @param insCallNo the insCallNo to set
	 */
	public void setInsCallNo(String insCallNo) {
		this.insCallNo = insCallNo;
	}
	/**
	 * @return the insEdate
	 */
	public String getInsEdate() {
		return insEdate;
	}
	public String getInsEdatePrint() {
		return CommonUtil.getDateType(insEdate);
	}
	/**
	 * @param insEdate the insEdate to set
	 */
	public void setInsEdate(String insEdate) {
		this.insEdate = insEdate;
	}
	/**
	 * @return the insAge
	 */
	public Integer getInsAge() {
		return insAge;
	}
	/**
	 * @param insAge the insAge to set
	 */
	public void setInsAge(Integer insAge) {
		this.insAge = insAge;
	}
	/**
	 * @return the insLicTyp
	 */
	public String getInsLicTyp() {
		return insLicTyp;
	}
	public String getInsLicTypPrint() {
		if (insLicTyp == null || insLicTyp.equals("")) return "2종보통";
		
		if (insLicTyp.equals("A")) return "1종대형";
		else if (insLicTyp.equals("B")) return "1종보통";
		else if (insLicTyp.equals("C")) return "2종보통";
		
		else return insLicTyp;
	}
	/**
	 * @param insLicTyp the insLicTyp to set
	 */
	public void setInsLicTyp(String insLicTyp) {
		this.insLicTyp = insLicTyp;
	}
	/**
	 * @return the compnyId
	 */
	public String getCompnyId() {
		return compnyId;
	}
	/**
	 * @param compnyId the compnyId to set
	 */
	public void setCompnyId(String compnyId) {
		this.compnyId = compnyId;
	}
	/**
	 * @return the compnyNm
	 */
	public String getCompnyNm() {
		return compnyNm;
	}
	/**
	 * @param compnyNm the compnyNm to set
	 */
	public void setCompnyNm(String compnyNm) {
		this.compnyNm = compnyNm;
	}
	/**
	 * @return the imgFileId
	 */
	public String getImgFileId() {
		return imgFileId;
	}
	/**
	 * @param imgFileId the imgFileId to set
	 */
	public void setImgFileId(String imgFileId) {
		this.imgFileId = imgFileId;
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
