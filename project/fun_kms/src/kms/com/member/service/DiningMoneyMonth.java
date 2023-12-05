package kms.com.member.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class DiningMoneyMonth {
	private String orgnztId;
	private String orgnztNm;
	private String yyyymm;
	private Integer userCnt;
	private Integer money;

	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	private String searchOrgId = "";
	private String searchOrgNm = "";
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
	 * @return the yyyymm
	 */
	public String getYyyymm() {
		return yyyymm;
	}
	public String getMm() {
		return yyyymm.substring(4,6);
	}
	/**
	 * @param yyyymm the yyyymm to set
	 */
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	/**
	 * @return the userCnt
	 */
	public Integer getUserCnt() {
		return userCnt;
	}
	/**
	 * @param userCnt the userCnt to set
	 */
	public void setUserCnt(Integer userCnt) {
		this.userCnt = userCnt;
	}
	/**
	 * @return the money
	 */
	public Integer getMoney() {
		return money;
	}
	public String getMoneyPrint() {
		return CommonUtil.insertComma(money);
	}
	/**
	 * @param money the money to set
	 */
	public void setMoney(Integer money) {
		this.money = money;
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
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
