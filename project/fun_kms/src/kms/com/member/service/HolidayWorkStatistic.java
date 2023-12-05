package kms.com.member.service;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class HolidayWorkStatistic {
	private Integer userNo;
	private String userNm;
	private String userId;
	private String orgnztId;
	private String orgnztNm;
	private Double hol01 = 0.0;
	private Double hol02 = 0.0;
	private Double hol03 = 0.0;
	private Double hol04 = 0.0;
	private Double hol05 = 0.0;
	private Double hol06 = 0.0;
	private Double hol07 = 0.0;
	private Double hol08 = 0.0;
	private Double hol09 = 0.0;
	private Double hol10 = 0.0;
	private Double hol11 = 0.0;
	private Double hol12 = 0.0;
	private Double holSum = 0.0;
	
	private String searchYear = CalendarUtil.getToday().substring(0,4);
	private String searchMonth;
	private String searchCondition = "0";
	private Integer searchUserNo = 0;
	private String searchUserNm = "";
	private String searchOrgNm = "";
	private String searchOrgId = "";
	private String[] searchOrgIdList;
	
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
	 * @return the hol01
	 */
	public Double getHol01() {
		return hol01;
	}
	/**
	 * @param hol01 the hol01 to set
	 */
	public void setHol01(Double hol01) {
		this.hol01 = hol01;
	}
	/**
	 * @return the hol02
	 */
	public Double getHol02() {
		return hol02;
	}
	/**
	 * @param hol02 the hol02 to set
	 */
	public void setHol02(Double hol02) {
		this.hol02 = hol02;
	}
	/**
	 * @return the hol03
	 */
	public Double getHol03() {
		return hol03;
	}
	/**
	 * @param hol03 the hol03 to set
	 */
	public void setHol03(Double hol03) {
		this.hol03 = hol03;
	}
	/**
	 * @return the hol04
	 */
	public Double getHol04() {
		return hol04;
	}
	/**
	 * @param hol04 the hol04 to set
	 */
	public void setHol04(Double hol04) {
		this.hol04 = hol04;
	}
	/**
	 * @return the hol05
	 */
	public Double getHol05() {
		return hol05;
	}
	/**
	 * @param hol05 the hol05 to set
	 */
	public void setHol05(Double hol05) {
		this.hol05 = hol05;
	}
	/**
	 * @return the hol06
	 */
	public Double getHol06() {
		return hol06;
	}
	/**
	 * @param hol06 the hol06 to set
	 */
	public void setHol06(Double hol06) {
		this.hol06 = hol06;
	}
	/**
	 * @return the hol07
	 */
	public Double getHol07() {
		return hol07;
	}
	/**
	 * @param hol07 the hol07 to set
	 */
	public void setHol07(Double hol07) {
		this.hol07 = hol07;
	}
	/**
	 * @return the hol08
	 */
	public Double getHol08() {
		return hol08;
	}
	/**
	 * @param hol08 the hol08 to set
	 */
	public void setHol08(Double hol08) {
		this.hol08 = hol08;
	}
	/**
	 * @return the hol09
	 */
	public Double getHol09() {
		return hol09;
	}
	/**
	 * @param hol09 the hol09 to set
	 */
	public void setHol09(Double hol09) {
		this.hol09 = hol09;
	}
	/**
	 * @return the hol10
	 */
	public Double getHol10() {
		return hol10;
	}
	/**
	 * @param hol10 the hol10 to set
	 */
	public void setHol10(Double hol10) {
		this.hol10 = hol10;
	}
	/**
	 * @return the hol11
	 */
	public Double getHol11() {
		return hol11;
	}
	/**
	 * @param hol11 the hol11 to set
	 */
	public void setHol11(Double hol11) {
		this.hol11 = hol11;
	}
	/**
	 * @return the hol12
	 */
	public Double getHol12() {
		return hol12;
	}
	/**
	 * @param hol12 the hol12 to set
	 */
	public void setHol12(Double hol12) {
		this.hol12 = hol12;
	}
	/**
	 * @return the holSum
	 */
	public Double getHolSum() {
		return holSum;
	}
	/**
	 * @param holSum the holSum to set
	 */
	public void setHolSum(Double holSum) {
		this.holSum = holSum;
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
	 * @return the searchUserNo
	 */
	public Integer getSearchUserNo() {
		return searchUserNo;
	}
	/**
	 * @param searchUserNo the searchUserNo to set
	 */
	public void setSearchUserNo(Integer searchUserNo) {
		this.searchUserNo = searchUserNo;
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

	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
