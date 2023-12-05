package kms.com.management.service;

import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Expense {
	private String accId;
	private String accNm;
	private Long exp01 = 0L;
	private Long exp02 = 0L;
	private Long exp03 = 0L;
	private Long exp04 = 0L;
	private Long exp05 = 0L;
	private Long exp06 = 0L;
	private Long exp07 = 0L;
	private Long exp08 = 0L;
	private Long exp09 = 0L;
	private Long exp10 = 0L;
	private Long exp11 = 0L;
	private Long exp12 = 0L;
	private Long sum = 0L;
	private String prntNm;
	private String expId;
	private String templtId;

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
	 * @return the exp01
	 */
	public Long getExp01() {
		return exp01;
	}
	/**
	 * @param exp01 the exp01 to set
	 */
	public void setExp01(Long exp01) {
		this.exp01 = exp01;
	}
	/**
	 * @return the exp02
	 */
	public Long getExp02() {
		return exp02;
	}
	/**
	 * @param exp02 the exp02 to set
	 */
	public void setExp02(Long exp02) {
		this.exp02 = exp02;
	}
	/**
	 * @return the exp03
	 */
	public Long getExp03() {
		return exp03;
	}
	/**
	 * @param exp03 the exp03 to set
	 */
	public void setExp03(Long exp03) {
		this.exp03 = exp03;
	}
	/**
	 * @return the exp04
	 */
	public Long getExp04() {
		return exp04;
	}
	/**
	 * @param exp04 the exp04 to set
	 */
	public void setExp04(Long exp04) {
		this.exp04 = exp04;
	}
	/**
	 * @return the exp05
	 */
	public Long getExp05() {
		return exp05;
	}
	/**
	 * @param exp05 the exp05 to set
	 */
	public void setExp05(Long exp05) {
		this.exp05 = exp05;
	}
	/**
	 * @return the exp06
	 */
	public Long getExp06() {
		return exp06;
	}
	/**
	 * @param exp06 the exp06 to set
	 */
	public void setExp06(Long exp06) {
		this.exp06 = exp06;
	}
	/**
	 * @return the exp07
	 */
	public Long getExp07() {
		return exp07;
	}
	/**
	 * @param exp07 the exp07 to set
	 */
	public void setExp07(Long exp07) {
		this.exp07 = exp07;
	}
	/**
	 * @return the exp08
	 */
	public Long getExp08() {
		return exp08;
	}
	/**
	 * @param exp08 the exp08 to set
	 */
	public void setExp08(Long exp08) {
		this.exp08 = exp08;
	}
	/**
	 * @return the exp09
	 */
	public Long getExp09() {
		return exp09;
	}
	/**
	 * @param exp09 the exp09 to set
	 */
	public void setExp09(Long exp09) {
		this.exp09 = exp09;
	}
	/**
	 * @return the exp10
	 */
	public Long getExp10() {
		return exp10;
	}
	/**
	 * @param exp10 the exp10 to set
	 */
	public void setExp10(Long exp10) {
		this.exp10 = exp10;
	}
	/**
	 * @return the exp11
	 */
	public Long getExp11() {
		return exp11;
	}
	/**
	 * @param exp11 the exp11 to set
	 */
	public void setExp11(Long exp11) {
		this.exp11 = exp11;
	}
	/**
	 * @return the exp12
	 */
	public Long getExp12() {
		return exp12;
	}
	/**
	 * @param exp12 the exp12 to set
	 */
	public void setExp12(Long exp12) {
		this.exp12 = exp12;
	}
	/**
	 * @return the sum
	 */
	public Long getSum() {
		return sum;
	}
	/**
	 * @param sum the sum to set
	 */
	public void setSum(Long sum) {
		this.sum = sum;
	}
	public String getExp01Print() {
		return CommonUtil.insertCommaDivideBy(exp01, 1000);
	}
	public String getExp02Print() {
		return CommonUtil.insertCommaDivideBy(exp02, 1000);
	}
	public String getExp03Print() {
		return CommonUtil.insertCommaDivideBy(exp03, 1000);
	}
	public String getExp04Print() {
		return CommonUtil.insertCommaDivideBy(exp04, 1000);
	}
	public String getExp05Print() {
		return CommonUtil.insertCommaDivideBy(exp05, 1000);
	}
	public String getExp06Print() {
		return CommonUtil.insertCommaDivideBy(exp06, 1000);
	}
	public String getExp07Print() {
		return CommonUtil.insertCommaDivideBy(exp07, 1000);
	}
	public String getExp08Print() {
		return CommonUtil.insertCommaDivideBy(exp08, 1000);
	}
	public String getExp09Print() {
		return CommonUtil.insertCommaDivideBy(exp09, 1000);
	}
	public String getExp10Print() {
		return CommonUtil.insertCommaDivideBy(exp10, 1000);
	}
	public String getExp11Print() {
		return CommonUtil.insertCommaDivideBy(exp11, 1000);
	}
	public String getExp12Print() {
		return CommonUtil.insertCommaDivideBy(exp12, 1000);
	}
	public String getSumPrint() {
		return CommonUtil.insertCommaDivideBy(sum, 1000);
	}
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setExpId(String expId) {
		this.expId = expId;
	}
	public String getExpId() {
		return expId;
	}
	public void setTempltId(String templtId) {
		this.templtId = templtId;
	}
	public String getTempltId() {
		return templtId;
	}
}
