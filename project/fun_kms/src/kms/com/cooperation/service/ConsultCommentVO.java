package kms.com.cooperation.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ConsultCommentVO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Integer no;	
	private Integer userNo;	
	private String	consult_no;	
	private String  cn           = "";	
	private String  atchFileId   = "";
	private String  regDt        = "";	
	private String  udtDt        = "";	
	private String  useAt        = "";	
	private String  userId        = "";	
	private String  userNm        = "";
	
	private String type;
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}	

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public Integer getUserNo() {
		return userNo;
	}

	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}

	public String getConsult_no() {
		return consult_no;
	}

	public void setConsult_no(String consult_no) {
		this.consult_no = consult_no;
	}

	public String getCn() {
		return cn;
	}

	public void setCn(String cn) {
		this.cn = cn;
	}

	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getUdtDt() {
		return udtDt;
	}

	public void setUdtDt(String udtDt) {
		this.udtDt = udtDt;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}


	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}	
	
}
