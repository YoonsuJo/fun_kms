package kms.com.cooperation.service;

/**
 * @Class Name : MissionVO.java
 * @Description : MissionController class
 * @Modification Information
 *
 * @author 김대현
 * @since 2013.08.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class MissionVO extends Mission {
    private String searchKeyword = "";  
    private String searchWriterNm = "";
    private String searchPrjId = "";
    private String searchPrjNm = "";
    private String searchLeaderNm = "";
    private String searchLeaderMixes = "";
    private String searchDate = "";
    private String searchDateS = "";
    private String searchDateE = "";
    private String dateMove = "";
    private String today = "";
	private String leaderMixes = "";
	private String teamMember  = "";
	private String[] userList;
    private String type = "";
    private String includeEndMission = "";
    private String includeICMission = "";
    private String includeCMission = "";
    private Integer userNo;
    private String redirectUrl = "";
    private String statCnt = "";
    private String prjId = "";
    private int missionLv;
    private String topUseAt = "";
    
	public String getTopUseAt() {
		return topUseAt;
	}
	public void setTopUseAt(String topUseAt) {
		this.topUseAt = topUseAt;
	}
	public int getMissionLv() {
		return missionLv;
	}
	public void setMissionLv(int missionLv) {
		this.missionLv = missionLv;
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public String getStatCnt() {
		return statCnt;
	}
	public void setStatCnt(String statCnt) {
		this.statCnt = statCnt;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getSearchWriterNm() {
		return searchWriterNm;
	}
	public void setSearchWriterNm(String searchWriterNm) {
		this.searchWriterNm = searchWriterNm;
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

	
	
	public String getSearchLeaderNm() {
		return searchLeaderNm;
	}
	public void setSearchLeaderNm(String searchLeaderNm) {
		this.searchLeaderNm = searchLeaderNm;
	}
	
	public String getTeamMember() {
		return teamMember;
	}
	public void setTeamMember(String teamMember) {
		this.teamMember = teamMember;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param userNo the userNo to set
	 */
	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}
	/**
	 * @return the userNo
	 */
	public Integer getUserNo() {
		return userNo;
	}
	/**
	 * @param includeEndMission the includeEndMission to set
	 */
	public void setIncludeEndMission(String includeEndMission) {
		this.includeEndMission = includeEndMission;
	}
	/**
	 * @return the includeEndMission
	 */
	public String getIncludeEndMission() {
		return includeEndMission;
	}
	

	






	public String getSearchDateS() {
		return searchDateS;
	}
	public void setSearchDateS(String searchDateS) {
		this.searchDateS = searchDateS;
	}
	public String getSearchDateE() {
		return searchDateE;
	}
	public void setSearchDateE(String searchDateE) {
		this.searchDateE = searchDateE;
	}









	/** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 15;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 0;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 100000;

	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	/**
	 * @param redirectUrl the redirectUrl to set
	 */
	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}
	/**
	 * @return the redirectUrl
	 */
	public String getRedirectUrl() {
		return redirectUrl;
	}
	/**
	 * @param searchDate the searchDate to set
	 */
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	/**
	 * @return the searchDate
	 */
	public String getSearchDate() {
		return searchDate;
	}
	
	public String getLeaderMixes() {
		return leaderMixes;
	}
	public void setLeaderMixes(String leaderMixes) {
		this.leaderMixes = leaderMixes;
	}

	/**
	 * @param today the today to set
	 */
	public void setToday(String today) {
		this.today = today;
	}
	/**
	 * @return the today
	 */
	public String getToday() {
		return today;
	}
	/**
	 * @param dateMove the dateMove to set
	 */
	public void setDateMove(String dateMove) {
		this.dateMove = dateMove;
	}
	/**
	 * @return the dateMove
	 */
	public String getDateMove() {
		return dateMove;
	}
	/**
	 * @param userList the userList to set
	 */
	public void setUserList(String[] userList) {
		this.userList = userList;
	}
	/**
	 * @return the userList
	 */
	public String[] getUserList() {
		return userList;
	}
	public String getIncludeICMission() {
		return includeICMission;
	}
	public void setIncludeICMission(String includeICMission) {
		this.includeICMission = includeICMission;
	}
	/**
	 * @param includeCMission the includeCMission to set
	 */
	public void setIncludeCMission(String includeCMission) {
		this.includeCMission = includeCMission;
	}
	/**
	 * @return the includeCMission
	 */
	public String getIncludeCMission() {
		return includeCMission;
	}
	/**
	 * @param searchLeaderMixes the searchLeaderMixes to set
	 */
	public void setSearchLeaderMixes(String searchLeaderMixes) {
		this.searchLeaderMixes = searchLeaderMixes;
	}
	/**
	 * @return the searchLeaderMixes
	 */
	public String getSearchLeaderMixes() {
		return searchLeaderMixes;
	}
}
