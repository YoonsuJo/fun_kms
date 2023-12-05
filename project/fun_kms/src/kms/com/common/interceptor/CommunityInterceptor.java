package kms.com.common.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.service.CommonService;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberVO;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class CommunityInterceptor extends HandlerInterceptorAdapter{


    @Resource(name = "KmsCommonService")
    private CommonService commonService;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		EgovMap commList = commonService.getCommunityUnreadCnt(user);
		req.setAttribute("commList", commList);
		
		return true;
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
