package kms.com.project.vo;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

import lombok.Getter;
import lombok.Setter;

public class StepResultVO {
	@Getter @Setter private String id = "";
	@Getter @Setter private String nm = "";
	@Getter @Setter private String sn = "";
	@Getter @Setter private Integer lv = 0;
	@Getter @Setter private String typ = "";
	@Getter @Setter private boolean havingLeaf;
	@Getter @Setter private Long salesOut = (long)0;
	@Getter @Setter private Long salesIn = (long)0;
	@Getter @Setter private Long purchaseOut = (long)0;
	@Getter @Setter private Long purchaseIn = (long)0;
	@Getter @Setter private Long salaryPlan = (long)0;
	@Getter @Setter private Long salary = (long)0;
	@Getter @Setter private Long expensePlan = (long)0;
	@Getter @Setter private Long expense = (long)0;
	@Getter @Setter private Long salesOutAcc = (long)0;
	@Getter @Setter private Long salesInAcc = (long)0;
	@Getter @Setter private Long purchaseOutAcc = (long)0;
	@Getter @Setter private Long purchaseInAcc = (long)0;
	@Getter @Setter private Long salaryPlanAcc = (long)0;
	@Getter @Setter private Long salaryAcc = (long)0;
	@Getter @Setter private Long expensePlanAcc = (long)0;
	@Getter @Setter private Long expenseAcc = (long)0;
	
	@Getter @Setter private String searchId = "";
	@Getter @Setter private Integer searchLv = 0;
	@Getter @Setter private String searchTyp = "";
	@Getter @Setter private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	@Getter @Setter private Integer searchMonth = Integer.parseInt(CalendarUtil.getToday().substring(4,6));
	@Getter @Setter private String startDate = "";
	@Getter @Setter private String endDate = "";
	@Getter @Setter private String includeAllDate = "N";	
	@Getter @Setter private String includeResult = "N";
	@Getter @Setter private String includeAcc = "N";	// 누적실적 포함
	@Getter @Setter private String isSub = "Y";
	@Getter @Setter private String searchRecalcYn = "N";

	@Getter @Setter private String stat = "";
	@Getter @Setter private String prjType = ""; 
	
	public String getSalesOutPrint() {
		return CommonUtil.insertCommaDivideBy(salesOut, 1000);
	}
	public String getSalesInPrint() {
		return CommonUtil.insertCommaDivideBy(salesIn, 1000);
	}
	public String getPurchaseOutPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOut, 1000);
	}
	public String getPurchaseInPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseIn, 1000);
	}
	public String getSalaryPlanPrint() {
		return CommonUtil.insertCommaDivideBy(salaryPlan, 1000);
	}
	public String getSalaryPrint() {
		return CommonUtil.insertCommaDivideBy(salary, 1000);
	}
	public String getExpensePlanPrint() {
		return CommonUtil.insertCommaDivideBy(expensePlan, 1000);
	}
	public String getExpensePrint() {
		return CommonUtil.insertCommaDivideBy(expense, 1000);
	}
	public String getSalesOutAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesOutAcc, 1000);
	}
	public String getSalesInAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesInAcc, 1000);
	}
	public String getPurchaseOutAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseOutAcc, 1000);
	}
	public String getPurchaseInAccPrint() {
		return CommonUtil.insertCommaDivideBy(purchaseInAcc, 1000);
	}
	public String getSalaryPlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(salaryPlanAcc, 1000);
	}
	public String getSalaryAccPrint() {
		return CommonUtil.insertCommaDivideBy(salaryAcc, 1000);
	}
	public String getExpensePlanAccPrint() {
		return CommonUtil.insertCommaDivideBy(expensePlanAcc, 1000);
	}
	public String getExpenseAccPrint() {
		return CommonUtil.insertCommaDivideBy(expenseAcc, 1000);
	}
	public String getSearchMonthStr() {
		String searchMonthStr = searchMonth.toString();
		if (searchMonthStr.length() == 1) searchMonthStr = "0" + searchMonthStr;
		return searchMonthStr;
	}
	public String getSalesProfitPrint() {
		return CommonUtil.insertCommaDivideBy(salesOut + salesIn - purchaseOut - purchaseIn, 1000);
	}
	public String getSalesProfitAccPrint() {
		return CommonUtil.insertCommaDivideBy(salesOutAcc + salesInAcc - purchaseOutAcc - purchaseInAcc, 1000);
	}
	
	public Long getBusiProfit() {
		return salesOut + salesIn - purchaseOut - purchaseIn - salary - expense;
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
}
