package kms.com.management.service;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ProjectInputPlanDaily {
	
	private String inputDt;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String orgnztId;
	private String orgnztNm;
	private Integer inputPercent = 0;
	private String noInput = "";
	private int noInputCnt = 0;
	/**
	 * @return the inputDt
	 */
	public String getInputDt() {
		return inputDt;
	}
	/**
	 * @param inputDt the inputDt to set
	 */
	public void setInputDt(String inputDt) {
		this.inputDt = inputDt;
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
	 * @return the inputPercent
	 */
	public Integer getInputPercent() {
		return inputPercent;
	}
	/**
	 * @param inputPercent the inputPercent to set
	 */
	public void setInputPercent(Integer inputPercent) {
		this.inputPercent = inputPercent;
	}
	
	
	public String getOrgnztId() {
		return orgnztId;
	}
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	public String getOrgnztNm() {
		return orgnztNm;
	}
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	public String getNoInput() {
		return noInput;
	}
	public void setNoInput(String noInput) {
		this.noInput = noInput;
	}
	public Integer getNoInputCnt() {
		return noInputCnt;
	}
	public void setNoInputCnt(Integer noInputCnt) {
		this.noInputCnt = noInputCnt;
	}
	public void increaseNoInputCnt() {
		noInputCnt++;
	}
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
