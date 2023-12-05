package kms.com.cooperation.service;

import java.util.List;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class DayReportVO extends DayReport {
	
	
	/** 나의업무 S**/
	private String searchType = "";
	private String includeEnd = "";
	private String param_returnUrl = ""; 
	
	private String stateDYn = "";
	private String statePYn = "";
	private String stateCYn = "";
	private String searchWriterNm = "";
	

	
	
	/** 나의업무 E**/
	
	

	/** 검색조건 */
    private String searchCondition = "0";    
    /** 검색Keyword - 업무진행내역 */
    private String searchKeyword = "";
    private String searchUserNm = "";
    private String searchOrgId = "";
    private String[] searchOrgIdList;
    private String searchOrgNm = "";    
    private String searchPrjId = "";
    private String searchPrjNm = "";
    private String searchDate = CalendarUtil.getToday();
    private String searchFirstDateOfThisWeek = CalendarUtil.getFirstDateOfThisWeek(CalendarUtil.getToday());
    private String searchLastDateOfThisWeek = CalendarUtil.getLastDateOfThisWeek(CalendarUtil.getToday());
    private String searchDateInit = CalendarUtil.getFirstDateOfThisWeek2(CalendarUtil.getToday()); //기존 일요일 구하는 함수 변형한 월요일 구하는 함수로 변경
	private String searchDateFrom = CalendarUtil.getFirstDateOfThisWeek2(CalendarUtil.getToday());
	private String searchDateTo = CalendarUtil.getToday();	
	
	private String today = CalendarUtil.getToday();	
	
	
	private String searchUserMix = "";
	private String[] searchUserMixList;
	private Integer searchUserNo = 0;
	private String myOrgId = ""; //예하부서 검색용. 자기부서코드
	private String myOrgIdSec = "";
	
	private String excludeLeader;
	private String exceptionUsers; //제외할 사용자 번호
    private String[] exceptionUsersList; //제외할 사용자 번호 리스트
    
    /** 검색Keyword - 업무진행내역 검색 */
    private String searchText = "";
    private String searchSdate = "";
    private String searchEdate = "";
    private String searchUserId = "";
    private String[] searchUserIdList;
    private String includeUnderProject;
    
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
    
    /** 결과용 */
    private String taskSj;
    private String prjCd;
    private String prjNm;
    private String prjId;
    
    
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

	public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

	/**
	 * @return the searchUserNm
	 */
	public String getSearchUserNm() {
		return searchUserNm;
	}

	/**
	 * @param searchUserNm the searchUserNm to set
	 */
	public void setSearchUserNm(String searchUserNm) {
		this.searchUserNm = searchUserNm;
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

	/**
	 * @return the searchOrgIdList
	 */
	public String[] getSearchOrgIdList() {
		return searchOrgIdList;
	}

	/**
	 * @param searchOrgIdList the searchOrgIdList to set
	 */
	public void setSearchOrgIdList(String[] searchOrgIdList) {
		this.searchOrgIdList = searchOrgIdList;
	}

	/**
	 * @return the searchPrjId
	 */
	public String getSearchPrjId() {
		return searchPrjId;
	}

	/**
	 * @param searchPrjId the searchPrjId to set
	 */
	public void setSearchPrjId(String searchPrjId) {
		this.searchPrjId = searchPrjId;
	}

	/**
	 * @return the searchPrjNm
	 */
	public String getSearchPrjNm() {
		return searchPrjNm;
	}

	/**
	 * @param searchPrjNm the searchPrjNm to set
	 */
	public void setSearchPrjNm(String searchPrjNm) {
		this.searchPrjNm = searchPrjNm;
	}

	/**
	 * @return the searchText
	 */
	public String getSearchText() {
		return searchText;
	}

	/**
	 * @param searchText the searchText to set
	 */
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	/**
	 * @return the searchSdate
	 */
	public String getSearchSdate() {
		return searchSdate;
	}

	/**
	 * @param searchSdate the searchSdate to set
	 */
	public void setSearchSdate(String searchSdate) {
		this.searchSdate = searchSdate;
	}

	/**
	 * @return the searchEdate
	 */
	public String getSearchEdate() {
		return searchEdate;
	}

	/**
	 * @param searchEdate the searchEdate to set
	 */
	public void setSearchEdate(String searchEdate) {
		this.searchEdate = searchEdate;
	}

	/**
	 * @return the searchUserId
	 */
	public String getSearchUserId() {
		return searchUserId;
	}

	/**
	 * @param searchUserId the searchUserId to set
	 */
	public void setSearchUserId(String searchUserId) {
		this.searchUserId = searchUserId;
	}

	/**
	 * @return the searchUserIdList
	 */
	public String[] getSearchUserIdList() {
		return searchUserIdList;
	}

	/**
	 * @param searchUserIdList the searchUserIdList to set
	 */
	public void setSearchUserIdList(String[] searchUserIdList) {
		this.searchUserIdList = searchUserIdList;
	}

	/**
	 * @return the includeUnderProject
	 */
	public String getIncludeUnderProject() {
		return includeUnderProject;
	}

	/**
	 * @param includeUnderProject the includeUnderProject to set
	 */
	public void setIncludeUnderProject(String includeUnderProject) {
		this.includeUnderProject = includeUnderProject;
	}

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
    
    /**
	 * @return the taskSj
	 */
    public String getTaskSj() {
		return taskSj;
	}

    public String getTaskSjPrint() {
		return taskSj;
	}

	/**
	 * @param taskSj the taskSj to set
	 */
	public void setTaskSj(String taskSj) {
		this.taskSj = taskSj;
	}

	/**
	 * @return the prjCd
	 */
	public String getPrjCd() {
		return prjCd;
	}

	/**
	 * @param prjCd the prjCd to set
	 */
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}

	/**
	 * @return the prjNm
	 */
	public String getPrjNm() {
		return prjNm;
	}

	/**
	 * @param prjNm the prjNm to set
	 */
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}

	/**
	 * @return the prjId
	 */
	public String getPrjId() {
		return prjId;
	}

	/**
	 * @param prjId the prjId to set
	 */
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }

	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}

	public String getSearchDate() {
		return searchDate;
	}

	public void setSearchDateFrom(String searchDateFrom) {
		this.searchDateFrom = searchDateFrom;
	}

	public String getSearchDateFrom() {
		return searchDateFrom;
	}

	public void setSearchDateTo(String searchDateTo) {
		this.searchDateTo = searchDateTo;
	}

	public String getSearchDateTo() {
		return searchDateTo;
	}

	public void setSearchUserMix(String searchUserMix) {
		this.searchUserMix = searchUserMix;
	}

	public String getSearchUserMix() {
		return searchUserMix;
	}

	public void setSearchUserNo(Integer searchUserNo) {
		this.searchUserNo = searchUserNo;
	}

	public Integer getSearchUserNo() {
		return searchUserNo;
	}

	public void setExcludeLeader(String excludeLeader) {
		this.excludeLeader = excludeLeader;
	}

	public String getExcludeLeader() {
		return excludeLeader;
	}

	public void setExceptionUsers(String exceptionUsers) {
		this.exceptionUsers = exceptionUsers;
	}

	public String getExceptionUsers() {
		return exceptionUsers;
	}

	public void setExceptionUsersList(String[] exceptionUsersList) {
		this.exceptionUsersList = exceptionUsersList;
	}

	public String[] getExceptionUsersList() {
		return exceptionUsersList;
	}

	public void setSearchDateInit(String searchDateInit) {
		this.searchDateInit = searchDateInit;
	}

	public String getSearchDateInit() {
		return searchDateInit;
	}

	public void setMyOrgId(String myOrgId) {
		this.myOrgId = myOrgId;
	}

	public String getMyOrgId() {
		return myOrgId;
	}

	public void setSearchUserMixList(String[] searchUserMixList) {
		this.searchUserMixList = searchUserMixList;
	}

	public String[] getSearchUserMixList() {
		return searchUserMixList;
	}

	/**
	 * @param searchType the searchType to set
	 */
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	/**
	 * @return the searchType
	 */
	public String getSearchType() {
		return searchType;
	}

	/**
	 * @param includeEnd the includeEnd to set
	 */
	public void setIncludeEnd(String includeEnd) {
		this.includeEnd = includeEnd;
	}

	/**
	 * @return the includeEnd
	 */
	public String getIncludeEnd() {
		return includeEnd;
	}

	/**
	 * @param param_returnUrl the param_returnUrl to set
	 */
	public void setParam_returnUrl(String param_returnUrl) {
		this.param_returnUrl = param_returnUrl;
	}

	/**
	 * @return the param_returnUrl
	 */
	public String getParam_returnUrl() {
		return param_returnUrl;
	}

	/**
	 * @param searchWriterNm the searchWriterNm to set
	 */
	public void setSearchWriterNm(String searchWriterNm) {
		this.searchWriterNm = searchWriterNm;
	}

	/**
	 * @return the searchWriterNm
	 */
	public String getSearchWriterNm() {
		return searchWriterNm;
	}

	public String getStateDYn() {
		return stateDYn;
	}

	public void setStateDYn(String stateDYn) {
		this.stateDYn = stateDYn;
	}

	public String getStatePYn() {
		return statePYn;
	}

	public void setStatePYn(String statePYn) {
		this.statePYn = statePYn;
	}

	public String getStateCYn() {
		return stateCYn;
	}

	public void setStateCYn(String stateCYn) {
		this.stateCYn = stateCYn;
	}

	/**
	 * @param searchLastDateOfThisWeek the searchLastDateOfThisWeek to set
	 */
	public void setSearchLastDateOfThisWeek(String searchLastDateOfThisWeek) {
		this.searchLastDateOfThisWeek = searchLastDateOfThisWeek;
	}

	/**
	 * @return the searchLastDateOfThisWeek
	 */
	public String getSearchLastDateOfThisWeek() {
		return searchLastDateOfThisWeek;
	}

	/**
	 * @param searchFirstDateOfThisWeek the searchFirstDateOfThisWeek to set
	 */
	public void setSearchFirstDateOfThisWeek(String searchFirstDateOfThisWeek) {
		this.searchFirstDateOfThisWeek = searchFirstDateOfThisWeek;
	}

	/**
	 * @return the searchFirstDateOfThisWeek
	 */
	public String getSearchFirstDateOfThisWeek() {
		return searchFirstDateOfThisWeek;
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

	public String getMyOrgIdSec() {
		return myOrgIdSec;
	}

	public void setMyOrgIdSec(String myOrgIdSec) {
		this.myOrgIdSec = myOrgIdSec;
	}


}
