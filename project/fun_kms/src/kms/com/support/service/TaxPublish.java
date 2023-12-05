package kms.com.support.service;

import java.io.Serializable;


/**
 * @Class Name : TblCardSpendVO.java
 * @Description : TblCardSpend VO class
 * @Modification Information
 *
 * @author 장기호
 * @since 2012.02.13
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class TaxPublish implements Serializable{
    private static final long serialVersionUID = 1L;
    
    String bondId = "";
    String bondSj = "";
    String bondCn = "";
    String companyCd = "";
    String companyNm = "";
    String custNm = "";
    String custBusiNo = "";
    String custAdres = "";
    String custRepNm = "";
    String custBusiCond = "";
    String custBusiTyp = "";
    String taxEmail1 = "";
    String taxUserNm1 = "";
    String taxUserTelNo1 = "";
    String taxEmail2 = "";
    String taxUserNm2 = "";
    String taxUserTelNo2 = "";
    String taxEmail3 = "";
    String taxUserNm3 = "";
    String taxUserTelNo3 = "";
    String taxEmail4 = "";
    String taxUserNm4 = "";
    String taxUserTelNo4 = "";
    String taxEmail5 = "";
    String taxUserNm5 = "";
    String taxUserTelNo5 = "";
    String publishDate = "";
    String bondTyp = "";
    String writeDate = "";
    String bondStat = "";
    int writerNo = 0;
    String fnshTime = "";
    int fnshUserNo = 0;
    String useAt = "";
    
    int no = 0;
    int expenseNo = 0;
    long expense = 0;
    String note = "";
    String containVat = "";
    
    int prjNo = 0;
    String prjId = "";
    String prjNm = "";
    String prjCd = "";
    long prjExpense = 0;
    
    int userNo = 0;
    String userNm = "";
    String userId = "";
    long expSum = 0;
    
    String fnshUserNm = "";
    String fnshUserId = "";
    
    long supSum = 0;
    long taxSum = 0;
    long pubSum = 0;
    
    String repeat = "";
    String publishToDate = "";
    String publishAtDate = "";

    String jsonExpenseString = "";
    String jsonProjectString = "";
    
    String atchFileId = "";
    
    private String zeroTaxRate = "";	// 영세율 구분 추가
    
	public String getBondId() {
		return bondId;
	}
	public void setBondId(String bondId) {
		this.bondId = bondId;
	}
	public String getBondSj() {
		return bondSj;
	}
	public void setBondSj(String bondSj) {
		this.bondSj = bondSj;
	}
	public String getBondCn() {
		return bondCn;
	}
	public void setBondCn(String bondCn) {
		this.bondCn = bondCn;
	}
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getCompanyNm() {
		return companyNm;
	}
	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getCustBusiNo() {
		return custBusiNo;
	}
	public String getCustBusiNoPrint() {
		if (custBusiNo.length() == 10)
			return custBusiNo.substring(0, 3) + '-' + custBusiNo.substring(3, 5) + '-' + custBusiNo.substring(5, 10);
		else
			return getCustBusiNo();
	}
	public void setCustBusiNo(String custBusiNo) {
		this.custBusiNo = custBusiNo;
	}
	public String getCustAdres() {
		return custAdres;
	}
	public void setCustAdres(String custAdres) {
		this.custAdres = custAdres;
	}
	public String getCustRepNm() {
		return custRepNm;
	}
	public void setCustRepNm(String custRepNm) {
		this.custRepNm = custRepNm;
	}
	public String getCustBusiCond() {
		return custBusiCond;
	}
	public void setCustBusiCond(String custBusiCond) {
		this.custBusiCond = custBusiCond;
	}
	public String getCustBusiTyp() {
		return custBusiTyp;
	}
	public void setCustBusiTyp(String custBusiTyp) {
		this.custBusiTyp = custBusiTyp;
	}
	public String getTaxEmail1() {
		return taxEmail1;
	}
	public void setTaxEmail1(String taxEmail1) {
		this.taxEmail1 = taxEmail1;
	}
	public String getTaxUserNm1() {
		return taxUserNm1;
	}
	public void setTaxUserNm1(String taxUserNm1) {
		this.taxUserNm1 = taxUserNm1;
	}
	public String getTaxUserTelNo1() {
		return taxUserTelNo1;
	}
	public void setTaxUserTelNo1(String taxUserTelNo1) {
		this.taxUserTelNo1 = taxUserTelNo1;
	}
	public String getTaxEmail2() {
		return taxEmail2;
	}
	public void setTaxEmail2(String taxEmail2) {
		this.taxEmail2 = taxEmail2;
	}
	public String getTaxUserNm2() {
		return taxUserNm2;
	}
	public void setTaxUserNm2(String taxUserNm2) {
		this.taxUserNm2 = taxUserNm2;
	}
	public String getTaxUserTelNo2() {
		return taxUserTelNo2;
	}
	public void setTaxUserTelNo2(String taxUserTelNo2) {
		this.taxUserTelNo2 = taxUserTelNo2;
	}
	public String getTaxEmail3() {
		return taxEmail3;
	}
	public void setTaxEmail3(String taxEmail3) {
		this.taxEmail3 = taxEmail3;
	}
	public String getTaxUserNm3() {
		return taxUserNm3;
	}
	public void setTaxUserNm3(String taxUserNm3) {
		this.taxUserNm3 = taxUserNm3;
	}
	public String getTaxUserTelNo3() {
		return taxUserTelNo3;
	}
	public void setTaxUserTelNo3(String taxUserTelNo3) {
		this.taxUserTelNo3 = taxUserTelNo3;
	}
	public String getTaxEmail4() {
		return taxEmail4;
	}
	public void setTaxEmail4(String taxEmail4) {
		this.taxEmail4 = taxEmail4;
	}
	public String getTaxUserNm4() {
		return taxUserNm4;
	}
	public void setTaxUserNm4(String taxUserNm4) {
		this.taxUserNm4 = taxUserNm4;
	}
	public String getTaxUserTelNo4() {
		return taxUserTelNo4;
	}
	public void setTaxUserTelNo4(String taxUserTelNo4) {
		this.taxUserTelNo4 = taxUserTelNo4;
	}
	public String getTaxEmail5() {
		return taxEmail5;
	}
	public void setTaxEmail5(String taxEmail5) {
		this.taxEmail5 = taxEmail5;
	}
	public String getTaxUserNm5() {
		return taxUserNm5;
	}
	public void setTaxUserNm5(String taxUserNm5) {
		this.taxUserNm5 = taxUserNm5;
	}
	public String getTaxUserTelNo5() {
		return taxUserTelNo5;
	}
	public void setTaxUserTelNo5(String taxUserTelNo5) {
		this.taxUserTelNo5 = taxUserTelNo5;
	}
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}
	public String getBondTyp() {
		return bondTyp;
	}
	public void setBondTyp(String bondTyp) {
		this.bondTyp = bondTyp;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getBondStat() {
		return bondStat;
	}
	public String getBondStatPrint() {
		if (bondStat == null)
			return "-";
		else if (bondStat.equals("N"))
			return "미발행";
		else if (bondStat.equals("Y"))
			return "발행";
		else if (bondStat.equals("C"))
			return "취소";
		else
			return bondStat;
	}
	public void setBondStat(String bondStat) {
		this.bondStat = bondStat;
	}
	public int getWriterNo() {
		return writerNo;
	}
	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
	}
	public String getFnshTime() {
		return fnshTime;
	}
	public void setFnshTime(String fnshTime) {
		this.fnshTime = fnshTime;
	}
	public int getFnshUserNo() {
		return fnshUserNo;
	}
	public void setFnshUserNo(int fnshUserNo) {
		this.fnshUserNo = fnshUserNo;
	}
	public String getUseAt() {
		return useAt;
	}
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getExpenseNo() {
		return expenseNo;
	}
	public void setExpenseNo(int expenseNo) {
		this.expenseNo = expenseNo;
	}
	public long getExpense() {
		return expense;
	}
	public long getSupplyExpense() {
		if ("Y".equals(zeroTaxRate)) {	// 영세율 O
			return expense;
		} else if (containVat == null || containVat.length() == 0 || containVat.equals("N"))
			return expense;
		else if (containVat.equals("Y"))
			return (long) expense - Math.round(expense / 11D);
		else
			return (long) expense - Math.round(expense / 11D);
	}
	public long getTaxExpense() {
		if ("Y".equals(zeroTaxRate)) {	// 영세율 O
			return 0;
		} else if (containVat == null || containVat.length() == 0 || containVat.equals("N"))
			return (long) Math.round(expense / 10D);
		else if (containVat.equals("Y"))
			return (long) Math.round(expense / 11D);
		else
			return (long) Math.round(expense / 11D);
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
	public String getContainVat() {
		return containVat;
	}
	public void setContainVat(String containVat) {
		this.containVat = containVat;
	}
	public int getPrjNo() {
		return prjNo;
	}
	public void setPrjNo(int prjNo) {
		this.prjNo = prjNo;
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getPrjCd() {
		return prjCd;
	}
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	public long getPrjExpense() {
		return prjExpense;
	}
	public void setPrjExpense(long prjExpense) {
		this.prjExpense = prjExpense;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public long getExpSum() {
		return expSum;
	}
	public void setExpSum(long expSum) {
		this.expSum = expSum;
	}
	public String getFnshUserNm() {
		return fnshUserNm;
	}
	public void setFnshUserNm(String fnshUserNm) {
		this.fnshUserNm = fnshUserNm;
	}
	public String getFnshUserId() {
		return fnshUserId;
	}
	public void setFnshUserId(String fnshUserId) {
		this.fnshUserId = fnshUserId;
	}
	public long getSupSum() {
		return supSum;
	}
	public void setSupSum(long supSum) {
		this.supSum = supSum;
	}
	public long getTaxSum() {
		return taxSum;
	}
	public void setTaxSum(long taxSum) {
		this.taxSum = taxSum;
	}
	public long getPubSum() {
		return pubSum;
	}
	public void setPubSum(long pubSum) {
		this.pubSum = pubSum;
	}
	public String getRepeat() {
		return repeat;
	}
	public void setRepeat(String repeat) {
		this.repeat = repeat;
	}
	public String getPublishToDate() {
		return publishToDate;
	}
	public void setPublishToDate(String publishToDate) {
		this.publishToDate = publishToDate;
	}
	public String getPublishAtDate() {
		return publishAtDate;
	}
	public void setPublishAtDate(String publishAtDate) {
		this.publishAtDate = publishAtDate;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getJsonExpenseString() {
		return jsonExpenseString;
	}
	public void setJsonExpenseString(String jsonExpenseString) {
		this.jsonExpenseString = jsonExpenseString;
	}
	public String getJsonProjectString() {
		return jsonProjectString;
	}
	public void setJsonProjectString(String jsonProjectString) {
		this.jsonProjectString = jsonProjectString;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getZeroTaxRate() {
		return zeroTaxRate;
	}
	public void setZeroTaxRate(String zeroTaxRate) {
		this.zeroTaxRate = zeroTaxRate;
	}
}
