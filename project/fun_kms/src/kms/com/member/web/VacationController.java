package kms.com.member.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.app.service.ApprovalVacVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.WorkStateVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class VacationController {
	
	@Resource(name="approvalService")
	KmsApprovalService approvalService;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;

	@RequestMapping("/member/selectVacationSummaryList.do")
	public String selectVacationSummaryList(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		wsVO.setSearchOrgIdList(CommonUtil.makeValidIdList(wsVO.getSearchOrgId()));		
		List<EgovMap> resultList = approvalService.selectVacationSummaryList(wsVO);
		
		if (resultList.size() == 1) {
			EgovMap result = resultList.get(0);			
			Integer workMonth = Integer.parseInt(String.valueOf(result.get("workMonth")));
			String workLength = ((Integer)workMonth/12) + "년 " + (Integer)workMonth%12 + "개월";			
			result.put("workLength", workLength);			
			model.addAttribute("result", result);
			
			return "human_resource/hr_vacationV";
		} else {
			for (int i=0; i<resultList.size(); i++) {
				EgovMap result = resultList.get(i);
				Integer workMonth = Integer.parseInt(String.valueOf(result.get("workMonth")));
				String workLength = ((Integer)workMonth/12) + "년 " + (Integer)workMonth%12 + "개월";				
				result.put("workLength", workLength);
			}			
			model.addAttribute("resultList", resultList);
			
			return "human_resource/hr_vacationL";
		}
	}
	
	@RequestMapping("/member/selectVacationSummaryView.do")
	public String selectVacationSummaryView(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		wsVO.setSearchOrgIdList(CommonUtil.makeValidIdList(wsVO.getSearchOrgId()));
		MemberVO user = null;
		if(wsVO.getUserNo() == null){
			user = SessionUtil.getMember(req);
			wsVO.setUserNo(user.getNo());
		}else{
			if(wsVO.getSearchUserNm() != null && "".equals(wsVO.getSearchUserNm()) == false){
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("searchUserNm", wsVO.getSearchUserNm());
				int userNo = memberService.selectUserNo(param);
				wsVO.setUserNo(userNo);
			}else{
				wsVO.setUserNo(wsVO.getUserNo());
			}
			
		}
		
//		if (wsVO.getSearchUserNm() != null && wsVO.getSearchUserNm().equals("") == false) {
//			wsVO.setUserNo(null);
//		}				
		EgovMap result = null;
		result = approvalService.selectVacationSummary(wsVO);
		Integer workMonth = 0;
		if(result == null){
			String inDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
			wsVO.setSearchDate(inDate);
			result = approvalService.selectVacationSummary(wsVO);
		}
		workMonth = Integer.parseInt(String.valueOf(result.get("workMonth")));
		String workLength = ((Integer)workMonth/12) + "년 " + (Integer)workMonth%12 + "개월";		
		result.put("workLength", workLength);	
		model.addAttribute("result", result);
		
		return "human_resource/hr_vacationV";
	}
	
	@RequestMapping("/member/selectVacationSummaryDetail.do")
	public String selectVacationSummaryDetail(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		List<EgovMap> resultList = approvalService.selectVacationSummaryDetail(wsVO);		
		model.addAttribute("resultList", resultList);		
		return "human_resource/hr_vacationD";
	}
	
	@RequestMapping("/member/selectVacationSummaryViewInc.do")
	public String selectVacationSummaryViewInc(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		String userNo = (String)commandMap.get("param_userNo");
		String year = (String)commandMap.get("param_year");
		
		wsVO.setUserNo(Integer.parseInt(userNo));
		wsVO.setSearchYear(year); // 쿼리에서 사용안함. 초기설계구현 미스
		if(CalendarUtil.getYear() != Integer.parseInt(year) )
			wsVO.setSearchDate(year + "1231");
		else
			wsVO.setSearchDate(CalendarUtil.getToday());
		
		EgovMap result = approvalService.selectVacationSummary(wsVO);		
		int workMonth = Integer.parseInt(String.valueOf(result.get("workMonth")));
		result.put("workMonthPrint", workMonth/12 + "년" + workMonth%12 + "개월");
		
		model.addAttribute("result", result);
		
		return "human_resource/include/hr_vacationI";
	}
	
	@RequestMapping("/member/selectVacationSummaryDetailInc.do")
	public String selectVacationSummaryDetailInc(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		String userNo = (String)commandMap.get("param_userNo");
		String year = (String)commandMap.get("param_year");

		wsVO.setUserNo(Integer.parseInt(userNo));
		wsVO.setSearchYear(year); // 쿼리에서 사용안함. 초기설계구현 미스
		if(CalendarUtil.getYear() != Integer.parseInt(year) )
			wsVO.setSearchDate(year + "1231");
		else
			wsVO.setSearchDate(CalendarUtil.getToday());
		
		List<EgovMap> resultList = approvalService.selectVacationSummaryDetail(wsVO);
		
		model.addAttribute("resultList", resultList);
		
		return "human_resource/hr_vacationD";
	}
	
	@RequestMapping("/member/updateVactyp.do")
	public String updateVactyp(//@ModelAttribute("searchVO") ApprovalVacVO vacVO, 
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model
			,String docId, int vacTyp) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		ApprovalVacVO vacVO = new ApprovalVacVO();
		vacVO.setDocId(docId);
		vacVO.setVacTyp(vacTyp);
		approvalService.updateApprovalVac(vacVO);
		
		return "error/simpleGoBack";
		//model.addAttribute("message","수정되었습니다.");
		//return "redirect:/member/selectVacationSummaryList.do";
    	//return "error/messageRedirect";
	}
}
