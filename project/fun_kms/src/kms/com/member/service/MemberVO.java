package kms.com.member.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : MemberVO.java
 * @Description : Member VO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2011.08.27    이병주          최초 생성
 *
 *  @author 웹개발팀 이병주
 *  @since 2011.08.27
 *  @version 1.0
 *  @see
 *  
 */
@SuppressWarnings("serial")
public class MemberVO extends Member implements Serializable  {
	
	private String[] workStList;
	/** 검색조건 */
    private String searchCondition = "1";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    private String searchUserNm = "";
    private String searchOrgNm = "";
    private String searchOrgId = "";
    private String[] searchOrgIdList;
    private String searchPrjNm = "";
    private String searchPrjId = "";
    private String[] searchKeywordList;
    private String searchNm = "";
    private String searchUserMix;
    private String[] searchUserIdList;
    
    //이력 검색
    private String rankIdFrom = "";
    private String rankIdTo = "";
    private String careerFrom = "";
    private String careerTo = "";
    private String searchSkill = "";
    private String searchLicense = "";
    private String needUpdate = "";
    private String hasLicense = "";
    
    //생일자 관련 쪽지 수신자 속성
    private String receiverList;
    private String[] receiverIdList;
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
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
    
    private String orderBy;

    private String reLoginYn = "";		// 모바일에서 재로그인시 구분하기 위함, Y:재로그인
    
    
    /**
	 * @return the workStList
	 */
	public String[] getWorkStList() {
		return workStList;
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
	 * @param workStList the workStList to set
	 */
	public void setWorkStList(String[] workStList) {
		this.workStList = workStList;
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
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
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
	public void setSearchPrjNm(String searchPrjNm) {
		this.searchPrjNm = searchPrjNm;
	}
	public String getSearchPrjNm() {
		return searchPrjNm;
	}
	public void setSearchPrjId(String searchPrjId) {
		this.searchPrjId = searchPrjId;
	}
	public String getSearchPrjId() {
		return searchPrjId;
	}	
	public void setReceiverList(String receiverList) {
		this.receiverList = receiverList;
	}
	public String getReceiverList() {
		return receiverList;
	}
	public void setReceiverIdList(String[] receiverIdList) {
		this.receiverIdList = receiverIdList;
	}
	public String[] getReceiverIdList() {
		return receiverIdList;
	}
	public void setRankIdFrom(String rankIdFrom) {
		this.rankIdFrom = rankIdFrom;
	}
	public String getRankIdFrom() {
		return rankIdFrom;
	}
	public void setRankIdTo(String rankIdTo) {
		this.rankIdTo = rankIdTo;
	}
	public String getRankIdTo() {
		return rankIdTo;
	}
	public void setCareerFrom(String careerFrom) {
		this.careerFrom = careerFrom;
	}
	public String getCareerFrom() {
		return careerFrom;
	}
	public void setCareerTo(String careerTo) {
		this.careerTo = careerTo;
	}
	public String getCareerTo() {
		return careerTo;
	}
	public void setSearchSkill(String searchSkill) {
		this.searchSkill = searchSkill;
	}
	public String getSearchSkill() {
		return searchSkill;
	}
	public void setSearchLicense(String searchLicense) {
		this.searchLicense = searchLicense;
	}
	public String getSearchLicense() {
		return searchLicense;
	}
	public void setNeedUpdate(String needUpdate) {
		this.needUpdate = needUpdate;
	}
	public String getNeedUpdate() {
		return needUpdate;
	}
	public void setHasLicense(String hasLicense) {
		this.hasLicense = hasLicense;
	}
	public String getHasLicense() {
		return hasLicense;
	}
	public void setSearchUserMix(String searchUserMix) {
		this.searchUserMix = searchUserMix;
	}
	public String getSearchUserMix() {
		return searchUserMix;
	}
	public void setSearchUserIdList(String[] searchUserIdList) {
		this.searchUserIdList = searchUserIdList;
	}
	public String[] getSearchUserIdList() {
		return searchUserIdList;
	}
	public String getReLoginYn() {
		return reLoginYn;
	}
	public void setReLoginYn(String reLoginYn) {
		this.reLoginYn = reLoginYn;
	}
}
