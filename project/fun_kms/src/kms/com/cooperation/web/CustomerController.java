package kms.com.cooperation.web;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.Customer;
import kms.com.cooperation.service.CustomerComment;
import kms.com.cooperation.service.CustomerPerson;
import kms.com.cooperation.service.CustomerService;
import kms.com.cooperation.service.CustomerVO;
import kms.com.member.service.MemberVO;
import kms.com.support.service.TaxPublishService;
import kms.com.support.service.TaxPublishVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import java.lang.Object;
import java.net.URLDecoder;

@Controller
public class CustomerController {
	
	@Resource(name="KmsCustomerService")
	private CustomerService custService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsTaxPublishService")
	private TaxPublishService taxPublishService;
	
	@RequestMapping("/cooperation/selectCustomerList.do")
	public String selectCustomerList(@ModelAttribute("searchVO") CustomerVO customerVO, ModelMap model) throws Exception {
		
		if (customerVO.getSearchUserMix().trim().equals("") == false && CommonUtil.isMixedId(customerVO.getSearchUserMix())) {
			customerVO.setSearchUserId(CommonUtil.parseIdFromMixs(customerVO.getSearchUserMix())[0]);
		}
		
		customerVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		customerVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(customerVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(customerVO.getPageUnit());
		paginationInfo.setPageSize(customerVO.getPageSize());
	
		customerVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		customerVO.setLastIndex(paginationInfo.getLastRecordIndex());
		customerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<CustomerVO> resultList = custService.selectCustomerList(customerVO);
		int totCnt = custService.selectCustomerListTotCnt(customerVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "cooperation/coop_customerL";
	}
	
	@RequestMapping(value = "/ajax/customerInfoList.do")
	public String projectUserIncluded(
			@ModelAttribute("searchVO") CustomerVO customerVO,
			HttpServletRequest request, HttpServletResponse response,
				ModelMap model) throws Exception {

		if (request.getParameter("searchTyp").equals("tax")) {
			Map<String, Object> param = new HashMap<String, Object>();
			
			param.put("searchNm", customerVO.getSearchKeyword());
			
			List<TaxPublishVO> resultList = taxPublishService.selectTaxPublishListAll(param);
			
			model.addAttribute("resultList",resultList);
			
			return "/ajax/customerTaxIncluded";
		} else {
			List<CustomerVO> resultList = null; 
			
			resultList = custService.selectCustomerListAll(customerVO);
			
			model.addAttribute("resultList",resultList);
			
			return "/ajax/customerIncluded";
		}
		
	}
	
	@RequestMapping(value = "/ajax/bondPrjNoSearch.do")
	public String bondProjectNoSearch(
			@ModelAttribute("searchVO") CustomerVO customerVO,
			HttpServletRequest request, HttpServletResponse response,
				ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("searchNm", customerVO.getSearchKeyword());
		
		List resultList = taxPublishService.selectBondPrjNo(param);
		
		model.addAttribute("resultList",resultList);
		
		return "/ajax/bondPrjNoSearch";
	}
	
	@RequestMapping("/cooperation/selectCustomer.do")
	public String selectCustomer(@ModelAttribute("searchVO") CustomerVO customerVO,
			@ModelAttribute("comment") CustomerComment customerComment,
			Map<String, Object> commandMap,  ModelMap model) throws Exception {
		
		CustomerVO result = custService.selectCustomer(customerVO);
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			customerComment.setNo(Integer.parseInt((String)commandMap.get("commentNo")));
		}
		
		model.addAttribute("result", result);
		
		return "cooperation/coop_customerV";
	}
	
	
	@RequestMapping("/cooperation/insertCustomerView.do")
	public String insertCustomerView(@ModelAttribute("searchVO") CustomerVO customerVO, ModelMap model) throws Exception {
		return "cooperation/coop_customerW";
	}
	@RequestMapping("/cooperation/insertCustomer.do")
	public String insertCustomer(final MultipartHttpServletRequest multiRequest, Customer customer,
			Map<String, Object> commandMap, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(multiRequest);
		
		customer.setUserNoReg(user.getNo());
		
		List<CustomerPerson> custPersonList = new ArrayList<CustomerPerson>();
		
		int personCnt = Integer.parseInt((String)commandMap.get("personCnt"));
		
		if (personCnt == 1) {
			CustomerPerson cp = new CustomerPerson();
			
			String personNm = (String)commandMap.get("personNm");
			String personEmail = (String)commandMap.get("personEmail");
			String personHpno = (String)commandMap.get("personHpno");
			String personTelno = (String)commandMap.get("personTelno");
			String personNote = (String)commandMap.get("personNote");
			
			cp.setPersonNm(personNm);
			cp.setPersonEmail(personEmail);
			cp.setPersonHpno(personHpno);
			cp.setPersonTelno(personTelno);
			cp.setPersonNote(personNote);
			
			custPersonList.add(cp);
			
		} else { // personCnt > 1
			for (int i=0; i<personCnt; i++) {
				CustomerPerson cp = new CustomerPerson();
				
				String personNm = ((String[])commandMap.get("personNm"))[i];
				String personEmail = ((String[])commandMap.get("personEmail"))[i];
				String personHpno = ((String[])commandMap.get("personHpno"))[i];
				String personTelno = ((String[])commandMap.get("personTelno"))[i];
				String personNote = ((String[])commandMap.get("personNote"))[i];
				
				cp.setPersonNm(personNm);
				cp.setPersonEmail(personEmail);
				cp.setPersonHpno(personHpno);
				cp.setPersonTelno(personTelno);
				cp.setPersonNote(personNote);
				
				custPersonList.add(cp);
			}
		}
		
		List<FileVO> result = null;
		String atchFileId = "";
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "CST_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		customer.setAtchFileId(atchFileId);
		
		custService.insertCustomer(customer, custPersonList);
		
		return "redirect:/cooperation/selectCustomerList.do";
	}
		
	@RequestMapping("/cooperation/updateCustomerView.do")
	public String updateCustomerView(@ModelAttribute("searchVO") CustomerVO customerVO, ModelMap model) throws Exception {

		CustomerVO result = custService.selectCustomer(customerVO);
		
		model.addAttribute("result", result);
		
		return "cooperation/coop_customerM";
	}
	
	@RequestMapping("/cooperation/updateCustomer.do")
	public String updateCustomer(final MultipartHttpServletRequest multiRequest, Customer customer,
			Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(multiRequest);
		
		customer.setUserNoMod(user.getNo());
		
		List<CustomerPerson> custPersonList = new ArrayList<CustomerPerson>();
		
		int personCnt = Integer.parseInt((String)commandMap.get("personCnt"));
		
		if (personCnt == 1) {
			CustomerPerson cp = new CustomerPerson();
			
			String personNm = (String)commandMap.get("personNm");
			String personEmail = (String)commandMap.get("personEmail");
			String personHpno = (String)commandMap.get("personHpno");
			String personTelno = (String)commandMap.get("personTelno");
			String personNote = (String)commandMap.get("personNote");
			
			cp.setCustId(customer.getCustId());
			cp.setPersonNm(personNm);
			cp.setPersonEmail(personEmail);
			cp.setPersonHpno(personHpno);
			cp.setPersonTelno(personTelno);
			cp.setPersonNote(personNote);
			
			custPersonList.add(cp);
			
		} else { // personCnt > 1
			for (int i=0; i<personCnt; i++) {
				CustomerPerson cp = new CustomerPerson();
				
				String personNm = ((String[])commandMap.get("personNm"))[i];
				String personEmail = ((String[])commandMap.get("personEmail"))[i];
				String personHpno = ((String[])commandMap.get("personHpno"))[i];
				String personTelno = ((String[])commandMap.get("personTelno"))[i];
				String personNote = ((String[])commandMap.get("personNote"))[i];
				
				cp.setCustId(customer.getCustId());
				cp.setPersonNm(personNm);
				cp.setPersonEmail(personEmail);
				cp.setPersonHpno(personHpno);
				cp.setPersonTelno(personTelno);
				cp.setPersonNote(personNote);
				
				custPersonList.add(cp);
			}
		}

		String atchFileId = customer.getAtchFileId();
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
				List<FileVO> result = fileUtil.parseFileInf(files, "BC_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				customer.setAtchFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "BC_", cnt, atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}
		
		custService.updateCustomer(customer, custPersonList);
		
		return "redirect:/cooperation/selectCustomerList.do";
	}
	
	@RequestMapping("/cooperation/deleteCustomer.do")
	public String deleteCustomer(final HttpServletRequest req, Customer customer,
			Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		if (user.isAdmin()) {
			customer.setUserNoMod(user.getNo());
			
			custService.deleteCustomer(customer);
		}
		return "redirect:/cooperation/selectCustomerList.do";
	}
	
	//상담관리 고객사 자동완성
	@RequestMapping(value={"/ajax/selectCustomerList.do"})
	public String selectCustomerListAjax(@ModelAttribute("searchVO") CustomerVO customerVO, ModelMap model) throws Exception {
		
		customerVO.setPageUnit(9999);
		customerVO.setPageSize(9999);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(customerVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(customerVO.getPageUnit());
		paginationInfo.setPageSize(customerVO.getPageSize());
	
		customerVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		customerVO.setLastIndex(paginationInfo.getLastRecordIndex());
		customerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<CustomerVO> resultList = custService.selectCustomerList(customerVO);
		
		model.addAttribute("resultList", resultList);
			
		return "/ajax/customerList";
	}
	
}
