package kms.com.support.service;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class CarReservation {
	private String no;
	private String carId;
	private String carTyp;
	private String imgFileId;
	private Integer userNo;
	private String userNm;
	private String userId;
	private Integer writerNo;
	private String writerNm;
	private String writerId;
	private String stDt;
	private Integer stTm;
	private String edDt;
	private Integer edTm;
	private String purpose;
	private String destination;
	private String runLength;
	private String rsvNote;
	
	private String searchDate = CalendarUtil.getToday();
	/**
	 * @return the no
	 */
	public String getNo() {
		return no;
	}
	/**
	 * @param no the no to set
	 */
	public void setNo(String no) {
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
	 * @return the carTyp
	 */
	public String getCarTyp() {
		return carTyp;
	}
	/**
	 * @param carTyp the carTyp to set
	 */
	public void setCarTyp(String carTyp) {
		this.carTyp = carTyp;
	}
	/**
	 * @return the imgFileId
	 */
	public String getImgFileId() {
		return imgFileId;
	}
	/**
	 * @param imgFileId the imgFileId to set
	 */
	public void setImgFileId(String imgFileId) {
		this.imgFileId = imgFileId;
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
	 * @return the writerNo
	 */
	public Integer getWriterNo() {
		return writerNo;
	}
	/**
	 * @param writerNo the writerNo to set
	 */
	public void setWriterNo(Integer writerNo) {
		this.writerNo = writerNo;
	}
	/**
	 * @return the writerNm
	 */
	public String getWriterNm() {
		return writerNm;
	}
	/**
	 * @param writerNm the writerNm to set
	 */
	public void setWriterNm(String writerNm) {
		this.writerNm = writerNm;
	}
	/**
	 * @return the writerId
	 */
	public String getWriterId() {
		return writerId;
	}
	/**
	 * @param writerId the writerId to set
	 */
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	/**
	 * @return the stDt
	 */
	public String getStDt() {
		return stDt;
	}
	public String getStDtPrint() {
		return CommonUtil.getDateType(stDt);
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
	public Integer getStTm() {
		return stTm;
	}
	/**
	 * @param stTm the stTm to set
	 */
	public void setStTm(Integer stTm) {
		this.stTm = stTm;
	}
	/**
	 * @return the edDt
	 */
	public String getEdDt() {
		return edDt;
	}
	public String getEdDtPrint() {
		return CommonUtil.getDateType(edDt);
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
	public Integer getEdTm() {
		return edTm;
	}
	/**
	 * @param edTm the edTm to set
	 */
	public void setEdTm(Integer edTm) {
		this.edTm = edTm;
	}
	/**
	 * @return the purpose
	 */
	public String getPurpose() {
		return purpose;
	}
	public String getPurposePrint() {
		if (purpose == null || purpose.equals("")) return "업무용";
		
		if (purpose.equals("W")) return "업무용";
		else if (purpose.equals("P")) return "개인사용";
		else return purpose;
	}
	/**
	 * @param purpose the purpose to set
	 */
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	/**
	 * @return the destination
	 */
	public String getDestination() {
		return destination;
	}
	/**
	 * @param destination the destination to set
	 */
	public void setDestination(String destination) {
		this.destination = destination;
	}
	/**
	 * @return the runLength
	 */
	public String getRunLength() {
		return runLength;
	}
	/**
	 * @param runLength the runLength to set
	 */
	public void setRunLength(String runLength) {
		this.runLength = runLength;
	}
	/**
	 * @return the rsvNote
	 */
	public String getRsvNote() {
		return rsvNote;
	}
	public String getRsvNotePrint() {
		if (rsvNote == null) return "";
		else return rsvNote.replace("\r\n", "<br/>");
	}
	/**
	 * @param rsvNote the rsvNote to set
	 */
	public void setRsvNote(String rsvNote) {
		this.rsvNote = rsvNote;
	}
	/**
	 * @return the searchDate
	 */
	public String getSearchDate() {
		return searchDate;
	}
	public String getSearchDatePrint() {
		return CommonUtil.getDateType(searchDate);
	}
	/**
	 * @param searchDate the searchDate to set
	 */
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
