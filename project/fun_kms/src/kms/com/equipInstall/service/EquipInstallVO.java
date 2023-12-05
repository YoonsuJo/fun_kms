package kms.com.equipInstall.service;

public class EquipInstallVO {
	
	/** 설치 요청 제목 **/
	private String subject;
	
	/** 설치 요청 내용 **/
	private String content;
	
	/** 설치요청 솔루션 이름 **/
	private String solutionNm;
	
	/** 설치요청 솔루션 코드 **/
	private int solutionCode;
	
	/** 고객사 **/
	private String customer;
	
	/** 프로젝트 **/
	private String prjId;
	private String prjNm;
	private String projectCode;
	
	/** 번호 **/
	private int installNo;
	private int installDetailNo;
	private int referenceNo;
	
	/** 사원 아이디 **/
	private String userId;
	private String userNm;
	private String userNo;
	
	/** 입력 날짜 **/
	private String instId;
	private String instDate;
	private String chgId;
	private String chgNo;
	private String chgDate;
	
	/** 게시판 번호 넘버링 **/
	private int listNum;
	
	/** 담당자 **/
	private String mngId;
	private String mngNo;
	private String mngNm;
	
	/** 등록자 **/
	private String regId;
	private String regNo;
	private String regNm;
	
	
	/** 구분코드 **/
	private int gubunCd;
	
	
	/** 등록일 **/
	private String regDate;
	private String completeDate;
	
	/** 파일 **/
	private String atchFileId;
	private String orignlFileName;
	
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
	
    /** 읽음 여부 **/
    private String readYn;
    private int readNo;
    
    /** 삭제여부 **/
    private String delYn;
    private String adminYn;
    
    /** 변동내역 **/
	private int historyNo;
    
    /** 검색조건 **/
    private String searchPrjId;
    private String searchPrjNm;
    private String searchSubject;
    private String searchUserId;
    private String searchUserNm;
    private String handling;
    private String searchGubun;
    private String[] arrGubun;
    
   
    
	public String getChgNo() {
		return chgNo;
	}
	public void setChgNo(String chgNo) {
		this.chgNo = chgNo;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegNo() {
		return regNo;
	}
	public void setRegNo(String regNo) {
		this.regNo = regNo;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getMngNo() {
		return mngNo;
	}
	public void setMngNo(String mngNo) {
		this.mngNo = mngNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getProjectCode() {
		return projectCode;
	}
	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}
	public String getChgId() {
		return chgId;
	}
	public void setChgId(String chgId) {
		this.chgId = chgId;
	}
	public String getChgDate() {
		return chgDate;
	}
	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public int getHistoryNo() {
		return historyNo;
	}
	public void setHistoryNo(int historyNo) {
		this.historyNo = historyNo;
	}
	public String[] getArrGubun() {
		return arrGubun;
	}
	public void setArrGubun(String[] arrGubun) {
		this.arrGubun = arrGubun;
	}
	public String getSearchGubun() {
		return searchGubun;
	}
	public void setSearchGubun(String searchGubun) {
		this.searchGubun = searchGubun;
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
	public String getSearchSubject() {
		return searchSubject;
	}
	public void setSearchSubject(String searchSubject) {
		this.searchSubject = searchSubject;
	}
	public String getSearchUserId() {
		return searchUserId;
	}
	public void setSearchUserId(String searchUserId) {
		this.searchUserId = searchUserId;
	}
	public String getSearchUserNm() {
		return searchUserNm;
	}
	public void setSearchUserNm(String searchUserNm) {
		this.searchUserNm = searchUserNm;
	}
	public String getHandling() {
		return handling;
	}
	public void setHandling(String handling) {
		this.handling = handling;
	}
	public String getInstId() {
		return instId;
	}
	public void setInstId(String instId) {
		this.instId = instId;
	}
	public int getReferenceNo() {
		return referenceNo;
	}
	public void setReferenceNo(int referenceNo) {
		this.referenceNo = referenceNo;
	}
	public String getAdminYn() {
		return adminYn;
	}
	public void setAdminYn(String adminYn) {
		this.adminYn = adminYn;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getCompleteDate() {
		return completeDate;
	}
	public void setCompleteDate(String completeDate) {
		this.completeDate = completeDate;
	}
	public String getOrignlFileName() {
		return orignlFileName;
	}
	public void setOrignlFileName(String orignlFileName) {
		this.orignlFileName = orignlFileName;
	}
	public String getReadYn() {
		return readYn;
	}
	public void setReadYn(String readYn) {
		this.readYn = readYn;
	}
	public int getReadNo() {
		return readNo;
	}
	public void setReadNo(int readNo) {
		this.readNo = readNo;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
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
	public int getInstallDetailNo() {
		return installDetailNo;
	}
	public void setInstallDetailNo(int installDetailNo) {
		this.installDetailNo = installDetailNo;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getMngId() {
		return mngId;
	}
	public void setMngId(String mngId) {
		this.mngId = mngId;
	}
	public String getMngNm() {
		return mngNm;
	}
	public void setMngNm(String mngNm) {
		this.mngNm = mngNm;
	}
	public int getGubunCd() {
		return gubunCd;
	}
	public void setGubunCd(int gubunCd) {
		this.gubunCd = gubunCd;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getInstDate() {
		return instDate;
	}
	public void setInstDate(String instDate) {
		this.instDate = instDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getInstallNo() {
		return installNo;
	}
	public void setInstallNo(int installNo) {
		this.installNo = installNo;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSolutionNm() {
		return solutionNm;
	}
	public void setSolutionNm(String solutionNm) {
		this.solutionNm = solutionNm;
	}
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public int getSolutionCode() {
		return solutionCode;
	}
	public void setSolutionCode(int solutionCode) {
		this.solutionCode = solutionCode;
	}
}