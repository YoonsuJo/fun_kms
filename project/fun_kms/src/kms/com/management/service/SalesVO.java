package kms.com.management.service;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class SalesVO extends Sales {
	private String searchYear = CalendarUtil.getToday().substring(0,4);
	private String searchMonth = CalendarUtil.getToday().substring(4,6);
	private String searchCondition = "0";
	private String includeResult = "N";
	private String searchBusiId = "";
	private String searchOrgId = "";
	private String[] searchOrgIdList;
	private String searchOrgNm = "";
	private String[] searchOrgNmList;
	
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
	
	/**
	 * @param includeNew the includeNew to set
	 */
	
	/**
	 * @param searchCompanyCd the searchCompanyCd to set
	 */
	
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
	
	/**
	 * @param searchPrjId the searchPrjId to set
	 */
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
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
	public void setSearchOrgIdList(String[] searchOrgIdList) {
		this.searchOrgIdList = searchOrgIdList;
	}
	public String[] getSearchOrgIdList() {
		return searchOrgIdList;
	}
	public void setSearchOrgNmList(String[] searchOrgNmList) {
		this.searchOrgNmList = searchOrgNmList;
	}
	public String[] getSearchOrgNmList() {
		return searchOrgNmList;
	}

}
