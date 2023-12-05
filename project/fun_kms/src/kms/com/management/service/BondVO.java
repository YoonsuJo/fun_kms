package kms.com.management.service;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class BondVO extends Bond {
	
	private String searchAllPeriod = "N";
	private String noColOnly = "N";
	private String includeResult = "N";
	private String searchBusiId = "";
	private String searchOrgId = "";
	private String[] searchOrgIdList;
	private String searchOrgNm = "";
	private String[] searchOrgNmList;
	//private String startDate = CalendarUtil.getToday().substring(0,4) + "0101";
	//private String startDate = Integer.toString(CalendarUtil.getLastYear()) + "0101";
	private String startDate = "20120101";	// [20150116, dwkim] 2012년 1월 2일로 fix, 안태규부장님 요청
	//private String startDate = Integer.toString(CalendarUtil.getYear()) + "0101";
	
	private String endDate = CalendarUtil.getToday();
	private Integer searchUserNo;
	
	private String searchIncMngd;	// [2015/02/6, dwkim] 검색조건 관리대상 포함 추가
	
	private String searchMappingFlag;	// [2015/07/01, dwkim] 매출문서와 매핑여부, 조회타입
	
	public String getNoColOnly() {
		return noColOnly;
	}
	public void setNoColOnly(String searchNoCollectionOnly) {
		this.noColOnly = searchNoCollectionOnly;
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
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setIncludeResult(String includeResult) {
		this.includeResult = includeResult;
	}
	public String getIncludeResult() {
		return includeResult;
	}
	public void setSearchBusiId(String searchBusiId) {
		this.searchBusiId = searchBusiId;
	}
	public String getSearchBusiId() {
		return searchBusiId;
	}
	public void setSearchOrgIdList(String[] searchOrgIdList) {
		this.searchOrgIdList = searchOrgIdList;
	}
	public String[] getSearchOrgIdList() {
		return searchOrgIdList;
	}
	public void setSearchOrgNmList(String[] searchOrgNmList) {
		this.searchOrgNmList = searchOrgNmList;
	}
	public String[] getSearchOrgNmList() {
		return searchOrgNmList;
	}
	public String getStartDate() {
		return this.startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return this.endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return the searchUserNo
	 */
	public Integer getSearchUserNo() {
		return searchUserNo;
	}
	/**
	 * @param searchUserNo the searchUserNo to set
	 */
	public void setSearchUserNo(Integer searchUserNo) {
		this.searchUserNo = searchUserNo;
	}
	/**
	 * @return the searchAllPeriod
	 */
	public String getSearchAllPeriod() {
		return searchAllPeriod;
	}
	/**
	 * @param searchAllPeriod the searchAllPeriod to set
	 */
	public void setSearchAllPeriod(String searchAllPeriod) {
		this.searchAllPeriod = searchAllPeriod;
	}
	public String getSearchIncMngd() {
		return searchIncMngd;
	}
	public void setSearchIncMngd(String searchIncMngd) {
		this.searchIncMngd = searchIncMngd;
	}
	public String getSearchMappingFlag() {
		return searchMappingFlag;
	}
	public void setSearchMappingFlag(String searchMappingFlag) {
		this.searchMappingFlag = searchMappingFlag;
	}

}
