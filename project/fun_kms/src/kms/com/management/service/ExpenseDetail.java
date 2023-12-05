package kms.com.management.service;

import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ExpenseDetail {

	private String docId;
	private String accId;
	private String accNm;
	private String prjId;
	private String prjCd;
	private String prjNm;
	private String companyCd;
	private String userNo;
	private String userNm;
	private String userId;
	private String expDt;
	private Integer expSpend;
	private String expSpendTyp;
	private String cardId;
	private String expCt;
	private String prntNm;
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
	 * @return the accId
	 */
	public String getAccId() {
		return accId;
	}
	/**
	 * @param accId the accId to set
	 */
	public void setAccId(String accId) {
		this.accId = accId;
	}
	/**
	 * @return the accNm
	 */
	public String getAccNm() {
		return accNm;
	}
	/**
	 * @param accNm the accNm to set
	 */
	public void setAccNm(String accNm) {
		this.accNm = accNm;
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
	 * @return the companyCd
	 */
	public String getCompanyCd() {
		return companyCd;
	}
	/**
	 * @param companyCd the companyCd to set
	 */
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	/**
	 * @return the userNo
	 */
	public String getUserNo() {
		return userNo;
	}
	/**
	 * @param userNo the userNo to set
	 */
	public void setUserNo(String userNo) {
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
	 * @return the expDt
	 */
	public String getExpDt() {
		return expDt;
	}
	public String getExpDtPrint() {
		return CommonUtil.getDateType(expDt);
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
	 * @return the expSpendTyp
	 */
	public String getExpSpendTyp() {
		return expSpendTyp;
	}
	public String getExpSpendTypPrint() {
		if (expSpendTyp == null) return "";
		//PP - 개인결제 CP - 회사결제 CC - 법인카드 KK - 체크카드
		if (expSpendTyp.equals("PP")) return "개인결제";
		else if (expSpendTyp.equals("KK")) return "체크카드";
		else if (expSpendTyp.equals("CP")) return "회사결제";
		else if (expSpendTyp.equals("CC")) return "법인카드" + "<br/>" + cardId;
		else if (expSpendTyp.equals("HW")) return "-";
		else return expSpendTyp;
	}
	/**
	 * @param expSpendTyp the expSpendTyp to set
	 */
	public void setExpSpendTyp(String expSpendTyp) {
		this.expSpendTyp = expSpendTyp;
	}
	/**
	 * @return the cardId
	 */
	public String getCardId() {
		return cardId;
	}
	/**
	 * @param cardId the cardId to set
	 */
	public void setCardId(String cardId) {
		this.cardId = cardId;
	}
	/**
	 * @return the expCt
	 */
	public String getExpCt() {
		return expCt;
	}
	public String getExpCtPrint() {
		if (expCt == null) return "";
		return expCt.replace("\r\n", "<br/>").replace("\n", "<br/>");
	}
	/**
	 * @param expCt the expCt to set
	 */
	public void setExpCt(String expCt) {
		this.expCt = expCt;
	}
	/**
	 * @return the prntNm
	 */
	public String getPrntNm() {
		return prntNm;
	}
	/**
	 * @param prntNm the prntNm to set
	 */
	public void setPrntNm(String prntNm) {
		this.prntNm = prntNm;
	}
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
