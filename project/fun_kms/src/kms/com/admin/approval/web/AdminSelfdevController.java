package kms.com.admin.approval.web;

import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import kms.com.app.service.*;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.member.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

/**
 * @Class Name : KmsApprovalTypController.java
 * @Description : KmsApprovalTypController class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class AdminSelfdevController {

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="KmsSelfdevService")
	KmsSelfdevService selfdevService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name="KmsWorkStateService")
	WorkStateService workStateService;
	
	@Resource(name = "approvalService")
	private KmsApprovalService approvalService;
	
	@Resource(name="KmsMemberService")
	MemberService memberService;
	
	/**
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/approval/selectSelfdevList.do")
	public String selectAccountList(@ModelAttribute("searchVO") SelfdevVO searchVO, 
			ModelMap model)
			throws Exception {
		Calendar cal = Calendar.getInstance();
		if(searchVO.getYear()==null)
			searchVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));    	
		List resultList = selfdevService.selectSelfdevCmmList(searchVO);
		List resultList2 = selfdevService.selectSelfdevUsrList(searchVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultList2", resultList2);
		model.addAttribute("year", searchVO.getYear());
		model.addAttribute("thisMonth", cal.get(Calendar.MONTH));        
		
		return "admin/approval/selfdevL";
	}
	
	@RequestMapping(value="/admin/approval/selectVacationList.do")
	public String selectVacationList(@ModelAttribute("searchVO") WorkStateVO wsVO, 
			@ModelAttribute("memberVO") MemberVO memberVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		wsVO.setSearchOrgIdList(CommonUtil.makeValidIdList(wsVO.getSearchOrgId()));
		
		String move = (String)commandMap.get("move");
		
		if (move != null && move.equals("") == false) {
			wsVO.setSearchDate(CalendarUtil.getDate(wsVO.getSearchDate(), Integer.parseInt(move)));
		}
		
		Map<String, Object> result = workStateService.selectAbsenceState(wsVO);
		
		model.addAttribute("specificVO", new ApprovalVacVO()) ;
		model.addAttribute("result", result);
		
		return "admin/approval/appr_absenceL";	
	}

	@Resource(name = "kmsApprovalService")
	private EgovIdGnrService idgenService;

	
	@RequestMapping(value="/admin/approval/insertVacationList.do")
	public String insertVacationList(@ModelAttribute("specificVO") ApprovalVacVO approvalVacVO,
			ApprovalVO paramVO, ModelMap model)
			throws Exception {
		Calendar cal = Calendar.getInstance();
		
		ApprovalVO approvalVO = new ApprovalVO();
		approvalVacVO.setRecieverIdList(CommonUtil.parseIdFromMixs(approvalVacVO.getRecieverList()));
		String recieverIdList[] = approvalVacVO.getRecieverIdList();
		String docId;
		String stDt = approvalVacVO.getStDt();
		String edDt = approvalVacVO.getEdDt();
		//To do : 휴직자 검사, 이미 휴가처리되어있는 사람 검사, IdList에 planned01~06 들어가있으면 걸러내기
		//JSP 단에서 휴가자, 휴가일자 선택 안되면 검사해서 튕겨주기
		//휴가 삭제 기능 추가
				
		if(recieverIdList != null && stDt != null && stDt != "" && edDt != null && edDt != ""){
			String sContent = stDt.substring(0,4) + "." + stDt.substring(4,6) + "." + stDt.substring(6,8) + " 일괄휴가처리 문서";
			sContent += "-" + paramVO.getSubject();
			
			for (int i = 0; i < recieverIdList.length; i++ ) {
				//전자결재 휴가처리문서 입력
				
				MemberVO memberVO = new MemberVO();
				memberVO.setUserId(recieverIdList[i]);
				memberVO = memberService.selectMemberByIdNew(memberVO);
				
				docId = idgenService.getNextStringId();
				approvalVO.setWriterId(recieverIdList[i]);
				approvalVO.setDocId(docId);
				approvalVO.setParntId(docId);    		
				approvalVO.setWriterNo(memberVO.getNo());
				approvalVO.setSubject(sContent);
				approvalVO.setContent(sContent);
				approvalVO.setDocStat("APP005");
				approvalVO.setNewAt(1);
				approvalVO.setCnt(0);
				approvalVO.setReUseCnt(0);
				approvalVO.setHandleStat(0);    		
				approvalVO.setAtchFileId("");    		
				approvalVO.setTempltId("2");
				approvalVO.setReWriteTyp(0);    		    		
				approvalService.insertApprovalCmm(approvalVO);
				
				//휴가 테이블 입력
				approvalVacVO.setDocId(docId);
				approvalVacVO.setVacTyp(approvalVacVO.getVacTyp());
				approvalVacVO.setStDt(approvalVacVO.getStDt());
				approvalVacVO.setEdDt(approvalVacVO.getEdDt());
				approvalVacVO.setStAmpm(approvalVacVO.getStAmpm());
				approvalVacVO.setEdAmpm(approvalVacVO.getEdAmpm());
				approvalVacVO.setSumDate(approvalVacVO.getSumDate());
				approvalVacVO.setWriterNo(memberVO.getNo().toString());
				approvalVacVO.setSystem("1"); //일괄입력 여부 플래그
				approvalService.insertApprovalVac(approvalVacVO);
				
				//부재자 현황 입력
				WorkState workState = new WorkState();
				workState.setUserNo(memberVO.getNo());
				workState.setWriterNo(memberVO.getNo());
				workState.setWsTyp("V");
				workState.setWsBgnDe(approvalVacVO.getStDt());
				workState.setWsEndDe(approvalVacVO.getEdDt());
				workState.setUserTelno(memberVO.getHomeTelno());
				workState.setUserMoblphonNo(memberVO.getMoblphonNo());
				workState.setWsPurpose(sContent);
				workState.setDocId(docId); // 휴가문서 번호 입력
				workStateService.insertWorkState(workState);
			}
		}
		return "redirect:/admin/approval/selectVacationList.do";
		//return "admin/approval/appr_absenceL";
	}
	
	@RequestMapping(value="/admin/approval/updateSelfdevCmm.do")
	public String updateSelfdevCmm(@ModelAttribute("searchVO") SelfdevVO searchVO, 
			@ModelAttribute("selfdevCmmVO") SelfdevVO selfdevCmmVO,
			ModelMap model)
	throws Exception {
		
		Calendar cal = Calendar.getInstance();
		if(selfdevCmmVO.getYear()==null)
			selfdevCmmVO.setYear(Integer.toString(cal.get(Calendar.YEAR))); 
		selfdevService.updateSelfdevCmm(selfdevCmmVO);
		
		return "redirect:/admin/approval/selectSelfdevList.do";
	}
	
	@RequestMapping(value="/ajax/selectSelfdevUsrList.do")
	public String selectSelfdevUsrList(@ModelAttribute("searchVO") SelfdevVO searchVO, 
			ModelMap model)
	throws Exception {
		List resultList2 = selfdevService.selectSelfdevUsrList(searchVO);
		model.addAttribute("year", searchVO.getYear() );
		model.addAttribute("resultList2", resultList2);
		return "/admin/approval/include/selfdevUsrL";
	}
	
	@RequestMapping(value="/ajax/admin/approval/writeSelfdevUsr.do")
	public String writeSelfdevUsrView(@ModelAttribute("searchVO") SelfdevVO searchVO, 
			ModelMap model)
	throws Exception {
		model.addAttribute("selfdevUsrVO", new SelfdevVO());
		return "/admin/approval/include/selfdevUsrW";
	}
	
	@RequestMapping(value="/ajax/admin/approval/modifySelfdevUsr.do")
	public String modifySelfdevUsrView(@ModelAttribute("searchVO") SelfdevVO searchVO, 
			ModelMap model)
	throws Exception {
		searchVO = selfdevService.selectSelfdevUsrView(searchVO);  
		searchVO.setExtraCharge(Integer.toString(Integer.parseInt(searchVO.getExtraCharge())/1000)); 
		model.addAttribute("selfdevUsrVO", searchVO);
		return "/admin/approval/include/selfdevUsrW";
	}
	
	@RequestMapping(value="/ajax/admin/approval/deleteSelfdevUsr.do")
	public String deleteSelfdevUsr(@ModelAttribute("searchVO") SelfdevVO searchVO, 
			ModelMap model)
	throws Exception {
		selfdevService.deleteSelfdevUsr(searchVO);
		return "success";
	}    
	
	@RequestMapping(value="/ajax/admin/approval/insertSelfdevUsr.do")
	public String insertSelfdevUsrView(@ModelAttribute("searchVO") SelfdevVO searchVO, 
			@ModelAttribute("selfdevVO") SelfdevVO selfdevVO,
			ModelMap model)
	throws Exception {
		selfdevVO.setExtraCharge(Integer.toString(Integer.parseInt(selfdevVO.getExtraCharge()) * 1000)); 
		selfdevService.insertSelfdevUsr(selfdevVO);
		return "success";
	}
	
	
	@RequestMapping(value="/ajax/admin/approval/updateSelfdevUsr.do")
	public String updateSelfdevUsrView(@ModelAttribute("searchVO") SelfdevVO searchVO, 
			@ModelAttribute("selfdevVO") SelfdevVO selfdevVO,
			ModelMap model)
	throws Exception {
		selfdevVO.setExtraCharge(Integer.toString(Integer.parseInt(selfdevVO.getExtraCharge()) * 1000)); 
		selfdevService.updateSelfdevUsr(selfdevVO);
		return "success";
	}
}
