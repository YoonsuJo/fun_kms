package kms.com.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.config.PathConfig;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CommonInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		req.setAttribute("rootPath", PathConfig.rootPath);
		req.setAttribute("imagePath", PathConfig.imagePath);
		req.setAttribute("commonPath", PathConfig.commonPath);
		req.setAttribute("jspPath", PathConfig.jspPath);
		
		req.setAttribute("commonMobilePath", PathConfig.commonMobilePath);
		req.setAttribute("jspMobilePath", PathConfig.jspMobilePath);
		
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
