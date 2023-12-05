package kms.com.management.service;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ExpenseVO extends Expense {
	
	private String searchYear = CalendarUtil.getToday().substring(0,4);
	private String searchMonth = "";
	private String searchAccId = "";
	private String searchAccNm = "";
	private String searchCondition = "0";
	private String includeNew = "N";
	
	private String searchCompanyCd = "";
	private String searchUserMixes = "";
	private String[] searchUserId;
	
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String[] searchOrgIdList;
	
	private String searchPrjId = "";
	private String searchPrjNm = "";
	
	private String includeResult = "N";
	private String includeExp = "Y";
	private String includeCost = "Y";
	
	/**
	 * @return the searchYear
	 */
	public String getSearchYear() {
		return searchYear;
	}
	/**
	 * @param searchYear the searchYear to set
	 */
	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}
	/**
	 * @return the searchMonth
	 */
	public String getSearchMonth() {
		return searchMonth;
	}
	/**
	 * @param searchMonth the searchMonth to set
	 */
	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}
	/**
	 * @return the searchAccId
	 */
	public String getSearchAccId() {
		return searchAccId;
	}
	/**
	 * @param searchAccId the searchAccId to set
	 */
	public void setSearchAccId(String searchAccId) {
		this.searchAccId = searchAccId;
	}
	/**
	 * @return the searchAccNm
	 */
	public String getSearchAccNm() {
		return searchAccNm;
	}
	/**
	 * @param searchAccNm the searchAccNm to set
	 */
	public void setSearchAccNm(String searchAccNm) {
		this.searchAccNm = searchAccNm;
	}
	/**
	 * @return the searchCondition
	 */
	public String getSearchCondition() {
		return searchCondition;
	}
	/**
	 * @param searchCondition the searchCondition to set
	 */
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	/**
	 * @return the includeNew
	 */
	public String getIncludeNew() {
		return includeNew;
	}
	/**
	 * @param includeNew the includeNew to set
	 */
	public void setIncludeNew(String includeNew) {
		this.includeNew = includeNew;
	}
	/**
	 * @return the searchCompanyCd
	 */
	public String getSearchCompanyCd() {
		return searchCompanyCd;
	}
	/**
	 * @param searchCompanyCd the searchCompanyCd to set
	 */
	public void setSearchCompanyCd(String searchCompanyCd) {
		this.searchCompanyCd = searchCompanyCd;
	}
	/**
	 * @return the searchUserMixes
	 */
	public String getSearchUserMixes() {
		return searchUserMixes;
	}
	/**
	 * @param searchUserMixes the searchUserMixes to set
	 */
	public void setSearchUserMixes(String searchUserMixes) {
		this.searchUserMixes = searchUserMixes;
	}
	/**
	 * @return the searchUserId
	 */
	public String[] getSearchUserId() {
		return searchUserId;
	}
	/**
	 * @param searchUserId the searchUserId to set
	 */
	public void setSearchUserId(String[] searchUserId) {
		this.searchUserId = searchUserId;
	}
	/**
	 * @return the searchOrgId
	 */
	public String getSearchOrgId() {
		return searchOrgId;
	}
	/**
	 * @param searchOrgId the searchOrgId to set
	 */
	public void setSearchOrgId(String searchOrgId) {
		this.searchOrgId = searchOrgId;
	}
	/**
	 * @return the searchOrgNm
	 */
	public String getSearchOrgNm() {
		return searchOrgNm;
	}
	/**
	 * @param searchOrgNm the searchOrgNm to set
	 */
	public void setSearchOrgNm(String searchOrgNm) {
		this.searchOrgNm = searchOrgNm;
	}
	/**
	 * @return the searchOrgIdList
	 */
	public String[] getSearchOrgIdList() {
		return searchOrgIdList;
	}
	/**
	 * @param searchOrgIdList the searchOrgIdList to set
	 */
	public void setSearchOrgIdList(String[] searchOrgIdList) {
		this.searchOrgIdList = searchOrgIdList;
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
	 * @return the includeResult
	 */
	public String getIncludeResult() {
		return includeResult;
	}
	/**
	 * @param includeResult the includeResult to set
	 */
	public void setIncludeResult(String includeResult) {
		this.includeResult = includeResult;
	}
	/**
	 * @return the includeExp
	 */
	public String getIncludeExp() {
		return includeExp;
	}
	/**
	 * @param includeExp the includeExp to set
	 */
	public void setIncludeExp(String includeExp) {
		this.includeExp = includeExp;
	}
	/**
	 * @return the includeCost
	 */
	public String getIncludeCost() {
		return includeCost;
	}
	/**
	 * @param includeCost the includeCost to set
	 */
	public void setIncludeCost(String includeCost) {
		this.includeCost = includeCost;
	}
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
