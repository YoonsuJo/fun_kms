package kms.com.product.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class ProductOutputVO {
	
	private String sortNoType;
	private String param_returnUrl;
	private String productNm;
	
	private String productId;	
	private String partId;
	private String partNm;
	private String outputId;
	private String outputNm;
	private String outputCn;

	private Integer writerNo;	//등록자
	private String writerNm;	//등록자
	private String writerId;	//등록자
	
	
	private String useAt;       //사용여부 YN
	private Integer sortNo;		//정열 순서
	private Date regDt;			//등록일
	private Date modDt;			//수정일
	
	List<ProductOutputInfoVO> outputInfoList = new ArrayList<ProductOutputInfoVO>();
	private Integer outputInfoCnt;
	
	public String getParam_returnUrl() {
		return param_returnUrl;
	}
	public void setParam_returnUrl(String param_returnUrl) {
		this.param_returnUrl = param_returnUrl;
	}
	public String getPartId() {
		return partId;
	}
	public void setPartId(String partId) {
		this.partId = partId;
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
	public String getOutputCn() {
		return outputCn;
	}
	public void setOutputCn(String outputCn) {
		this.outputCn = outputCn;
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
	public String getUseAt() {
		return useAt;
	}
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	public Integer getSortNo() {
		return sortNo;
	}
	public void setSortNo(Integer sortNo) {
		this.sortNo = sortNo;
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
	/**
	 * @param sortNoType the sortNoType to set
	 */
	public void setSortNoType(String sortNoType) {
		this.sortNoType = sortNoType;
	}
	/**
	 * @return the sortNoType
	 */
	public String getSortNoType() {
		return sortNoType;
	}
	/**
	 * @param productId the productId to set
	 */
	public void setProductId(String productId) {
		this.productId = productId;
	}
	/**
	 * @return the productId
	 */
	public String getProductId() {
		return productId;
	}
	/**
	 * @param productNm the productNm to set
	 */
	public void setProductNm(String productNm) {
		this.productNm = productNm;
	}
	/**
	 * @return the productNm
	 */
	public String getProductNm() {
		return productNm;
	}
	/**
	 * @param partNm the partNm to set
	 */
	public void setPartNm(String partNm) {
		this.partNm = partNm;
	}
	/**
	 * @return the partNm
	 */
	public String getPartNm() {
		return partNm;
	}
	public List<ProductOutputInfoVO> getOutputInfoList() {
		return outputInfoList;
	}
	public void setOutputInfoList(List<ProductOutputInfoVO> outputInfoList) {
		this.outputInfoList = outputInfoList;
	}
	/**
	 * @param outputInfoCnt the outputInfoCnt to set
	 */
	public void setOutputInfoCnt(Integer outputInfoCnt) {
		this.outputInfoCnt = outputInfoCnt;
	}
	/**
	 * @return the outputInfoCnt
	 */
	public Integer getOutputInfoCnt() {
		return outputInfoCnt;
	}
	
	
	
	
}
