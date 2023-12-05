package kms.com.management.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

public class PlanCost implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Getter @Setter private String orgnztId = "";
	@Getter @Setter private String orgnztNm = "";
	@Getter @Setter private String prjId = "";
	@Getter @Setter private String prjNm = "";
	@Getter @Setter private String prjCd = "";
	@Getter @Setter private long planExp = 0;
	@Getter @Setter private long planLabor = 0;
	@Getter @Setter private long salesOut = 0;
	@Getter @Setter private long salesIn = 0;
	@Getter @Setter private long purchaseOut = 0;
	@Getter @Setter private long purchaseIn = 0;
	@Getter @Setter private long common = 0;
	@Getter @Setter private long year = 0;
	@Getter @Setter private long month = 0;
	@Getter @Setter private String stat = "";
	
	
	public long getSalesProfit() {
		return salesOut + salesIn - purchaseOut - purchaseIn;
	}
	public long getBusiProfit() {
		return getSalesProfit() - planLabor- planExp - common;
	}
}
