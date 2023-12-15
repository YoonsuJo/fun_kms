package kms.com.common.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kms.com.common.service.CommonService;
import kms.com.common.service.ExpansionVO;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberVO;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class MypageController {

	Logger logT = Logger.getLogger("TENY");

    @Resource(name = "KmsCommonService")
    private CommonService commonService;
    
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@RequestMapping(value="/mypage/listMenuAll.do")
    public String listMenuAll(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	
    	model.addAttribute("user", user);
    	
    	return "mypage/listMenuAll";
    }
    
	@RequestMapping(value="/mypage/MymenuList.do")
    public String MymenuList(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	
    	List<EgovMap> resultList = commonService.getMyMenuList(user);
    	
    	model.addAttribute("resultList", resultList);
    	
    	return "mypage/mypageL";
    }
    
    @RequestMapping(value="/mypage/writeMenuPop.do")
    public String writeMenuPop(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");
		return "mypage/menuWMPop";
	}
	
	@RequestMapping(value="mypage/saveMenu.do")
	public String insertMymenu(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");
		
		MemberVO user = SessionUtil.getMember(req);
		commandMap.put("userNo", user.getNo());
		commonService.insertMymenu(commandMap);
	
		model.addAttribute("retMessage", "success");
		return "/common/returnPage/windowReloadNClose";
	}
	
    @RequestMapping(value="/mypage/modifyMymenu.do")
    public String modifyMymenu(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

    	EgovMap result = commonService.getMyMenu(commandMap);
    	
    	model.addAttribute("result", result);
    	
    	return "mypage/mypageM";
    }
    
    @RequestMapping(value="/mypage/updateMymenu.do")
    public String updateMymenu(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	
    	commandMap.put("userNo", user.getNo());
    	
    	commonService.updateMymenu(commandMap);
    	
    	return "redirect:/mypage/MymenuList.do";
    }
    
    @RequestMapping(value="/mypage/deleteMymenu.do")
    public String deleteMymenu(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	commonService.deleteMymenu(commandMap);
    	
    	return "redirect:/mypage/MymenuList.do";
    }
    
    @RequestMapping(value="/mypage/ajaxOrderUpdate.do")
    public void ajaxOrderUpdate(Map<String, Object> commandMap, String orderResult, HttpServletRequest req, ModelMap model) throws Exception {
    	
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
        		Map<String, Object> map = new HashMap<String, Object>();
        		map.put("no", no);
        		map.put("menuOrd", idx);
        		orderResultJ.remove(Integer.toString(idx));
        		commonService.updateMymenu(map);
        	}
        	idx ++;
        }
    	
    }
    
    @RequestMapping(value="/mypage/expansionPop.do")
    public String expansionPop(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

    	MemberVO user = SessionUtil.getMember(req);
    	
		List<ExpansionVO> expList = commonService.getExpansionList(user);
		List<ExpansionVO> unuseExpList = commonService.getUnuseExpansionList(user);
		
		model.addAttribute("expList", expList);
		model.addAttribute("unuseExpList", unuseExpList);

    	return "include/expansion_pop";
    }

    @RequestMapping(value="/mypage/expansionAdd.do")
    public String expansionAdd(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	
    	commandMap.put("userNo", user.getNo());
    	
    	commonService.insertExpansionUse(commandMap);
    	
    	return "redirect:/mypage/expansionPop.do";
    }
    @RequestMapping(value="/mypage/expansionDel.do")
    public String expansionDel(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

    	MemberVO user = SessionUtil.getMember(req);
    	
    	commandMap.put("userNo", user.getNo());
    	
    	commonService.deleteExpansionUse(commandMap);

    	return "redirect:/mypage/expansionPop.do";
    }
    
    
    
    @RequestMapping(value="/mypage/ajaxExpOrderUpdate.do")
    public void ajaxExpOrderUpdate(Map<String, Object> commandMap, String orderResult, HttpServletRequest req, ModelMap model) throws Exception {

    	MemberVO user = SessionUtil.getMember(req);
    	
    	String orderResultDecode = URLDecoder.decode(orderResult, "UTF-8");
        JSONObject orderResultJ=  (JSONObject)JSONValue.parseWithException(orderResultDecode);
        
        int idx = 0;
        while(!orderResultJ.isEmpty())
        {
        	String expId = (String)orderResultJ.get(Integer.toString(idx));
        	if(expId == null)
        	{
        		
        	}
        	else
        	{
        		Map<String, Object> map = new HashMap<String, Object>();
        		map.put("userNo", user.getNo());
        		map.put("expId", expId);
        		map.put("expOrd", idx);
        		orderResultJ.remove(Integer.toString(idx));
        		commonService.updateExpansionOrder(map);
        	}
        	idx ++;
        }
    }
    
    
    @RequestMapping(value="/mypage/ScrapList.do")
    public String ScrapList(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = new HashMap<String, Object>();

    	MemberVO user = SessionUtil.getMember(req);
    	param.put("userNo", user.getUserNo());
    	
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
		
		List resultList = commonService.getScrapList(param);
		int totCnt = commonService.getScrapListCnt(param);

		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
    	
    	return "mypage/scrapL";
    }
    
    @RequestMapping(value="/mypage/insertScrap.do")
    public String insertScrap(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	commandMap.put("userNo", user.getUserNo());
    	
    	commonService.insertScrap(commandMap);
    	
    	return "mypage/done";
    }
    
    @RequestMapping(value="/mypage/deleteScrap.do")
    public String deleteScrap(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	commonService.deleteScrap(commandMap);
    	
    	return "redirect:/mypage/ScrapList.do?pageIndex=" + commandMap.get("pageIndex");
    }
    
    @RequestMapping(value="/mypage/MyArticleList.do")
    public String MyArticleList(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = new HashMap<String, Object>();

    	MemberVO user = SessionUtil.getMember(req);
    	param.put("userNo", user.getUserNo());
    	
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
		
		List resultList = commonService.getMyArticleList(param);
		int totCnt = commonService.getMyArticleListCnt(param);

		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
    	
    	return "mypage/myArticleL";
    }

	
	
	
}
