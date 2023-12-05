package kms.com.management.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

import kms.com.management.vo.BizStatisticVO;


public class BizStatisticRateVO {
	
	@Getter @Setter private String salesOutRate = "";
	@Getter @Setter private String salesInRate = "";
	@Getter @Setter private String purchaseOutRate = "";
	@Getter @Setter private String purchaseInRate = "";
	@Getter @Setter private String salesProfitRate = "";
	@Getter @Setter private String laborRate = "";
	@Getter @Setter private String expenseRate = "";
	@Getter @Setter private String bizProfitRate = "";
	@Getter @Setter private String commonCostRate = "";
	@Getter @Setter private String netProfitRate = "";

	public BizStatisticRateVO(BizStatisticVO planVO, BizStatisticVO resultVO) throws Exception {
		salesOutRate 		= calRate(planVO.getSalesOut(), 			resultVO.getSalesOut());
		salesInRate 			= calRate(planVO.getSalesIn(), 			resultVO.getSalesIn());
		purchaseOutRate 	= calRate(planVO.getPurchaseOut(), 		resultVO.getPurchaseOut());
		purchaseInRate 		= calRate(planVO.getPurchaseIn(),		resultVO.getPurchaseIn());
		laborRate 			= calRate(planVO.getLabor(), 				resultVO.getLabor());
		expenseRate 		= calRate(planVO.getExpense(), 			resultVO.getExpense());
		commonCostRate 	= calRate(planVO.getCommonCost(), 	resultVO.getCommonCost());

		salesProfitRate 		= calRate(planVO.getSalesProfit(), 		resultVO.getSalesProfit());
		bizProfitRate 			= calRate(planVO.getBizProfit(), 			resultVO.getBizProfit());
		netProfitRate 		= calRate(planVO.getNetProfit(), 			resultVO.getNetProfit());
	}

	public String calRate(long plan, long result) throws Exception {
		if (plan == 0)
			return "NAN";
		float rate = ((float)result/(float)plan) * 100;
		if(rate >= 10) {
			return String.format("%.0f", rate);
		}
		else {
			return String.format("%.1f", rate);
		}
	}
}
