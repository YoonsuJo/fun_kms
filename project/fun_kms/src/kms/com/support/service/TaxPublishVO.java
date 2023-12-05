package kms.com.support.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

public class TaxPublishVO extends TaxPublish implements Serializable {

	/** 검색조건 */
    private String searchCondition = "0";
    
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
    
    private String searchSj = "";
    private String searchNm = "";
    private String userNm = "";
    private String bondStatN = "";
    private String bondStatY = "";
    private String bondStatC = "";
    private String untilToday = "";
    private String searchCompanyCd = "";
    private String searchPrjNm = "";
    private String searchPrjId = "";
    
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

    public String getSearchSj() {
		return searchSj;
	}

	public void setSearchSj(String searchSj) {
		this.searchSj = searchSj;
	}

	public String getSearchNm() {
		return searchNm;
	}

	public void setSearchNm(String searchNm) {
		this.searchNm = searchNm;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getBondStatN() {
		return bondStatN;
	}

	public void setBondStatN(String bondStatN) {
		this.bondStatN = bondStatN;
	}

	public String getBondStatY() {
		return bondStatY;
	}

	public void setBondStatY(String bondStatY) {
		this.bondStatY = bondStatY;
	}

	public String getBondStatC() {
		return bondStatC;
	}

	public void setBondStatC(String bondStatC) {
		this.bondStatC = bondStatC;
	}

	public String getUntilToday() {
		return untilToday;
	}

	public void setUntilToday(String untilToday) {
		this.untilToday = untilToday;
	}

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	/**
	 * @return the searchCompanyCd
	 */
	public String getSearchCompanyCd() {
		return searchCompanyCd;
	}

	/**
	 * @param searchCompanyCd the searchCompanyCd to set
	 */
	public void setSearchCompanyCd(String searchCompanyCd) {
		this.searchCompanyCd = searchCompanyCd;
	}

	public String getSearchPrjNm() {
		return searchPrjNm;
	}

	public void setSearchPrjNm(String searchPrjNm) {
		this.searchPrjNm = searchPrjNm;
	}

	public String getSearchPrjId() {
		return searchPrjId;
	}

	public void setSearchPrjId(String searchPrjId) {
		this.searchPrjId = searchPrjId;
	}

}
