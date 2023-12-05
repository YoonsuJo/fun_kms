
package kms.com.app.service;

import kms.com.common.utils.CalendarUtil;


/**
 * @author blind
 * 작성일 : 2011.08.26
 * 전자결재 관련 VO
 *
 */
@SuppressWarnings("serial")
public class ApprovalVO extends Approval{
	
	/** 검색시작일 */
	private String searchYear = CalendarUtil.getToday().substring(0,4);
	private String searchMonth = CalendarUtil.getToday().substring(4,6);
	private String[] checkList;
	
    private String searchBgnDe = "";
    
    /** 검색조건 */
    private String searchCnd = "";
    
	/** 검색종료일 */
    private String searchEndDe = "";
    
    /** 검색단어 */
    private String searchWrd = "";
    
    /** 정렬순서(DESC,ASC) */
    private long sortOrdr = 0L;

    /** 검색사용여부 */
    private String searchUseYn = "";

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 15;

    /** 페이지사이즈 */
    private int pageSize = 15;

    /** 첫페이지 인덱스 */
    private int firstIndex = 1;

    /** 마지막페이지 인덱스 */
    private int lastIndex = 1;

    /** 페이지당 레코드 개수 */
    private int recordCountPerPage = 10;

    /** 레코드 번호 */
    private int rowNo = 0;
    
    private int posblAtchFileNumber = 5;
    
    //작성자이름
    private String writerNm ="";
    
    //검토자 Mixs
    private String reviewerMixs ="";
        
    //협력자 Mixs
    private String cooperatorMixs ="";
    
    //전결자 id
    private String deciderMix ="";
    
    //참조자 Mixs
    private String referencerMixs ="";
    
    //처리자 Mixs
    private String handlerMixs ="";
    
    //메일수신Mixs
    private String emailMixs = "";    
    private String emailAddr = "";
    
	//TBL_PRJ의 컬럼 이름과 구분	
	private String prjNmDoc = "";
	private String prjCdDoc = "";
    
    private String searchDocStat ;
    private int searchUsrTyp = -1;
    private int readerNo;
    private int reWriteYn=0;
    private int ajaxMode = 0; 
    
    //summary 관련
    private int reviewCnt = 0;
    private int cooperationCnt = 0;
    private int decideCnt = 0;
    private int rejectCnt = 0;
    private int doApprovalCnt = 0;
    private int whileHandingCnt = 0;
    
    //group by를 통해 query 해온 값을 받아오기 위한 변수
    private String appTyp ;
    private int appTypCnt ;
    private int docStatCnt = 0; 

    
    //리스트 및 검색관련
    private String srchDt;
    private String mode;
    private int expPersonalSpend; //전자결재 개인 상신 금액
    private String completeDocYn;
    private String[] searchHandleStatL;
    private String[] searchdocStatL;
    private String noRequireHandle;
    private String searchTempltId;
    private String searchCompanyId; //회사구분
    private String searchWriterNm;
    private String searchSubject;
    private String searchDoHandle;
    private String searchExpMoney;
    private String searchExpDesc;
    private String searchAllPeriod;
    
    private String templtNm ="";
    private String templtNmBr ="";
        
    //batch 처리를 위해
    private String[] docIdList;
    //일괄휴가처리를 위해
    private String recieverList;
    private String[] recieverIdList;
    
    //양식재사용 문서 작성시 지우지않은
    private String reWriteFileInfo;

    //참조자 본인의 참조 여부
    private int stat = 0;
    
