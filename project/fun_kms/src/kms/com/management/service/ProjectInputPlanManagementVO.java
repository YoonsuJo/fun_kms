package kms.com.management.service;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ProjectInputPlanManagementVO extends ProjectInputPlanManagement {
	
	private String searchPrjId = "";
	private String searchPrjNm = "";
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String searchYear = CalendarUtil.getToday().substring(0,4);
	private String searchMonth = CalendarUtil.getToday().substring(4,6);
	private String searchWorkTyp = "";
	
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
	 * @return the searchWorkTyp
	 */
	public String getSearchWorkTyp() {
		return searchWorkTyp;
	}
	/**
	 * @param searchWorkTyp the searchWorkTyp to set
	 */
	public void setSearchWorkTyp(String searchWorkTyp) {
		this.searchWorkTyp = searchWorkTyp;
	}
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
