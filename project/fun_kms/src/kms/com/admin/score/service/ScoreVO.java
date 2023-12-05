package kms.com.admin.score.service;

import java.io.Serializable;


import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : TblScoreDefaultVO.java
 * @Description : TblScore Default VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ScoreVO extends Score{
	
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
    
      
    
    //form bbs value 를 받아오기 위해
    private int[] point1List;
    private int[] point2List;
    private int[] point3List;
    private int[] point4List;
    private String[] bbsCode;
    
    //각각 articleInsert, commentInser, viewEarly, viewLate을 받음
    private int ai;
    private int ci;
    private int ve;
    private int vl;
    
    //scoreDetail 삽입을 위한 변수
    private int userNo;
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

	public void setAi(int ai) {
		this.ai = ai;
	}

	public int getAi() {
		return ai;
	}

	public void setCi(int ci) {
		this.ci = ci;
	}

	public int getCi() {
		return ci;
	}

	public void setVe(int ve) {
		this.ve = ve;
	}

	public int getVe() {
		return ve;
	}

	public void setVl(int vl) {
		this.vl = vl;
	}

	public int getVl() {
		return vl;
	}

	public void setBbsCode(String[] bbsCode) {
		this.bbsCode = bbsCode;
	}

	public String[] getBbsCode() {
		return bbsCode;
	}

	public void setPoint1List(int[] point1List) {
		this.point1List = point1List;
	}

	public int[] getPoint1List() {
		return point1List;
	}

	public void setPoint2List(int[] point2List) {
		this.point2List = point2List;
	}

	public int[] getPoint2List() {
		return point2List;
	}

	public void setPoint3List(int[] point3List) {
		this.point3List = point3List;
	}

	public int[] getPoint3List() {
		return point3List;
	}

	public void setPoint4List(int[] point4List) {
		this.point4List = point4List;
	}

	public int[] getPoint4List() {
		return point4List;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getUserNo() {
		return userNo;
	}

}
