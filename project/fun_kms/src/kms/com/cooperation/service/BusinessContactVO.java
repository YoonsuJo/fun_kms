package kms.com.cooperation.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

public class BusinessContactVO extends BusinessContact {
	
	/** 검색조건 */
	private String searchCondition = "0";
	
	/** 검색Keyword - 업무진행내역 */
	private String searchKeyword = "";
	private String searchUserNm = "";
	private String searchPrjId = "";
	private String searchPrjNm = "";
	private String searchYear = "";
	/** [2015/02/16, dwkim] 검색조건 추가 */
	private String searchDetail = "";		// 간단히/자세히
	private String searchCmmtCn = "";		// 덧글 내용
	private String searchCmmtUserNm = "";	// 덧글 작성자
	private String searchOnlyPrjNm = "";	// 프로젝트명
	private String searchRegDtS = "";		// 작성일 시작
	private String searchRegDtE = "";		// 작성일 종료
	private String searchAllPeriod = "";	// 전체 여부
	private String[] searchArrKeyword;
	private String[] searchArrUserNm;
	private String[] searchArrCmmtCn;
	private String[] searchArrCmmtUserNm;
	private String[] searchArrOnlyPrjNm;
	private String[] searchArrPrjId;		// 프로젝트 다중검색
	
	private String ajax = "";
	
	
	private String includeUnderProject;
	
	public String getAttachFileId() {
		return attachFileId;
	}
	public void setAttachFileId(String attachFileId) {
		this.attachFileId = attachFileId;
	}

	private String attachFileId = "";
	
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
	
	private int commentCnt = 0;
	private String readStat;
	private String readYn;
	
	private List<BusinessContactRecieve> recieveList = new ArrayList<BusinessContactRecieve>();
	private List<BusinessContactRecieve> referenceList = new ArrayList<BusinessContactRecieve>();
	/**
	 * @return the searchCondition
	 */
	public String getSearchCondition() {
		return searchCondition;
	}
	/**
	 * @param searchCondition the searchCondition to set
	 */
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
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
	public int getCommentCnt() {
		return commentCnt;
	}
	/**
	 * @param commentCnt the commentCnt to set
	 */
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	/**
	 * @return the readStat
	 */
	public String getReadStat() {
		return readStat;
	}
	public String getReadStatPrint() {
		if (readStat == null || readStat.equals("")) return "";
		
		if (readStat.equals("C")) {
			return "완료";
		} else if (readStat.equals("P")) {
			return "열람중";
		}
		else return readStat;
	}
	/**
	 * @param readStat the readStat to set
	 */
	public void setReadStat(String readStat) {
		this.readStat = readStat;
	}
	/**
	 * @return the readYn
	 */
	public String getReadYn() {
		return readYn;
	}
	/**
	 * @param readYn the readYn to set
	 */
	public void setReadYn(String readYn) {
		this.readYn = readYn;
	}
	/**
	 * @return the recieveList
	 */
	public List<BusinessContactRecieve> getRecieveList() {
		return recieveList;
	}
	/**
	 * @param recieveList the recieverList to set
	 */
	public void setRecieveList(List<BusinessContactRecieve> recieveList) {
		this.recieveList = recieveList;
	}
	public void addRecieveList(BusinessContactRecieve recieve) {
		this.recieveList.add(recieve);
	}
	/**
	 * @return the referenceList
	 */
	public List<BusinessContactRecieve> getReferenceList() {
		return referenceList;
	}
	/**
	 * @param referenceList the referenceList to set
	 */
	public void setReferenceList(List<BusinessContactRecieve> referenceList) {
		this.referenceList = referenceList;
	}
	public void addReferenceList(BusinessContactRecieve reference) {
		this.referenceList.add(reference);
	}
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setAjax(String ajax) {
		this.ajax = ajax;
	}
	public String getAjax() {
		return ajax;
	}
	public String getSearchYear() {
		return searchYear;
	}
	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}
	
	public String getSearchCmmtCn() {
		return searchCmmtCn;
	}
	public void setSearchCmmtCn(String searchCmmtCn) {
		this.searchCmmtCn = searchCmmtCn;
	}
	public String getSearchCmmtUserNm() {
		return searchCmmtUserNm;
	}
	public void setSearchCmmtUserNm(String searchCmmtUserNm) {
		this.searchCmmtUserNm = searchCmmtUserNm;
	}
	public String getSearchOnlyPrjNm() {
		return searchOnlyPrjNm;
	}
	public void setSearchOnlyPrjNm(String searchOnlyPrjNm) {
		this.searchOnlyPrjNm = searchOnlyPrjNm;
	}
	public String[] getSearchArrKeyword() {
		if (!"".equals(searchKeyword)) {
			searchArrKeyword = searchKeyword.split(" ");
		}
		return searchArrKeyword;
	}
	public String[] getSearchArrUserNm() {
		if (!"".equals(searchUserNm)) {
			searchArrUserNm = searchUserNm.split(" ");
		}
		return searchArrUserNm;
	}
	public String[] getSearchArrCmmtCn() {
		if (!"".equals(searchCmmtCn)) {
			searchArrCmmtCn = searchCmmtCn.split(" ");
		}
		return searchArrCmmtCn;
	}
	public String[] getSearchArrCmmtUserNm() {
		if (!"".equals(searchCmmtUserNm)) {
			searchArrCmmtUserNm = searchCmmtUserNm.split(" ");
		}
		return searchArrCmmtUserNm;
	}
	public String[] getSearchArrOnlyPrjNm() {
		if (!"".equals(searchOnlyPrjNm)) {
			searchArrOnlyPrjNm = searchOnlyPrjNm.split(" ");
		}
		return searchArrOnlyPrjNm;
	}
	public String getSearchDetail() {
		return searchDetail;
	}
	public void setSearchDetail(String searchDetail) {
		this.searchDetail = searchDetail;
	}
	public String getSearchRegDtS() {
		return searchRegDtS;
	}
	public void setSearchRegDtS(String searchRegDtS) {
		this.searchRegDtS = searchRegDtS;
	}
	public String getSearchRegDtE() {
		return searchRegDtE;
	}
	public void setSearchRegDtE(String searchRegDtE) {
		this.searchRegDtE = searchRegDtE;
	}
	public String getSearchAllPeriod() {
		return searchAllPeriod;
	}
	public void setSearchAllPeriod(String searchAllPeriod) {
		this.searchAllPeriod = searchAllPeriod;
	}
	public String[] getSearchArrPrjId() {
		if (!"".equals(searchPrjId)) {
			searchArrPrjId = searchPrjId.split(",");
		}
		return searchArrPrjId;
	}
}
