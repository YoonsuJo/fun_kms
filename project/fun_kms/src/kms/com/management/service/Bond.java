package kms.com.management.service;

import kms.com.common.utils.CommonUtil;

public class Bond {
	
	String bondId = "";
	String publishDate = "";
	String custNm = "";
	String orgnztNm = "";
	String orgnztId = "";
	String prjNm = "";
	String prjId = "";
	String prjCd = "";
	String prjStat = "";	
	String companyNm = "";
	int bondPrjNo = 0;
	long sumExpense = 0;
	long sumWillCollect = 0;
	long sumCollection = 0;
	long sumSales = 0;
	long accSumExpense = 0;
	long accSumWillCollect = 0;
	long accSumCollection = 0;
	long accSumSales = 0;
	int bondColNo = 0;
	
	String collectionDate = "";
	long expense = 0;
	String note = "";
	String useAt = "";
	
	private String docId = "";
	private int regUserNo;
	private String bondSalesCnt;
	
	public String getBondId() {
		return bondId;
	}
	public void setBondId(String bondId) {
		this.bondId = bondId;
	}
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getOrgnztNm() {
		return orgnztNm;
	}
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	public String getOrgnztId() {
		return orgnztId;
	}
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public String getPrjCd() {
		return prjCd;
	}
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	public String getCompanyNm() {
		return companyNm;
	}
	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}
	public int getBondPrjNo() {
		return bondPrjNo;
	}
	public void setBondPrjNo(int bondPrjNo) {
		this.bondPrjNo = bondPrjNo;
	}
	public long getSumExpense() {
		return sumExpense;
	}
	public void setSumExpense(long sumExpense) {
		this.sumExpense = sumExpense;
	}
	public long getSumCollection() {
		return sumCollection;
	}
	public void setSumCollection(long sumCollection) {
		this.sumCollection = sumCollection;
	}
	/*미수금액*/
	public long getNoCollection() {
		return getSumWillCollect() - getSumCollection();
	}
	public long getSumSales() {
		return sumSales;
	}
	public void setSumSales(long sumSales) {
		this.sumSales = sumSales;
	}
	/*계산서 미발행금액*/
	public long getNoPublish() {
		return getSumSales() - getSumExpense();
	}
	public long getAccSumCollection() {
		return accSumCollection;
	}
	public void setAccSumCollection(long accSumCollection) {
		this.accSumCollection = accSumCollection;
	}
	public long getAccSumExpense() {
		return accSumExpense;
	}
	public void setAccSumExpense(long accSumExpense) {
		this.accSumExpense = accSumExpense;
	}
	public long getAccSumSales() {
		return accSumSales;
	}
	/*누적 계산서 미발행금액*/
	public long getAccNoPublish() {
		return getAccSumSales() - getAccSumExpense();
	}
	public void setAccSumSales(long accSumSales) {
		this.accSumSales = accSumSales;
	}
	/*전체누적 미수금액*/
	public long getAccNoCollection() {
		return getAccSumWillCollect() - getAccSumCollection();
	}
	public int getBondColNo() {
		return bondColNo;
	}
	public void setBondColNo(int bondColNo) {
		this.bondColNo = bondColNo;
	}
	public String getCollectionDate() {
		return collectionDate;
	}
	public void setCollectionDate(String collectionDate) {
		this.collectionDate = collectionDate;
	}
	public long getExpense() {
		return expense;
	}
	public void setExpense(long expense) {
		this.expense = expense;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getUseAt() {
		return useAt;
	}
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	/**
	 * @return the sumWillCollect
	 */
	public long getSumWillCollect() {
		return sumWillCollect;
	}
	/**
	 * @param sumWillCollect the sumWillCollect to set
	 */
	public void setSumWillCollect(long sumWillCollect) {
		this.sumWillCollect = sumWillCollect;
	}
	/**
	 * @return the accSumWillCollect
	 */
	public long getAccSumWillCollect() {
		return accSumWillCollect;
	}
	/**
	 * @param accSumWillCollect the accSumWillCollect to set
	 */
	public void setAccSumWillCollect(long accSumWillCollect) {
		this.accSumWillCollect = accSumWillCollect;
	}
	public void setPrjStat(String prjStat) {
		this.prjStat = prjStat;
	}
	public String getPrjStat() {
		return prjStat;
	}
	public String getDocId() {
		return docId;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public int getRegUserNo() {
		return regUserNo;
	}
	public void setRegUserNo(int regUserNo) {
		this.regUserNo = regUserNo;
	}
	public String getBondSalesCnt() {
		return bondSalesCnt;
	}
	public void setBondSalesCnt(String bondSalesCnt) {
		this.bondSalesCnt = bondSalesCnt;
	}
}
