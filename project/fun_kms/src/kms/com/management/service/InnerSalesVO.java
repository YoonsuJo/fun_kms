package kms.com.management.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class InnerSalesVO {
	private String salesPrjId;
	private String salesPrjCd;
	private String salesPrjNm;
	private String salesOrgId;
	private String salesOrgNm;
	private String purchasePrjId;
	private String purchasePrjCd;
	private String purchasePrjNm;
	private String purchaseOrgId;
	private String purchaseOrgNm;
	private Integer cost;
	
	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	private Integer searchMonth = Integer.parseInt(CalendarUtil.getToday().substring(4,6));
	
	private String searchConditionSales = "0";
	private String searchOrgIdSales = "";
	private String searchOrgNmSales = "";
	private String[] searchOrgIdSalesList;
	private String searchPrjIdSales = "";
	private String searchPrjNmSales = "";
	private String includeUnderPrjSales = "N";
	
	private String searchConditionPurchase = "0";
	private String searchOrgIdPurchase = "";
	private String searchOrgNmPurchase = "";
	private String[] searchOrgIdPurchaseList;
	private String searchPrjIdPurchase = "";
	private String searchPrjNmPurchase = "";
	private String includeUnderPrjPurchase = "N";
	
	private String includeResult;
	/**
	 * @return the salesPrjId
	 */
	public String getSalesPrjId() {
		return salesPrjId;
	}
	/**
	 * @param salesPrjId the salesPrjId to set
	 */
	public void setSalesPrjId(String salesPrjId) {
		this.salesPrjId = salesPrjId;
	}
	/**
	 * @return the salesPrjCd
	 */
	public String getSalesPrjCd() {
		return salesPrjCd;
	}
	/**
	 * @param salesPrjCd the salesPrjCd to set
	 */
	public void setSalesPrjCd(String salesPrjCd) {
		this.salesPrjCd = salesPrjCd;
	}
	/**
	 * @return the salesPrjNm
	 */
	public String getSalesPrjNm() {
		return salesPrjNm;
	}
	/**
	 * @param salesPrjNm the salesPrjNm to set
	 */
	public void setSalesPrjNm(String salesPrjNm) {
		this.salesPrjNm = salesPrjNm;
	}
	/**
	 * @return the salesOrgId
	 */
	public String getSalesOrgId() {
		return salesOrgId;
	}
	/**
	 * @param salesOrgId the salesOrgId to set
	 */
	public void setSalesOrgId(String salesOrgId) {
		this.salesOrgId = salesOrgId;
	}
	/**
	 * @return the salesOrgNm
	 */
	public String getSalesOrgNm() {
		return salesOrgNm;
	}
	/**
	 * @param salesOrgNm the salesOrgNm to set
	 */
	public void setSalesOrgNm(String salesOrgNm) {
		this.salesOrgNm = salesOrgNm;
	}
	/**
	 * @return the purchasePrjId
	 */
	public String getPurchasePrjId() {
		return purchasePrjId;
	}
	/**
	 * @param purchasePrjId the purchasePrjId to set
	 */
	public void setPurchasePrjId(String purchasePrjId) {
		this.purchasePrjId = purchasePrjId;
	}
	/**
	 * @return the purchasePrjCd
	 */
	public String getPurchasePrjCd() {
		return purchasePrjCd;
	}
	/**
	 * @param purchasePrjCd the purchasePrjCd to set
	 */
	public void setPurchasePrjCd(String purchasePrjCd) {
		this.purchasePrjCd = purchasePrjCd;
	}
	/**
	 * @return the purchasePrjNm
	 */
	public String getPurchasePrjNm() {
		return purchasePrjNm;
	}
	/**
	 * @param purchasePrjNm the purchasePrjNm to set
	 */
	public void setPurchasePrjNm(String purchasePrjNm) {
		this.purchasePrjNm = purchasePrjNm;
	}
	/**
	 * @return the purchaseOrgId
	 */
	public String getPurchaseOrgId() {
		return purchaseOrgId;
	}
	/**
	 * @param purchaseOrgId the purchaseOrgId to set
	 */
	public void setPurchaseOrgId(String purchaseOrgId) {
		this.purchaseOrgId = purchaseOrgId;
	}
	/**
	 * @return the purchaseOrgNm
	 */
	public String getPurchaseOrgNm() {
		return purchaseOrgNm;
	}
	/**
	 * @param purchaseOrgNm the purchaseOrgNm to set
	 */
	public void setPurchaseOrgNm(String purchaseOrgNm) {
		this.purchaseOrgNm = purchaseOrgNm;
	}
	/**
	 * @return the cost
	 */
	public Integer getCost() {
		return cost;
	}
	public String getCostPrint() {
		return CommonUtil.insertCommaDivideBy(cost, 1000);
	}
	/**
	 * @param cost the cost to set
	 */
	public void setCost(Integer cost) {
		this.cost = cost;
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
	 * @return the searchConditionSales
	 */
	public String getSearchConditionSales() {
		return searchConditionSales;
	}
	/**
	 * @param searchConditionSales the searchConditionSales to set
	 */
	public void setSearchConditionSales(String searchConditionSales) {
		this.searchConditionSales = searchConditionSales;
	}
	/**
	 * @return the searchOrgIdSales
	 */
	public String getSearchOrgIdSales() {
		return searchOrgIdSales;
	}
	/**
	 * @param searchOrgIdSales the searchOrgIdSales to set
	 */
	public void setSearchOrgIdSales(String searchOrgIdSales) {
		this.searchOrgIdSales = searchOrgIdSales;
	}
	/**
	 * @return the searchOrgNmSales
	 */
	public String getSearchOrgNmSales() {
		return searchOrgNmSales;
	}
	/**
	 * @param searchOrgNmSales the searchOrgNmSales to set
	 */
	public void setSearchOrgNmSales(String searchOrgNmSales) {
		this.searchOrgNmSales = searchOrgNmSales;
	}
	/**
	 * @return the searchOrgIdSalesList
	 */
	public String[] getSearchOrgIdSalesList() {
		return searchOrgIdSalesList;
	}
	/**
	 * @param searchOrgIdSalesList the searchOrgIdSalesList to set
	 */
	public void setSearchOrgIdSalesList(String[] searchOrgIdSalesList) {
		this.searchOrgIdSalesList = searchOrgIdSalesList;
	}
	/**
	 * @return the searchPrjIdSales
	 */
	public String getSearchPrjIdSales() {
		return searchPrjIdSales;
	}
	/**
	 * @param searchPrjIdSales the searchPrjIdSales to set
	 */
	public void setSearchPrjIdSales(String searchPrjIdSales) {
		this.searchPrjIdSales = searchPrjIdSales;
	}
	/**
	 * @return the searchPrjNmSales
	 */
	public String getSearchPrjNmSales() {
		return searchPrjNmSales;
	}
	/**
	 * @param searchPrjNmSales the searchPrjNmSales to set
	 */
	public void setSearchPrjNmSales(String searchPrjNmSales) {
		this.searchPrjNmSales = searchPrjNmSales;
	}
	/**
	 * @return the includeUnderPrjSales
	 */
	public String getIncludeUnderPrjSales() {
		return includeUnderPrjSales;
	}
	/**
	 * @param includeUnderPrjSales the includeUnderPrjSales to set
	 */
	public void setIncludeUnderPrjSales(String includeUnderPrjSales) {
		this.includeUnderPrjSales = includeUnderPrjSales;
	}
	/**
	 * @return the searchConditionPurchase
	 */
	public String getSearchConditionPurchase() {
		return searchConditionPurchase;
	}
	/**
	 * @param searchConditionPurchase the searchConditionPurchase to set
	 */
	public void setSearchConditionPurchase(String searchConditionPurchase) {
		this.searchConditionPurchase = searchConditionPurchase;
	}
	/**
	 * @return the searchOrgIdPurchase
	 */
	public String getSearchOrgIdPurchase() {
		return searchOrgIdPurchase;
	}
	/**
	 * @param searchOrgIdPurchase the searchOrgIdPurchase to set
	 */
	public void setSearchOrgIdPurchase(String searchOrgIdPurchase) {
		this.searchOrgIdPurchase = searchOrgIdPurchase;
	}
	/**
	 * @return the searchOrgNmPurchase
	 */
	public String getSearchOrgNmPurchase() {
		return searchOrgNmPurchase;
	}
	/**
	 * @param searchOrgNmPurchase the searchOrgNmPurchase to set
	 */
	public void setSearchOrgNmPurchase(String searchOrgNmPurchase) {
		this.searchOrgNmPurchase = searchOrgNmPurchase;
	}
	/**
	 * @return the searchOrgIdPurchaseList
	 */
	public String[] getSearchOrgIdPurchaseList() {
		return searchOrgIdPurchaseList;
	}
	/**
	 * @param searchOrgIdPurchaseList the searchOrgIdPurchaseList to set
	 */
	public void setSearchOrgIdPurchaseList(String[] searchOrgIdPurchaseList) {
		this.searchOrgIdPurchaseList = searchOrgIdPurchaseList;
	}
	/**
	 * @return the searchPrjIdPurchase
	 */
	public String getSearchPrjIdPurchase() {
		return searchPrjIdPurchase;
	}
	/**
	 * @param searchPrjIdPurchase the searchPrjIdPurchase to set
	 */
	public void setSearchPrjIdPurchase(String searchPrjIdPurchase) {
		this.searchPrjIdPurchase = searchPrjIdPurchase;
	}
	/**
	 * @return the searchPrjNmPurchase
	 */
	public String getSearchPrjNmPurchase() {
		return searchPrjNmPurchase;
	}
	/**
	 * @param searchPrjNmPurchase the searchPrjNmPurchase to set
	 */
	public void setSearchPrjNmPurchase(String searchPrjNmPurchase) {
		this.searchPrjNmPurchase = searchPrjNmPurchase;
	}
	/**
	 * @return the includeUnderPrjPurchase
	 */
	public String getIncludeUnderPrjPurchase() {
		return includeUnderPrjPurchase;
	}
	/**
	 * @param includeUnderPrjPurchase the includeUnderPrjPurchase to set
	 */
	public void setIncludeUnderPrjPurchase(String includeUnderPrjPurchase) {
		this.includeUnderPrjPurchase = includeUnderPrjPurchase;
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
	
	
}
