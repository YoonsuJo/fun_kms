package kms.com.support.service;

import java.io.Serializable;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : TblCardSpendDefaultVO.java
 * @Description : TblCardSpend Default VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.11.16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class CardSpendVO extends CardSpend {

	private String searchYear = CalendarUtil.getToday().substring(0,4);
	private String searchMonth = CalendarUtil.getToday().substring(4,6);
	private String searchCardId;
	private String searchUserNm;
	private String[] searchUserNmArr;
	private String searchAll;
	private String[] checkList;
	private String myOrgId;
	private String[] searchStatus;	// 상태값(1:결재중,2:완료,3:미상신)
	private String searchStatusStr;	// 상태값(javascript에서 쓸수있게 변환) : // [1, 2] -> "1,2"
	private String searchAdminAuth;	// 관리자 권한 여부
	
	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 15;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
        
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

    public String getSearchUseYn() {
        return searchUseYn;
    }

    public void setSearchUseYn(String searchUseYn) {
        this.searchUseYn = searchUseYn;
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

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}

	public String getSearchYear() {
		return searchYear;
	}

	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}

	public String getSearchMonth() {
		return searchMonth;
	}

	public void setSearchCardId(String searchCardId) {
		this.searchCardId = searchCardId;
	}

	public String getSearchCardId() {
		return searchCardId;
	}

	public void setSearchUserNm(String searchUserNm) {
		this.searchUserNm = searchUserNm;
	}

	public String getSearchUserNm() {
		return searchUserNm;
	}

	public void setCheckList(String[] checkList) {
		this.checkList = checkList;
	}

	public String[] getCheckList() {
		return checkList;
	}

	public void setSearchAll(String searchAll) {
		this.searchAll = searchAll;
	}

	public String getSearchAll() {
		return searchAll;
	}

	public void setMyOrgId(String myOrgId) {
		this.myOrgId = myOrgId;
	}

	public String getMyOrgId() {
		return myOrgId;
	}

	public String[] getSearchStatus() {
		return searchStatus;
	}

	public void setSearchStatus(String[] searchStatus) {
		this.searchStatus = searchStatus;
	}

	public String getSearchStatusStr() {
		return searchStatusStr;
	}

	public void setSearchStatusStr(String searchStatusStr) {
		this.searchStatusStr = searchStatusStr;
	}

	public String[] getSearchUserNmArr() {
		return searchUserNmArr;
	}

	public void setSearchUserNmArr(String[] searchUserNmArr) {
		this.searchUserNmArr = searchUserNmArr;
	}

	public String getSearchAdminAuth() {
		return searchAdminAuth;
	}

	public void setSearchAdminAuth(String searchAdminAuth) {
		this.searchAdminAuth = searchAdminAuth;
	}
}
