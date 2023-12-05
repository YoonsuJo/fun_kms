package kms.com.support.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.support.service.IpVO;
import kms.com.support.service.ResourceService;

@Controller
public class IpController {

	@Resource(name = "KmsResourceService")
	private ResourceService resourceService;
	
	@Resource(name="KmsMemberService")
	MemberService memberService;
	
	@RequestMapping("/support/selectIpList.do")
	public String selectIpList(ModelMap model) throws Exception{
		
		List<IpVO> resultList = resourceService.selectIpList(null);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("ipModDate", CalendarUtil.getToday());
		
		return "support/sprt_ipL";
	}
	
	@RequestMapping("/support/selectIpW.do")
	public String selectIpW(Map<String, Object> commandMap, ModelMap model) throws Exception{
		return "/support/sprt_ipW";
	}
	
	@RequestMapping("/support/selectIpM.do")
	public String selectIpM(IpVO ipVO, ModelMap model) throws Exception{
		
		IpVO result = resourceService.selectIp(ipVO);
		model.addAttribute("result", result);
		
		return "support/sprt_ipM";
	}
	
	@RequestMapping("/support/insertIpinfo.do")
	public String insertIpInfo(IpVO ipVO, ModelMap model) throws Exception{
		
		String ipUserId = ipVO.getIpUserList()[0].split("\\(")[1].split("\\)")[0];
		MemberVO memberVO = new MemberVO();
		memberVO.setUserId(ipUserId);
		memberVO = memberService.selectMemberByIdNew(memberVO);
		ipVO.setIpUserNo(memberVO.getNo());
		
		ipVO.setIpModDate(CalendarUtil.getToday());
		
		IpVO isUseVO = resourceService.selectIpInfo(ipVO);
		if(isUseVO != null) {
			model.addAttribute("message", "해당 주소는 이미 사용 중입니다.");
			return "error/messageError";
		}
		
		resourceService.insertIpInfo(ipVO);
		
		return "redirect:/support/selectIpList.do";
	}
	
	@RequestMapping("/support/updateIpInfo.do")
	public String updateIpInfo(IpVO ipVO, ModelMap model) throws Exception{
		
		String ipUserId = ipVO.getIpUserList()[0].split("\\(")[1].split("\\)")[0];
		MemberVO memberVO = new MemberVO();
		memberVO.setUserId(ipUserId);
		memberVO = memberService.selectMemberByIdNew(memberVO);
		ipVO.setIpUserNo(memberVO.getNo());
		
		ipVO.setIpModDate(CalendarUtil.getToday());
		
		IpVO isUseVO = resourceService.selectIpInfo(ipVO);
		if(isUseVO != null) {
			if(isUseVO.getNo() != ipVO.getNo()) {
				model.addAttribute("message", "해당 주소는 이미 사용 중입니다.");
				return "error/messageError";
			}
		}
		
		resourceService.updateIpInfo(ipVO);
		
		return "redirect:/support/selectIpList.do";
	}
	
	@RequestMapping("/support/deleteIpInfo.do")
	public String deleteIpInfo(IpVO ipVO) throws Exception{
		
		resourceService.deleteIpInfo(ipVO);
		
		return "redirect:/support/selectIpList.do";
	}
}
