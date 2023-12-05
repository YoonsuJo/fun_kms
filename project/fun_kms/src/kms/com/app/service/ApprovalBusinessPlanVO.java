package kms.com.app.service;

public class ApprovalBusinessPlanVO {
	//문서번호
	private String docId;
	private String orgnztId;
	private String orgnztNm;
	private int year;
	private int month;	
	private String yyyymm;	
	private long salesOut;
	private long salesIn;
	private long purchaseOut;
	private long purchaseIn;
	private long labor;
	private long expense;
	
	private long purchaseInCommon;
	///list 는 form 에서 값을 얻어오기 위해서만 사용.
	private long[] salesOutList = new long[12];
	private long[] salesInList = new long[12];
	private long[] purchaseOutList= new long[12];
	private long[] purchaseInList= new long[12];
	private long[] laborList= new long[12];
	private long[] expenseList= new long[12];
	private long[] purchaseInCommonList= new long[12];
	private String salesPrjId;
	private String salesPrjNm;
	private String salesPrjCd;
	private String purchasePrjId;
	private String purchasePrjNm;
	private String purchasePrjCd;
	public String getDocId() {
		return docId;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public String getOrgnztId() {
		return orgnztId;
	}
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	public String getOrgnztNm() {
		return orgnztNm;
	}
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	
	public void setPurchaseInCommonList(long purchaseInCommon, int i) {
		this.purchaseInCommonList[i] = purchaseInCommon;
	}
	public void setSalesPrjId(String salesPrjId) {
		this.salesPrjId = salesPrjId;
	}
	public String getSalesPrjId() {
		return salesPrjId;
	}
	public void setSalesPrjNm(String salesPrjNm) {
		this.salesPrjNm = salesPrjNm;
	}
	public String getSalesPrjNm() {
		return salesPrjNm;
	}
	public void setSalesPrjCd(String salesPrjCd) {
		this.salesPrjCd = salesPrjCd;
	}
	public String getSalesPrjCd() {
		return salesPrjCd;
	}
	public void setPurchasePrjNm(String purchasePrjNm) {
		this.purchasePrjNm = purchasePrjNm;
	}
	public String getPurchasePrjNm() {
		return purchasePrjNm;
	}
	public void setPurchasePrjCd(String purchasePrjCd) {
		this.purchasePrjCd = purchasePrjCd;
	}
	public String getPurchasePrjCd() {
		return purchasePrjCd;
	}
	public void setPurchasePrjId(String purchasePrjId) {
		this.purchasePrjId = purchasePrjId;
	}
	public String getPurchasePrjId() {
		return purchasePrjId;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getYyyymm() {
		return yyyymm;
	}
	
///view 단 통계처리를 위해.
	
	
	
	public void setSalesOutList(long[] salesOutList) {
		this.salesOutList = salesOutList;
	}
	public long[] getSalesOutList() {
		return salesOutList;
	}
	public void setSalesInList(long[] salesInList) {
		this.salesInList = salesInList;
	}
	public long[] getSalesInList() {
		return salesInList;
	}
	public void setPurchaseOutList(long[] purchaseOutList) {
		this.purchaseOutList = purchaseOutList;
	}
	public long[] getPurchaseOutList() {
		return purchaseOutList;
	}
	public void setPurchaseInList(long[] purchaseInList) {
		this.purchaseInList = purchaseInList;
	}
	public long[] getPurchaseInList() {
		return purchaseInList;
	}
	public void setLaborList(long[] laborList) {
		this.laborList = laborList;
	}
	public long[] getLaborList() {
		return laborList;
	}
	public void setExpenseList(long[] expenseList) {
		this.expenseList = expenseList;
	}
	public long[] getExpenseList() {
		return expenseList;
	}
	public void setSalesOut(long salesOut) {
		this.salesOut = salesOut;
	}
	public long getSalesOut() {
		return salesOut;
	}
	public void setSalesIn(long salesIn) {
		this.salesIn = salesIn;
	}
	public long getSalesIn() {
		return salesIn;
	}
	public void setPurchaseOut(long purchaseOut) {
		this.purchaseOut = purchaseOut;
	}
	public long getPurchaseOut() {
		return purchaseOut;
	}
	public void setPurchaseIn(long purchaseIn) {
		this.purchaseIn = purchaseIn;
	}
	public long getPurchaseIn() {
		return purchaseIn;
	}
	public void setLabor(long labor) {
		this.labor = labor;
	}
	public long getLabor() {
		return labor;
	}
	public void setExpense(long expense) {
		this.expense = expense;
	}
	public long getExpense() {
		return expense;
	}
	public void setPurchaseInCommonList(long[] purchaseInCommonList) {
		this.purchaseInCommonList = purchaseInCommonList;
	}
	public long[] getPurchaseInCommonList() {
		return purchaseInCommonList;
	}
	

	public long getProfitOnSales(){
		return this.getSalesOut() + this.getSalesIn()- this.getPurchaseOut() - this.getPurchaseIn();
	}
	
	public long getOperatingProfit(){
		return this.getSalesOut() + this.getSalesIn() - this.getPurchaseOut() - this.getPurchaseIn() 
		         -this.getExpense() -this.getLabor() - this.getPurchaseInCommon();
	}
	public void setPurchaseInCommon(long purchaseInCommon) {
		this.purchaseInCommon = purchaseInCommon;
	}
	public long getPurchaseInCommon() {
		return purchaseInCommon;
	}
}
