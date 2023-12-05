package kms.com.daily.web;

import java.net.URLEncoder;
import java.util.*;
import java.text.*; 

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.cxf.common.util.StringUtils;
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
import kms.com.project.dao.ProjectDAO2;
import kms.com.daily.service.DailyService;
import kms.com.daily.dao.DailyDAO;
import kms.com.daily.fm.*;
import kms.com.daily.vo.*;
import kms.com.admin.organ.service.impl.OrganDAO;
import kms.com.admin.organ.service.Organ;
import kms.com.admin.organ.service.OrganVO;
import kms.com.request.dao.RequestDAO;
import kms.com.request.vo.ReqTaskVO;
import kms.com.request.vo.RequestDailyVO;


@Controller
public class DailyController {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name="KmsDailyDAO")
	private DailyDAO dailyDAO;

	@Resource(name="KmsDailyService")
	private DailyService dailyService;
	
	@Resource(name="KmsProjectDAO2")
	private ProjectDAO2 projectDAO;

	@Resource(name="KmsMemberDAO")
	private MemberDAO memberDAO;

	@Resource(name="OrganDAO")
	private OrganDAO organDAO;

	@Resource(name="KmsRequestDAO")
	private RequestDAO requestDAO;

	/* TENY_170402 나의 업무를 개인별로 조회하는 기능(주단위로) */
	@RequestMapping("/daily/DailyByWeekL.do")
	public String DailyByWeekL(@ModelAttribute("dailyPlanFm") DailyPlanFm dailyPlanFm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		// 검색 조건 : 1. 작성자 user NO, (+ 작성자 user name)  2. 작성기준일(작성되어야 하는 일자 yyyymmdd) (+ 이동일)
		// 작성자가 없는 경우 접속자의 user no를 기본값으로 한다.
		MemberVO user = SessionUtil.getMember(req);
		if(dailyPlanFm.getWriterNo() == 0) {
			dailyPlanFm.setWriterNo(user.getNo());
			dailyPlanFm.setWriterName(user.getUserNm());
		}
		// 작성기준일이 없는 경우 오늘을 검색조건의 작성기준일로 한다.
		if((dailyPlanFm.getAtDate() == null) || (dailyPlanFm.getAtDate().length() == 0) ) { // 검색조건(작성기준일)이 없는 경우
			dailyPlanFm.setAtDate(CalendarUtil.getToday());
			dailyPlanFm.setDateMove(0);
		}
		// 검색조건에 이종일이 있는 경우 검색조건(작성기준일)을 수정한다.
		if(dailyPlanFm.getDateMove() != 0) {
			dailyPlanFm.setAtDate(CalendarUtil.getDate(dailyPlanFm.getAtDate(), dailyPlanFm.getDateMove()));
		}
		
		// 검색조건(작성기준일)이 포함된 주의 월요일부터 일요일까지의 업무계획 및 실적을 조회한다.
		List <DailyPlanVO> dailyPlanVOList = dailyService.selectDailyWeekList(dailyPlanFm.getWriterNo(), dailyPlanFm.getAtDate());
		if(dailyPlanVOList.size() != 7) {
			logT.debug("selectDailyWeekList fail");
			model.addAttribute("message", "일일업무보고가 조회에 실패하였습니다. \n관리자에게 문의바랍니다 ");
			return "common/returnPage/message";
		}
		model.addAttribute("dailyPlanVOList", dailyPlanVOList);
//		model.addAttribute("dailyPlanVO", dailyPlanVO);  // atDate(찾고자하는 일자), writerNo, writerName을 보낸다.
		
		/* TENY_170404 자신의 부서원들의 리스트를 검색한다 */
		/* TENY_170417 겸직인경우 겸직의 부서원들의 리스트를 추가로 검색한다 */
		Map<String, Object> map = new HashMap<String, Object>();
		
		OrganVO orgVO = new OrganVO();
		orgVO.setOrgnztId(user.getOrgnztId());
		Organ userOrg = organDAO.selectOrganDetail(orgVO);
		if("ORGAN_TOP_ORGAN_CODE".equals(userOrg.getOrgUp()) && !"ORGAN_TOP_ORGAN_CODE".equals(user.getOrgnztId())) {
			if(user.isLeader()) {
				map.put("topOrgId", user.getOrgnztId());
				map.put("orgnztIdSec", user.getOrgnztIdSec());
			}else {
				map.put("topOrgId", user.getOrgnztId());
				map.put("orgnztIdSec", user.getOrgnztIdSec());
			}
		}else {
			map.put("topOrgId", user.getOrgnztId());
			map.put("orgnztIdSec", user.getOrgnztIdSec());
		}
		
		List<UserVO> memberList= memberDAO.selectUserList(map);

		model.addAttribute("memberList", memberList);

		model.addAttribute("searchWriterNo", dailyPlanFm.getWriterNo());
		model.addAttribute("searchWriterName", dailyPlanFm.getWriterName());
		model.addAttribute("searchAtDate", dailyPlanFm.getAtDate());

		logT.debug("END");
		return "daily/DailyByWeekL";
	}
	
	/* TENY_170402 나의 업무를 부서별로 조회하는 기능(일단위로) */
	@RequestMapping("/daily/DailyByOrgL.do")
	public String DailyByOrgL(@ModelAttribute("dailyPlanFm") DailyPlanFm dailyPlanFm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");

		if(StringUtils.isEmpty(dailyPlanFm.getAtDate())) {
			dailyPlanFm.setAtDate(CalendarUtil.getToday());
			dailyPlanFm.getAtDate();
		}
		
		MemberVO user = SessionUtil.getMember(req);
		if(!dailyPlanFm.getSearchUseYn().equals("Y")) { // 검색조건 없이 리스트 하는 경우 : 사용자는 접속자, 검색일자는 오늘
			dailyPlanFm.setWriterOrgnztId(user.getOrgnztId());
			dailyPlanFm.setWriterOrgnztName(user.getOrgnztNm());
			dailyPlanFm.setAtDate(CalendarUtil.getToday());
		}
		else { // 검색조건이 있는 경우
			if(dailyPlanFm.getDateMove() != 0) { // 날짜 이동이 있는 경우 이동날짜를 이용하여 검색날짜를 수정한다. 
				dailyPlanFm.setAtDate(CalendarUtil.getDate(dailyPlanFm.getAtDate(), dailyPlanFm.getDateMove()));
			}else { // 날짜 이동이 없는 경우 오늘 날짜로 다시 맞춰준다. (나의 메뉴에 추가했을 경우를 대비)
				dailyPlanFm.setAtDate(CalendarUtil.getToday());
				dailyPlanFm.getAtDate();
			}
			if(dailyPlanFm.getWriterOrgnztId().length() == 0) {
				dailyPlanFm.setWriterOrgnztId(user.getOrgnztId());
				dailyPlanFm.setWriterOrgnztName(user.getOrgnztNm());
			}
		} 
		
		// 선택된 부서의 부서원들이 작성한 나의업무를 리스트 한다. 
		List <DailyPlanVO> dailyPlanVOList = dailyService.selectDailyListOrg(
				dailyPlanFm.getWriterOrgnztId(), dailyPlanFm.getAtDate());

		model.addAttribute("dailyPlanVOList", dailyPlanVOList);
//		model.addAttribute("dailyPlanVO", dailyPlanVO);  // atDate(찾고자하는 일자), writerNo, writerName을 보낸다.
		
		/* TENY_170420 자신의 부서 및 하위부서목록을 검색한다. */
		/* TENY_170420 겸직인경우 겸직 부서 및 하위부서목록을 검색한다.*/
		OrganVO orgVO = new OrganVO();
		if(user.getUserNm().equals("오성민")) {
			orgVO.setOrgnztId("ORGAN_TOP_ORGAN_CODE");
		
		} else {
			OrganVO searchOrg = new OrganVO();
			searchOrg.setOrgnztId(user.getOrgnztId());
			Organ userOrg = organDAO.selectOrganDetail(searchOrg);
			if("ORGAN_TOP_ORGAN_CODE".equals(userOrg.getOrgUp()) && !"ORGAN_TOP_ORGAN_CODE".equals(user.getOrgnztId())) {
				if(user.isLeader()) {
					orgVO.setOrgnztId(userOrg.getOrgUp());
				}else {
					orgVO.setOrgnztId(user.getOrgnztId());
				}
			}else {
				orgVO.setOrgnztId(userOrg.getOrgUp());
			}
		}
		List organList = organDAO.selectOrganTreeList(orgVO);
		model.addAttribute("organList", organList);

		model.addAttribute("writerOrgnztId", dailyPlanFm.getWriterOrgnztId());
		model.addAttribute("writerOrgnztName", dailyPlanFm.getWriterOrgnztName());
		model.addAttribute("atDate", dailyPlanFm.getAtDate());

		logT.debug("END");
		return "daily/DailyByOrgL";
	}
	
	/* TENY_170402 업무계획 작성화면을 띄우는 기능 */
	@RequestMapping("/daily/DailyPlanWUPop.do")
	public String DailyPlanWUPop(@ModelAttribute("dailyPlanFm") DailyPlanFm dailyPlanFm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");

		// TENY_170518 내가처리해야하는 요구사항 업무목록을 작성화면 위쪽에 추가
		MemberVO user = SessionUtil.getMember(req);
		List <ReqTaskVO> rtVOList = requestDAO.selectMyReqTaskList(user.getNo());
		if(rtVOList != null){
			model.addAttribute("rtVOList", rtVOList);
		}

		// TENY_1704223 업무작성화면의 띄우기 위해서는 누구의 몇일날 업무계획을 작성할 것인가에 정보가 필요함
		DailyPlanVO dailyPlanVO = dailyDAO.getDailyPlan(dailyPlanFm.getWriterNo(), dailyPlanFm.getWriteDate());
		if(dailyPlanVO == null) {
			dailyPlanVO = new DailyPlanVO();
			dailyPlanFm.setNo(0);
			dailyPlanVO.setWriterNo(dailyPlanFm.getWriterNo());
			dailyPlanVO.setWriteDate(dailyPlanFm.getWriteDate());
		}
		model.addAttribute("dailyPlanVO", dailyPlanVO);
		
		logT.debug("END");
		return "daily/DailyPlanWUPop";
	}
	
	// TENY_170407 작성된 일일업무보고를 DB에 저장하는 기능
	@RequestMapping("/daily/insertDailyPlan.do")
	public String insertDailyPlan(@ModelAttribute("dailyPlanFm") DailyPlanFm fm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		MemberVO user = SessionUtil.getMember(req);
		if(fm.getNo() == 0){ // 새로 등록되는 글
			logT.debug("insert");
			DailyPlanVO dailyPlanVO = new DailyPlanVO();
			if(fm.getWriterNo() != user.getNo() && user.getNo() == 2) {
				dailyPlanVO.setWriterNo(fm.getWriterNo());
			}else {
				dailyPlanVO.setWriterNo(user.getNo());
			}
			dailyPlanVO.setWriteDate(fm.getWriteDate());
			dailyPlanVO.setContents(fm.getContents());
			dailyDAO.insertDailyPlan(dailyPlanVO);
		} 
		else {
			logT.debug("update");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("no", fm.getNo());
			map.put("contents", fm.getContents());
			dailyDAO.updateDailyPlan(map);
		}

		logT.debug("END");
		return "/common/returnPage/windowReloadNClose";
	}
	// TENY_170409 일일업무보고에 따른 수행프로젝트 및 투입시간을 입력하는 화면을 띄우는 기능
	@RequestMapping("/daily/DailyResultWUPop.do")
	public String DailyResultWUPop(@ModelAttribute("dailyResultFm") DailyResultFm dailyResultFm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		// TENY_170518 내가처리해야하는 요구사항 업무목록을 작성화면 위쪽에 추가
		MemberVO user = SessionUtil.getMember(req);
		//List <ReqTaskVO> rtVOList = requestDAO.selectMyReqTaskList(user.getNo());
		List <RequestDailyVO> rtVOList = requestDAO.selectMyReqDailyList(user.getNo());
		if(rtVOList != null){
			model.addAttribute("rtVOList", rtVOList);
		}

		// TENY_1704223 업무작성화면의 띄우기 위해서는 누구의 몇일날 업무계획을 작성할 것인가에 정보가 필요함
		if(dailyResultFm.getWriterNo() == 0) {
			logT.debug("No writerNo");
			model.addAttribute("message", "일일업무보고가 작성되어야 합니다");
			return "common/returnPage/message";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", user.getUserNo());
		map.put("year", CalendarUtil.getYear());
		map.put("month", CalendarUtil.getMonth());
		List <ProjectVO> projectVOList = projectDAO.selectMyProjectList(map);
		model.addAttribute("projectVOList", projectVOList);
			
		List <DailyResultVO> dailyResultVOList = dailyDAO.selectDailyResultList(
				dailyResultFm.getWriterNo(), dailyResultFm.getWriteDate(), dailyResultFm.getWriteDate());
		model.addAttribute("dailyResultVOList", dailyResultVOList);
		
//		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss", Locale.KOREA ); 
		Date date = new Date ( ); 
		Calendar cal = Calendar.getInstance ( ); 
		cal.setTime ( date ); 
		int hour = cal.get(Calendar.HOUR_OF_DAY);

		// model.addAttribute("goodBye", String.format("%d시가 넘었네요 수고하셨습니다", hour));
		if(((22 <= hour) || (hour <= 6)) && (user.getIsInnerNetwork().equals("Y"))) {
			model.addAttribute("goodBye", String.format("※ 늦은시간까지 수고하셨습니다."));
			model.addAttribute("overTime", "Y");
		}
		else {
			model.addAttribute("goodBye", String.format("※ 오늘 하루도 수고하셨습니다 ^^"));
			model.addAttribute("overTime", "N");
		}

		model.addAttribute("writerNo", dailyResultFm.getWriterNo());
		model.addAttribute("writeDate", dailyResultFm.getWriteDate());

		logT.debug("END");
		return "daily/DailyResultWUPop";
	}
	
	@RequestMapping("/daily/insertDailyResult.do")
	public String insertDailyResult(@ModelAttribute("dailyResultFm") DailyResultFm dailyResultFm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		if(!dailyService.insertDailyResult(dailyResultFm)) {
			logT.warn("프로젝트 투입시간이 입력되지 못했습니다:");
			model.addAttribute("message", "프로젝트 투입시간 입력중 오류가 발생하였습니다.");
			return "/common/returnPage/message";
		}

		logT.debug("END");
		return "/common/returnPage/windowReloadNClose";
	}
	
	/* TENY_170402 나의 업무를 개인별로 조회하는 기능(주단위로) */
	@RequestMapping("/daily/DailyMigration.do")
	public String DailyMigration(@ModelAttribute("dailyPlanFm") DailyPlanFm dailyPlanFm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		// 검색 조건 : 1. 작성자 user NO, (+ 작성자 user name)  2. 작성기준일(작성되어야 하는 일자 yyyymmdd) (+ 이동일)
		// 작성자가 없는 경우 접속자의 user no를 기본값으로 한다.
		MemberVO user = SessionUtil.getMember(req);
		if(dailyPlanFm.getWriterNo() == 0) {
			dailyPlanFm.setWriterNo(user.getNo());
			dailyPlanFm.setWriterName(user.getUserNm());
		}
		// 작성기준일이 없는 경우 오늘을 검색조건의 작성기준일로 한다.
		if((dailyPlanFm.getAtDate() == null) || (dailyPlanFm.getAtDate().length() == 0) ) { // 검색조건(작성기준일)이 없는 경우
			dailyPlanFm.setAtDate(CalendarUtil.getToday());
			dailyPlanFm.setDateMove(0);
		}
		// 검색조건에 이종일이 있는 경우 검색조건(작성기준일)을 수정한다.
		if(dailyPlanFm.getDateMove() != 0) {
			dailyPlanFm.setAtDate(CalendarUtil.getDate(dailyPlanFm.getAtDate(), dailyPlanFm.getDateMove()));
		}
		
		// 검색조건(작성기준일)이 포함된 주의 월요일부터 일요일까지의 업무계획 및 실적을 조회한다.
		List <DailyPlanVO> dailyPlanVOList = dailyService.selectDailyWeekList(dailyPlanFm.getWriterNo(), dailyPlanFm.getAtDate());
		if(dailyPlanVOList.size() != 7) {
			logT.debug("selectDailyWeekList fail");
			model.addAttribute("message", "일일업무보고가 조회에 실패하였습니다. \n관리자에게 문의바랍니다 ");
			return "common/returnPage/message";
		}
		model.addAttribute("dailyPlanVOList", dailyPlanVOList);
//		model.addAttribute("dailyPlanVO", dailyPlanVO);  // atDate(찾고자하는 일자), writerNo, writerName을 보낸다.
		
		/* TENY_170404 자신의 부서원들의 리스트를 검색한다 */
		/* TENY_170417 겸직인경우 겸직의 부서원들의 리스트를 추가로 검색한다 */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("topOrgId", user.getOrgnztId());
		map.put("orgnztIdSec", user.getOrgnztIdSec());
		List<UserVO> memberList= memberDAO.selectUserList(map);

		model.addAttribute("memberList", memberList);

		model.addAttribute("searchWriterNo", dailyPlanFm.getWriterNo());
		model.addAttribute("searchWriterName", dailyPlanFm.getWriterName());
		model.addAttribute("searchAtDate", dailyPlanFm.getAtDate());

		logT.debug("END");
		return "daily/DailyMigration";
	}
	
	// TENY_170407 작성된 일일업무보고를 DB에 저장하는 기능
	@RequestMapping("/daily/migrateDailyPlan.do")
	public String migrateDailyPlan(@ModelAttribute("dailyPlanFm") DailyPlanFm fm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		if(!dailyService.migrateDailyPlan(fm.getWriterNo(), fm.getFromDate(), fm.getToDate())) {
			logT.debug("migrateDailyPlan SUCCEED");
		}
		
		logT.debug("END");
		return "redirect:/daily/DailyMigration.do";
	}
	
	// TENY_170613 나의업무 등록 현황 조회 기능
	@RequestMapping("/daily/statDailyReport.do")
	public String statDailyReport(@ModelAttribute("dailyPlanFm") DailyPlanFm fm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		logT.debug("END");
		return "/daily/DailyStat";
	}
	
	
}
