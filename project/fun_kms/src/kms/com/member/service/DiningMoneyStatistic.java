package kms.com.member.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class DiningMoneyStatistic {
	private String orgnztId;
	private String orgnztNm;
	private Integer dineMoney;
	private Integer dineMoneyAdd;
	private Integer dineMoneyFull;
	private Integer dineMoneyUse;

	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String[] searchOrgIdList;
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
	 * @return the dineMoney
	 */
	public Integer getDineMoney() {
		return dineMoney;
	}
	public String getDineMoneyPrint() {
		return CommonUtil.insertComma(dineMoney);
	}
	/**
	 * @param dineMoney the dineMoney to set
	 */
	public void setDineMoney(Integer dineMoney) {
		this.dineMoney = dineMoney;
	}
	/**
	 * @return the dineMoneyAdd
	 */
	public Integer getDineMoneyAdd() {
		return dineMoneyAdd;
	}
	public String getDineMoneyAddPrint() {
		return CommonUtil.insertComma(dineMoneyAdd);
	}
	/**
	 * @param dineMoneyAdd the dineMoneyAdd to set
	 */
	public void setDineMoneyAdd(Integer dineMoneyAdd) {
		this.dineMoneyAdd = dineMoneyAdd;
	}
	/**
	 * @return the dineMoneyFull
	 */
	public Integer getDineMoneyFull() {
		return dineMoneyFull;
	}
	public String getDineMoneyFullPrint() {
		return CommonUtil.insertComma(dineMoneyFull);
	}
	/**
	 * @param dineMoneyFull the dineMoneyFull to set
	 */
	public void setDineMoneyFull(Integer dineMoneyFull) {
		this.dineMoneyFull = dineMoneyFull;
	}
	/**
	 * @return the dineMoneyUse
	 */
	public Integer getDineMoneyUse() {
		return dineMoneyUse;
	}
	public String getDineMoneyUsePrint() {
		return CommonUtil.insertComma(dineMoneyUse);
	}
	/**
	 * @param dineMoneyUse the dineMoneyUse to set
	 */
	public void setDineMoneyUse(Integer dineMoneyUse) {
		this.dineMoneyUse = dineMoneyUse;
	}
	
	public String getDineMoneyLeftPrint() {
		return CommonUtil.insertComma(dineMoney + dineMoneyAdd - dineMoneyUse);
	}
	public String getDineMoneyExpectLeftPrint() {
		return CommonUtil.insertComma(dineMoneyFull + dineMoneyAdd - dineMoneyUse);
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
