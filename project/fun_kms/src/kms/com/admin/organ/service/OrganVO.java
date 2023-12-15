package kms.com.admin.organ.service;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * @Class Name : OrganVO.java
 * @Description : Organ VO class
 * @Modification Information
 *
 * @author 민형식
 * @since 2011.09.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class  OrganVO extends Organ implements Serializable {
	
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
    
    /** 검색레벨 */
    private String searchLV = "";
    
    /** 검색상위부서 */
    private String searchUp = "";
    
	/** 검색조직명 */
    private String searchOrgNm = "";

	//2013.08.02 김대현 조직개편 검색 기능 추가
    /** 검색상위부서리스트 */
    private ArrayList searchUpList;
	/** 검색조직명리스트 */
    private ArrayList searchOrgNmList;
    
    
    public String getSearchLV() {
		return searchLV;
	}

	public void setSearchLV(String searchLV) {
		this.searchLV = searchLV;
	}

	public String getSearchUp() {
		return searchUp;
	}

	public void setSearchUp(String searchUp) {
		this.searchUp = searchUp;
	}

	public String getSearchOrgNm() {
		return searchOrgNm;
	}

	public void setSearchOrgNm(String searchOrgNm) {
		this.searchOrgNm = searchOrgNm;
	}

    /** recordCountPerPage */
    private int recordCountPerPage = 10;

	/**
	 * searchCondition attribute 를 리턴한다.
	 * @return String
	 */
	public String getSearchCondition() {
		return searchCondition;
	}

	/**
	 * searchCondition attribute 값을 설정한다.
	 * @param searchCondition String
	 */
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	/**
	 * searchKeyword attribute 를 리턴한다.
	 * @return String
	 */
	public String getSearchKeyword() {
		return searchKeyword;
	}

	/**
	 * searchKeyword attribute 값을 설정한다.
	 * @param searchKeyword String
	 */
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	/**
	 * searchUseYn attribute 를 리턴한다.
	 * @return String
	 */
	public String getSearchUseYn() {
		return searchUseYn;
	}

	/**
	 * searchUseYn attribute 값을 설정한다.
	 * @param searchUseYn String
	 */
	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	/**
	 * pageIndex attribute 를 리턴한다.
	 * @return int
	 */
	public int getPageIndex() {
		return pageIndex;
	}

	/**
	 * pageIndex attribute 값을 설정한다.
	 * @param pageIndex int
	 */
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	/**
	 * pageUnit attribute 를 리턴한다.
	 * @return int
	 */
	public int getPageUnit() {
		return pageUnit;
	}

	/**
	 * pageUnit attribute 값을 설정한다.
	 * @param pageUnit int
	 */
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	/**
	 * pageSize attribute 를 리턴한다.
	 * @return int
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * pageSize attribute 값을 설정한다.
	 * @param pageSize int
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * firstIndex attribute 를 리턴한다.
	 * @return int
	 */
	public int getFirstIndex() {
		return firstIndex;
	}

	/**
	 * firstIndex attribute 값을 설정한다.
	 * @param firstIndex int
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	/**
	 * lastIndex attribute 를 리턴한다.
	 * @return int
	 */
	public int getLastIndex() {
		return lastIndex;
	}

	/**
	 * lastIndex attribute 값을 설정한다.
	 * @param lastIndex int
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	/**
	 * recordCountPerPage attribute 를 리턴한다.
	 * @return int
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	/**
	 * recordCountPerPage attribute 값을 설정한다.
	 * @param recordCountPerPage int
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public void setSearchOrgNmList(ArrayList searchOrgNmList) {
		this.searchOrgNmList = searchOrgNmList;
	}

	public ArrayList getSearchOrgNmList() {
		return searchOrgNmList;
	}

	public void setSearchUpList(ArrayList searchUpList) {
		this.searchUpList = searchUpList;
	}

	public ArrayList getSearchUpList() {
		return searchUpList;
	}
    

}
