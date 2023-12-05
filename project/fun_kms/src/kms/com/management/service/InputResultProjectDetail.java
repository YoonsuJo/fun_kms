package kms.com.management.service;

import java.text.DecimalFormat;
import java.text.Format;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class InputResultProjectDetail {
	private InputResultProjectDetailVO parentVO;
	
	private String prjId;
	private String prjCd;
	private String prjNm;
	private Integer userNo;
	private String userNm;
	private String userId;
	private Integer drTm;
	private Integer drSumTm;
	private Integer drSalary;
	private Double holTm;
	private Integer holSalary;

	private String searchDate = CalendarUtil.getToday();
	private String searchPrjId = "";
	private String searchPrjNm = "";
	private String[] searchPrjIdList;
	private String includeUnderPrj;
	
	private String moveMonth = "0";
	
	/**
	 * @return the parentVO
	 */
	public InputResultProjectDetailVO getParentVO() {
		return parentVO;
	}
	/**
	 * @param parentVO the parentVO to set
	 */
	public void setParentVO(InputResultProjectDetailVO parentVO) {
		this.parentVO = parentVO;
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
	 * @return the drTm
	 */
	public Integer getDrTm() {
		return drTm;
	}
	public String getDrTmPercent() {
		return CommonUtil.getPercent(drTm, drSumTm);
	}
	/**
	 * @param drTm the drTm to set
	 */
	public void setDrTm(Integer drTm) {
		this.drTm = drTm;
	}
	/**
	 * @return the drSumTm
	 */
	public Integer getDrSumTm() {
		return drSumTm;
	}
	/**
	 * @param drSumTm the drSumTm to set
	 */
	public void setDrSumTm(Integer drSumTm) {
		this.drSumTm = drSumTm;
	}
	/**
	 * @return the drSalary
	 */
	public Integer getDrSalary() {
		return drSalary;
	}
	public String getDrSalaryPrint() {
		return CommonUtil.insertComma(drSalary);
	}
	/**
	 * @param drSalary the drSalary to set
	 */
	public void setDrSalary(Integer drSalary) {
		this.drSalary = drSalary;
	}
	/**
	 * @return the holTm
	 */
	public Double getHolTm() {
		return holTm;
	}
	/**
	 * @param holTm the holTm to set
	 */
	public void setHolTm(Double holTm) {
		this.holTm = holTm;
	}
	/**
	 * @return the holSalary
	 */
	public Integer getHolSalary() {
		return holSalary;
	}
	public String getHolSalaryPrint() {
		return CommonUtil.insertComma(holSalary);
	}
	/**
	 * @param holSalary the holSalary to set
	 */
	public void setHolSalary(Integer holSalary) {
		this.holSalary = holSalary;
	}
	/**
	 * @return the searchDate
	 */
	public String getSearchDate() {
		return searchDate;
	}
	/**
	 * @param searchDate the searchDate to set
	 */
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	/**
	 * @return the searchPrjId
	 */
	public String getSearchPrjId() {
		return searchPrjId;
	}
	/**
	 * @param searchPrjId the searchPrjId to set
	 */
	public void setSearchPrjId(String searchPrjId) {
		this.searchPrjId = searchPrjId;
	}
	/**
	 * @return the searchPrjNm
	 */
	public String getSearchPrjNm() {
		return searchPrjNm;
	}
	/**
	 * @param searchPrjNm the searchPrjNm to set
	 */
	public void setSearchPrjNm(String searchPrjNm) {
		this.searchPrjNm = searchPrjNm;
	}
	/**
	 * @return the searchPrjIdList
	 */
	public String[] getSearchPrjIdList() {
		return searchPrjIdList;
	}
	/**
	 * @param searchPrjIdList the searchPrjIdList to set
	 */
	public void setSearchPrjIdList(String[] searchPrjIdList) {
		this.searchPrjIdList = searchPrjIdList;
	}
	/**
	 * @return the includeUnderPrj
	 */
	public String getIncludeUnderPrj() {
		return includeUnderPrj;
	}
	/**
	 * @param includeUnderPrj the includeUnderPrj to set
	 */
	public void setIncludeUnderPrj(String includeUnderPrj) {
		this.includeUnderPrj = includeUnderPrj;
	}
	
	
	public String getMoveMonth() {
		return moveMonth;
	}
	public void setMoveMonth(String moveMonth) {
		this.moveMonth = moveMonth;
	}
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
