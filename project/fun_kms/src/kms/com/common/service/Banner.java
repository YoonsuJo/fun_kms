package kms.com.common.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

@SuppressWarnings("serial")
public class Banner implements Serializable {

	private String bnrId;
	
	private String bnrFileId;
	
	private String bnrSj;
	
	private String ntceSdt;

	private String ntceEdt;
	
	private String useAt;
	
	private String regDt;

	private String linkUrl;
	
	private String popYn;
	
	private String bnrCn;
	
	private String popWidth;
	
	private String popHeight;
	
	private String ordNo;
	
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	/**
	 * @return the bnrId
	 */
	public String getBnrId() {
		return bnrId;
	}
	/**
	 * @param bnrId the bnrId to set
	 */
	public void setBnrId(String bnrId) {
		this.bnrId = bnrId;
	}
	/**
	 * @return the bnrFileId
	 */
	public String getBnrFileId() {
		return bnrFileId;
	}
	/**
	 * @param bnrFileId the bnrFileId to set
	 */
	public void setBnrFileId(String bnrFileId) {
		this.bnrFileId = bnrFileId;
	}
	/**
	 * @return the bnrSj
	 */
	public String getBnrSj() {
		return bnrSj;
	}
	/**
	 * @param bnrSj the bnrSj to set
	 */
	public void setBnrSj(String bnrSj) {
		this.bnrSj = bnrSj;
	}
	/**
	 * @return the ntceSdt
	 */
	public String getNtceSdt() {
		return ntceSdt;
	}
	/**
	 * @param ntceSdt the ntceSdt to set
	 */
	public void setNtceSdt(String ntceSdt) {
		this.ntceSdt = ntceSdt;
	}
	/**
	 * @return the ntceEdt
	 */
	public String getNtceEdt() {
		return ntceEdt;
	}
	/**
	 * @param ntceEdt the ntceEdt to set
	 */
	public void setNtceEdt(String ntceEdt) {
		this.ntceEdt = ntceEdt;
	}
	/**
	 * @return the useAt
	 */
	public String getUseAt() {
		return useAt;
	}
	/**
	 * @param useAt the useAt to set
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	/**
	 * @return the regDt
	 */
	public String getRegDt() {
		return regDt;
	}
	/**
	 * @param regDt the regDt to set
	 */
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	/**
	 * @return the linkUrl
	 */
	public String getLinkUrl() {
		return linkUrl;
	}
	/**
	 * @param linkUrl the linkUrl to set
	 */
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	/**
	 * @return the popYn
	 */
	public String getPopYn() {
		return popYn;
	}
	/**
	 * @param popYn the popYn to set
	 */
	public void setPopYn(String popYn) {
		this.popYn = popYn;
	}
	/**
	 * @return the bnrCn
	 */
	public String getBnrCn() {
		return bnrCn;
	}
	/**
	 * @param bnrCn the bnrCn to set
	 */
	public void setBnrCn(String bnrCn) {
		this.bnrCn = bnrCn;
	}
	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
	/**
	 * @return the popWidth
	 */
	public String getPopWidth() {
		return popWidth;
	}
	/**
	 * @param popWidth the popWidth to set
	 */
	public void setPopWidth(String popWidth) {
		this.popWidth = popWidth;
	}
	/**
	 * @return the popHeight
	 */
	public String getPopHeight() {
		return popHeight;
	}
	/**
	 * @param popHeight the popHeight to set
	 */
	public void setPopHeight(String popHeight) {
		this.popHeight = popHeight;
	}

}
