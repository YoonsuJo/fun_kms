package kms.com.product.service;

import java.util.Date;


public class ProductRequestVO {
	
	private String adminMixes;	//관리자 이름(아이디)
	private String param_returnUrl;

	private String commentCn;
	
	
	
	/** 검색 조건 S*/
	private String searchRequestNm;
	private String searchWriterNm;
	private String searchAdminNm;
	private String searchDateFrom;
	private String searchDateTo;
	private String searchPrjNm;
	private String searchPrjId;
	
	/* 
		미처리    A
		처리완료  B
		검토완료  C
		미검토    D
		기각      E
	 */
		
	private String ACheck;
	private String BCheck;
	private String CCheck;
	private String DCheck;
	private String ECheck;
	
	private String searchRequestState;
	private String[] searchRequestStateArray;
	private String searchRequestId;
	/** 검색 조건 E*/
    
	
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
    
    
    
	
	private String productId;  
	private String productNm;
	
	private String partId;
	private String partNm;
	
	private String requestId;  
	private String requestNm;
	private String requestType;  //요구 유형 기능개선 I 기능추가 A 기능오류 E
	private String requestCn;    //미처리 A 처리완료 B 검토완료 C 미검토 D 기각 E
	private String requestState;   
	private String useAt;
	private String atchFileId;

	
	private Integer writerNo;	//등록자
	private String writerNm;	//등록자
	private String writerId;	//등록자
	private Integer adminNo;	//관리자
	private String adminNm;		//관리자
	private String adminId;		//관리자
	private Integer modifierNo;	//수정자
	
	private String hopeDt;		//적용희망일

	
	private Date regDt;			//등록일
	private Date modDt;			//수정일
	private Date endDt;			//완료일
	
	
	
	//요구사항 검토
	private String acceptAt;    //수용여부 YN
	private String checkCn;     //검토 결과 내용
	private String dueDt;       //처리예정일
	
	private Date checkModDt;	//검토 수정일
	
	private Integer checkWriterNo;	//검토자
	private String checkWriterNm;	//검토자
	private String checkWriterId;	//검토자
	
	private String checkAtchFileId;
	
	// Comments 목록 가공(엑셀 저장을 위해)
	private String commentsList;		//처리결과(덧글)
	
	private String versionNm;		//상품 버전
	private String prjId;		// 프로젝트ID
	private String prjNm;		// 프로젝트명
	private String prjCd;		// 프로젝트코드

	public String getAdminMixes() {
		return adminMixes;
	}

	public void setAdminMixes(String adminMixes) {
		this.adminMixes = adminMixes;
	}

	public String getParam_returnUrl() {
		return param_returnUrl;
	}

	public void setParam_returnUrl(String param_returnUrl) {
		this.param_returnUrl = param_returnUrl;
	}

	public String getCommentCn() {
		return commentCn;
	}

	public void setCommentCn(String commentCn) {
		this.commentCn = commentCn;
	}

	public String getSearchRequestNm() {
		return searchRequestNm;
	}

	public void setSearchRequestNm(String searchRequestNm) {
		this.searchRequestNm = searchRequestNm;
	}

	public String getSearchWriterNm() {
		return searchWriterNm;
	}

	public void setSearchWriterNm(String searchWriterNm) {
		this.searchWriterNm = searchWriterNm;
	}

	public String getSearchAdminNm() {
		return searchAdminNm;
	}

	public void setSearchAdminNm(String searchAdminNm) {
		this.searchAdminNm = searchAdminNm;
	}

	public String getSearchDateFrom() {
		return searchDateFrom;
	}

	public void setSearchDateFrom(String searchDateFrom) {
		this.searchDateFrom = searchDateFrom;
	}

	public String getSearchDateTo() {
		return searchDateTo;
	}

	public void setSearchDateTo(String searchDateTo) {
		this.searchDateTo = searchDateTo;
	}

	public String getACheck() {
		return ACheck;
	}

	public void setACheck(String check) {
		ACheck = check;
	}

	public String getBCheck() {
		return BCheck;
	}

	public void setBCheck(String check) {
		BCheck = check;
	}

	public String getCCheck() {
		return CCheck;
	}

	public void setCCheck(String check) {
		CCheck = check;
	}

	public String getDCheck() {
		return DCheck;
	}

	public void setDCheck(String check) {
		DCheck = check;
	}

	public String getECheck() {
		return ECheck;
	}

	public void setECheck(String check) {
		ECheck = check;
	}

	public String getSearchRequestState() {
		return searchRequestState;
	}

	public void setSearchRequestState(String searchRequestState) {
		this.searchRequestState = searchRequestState;
	}

	public String[] getSearchRequestStateArray() {
		return searchRequestStateArray;
	}

