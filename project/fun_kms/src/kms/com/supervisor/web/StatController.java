package kms.com.supervisor.web;

import java.net.URLEncoder;
import java.util.*;
import java.text.*; 

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kms.com.member.service.MemberVO;
import kms.com.member.service.impl.MemberDAO;
import kms.com.member.vo.UserVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.ProjectVO;
import kms.com.cooperation.service.impl.ProjectDAO;
import kms.com.daily.service.DailyService;
import kms.com.daily.dao.DailyDAO;
import kms.com.daily.fm.*;
import kms.com.daily.vo.*;

@Controller
public class StatController {

	Logger logT = Logger.getLogger("TENY");

	@Resource(name="KmsDailyDAO")
	private DailyDAO dailyDAO;

	@Resource(name="KmsDailyService")
	private DailyService dailyService;
	
	@Resource(name="KmsProjectDAO")
	private ProjectDAO projectDAO;

	@Resource(name="KmsMemberDAO")
	private MemberDAO memberDAO;

	/* TENY_170418 나의 업무입력현황을 조회하는 기능 */
	@RequestMapping("/supervisor/StatDailyList.do")
	public String StatDailyList(@ModelAttribute("dailyReportFm") DailyPlanFm dailyReportFm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");

		MemberVO user = SessionUtil.getMember(req);
		Map<String, Object> map = new HashMap<String, Object>();
		if(dailyReportFm.getSearchUseYn().equals("Y")) { // 검색조건이 있는 경우
			if(dailyReportFm.getDateMove() != 0) {
				dailyReportFm.setAtDate(CalendarUtil.getDate(dailyReportFm.getAtDate(), dailyReportFm.getDateMove()));
			}
		} 
		else { // 검색조건 없이 리스트 하는 경우 : 사용자는 접속자, 검색일자는 오늘
			dailyReportFm.setWriterNo(user.getNo());
			dailyReportFm.setWriterName(user.getUserNm());
			dailyReportFm.setAtDate(CalendarUtil.getToday());
		}
		
		//for-loop 통한 1주일 단위로 조회 report가 없는날도 DailyReportVO를 만든다.
		List <DailyPlanVO> dailyReportVOList = dailyService.selectDailyWeekList(dailyReportFm.getWriterNo(), dailyReportFm.getAtDate());

		model.addAttribute("dailyReportVOList", dailyReportVOList);
//		model.addAttribute("dailyReportVO", dailyReportVO);  // atDate(찾고자하는 일자), writerNo, writerName을 보낸다.
		
		/* TENY_170404 자신의 부서원들의 리스트를 검색한다 */
		/* TENY_170417 겸직인경우 겸직의 부서원들의 리스트를 추가로 검색한다 */
		map.clear();
		map.put("topOrgId", user.getOrgnztId());
		map.put("orgnztIdSec", user.getOrgnztIdSec());
		List<UserVO> memberList= memberDAO.selectUserList(map);

		model.addAttribute("memberList", memberList);

		model.addAttribute("searchWriterNo", dailyReportFm.getWriterNo());
		model.addAttribute("searchWriterName", dailyReportFm.getWriterName());
		model.addAttribute("searchAtDate", dailyReportFm.getAtDate());

		logT.debug("END");
		return "daily/ReportWeekList";
	}
	
}
