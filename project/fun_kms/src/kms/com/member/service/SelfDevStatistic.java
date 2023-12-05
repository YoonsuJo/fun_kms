package kms.com.member.service;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class SelfDevStatistic {
	private Integer userNo;
	private String userNm;
	private String userId;
	private String orgnztId;
	private String orgnztNm;
	private Integer full = 0;
	private Integer half = 0;
	private Integer used = 0;
	
	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	private String searchCondition = "0";
	private String searchUserNm = "";
	private String searchOrgNm = "";
	private String searchOrgId = "";
	private String[] searchOrgIdList;
	private String orderBy;
	
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
	 * @return the full
	 */
	public Integer getFull() {
		return full;
	}
	/**
	 * @param full the full to set
	 */
	public void setFull(Integer full) {
		this.full = full;
	}
	/**
	 * @return the half
	 */
	public Integer getHalf() {
		return half;
	}
	/**
	 * @param half the half to set
	 */
	public void setHalf(Integer half) {
		this.half = half;
	}
	/**
	 * @return the used
	 */
	public Integer getUsed() {
		return used;
	}
	public String getUsedPrint() {
		return CommonUtil.insertComma(used);
	}
	/**
	 * @param used the used to set
	 */
	public void setUsed(Integer used) {
		this.used = used;
	}
	/**
	 * @return the searchYear
	 */
	public Integer getSearchYear() {
		return searchYear;
	}
	/**
	 * @param searchYear the searchYear to set
	 */
	public void setSearchYear(Integer searchYear) {
		this.searchYear = searchYear;
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

	public String getSelfDev() {
		return CommonUtil.insertComma(full + half);
	}
	public String getFullLeft() {
		if (used > full) return "0";
		else return CommonUtil.insertComma(full - used);
	}
	public String getHalfLeft() {
		if (used >= full + half) return "0";
		else if (used < full) return CommonUtil.insertComma(half);
		else return CommonUtil.insertComma(half + full - used);
	}
	
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
