package kms.com.common.interceptor;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.config.ConditionSettingKey;
import kms.com.common.service.CommonService;
import kms.com.common.service.ExpansionVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.DayReportService;
import kms.com.cooperation.service.TaskVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class BaseInterceptor extends HandlerInterceptorAdapter{

	@Resource(name = "KmsCommonService")
	private CommonService commonService;

	@Resource(name="KmsDayReportService")
	private DayReportService dayReportService;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		try{
			if(SessionUtil.isLogin(req)) {
				//System.out.println("Login Ok");
				MemberVO user = SessionUtil.getMember(req);

				req.getSession().setAttribute("user", user);
				if (req.getSession().getAttribute( ConditionSettingKey.REDIRECT_PAGE ) != null) {
					req.getSession().setAttribute( ConditionSettingKey.REDIRECT_PAGE , null);
				}
				if (req.getSession().getAttribute( ConditionSettingKey.REDIRECT_PARAM ) != null) {
					EgovMap param = (EgovMap)req.getSession().getAttribute(ConditionSettingKey.REDIRECT_PARAM);
					if(param != null){
						for (int i=0; i<param.size(); i++) {
							req.setAttribute( (String)param.get(i), param.get(param.get(i)) );
						}
					}
					req.getSession().setAttribute( ConditionSettingKey.REDIRECT_PARAM , null);
				}

				Map<String,Object> param = new HashMap<String,Object>();
				param.put("searchUserNo", user.getNo());
				param.put("limitSize", 9999);
				
				List<ExpansionVO> expList = commonService.getExpansionList(user);
				List<EgovMap> myMenuList = commonService.getMyMenuList(user);
				EgovMap calendarInfo = commonService.getCalendar(new HashMap<String, Object>(), user);
				EgovMap scheduleInfo = commonService.getSchedule(new HashMap<String, Object>(), user);
				List<TaskVO> taskList = dayReportService.selectTaskList(param);
				//user.setShowRight("0");
				//memberService.updtMemberUiSetting(user);
				
				req.setAttribute("user", user);
				req.setAttribute("loginTime", SessionUtil.getLoginTime(req));
				req.setAttribute("todayDate", CalendarUtil.getToday());
				req.setAttribute("expList", expList);
				req.setAttribute("myMenuList", myMenuList);
				req.setAttribute("calendarInfo", calendarInfo);
				req.setAttribute("scheduleInfo", scheduleInfo);
				req.setAttribute("taskList", taskList);;
				return true;
			}else{
				
				if(req.getRequestURL().indexOf("app.do") > 0){ // 화상회의 다운로드 페이지 로그인 예외 처리 20130913 김대현
					return true;
				} else if (req.getRequestURL().indexOf("member/ajax/selectMemberList.do") > 0) {	// 알림톡 사원정보 전달 페이지 로그인 예외처리 20150514 김동우
					return true;
				}
				
				if (req.getMethod().equalsIgnoreCase("GET")) {
					String qs = req.getQueryString();
					if(qs != null) qs = "?" + qs;
					else qs = "";
					
					req.getSession().setAttribute( ConditionSettingKey.REDIRECT_PAGE , req.getRequestURI() + qs);
					
					EgovMap param = new EgovMap();
					
					Enumeration e = req.getParameterNames();
					while(e.hasMoreElements()) {
						String tmp = (String) e.nextElement();
						param.put(tmp, req.getParameter(tmp));
					}
					
					req.getSession().setAttribute( ConditionSettingKey.REDIRECT_PARAM , param);
				} else {
					if(req.getSession().getAttribute(ConditionSettingKey.REDIRECT_PAGE) != null) {
						req.getSession().removeAttribute( ConditionSettingKey.REDIRECT_PAGE );
					}
				}
				
				String userAgent = req.getHeader("user-agent");
				String[] mobileos = {"iPhone","iPod","Android","BlackBerry","Windows CE", "Nokia","Webos","Opera Mini","SonyEricsson","Opera Mobi","IEMobile"};
				boolean isMobile = false;
				int j = -1;
				for(int i=0; i<mobileos.length; i++){
					j = userAgent.indexOf(mobileos[i]);
					if(j > -1){
						//System.out.println("os - : " + userAgent);
						isMobile = true; 
						break;
					}
				}
				
				if(isMobile) 
					res.sendRedirect("/mobile/login.do");
				else 
					res.sendRedirect("/login.do");
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
