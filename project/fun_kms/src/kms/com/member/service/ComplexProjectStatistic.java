package kms.com.member.service;

import kms.com.common.utils.CalendarUtil;
import org.apache.commons.lang.builder.ToStringBuilder;

public class ComplexProjectStatistic {
	
	private String userOrgNm;
	private String userNm;
	private String prjCd;
	private String prjNm;	
	private String prjOrgNm;
	private Double orgRatio = 0.0;
	private Integer repeatCount;
	private Double realRatio = 0.0;
	private Long salesOut;
	private Long salesIn;
	private Long purchaseOut;
	private Long purchaseInNormal;
	private Long salesProfit;
	private Long labor;
	private Long exp;
	private Long purchaseInCommon;
	private Long totalProfit;
	private Long prjSalesInLabor;
	
	private String p1PrjCd;
	private String p1PrjNm;
	private String p1OrgNm;
	private Long p1SalesOut;
	private Long p1SalesIn;
	private Long p1PurchaseOut;
	private Long p1PurchaseInNoraml;
	private Long p1SalesProfit;
	private Long p1Labor;
	private Long p1Exp;
	private Long p1PurchaseInCommon;
	private Long p1TotalProfit;
	private Long p1PrjSalesInLabor;
	
	private String p2PrjCd;
	private String p2PrjNm;
	private String p2OrgNm;
	private Long p2SalesOut;
	private Long p2SalesIn;
	private Long p2PurchaseOut;
	private Long p2PurchaseInNoraml;
	private Long p2SalesProfit;
	private Long p2Labor;
	private Long p2Exp;
	private Long p2PurchaseInCommon;
	private Long p2TotalProfit;
	private Long p2PrjSalesInLabor;
	
	private String p3PrjCd;
	private String p3PrjNm;
	private String p3OrgNm;
	private Long p3SalesOut;
	private Long p3SalesIn;
	private Long p3PurchaseOut;
	private Long p3PurchaseInNoraml;
	private Long p3SalesProfit;
	private Long p3Labor;
	private Long p3Exp;
	private Long p3PurchaseInCommon;
	private Long p3TotalProfit;
	private Long p3PrjSalesInLabor;

