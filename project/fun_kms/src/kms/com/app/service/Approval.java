	package kms.com.app.service;

import java.io.Serializable;

import kms.com.app.web.KmsApprovalController;


/**
 * @author blind
 * 작성일 : 2011.08.26
 * 전자결재 관련 VO
 *
 */
@SuppressWarnings("serial")
public class Approval implements Serializable{
	
	//문서번호
	private String docId;
	//부모문서
	private String parntId;
	//문서양식
	private String templtId;
	//글쓴이번호
	private int writerNo = -1;
	//글쓴이Id
	private String writerId;
	//제목
	private String subject;
	//내용
	private String content;
	//작성일
	private String writeDt;
	//상태를 변경하게 만든 변경일자 저장.
	private String preAppDt;
	//문서상태 - 미리 세팅해야 함
	private String docStat="APP000";
	//처리상태
	private int handleStat=0; 
	private String handleDt;
	//처리해야 하는지 여부
	private String doHandle; // 'Y'-> 처리해야 함. 'N' -> 불필요. 'U' -> 알수없음(아직 전결상태 이전이므로 구분하는 것이 무의미한 경우 등)
	//최신유무
	private int newAt=0;
	//조회수
	private int cnt = 0;
	//파일첨부아이디
	private String atchFileId = "";
	//재기안횟수 
	private int reUseCnt = 0;
	//재기안타입
	private int reWriteTyp = 0; // 0 -> 재기안이 아님. 1 -> 재기안 2-> 삭제
	//개인결제총액
	private long expSum = 0;
	//판관비초과
	private String exceedManage;
	//기한초과
	private String expiredDate;
	
	//일반결재문서 Prj Id (TBL_PRJ의 Primary key PRJ_ID와 구분)
	private String prjIdDoc = "";

	private int rejCfmStat = 0;

	//sales 관련
	private String decideYn = "";
	private String salesOut = "";
	private String salesIn = "";
	private long cost = 0;
	private String bondManageYn = "Y";
	
	private String leaderNo = "0";
	
