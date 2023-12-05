package kms.com.support.service;

import kms.com.common.utils.CommonUtil;
import lombok.Getter;
import lombok.Setter;

public class IpVO{
	
	@Getter @Setter private int no;					// IP No
	@Getter @Setter private String bw;				// 대역폭
	@Getter @Setter private String ip;				// IP
	@Getter @Setter private String[] ipUserList;	// IP 사용자 List
	@Getter @Setter private int ipUserNo;			// IP 사용자 No
	@Getter @Setter private String ipUserNm;		// IP 사용자 이름
	@Getter @Setter private String ipUserId;		// IP 사용자 ID
	@Getter @Setter private String ipPurpose;		// IP 사용 목적
	@Getter @Setter private String ipModDate;		// 발급일
	@Getter @Setter private int ipModUserNo;		// 발급자 No
	@Getter @Setter private String ipModUserNm;		// 발급자 이름
	@Getter @Setter private String ipModUserId;		// 발급자 ID
	
	public String getipModDate() {
		return CommonUtil.getDateType(ipModDate);
	}
}