	private String p4PrjCd;
	private String p4PrjNm;
	private String p4OrgNm;
	private Long p4SalesOut;
	private Long p4SalesIn;
	private Long p4PurchaseOut;
	private Long p4PurchaseInNoraml;
	private Long p4SalesProfit;
	private Long p4Labor;
	private Long p4Exp;
	private Long p4PurchaseInCommon;
	private Long p4TotalProfit;
	private Long p4PrjSalesInLabor;
	
	
	/**
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	

	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setUserOrgNm(String userOrgNm) {
		this.userOrgNm = userOrgNm;
	}
	public String getUserOrgNm() {
		return userOrgNm;
	}
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	public String getPrjCd() {
		return prjCd;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjOrgNm(String prjOrgNm) {
		this.prjOrgNm = prjOrgNm;
	}
	public String getPrjOrgNm() {
		return prjOrgNm;
	}
	public void setOrgRatio(Double orgRatio) {
		this.orgRatio = orgRatio;
	}
	public Double getOrgRatio() {
		return orgRatio;
	}
	public void setRepeatCount(int repeatCount) {
		this.repeatCount = repeatCount;
	}
	public int getRepeatCount() {
		return repeatCount;
	}
	public void setRealRatio(Double realRatio) {
		this.realRatio = realRatio;
	}
	public Double getRealRatio() {
		return realRatio;
	}
	public void setSalesOut(Long salesOut) {
		this.salesOut = salesOut;
	}
	public Long getSalesOut() {
		return salesOut;
	}
	public void setSalesIn(Long salesIn) {
		this.salesIn = salesIn;
	}
	public Long getSalesIn() {
		return salesIn;
	}
	public void setPurchaseOut(Long purchaseOut) {
		this.purchaseOut = purchaseOut;
	}
	public Long getPurchaseOut() {
		return purchaseOut;
	}
	public void setPurchaseInNormal(Long purchaseInNormal) {
		this.purchaseInNormal = purchaseInNormal;
	}
	public Long getPurchaseInNormal() {
		return purchaseInNormal;
	}
	public void setSalesProfit(Long salesProfit) {
		this.salesProfit = salesProfit;
	}
	public Long getSalesProfit() {
		return salesProfit;
	}
	public void setLabor(Long labor) {
		this.labor = labor;
	}
	public Long getLabor() {
		return labor;
	}
	public void setExp(Long exp) {
		this.exp = exp;
	}
	public Long getExp() {
		return exp;
	}
	public void setPurchaseInCommon(Long purchaseInCommon) {
		this.purchaseInCommon = purchaseInCommon;
	}
	public Long getPurchaseInCommon() {
		return purchaseInCommon;
	}
	public void setTotalProfit(Long totalProfit) {
		this.totalProfit = totalProfit;
	}
	public Long getTotalProfit() {
		return totalProfit;
	}
	public void setPrjSalesInLabor(Long prjSalesInLabor) {
		this.prjSalesInLabor = prjSalesInLabor;
	}
	public Long getPrjSalesInLabor() {
		return prjSalesInLabor;
	}
	public void setP1PrjCd(String p1PrjCd) {
		this.p1PrjCd = p1PrjCd;
	}
	public String getP1PrjCd() {
		return p1PrjCd;
	}
	public void setP1PrjNm(String p1PrjNm) {
		this.p1PrjNm = p1PrjNm;
	}
	public String getP1PrjNm() {
		return p1PrjNm;
	}
	public void setP1OrgNm(String p1OrgNm) {
		this.p1OrgNm = p1OrgNm;
	}
	public String getP1OrgNm() {
		return p1OrgNm;
	}
	public void setP1SalesOut(Long p1SalesOut) {
		this.p1SalesOut = p1SalesOut;
	}
	public Long getP1SalesOut() {
		return p1SalesOut;
	}
	public void setP1SalesIn(Long p1SalesIn) {
		this.p1SalesIn = p1SalesIn;
	}
	public Long getP1SalesIn() {
		return p1SalesIn;
	}
	public void setP1PurchaseOut(Long p1PurchaseOut) {
		this.p1PurchaseOut = p1PurchaseOut;
	}
	public Long getP1PurchaseOut() {
		return p1PurchaseOut;
	}
	public void setP1PurchaseInNoraml(Long p1PurchaseInNoraml) {
		this.p1PurchaseInNoraml = p1PurchaseInNoraml;
	}
	public Long getP1PurchaseInNoraml() {
		return p1PurchaseInNoraml;
	}
	public void setP1SalesProfit(Long p1SalesProfit) {
		this.p1SalesProfit = p1SalesProfit;
	}
	public Long getP1SalesProfit() {
		return p1SalesProfit;
	}
	public void setP1Labor(Long p1Labor) {
		this.p1Labor = p1Labor;
	}
	public Long getP1Labor() {
		return p1Labor;
	}
	public void setP1Exp(Long p1Exp) {
		this.p1Exp = p1Exp;
	}
	public Long getP1Exp() {
		return p1Exp;
	}
	public void setP1PurchaseInCommon(Long p1PurchaseInCommon) {
		this.p1PurchaseInCommon = p1PurchaseInCommon;
	}
	public Long getP1PurchaseInCommon() {
		return p1PurchaseInCommon;
	}
	public void setP1TotalProfit(Long p1TotalProfit) {
		this.p1TotalProfit = p1TotalProfit;
	}
	public Long getP1TotalProfit() {
		return p1TotalProfit;
	}
	public void setP1PrjSalesInLabor(Long p1PrjSalesInLabor) {
		this.p1PrjSalesInLabor = p1PrjSalesInLabor;
	}
	public Long getP1PrjSalesInLabor() {
		return p1PrjSalesInLabor;
	}
	public void setP2PrjCd(String p2PrjCd) {
		this.p2PrjCd = p2PrjCd;
	}
	public String getP2PrjCd() {
		return p2PrjCd;
	}
	public void setP2PrjNm(String p2PrjNm) {
		this.p2PrjNm = p2PrjNm;
	}
	public String getP2PrjNm() {
		return p2PrjNm;
	}
	public void setP2OrgNm(String p2OrgNm) {
		this.p2OrgNm = p2OrgNm;
	}
	public String getP2OrgNm() {
		return p2OrgNm;
	}
	public void setP2SalesOut(Long p2SalesOut) {
		this.p2SalesOut = p2SalesOut;
	}
	public Long getP2SalesOut() {
		return p2SalesOut;
	}
	public void setP2SalesIn(Long p2SalesIn) {
		this.p2SalesIn = p2SalesIn;
	}
	public Long getP2SalesIn() {
		return p2SalesIn;
	}
	public void setP2PurchaseOut(Long p2PurchaseOut) {
		this.p2PurchaseOut = p2PurchaseOut;
	}
	public Long getP2PurchaseOut() {
		return p2PurchaseOut;
	}
	public void setP2PurchaseInNoraml(Long p2PurchaseInNoraml) {
		this.p2PurchaseInNoraml = p2PurchaseInNoraml;
	}
	public Long getP2PurchaseInNoraml() {
		return p2PurchaseInNoraml;
	}
	public void setP2SalesProfit(Long p2SalesProfit) {
		this.p2SalesProfit = p2SalesProfit;
	}
	public Long getP2SalesProfit() {
		return p2SalesProfit;
	}
	public void setP2Labor(Long p2Labor) {
		this.p2Labor = p2Labor;
	}
	public Long getP2Labor() {
		return p2Labor;
	}
	public void setP2Exp(Long p2Exp) {
		this.p2Exp = p2Exp;
	}
	public Long getP2Exp() {
		return p2Exp;
	}
	public void setP2PurchaseInCommon(Long p2PurchaseInCommon) {
		this.p2PurchaseInCommon = p2PurchaseInCommon;
	}
	public Long getP2PurchaseInCommon() {
		return p2PurchaseInCommon;
	}
	public void setP2TotalProfit(Long p2TotalProfit) {
		this.p2TotalProfit = p2TotalProfit;
	}
	public Long getP2TotalProfit() {
		return p2TotalProfit;
	}
	public void setP2PrjSalesInLabor(Long p2PrjSalesInLabor) {
		this.p2PrjSalesInLabor = p2PrjSalesInLabor;
	}
	public Long getP2PrjSalesInLabor() {
		return p2PrjSalesInLabor;
	}
	public void setP3PrjCd(String p3PrjCd) {
		this.p3PrjCd = p3PrjCd;
	}
	public String getP3PrjCd() {
		return p3PrjCd;
	}
	public void setP3PrjNm(String p3PrjNm) {
		this.p3PrjNm = p3PrjNm;
	}
	public String getP3PrjNm() {
		return p3PrjNm;
	}
	public void setP3OrgNm(String p3OrgNm) {
		this.p3OrgNm = p3OrgNm;
	}
	public String getP3OrgNm() {
		return p3OrgNm;
	}
	public void setP3SalesOut(Long p3SalesOut) {
		this.p3SalesOut = p3SalesOut;
	}
	public Long getP3SalesOut() {
		return p3SalesOut;
	}
	public void setP3SalesIn(Long p3SalesIn) {
		this.p3SalesIn = p3SalesIn;
	}
	public Long getP3SalesIn() {
		return p3SalesIn;
	}
	public void setP3PurchaseOut(Long p3PurchaseOut) {
		this.p3PurchaseOut = p3PurchaseOut;
	}
	public Long getP3PurchaseOut() {
		return p3PurchaseOut;
	}
	public void setP3PurchaseInNoraml(Long p3PurchaseInNoraml) {
		this.p3PurchaseInNoraml = p3PurchaseInNoraml;
	}
	public Long getP3PurchaseInNoraml() {
		return p3PurchaseInNoraml;
	}
	public void setP3SalesProfit(Long p3SalesProfit) {
		this.p3SalesProfit = p3SalesProfit;
	}
	public Long getP3SalesProfit() {
		return p3SalesProfit;
	}
	public void setP3Labor(Long p3Labor) {
		this.p3Labor = p3Labor;
	}
	public Long getP3Labor() {
		return p3Labor;
	}
	public void setP3Exp(Long p3Exp) {
		this.p3Exp = p3Exp;
	}
	public Long getP3Exp() {
		return p3Exp;
	}
	public void setP3PurchaseInCommon(Long p3PurchaseInCommon) {
		this.p3PurchaseInCommon = p3PurchaseInCommon;
	}
	public Long getP3PurchaseInCommon() {
		return p3PurchaseInCommon;
	}
	public void setP3TotalProfit(Long p3TotalProfit) {
		this.p3TotalProfit = p3TotalProfit;
	}
	public Long getP3TotalProfit() {
		return p3TotalProfit;
	}
	public void setP3PrjSalesInLabor(Long p3PrjSalesInLabor) {
		this.p3PrjSalesInLabor = p3PrjSalesInLabor;
	}
	public Long getP3PrjSalesInLabor() {
		return p3PrjSalesInLabor;
	}
	public void setP4PrjCd(String p4PrjCd) {
		this.p4PrjCd = p4PrjCd;
	}
	public String getP4PrjCd() {
		return p4PrjCd;
	}
	public void setP4PrjNm(String p4PrjNm) {
		this.p4PrjNm = p4PrjNm;
	}
	public String getP4PrjNm() {
		return p4PrjNm;
	}
	public void setP4OrgNm(String p4OrgNm) {
		this.p4OrgNm = p4OrgNm;
	}
	public String getP4OrgNm() {
		return p4OrgNm;
	}
	public void setP4SalesOut(Long p4SalesOut) {
		this.p4SalesOut = p4SalesOut;
	}
	public Long getP4SalesOut() {
		return p4SalesOut;
	}
	public void setP4SalesIn(Long p4SalesIn) {
		this.p4SalesIn = p4SalesIn;
	}
	public Long getP4SalesIn() {
		return p4SalesIn;
	}
	public void setP4PurchaseOut(Long p4PurchaseOut) {
		this.p4PurchaseOut = p4PurchaseOut;
	}
	public Long getP4PurchaseOut() {
		return p4PurchaseOut;
	}
	public void setP4PurchaseInNoraml(Long p4PurchaseInNoraml) {
		this.p4PurchaseInNoraml = p4PurchaseInNoraml;
	}
	public Long getP4PurchaseInNoraml() {
		return p4PurchaseInNoraml;
	}
	public void setP4SalesProfit(Long p4SalesProfit) {
		this.p4SalesProfit = p4SalesProfit;
	}
	public Long getP4SalesProfit() {
		return p4SalesProfit;
	}
	public void setP4Labor(Long p4Labor) {
		this.p4Labor = p4Labor;
	}
	public Long getP4Labor() {
		return p4Labor;
	}
	public void setP4Exp(Long p4Exp) {
		this.p4Exp = p4Exp;
	}
	public Long getP4Exp() {
		return p4Exp;
	}
	public void setP4PurchaseInCommon(Long p4PurchaseInCommon) {
		this.p4PurchaseInCommon = p4PurchaseInCommon;
	}
	public Long getP4PurchaseInCommon() {
		return p4PurchaseInCommon;
	}
	public void setP4TotalProfit(Long p4TotalProfit) {
		this.p4TotalProfit = p4TotalProfit;
	}
	public Long getP4TotalProfit() {
		return p4TotalProfit;
	}
	public void setP4PrjSalesInLabor(Long p4PrjSalesInLabor) {
		this.p4PrjSalesInLabor = p4PrjSalesInLabor;
	}
	public Long getP4PrjSalesInLabor() {
		return p4PrjSalesInLabor;
	}

}
