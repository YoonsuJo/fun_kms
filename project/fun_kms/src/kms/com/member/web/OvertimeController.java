package kms.com.member.web;

import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.OvertimeService;
import kms.com.member.service.WorkState;
import kms.com.member.service.WorkStateService;
import kms.com.member.service.WorkStateVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class OvertimeController {
	
	@Resource(name="KmsWorkStateService")
	WorkStateService workStateService;
	
	@Resource(name="KmsMemberService")
	MemberService memberService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@RequestMapping("/member/selectOvertimeList.do")
	public String selectOvertimeList(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userMixList", CommonUtil.makeValidIdList(wsVO.getSearchUserNm()));
		List<Integer> userNoList = memberService.selectUserNoList(param);		
		if (wsVO.getUserNo() == null || wsVO.getUserNo() == 0) {
			wsVO.setUserNo(userNoList.get(0));
		}
		String searchMonth = CalendarUtil.getToday().substring(4,6);
		//wsVO.setSearchMonth(searchMonth);
		
		wsVO.setSearchOrgIdList(CommonUtil.makeValidIdList(wsVO.getSearchOrgId()));
		List<EgovMap> list = workStateService.selectOvertimeList(wsVO);
		
		List<WorkStateVO> detailList = workStateService.selectOvertimeDetailList(wsVO);
		model.addAttribute("detailList", detailList);
		
		if (list.size() == 1) {
			model.addAttribute("result", list.get(0));			
			return "human_resource/hr_overtimeV";
		}
		else {
			EgovMap sum = workStateService.selectOvertimeListSum(wsVO);
			
			model.addAttribute("resultList", list);
			model.addAttribute("sum", sum);			
			return "human_resource/hr_overtimeL";
		}
	}
	
	@RequestMapping("/member/selectOvertimeView.do")
	public String selectOvertimeView(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
	    
		MemberVO user = SessionUtil.getMember(req);
	    
		if (wsVO.getUserNo() == null || wsVO.getUserNo() == 0) {
			wsVO.setUserNo(user.getNo());
		}
		wsVO.setSearchOrgIdList(CommonUtil.makeValidIdList(wsVO.getSearchOrgId()));
		
		EgovMap result = workStateService.selectOvertime(wsVO);
		List<WorkStateVO> detailList = workStateService.selectOvertimeDetailList(wsVO);
		
		model.addAttribute("result", result);
		model.addAttribute("detailList", detailList);
		
		return "human_resource/hr_overtimeV";
	}
	
	@RequestMapping("/member/selectOvertimeDetail.do")
	public String selectOvertimeDetail(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		List<WorkStateVO> list = workStateService.selectOvertimeDetailList(wsVO);
		
		model.addAttribute("resultList", list);
		
		return "human_resource/hr_overtimeD";
	}
	
	@RequestMapping("/member/insertOvertimeView.do")
	public String insertOvertimeView(@ModelAttribute("searchVO") WorkStateVO wsVO, ModelMap model) throws Exception {
		
		/*
		MemberVO tmp = new MemberVO();
		tmp.setWorkStList(new String[]{"W"});
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS004");
		
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("codeResult", codeResult.get(0));
		model.addAttribute("overtimeDt", CalendarUtil.getToday());
		model.addAttribute("memList", memberService.selectMemberList(tmp));
		*/
		
		return "redirect:/member/insertAbsenceView.do?wsTyp=N";
	}
	
	@RequestMapping("/member/insertOvertime.do")
	public String insertOvertime(WorkState workState,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		workState.setWriterNo(user.getNo());
		
		workStateService.insertWorkState(workState);
		
		return "redirect:/member/selectOvertimeView.do";
	}
	
	@RequestMapping("/member/updateOvertimeView.do")
	public String updateOvertimeView(@ModelAttribute("searchVO") WorkStateVO wsVO, ModelMap model) throws Exception {
		
		MemberVO tmp = new MemberVO();
		tmp.setWorkStList(new String[]{"W"});
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS004");
		
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		WorkStateVO result = workStateService.selectWorkState(wsVO);
		
		model.addAttribute("codeResult", codeResult.get(0));
		model.addAttribute("result", result);
		model.addAttribute("memList", memberService.selectMemberList(tmp));
		
		return "human_resource/hr_overtimeM";
	}
	
	@RequestMapping("/member/updateOvertime.do")
	public String updateOvertime(WorkState workState,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		workState.setWriterNo(user.getNo());
			
		Calendar cal = Calendar.getInstance();
		int iHour = cal.get(Calendar.HOUR_OF_DAY);
		int iWsBgnTm = Integer.parseInt(workState.getWsBgnTm());
		int iToday = Integer.parseInt(CalendarUtil.getToday());
		int iWsBgnDe = Integer.parseInt(workState.getWsBgnDe());
				
		// 2012-08-28 jsp 에서 날짜 시간 변경 막아둔 상태
		// 당일 등록은 22시 23시 24시만 해당시간 이후에만 등록
		if(iToday == iWsBgnDe){
			if(iHour > 21 && iHour >= iWsBgnTm){					
				workStateService.updateWorkState(workState);
			} else {							
				workState.setWsBgnDe("");
				workState.setWsBgnTm("");
				workStateService.updateWorkState(workState);
			}				
		} // 전일 등록은 6시 이전까지만, 단 6시는 5시에도 등록가능
		else if(iToday == iWsBgnDe + 1){
			if(iWsBgnTm == 6 && iHour == 5){ // 6시 야근등록은 5시~5:59:59까지 등록
				workStateService.updateWorkState(workState);
			} else if(iHour < 6 && iHour >= iWsBgnTm){					
				workStateService.updateWorkState(workState);
			} else {
				workState.setWsBgnDe("");
				workState.setWsBgnTm("");
				workStateService.updateWorkState(workState);										
			}
		} // 그 외 아예 다른 날 
		else { //날짜 시간 수정은 안되고 사유만 수정
			workState.setWsBgnDe("");
			workState.setWsBgnTm("");
			workStateService.updateWorkState(workState);
		}
				
		return "redirect:/member/selectOvertimeList.do?searchCondition=0&searchUserNm=" + URLEncoder.encode(workState.getUserNm(), "UTF-8") + "(" + workState.getUserId() + ")";
		//return "redirect:/member/selectOvertimeView.do";
	}
	
	@RequestMapping("/member/deleteOvertime.do")
	public String deleteOvertime(@ModelAttribute("searchVO") WorkStateVO wsVO, WorkState workState,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		workStateService.deleteWorkState(wsVO);
		
		return "forward:/member/selectOvertimeView.do";
	}
	
	
	

	@RequestMapping("/member/selectOvertimeViewInc.do")
	public String selectOvertimeViewInc(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		String userNo = (String)commandMap.get("param_userNo");
		String year = (String)commandMap.get("param_year");

		wsVO.setUserNo(Integer.parseInt(userNo));
		wsVO.setSearchYear(year);
		
		EgovMap result = workStateService.selectOvertime(wsVO);
		
		model.addAttribute("result", result);
		
		return "human_resource/include/hr_overtimeI";
	}
	@RequestMapping("/member/selectOvertimeDetailPop.do")
	public String selectOvertimeDetailPop(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		String userNo = (String)commandMap.get("param_userNo");
		String year = (String)commandMap.get("param_year");
		String month = (String)commandMap.get("param_month");

		wsVO.setUserNo(Integer.parseInt(userNo));
		wsVO.setSearchYear(year);
		wsVO.setSearchMonth(month);
		
		List<WorkStateVO> list = workStateService.selectOvertimeDetailList(wsVO);
		
		model.addAttribute("resultList", list);
		
		return "human_resource/hr_overtimeD";
	}
}
