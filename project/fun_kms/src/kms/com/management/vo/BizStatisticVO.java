package kms.com.management.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

public class BizStatisticVO implements Serializable{
	private static final long serialVersionUID = 1L;
	private int scale = 1000000;
	@Getter @Setter private long salesOut = 0;
	@Getter @Setter private long salesIn = 0;
	@Getter @Setter private long purchaseOut = 0;
	@Getter @Setter private long purchaseIn = 0;
	@Getter @Setter private long labor = 0;
	@Getter @Setter private long expense = 0;
	@Getter @Setter private long commonCost = 0;

	// 매출이익
	public long getSalesProfit() {
		return salesOut + salesIn - purchaseOut -  purchaseIn;
	}
	// 사업부 이익
	public long getBizProfit() {
		return getSalesProfit() - labor - expense;
	}
	// 순이익
	public long getNetProfit() {
		return getBizProfit() - commonCost;
	}
	
	private String getStr(long source) {
		float result = (float)source /(float)scale;
/*		if(result >= 10) {
			return String.format("%.0f", result);
		}
		else {
			return String.format("%.1f", result);
		}
*/
		return String.format("%.0f", result);
	}
	
	public String getSalesOutStr() {
		return getStr(salesOut);
	}
	public String getSalesInStr() {
		return getStr(salesIn);
	}
	public String getPurchaseOutStr() {
		return getStr(purchaseOut);
	}
	public String getPurchaseInStr() {
		return getStr(purchaseIn);
	}
	public String getSalesProfitStr() {
		return getStr(getSalesProfit());
	}
	public String getLaborStr() {
		return getStr(labor);
	}
	public String getExpenseStr() {
		return getStr(expense);
	}
	public String getBizProfitStr() {
		return getStr(getBizProfit());
	}
	public String getCommonCostStr() {
		return getStr(commonCost);
	}
	public String getNetProfitStr() {
		return getStr(getNetProfit());
	}
}

