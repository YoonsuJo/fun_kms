package kms.com.product.service;

import java.util.Date;


public class ProductRequestHistoryVO {
	
	private String requestId;  
	private Integer writerNo;	//등록자
	private String writerId;	//등록자
	private String writerNm;	//등록자
	private Date regDt;			//등록일
	private Integer no;
	private String historyState; //진행내역  처리미완료A 처리완료B 검토C 재검토D 수정E 등록F
	private String historyCn;
	
	
	public String getRequestId() {
		return requestId;
	}
	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}
	public Integer getWriterNo() {
		return writerNo;
	}
	public void setWriterNo(Integer writerNo) {
		this.writerNo = writerNo;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public String getHistoryState() {
		return historyState;
	}
	public void setHistoryState(String historyState) {
		this.historyState = historyState;
	}
	public String getHistoryCn() {
		return historyCn;
	}
	public void setHistoryCn(String historyCn) {
		this.historyCn = historyCn;
	}
	/**
	 * @param writerId the writerId to set
	 */
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	/**
	 * @return the writerId
	 */
	public String getWriterId() {
		return writerId;
	}
	/**
	 * @param writerNm the writerNm to set
	 */
	public void setWriterNm(String writerNm) {
		this.writerNm = writerNm;
	}
	/**
	 * @return the writerNm
	 */
	public String getWriterNm() {
		return writerNm;
	}     
	
	

	
}