	public void setSearchRequestStateArray(String[] searchRequestStateArray) {
		this.searchRequestStateArray = searchRequestStateArray;
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

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductNm() {
		return productNm;
	}

	public void setProductNm(String productNm) {
		this.productNm = productNm;
	}

	public String getPartId() {
		return partId;
	}

	public void setPartId(String partId) {
		this.partId = partId;
	}

	public String getPartNm() {
		return partNm;
	}

	public void setPartNm(String partNm) {
		this.partNm = partNm;
	}

	public String getRequestId() {
		return requestId;
	}

	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}

	public String getRequestNm() {
		return requestNm;
	}

	public void setRequestNm(String requestNm) {
		this.requestNm = requestNm;
	}

	public String getRequestType() {
		return requestType;
	}

	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}

	public String getRequestCn() {
		return requestCn;
	}

	public void setRequestCn(String requestCn) {
		this.requestCn = requestCn;
	}

	public String getRequestState() {
		return requestState;
	}

	public void setRequestState(String requestState) {
		this.requestState = requestState;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public Integer getWriterNo() {
		return writerNo;
	}

	public void setWriterNo(Integer writerNo) {
		this.writerNo = writerNo;
	}

	public String getWriterNm() {
		return writerNm;
	}

	public void setWriterNm(String writerNm) {
		this.writerNm = writerNm;
	}

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}

	public Integer getAdminNo() {
		return adminNo;
	}

	public void setAdminNo(Integer adminNo) {
		this.adminNo = adminNo;
	}

	public String getAdminNm() {
		return adminNm;
	}

	public void setAdminNm(String adminNm) {
		this.adminNm = adminNm;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getHopeDt() {
		return hopeDt;
	}

	public void setHopeDt(String hopeDt) {
		this.hopeDt = hopeDt;
	}

	public Date getRegDt() {
		return regDt;
	}

	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}

	public Date getModDt() {
		return modDt;
	}

	public void setModDt(Date modDt) {
		this.modDt = modDt;
	}

	public Date getEndDt() {
		return endDt;
	}

	public void setEndDt(Date endDt) {
		this.endDt = endDt;
	}

	public String getAcceptAt() {
		return acceptAt;
	}

	public void setAcceptAt(String acceptAt) {
		this.acceptAt = acceptAt;
	}

	public String getCheckCn() {
		return checkCn;
	}

	public void setCheckCn(String checkCn) {
		this.checkCn = checkCn;
	}

	public String getDueDt() {
		return dueDt;
	}

	public void setDueDt(String dueDt) {
		this.dueDt = dueDt;
	}


	public Date getCheckModDt() {
		return checkModDt;
	}

	public void setCheckModDt(Date checkModDt) {
		this.checkModDt = checkModDt;
	}

	public Integer getCheckWriterNo() {
		return checkWriterNo;
	}

	public void setCheckWriterNo(Integer checkWriterNo) {
		this.checkWriterNo = checkWriterNo;
	}

	public String getCheckWriterNm() {
		return checkWriterNm;
	}

	public void setCheckWriterNm(String checkWriterNm) {
		this.checkWriterNm = checkWriterNm;
	}

	public String getCheckWriterId() {
		return checkWriterId;
	}

	public void setCheckWriterId(String checkWriterId) {
		this.checkWriterId = checkWriterId;
	}

	public String getCheckAtchFileId() {
		return checkAtchFileId;
	}

	public void setCheckAtchFileId(String checkAtchFileId) {
		this.checkAtchFileId = checkAtchFileId;
	}

	public String getCommentsList() {
		return commentsList;
	}

	public void setCommentsList(String commentsList) {
		this.commentsList = commentsList;
	}

	public String getVersionNm() {
		return versionNm;
	}

	public void setVersionNm(String versionNm) {
		this.versionNm = versionNm;
	}

	public String getSearchRequestId() {
		return searchRequestId;
	}

	public void setSearchRequestId(String searchRequestId) {
		this.searchRequestId = searchRequestId;
	}

	public Integer getModifierNo() {
		return modifierNo;
	}

	public void setModifierNo(Integer modifierNo) {
		this.modifierNo = modifierNo;
	}

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public String getPrjNm() {
		return prjNm;
	}

	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}

	public String getSearchPrjId() {
		return searchPrjId;
	}

	public void setSearchPrjId(String searchPrjId) {
		this.searchPrjId = searchPrjId;
	}

	public String getPrjCd() {
		return prjCd;
	}

	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}

	public String getSearchPrjNm() {
		return searchPrjNm;
	}

	public void setSearchPrjNm(String searchPrjNm) {
		this.searchPrjNm = searchPrjNm;
	}
}
