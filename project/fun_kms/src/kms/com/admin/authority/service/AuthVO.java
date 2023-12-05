package kms.com.admin.authority.service;

import java.io.Serializable;

/**
 * @Class Name : KmsEappDoctypVO.java
 * @Description : KmsEappDoctyp VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class AuthVO
implements Serializable{
	
	private String authCode;
	private String authNm;
	private String regDt;
	private String userComplexs;
	private String userId;
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
	public String getAuthCode() {
		return authCode;
	}
	public void setAuthNm(String authNm) {
		this.authNm = authNm;
	}
	public String getAuthNm() {
		return authNm;
	}
	
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setUserComplexs(String userComplexs) {
		this.userComplexs = userComplexs;
	}
	public String getUserComplexs() {
		return userComplexs;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserId() {
		return userId;
	}
	
      
}