	private String mapYn = "N";		// 세금계산서 미발행내역, 매출문서-세금계산서 매핑여부
	
	
	public String getWriterId() {
		return writerId;
	}
	public void setWriterId(String writerId) {
		this.writerId = writerId;
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
	public String getWriteDt() {
		return writeDt;
	}
	public void setWriteDt(String writeDt) {
		this.writeDt = writeDt;
	}

	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	public String getDocId() {
		return docId;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public String getParntId() {
		return parntId;
	}
	public void setParntId(String parntId) {
		this.parntId = parntId;
	}
	public String getDocStat() {
		return docStat;
	}
	public void setDocStat(String docStat) {
		this.docStat = docStat;
	}
	public int getHandleStat() {
		return handleStat;
	}
	public String getHandleStatPrint() {
		String printStat = "-"; 
		if ("Y".equals(doHandle)) {
			if (handleStat == 0) printStat = "<span class=\"txtB_orange\">처리중</span>"; 
			if (handleStat == 1) printStat = "<span class=\"txtB_grey\">완료</span>"; 
			if (handleStat == 2) printStat = "<span class=\"txtB_blue2\">취소</span>"; 
		}
		return printStat;
	}
	public void setHandleStat(int handleStat) {
		this.handleStat = handleStat;
	}
	public int getNewAt() {
		return newAt;
	}
	public void setNewAt(int newAt) {
		this.newAt = newAt;
	}
	
	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
	}
	public int getWriterNo() {
		return writerNo;
	}
	public void setTempltId(String templtId) {
		this.templtId = templtId;
	}
	public String getTempltId() {
		return templtId;
	}
	public void setRejCfmStat(int rejCfmStat) {
		this.rejCfmStat = rejCfmStat;
	}
	public int getRejCfmStat() {
		return rejCfmStat;
	}
	public void setHandleDt(String handleDt) {
		this.handleDt = handleDt;
	}
	public String getHandleDt() {
		return handleDt;
	}
	public void setPreAppDt(String preAppDt) {
		this.preAppDt = preAppDt;
	}
	public String getPreAppDt() {
		return preAppDt;
	}
	
	public String getWriteDtShort()
	{
		return writeDt.substring(0,4) +"." + writeDt.substring(5,7) +"." +writeDt.substring(8,10);
	}
	public String getWriteDtLong()
	{
		return writeDt.substring(0,4) +"." + writeDt.substring(5,7) +"." +writeDt.substring(8,10)  + " " +writeDt.substring(11);
	}
	public String getWriteDtMedium()
	{
		return writeDt.substring(2,4) +"." + writeDt.substring(5,7) +"." +writeDt.substring(8,10)  + " " +writeDt.substring(11);
	}
	
	public String getPreAppDtShort()
	{
		return preAppDt.substring(0,4) +"." + preAppDt.substring(5,7) +"." +preAppDt.substring(8,10);
	}
	public String getPreAppDtLong()
	{
		return preAppDt.substring(0,4) +"." + preAppDt.substring(5,7) +"." +preAppDt.substring(8,10)  + " " + preAppDt.substring(11);
	}
	public String getPreAppDtMedium()
	{
		return preAppDt.substring(2,4) +"." + preAppDt.substring(5,7) +"." +preAppDt.substring(8,10)  + " " + preAppDt.substring(11);
	}
	
	public String getHandleDtShort()
	{
		return handleDt.substring(0,4) +"." + handleDt.substring(5,7) +"." +handleDt.substring(8,10);
	}
	public String getHandleDtLong()
	{
		return handleDt.substring(0,4) +"." + handleDt.substring(5,7) +"." +handleDt.substring(8,10)  + handleDt.substring(11);
	}


	public void setReWriteTyp(int reWriteTyp) {
		this.reWriteTyp = reWriteTyp;
	}
	public int getReWriteTyp() {
		return reWriteTyp;
	}
	public void setReUseCnt(int reUseCnt) {
		this.reUseCnt = reUseCnt;
	}
	public int getReUseCnt() {
		return reUseCnt;
	}
	public void setDecideYn(String decideYn) {
		this.decideYn = decideYn;
	}
	public String getDecideYn() {
		return decideYn;
	}
	public String getDecideYnPrint() {		
		if(decideYn == null)
			return decideYn;
		else if(decideYn.equals("Y"))
			return "확정";
		else if(decideYn.equals("N"))
			return "예상";
		return decideYn;
	}
		
	public String getDocStatPrint(){
		String print=""; 
		if(KmsApprovalController.writingC.equals(docStat)){
			print = "기안대기";
		}
		else if(KmsApprovalController.reviewingC.equals(docStat)){
			print = "<span class=\"txtB_green\">검토중</span>";
		}
		else if(KmsApprovalController.cooperatingC.equals(docStat)){
			print = "<span class=\"txtB_blue2\">협조중</span>";
		}
		else if(KmsApprovalController.decidingC.equals(docStat)){
			print = "<span class=\"txtB_orange\">전결중</span>";
		}
		else if(KmsApprovalController.referencingC.equals(docStat)){
			print = "<span class=\"txtB_blue\">참조중</span>";
		}
		else if(KmsApprovalController.decidedC.equals(docStat)){
			print = "<span class=\"txtB_grey\">완료</span>";
		}
		else
			print = "결재실패";
		
		return print;
	}
	
	public String getDoHandle() {
		return doHandle;
	}
	public void setDoHandle(String doHandle) {
		this.doHandle = doHandle;
	}
	public long getExpSum() {
		return expSum;
	}
	public void setExpSum(long expSum) {
		this.expSum = expSum;
	}
	public String getExceedManage() {
		return exceedManage;
	}
	public void setExceedManage(String exceedManage) {
		this.exceedManage = exceedManage;
	}
	public String getExpiredDate() {
		return expiredDate;
	}
	public void setExpiredDate(String expiredDate) {
		this.expiredDate = expiredDate;
	}
	public String getSalesOut() {
		return salesOut;
	}
	public void setSalesOut(String salesOut) {
		this.salesOut = salesOut;
	}
	public String getSalesIn() {
		return salesIn;
	}
	public void setSalesIn(String salesIn) {
		this.salesIn = salesIn;
	}
	public String getSalesType() {
		if (salesOut.equals("Y") && salesIn.equals("Y"))
			return "외부/내부";
		else if (salesOut.equals("Y") && salesIn.equals("N"))
			return "외부";
		else if (salesOut.equals("N") && salesIn.equals("Y"))
			return "내부";
		else if (salesOut.equals("N") && salesIn.equals("N"))
			return "";
		return "";
	}
	public long getCost() {
		return cost;
	}
	public void setCost(long cost) {
		this.cost = cost;
	}
	/**
	 * @return the bondManageYn
	 */
	public String getBondManageYn() {
		return bondManageYn;
	}
	/**
	 * @param bondManageYn the bondManageYn to set
	 */
	public void setBondManageYn(String bondManageYn) {
		this.bondManageYn = bondManageYn;
	}
	public void setPrjIdDoc(String prjIdDoc) {
		this.prjIdDoc = prjIdDoc;
	}
	public String getPrjIdDoc() {
		return prjIdDoc;
	}
	public void setLeaderNo(String leaderNo) {
		this.leaderNo = leaderNo;
	}
	public String getLeaderNo() {
		return leaderNo;
	}
	public String getMapYn() {
		return mapYn;
	}
	public void setMapYn(String mapYn) {
		this.mapYn = mapYn;
	}
}
