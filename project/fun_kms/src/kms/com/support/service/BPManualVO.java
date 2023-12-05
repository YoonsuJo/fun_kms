package kms.com.support.service;

import org.springframework.web.multipart.MultipartFile;

public class BPManualVO {
	private int bpmNo;
	private String subject;
	private String useStatus;
	private String suggestStatus;
	private String content;
	private String atchFileId;
	private String atchFileId2;
	private String tempAtchFile1;
	private String tempAtchFile2;
	private String instDate;
	private String chgDate;
	private Integer commentNo;
	private String comment;
	private int suggestNo;
	private int commentCount;
	private Integer gubunNo;
	private String gubunNm;
	private String hiddenYn;
	
	
	/** 읽음표시, 조회수 **/
	private int readCount;
	private int readNo;
	private String readYn;
	
	private int userNo;
	private String userId;
	private String userNm;
	private int instNo;
	private String instNm;
	private int chgNo;
	private String chgNm;
	private String instUser;
	private String authUsers;
	private String receiverUsers;
	
	private String thisUrl;
	
	
	/* 페이징 */
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
    /* 페이징 끝 */
    
    /* 검색 */
    private Integer searchCondition = 0;
    private String searchKeyword;
    private String searchCheck = "Y";
    private String adminYn = "N";
    private Integer searchGubunNo;
    
    private Integer cntFile1;
    private Integer cntFile2;
	
    
	public String getTempAtchFile1() {
		return tempAtchFile1;
	}
	public void setTempAtchFile1(String tempAtchFile1) {
		this.tempAtchFile1 = tempAtchFile1;
	}
	public String getTempAtchFile2() {
		return tempAtchFile2;
	}
	public void setTempAtchFile2(String tempAtchFile2) {
		this.tempAtchFile2 = tempAtchFile2;
	}
	public Integer getCntFile1() {
		return cntFile1;
	}
	public void setCntFile1(Integer cntFile1) {
		this.cntFile1 = cntFile1;
	}
	public Integer getCntFile2() {
		return cntFile2;
	}
	public void setCntFile2(Integer cntFile2) {
		this.cntFile2 = cntFile2;
	}
	public String getHiddenYn() {
		return hiddenYn;
	}
	public void setHiddenYn(String hiddenYn) {
		this.hiddenYn = hiddenYn;
	}
	public String getThisUrl() {
		return thisUrl;
	}
	public void setThisUrl(String thisUrl) {
		this.thisUrl = thisUrl;
	}
	public String getReceiverUsers() {
		return receiverUsers;
	}
	public void setReceiverUsers(String receiverUsers) {
		this.receiverUsers = receiverUsers;
	}
	public String getInstUser() {
		return instUser;
	}
	public void setInstUser(String instUser) {
		this.instUser = instUser;
	}
	public String getAuthUsers() {
		return authUsers;
	}
	public void setAuthUsers(String authUsers) {
		this.authUsers = authUsers;
	}
	public Integer getSearchGubunNo() {
		return searchGubunNo;
	}
	public void setSearchGubunNo(Integer searchGubunNo) {
		this.searchGubunNo = searchGubunNo;
	}
	public Integer getGubunNo() {
		return gubunNo;
	}
	public void setGubunNo(Integer gubunNo) {
		this.gubunNo = gubunNo;
	}
	public String getGubunNm() {
		return gubunNm;
	}
	public void setGubunNm(String gubunNm) {
		this.gubunNm = gubunNm;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public String getAdminYn() {
		return adminYn;
	}
	public void setAdminYn(String adminYn) {
		this.adminYn = adminYn;
	}
	public Integer getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(Integer searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getSearchCheck() {
		return searchCheck;
	}
	public void setSearchCheck(String searchCheck) {
		this.searchCheck = searchCheck;
	}
	public String getInstDate() {
		return instDate;
	}
	public int getSuggestNo() {
		return suggestNo;
	}
	public void setSuggestNo(int suggestNo) {
		this.suggestNo = suggestNo;
	}
	
	public Integer getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(Integer commentNo) {
		this.commentNo = commentNo;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
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
	public void setInstDate(String instDate) {
		this.instDate = instDate;
	}
	public int getInstNo() {
		return instNo;
	}
	public void setInstNo(int instNo) {
		this.instNo = instNo;
	}
	public String getInstNm() {
		return instNm;
	}
	public void setInstNm(String instNm) {
		this.instNm = instNm;
	}
	public int getChgNo() {
		return chgNo;
	}
	public void setChgNo(int chgNo) {
		this.chgNo = chgNo;
	}
	public String getChgNm() {
		return chgNm;
	}
	public void setChgNm(String chgNm) {
		this.chgNm = chgNm;
	}
	public int getReadNo() {
		return readNo;
	}
	public void setReadNo(int readNo) {
		this.readNo = readNo;
	}
	public String getReadYn() {
		return readYn;
	}
	public void setReadYn(String readYn) {
		this.readYn = readYn;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public String getChgDate() {
		return chgDate;
	}
	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getUseStatus() {
		return useStatus;
	}
	public void setUseStatus(String useStatus) {
		this.useStatus = useStatus;
	}
	public String getSuggestStatus() {
		return suggestStatus;
	}
	public void setSuggestStatus(String suggestStatus) {
		this.suggestStatus = suggestStatus;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAtchFileId2() {
		return atchFileId2;
	}
	public void setAtchFileId2(String atchFileId2) {
		this.atchFileId2 = atchFileId2;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getBpmNo() {
		return bpmNo;
	}
	public void setBpmNo(int bpmNo) {
		this.bpmNo = bpmNo;
	}
}