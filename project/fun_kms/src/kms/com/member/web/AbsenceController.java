package kms.com.member.web;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.config.PathConfig;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.Msn;
import kms.com.member.service.WorkState;
import kms.com.member.service.WorkStateDetail;
import kms.com.member.service.WorkStateService;
import kms.com.member.service.WorkStateVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AbsenceController {
	
	@Resource(name="KmsMemberService")
	MemberService memberService;

	@Resource(name="KmsWorkStateService")
	WorkStateService workStateService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	Logger log = Logger.getLogger(this.getClass());
	
	
	@RequestMapping("/member/selectAbsenceState.do")
	public String selectAbsenceState(@ModelAttribute("searchVO") WorkStateVO wsVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		wsVO.setSearchOrgIdList(CommonUtil.makeValidIdList(wsVO.getSearchOrgId()));
		
		String move = (String)commandMap.get("move");
		
		if (move != null && move.equals("") == false) {
			wsVO.setSearchDate(CalendarUtil.getDate(wsVO.getSearchDate(), Integer.parseInt(move)));
		}
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("KMS039");
    	List<CmmnDetailCode> excludeLeaderCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
    	CmmnDetailCode excludeLeader = new CmmnDetailCode();
    	CmmnDetailCode exceptionUsers = new CmmnDetailCode();
    	   
    	if(excludeLeaderCode.size() > 1){
    		excludeLeader = (CmmnDetailCode)excludeLeaderCode.get(0);
    		exceptionUsers  = (CmmnDetailCode)excludeLeaderCode.get(1);
	    }
    	
    	wsVO.setExcludeLeader(excludeLeader.getCodeDc());
    	wsVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
    	
		Map<String, Object> result = workStateService.selectAbsenceState(wsVO);
		
		model.addAttribute("result", result);
		
		return "human_resource/hr_absenceL";
	}

	@RequestMapping("/member/selectAbsenceStateDatail.do")
	public String selectAbsenceStateDatail(Map<String,Object> commandMap, ModelMap model) throws Exception {
		//WorkStateController ("/member/dailyWorkStateDatail.do") 함수 복사, 변경해서 사용
		//부재현황 조회 (현재시각기준 부재자 현황) 상세내역
		WorkStateDetail wsDetail = new WorkStateDetail();
		
		wsDetail.setSearchDate((String)commandMap.get("param_searchDate"));
		wsDetail.setSearchOrgId((String)commandMap.get("param_searchOrgId"));
		wsDetail.setSearchAttendCd((String)commandMap.get("param_attendCd"));
		wsDetail.setSearchOrgIdList(CommonUtil.makeValidIdList(wsDetail.getSearchOrgId()));
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("KMS039");
    	List<CmmnDetailCode> excludeLeaderCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
    	CmmnDetailCode excludeLeader = new CmmnDetailCode();
    	CmmnDetailCode exceptionUsers = new CmmnDetailCode();
    	   
    	if(excludeLeaderCode.size() > 1){
    		excludeLeader = (CmmnDetailCode)excludeLeaderCode.get(0);
    		exceptionUsers  = (CmmnDetailCode)excludeLeaderCode.get(1);
	    }
    	
    	wsDetail.setExcludeLeader(excludeLeader.getCodeDc());	
    	wsDetail.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
    	
		List<WorkStateDetail> resultList = workStateService.selectAbsenceStateDatail(wsDetail);		
		model.addAttribute("resultList", resultList);
		
		return "human_resource/hr_dailyWorkStateD";
	}
	
	@RequestMapping("/member/insertAbsenceView.do")
	public String insertAbsenceView(@ModelAttribute("searchVO") WorkStateVO wsVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO memberVO = new MemberVO();
		memberVO.setWorkStList(new String[]{"W"});
		memberVO.setOrderBy("name");		
		model.addAttribute("memList", memberService.selectMemberList(memberVO));		
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS004");		
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("codeResult", codeResult.get(0));
		model.addAttribute("overtimeDt", CalendarUtil.getToday());		
		
		return "human_resource/hr_absenceW";
	}
	
	@RequestMapping("/member/insertAbsence.do")
	public String insertAbsence(WorkState workState, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);				
		workState.setWriterNo(user.getNo());	
		workState.setUserIp(user.getUserIp());
		workState.setIsInnerNetwork(user.getIsInnerNetwork());
		
		Calendar cal = Calendar.getInstance();
		int iHour = cal.get(Calendar.HOUR_OF_DAY);
		int iWsBgnTm = Integer.parseInt(workState.getWsBgnTm());
		int iToday = Integer.parseInt(CalendarUtil.getToday());
		int iYesterday = Integer.parseInt(CalendarUtil.getYesterday());
		int iWsBgnDe = Integer.parseInt(workState.getWsBgnDe());				
		String sMsg = "당일 야근 해당시간에만 등록 가능합니다";
		String sMsgExist = "중복외근등록 불가\\n해당 일자 시간에 이미 등록된 데이터가 있습니다";		
		model.addAttribute("message", "");
		//iHour = 25; //DEBUG SETTING
		
		//야근등록  N 정책 검사
		if (workState.getWsTyp().equals("N")) {
			// 등록장소 입력
			workState.setWsPlace(user.getIsInnerNetworkPrint2());
			String wsId = workStateService.selectExistAbsentDataWsId(workState);
			workState.setWsId(wsId);
			
			// 당일 등록은 22시 23시만 해당시간 이후에만 등록
			if(iToday == iWsBgnDe) {
				if(iHour > 21 && iHour >= iWsBgnTm) {
					if(wsId == null || wsId.equals("") )
						workStateService.insertWorkState(workState);
					else
						workStateService.updateWorkState(workState);
				} else 							
					model.addAttribute("message", sMsg);
				
			} // 전일 등록은 6시 이전까지만 등록.6시는 5시~5:59:59까지 등록가능
			else if(iYesterday == iWsBgnDe) {
				if( (iHour < 6 && iWsBgnTm > 21) ||//22, 23, 24시
				   (iHour < 6 && iHour >= iWsBgnTm) || //1, 2, 3, 4, 5시
				   (iHour == 5 && iWsBgnTm == 6) ) { // 6시 야근등록은 5시~5:59:59까지 등록
					
					if(wsId == null || wsId.equals("") )
						workStateService.insertWorkState(workState);
					else
						workStateService.updateWorkState(workState);
				} else {
					model.addAttribute("message", sMsg);
				}
			} else { // 당일 전일 외 아예 다른 날
				model.addAttribute("message", sMsg);
			}
		} else if (workState.getWsTyp().equals("O")) { //외근 O
			int iCount = workStateService.checkExistAbsentData(workState);
			if(iCount == 0){
				workStateService.insertWorkState(workState);
			} else {
				model.addAttribute("message", sMsgExist);
			}
		} else { //출장 파견 T S
			workStateService.insertWorkState(workState);
		}
		
		if(model.get("message").equals("") == false){
			return "error/messageError";			
		}		
		
		if (workState.getWsTyp().equals("N"))
			return "redirect:/member/selectOvertimeView.do";
		else
			return "redirect:/member/dailyWorkStateStatistic.do";
	}

	
	@RequestMapping("/member/updateAbsenceView.do")
	public String updateAbsenceView(@ModelAttribute("searchVO") WorkStateVO wsVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO tmp = new MemberVO();
		tmp.setWorkStList(new String[]{"W"});
		
		WorkStateVO view = workStateService.selectWorkState(wsVO);

		model.addAttribute("memList", memberService.selectMemberList(tmp));
		model.addAttribute("result", view);
		
		return "human_resource/hr_absenceM";
	}
	@RequestMapping("/member/updateAbsence.do")
	public String updateAbsence(WorkState absence, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);		
		absence.setWriterNo(user.getNo());
		String sMsgExist = "중복외근등록 불가\\n해당 일자 시간에 이미 등록된 데이터가 있습니다";	
		model.addAttribute("message", "");
				
		if (absence.getWsTyp().equals("O")) { //외근 O
			int iCount = workStateService.checkExistAbsentData(absence);
			if(iCount == 0){
				workStateService.updateWorkState(absence);
			} else {
				model.addAttribute("message", sMsgExist);
			}
		} else { //외근 외 파견 출장
			workStateService.updateWorkState(absence);
		}
		
		if(model.get("message").equals("") == false){
			return "error/messageError";			
		}
		
		return "redirect:/member/dailyWorkStateStatistic.do";
	}
	@RequestMapping("/member/deleteAbsence.do")
	public String deleteAbsence(@ModelAttribute("searchVO") WorkStateVO wsVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		workStateService.deleteWorkState(wsVO);
		
		return "redirect:/member/dailyWorkStateStatistic.do";
	}
	

    @RequestMapping("/member/changeUserinfo.do")
    public void changeUserinfo(MemberVO memberVO, HttpServletResponse res, ModelMap model) throws Exception {
    	
    	MemberVO userinfo = (MemberVO)memberService.selectMember(memberVO).get("member");
    	
    	res.setContentType("text/xml;charset=UTF-8");
		String out = "<moblphonNo>" + userinfo.getMoblphonNo() + "</moblphonNo>";
		out += "<homeTelno>" + userinfo.getHomeTelno() + "</homeTelno>";
		
		res.getWriter().println( CommonUtil.getXMLStr(out) );
		
    }

}
