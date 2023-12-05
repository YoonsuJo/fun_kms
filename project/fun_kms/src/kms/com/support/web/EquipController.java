package kms.com.support.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.config.PathConfig;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.Msn;
import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarReservationVO;
import kms.com.support.service.CarVO;
import kms.com.support.service.CardVO;
import kms.com.support.service.EquipVO;
import kms.com.support.service.ResourceService;
import kms.com.support.service.TaxPublishVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.support.HttpRequestHandlerServlet;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EquipController {

	@Resource(name = "KmsResourceService")
	private ResourceService resourceService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;

    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
    
    
	@RequestMapping("/support/selectEquipList.do")
	public String selectEquipList(@ModelAttribute("equipVO") EquipVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		/* 검색 조건 관련 내용 Start */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchCondition", searchVO.getSearchCondition());
		param.put("searchKeyword", searchVO.getSearchKeyword());
		param.put("searchSelect", searchVO.getSearchSelect());
		/* 검색 조건 관련 내용 End */
		
		
		/* 페이징 관련 내용 Start */
		/*
		param.put("pageUnit", propertyService.getInt("pageUnit"));
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		int pageIndex = 1;
		if (commandMap.get("pageIndex") != null && !commandMap.get("pageIndex").equals(""))
			pageIndex = Integer.parseInt(commandMap.get("pageIndex").toString());
		
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		*/
		/* 페이징 관련 내용 End */
		
		List<EquipVO> resultList = resourceService.selectEquipList(param);
		List<EquipVO> equipTypeList = resourceService.selectEquipTypeList();

		model.addAttribute("equipTypeList", equipTypeList);
		
		//int totCnt = resourceService.selectEquipListTotCnt(param);

		//paginationInfo.setTotalRecordCount(totCnt);

    	//model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", searchVO);
		
		return "support/sprt_equipL";
	}

	@RequestMapping("/support/selectEquipView.do")
	public String selectEquipView(EquipVO equipVO, ModelMap model) throws Exception{
		equipVO = resourceService.selectEquipInfo(equipVO);
		List equipHistoryVOList = resourceService.selectEquipHistoryList(equipVO);
		List equipRepairHistoryVOList = resourceService.selectEquipRepairHistoryList(equipVO);
		List<EquipVO> equipTypeList = resourceService.selectEquipTypeList();
		
		model.addAttribute("equipVO", equipVO);
		model.addAttribute("equipHistoryVOList", equipHistoryVOList);
		model.addAttribute("equipRepairHistoryVOList", equipRepairHistoryVOList);
		model.addAttribute("equipTypeList", equipTypeList);
				
		return "support/sprt_equipV";
	}
	
	@RequestMapping("/support/insertEquipView.do")
	public String insertEquipView(ModelMap model) throws Exception{
		
		List<EquipVO> equipTypeList = resourceService.selectEquipTypeList();
		model.addAttribute("equipTypeList", equipTypeList);
		
		return "support/sprt_equipW";
	}
	
	
	@RequestMapping("/support/insertEquip.do")
	public String insertEquip(EquipVO equipVO, ModelMap model) throws Exception{
		resourceService.insertEquip(equipVO);
		return "redirect:/support/selectEquipList.do";
	}
	
	@RequestMapping("/support/updateEquipInfoView.do")
	public String updateCarInfoView(EquipVO equipVO, ModelMap model) throws Exception{

		EquipVO result = resourceService.selectEquipInfo(equipVO);

		List equipHistoryVOList = resourceService.selectEquipHistoryList(equipVO);
		List<EquipVO> equipTypeList = resourceService.selectEquipTypeList();
		
		model.addAttribute("equipTypeList", equipTypeList);
		model.addAttribute("result", result);
		model.addAttribute("equipHistoryVOList", equipHistoryVOList);
		
		return "support/sprt_equipM";
	}
	
	@RequestMapping("/support/updateEquip.do")
	public String updateEquip(EquipVO equipVO, ModelMap model) throws Exception{
		resourceService.updateEquip(equipVO);
		return "redirect:/support/selectEquipList.do";
	}
	
	@RequestMapping("/support/deleteEquip.do")
	public String deleteEquipInfo(EquipVO equipVO, ModelMap model) throws Exception{		
		resourceService.deleteEquipDetail(equipVO);
		resourceService.deleteEquip(equipVO);		
		return "redirect:/support/selectEquipList.do";
	}
	
	//장비 사용이력 시작
	@RequestMapping("/support/insertEquipDetailView.do")
	public String insertEquipDetailView(@ModelAttribute("equipVO") EquipVO equipVO, ModelMap model) throws Exception{
		equipVO = resourceService.selectEquipInfo(equipVO);
		model.addAttribute("equipVO", equipVO);
		return "support/sprt_equipDetailW";
	}
		
	@RequestMapping("/support/insertEquipDetail.do")
	public String insertEquipDetail(EquipVO equipVO, ModelMap model) throws Exception{		
		equipVO.setUser_id(CommonUtil.parseIdFromMixs(equipVO.getUser_nm())[0]);
		equipVO.setUser_nm(CommonUtil.parseNmFromMixs(equipVO.getUser_nm())[0]);
		resourceService.updateEquipNotUsed(equipVO);
		resourceService.insertEquipDetail(equipVO);
		resourceService.updateEquipUser(equipVO);
		return "redirect:/support/selectEquipView.do?equip_no="+equipVO.getEquip_no();
	}
	
	@RequestMapping("/support/selectEquipDetailView.do")
	public String selectEquipDetailView(EquipVO equipVO, ModelMap model) throws Exception{
		equipVO = resourceService.selectEquipInfoDetail(equipVO);
		model.addAttribute("equipVO", equipVO);
		return "support/sprt_equipDetailV";
	}	
	
	@RequestMapping("/support/updateEquipDetailView.do")
	public String updateEquipDetailView(EquipVO equipVO, ModelMap model) throws Exception{
		equipVO = resourceService.selectEquipInfoDetail(equipVO);
		model.addAttribute("equipVO", equipVO);
		return "support/sprt_equipDetailM";
	}
	
	@RequestMapping("/support/updateEquipDetail.do")
	public String updateEquipDetail(EquipVO equipVO, ModelMap model) throws Exception{
		resourceService.updateEquipDetail(equipVO);
		String idx = equipVO.getIdx();
		String maxIdx = resourceService.selectMaxIdx(equipVO);		
		if(idx.equals(maxIdx)) 
			resourceService.updateEquipUser(equipVO);		
		return "redirect:/support/selectEquipView.do?equip_no="+equipVO.getEquip_no();
	}

	@RequestMapping("/support/deleteEquipDetail.do")
	public String deleteEquipDetail(EquipVO equipVO, ModelMap model) throws Exception{
		resourceService.deleteEquipDetail(equipVO);		
		return "redirect:/support/selectEquipView.do?equip_no="+equipVO.getEquip_no();
	}
	//장비 사용이력 끝
	
	//장비 수리이력 시작
	@RequestMapping("/support/insertEquipRepairView.do")
	public String insertEquipRepairView(@ModelAttribute("equipVO") EquipVO equipVO, ModelMap model) throws Exception{
		equipVO = resourceService.selectEquipInfo(equipVO);
		model.addAttribute("equipVO", equipVO);
		return "support/sprt_equipRepairW";
	}	
	
	@RequestMapping("/support/insertEquipRepair.do")
	public String insertEquipRepair(EquipVO equipVO, HttpServletRequest request, ModelMap model) throws Exception{		
		MemberVO user = (MemberVO)SessionUtil.getMember(request);
		equipVO.setRegNo(user.getNo());
		resourceService.insertEquipRepair(equipVO);
		return "redirect:/support/selectEquipView.do?equip_no="+equipVO.getEquip_no();
	}
	
	@RequestMapping("/support/selectEquipRepairView.do")
	public String selectEquipRepairView(EquipVO equipVO, ModelMap model) throws Exception{
		equipVO = resourceService.selectEquipInfoRepair(equipVO);
		model.addAttribute("equipVO", equipVO);
		return "support/sprt_equipRepairV";
	}
	
	@RequestMapping("/support/updateEquipRepairView.do")
	public String updateEquipRepairView(EquipVO equipVO, ModelMap model) throws Exception{
		equipVO = resourceService.selectEquipInfoRepair(equipVO);
		model.addAttribute("equipVO", equipVO);
		return "support/sprt_equipRepairM";
	}
	
	@RequestMapping("/support/updateEquipRepair.do")
	public String updateEquipRepair(EquipVO equipVO, HttpServletRequest request, ModelMap model) throws Exception{
		MemberVO user = (MemberVO)SessionUtil.getMember(request);
		equipVO.setUdtNo(user.getNo());
		resourceService.updateEquipRepair(equipVO);		
		return "redirect:/support/selectEquipView.do?equip_no="+equipVO.getEquip_no();
	}

	@RequestMapping("/support/deleteEquipRepair.do")
	public String deleteEquipRepair(EquipVO equipVO, ModelMap model) throws Exception{
		resourceService.deleteEquipRepair(equipVO);		
		return "redirect:/support/selectEquipView.do?equip_no="+equipVO.getEquip_no();
	}
	//장비 수리이력 끝
	
	@RequestMapping("/support/selectEquipTypeList.do")
	public String selectEquipTypeList(@ModelAttribute("equipVO") EquipVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		List<EquipVO> resultList = resourceService.selectEquipTypeList();

		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", searchVO);
		
		return "support/sprt_equipTypeL";
	}

	@RequestMapping("/support/selectEquipTypeView.do")
	public String selectEquipTypeView(EquipVO equipVO, ModelMap model) throws Exception{
		equipVO = resourceService.selectEquipTypeInfo(equipVO);
		model.addAttribute("equipVO", equipVO);
		return "support/sprt_equipTypeV";
	}
	
	@RequestMapping("/support/updateEquipType.do")
	public String updateEquipType(EquipVO equipVO, ModelMap model) throws Exception{
		resourceService.updateEquipType(equipVO);
		return "redirect:/support/selectEquipTypeList.do";
	}
	
	@RequestMapping("/support/deleteEquipType.do")
	public String deleteEquipType(EquipVO equipVO, ModelMap model) throws Exception{
		
		resourceService.deleteEquipType(equipVO);
		
		return "redirect:/support/selectEquipTypeList.do";
	}
	
	
	@RequestMapping("/support/insertEquipTypeView.do")
	public String insertEquipTypeView(ModelMap model) throws Exception{
		return "support/sprt_equipTypeW";
	}
	
	
	@RequestMapping("/support/insertEquipType.do")
	public String insertEquipType(EquipVO equipVO, ModelMap model) throws Exception{
		resourceService.insertEquipType(equipVO);
		return "redirect:/support/selectEquipTypeList.do";
	}
}
