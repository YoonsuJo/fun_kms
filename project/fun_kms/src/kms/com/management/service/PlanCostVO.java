package kms.com.management.service;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class PlanCostVO extends PlanCost {
	private String searchYear = CalendarUtil.getToday().substring(0,4);
	private String searchMonth = CalendarUtil.getToday().substring(4,6);
	private String searchAccId = "";
	private String searchAccNm = "";
	private String searchCondition = "0";
	private String includeNew = "Y";
	private String searchCompanyCd = "";
	private String searchUserMixes = "";
	private String[] searchUserId;
	private String searchOrgId = "";
	private String searchBusiId = "";
	private String[] searchBusiIdList;
	private String[] searchOrgIdList ;
	private String searchOrgNm = "";
	private String searchPrjId = "";
	private String searchPrjNm = "";
	private String searchSectorNo = "";
	
	private String includeResult = "N";
	private String searchSum = "N";
	
	// [20141010, dwkim] 조건 추가 
	private String startDate = "";
	private String endDate = "";
	private String includeAllDate = "N";	// 전체기간 포함
	private String includeAcc = "N";	// 누적실적 포함
	
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
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setSearchSum(String searchSum) {
		this.searchSum = searchSum;
	}
	public String getSearchSum() {
		return searchSum;
	}
	public void setSearchOrgIdList(String[] searchOrgIdList) {
		this.searchOrgIdList = searchOrgIdList;
	}
	public String[] getSearchOrgIdList() {
		return searchOrgIdList;
	}
	public void setIncludeResult(String includeResult) {
		this.includeResult = includeResult;
	}
	public String getIncludeResult() {
		return includeResult;
	}
	public void setSearchBusiId(String searchBusiId) {
		this.searchBusiId = searchBusiId;
	}
	public String getSearchBusiId() {
		return searchBusiId;
	}
	public void setSearchBusiIdList(String[] searchBusiIdList) {
		this.searchBusiIdList = searchBusiIdList;
	}
	public String[] getSearchBusiIdList() {
		return searchBusiIdList;
	}
	/**
	 * @return the searchSectorNo
	 */
	public String getSearchSectorNo() {
		return searchSectorNo;
	}
	/**
	 * @param searchSectorNo the searchSectorNo to set
	 */
	public void setSearchSectorNo(String searchSectorNo) {
		this.searchSectorNo = searchSectorNo;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getIncludeAllDate() {
		return includeAllDate;
	}
	public void setIncludeAllDate(String includeAllDate) {
		this.includeAllDate = includeAllDate;
	}
	public String getIncludeAcc() {
		return includeAcc;
	}
	public void setIncludeAcc(String includeAcc) {
		this.includeAcc = includeAcc;
	}

}
