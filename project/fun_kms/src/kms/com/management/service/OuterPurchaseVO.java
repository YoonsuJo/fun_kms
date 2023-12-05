package kms.com.management.service;

public class OuterPurchaseVO extends OuterPurchase {
	private String searchType= "";	// ORG, PRJ, DOC
	
	private String searchStartDate = "";
	private String searchEndDate = "";
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String searchPrjId = "";
	private String searchPrjNm = "";
	private String searchDocId = "";
	private String searchIncEndPrj = "N";		// 종료된 프로젝트 포함
	private String searchIncAllTarget = "N";	// 모든 관리 대상 포함(사외매입액,비용 계산)
	private String searchDecideYn = "";	// 모든 관리 대상 포함(사외매입액,비용 계산)
	private String searchNewAt = "1";	// 매출 유/무효 구분 (무효화된 매출건에 대한 매입액을 추억하기 위함)
	
	private String[] searchOrgIdList;
	private String[] searchPrjIdList;
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchStartDate() {
		return searchStartDate;
	}
	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}
	public String getSearchEndDate() {
		return searchEndDate;
	}
	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}
	public String getSearchOrgId() {
		return searchOrgId;
	}
	public void setSearchOrgId(String searchOrgId) {
		this.searchOrgId = searchOrgId;
	}
	public String getSearchOrgNm() {
		return searchOrgNm;
	}
	public void setSearchOrgNm(String searchOrgNm) {
		this.searchOrgNm = searchOrgNm;
	}
	public String getSearchPrjId() {
		return searchPrjId;
	}
	public void setSearchPrjId(String searchPrjId) {
		this.searchPrjId = searchPrjId;
	}
	public String getSearchPrjNm() {
		return searchPrjNm;
	}
	public void setSearchPrjNm(String searchPrjNm) {
		this.searchPrjNm = searchPrjNm;
	}
	public String[] getSearchOrgIdList() {
		return searchOrgIdList;
	}
	public void setSearchOrgIdList(String[] searchOrgIdList) {
		this.searchOrgIdList = searchOrgIdList;
	}
	public String[] getSearchPrjIdList() {
		return searchPrjIdList;
	}
	public void setSearchPrjIdList(String[] searchPrjIdList) {
		this.searchPrjIdList = searchPrjIdList;
	}
	public String getSearchDocId() {
		return searchDocId;
	}
	public void setSearchDocId(String searchDocId) {
		this.searchDocId = searchDocId;
	}
	public String getSearchIncEndPrj() {
		return searchIncEndPrj;
	}
	public void setSearchIncEndPrj(String searchIncEndPrj) {
		this.searchIncEndPrj = searchIncEndPrj;
	}
	public String getSearchIncAllTarget() {
		return searchIncAllTarget;
	}
	public void setSearchIncAllTarget(String searchIncAllTarget) {
		this.searchIncAllTarget = searchIncAllTarget;
	}
	public String getSearchDecideYn() {
		return searchDecideYn;
	}
	public void setSearchDecideYn(String searchDecideYn) {
		this.searchDecideYn = searchDecideYn;
	}
	public String getSearchNewAt() {
		return searchNewAt;
	}
	public void setSearchNewAt(String searchNewAt) {
		this.searchNewAt = searchNewAt;
	}
}
