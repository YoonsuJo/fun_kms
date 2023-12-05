package kms.com.management.service;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ProjectInputPlanManagement {
	private Integer no;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String prjId;
	private String prjCd;
	private String prjNm;
	private String orgnztId;
	private String orgnztNm;
	private Integer inputPercent;
	private String inputSdt;
	private String inputEdt;
	private Integer regUserNo;
	private String regUserNm;
	private String regUserId;
	private String regDt;
	private Integer modUserNo;
	private String modUserNm;
	private String modUserId;
	private String modDt;
	
	private String[] userMixList;
	/**
	 * @return the no
	 */
	public Integer getNo() {
		return no;
	}
	/**
	 * @param no the no to set
	 */
	public void setNo(Integer no) {
		this.no = no;
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
	 * @return the prjId
	 */
	public String getPrjId() {
		return prjId;
	}
	/**
	 * @param prjId the prjId to set
	 */
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	/**
	 * @return the prjCd
	 */
	public String getPrjCd() {
		return prjCd;
	}
	/**
	 * @param prjCd the prjCd to set
	 */
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	/**
	 * @return the prjNm
	 */
	public String getPrjNm() {
		return prjNm;
	}
	/**
	 * @param prjNm the prjNm to set
	 */
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	/**
	 * @return the orgnztId
	 */
	public String getOrgnztId() {
		return orgnztId;
	}
	/**
	 * @param orgnztId the orgnztId to set
	 */
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	/**
	 * @return the orgnztNm
	 */
	public String getOrgnztNm() {
		return orgnztNm;
	}
	/**
	 * @param orgnztNm the orgnztNm to set
	 */
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
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
	/**
	 * @return the inputSdt
	 */
	public String getInputSdt() {
		return inputSdt;
	}
	/**
	 * @param inputSdt the inputSdt to set
	 */
	public void setInputSdt(String inputSdt) {
		this.inputSdt = inputSdt;
	}
	/**
	 * @return the inputEdt
	 */
	public String getInputEdt() {
		return inputEdt;
	}
	/**
	 * @param inputEdt the inputEdt to set
	 */
	public void setInputEdt(String inputEdt) {
		this.inputEdt = inputEdt;
	}
	/**
	 * @return the regUserNo
	 */
	public Integer getRegUserNo() {
		return regUserNo;
	}
	/**
	 * @param regUserNo the regUserNo to set
	 */
	public void setRegUserNo(Integer regUserNo) {
		this.regUserNo = regUserNo;
	}
	/**
	 * @return the regUserNm
	 */
	public String getRegUserNm() {
		return regUserNm;
	}
	/**
	 * @param regUserNm the regUserNm to set
	 */
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
	}
	/**
	 * @return the regUserId
	 */
	public String getRegUserId() {
		return regUserId;
	}
	/**
	 * @param regUserId the regUserId to set
	 */
	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}
	/**
	 * @return the regDt
	 */
	public String getRegDt() {
		return regDt;
	}
	/**
	 * @param regDt the regDt to set
	 */
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	/**
	 * @return the modUserNo
	 */
	public Integer getModUserNo() {
		return modUserNo;
	}
	/**
	 * @param modUserNo the modUserNo to set
	 */
	public void setModUserNo(Integer modUserNo) {
		this.modUserNo = modUserNo;
	}
	/**
	 * @return the modUserNm
	 */
	public String getModUserNm() {
		return modUserNm;
	}
	/**
	 * @param modUserNm the modUserNm to set
	 */
	public void setModUserNm(String modUserNm) {
		this.modUserNm = modUserNm;
	}
	/**
	 * @return the modUserId
	 */
	public String getModUserId() {
		return modUserId;
	}
	/**
	 * @param modUserId the modUserId to set
	 */
	public void setModUserId(String modUserId) {
		this.modUserId = modUserId;
	}
	/**
	 * @return the modDt
	 */
	public String getModDt() {
		return modDt;
	}
	/**
	 * @param modDt the modDt to set
	 */
	public void setModDt(String modDt) {
		this.modDt = modDt;
	}
	/**
	 * @return the userMixList
	 */
	public String[] getUserMixList() {
		return userMixList;
	}
	/**
	 * @param userMixList the userMixList to set
	 */
	public void setUserMixList(String[] userMixList) {
		this.userMixList = userMixList;
	}
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