    public String getSearchBgnDe() {
		return searchBgnDe;
	}

	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}

	public String getSearchCnd() {
		return searchCnd;
	}

	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}

	public String getSearchEndDe() {
		return searchEndDe;
	}

	public void setSearchEndDe(String searchEndDe) {
		this.searchEndDe = searchEndDe;
	}

	public String getSearchWrd() {
		return searchWrd;
	}

	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}

	public long getSortOrdr() {
		return sortOrdr;
	}

	public void setSortOrdr(long sortOrdr) {
		this.sortOrdr = sortOrdr;
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

	public int getRowNo() {
		return rowNo;
	}

	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}

	public String getReviewerMixs() {
		return reviewerMixs;
	}

	public void setReviewerMixs(String reviewerMixs) {
		this.reviewerMixs = reviewerMixs;
	}

	public String getCooperatorMixs() {
		return cooperatorMixs;
	}

	public void setCooperatorMixs(String cooperatorMixs) {
		this.cooperatorMixs = cooperatorMixs;
	}

	public String getDeciderMix() {
		return deciderMix;
	}

	public void setDeciderMix(String deciderMix) {
		this.deciderMix = deciderMix;
	}

	public String getReferencerMixs() {
		return referencerMixs;
	}

	public void setReferencerMixs(String referencerMixs) {
		this.referencerMixs = referencerMixs;
	}

	public String gethandlerMixs() {
		return handlerMixs;
	}

	public void sethandlerMixs(String handlerMixs) {
		this.handlerMixs = handlerMixs;
	}

	public int getPosblAtchFileNumber() {
		return posblAtchFileNumber;
	}

	public void setPosblAtchFileNumber(int posblAtchFileNumber) {
		this.posblAtchFileNumber = posblAtchFileNumber;
	}

	public void setWriterNm(String writerNm) {
		this.writerNm = writerNm;
	}

	public String getWriterNm() {
		return writerNm;
	}

	


	public void setSearchUsrTyp(int searchUsrTyp) {
		this.searchUsrTyp = searchUsrTyp;
	}

	public int getSearchUsrTyp() {
		return searchUsrTyp;
	}

	public void setSearchDocStat(String searchDocStat) {
		this.searchDocStat = searchDocStat;
	}

	public String getSearchDocStat() {
		return searchDocStat;
	}

	public void setReaderNo(int readerNo) {
		this.readerNo = readerNo;
	}

	public int getReaderNo() {
		return readerNo;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getMode() {
		return mode;
	}

	public int getReviewCnt() {
		return reviewCnt;
	}

	public void setReviewCnt(int reviewCnt) {
		this.reviewCnt = reviewCnt;
	}

	public int getCooperationCnt() {
		return cooperationCnt;
	}

	public void setCooperationCnt(int cooperationCnt) {
		this.cooperationCnt = cooperationCnt;
	}

	public int getDecideCnt() {
		return decideCnt;
	}

	public void setDecideCnt(int decideCnt) {
		this.decideCnt = decideCnt;
	}
	public String getAppTyp() {
		return appTyp;
	}

	public void setAppTyp(String appTyp) {
		this.appTyp = appTyp;
	}

	public int getAppTypCnt() {
		return appTypCnt;
	}

	public void setAppTypCnt(int appTypCnt) {
		this.appTypCnt = appTypCnt;
	}

	public void setDocStatCnt(int docStatCnt) {
		this.docStatCnt = docStatCnt;
	}

	public int getDocStatCnt() {
		return docStatCnt;
	}

	public void setRejectCnt(int rejectCnt) {
		this.rejectCnt = rejectCnt;
	}

	public int getRejectCnt() {
		return rejectCnt;
	}


	public void setDoApprovalCnt(int doApprovalCnt) {
		this.doApprovalCnt = doApprovalCnt;
	}

	public int getDoApprovalCnt() {
		return doApprovalCnt;
	}

	
	public String[] getSearchHandleStatL() {
		return searchHandleStatL;
	}

	public void setSearchHandleStatL(String[] searchHandleStatL) {
		this.searchHandleStatL = searchHandleStatL;
	}

	

	public String[] getSearchdocStatL() {
		return searchdocStatL;
	}

	public void setSearchdocStatL(String[] searchdocStatL) {
		this.searchdocStatL = searchdocStatL;
	}

	public void setAjaxMode(int ajaxMode) {
		this.ajaxMode = ajaxMode;
	}

	public int getAjaxMode() {
		return ajaxMode;
	}

	public void setTempltNm(String templtNm) {
		this.templtNm = templtNm;
	}

	public String getTempltNm() {
		return templtNm;
	}

	

	public void setDocIdList(String[] docIdList) {
		this.docIdList = docIdList;
	}

	public String[] getDocIdList() {
		return docIdList;
	}

	public void setWhileHandingCnt(int whileHandingCnt) {
		this.whileHandingCnt = whileHandingCnt;
	}

	public int getWhileHandingCnt() {
		return whileHandingCnt;
	}

	public void setSearchTempltId(String searchTempltId) {
		this.searchTempltId = searchTempltId;
	}

	public String getSearchTempltId() {
		return searchTempltId;
	}

	public void setSearchWriterNm(String searchWriterNm) {
		this.searchWriterNm = searchWriterNm;
	}

	public String getSearchWriterNm() {
		return searchWriterNm;
	}

	public void setSearchSubject(String searchSubject) {
		this.searchSubject = searchSubject;
	}

	public String getSearchSubject() {
		return searchSubject;
	}

	public void setSrchDt(String srchDt) {
		this.srchDt = srchDt;
	}

	public String getSrchDt() {
		return srchDt;
	}

	public void setReWriteFileInfo(String reWriteFileInfo) {
		this.reWriteFileInfo = reWriteFileInfo;
	}

	public String getReWriteFileInfo() {
		return reWriteFileInfo;
	}

	public void setCompleteDocYn(String completeDocYn) {
		this.completeDocYn = completeDocYn;
	}

	public String getCompleteDocYn() {
		return completeDocYn;
	}

	public void setReWriteYn(int reWriteYn) {
		this.reWriteYn = reWriteYn;
	}

	public int getReWriteYn() {
		return reWriteYn;
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

	public void setNoRequireHandle(String noRequireHandle) {
		this.noRequireHandle = noRequireHandle;
	}

	public String getNoRequireHandle() {
		return noRequireHandle;
	}

	public void setSearchDoHandle(String searchDoHandle) {
		this.searchDoHandle = searchDoHandle;
	}

	public String getSearchDoHandle() {
		return searchDoHandle;
	}

	public void setExpPersonalSpend(int expPersonalSpend) {
		this.expPersonalSpend = expPersonalSpend;
	}

	public int getExpPersonalSpend() {
		return expPersonalSpend;
	}

	public int getStat() {
		return stat;
	}

	public void setStat(int stat) {
		this.stat = stat;
	}

	public void setCheckList(String[] checkList) {
		this.checkList = checkList;
	}

	public String[] getCheckList() {
		return checkList;
	}

	/**
	 * @return the searchExpMoney
	 */
	public String getSearchExpMoney() {
		return searchExpMoney;
	}

	/**
	 * @param searchExpMoney the searchExpMoney to set
	 */
	public void setSearchExpMoney(String searchExpMoney) {
		this.searchExpMoney = searchExpMoney;
	}

	/**
	 * @return the searchExpDesc
	 */
	public String getSearchExpDesc() {
		return searchExpDesc;
	}

	/**
	 * @param searchExpDesc the searchExpDesc to set
	 */
	public void setSearchExpDesc(String searchExpDesc) {
		this.searchExpDesc = searchExpDesc;
	}

	public void setRecieverList(String recieverList) {
		this.recieverList = recieverList;
	}

	public String getRecieverList() {
		return recieverList;
	}

	public void setRecieverIdList(String[] recieverIdList) {
		this.recieverIdList = recieverIdList;
	}

	public String[] getRecieverIdList() {
		return recieverIdList;
	}

	public void setEmailMixs(String emailMixs) {
		this.emailMixs = emailMixs;
	}

	public String getEmailMixs() {
		return emailMixs;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setPrjNmDoc(String prjNmDoc) {
		this.prjNmDoc = prjNmDoc;
	}

	public String getPrjNmDoc() {
		return prjNmDoc;
	}

	public void setPrjCdDoc(String prjCdDoc) {
		this.prjCdDoc = prjCdDoc;
	}

	public String getPrjCdDoc() {
		return prjCdDoc;
	}

	public void setTempltNmBr(String templtNmBr) {
		this.templtNmBr = templtNmBr;
	}

	public String getTempltNmBr() {
		return templtNmBr;
	}

	/**
	 * @param searchCompanyId the searchCompanyId to set
	 */
	public void setSearchCompanyId(String searchCompanyId) {
		this.searchCompanyId = searchCompanyId;
	}

	/**
	 * @return the searchCompanyId
	 */
	public String getSearchCompanyId() {
		return searchCompanyId;
	}

	public String getSearchAllPeriod() {
		return searchAllPeriod;
	}

	public void setSearchAllPeriod(String searchAllPeriod) {
		this.searchAllPeriod = searchAllPeriod;
	}	
	
}
