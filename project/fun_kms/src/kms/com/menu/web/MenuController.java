package kms.com.menu.web;

import kms.com.admin.organ.service.OrganService;
import kms.com.admin.organ.service.OrganVO;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberVO;
import kms.com.menu.dao.MenuDAO;
import kms.com.menu.service.MenuService;
import kms.com.menu.vo.MenuVO;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MenuController {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name="KmsMenuDAO")
	private MenuDAO menuDAO;

	@Resource(name="KmsMenuService")
	private MenuService menuService;
	
	@Resource(name = "OrganService")
	private OrganService organService;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
//TENY_170620 개인 메뉴 관련 기능
//TENY_170620 개인 메뉴 목록보기 기능
	@RequestMapping(value="/menu/myMenuL.do")
	public String myMenuL(@ModelAttribute("fm") MenuVO vo,
			Map<String,Object> commandMap,
			HttpServletRequest req, 
			ModelMap model) throws Exception {
		logT.debug("START");
		
		MemberVO user = SessionUtil.getMember(req);
		
		if((vo == null) || (vo.getOwnerNo() == 0)) {
		vo.setOwnerNo(user.getNo());
		vo.setType(1);
		}
		
		List<MenuVO> mVOList = menuDAO.selectMenuList(vo);
		
		model.addAttribute("mVOList", mVOList);
		
		logT.debug("END");
		return "menu/myMenuL";
	}

	@RequestMapping(value="/menu/writeMenuPop.do")
	public String writeMenuPop(@ModelAttribute("fm") MenuVO vo,
			HttpServletRequest req,
			ModelMap model) throws Exception {
		logT.debug("START");
		vo.setNo(0);
		vo.setType(1);
		model.addAttribute("mVO", vo);
		return "menu/menuWMPop";
	}

	@RequestMapping(value="/menu/modifyMenuPop.do")
	public String modifyMenuPop(@ModelAttribute("fm") MenuVO vo,
			HttpServletRequest req,
			ModelMap model) throws Exception {
		logT.debug("START");
		
		MenuVO mVO = menuDAO.getMenu(vo.getNo());
		model.addAttribute("mVO", mVO);
		return "menu/menuWMPop";
	}
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
// TENY_170525 팀 메뉴 관련 기능
// TENY_170525 팀 메뉴 목록보기 기능
	@RequestMapping(value="/menu/teamMenuL.do")
	public String teamMenuL(@ModelAttribute("fm") MenuVO vo,
			Map<String,Object> commandMap,
			HttpServletRequest req, 
			ModelMap model) throws Exception {
		logT.debug("START");
		
		MemberVO user = SessionUtil.getMember(req);
		String orgnztId;
		
		// 메뉴에 나올 부서목록을 조회한다. 원칙은 접속한 사용자의 부서와 그 이하 부서를 조회한다.
		OrganVO orgVO = new OrganVO();
		orgVO.setOrgnztId(user.getOrgnztId());
		List orgTreeList = organService.selectOrganTreeList(orgVO);
		model.addAttribute("orgTreeList", orgTreeList);

		// 첫페이지인 경우 나의 부서를 기본으로 검색한다.
		if((vo != null) && (vo.getOrgnztId().length() == 0)) {
			vo.setOwnerNo(user.getNo());
			vo.setOrgnztId(user.getOrgnztId());
			vo.setType(2);
		}

		List<MenuVO> mVOList = menuDAO.selectMenuList(vo);
		
		model.addAttribute("mVOList", mVOList);
		
		logT.debug("END");
		return "menu/teamMenuL";
	}
	
	// TENY_170525 팀메뉴 작성창 열기 기능
	@RequestMapping(value="/menu/teamMenuW.do")
	public String teamMenuW(@ModelAttribute("fm") MenuVO vo,
			Map<String,Object> commandMap,
			HttpServletRequest req, 
			ModelMap model) throws Exception {
		logT.debug("START");
		
		logT.debug("END");
		return "menu/menuWMPop";
	}

	@RequestMapping(value="/menu/teamMenuM.do")
	public String teamMenuM(@ModelAttribute("fm") MenuVO vo,
			Map<String,Object> commandMap,
			HttpServletRequest req, 
			ModelMap model) throws Exception {
		logT.debug("START");
		
		vo = menuDAO.getMenu(vo.getNo());

		model.addAttribute("fm", vo);
		logT.debug("END");
		return "menu/menuWMPop";
	}

	// TENY_170525 팀메뉴 저장 기능
	@RequestMapping("/menu/saveMenu.do")
	public String saveRequest(@ModelAttribute("fm") MenuVO vo,
			HttpServletRequest req, 
			Map<String,Object> commandMap, 
			ModelMap model) throws Exception {
	
		logT.debug("START");
		MemberVO user = SessionUtil.getMember(req);
		// 새로 작성된 글은 작성자를 접속사용자로 한다.
		if("space".equals(vo.getTitle()) == true) {
			if((vo.getUrl() == null) || (vo.getUrl().length() <= 0)) {
				vo.setUrl(" ");
			}
		}
			
		if(vo.getNo() == 0){ // 새로 등록되는 글
			logT.debug("insert");
			vo.setOwnerNo(user.getNo());
			menuDAO.insertMenu(vo);
		} 
		else {
			logT.debug("update");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("no", vo.getNo());
			map.put("title", vo.getTitle());
			map.put("url", vo.getUrl());
			if(vo.getType() == 2) {
				map.put("orgnztId", vo.getOrgnztId());
			}
			menuDAO.updateMenu(map);
		}
		logT.debug("END");
		model.addAttribute("fm", vo);
		return "/common/returnPage/windowReloadNClose";

	}
	
	@RequestMapping(value="/menu/deleteMenu.do")
	public String deleteMenu(@ModelAttribute("fm") MenuVO vo,
			HttpServletRequest req, 
			Map<String,Object> commandMap, 
			ModelMap model) throws Exception {

		logT.debug("START");
		
		menuDAO.deleteMenu(vo.getNo());
		model.addAttribute("fm", vo);

		logT.debug("END");
		if(vo.getType() == 1) {
			return "redirect:/menu/myMenuL.do";
		} else {
			return "redirect:/menu/teamMenuL.do";
		}
	}

	@RequestMapping(value="/menu/ajaxMenuOrderUpdate.do")
	public void ajaxMenuOrderUpdate(
			Map<String, Object> commandMap, 
			String orderResult, 
			HttpServletRequest req,
			HttpServletResponse res,
			ModelMap model) throws Exception {
		
		String orderResultDecode = URLDecoder.decode(orderResult, "UTF-8");
		JSONObject orderResultJ=  (JSONObject)JSONValue.parseWithException(orderResultDecode);
	
		int idx = 0;
		while(!orderResultJ.isEmpty())
		{
			String no = (String)orderResultJ.get(Integer.toString(idx));
			if(no != null)
			{
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("no", no);
				map.put("order", idx);
				orderResultJ.remove(Integer.toString(idx));
				menuDAO.updateMenu(map);
			}
			idx ++;
		}

		JSONObject result = new JSONObject();
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		result.put("RETURN", "OK");
		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}

}
