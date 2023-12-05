package kms.com.common.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;

import kms.com.common.config.ConditionSettingKey;
import kms.com.member.service.MemberVO;

public class SessionUtil {
	public static void defaultSetting(HttpSessionEvent se) {
		HttpSession ss = se.getSession();
	}

	public static boolean isLogin(HttpServletRequest req) throws Exception {
		HttpSession ss = req.getSession();
		MemberVO member = (MemberVO)ss.getAttribute(ConditionSettingKey.MEMBER);
		boolean chk = false;
		if(member == null || member.getUserId() == null || member.getUserId().equals("")){
			return false;
		}
		return true;
	}

	
	//Login 처리
	public static MemberVO getMember(HttpServletRequest req) {
		return getMember(req.getSession());
	}
	public static MemberVO getMember(HttpSession ss) {
		try{
			return (MemberVO)ss.getAttribute(ConditionSettingKey.MEMBER);
		}catch(Exception e){
			return null;
		}
	}
	
	public static void logout(HttpSession ss) {
		ss.invalidate();
	}

	public static Object getLoginTime(HttpServletRequest req) {
		HttpSession ss = req.getSession();
		String loginTime = (String)ss.getAttribute(ConditionSettingKey.LOGIN_TIME);
		return loginTime;
	}


}
