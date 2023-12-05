package kms.com.management.service;

import org.apache.commons.lang.builder.ToStringBuilder;
import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class MonthResultVO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Getter @Setter private String id;
	
	@Getter @Setter private Long salesOutBusiPlan = (long)0;
	@Getter @Setter private Long salesInBusiPlan = (long)0;
	@Getter @Setter private Long purchaseOutBusiPlan = (long)0;
	@Getter @Setter private Long purchaseInBusiPlan = (long)0;
	@Getter @Setter private Long salaryBusiPlan = (long)0;
	@Getter @Setter private Long expenseBusiPlan = (long)0;
	
	@Getter @Setter private Long salesOutPlan = (long)0;
	@Getter @Setter private Long salesInPlan = (long)0;
	@Getter @Setter private Long purchaseOutPlan = (long)0;
	@Getter @Setter private Long purchaseInPlan = (long)0;
	@Getter @Setter private Long salaryPlan = (long)0;
	@Getter @Setter private Long expensePlan = (long)0;
	
	@Getter @Setter private Long salesOut = (long)0;
	@Getter @Setter private Long salesIn = (long)0;
	@Getter @Setter private Long purchaseOut = (long)0;
	@Getter @Setter private Long purchaseIn = (long)0;
	@Getter @Setter private Long salary = (long)0;
	@Getter @Setter private Long expense = (long)0;
	
	@Getter @Setter private Long common = (long)0;
	
	@Getter @Setter private Long salesOutBusiPlanAcc = (long)0;
	@Getter @Setter private Long salesInBusiPlanAcc = (long)0;
	@Getter @Setter private Long purchaseOutBusiPlanAcc = (long)0;
	@Getter @Setter private Long purchaseInBusiPlanAcc = (long)0;
	@Getter @Setter private Long salaryBusiPlanAcc = (long)0;
	@Getter @Setter private Long expenseBusiPlanAcc = (long)0;
	
	@Getter @Setter private Long salesOutPlanAcc = (long)0;
	@Getter @Setter private Long salesInPlanAcc = (long)0;
	@Getter @Setter private Long purchaseOutPlanAcc = (long)0;
	@Getter @Setter private Long purchaseInPlanAcc = (long)0;
	@Getter @Setter private Long salaryPlanAcc = (long)0;
	@Getter @Setter private Long expensePlanAcc = (long)0;
	
	@Getter @Setter private Long salesOutAcc = (long)0;
	@Getter @Setter private Long salesInAcc = (long)0;
	@Getter @Setter private Long purchaseOutAcc = (long)0;
	@Getter @Setter private Long purchaseInAcc = (long)0;
	@Getter @Setter private Long salaryAcc = (long)0;
	@Getter @Setter private Long expenseAcc = (long)0;
	
	@Getter @Setter private Long commonAcc = (long)0;
	
	@Getter @Setter private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	@Getter @Setter private Integer searchMonth = Integer.parseInt(CalendarUtil.getToday().substring(4,6));
	@Getter @Setter private String searchSectorNo = "";
	@Getter @Setter private String searchRecalcYn = "N";
	
	
	/**
	 * @return the salesBusiPlan
	 */
	public String getSalesOutBusiPlanPrint() {
		return CommonUtil.insertCommaDivideBy(salesOutBusiPlan, 1000000, true);
	}
	public String getSalesInBusiPlanPrint() {
		return CommonUtil.insertCommaDivideBy(salesInBusiPlan, 1000000, true);
	}
	/**
	 * @return the purchaseOutBusiPlan
	 */
	public String getPurchaseOutBusiPlanPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOutBusiPlan, 1000000, true);
	}
	/**
	 * @return the purchaseInBusiPlan
	 */
	public String getPurchaseInBusiPlanPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseInBusiPlan, 1000000, true);
	}
	/**
	 * @param purchaseInBusiPlan the purchaseInBusiPlan to set
	 */
	public void setPurchaseInBusiPlan(Long purchaseInBusiPlan) {
		this.purchaseInBusiPlan = purchaseInBusiPlan;
	}
	/**
	 * @return the salaryBusiPlan
	 */
	public String getSalaryBusiPlanPrint() {
		return CommonUtil.insertCommaDivideBy(salaryBusiPlan, 1000000, true);
	}
	/**
	 * @return the expenseBusiPlan
	 */
	public String getExpenseBusiPlanPrint() {
		return CommonUtil.insertCommaDivideBy(expenseBusiPlan, 1000000, true);
	}
	/**
	 * @return the salesOutPlan
	 */
	public String getSalesOutPlanPrint() {
		return CommonUtil.insertCommaDivideBy(salesOutPlan, 1000000, true);
	}
	/**
	 * @return the salesInPlan
	 */
	public String getSalesInPlanPrint() {
		return CommonUtil.insertCommaDivideBy(salesInPlan, 1000000, true);
	}
	/**
	 * @return the purchaseOutPlan
	 */
	public String getPurchaseOutPlanPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOutPlan, 1000000, true);
	}
	public String getPurchaseInPlanPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseInPlan, 1000000, true);
	}
	public String getSalaryPlanPrint() {
		return CommonUtil.insertCommaDivideBy(salaryPlan, 1000000, true);
	}
	public String getExpensePlanPrint() {
		return CommonUtil.insertCommaDivideBy(expensePlan, 1000000, true);
	}
	public String getSalesOutPrint() {
		return CommonUtil.insertCommaDivideBy(salesOut, 1000000, true);
	}
	public String getSalesInPrint() {
		return CommonUtil.insertCommaDivideBy(salesIn, 1000000, true);
	}
	public String getPurchaseOutPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOut, 1000000, true);
	}
	public String getPurchaseInPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseIn, 1000000, true);
	}
	public String getSalaryPrint() {
		return CommonUtil.insertCommaDivideBy(salary, 1000000, true);
	}
	public String getExpensePrint() {
		return CommonUtil.insertCommaDivideBy(expense, 1000000, true);
	}
	public String getCommonPrint() {
		return CommonUtil.insertCommaDivideBy(common, 1000000, true);
	}
	public String getSalesOutBusiPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesOutBusiPlanAcc, 1000000, true);
	}
	public String getSalesInBusiPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesInBusiPlanAcc, 1000000, true);
	}
	public String getPurchaseOutBusiPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOutBusiPlanAcc, 1000000, true);
	}
	public String getPurchaseInBusiPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseInBusiPlanAcc, 1000000, true);
	}
	public String getSalaryBusiPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(salaryBusiPlanAcc, 1000000, true);
	}
	public String getExpenseBusiPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(expenseBusiPlanAcc, 1000000, true);
	}
	public String getSalesOutPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesOutPlanAcc, 1000000, true);
	}
	public String getSalesInPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesInPlanAcc, 1000000, true);
	}
	public String getPurchaseOutPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOutPlanAcc, 1000000, true);
	}
	public String getPurchaseInPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseInPlanAcc, 1000000, true);
	}
	public String getSalaryPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(salaryPlanAcc, 1000000, true);
	}
	public String getExpensePlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(expensePlanAcc, 1000000, true);
	}
	public String getSalesOutAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesOutAcc, 1000000, true);
	}
	public String getSalesInAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesInAcc, 1000000, true);
	}
	public String getPurchaseOutAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOutAcc, 1000000, true);
	}
	public String getPurchaseInAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseInAcc, 1000000, true);
	}
	public String getSalaryAccPrint() {
		return CommonUtil.insertCommaDivideBy(salaryAcc, 1000000, true);
	}
	public String getExpenseAccPrint() {
		return CommonUtil.insertCommaDivideBy(expenseAcc, 1000000, true);
	}
	public String getCommonAccPrint() {
		return CommonUtil.insertCommaDivideBy(commonAcc, 1000000, true);
	}
	public Long getSalesProfitBusiPlan() {
		return salesOutBusiPlan + salesInBusiPlan - purchaseOutBusiPlan - purchaseInBusiPlan;
	}
	public String getSalesProfitBusiPlanPrint() {
		return CommonUtil.insertCommaDivideBy(getSalesProfitBusiPlan(), 1000000, true);
	}
	public String getSalesProfitBusiPlanPercent() {
		return CommonUtil.getPercent(getSalesProfitBusiPlan(), salesOutBusiPlan + salesInBusiPlan);
	}
	
	public Long getSalesProfitPlan() {
		return salesOutPlan + salesInPlan - purchaseOutPlan - purchaseInPlan;
	}
	public String getSalesProfitPlanPrint() {
		return CommonUtil.insertCommaDivideBy(getSalesProfitPlan(), 1000000, true);
	}
	public String getSalesProfitPlanPercent() {
		return CommonUtil.getPercent(getSalesProfitPlan(), salesOutPlan + salesInPlan);
	}
	
	public Long getSalesProfit() {
		return salesOut + salesIn - purchaseOut - purchaseIn;
	}
	public String getSalesProfitPrint() {
		return CommonUtil.insertCommaDivideBy(getSalesProfit(), 1000000, true);
	}
	public String getSalesProfitPercent() {
		return CommonUtil.getPercent(getSalesProfit(), salesOut + salesIn);
	}
	
	
	public Long getSalesProfitBusiPlanAcc() {
		return salesOutBusiPlanAcc + salesInBusiPlanAcc - purchaseOutBusiPlanAcc - purchaseInBusiPlanAcc;
	}
	public String getSalesProfitBusiPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(getSalesProfitBusiPlanAcc(), 1000000, true);
	}
	public String getSalesProfitBusiPlanAccPercent() {
		return CommonUtil.getPercent(getSalesProfitBusiPlanAcc(), salesOutBusiPlanAcc+salesInBusiPlanAcc);
	}
	
	public Long getSalesProfitPlanAcc() {
		return salesOutPlanAcc + salesInPlanAcc - purchaseOutPlanAcc - purchaseInPlanAcc;
	}
	public String getSalesProfitPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(getSalesProfitPlanAcc(), 1000000, true);
	}
	public String getSalesProfitPlanAccPercent() {
		return CommonUtil.getPercent(getSalesProfitPlanAcc(), salesOutPlanAcc + salesInPlanAcc);
	}
	
	public Long getSalesProfitAcc() {
		return salesOutAcc + salesInAcc - purchaseOutAcc - purchaseInAcc;
	}
	public String getSalesProfitAccPrint() {
		return CommonUtil.insertCommaDivideBy(getSalesProfitAcc(), 1000000, true);
	}
	public String getSalesProfitAccPercent() {
		return CommonUtil.getPercent(getSalesProfitAcc(), salesOutAcc + salesInAcc);
	}
	
	/*************************************************************************************************/
	// 사업부 공헌이익 목표 - 월별실적
	public Long getDiviProfitBusiPlan() {
		return getSalesProfitBusiPlan() - salaryBusiPlan - expenseBusiPlan;
	}
	// 숫자
	public String getDiviProfitBusiPlanPrint() {
		return CommonUtil.insertCommaDivideBy(getDiviProfitBusiPlan(), 1000000, true);
	}
	// 퍼센트
	public String getDiviProfitBusiPlanPercent() {
		return CommonUtil.getPercent(getDiviProfitBusiPlan(), salesOutBusiPlan+salesInBusiPlan);
	}
	
	// 사업부 공헌이익 예상 
	public Long getDiviProfitPlan() {
		return getSalesProfitPlan() - salary - expensePlan;
	}
	// 숫자
	public String getDiviProfitPlanPrint() {
		return CommonUtil.insertCommaDivideBy(getDiviProfitPlan(), 1000000, true);
	}
	// 퍼센트
	public String getDiviProfitPlanPercent() {
		return CommonUtil.getPercent(getDiviProfitPlan(), salesOutPlan + salesInPlan);
	}

	// 사업부 공헌이익 실적
	public Long getDiviProfit() {
		return getSalesProfit() - salary - expense;
	}
	// 숫자
	public String getDiviProfitPrint() {
		return CommonUtil.insertCommaDivideBy(getDiviProfit(), 1000000, true);
	}
	// 퍼센트
	public String getDiviProfitPercent() {
		return CommonUtil.getPercent(getDiviProfit(), salesOut + salesIn);
	}
	
	// 사업부 공헌이익 목표 - 누계
	public Long getDiviProfitBusiPlanAcc() {
		return getSalesProfitBusiPlanAcc() - salaryBusiPlanAcc - expenseBusiPlanAcc;
	}
	// 숫자
	public String getDiviProfitBusiPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(getDiviProfitBusiPlanAcc(), 1000000, true);
	}
	// 퍼센트
	public String getDiviProfitBusiPlanAccPercent() {
		return CommonUtil.getPercent(getDiviProfitBusiPlanAcc(), salesOutBusiPlanAcc+salesInBusiPlanAcc);
	}
	
	// 사업부 공헌이익 실적 - 누계
	public Long getDiviProfitPlanAcc() {
		return getSalesProfitPlanAcc() - salaryPlanAcc - expensePlanAcc;
	}
	// 숫자
	public String getDiviProfitPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(getDiviProfitPlanAcc(), 1000000, true);
	}
	// 퍼센트
	public String getDiviProfitPlanAccPercent() {
		return CommonUtil.getPercent(getDiviProfitPlanAcc(), salesOutPlanAcc + salesInPlanAcc);
	}
	
	// 사업부 공헌이익 달성률 - 누계
	public Long getDiviProfitAcc() {
		return getSalesProfitAcc() - salaryAcc - expenseAcc;
	}
	// 숫자
	public String getDiviProfitAccPrint() {
		return CommonUtil.insertCommaDivideBy(getDiviProfitAcc(), 1000000, true);
	}
	// 퍼센트
	public String getDiviProfitAccPercent() {
		return CommonUtil.getPercent(getDiviProfitAcc(), salesOutAcc + salesInAcc);
	}
	
	/*************************************************************************************************/
	// 영업이익 목표 - 월별실적
	public Long getBusiProfitBusiPlan() {
		return getSalesProfitBusiPlan() - salaryBusiPlan - expenseBusiPlan - common;
	}
	// 숫자
	public String getBusiProfitBusiPlanPrint() {
		return CommonUtil.insertCommaDivideBy(getBusiProfitBusiPlan(), 1000000, true);
	}
	// 퍼센트
	public String getBusiProfitBusiPlanPercent() {
		return CommonUtil.getPercent(getBusiProfitBusiPlan(), salesOutBusiPlan+salesInBusiPlan);
	}
	
	// 영업이익 예상 
	public Long getBusiProfitPlan() {
		return getSalesProfitPlan() - salary - expensePlan - common;
	}
	// 숫자
	public String getBusiProfitPlanPrint() {
		return CommonUtil.insertCommaDivideBy(getBusiProfitPlan(), 1000000, true);
	}
	// 퍼센트
	public String getBusiProfitPlanPercent() {
		return CommonUtil.getPercent(getBusiProfitPlan(), salesOutPlan + salesInPlan);
	}

	// 영업이익 실적
	public Long getBusiProfit() {
		return getSalesProfit() - salary - expense - common;
	}
	// 숫자
	public String getBusiProfitPrint() {
		return CommonUtil.insertCommaDivideBy(getBusiProfit(), 1000000, true);
	}
	// 퍼센트
	public String getBusiProfitPercent() {
		return CommonUtil.getPercent(getBusiProfit(), salesOut + salesIn);
	}
	
	// 영업이익 목표 - 누계
	public Long getBusiProfitBusiPlanAcc() {
		return getSalesProfitBusiPlanAcc() - salaryBusiPlanAcc - expenseBusiPlanAcc - commonAcc;
	}
	// 숫자
	public String getBusiProfitBusiPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(getBusiProfitBusiPlanAcc(), 1000000, true);
	}
	// 퍼센트
	public String getBusiProfitBusiPlanAccPercent() {
		return CommonUtil.getPercent(getBusiProfitBusiPlanAcc(), salesOutBusiPlanAcc+salesInBusiPlanAcc);
	}
	
	// 영업이익 실적 - 누계
	public Long getBusiProfitPlanAcc() {
		return getSalesProfitPlanAcc() - salaryPlanAcc - expensePlanAcc - commonAcc;
	}
	// 숫자
	public String getBusiProfitPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(getBusiProfitPlanAcc(), 1000000, true);
	}
	// 퍼센트
	public String getBusiProfitPlanAccPercent() {
		return CommonUtil.getPercent(getBusiProfitPlanAcc(), salesOutPlanAcc + salesInPlanAcc);
	}
	
	// 영업이익 달성률 - 누계
	public Long getBusiProfitAcc() {
		return getSalesProfitAcc() - salaryAcc - expenseAcc - commonAcc;
	}
	// 숫자
	public String getBusiProfitAccPrint() {
		return CommonUtil.insertCommaDivideBy(getBusiProfitAcc(), 1000000, true);
	}
	// 퍼센트
	public String getBusiProfitAccPercent() {
		return CommonUtil.getPercent(getBusiProfitAcc(), salesOutAcc + salesInAcc);
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
