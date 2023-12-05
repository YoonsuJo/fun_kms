package kms.com.management.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class ProjectResultVO {

	private String prjId;
	private String prjNm;
	private String prjCd;
	private String prjSn;
	private boolean havingLeaf;
	private String stat;
	
	private Long salesOut = (long)0;
	private Long salesIn = (long)0;
	private Long purchaseOut = (long)0;
	private Long purchaseIn = (long)0;
	private Long salary = (long)0;
	private Long expense = (long)0;
	
	private Long salesOutAcc = (long)0;
	private Long salesInAcc = (long)0;
	private Long purchaseOutAcc = (long)0;
	private Long purchaseInAcc = (long)0;
	private Long salaryAcc = (long)0;
	private Long expenseAcc = (long)0;
	
	private Long allBusiProfitAcc = (long)0;
	
	
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String[] searchOrgIdList;
	private String searchCondition = "0";
	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	private Integer searchMonth = Integer.parseInt(CalendarUtil.getToday().substring(4,6));
	private String includeResult = "N";
	private String searchRecalcYn = "N";
	
	private String sectorNm;
	private Integer sectorNo = 0;
	private String colorTyp;
	private Long commonExpense = (long)0;
	
	private Long planSalesOut = (long)0;
	private Long planSalesIn = (long)0;
	private Long planPurchaseOut = (long)0;
	private Long planPurchaseIn = (long)0;
	private Long planExpense = (long)0;
	private Long planCommonExpense = (long)0;
	private Long planLaborExpense = (long)0;
	
	// [20141001, dwkim] 조건 추가 
	private String startDate = "";
	private String endDate = "";
	private String includeAllDate = "N";	// 전체기간 포함
	private String includeAcc = "N";	// 누적실적 포함
	
	
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
	 * @return the prjSn
	 */
	public String getPrjSn() {
		return prjSn;
	}
	/**
	 * @param prjSn the prjSn to set
	 */
	public void setPrjSn(String prjSn) {
		this.prjSn = prjSn;
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
	 * @return the searchOrgId
	 */
	public String getSearchOrgId() {
		return searchOrgId;
	}
	/**
	 * @param searchOrgId the searchOrgId to set
	 */
	public void setSearchOrgId(String searchOrgId) {
		this.searchOrgId = searchOrgId;
	}
	/**
	 * @return the searchOrgNm
	 */
	public String getSearchOrgNm() {
		return searchOrgNm;
	}
	/**
	 * @param searchOrgNm the searchOrgNm to set
	 */
	public void setSearchOrgNm(String searchOrgNm) {
		this.searchOrgNm = searchOrgNm;
	}
	/**
	 * @return the searchOrgIdList
	 */
	public String[] getSearchOrgIdList() {
		return searchOrgIdList;
	}
	/**
	 * @param searchOrgIdList the searchOrgIdList to set
	 */
	public void setSearchOrgIdList(String[] searchOrgIdList) {
		this.searchOrgIdList = searchOrgIdList;
	}
	/**
	 * @return the searchCondition
	 */
	public String getSearchCondition() {
		return searchCondition;
	}
	/**
	 * @param searchCondition the searchCondition to set
	 */
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
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
	// 매출이익 누계
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
	public String getBusiProfitPercent() {
		return CommonUtil.getPercent(getBusiProfit(), salesOut + salesIn);
	}
	// 이익 누계
	public Long getBusiProfitAcc() {
		return salesOutAcc + salesInAcc - purchaseOutAcc - purchaseInAcc - salaryAcc - expenseAcc;
	}
	public String getBusiProfitAccPrint() {
		return CommonUtil.insertCommaDivideBy(getBusiProfitAcc(), 1000);
	}
	public String getBusiProfitAccPercent() {
		return CommonUtil.getPercent(getBusiProfitAcc(), salesOutAcc + salesInAcc);
	}	
	
	public String getSectorNm() {
		return sectorNm;
	}
	public void setSectorNm(String sectorNm) {
		this.sectorNm = sectorNm;
	}
	public String getColorTyp() {
		return colorTyp;
	}
	public void setColorTyp(String colorTyp) {
		this.colorTyp = colorTyp;
	}
	public Long getCommonExpense() {
		return commonExpense;
	}
	public void setCommonExpense(Long commonExpense) {
		this.commonExpense = commonExpense;
	}
	public Long getPlanSalesOut() {
		return planSalesOut;
	}
	public void setPlanSalesOut(Long planSalesOut) {
		this.planSalesOut = planSalesOut;
	}
	public Long getPlanSalesIn() {
		return planSalesIn;
	}
	public void setPlanSalesIn(Long planSalesIn) {
		this.planSalesIn = planSalesIn;
	}
	public Long getPlanPurchaseOut() {
		return planPurchaseOut;
	}
	public void setPlanPurchaseOut(Long planPurchaseOut) {
		this.planPurchaseOut = planPurchaseOut;
	}
	public Long getPlanPurchaseIn() {
		return planPurchaseIn;
	}
	public void setPlanPurchaseIn(Long planPurchaseIn) {
		this.planPurchaseIn = planPurchaseIn;
	}
	public Long getPlanExpense() {
		return planExpense;
	}
	public void setPlanExpense(Long planExpense) {
		this.planExpense = planExpense;
	}
	public Long getPlanCommonExpense() {
		return planCommonExpense;
	}
	public void setPlanCommonExpense(Long planCommonExpense) {
		this.planCommonExpense = planCommonExpense;
	}
	public Long getPlanLaborExpense() {
		return planLaborExpense;
	}
	public void setPlanLaborExpense(Long planLaborExpense) {
		this.planLaborExpense = planLaborExpense;
	}
	public Integer getSectorNo() {
		return sectorNo;
	}
	public void setSectorNo(Integer sectorNo) {
		this.sectorNo = sectorNo;
	}
	
	public Long getPlanSalesProfit() {
		return planSalesOut + planSalesIn - planPurchaseOut - planPurchaseIn;
	}
	public Long getSalesProfit(Long salesProfit) {
		return salesOut + salesIn - purchaseOut - purchaseIn;
	}

	public Long getPlanProfit() {
		return getPlanSalesProfit() - planLaborExpense - planExpense - planCommonExpense;
		
	}
	public Long getProfit() {
		return getSalesProfit() - salary - expense - commonExpense;
	}
		
	public String getPlanSalesProfitPercent() {
		return CommonUtil.getPercent(getPlanProfit(), planSalesOut + planSalesIn);
	}
	public String getSalesProfitPercent() {
		return CommonUtil.getPercent(getProfit(), salesOut + salesIn);
	}
	
	public String getPlanProfitPercent() {
		return CommonUtil.getPercent(getPlanProfit(), planSalesOut + planSalesIn);
	}
	public String getProfitPercent() {
		return CommonUtil.getPercent(getProfit(), salesOut + salesIn);
	}
	
	public String getAchievePercent() {
		return CommonUtil.getPercent(getProfit(), getPlanProfit());
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
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
	/**
	 * @return the allBusiProfitAcc
	 */
	public Long getAllBusiProfitAcc() {
		return allBusiProfitAcc;
	}
	
	/**
	 * @param allBusiProfitAcc the allBusiProfitAcc to set
	 */
	public void setAllBusiProfitAcc(Long allBusiProfitAcc) {
		this.allBusiProfitAcc = allBusiProfitAcc;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getIncludeAllDate() {
		return includeAllDate;
	}
	public void setIncludeAllDate(String includeAllDate) {
		this.includeAllDate = includeAllDate;
	}
	public String getIncludeAcc() {
		return includeAcc;
	}
	public void setIncludeAcc(String includeAcc) {
		this.includeAcc = includeAcc;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}


}
