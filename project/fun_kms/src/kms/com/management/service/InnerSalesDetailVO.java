package kms.com.management.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CommonUtil;

public class InnerSalesDetailVO {
	private String docId;
	private String templtId;
	private String templtNm;
	private String subject;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String docDt;
	private String salesPrjId;
	private String salesPrjCd;
	private String salesPrjNm;
	private String purchasePrjId;
	private String purchasePrjCd;
	private String purchasePrjNm;
	private Integer cost;
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
	 * @return the templtId
	 */
	public String getTempltId() {
		return templtId;
	}
	/**
	 * @param templtId the templtId to set
	 */
	public void setTempltId(String templtId) {
		this.templtId = templtId;
	}
	/**
	 * @return the templtNm
	 */
	public String getTempltNm() {
		return templtNm;
	}
	/**
	 * @param templtNm the templtNm to set
	 */
	public void setTempltNm(String templtNm) {
		this.templtNm = templtNm;
	}
	/**
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}
	/**
	 * @param subject the subject to set
	 */
	public void setSubject(String subject) {
		this.subject = subject;
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
	 * @return the docDt
	 */
	public String getDocDt() {
		return docDt;
	}
	/**
	 * @param docDt the docDt to set
	 */
	public void setDocDt(String docDt) {
		this.docDt = docDt;
	}
	/**
	 * @return the salesPrjId
	 */
	public String getSalesPrjId() {
		return salesPrjId;
	}
	/**
	 * @param salesPrjId the salesPrjId to set
	 */
	public void setSalesPrjId(String salesPrjId) {
		this.salesPrjId = salesPrjId;
	}
	/**
	 * @return the salesPrjCd
	 */
	public String getSalesPrjCd() {
		return salesPrjCd;
	}
	/**
	 * @param salesPrjCd the salesPrjCd to set
	 */
	public void setSalesPrjCd(String salesPrjCd) {
		this.salesPrjCd = salesPrjCd;
	}
	/**
	 * @return the salesPrjNm
	 */
	public String getSalesPrjNm() {
		return salesPrjNm;
	}
	/**
	 * @param salesPrjNm the salesPrjNm to set
	 */
	public void setSalesPrjNm(String salesPrjNm) {
		this.salesPrjNm = salesPrjNm;
	}
	/**
	 * @return the purchasePrjId
	 */
	public String getPurchasePrjId() {
		return purchasePrjId;
	}
	/**
	 * @param purchasePrjId the purchasePrjId to set
	 */
	public void setPurchasePrjId(String purchasePrjId) {
		this.purchasePrjId = purchasePrjId;
	}
	/**
	 * @return the purchasePrjCd
	 */
	public String getPurchasePrjCd() {
		return purchasePrjCd;
	}
	/**
	 * @param purchasePrjCd the purchasePrjCd to set
	 */
	public void setPurchasePrjCd(String purchasePrjCd) {
		this.purchasePrjCd = purchasePrjCd;
	}
	/**
	 * @return the purchasePrjNm
	 */
	public String getPurchasePrjNm() {
		return purchasePrjNm;
	}
	/**
	 * @param purchasePrjNm the purchasePrjNm to set
	 */
	public void setPurchasePrjNm(String purchasePrjNm) {
		this.purchasePrjNm = purchasePrjNm;
	}
	/**
	 * @return the cost
	 */
	public Integer getCost() {
		return cost;
	}
	public String getCostPrint() {
		return CommonUtil.insertCommaDivideBy(cost, 1000);
	}
	/**
	 * @param cost the cost to set
	 */
	public void setCost(Integer cost) {
		this.cost = cost;
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
