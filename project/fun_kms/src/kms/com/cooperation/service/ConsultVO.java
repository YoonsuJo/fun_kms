package kms.com.cooperation.service;

import java.io.Serializable;

public class ConsultVO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Integer no              ;
	
	private Integer userNo          ;
	
	private Integer consultNo       ;
	
	private String cn           = "";       
	
	private String atchFileId   = "";
	
	private String regDt        = "";
	
	private String udtDt        = "";
	
	private String useAt        = "";
	
	private String userId        = "";
	
	private String userNm        = "";
	

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

	public Integer getConsultNo() {
		return consultNo;
	}

	public void setConsultNo(Integer consultNo) {
		this.consultNo = consultNo;
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
	
}
