package kms.com.member.service;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class SelfDevDetail {
	private Integer userNo;
	private String expDt;
	private Integer expSpend;
	private String expCt;
	private String docId;
	private String searchYear = CalendarUtil.getToday().substring(0,4);
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
	 * @return the expSpend
	 */
	public Integer getExpSpend() {
		return expSpend;
	}
	public String getExpSpendPrint() {
		return CommonUtil.insertComma(expSpend);
	}
	/**
	 * @param expSpend the expSpend to set
	 */
	public void setExpSpend(Integer expSpend) {
		this.expSpend = expSpend;
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
	 * @return the docId
	 */
	public String getDocId() {
		return docId;
	}
	/**
	 * @param docId the docId to set
	 */
	public void setDocId(String docId) {
		this.docId = docId;
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
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
