package kms.com.support.service;

import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class CarFixVO {
	private Integer no;
	private String carId;
	private String fixDate;
	private Integer userNo;
	private String userNm;
	private String userId;
	private Integer runLength;
	private String fixItem;
	private String fixItemDetail;
	private String fixNote;
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
	 * @return the carId
	 */
	public String getCarId() {
		return carId;
	}
	/**
	 * @param carId the carId to set
	 */
	public void setCarId(String carId) {
		this.carId = carId;
	}
	/**
	 * @return the fixDate
	 */
	public String getFixDate() {
		return fixDate;
	}
	/**
	 * @param fixDate the fixDate to set
	 */
	public void setFixDate(String fixDate) {
		this.fixDate = fixDate;
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
	 * @return the runLength
	 */
	public Integer getRunLength() {
		return runLength;
	}
	public String getRunLengthPrint() {
		return CommonUtil.insertComma(runLength);
	}
	/**
	 * @param runLength the runLength to set
	 */
	public void setRunLength(Integer runLength) {
		this.runLength = runLength;
	}
	/**
	 * @return the fixItem
	 */
	public String getFixItem() {
		return fixItem;
	}
	/**
	 * @param fixItem the fixItem to set
	 */
	public void setFixItem(String fixItem) {
		this.fixItem = fixItem;
	}
	/**
	 * @return the fixItemDetail
	 */
	public String getFixItemDetail() {
		return fixItemDetail;
	}
	public String getFixItemDetailPrint() {
		if (fixItemDetail == null) return "";
		else return fixItemDetail.replace("\r\n", "<br/>");
	}
	/**
	 * @param fixItemDetail the fixItemDetail to set
	 */
	public void setFixItemDetail(String fixItemDetail) {
		this.fixItemDetail = fixItemDetail;
	}
	/**
	 * @return the fixNote
	 */
	public String getFixNote() {
		return fixNote;
	}
	public String getFixNotePrint() {
		if (fixNote == null) return "";
		else return fixNote.replace("\r\n", "<br/>");
	}
	/**
	 * @param fixNote the fixNote to set
	 */
	public void setFixNote(String fixNote) {
		this.fixNote = fixNote;
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
