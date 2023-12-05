package kms.com.member.service;

import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.LunarHandler;

public class MobileDeviceVO {
	private String macAddr;
	private String deviceType;
	private String tokenInfo;
	private String userNo;
	private String userId;
	
	
	public String getMacAddr() {
		return macAddr;
	}
	public void setMacAddr(String macAddr) {
		this.macAddr = macAddr;
	}
	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
	public String getTokenInfo() {
		return tokenInfo;
	}
	public void setTokenInfo(String tokenInfo) {
		this.tokenInfo = tokenInfo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserId() {
		return userId;
	}
}
