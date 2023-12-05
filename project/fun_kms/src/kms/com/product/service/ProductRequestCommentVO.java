package kms.com.product.service;

import java.util.Date;


public class ProductRequestCommentVO {
	
	
	private String productId;
	private String requestType;
	private String commentYn;
	
	private String requestId; 
	private Integer no;
	
	private Integer writerNo;
	private String writerNm;
	private String writerId;

	private String commentCn;
	private Date regDt;
	private Date modDt;
	private String atchFileId;
	private String useAt;
	
	
	
	private String type;
    private boolean isModified = false;
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	public String getCommentYn() {
		return commentYn;
	}
	public void setCommentYn(String commentYn) {
		this.commentYn = commentYn;
	}
	public String getRequestId() {
		return requestId;
	}
	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
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
	public String getCommentCn() {
		return commentCn;
	}
	public void setCommentCn(String commentCn) {
		this.commentCn = commentCn;
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
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getUseAt() {
		return useAt;
	}
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public boolean isModified() {
		return isModified;
	}
	public void setModified(boolean isModified) {
		this.isModified = isModified;
	}
    
    

   
    
}
