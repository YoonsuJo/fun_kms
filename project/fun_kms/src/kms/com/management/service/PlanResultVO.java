package kms.com.management.service;

import java.text.DecimalFormat;
import java.text.Format;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class PlanResultVO {

	private String prjId;
	private String prjNm;
	private String prjCd;
	private String prjSn;
	private boolean havingLeaf;
	private String stat;
	private Long salaryPlan = (long)0;
	private Long salary = (long)0;
	private Long expensePlan = (long)0;
	private Long expense = (long)0;
	private Long salaryPlanAcc = (long)0;
	private Long salaryAcc = (long)0;
	private Long expensePlanAcc = (long)0;
	private Long expenseAcc = (long)0;
	
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String[] searchOrgIdList;
	private String searchCondition = "0";
	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	private Integer searchMonth = Integer.parseInt(CalendarUtil.getToday().substring(4,6));
	private String includeResult = "N";
	
	// [20141001, dwkim] 조건 추가 
	private String startDate = "";
	private String endDate = "";
	private String includeAllDate = "N";	// 전체기간 포함
	
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
	
	public Long getOverAcc() {
		return salaryAcc + expenseAcc - salaryPlanAcc - expensePlanAcc;
	}
	public String getOverAccPrint() {
		return CommonUtil.insertCommaDivideBy(getOverAcc(), 1000);
	}
	public String getOverAccPercent() {
		return CommonUtil.getPercent(getOverAcc(), salaryPlanAcc + expensePlanAcc);
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
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
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
}
