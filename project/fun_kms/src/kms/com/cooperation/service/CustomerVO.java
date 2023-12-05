package kms.com.cooperation.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

public class CustomerVO extends Customer {

	/** 검색Keyword */
	private String searchKeyword = "";
	private String searchBusiNo = "";
	private String searchPersonNm = "";
	private String searchTelno = "";
	private String searchFaxno = "";
	private String searchUserMix = "";
	private String searchUserId = "";

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

	/** 결과출력용  */
	private Integer commentCnt;
	private List<CustomerPerson> personList = new ArrayList<CustomerPerson>();

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	
	/**
	 * @return the searchKeyword
	 */
	public String getSearchKeyword() {
		return searchKeyword;
	}

	/**
	 * @param searchKeyword the searchKeyword to set
	 */
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	/**
	 * @return the searchBusiNo
	 */
	public String getSearchBusiNo() {
		return searchBusiNo;
	}

	/**
	 * @param searchBusiNo the searchBusiNo to set
	 */
	public void setSearchBusiNo(String searchBusiNo) {
		this.searchBusiNo = searchBusiNo;
	}

	/**
	 * @return the searchPersonNm
	 */
	public String getSearchPersonNm() {
		return searchPersonNm;
	}

	/**
	 * @param searchPersonNm the searchPersonNm to set
	 */
	public void setSearchPersonNm(String searchPersonNm) {
		this.searchPersonNm = searchPersonNm;
	}

	/**
	 * @return the searchTelno
	 */
	public String getSearchTelno() {
		return searchTelno;
	}

	/**
	 * @param searchTelno the searchTelno to set
	 */
	public void setSearchTelno(String searchTelno) {
		this.searchTelno = searchTelno;
	}

	/**
	 * @return the searchFaxno
	 */
	public String getSearchFaxno() {
		return searchFaxno;
	}

	/**
	 * @param searchFaxno the searchFaxno to set
	 */
	public void setSearchFaxno(String searchFaxno) {
		this.searchFaxno = searchFaxno;
	}

	/**
	 * @return the searchUserMix
	 */
	public String getSearchUserMix() {
		return searchUserMix;
	}

	/**
	 * @param searchUserMix the searchUserMix to set
	 */
	public void setSearchUserMix(String searchUserMix) {
		this.searchUserMix = searchUserMix;
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
	 * @return the pageIndex
	 */
	public int getPageIndex() {
		return pageIndex;
	}

	/**
	 * @param pageIndex the pageIndex to set
	 */
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	/**
	 * @return the pageUnit
	 */
	public int getPageUnit() {
		return pageUnit;
	}

	/**
	 * @param pageUnit the pageUnit to set
	 */
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	/**
	 * @return the pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * @return the firstIndex
	 */
	public int getFirstIndex() {
		return firstIndex;
	}

	/**
	 * @param firstIndex the firstIndex to set
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	/**
	 * @return the lastIndex
	 */
	public int getLastIndex() {
		return lastIndex;
	}

	/**
	 * @param lastIndex the lastIndex to set
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	/**
	 * @return the recordCountPerPage
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	/**
	 * @param recordCountPerPage the recordCountPerPage to set
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	/**
	 * @return the commentCnt
	 */
	public Integer getCommentCnt() {
		return commentCnt;
	}

	/**
	 * @param commentCnt the commentCnt to set
	 */
	public void setCommentCnt(Integer commentCnt) {
		this.commentCnt = commentCnt;
	}

	/**
	 * @return the personList
	 */
	public List<CustomerPerson> getPersonList() {
		return personList;
	}

	/**
	 * @param personList the personList to set
	 */
	public void setPersonList(List<CustomerPerson> personList) {
		this.personList = personList;
	}
	public void addPersonList(CustomerPerson person) {
		this.personList.add(person);
	}
	public void addPersonList(List<CustomerPerson> personList) {
		this.personList.addAll(personList);
	}
	
	
	
}
