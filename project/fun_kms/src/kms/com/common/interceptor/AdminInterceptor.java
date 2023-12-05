package kms.com.common.interceptor;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.config.ConditionSettingKey;
import kms.com.common.config.PathConfig;
import kms.com.common.service.CommonService;
import kms.com.common.service.Expansion;
import kms.com.common.service.ExpansionVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.ScheduleVO;
import kms.com.member.service.MemberVO;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class AdminInterceptor extends HandlerInterceptorAdapter{

    @Resource(name = "KmsCommonService")
    private CommonService commonService;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		try{
			
			if(SessionUtil.isLogin(req) == false) {
				res.sendRedirect("/main.do");
				return false;
			} else if(SessionUtil.isLogin(req) && SessionUtil.getMember(req).isAdmin()) {
				return true;
			} else {
				res.sendRedirect("/adminError.do");
				
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}

		return true;
		//return super.preHandle(req, res, handler);
	}

	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(req, res, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object handler, Exception ex) throws Exception {
		//if(ex!=null) PageHandler.warningMsg(res, ex, false);
		super.afterCompletion(req, res, handler, ex);
	}
}
