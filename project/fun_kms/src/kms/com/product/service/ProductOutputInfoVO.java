package kms.com.product.service;

import java.util.Date;


public class ProductOutputInfoVO {
	
	private String param_returnUrl;
	
	
	private String productNm;
	private String productId;	
	
	private String partId;
	private String partNm;
	
	private String outputId;
	private String outputNm;
	
	private Integer no;
	private String infoNm;
	private String infoCn;

	private Integer writerNo;	//등록자
	private String writerNm;	//등록자
	private String writerId;	//등록자
	
	
	private Date regDt;			//등록일
	private Date modDt;			//수정일
	
	private String atchFileId;
	
	private String useAt;
	
	public String getParam_returnUrl() {
		return param_returnUrl;
	}

	public void setParam_returnUrl(String param_returnUrl) {
		this.param_returnUrl = param_returnUrl;
	}

	public String getProductNm() {
		return productNm;
	}

	public void setProductNm(String productNm) {
		this.productNm = productNm;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
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

	public String getOutputId() {
		return outputId;
	}

	public void setOutputId(String outputId) {
		this.outputId = outputId;
	}

	public String getOutputNm() {
		return outputNm;
	}

	public void setOutputNm(String outputNm) {
		this.outputNm = outputNm;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public String getInfoNm() {
		return infoNm;
	}

	public void setInfoNm(String infoNm) {
		this.infoNm = infoNm;
	}

	public String getInfoCn() {
		return infoCn;
	}

	public void setInfoCn(String infoCn) {
		this.infoCn = infoCn;
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

	/**
	 * @param useAt the useAt to set
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	/**
	 * @return the useAt
	 */
	public String getUseAt() {
		return useAt;
	}
	
	
	
}
