package kms.com.member.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class DiningMoneyAdd {
	private Integer no;
	private String orgnztId;
	private String yyyymm;
	private Integer money;
	private String note;

	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	private String searchOrgId = "";
	/**
	 * @return the no
	 */
	public Integer getNo() {
		return no;
	}
	/**
	 * @param no the no to set
	 */
	public void setNo(Integer no) {
		this.no = no;
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
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
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
