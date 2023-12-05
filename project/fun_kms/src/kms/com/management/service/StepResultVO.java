package kms.com.management.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class StepResultVO {
	private String id;
	private String nm;
	private String sn;
	private Integer lv;
	private String typ;
	private boolean havingLeaf;
	private Long salesOut = (long)0;
	private Long salesIn = (long)0;
	private Long purchaseOut = (long)0;
	private Long purchaseIn = (long)0;
	private Long salaryPlan = (long)0;
	private Long salary = (long)0;
	private Long expensePlan = (long)0;
	private Long expense = (long)0;
	private Long salesOutAcc = (long)0;
	private Long salesInAcc = (long)0;
	private Long purchaseOutAcc = (long)0;
	private Long purchaseInAcc = (long)0;
	private Long salaryPlanAcc = (long)0;
	private Long salaryAcc = (long)0;
	private Long expensePlanAcc = (long)0;
	private Long expenseAcc = (long)0;
	
	private String searchId = "";
	private Integer searchLv = 0;
	private String searchTyp = "";
	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	private Integer searchMonth = Integer.parseInt(CalendarUtil.getToday().substring(4,6));
	private String startDate = "";
	private String endDate = "";
	private String includeAllDate = "N";	
	private String includeResult = "N";
	private String includeAcc = "N";	// 누적실적 포함
	private String isSub = "Y";
	private String searchRecalcYn = "N";

	private String stat = "";
	private String prjType = ""; 
	
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the nm
	 */
	public String getNm() {
		return nm;
	}
	/**
	 * @param nm the nm to set
	 */
	public void setNm(String nm) {
		this.nm = nm;
	}
	/**
	 * @return the sn
	 */
	public String getSn() {
		return sn;
	}
	/**
	 * @param sn the sn to set
	 */
	public void setSn(String sn) {
		this.sn = sn;
	}
	/**
	 * @return the lv
	 */
	public Integer getLv() {
		return lv;
	}
	/**
	 * @param lv the lv to set
	 */
	public void setLv(Integer lv) {
		this.lv = lv;
	}
	/**
	 * @return the typ
	 */
	public String getTyp() {
		return typ;
	}
	/**
	 * @param typ the typ to set
	 */
	public void setTyp(String typ) {
		this.typ = typ;
	}
	/**
	 * @return the havingLeaf
	 */
	public boolean isHavingLeaf() {
		return havingLeaf;
	}
	/**
	 * @param havingLeaf the havingLeaf to set
	 */
	public void setHavingLeaf(boolean havingLeaf) {
		this.havingLeaf = havingLeaf;
	}
	/**
	 * @return the salesOut
	 */
	public Long getSalesOut() {
		return salesOut;
	}
	public String getSalesOutPrint() {
		return CommonUtil.insertCommaDivideBy(salesOut, 1000);
	}
	/**
	 * @param salesOut the salesOut to set
	 */
	public void setSalesOut(Long salesOut) {
		this.salesOut = salesOut;
	}
	/**
	 * @return the salesIn
	 */
	public Long getSalesIn() {
		return salesIn;
	}
	public String getSalesInPrint() {
		return CommonUtil.insertCommaDivideBy(salesIn, 1000);
	}
	/**
	 * @param salesIn the salesIn to set
	 */
	public void setSalesIn(Long salesIn) {
		this.salesIn = salesIn;
	}
	/**
	 * @return the purchaseOut
	 */
	public Long getPurchaseOut() {
		return purchaseOut;
	}
	public String getPurchaseOutPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOut, 1000);
	}
	/**
	 * @param purchaseOut the purchaseOut to set
	 */
	public void setPurchaseOut(Long purchaseOut) {
		this.purchaseOut = purchaseOut;
	}
	/**
	 * @return the purchaseIn
	 */
	public Long getPurchaseIn() {
		return purchaseIn;
	}
	public String getPurchaseInPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseIn, 1000);
	}
	/**
	 * @param purchaseIn the purchaseIn to set
	 */
	public void setPurchaseIn(Long purchaseIn) {
		this.purchaseIn = purchaseIn;
	}
	/**
	 * @return the salaryPlan
	 */
	public Long getSalaryPlan() {
		return salaryPlan;
	}
	public String getSalaryPlanPrint() {
		return CommonUtil.insertCommaDivideBy(salaryPlan, 1000);
	}
	/**
	 * @param salaryPlan the salaryPlan to set
	 */
	public void setSalaryPlan(Long salaryPlan) {
		this.salaryPlan = salaryPlan;
	}
	/**
	 * @return the salary
	 */
	public Long getSalary() {
		return salary;
	}
	public String getSalaryPrint() {
		return CommonUtil.insertCommaDivideBy(salary, 1000);
	}
	/**
	 * @param salary the salary to set
	 */
	public void setSalary(Long salary) {
		this.salary = salary;
	}
	/**
	 * @return the expensePlan
	 */
	public Long getExpensePlan() {
		return expensePlan;
	}
	public String getExpensePlanPrint() {
		return CommonUtil.insertCommaDivideBy(expensePlan, 1000);
	}
	/**
	 * @param expensePlan the expensePlan to set
	 */
	public void setExpensePlan(Long expensePlan) {
		this.expensePlan = expensePlan;
	}
	/**
	 * @return the expense
	 */
	public Long getExpense() {
		return expense;
	}
	public String getExpensePrint() {
		return CommonUtil.insertCommaDivideBy(expense, 1000);
	}
	/**
	 * @param expense the expense to set
	 */
	public void setExpense(Long expense) {
		this.expense = expense;
	}
	/**
	 * @return the salesOutAcc
	 */
	public Long getSalesOutAcc() {
		return salesOutAcc;
	}
	public String getSalesOutAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesOutAcc, 1000);
	}
	/**
	 * @param salesOutAcc the salesOutAcc to set
	 */
	public void setSalesOutAcc(Long salesOutAcc) {
		this.salesOutAcc = salesOutAcc;
	}
	/**
	 * @return the salesInAcc
	 */
	public Long getSalesInAcc() {
		return salesInAcc;
	}
	public String getSalesInAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesInAcc, 1000);
	}
	/**
	 * @param salesInAcc the salesInAcc to set
	 */
	public void setSalesInAcc(Long salesInAcc) {
		this.salesInAcc = salesInAcc;
	}
	/**
	 * @return the purchaseOutAcc
	 */
	public Long getPurchaseOutAcc() {
		return purchaseOutAcc;
	}
	public String getPurchaseOutAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOutAcc, 1000);
	}
	/**
	 * @param purchaseOutAcc the purchaseOutAcc to set
	 */
	public void setPurchaseOutAcc(Long purchaseOutAcc) {
		this.purchaseOutAcc = purchaseOutAcc;
	}
	/**
	 * @return the purchaseInAcc
	 */
	public Long getPurchaseInAcc() {
		return purchaseInAcc;
	}
	public String getPurchaseInAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseInAcc, 1000);
	}
	/**
	 * @param purchaseInAcc the purchaseInAcc to set
	 */
	public void setPurchaseInAcc(Long purchaseInAcc) {
		this.purchaseInAcc = purchaseInAcc;
	}
	/**
	 * @return the salaryPlanAcc
	 */
	public Long getSalaryPlanAcc() {
		return salaryPlanAcc;
	}
	public String getSalaryPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(salaryPlanAcc, 1000);
	}
	/**
	 * @param salaryPlanAcc the salaryPlanAcc to set
	 */
	public void setSalaryPlanAcc(Long salaryPlanAcc) {
		this.salaryPlanAcc = salaryPlanAcc;
	}
	/**
	 * @return the salaryAcc
	 */
	public Long getSalaryAcc() {
		return salaryAcc;
	}
	public String getSalaryAccPrint() {
		return CommonUtil.insertCommaDivideBy(salaryAcc, 1000);
	}
	/**
	 * @param salaryAcc the salaryAcc to set
	 */
	public void setSalaryAcc(Long salaryAcc) {
		this.salaryAcc = salaryAcc;
	}
	/**
	 * @return the expensePlanAcc
	 */
	public Long getExpensePlanAcc() {
		return expensePlanAcc;
	}
	public String getExpensePlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(expensePlanAcc, 1000);
	}
	/**
	 * @param expensePlanAcc the expensePlanAcc to set
	 */
	public void setExpensePlanAcc(Long expensePlanAcc) {
		this.expensePlanAcc = expensePlanAcc;
	}
	/**
	 * @return the expenseAcc
	 */
	public Long getExpenseAcc() {
		return expenseAcc;
	}
	public String getExpenseAccPrint() {
		return CommonUtil.insertCommaDivideBy(expenseAcc, 1000);
	}
	/**
	 * @param expenseAcc the expenseAcc to set
	 */
	public void setExpenseAcc(Long expenseAcc) {
		this.expenseAcc = expenseAcc;
	}
	/**
	 * @return the searchId
	 */
	public String getSearchId() {
		return searchId;
	}
	/**
	 * @param searchId the searchId to set
	 */
	public void setSearchId(String searchId) {
		this.searchId = searchId;
	}
	/**
	 * @return the searchLv
	 */
	public Integer getSearchLv() {
		return searchLv;
	}
	/**
	 * @param searchLv the searchLv to set
	 */
	public void setSearchLv(Integer searchLv) {
		this.searchLv = searchLv;
	}
	/**
	 * @return the searchTyp
	 */
	public String getSearchTyp() {
		return searchTyp;
	}
	/**
	 * @param searchTyp the searchTyp to set
	 */
	public void setSearchTyp(String searchTyp) {
		this.searchTyp = searchTyp;
	}
	/**
	 * @return the searchYear
	 */
	public Integer getSearchYear() {
		return searchYear;
	}
	/**
	 * @param searchYear the searchYear to set
	 */
	public void setSearchYear(Integer searchYear) {
		this.searchYear = searchYear;
	}
	/**
	 * @return the searchMonth
	 */
	public Integer getSearchMonth() {
		return searchMonth;
	}
	public String getSearchMonthStr() {
		String searchMonthStr = searchMonth.toString();
		if (searchMonthStr.length() == 1) searchMonthStr = "0" + searchMonthStr;
		return searchMonthStr;
	}
	/**
	 * @param searchMonth the searchMonth to set
	 */
	public void setSearchMonth(Integer searchMonth) {
		this.searchMonth = searchMonth;
	}
	/**
	 * @return the includeResult
	 */
	public String getIncludeResult() {
		return includeResult;
	}
	/**
	 * @param includeResult the includeResult to set
	 */
	public void setIncludeResult(String includeResult) {
		this.includeResult = includeResult;
	}
	
	public Long getSalesProfit() {
		return salesOut + salesIn - purchaseOut - purchaseIn;
	}
	public String getSalesProfitPrint() {
		return CommonUtil.insertCommaDivideBy(getSalesProfit(), 1000);
	}
	
	public Long getSalesProfitAcc() {
		return salesOutAcc + salesInAcc - purchaseOutAcc - purchaseInAcc;
	}
	public String getSalesProfitAccPrint() {
		return CommonUtil.insertCommaDivideBy(getSalesProfitAcc(), 1000);
	}
	
	public Long getBusiProfit() {
		return getSalesProfit() - salary - expense;
	}
	public String getBusiProfitPrint() {
		return CommonUtil.insertCommaDivideBy(getBusiProfit(), 1000);
	}
	public Long getBusiProfitAcc() {
		return salesOutAcc + salesInAcc - purchaseOutAcc - purchaseInAcc - salaryAcc - expenseAcc;
	}
	public String getBusiProfitAccPrint() {
		return CommonUtil.insertCommaDivideBy(getBusiProfitAcc(), 1000);
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setIsSub(String isSub) {
		this.isSub = isSub;
	}
	public String getIsSub() {
		return isSub;
	}
	/**
	 * @return the searchRecalcYn
	 */
	public String getSearchRecalcYn() {
		return searchRecalcYn;
	}
	/**
	 * @param searchRecalcYn the searchRecalcYn to set
	 */
	public void setSearchRecalcYn(String searchRecalcYn) {
		this.searchRecalcYn = searchRecalcYn;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setIncludeAllDate(String includeAllDate) {
		this.includeAllDate = includeAllDate;
	}
	public String getIncludeAllDate() {
		return includeAllDate;
	}
	/**
	 * @param stat the stat to set
	 */
	public void setStat(String stat) {
		this.stat = stat;
	}
	/**
	 * @return the stat
	 */
	public String getStat() {
		return stat;
	}
	public String getIncludeAcc() {
		return includeAcc;
	}
	public void setIncludeAcc(String includeAcc) {
		this.includeAcc = includeAcc;
	}
	public String getPrjType() {
		return prjType;
	}
	public void setPrjType(String prjType) {
		this.prjType = prjType;
	}
}
