package kms.com.admin.organ.web;

import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kms.com.admin.organ.service.Organ;
import kms.com.admin.organ.service.OrganService;
import kms.com.admin.organ.service.OrganVO;
import kms.com.common.service.BusinessSectorVO;
import kms.com.common.service.CommonService;
import kms.com.common.service.StatisticSectorVO;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.ProjectService;
import kms.com.member.service.MemberVO;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 
 * 조직정보에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author 민형식
 * @since 2011.09.07
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.09.07  민형식          최초 생성
 *
 * </pre>
 */
@Controller
public class OrganController {
	@Resource(name = "OrganService")
	private OrganService organService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private DefaultBeanValidator beanValidator;
	
	@Resource(name="kmsOrganIdGnrService")
	private EgovIdGnrService idGnrService;	
	
	@Resource(name = "KmsCommonService")
	CommonService commonService;
	
	@Resource(name = "projectService")
	private ProjectService projectService;

	/**
	 * 조직정보를 삭제한다.
	 * @param loginVO
	 * @param organ
	 * @param model
	 * @return "forward:/admin/organ/OrganList.do"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/organ/OrganRemove.do")
	public String deleteOrgan (@ModelAttribute("loginVO") LoginVO loginVO
			, Organ organ
			, ModelMap model
			, HttpServletRequest req
			) throws Exception {
		
		//사용자 정보 수신
		MemberVO user = (MemberVO)SessionUtil.getMember(req);
		organ.setLastUpdusrId(user.getUserId());    	
		organ.setFrstRegisterId(user.getUserId());
		organService.deleteOrgan(organ);
		 
		// 3.조직정보 이력 등록
		organ.setOrgStat("삭제");
		organService.insertOrganHis(organ);    	 
		 
		return "forward:/admin/organ/OrganList.do";
	}

	/**
	 * 조직정보를 등록한다.
	 * @param loginVO
	 * @param organ
	 * @param bindingResult
	 * @return "/admin/organ/OrganRegist"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/organ/OrganRegist.do")
	public String insertOrgan (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("organ") Organ organ
			, BindingResult bindingResult ,HttpServletRequest req
			) throws Exception {    
		beanValidator.validate(organ, bindingResult);
		if (bindingResult.hasErrors()){			
			//하위 조직 추가 등록시에 상위조직 값에 현재 선택 조직 아이디를 전달합니다.			
			return "/admin/organ/OrganW"; // /admin/organ/
		}

		// 1.사용자 정보 수신
		MemberVO user = (MemberVO)SessionUtil.getMember(req);
		organ.setFrstRegisterId(user.getUserId());
		organ.setLastUpdusrId(user.getUserId());

		// 2.조직 정보 등록
		String orgId = idGnrService.getNextStringId();
		organ.setOrgnztId(orgId);
		organService.insertOrgan(organ);
		organService.updateOrganTree(organ);
		// 3.조직정보 이력 등록
		organ.setOrgStat("저장");
		organService.insertOrganHis(organ);
		
		return "forward:/admin/organ/OrganList.do";
	}

	/**
	 * 조직정보 상세항목을 조회한다.
	 * @param loginVO
	 * @param organ
	 * @param model
	 * @return "admin/organ/OrganDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/organ/OrganDetail.do")
	public String selectOrganDetail (@ModelAttribute("loginVO") LoginVO loginVO
			, Organ organ
			, ModelMap model
			) throws Exception {
		
		// 1. 조직 상세 정보
		Organ vo = organService.selectOrganDetail(organ);
		model.addAttribute("result", vo);

		// 2. 조직 상세 이력 목록
		List organListHis = organService.selectOrganListHis(organ);
		model.addAttribute("resultHis", organListHis);
		
		return "admin/organ/OrganV";// admin/organ/
	}

	/**
	 * 조직정보 목록을 조회한다.
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/admin/organ/OrganList"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/organ/OrganList.do")
	public String selectOrganList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") OrganVO searchVO
			, ModelMap model
			) throws Exception {
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(20);
		searchVO.setPageSize(20);

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		//2013.08.02 김대현 조직개편 검색 기능 추가
		ArrayList searchUpList = new ArrayList();
		String[] searchUpToken = searchVO.getSearchUp().split(",");	
		for (int i = searchUpToken.length-1; i >= 0 ; i--){
			searchUpList.add(searchUpToken[i]);		
		}
		searchVO.setSearchUpList(searchUpList);
		
		ArrayList searchOrgNmList = new ArrayList();
		String[] searchOrgNmToken = searchVO.getSearchOrgNm().split(",");	
		for (int i = searchOrgNmToken.length-1; i >= 0 ; i--){
			searchOrgNmList.add(searchOrgNmToken[i]);		
		}
		searchVO.setSearchOrgNmList(searchOrgNmList);
		
		List CmmnOrganList = organService.selectOrganList(searchVO);
		model.addAttribute("resultList", CmmnOrganList);
		
		int totCnt = organService.selectOrganListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "admin/organ/OrganL"; // admin/organ/OrganList
	}
	
	/**
	 * 조직정보 팝업 목록을 조회한다.
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/admin/organ/OrganListP"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/organ/OrganListP.do")
	public String selectOrganListP (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") OrganVO searchVO
			, ModelMap model
			) throws Exception {
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List CmmnCodeList = organService.selectOrganList(searchVO);
		model.addAttribute("resultList", CmmnCodeList);
		
		int totCnt = organService.selectOrganListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "admin/organ/OrganP"; // admin/organ/OrganList
	}    

	
	 
		
	/**
	 * 조직정보를 수정한다.
	 * @param loginVO
	 * @param organ
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/organ/OrganModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/organ/OrganModify.do")
	public String updateOrgan (
			@ModelAttribute("administCode") Organ organ
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			, HttpServletRequest req
			) throws Exception {
		
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		if (sCmd.equals("")) {
			Organ vo = organService.selectOrganDetail(organ);
			model.addAttribute("organ", vo);

			return "/admin/organ/OrganM";
		} else if (sCmd.equals("Modify")) {
			
			//사용자 정보 수신
			MemberVO user = (MemberVO)SessionUtil.getMember(req);
			organ.setUserNo(user.getNo());

			beanValidator.validate(organ, bindingResult);
			if (bindingResult.hasErrors()){
				Organ vo = organService.selectOrganDetail(organ);
				model.addAttribute("organ", vo);

				return "/admin/organ/OrganM"; // /admin/organ/
			}
			
			organService.updateOrgan(organ);
			organService.updateOrganTree(organ);
			projectService.updatePrjTreeByOrg(organ);
			// 2.사용자 최초등록자지정
			organ.setFrstRegisterId(user.getUserId());
			// 3.조직정보 이력 등록
			organ.setOrgStat("수정");
			organService.insertOrganHis(organ);
			
			return "redirect:/admin/organ/OrganList.do";
		} else {
			return "forward:/admin/organ/OrganList.do";
		}
	}
	
	
	@RequestMapping("/admin/organ/busiSector.do")
	public String busiSector(@ModelAttribute("searchVO") BusinessSectorVO bsVO, ModelMap model) throws Exception {
		
		List<BusinessSectorVO> resultList = commonService.selectBusinessSectorList(bsVO.getSearchYear());
		
		model.addAttribute("resultList", resultList);
		
		return "admin/organ/busi_sectorW";
	}
	
	@RequestMapping("/admin/organ/insertBusiSector.do")
	public String insertBusiSector(@ModelAttribute("searchVO") BusinessSectorVO bsVO, Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		commonService.insertBusinessSector(commandMap);
		
		return "redirect:/admin/organ/busiSector.do?searchYear=" + bsVO.getSearchYear();
	}
	@RequestMapping("/admin/organ/updateBusiSector.do")
	public String updateBusiSector(@ModelAttribute("searchVO") BusinessSectorVO bsVO, Map<String,Object> commandMap, ModelMap model) throws Exception {

		commonService.updateBusinessSector(commandMap);
		
		return "redirect:/admin/organ/busiSector.do?searchYear=" + bsVO.getSearchYear();
	}
	

	@RequestMapping("/ajax/admin/organ/updateBusiSector.do")
	public void ajaxOrderUpdate(@ModelAttribute("searchVO") BusinessSectorVO bsVO,
			String orderResult, HttpServletResponse res, Model model) throws Exception {
		
		String orderResultDecode = URLDecoder.decode(orderResult, "UTF-8");
		JSONObject orderResultJ=  (JSONObject)JSONValue.parseWithException(orderResultDecode);
		
		int idx = 0;
		while(!orderResultJ.isEmpty())
		{
			String no = (String)orderResultJ.get(Integer.toString(idx));
			if(no == null)
			{
				
			}
			else
			{
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("no", no);
				param.put("busiSectorOrd", idx);
				orderResultJ.remove(Integer.toString(idx));
				commonService.updateBusinessSectorOrd(param);
			}
			idx ++;
		}
	}
	
	@RequestMapping("/admin/organ/statisticSector.do")
	public String statisticSector(@ModelAttribute("searchVO") StatisticSectorVO ssVO, ModelMap model) throws Exception {
		
		List<StatisticSectorVO> resultList = commonService.selectStatisticSectorList(ssVO);
		
		model.addAttribute("resultList", resultList);
		
		return "admin/organ/statistic_sectorW";
	}
	
	@RequestMapping("/admin/organ/insertStatisticSector.do")
	public String insertStatisticSector(@ModelAttribute("searchVO") StatisticSectorVO ssVO, Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		commonService.insertStatisticSector(commandMap);
		
		return "redirect:/admin/organ/statisticSector.do?searchYear=" + ssVO.getSearchYear() + "&sectorTyp=" + ssVO.getSectorTyp();
	}
	
	@RequestMapping("/admin/organ/updateStatisticSector.do")
	public String updateStatisticSector(@ModelAttribute("searchVO") StatisticSectorVO ssVO, Map<String,Object> commandMap, ModelMap model) throws Exception {

		commonService.updateStatisticSector(commandMap);
		
		return "redirect:/admin/organ/statisticSector.do?searchYear=" + ssVO.getSearchYear() + "&sectorTyp=" + ssVO.getSectorTyp();
	}
	
	@RequestMapping("/admin/organ/deleteStatisticSector.do")
	public String deleteStatisticSector(@ModelAttribute("searchVO") StatisticSectorVO ssVO, Map<String,Object> commandMap, ModelMap model) throws Exception {

		commonService.deleteStatisticSector(commandMap);
		
		return "redirect:/admin/organ/statisticSector.do?searchYear=" + ssVO.getSearchYear() + "&sectorTyp=" + ssVO.getSectorTyp();
	}

	@RequestMapping("/ajax/admin/organ/updateStatisticSector.do")
	public void ajaxOrderUpdate(@ModelAttribute("searchVO") StatisticSectorVO ssVO,
			String orderResult, HttpServletResponse res, Model model) throws Exception {
		
		String orderResultDecode = URLDecoder.decode(orderResult, "UTF-8");
		JSONObject orderResultJ=  (JSONObject)JSONValue.parseWithException(orderResultDecode);
		
		int idx = 0;
		while(!orderResultJ.isEmpty())
		{
			String no = (String)orderResultJ.get(Integer.toString(idx));
			if(no == null)
			{
				
			}
			else
			{
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("no", no);
				param.put("statisticSectorOrg", idx);
				orderResultJ.remove(Integer.toString(idx));
				commonService.updateStatisticSectorOrd(param);
			}
			idx ++;
		}
	}
}