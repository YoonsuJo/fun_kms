package kms.com.support.service;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;



public class CardVO extends Card{

	private static final long serialVersionUID = 1L;
	private String[] searchStatList={"N"};
	private String searchUserNm;
	private String searchOrgnztId;
	private String searchOrgnztNm;
	private String searchCompanyCd;
	private String searchCompanyAll = "true";
	private String searchProvided = "true";
	private String searchUnProvided = "true";
	private String searchUserOrgnzt;
	private String[] checkList;
	
	public void setSearchStatList(String[] searchStatList) {
		this.searchStatList = searchStatList;
	}
	public String[] getSearchStatList() {
		return searchStatList;
	}
	public void setSearchUserNm(String searchUserNm) {
		this.searchUserNm = searchUserNm;
	}
	public String getSearchUserNm() {
		return searchUserNm;
	}
	public void setSearchOrgnztId(String searchOrgnztId) {
		this.searchOrgnztId = searchOrgnztId;
	}
	public String getSearchOrgnztId() {
		return searchOrgnztId;
	}
	public void setSearchProvided(String searchProvided) {
		this.searchProvided = searchProvided;
	}
	public String getSearchProvided() {
		return searchProvided;
	}
	public void setSearchUnProvided(String searchUnProvided) {
		this.searchUnProvided = searchUnProvided;
	}
	public String getSearchUnProvided() {
		return searchUnProvided;
	}
	public void setSearchUserOrgnzt(String searchUserOrgnzt) {
		this.searchUserOrgnzt = searchUserOrgnzt;
	}
	public String getSearchUserOrgnzt() {
		return searchUserOrgnzt;
	}
	public void setSearchOrgnztNm(String searchOrgnztNm) {
		this.searchOrgnztNm = searchOrgnztNm;
	}
	public String getSearchOrgnztNm() {
		return searchOrgnztNm;
	}
	public void setSearchCompanyCd(String searchCompanyCd) {
		this.searchCompanyCd = searchCompanyCd;
	}
	public String getSearchCompanyCd() {
		return searchCompanyCd;
	}
	public void setSearchCompanyAll(String searchCompanyAll) {
		this.searchCompanyAll = searchCompanyAll;
	}
	public String getSearchCompanyAll() {
		return searchCompanyAll;
	}
	public void setCheckList(String[] checkList) {
		this.checkList = checkList;
	}
	public String[] getCheckList() {
		return checkList;
	}
	
	
}
