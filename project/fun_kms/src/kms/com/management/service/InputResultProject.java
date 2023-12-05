package kms.com.management.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class InputResultProject {
	private String orgnztId;
	private String orgnztNm;
	private String prjId;
	private String prjCd;
	private String prjNm;
	private Integer prjLvl;
	private Integer drTm;
	private Integer drSalary;
	private Double holTm;
	private Integer holSalary;
	private String orgnztUpNm;	// 20140716 소계를 위한 상위부서명 추가
	
	private String searchDate = CalendarUtil.getToday();
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
	 * @return the prjId
	 */
	public String getPrjId() {
		return prjId;
	}
	/**
	 * @param prjId the prjId to set
	 */
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	/**
	 * @return the prjCd
	 */
	public String getPrjCd() {
		return prjCd;
	}
	/**
	 * @param prjCd the prjCd to set
	 */
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	/**
	 * @return the prjNm
	 */
	public String getPrjNm() {
		return prjNm;
	}
	/**
	 * @param prjNm the prjNm to set
	 */
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	/**
	 * @return the prjLvl
	 */
	public Integer getPrjLvl() {
		return prjLvl;
	}
	/**
	 * @param prjLvl the prjLvl to set
	 */
	public void setPrjLvl(Integer prjLvl) {
		this.prjLvl = prjLvl;
	}
	/**
	 * @return the drTm
	 */
	public Integer getDrTm() {
		return drTm;
	}
	/**
	 * @param drTm the drTm to set
	 */
	public void setDrTm(Integer drTm) {
		this.drTm = drTm;
	}
	/**
	 * @return the drSalary
	 */
	public Integer getDrSalary() {
		return drSalary;
	}
	public String getDrSalaryPrint() {
		return CommonUtil.insertComma(drSalary);
	}
	/**
	 * @param drSalary the drSalary to set
	 */
	public void setDrSalary(Integer drSalary) {
		this.drSalary = drSalary;
	}
	/**
	 * @return the holTm
	 */
	public Double getHolTm() {
		return holTm;
	}
	/**
	 * @param holTm the holTm to set
	 */
	public void setHolTm(Double holTm) {
		this.holTm = holTm;
	}
	/**
	 * @return the holSalary
	 */
	public Integer getHolSalary() {
		return holSalary;
	}
	public String getHolSalaryPrint() {
		return CommonUtil.insertComma(holSalary);
	}
	/**
	 * @param holSalary the holSalary to set
	 */
	public void setHolSalary(Integer holSalary) {
		this.holSalary = holSalary;
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
	public String getOrgnztUpNm() {
		return orgnztUpNm;
	}
	public void setOrgnztUpNm(String orgnztUpNm) {
		this.orgnztUpNm = orgnztUpNm;
	}
}
