package kms.com.main.web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kms.com.admin.score.service.ScoreDetailVO;
import kms.com.admin.score.service.ScoreService;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.common.service.BannerService;
import kms.com.common.service.BannerVO;
import kms.com.common.service.impl.CommonDAO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.XmlParseUtil;
import kms.com.community.service.BBSAttributeManageService;
import kms.com.community.service.BBSManageService;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BoardVO;
import kms.com.community.service.MvucVO;
import kms.com.community.service.ScheduleService;
import kms.com.community.service.ScheduleVO;
import kms.com.cooperation.service.BusiCntctService;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.cooperation.service.DayReportDetail;
import kms.com.cooperation.service.DayReportService;
import kms.com.cooperation.service.TaskVO;
import kms.com.management.service.ContractService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MainController {

	@Resource(name = "KmsBBSManageService")
	private BBSManageService bbsMngService;

	@Resource(name = "KmsBusinessContactService")
	protected BusiCntctService bcService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	@Resource(name = "ScoreService")
	private ScoreService scoreService;

	@Resource(name = "KmsBannerService")
	private BannerService bannerService;
	
	@Resource(name = "approvalService")
	private KmsApprovalService approvalService;

	@Resource(name="KmsContractService")
	private ContractService contractService;

	@Resource(name="KmsDayReportService")
	private DayReportService dayReportService;

    @Resource(name = "KmsScheduleService")
    private ScheduleService scheduleService;
    
    @Resource(name = "KmsBBSAttributeManageService")
    private BBSAttributeManageService bbsAttrbService;
    
    @Resource(name = "KmsCommonDAO")
	private CommonDAO commonDAO;
	
	@RequestMapping("/main.do")
	public String main(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		BoardVO boardVO = new BoardVO();
		
		boardVO.setRecordCountPerPage(4);
		boardVO.setFirstIndex(0);
		boardVO.setFrstRegisterId(user.getStringNo());
		
		boardVO.setBbsTyCode("COMM");
		Map<String, Object> commUnread = bbsMngService.selectUnreadBoardArticles(boardVO, "");
		boardVO.setBbsId("BBSMSTR_000000000001");
		Map<String, Object> free = bbsMngService.selectBoardArticles(boardVO, "");
		boardVO.setBbsId("BBSMSTR_000000000029");
		Map<String, Object> discuss = bbsMngService.selectBoardArticles(boardVO, "");
		boardVO.setBbsId("BBSMSTR_000000000030");
		Map<String, Object> schedule = bbsMngService.selectBoardArticles(boardVO, "");
		
		boardVO.setBbsTyCode("SPRT");
		boardVO.setBbsAttrbCode("COMMON");
		boardVO.setIsAdmin(user.getIsAdmin()); //2013-05-29 운영자가 아닌 경우 알림공지는 보이지 않도록 수정
		Map<String, Object> sprtUnread = bbsMngService.selectUnreadBoardArticles(boardVO, "");
		boardVO.setBbsId("BBSMSTR_000000000031");
		Map<String, Object> notice = bbsMngService.selectBoardArticles(boardVO, "");
		boardVO.setBbsId("BBSMSTR_000000000032");
		Map<String, Object> kmsNotice = bbsMngService.selectBoardArticles(boardVO, "");
		boardVO.setBbsId("BBSMSTR_000000000033");
		Map<String, Object> noticeNotice = bbsMngService.selectBoardArticles(boardVO, "");
		
		
		MemberVO memberVO = new MemberVO();
		
		memberVO.setNo(user.getUserNo());		
		memberVO.setWorkStList(new String[]{"W", "L"});
		
		memberVO.setRecordCountPerPage(3);
		memberVO.setFirstIndex(0);
		memberVO.setOrderBy("new");
		List<MemberVO> newMember = memberService.selectMemberListMain(memberVO);
		
		memberVO.setRecordCountPerPage(5);
		memberVO.setFirstIndex(0);
		memberVO.setOrderBy("birth");
		List<MemberVO> birth = memberService.selectMemberListMain(memberVO);
		memberVO.setOrderBy("enter");
		List<MemberVO> enter = memberService.selectMemberListMain(memberVO);
		
		ApprovalVO vo2 = new ApprovalVO();
		vo2.setFirstIndex(0);
		vo2.setRecordCountPerPage(4);
		List<EgovMap> jobgList = approvalService.selectJobgList(vo2);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("firstIndex", 0);
		param.put("recordCountPerPage", 4);
		List cntgList = contractService.selectContractList(param);
		
		BannerVO bannerVO = new BannerVO();
		
		List<BannerVO> banner = bannerService.selectBannerList(bannerVO);
		
//		commandMap.put("userNo", user.getUserNo());
//		
//		if (commandMap.get("searchStartDate") == null || commandMap.get("searchStartDate").equals(""))
//			commandMap.put("searchStartDate", CalendarUtil.getToday().substring(0,6) + "01");
//		if (commandMap.get("searchEndDate") == null || commandMap.get("searchEndDate").equals(""))
//			commandMap.put("searchEndDate", CalendarUtil.getToday().substring(0,8));
//		
//		List totalList = scoreService.selectRankList(commandMap);
		
		
		
		//아침인사
		EgovMap goodmorning = memberService.selectGoodMorningState(memberVO);
		model.addAttribute("goodmorning", goodmorning);
		
		model.addAttribute("commUnread", commUnread.get("resultList"));
		model.addAttribute("free", free.get("resultList"));
		model.addAttribute("discuss", discuss.get("resultList"));
		model.addAttribute("schedule", schedule.get("resultList"));
		
		model.addAttribute("sprtUnread", sprtUnread.get("resultList"));
		model.addAttribute("notice", notice.get("resultList"));
		model.addAttribute("kmsNotice", kmsNotice.get("resultList"));
		model.addAttribute("noticeNotice", noticeNotice.get("resultList"));
		
		model.addAttribute("newMember", newMember);
		model.addAttribute("birth", birth);
		model.addAttribute("enter", enter);
		
		model.addAttribute("jobgList", jobgList);
		model.addAttribute("cntgList", cntgList);
		
		model.addAttribute("banner", banner);
		
		model.addAttribute("showRight", true);
		
		model.addAttribute("noInput", req.getParameter("noInput"));
		
//		model.addAttribute("totalList", totalList);
		
		/* 아침인사 selectBoard */
		//BoardVO boardVO = new BoardVO();
		//MemberVO user = SessionUtil.getMember(req);
		//nttId, bbsId, readBool
		
		String goodMorningId = (String)goodmorning.get("id");
		String goodmorningReadBool = (String)goodmorning.get("readBool");
		
		if ( goodMorningId.equals("") && user.getIsInnerNetworkPrint().equals("본사") ) {
			BoardMasterVO masterVo = new BoardMasterVO();
			BoardMasterVO vo = new BoardMasterVO();
			
		    vo.setBbsId("BBSMSTR_000000000082");

		    
		    
		    masterVo = bbsAttrbService.selectBBSMasterInf(vo);
		    model.addAttribute("bdMstr", masterVo);
			
		} else if ( goodmorningReadBool.equals("N") && user.getIsInnerNetworkPrint().equals("본사") ){
			boardVO.setPlusCount(true);
			
			boardVO.setBbsId("BBSMSTR_000000000082");
			boardVO.setLastUpdusrId(user.getStringNo());
			boardVO.setFrstRegisterId(user.getStringNo());
			boardVO.setNttId(Long.parseLong((String)goodmorning.get("id")));
			BoardVO vo = bbsMngService.selectBoardArticle(boardVO);
		
			model.addAttribute("result", vo);
			//이미 jsp 단에서 어떻게인가 user 객체를 사용하고 있음
			//model.addAttribute("user", user);
		
			model.addAttribute("sessionUniqId", user.getStringNo());
			BoardMasterVO master = new BoardMasterVO();
			master.setBbsId(boardVO.getBbsId());
			BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);
			model.addAttribute("brdMstrVO", masterVo);
			
			
			MemberVO writerVO = new MemberVO();
			writerVO.setNo(Integer.parseInt(vo.getFrstRegisterId()));
			
	    	//writerVO 세팅
			writerVO = memberService.selectMemberBasic(writerVO);
	
	    	model.addAttribute("writerVO", writerVO);
	
	    	//기존 근무현황 정보
	    	EgovMap state = memberService.selectMemberState(writerVO); //selectMemberState 전체 코드에서 여기서만 호출
	    	model.addAttribute("state", state);
			
	    	MemberVO memberVO2 = new MemberVO();
	    	memberVO2.setNo(user.getNo()); //체크리스트는 현제 로그인 사용자 정보를 가져옴
			List<EgovMap> list = commonDAO.getCheckList(memberVO2);
			EgovMap checkList = new EgovMap();
			
			for (int i=0; i<list.size(); i++) {
				EgovMap t = list.get(i);
				checkList.put(t.get("id"), t.get("cnt"));
			}
			model.addAttribute("checkList", checkList);			
		}
		
		return "main/main";
	}
	
	@RequestMapping("/headSearch.do")
	public String headSearch(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		BannerVO bannerVO = new BannerVO();
		
		List<BannerVO> banner = bannerService.selectBannerList(bannerVO);
		
		model.addAttribute("banner", banner);
		model.addAttribute("headSearchVO", commandMap);
		
		if ("0".equals(commandMap.get("searchCondition"))) {
		
			//System.out.println("commandMap=="+commandMap.toString());
			
			List<MemberVO> resultList = memberService.selectMemberListHeadSearch(commandMap);
			
			if (resultList.size() == 1) {
		    	return "redirect:/member/selectMemberMain.do?no=" + resultList.get(0).getUserNo();
			}
			else {
				model.addAttribute("resultList", resultList);
				return "main/main_headSearchUser";
			}
		} else if ("1".equals(commandMap.get("searchCondition"))) {
			
			String bbsPageIndex = (commandMap.get("bbsPageIndex") == null || commandMap.get("bbsPageIndex").equals("")) ? "1" : (String)commandMap.get("bbsPageIndex");
			String bcPageIndex = (commandMap.get("bcPageIndex") == null || commandMap.get("bcPageIndex").equals("")) ? "1" : (String)commandMap.get("bcPageIndex");
			
			BoardVO boardVO = new BoardVO();

			boardVO.setPageIndex(Integer.parseInt(bbsPageIndex));
			boardVO.setPageUnit(propertyService.getInt("pageUnit"));
			boardVO.setPageSize(propertyService.getInt("pageSize"));
			boardVO.setSearchKeyword((String)commandMap.get("searchKeyword"));
			
			PaginationInfo bbsPaginationInfo = new PaginationInfo();
			
			bbsPaginationInfo.setCurrentPageNo(boardVO.getPageIndex());
			bbsPaginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
			bbsPaginationInfo.setPageSize(boardVO.getPageSize());
		
			boardVO.setFirstIndex(bbsPaginationInfo.getFirstRecordIndex());
			boardVO.setLastIndex(bbsPaginationInfo.getLastRecordIndex());
			boardVO.setRecordCountPerPage(bbsPaginationInfo.getRecordCountPerPage());
		
			Map<String, Object> bbsMap = bbsMngService.selectBoardListHeadSearch(boardVO);
			int bbsTotCnt = Integer.parseInt((String)bbsMap.get("resultCnt"));

			bbsPaginationInfo.setTotalRecordCount(bbsTotCnt);

			model.addAttribute("bbsSearchVO", boardVO);
			model.addAttribute("bbsList", bbsMap.get("resultList"));
			model.addAttribute("bbsPaginationInfo", bbsPaginationInfo);
			

			MemberVO user = SessionUtil.getMember(req);
			
			BusinessContactVO bcVO = new BusinessContactVO();
			
			bcVO.setUserNo(user.getNo());
			bcVO.setPageIndex(Integer.parseInt(bcPageIndex));
			bcVO.setPageUnit(propertyService.getInt("pageUnit"));
			bcVO.setPageSize(propertyService.getInt("pageSize"));
			bcVO.setSearchKeyword((String)commandMap.get("searchKeyword"));
		
			PaginationInfo bcPaginationInfo = new PaginationInfo();
			
			bcPaginationInfo.setCurrentPageNo(bcVO.getPageIndex());
			bcPaginationInfo.setRecordCountPerPage(bcVO.getPageUnit());
			bcPaginationInfo.setPageSize(bcVO.getPageSize());
		
			bcVO.setFirstIndex(bcPaginationInfo.getFirstRecordIndex());
			bcVO.setLastIndex(bcPaginationInfo.getLastRecordIndex());
			bcVO.setRecordCountPerPage(bcPaginationInfo.getRecordCountPerPage());
			
			List<BusinessContactVO> bcList = bcService.selectBusinessContactListHeadSearch(bcVO);
			int bcTotCnt = bcService.selectBusinessContactListTotCntHeadSearch(bcVO);
			
			bcPaginationInfo.setTotalRecordCount(bcTotCnt);
			
			model.addAttribute("bcSearchVO", bcVO);
			model.addAttribute("bcList", bcList);
			model.addAttribute("bcPaginationInfo", bcPaginationInfo);
			
			
			return "main/main_headSearchInfo";
		} else 
			return "redirect:/main.do";
	}
	
	@RequestMapping("/statusBoardOld.do")
	public String statusBoard(HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		
		/** 오늘의 할일 **/
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("searchUserNo", user.getNo());
		param.put("limitSize", 5);
		
		List<TaskVO> taskList = dayReportService.selectTaskList(param);
		
		model.addAttribute("taskList", taskList);
		model.addAttribute("today", CalendarUtil.getToday());

		/** 부재현황 **/
		Map<String,Object> param2 = new HashMap<String,Object>();
		param2.put("userNo", user.getNo());
		param2.put("orgnztId", user.getOrgnztId());
		param2.put("head", user.getPosition().equals("H") || user.getPosition().equals("S") ? "Y" : "N");
		
		List<EgovMap> stateList = memberService.selectMemberStateStatusBoard(param2);

		model.addAttribute("stateList", stateList);

		/** 주요일정 **/
		ScheduleVO scVO = new ScheduleVO();
		scVO.setOrgnztId(user.getOrgnztId());
		scVO.setUserNo(user.getNo());
		
		List<ScheduleVO> scheduleList = scheduleService.selectScheduleListStatusBoard(scVO);

		model.addAttribute("scheduleList", scheduleList);
		

		BannerVO bannerVO = new BannerVO();
		List<BannerVO> banner = bannerService.selectBannerList(bannerVO);

		model.addAttribute("banner", banner);
		
		model.addAttribute("showRight", true);
		
		return "main/main_statusBoard_old";
	}
		
	@RequestMapping("/statusBoard.do")
	public String statusBoard2(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		
		/** 부재현황 **/
		Map<String,Object> param2 = new HashMap<String,Object>();
		param2.put("userNo", user.getNo());
		param2.put("orgnztId", user.getOrgnztId());
		param2.put("head", user.getPosition().equals("H") || user.getPosition().equals("S") ? "Y" : "N");
		
		List<EgovMap> stateList = memberService.selectMemberStateStatusBoard(param2);

		model.addAttribute("stateList", stateList);
		
		/** 나의업무현황 **/
		commandMap.remove("taskId");
		commandMap.remove("taskState");
		
		String searchDate = CalendarUtil.getToday();
		String searchUserNm = searchUserNm = user.getUserNm() + "(" + user.getUserId() + ")";
		String dateMove = (String)commandMap.get("dateMove");
		
		if (dateMove != null && dateMove.equals("") == false) {
			searchDate = CalendarUtil.getDate(searchDate, Integer.parseInt(dateMove));
		}
		
		commandMap.put("today", CalendarUtil.getToday());
		commandMap.put("searchDate", searchDate);
		commandMap.put("searchUserNm", searchUserNm);
		
		List<DayReportDetail> resultList = dayReportService.selectDayReportDetail(commandMap);
		List<Map<String, Object>> dateList = CalendarUtil.getDateList((String)commandMap.get("sDate"));
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("dateList", dateList);
		model.addAttribute("searchVO", commandMap);
		
		BannerVO bannerVO = new BannerVO();
		List<BannerVO> banner = bannerService.selectBannerList(bannerVO);
		model.addAttribute("banner", banner);

		return "main/main_statusBoard";
	}
	
	@RequestMapping("/statusBoardBusiCntct.do")
	public String statusBoardBusiCntct(HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);

		BusinessContactVO bcVO = new BusinessContactVO();
		
		bcVO.setUserNo(user.getNo());
		bcVO.setPageIndex(1);
		bcVO.setPageUnit(5);
		bcVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo bcPaginationInfo = new PaginationInfo();
		
		bcPaginationInfo.setCurrentPageNo(bcVO.getPageIndex());
		bcPaginationInfo.setRecordCountPerPage(bcVO.getPageUnit());
		bcPaginationInfo.setPageSize(bcVO.getPageSize());
	
		bcVO.setFirstIndex(bcPaginationInfo.getFirstRecordIndex());
		bcVO.setLastIndex(bcPaginationInfo.getLastRecordIndex());
		bcVO.setRecordCountPerPage(bcPaginationInfo.getRecordCountPerPage());
		
		List<BusinessContactVO> bcList = bcService.selectBusinessContactList(bcVO);
		
		model.addAttribute("bcList", bcList);
		
		return "main/main_statusBoard_BusiCntct";
	}
	
	@RequestMapping("/statusBoardEapp.do")
	public String statusBoardEapp(HttpServletRequest req, ModelMap model) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		MemberVO user = SessionUtil.getMember(req);
		
		ApprovalVO appVO = new ApprovalVO();
		appVO.setReaderNo(user.getNo());
		appVO.setPageUnit(5);
		appVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(appVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(appVO.getPageUnit());
		paginationInfo.setPageSize(appVO.getPageSize());
		
		appVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		appVO.setLastIndex(paginationInfo.getLastRecordIndex());
		appVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		appVO.setMode("2");
		Map<String, Object> todo = approvalService.selectApprovalList(appVO);
		appVO.setMode("5");
		Map<String, Object> reject = approvalService.selectApprovalList(appVO);
		appVO.setMode("3");
		Map<String, Object> write = approvalService.selectApprovalList(appVO);
		appVO.setMode("12");
		Map<String, Object> refer = approvalService.selectApprovalList(appVO);
		appVO.setMode("13");
		Map<String, Object> handle = approvalService.selectApprovalList(appVO);
		
		resultMap.put("todo", todo.get("resultList"));
		resultMap.put("reject", reject.get("resultList"));
		resultMap.put("write", write.get("resultList"));
		resultMap.put("refer", refer.get("resultList"));
		resultMap.put("handle", handle.get("resultList"));
		
		model.addAttribute("resultMap", resultMap);
		
		return "main/main_statusBoard_Eapp";
	}
	
	@RequestMapping("/ajax/statusBoardTaskLayer.do")
	public String statusBoardTaskLayer(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		TaskVO task = dayReportService.selectTaskInfo(commandMap);
		
		model.addAttribute("task", task);
		
		return "main/main_statusBoard_taskLayer";
	}
	
	@RequestMapping("/ajax/statusBoardScheduleLayer.do")
	public String statusBoardScheduleLayer(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		TaskVO task = dayReportService.selectTaskInfo(commandMap);
		
		model.addAttribute("task", task);
		
		return "main/main_statusBoard_taskLayer";
	}
	
	@RequestMapping("/main/rankList.do")
	public String rankList(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		commandMap.put("userNo", user.getUserNo());
		
		if (commandMap.get("searchStartDate") == null || commandMap.get("searchStartDate").equals(""))
			commandMap.put("searchStartDate", CalendarUtil.getToday().substring(0,6) + "01");
		if (commandMap.get("searchEndDate") == null || commandMap.get("searchEndDate").equals(""))
			commandMap.put("searchEndDate", CalendarUtil.getToday().substring(0,8));
		
		List totalList = scoreService.selectRankList(commandMap);
		
		commandMap.put("order", "community");
		List communityList = scoreService.selectRankList(commandMap);
		
		commandMap.put("order", "report");
		List reportList = scoreService.selectRankList(commandMap);
		
		commandMap.put("order", "game");
		List gameList = scoreService.selectRankList(commandMap);
		
		model.addAttribute("totalList", totalList);
		model.addAttribute("communityList", communityList);
		model.addAttribute("reportList", reportList);
		model.addAttribute("gameList", gameList);
		
		model.addAttribute("searchStartDate", commandMap.get("searchStartDate"));
		model.addAttribute("searchEndDate", commandMap.get("searchEndDate"));
		
		return "main/main_statusBoard_rank";
	}

	@RequestMapping(value="/app.do")
    public String mvucView(Map<String, Object> commandMap,ModelMap model)throws Exception {

    	/*2013-04-01 최신정보 링크도 변경되면 수정 필요
    	String xmlParse = XmlParseUtil.getXml("http://222.112.235.250:6010/mvuc/app/pc/lastest.xml");    	    	
    	model.addAttribute("pcDataSize", XmlParseUtil.parse(xmlParse,"dataSize"));
    	model.addAttribute("pcFilename", XmlParseUtil.parse(xmlParse,"filename"));
    	model.addAttribute("pcUploadTime", XmlParseUtil.parse(xmlParse,"uploadTime"));
    	model.addAttribute("pcVersion", XmlParseUtil.parse(xmlParse,"version"));

    	xmlParse = XmlParseUtil.getXml("http://222.112.235.250:6010/mvuc/app/android/lastest.xml");
    	model.addAttribute("androidDataSize", XmlParseUtil.parse(xmlParse,"dataSize"));
    	model.addAttribute("androidFilename", XmlParseUtil.parse(xmlParse,"filename"));
    	model.addAttribute("androidUploadTime", XmlParseUtil.parse(xmlParse,"uploadTime"));
    	model.addAttribute("androidVersion", XmlParseUtil.parse(xmlParse,"version"));

    	xmlParse = XmlParseUtil.getXml("http://222.112.235.250:6010/mvuc/app/ios/lastest.xml");
    	model.addAttribute("iosDataSize", XmlParseUtil.parse(xmlParse,"dataSize"));
    	model.addAttribute("iosFilename", XmlParseUtil.parse(xmlParse,"filename"));
    	model.addAttribute("iosUploadTime", XmlParseUtil.parse(xmlParse,"uploadTime"));
    	model.addAttribute("iosVersion", XmlParseUtil.parse(xmlParse,"version"));
    	*/
    	//COMTCCMMNDETAILCODE KMS020
    	MvucVO mvuc = (MvucVO)memberService.selectMvucView();
    	model.addAttribute("mvuc", mvuc);
        return "main/mvuc";
    }	
	
  
    @RequestMapping(value="/main/mvucUpdate.do")
    public String mvucUpdate(Map<String, Object> commandMap,ModelMap model)throws Exception {
    	MvucVO mvuc = new MvucVO();
    	
    	mvuc.setCode_dc((String) commandMap.get("download_pc"));
    	mvuc.setUpdate_code("Download_PC");
    	memberService.mvucUpdate(mvuc);

    	mvuc.setCode_dc((String) commandMap.get("download_androi"));
    	mvuc.setUpdate_code("Download_Androi");
    	memberService.mvucUpdate(mvuc);

    	mvuc.setCode_dc((String) commandMap.get("download_ios"));
    	mvuc.setUpdate_code("Download_IOS");
    	memberService.mvucUpdate(mvuc);

    	
    	mvuc = (MvucVO)memberService.selectMvucView();
    	model.addAttribute("save", "ok");
    	model.addAttribute("mvuc", mvuc);
    	return "main/mvuc";
    }
    
	
}
