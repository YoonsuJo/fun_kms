package kms.com.salary.service;

import java.io.Serializable;


import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : MemberEvaVO.java
 * @Description : MemberEva VO class
 * @Modification Information
 *
 * @author 박기현
 * @since 2012.11.27
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class MemberEvaVO extends MemberEva {
		
	/** 검색조건 */
    private String searchCondition = "1";
        
    /** 검색Keyword */
    private String searchKeyword = "";
    private String searchUserNm = "";
    private String searchOrgNm = "";
    private String searchOrgId = "";
    private String[] searchOrgIdList;
    private String[] searchKeywordList;
    private String searchNm = "";
	private String[] workStList;
	private String orderBy;
	
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
    
    private int salaryList[];
    
    
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

	public void setSalaryList(int salaryList[]) {
		this.salaryList = salaryList;
	}

	public int[] getSalaryList() {
		return salaryList;
	}
	
	/**
	 * @return the workStList
	 */
	public String[] getWorkStList() {
		return workStList;
	}
	public void setWorkStList(String[] workStList) {
		this.workStList = workStList;
	}
	public boolean isWorking() {
		for (int i=0; i<workStList.length; i++) {
			if (workStList[i].equals("W"))
				return true;
		}
		return false;
	}
	public boolean isLeaved() {
		for (int i=0; i<workStList.length; i++) {
			if (workStList[i].equals("L"))
				return true;
		}
		return false;
	}
	public boolean isRetired() {
		for (int i=0; i<workStList.length; i++) {
			if (workStList[i].equals("R"))
				return true;
		}
		return false;
	}
    /**
	 * @return the orderBy
	 */
	public String getOrderBy() {
		return orderBy;
	}
	/**
	 * @param orderBy the orderBy to set
	 */
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	
	/* 가상 함수 */
	public void setSearchOrgNm(String searchOrgNm) {
		this.searchOrgNm = searchOrgNm;
	}

	public String getSearchOrgNm() {
		return searchOrgNm;
	}

	public void setSearchOrgId(String searchOrgId) {
		this.searchOrgId = searchOrgId;
	}

	public String getSearchOrgId() {
		return searchOrgId;
	}

	public void setSearchUserNm(String searchUserNm) {
		this.searchUserNm = searchUserNm;
	}

	public String getSearchUserNm() {
		return searchUserNm;
	}

	public void setSearchOrgIdList(String[] searchOrgIdList) {
		this.searchOrgIdList = searchOrgIdList;
	}

	public String[] getSearchOrgIdList() {
		return searchOrgIdList;
	}

	public void setSearchKeywordList(String[] searchKeywordList) {
		this.searchKeywordList = searchKeywordList;
	}

	public String[] getSearchKeywordList() {
		return searchKeywordList;
	}

	public void setSearchNm(String searchNm) {
		this.searchNm = searchNm;
	}

	public String getSearchNm() {
		return searchNm;
	}

}
