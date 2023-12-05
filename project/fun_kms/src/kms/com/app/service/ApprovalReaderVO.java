package kms.com.app.service;


/**
 * @author blind
 * 작성일 : 2011.08.26
 * 전자결재 관련 VO
 *
 */
@SuppressWarnings("serial")
public class ApprovalReaderVO{
	 
	private String docId;
	private int no;
	private String appTyp;
	//조회일
	private String srchDt;
	private Integer stat =0;

	private int readerNo;
	private String readerNm;
	private String readerId;
	//승인일
	private String appDt;
	
	public ApprovalReaderVO()
	{
	
	}
	
	public ApprovalReaderVO(String docId, String approvalType, String readerId) {
		this.docId = docId;
		this.appTyp= approvalType;
		this.readerId = readerId;
		
	}


	public String getDocId() {
		return docId;
	}


	public void setDocId(String docId) {
		this.docId = docId;
	}


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getAppTyp() {
		return appTyp;
	}


	public void setAppTyp(String appTyp) {
		this.appTyp = appTyp;
	}


	public String getSrchDt() {
		return srchDt;
	}


	public void setSrchDt(String srchDt) {
		this.srchDt = srchDt;
	}


	public Integer getStat() {
		return stat;
	}


	public void setStat(Integer stat) {
		this.stat = stat;
	}


	public int getReaderNo() {
		return readerNo;
	}


	public void setReaderNo(int readerNo) {
		this.readerNo = readerNo;
	}


	public String getReaderNm() {
		return readerNm;
	}


	public void setReaderNm(String readerNm) {
		this.readerNm = readerNm;
	}


	public String getReaderId() {
		return readerId;
	}


	public void setReaderId(String readerId) {
		this.readerId = readerId;
	}


	public String getAppDt() {
		return appDt;
	}


	public void setAppDt(String appDt) {
		this.appDt = appDt;
	}

	public String getAppDtShort()
	{
		return appDt.substring(0,4) +"." + appDt.substring(5,7) +"." +appDt.substring(8,10);
	}
	public String getAppDtLong()
	{
		return appDt.substring(0,4) +"." + appDt.substring(5,7) +"." +appDt.substring(8,10)  + appDt.substring(11);
	}
	
	
	public String getSrchDtShort()
	{
		return srchDt.substring(0,4) +"." + srchDt.substring(5,7) +"." +srchDt.substring(8,10);
	}
	public String getSrchDtLong()
	{
		return srchDt.substring(0,4) +"." + srchDt.substring(5,7) +"." +srchDt.substring(8,10)  + srchDt.substring(11);
	}
}
