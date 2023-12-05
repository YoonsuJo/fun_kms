package kms.com.member.service;

import org.apache.commons.lang.builder.ToStringBuilder;

public class HolidayWorkDetail {
	private Integer userNo;
	private String userNm;
	private String userId;
	private String stDt;
	private String stTm;
	private String edDt;
	private String edTm;
	private Double period;
	private String prjId;
	private String prjCd;
	private String prjNm;
	private String content;
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
	 * @return the stDt
	 */
	public String getStDt() {
		return stDt;
	}
	/**
	 * @param stDt the stDt to set
	 */
	public void setStDt(String stDt) {
		this.stDt = stDt;
	}
	/**
	 * @return the stTm
	 */
	public String getStTm() {
		return stTm;
	}
	/**
	 * @param stTm the stTm to set
	 */
	public void setStTm(String stTm) {
		this.stTm = stTm;
	}
	/**
	 * @return the edDt
	 */
	public String getEdDt() {
		return edDt;
	}
	/**
	 * @param edDt the edDt to set
	 */
	public void setEdDt(String edDt) {
		this.edDt = edDt;
	}
	/**
	 * @return the edTm
	 */
	public String getEdTm() {
		return edTm;
	}
	/**
	 * @param edTm the edTm to set
	 */
	public void setEdTm(String edTm) {
		this.edTm = edTm;
	}
	/**
	 * @return the period
	 */
	public Double getPeriod() {
		return period;
	}
	/**
	 * @param period the period to set
	 */
	public void setPeriod(Double period) {
		this.period = period;
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
	 * @return the content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}
