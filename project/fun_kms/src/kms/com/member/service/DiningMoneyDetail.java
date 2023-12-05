package kms.com.member.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class DiningMoneyDetail {
	private String expDt;
	private Integer diningSpend;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String expCt;

	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	private String searchOrgId = "";
	/**
	 * @return the expDt
	 */
	public String getExpDt() {
		return expDt;
	}
	/**
	 * @param expDt the expDt to set
	 */
	public void setExpDt(String expDt) {
		this.expDt = expDt;
	}
	/**
	 * @return the diningSpend
	 */
	public Integer getDiningSpend() {
		return diningSpend;
	}
	public String getDiningSpendPrint() {
		return CommonUtil.insertComma(diningSpend);
	}
	/**
	 * @param diningSpend the diningSpend to set
	 */
	public void setDiningSpend(Integer diningSpend) {
		this.diningSpend = diningSpend;
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
	 * @return the expCt
	 */
	public String getExpCt() {
		return expCt;
	}
	public String getExpCtPrint() {
		if (expCt == null) return "";
		else return expCt.replace("\r\n", "<br/>");
	}
	/**
	 * @param expCt the expCt to set
	 */
	public void setExpCt(String expCt) {
		this.expCt = expCt;
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
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
