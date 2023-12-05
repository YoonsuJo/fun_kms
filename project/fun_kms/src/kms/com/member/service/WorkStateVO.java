package kms.com.member.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;

@SuppressWarnings("serial")
public class WorkStateVO extends WorkState implements Serializable{
	
	/** 검색조건 */
	private String searchCondition = "0";

	/** 검색Keyword */
	private String searchKeyword = "";
	private String searchUserNm = "";
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String[] searchOrgIdList;
	private String orderBy = "";
	
	private String searchDate = CalendarUtil.getToday();	
	private String searchYear = CalendarUtil.getToday().substring(0,4);
	private String searchMonth;
	private String vacTyp;

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
	 * @return the searchKeyword
	 */
	public String getSearchKeyword() {
		return searchKeyword;
	}

	/**
	 * @param searchKeyword the searchKeyword to set
	 */
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	/**
	 * @return the searchUserNm
	 */
	public String getSearchUserNm() {
		return searchUserNm;
	}

	/**
	 * @param searchUserNm the searchUserNm to set
	 */
	public void setSearchUserNm(String searchUserNm) {
		this.searchUserNm = searchUserNm;
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
	 * @return the vacTyp
	 */
	public String getVacTyp() {
		return vacTyp;
	}

	/**
	 * @param vacTyp the vacTyp to set
	 */
	public void setVacTyp(String vacTyp) {
		this.vacTyp = vacTyp;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getOrderBy() {
		return orderBy;
	}	
	
}
