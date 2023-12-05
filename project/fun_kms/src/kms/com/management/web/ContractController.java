package kms.com.management.web;

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
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.management.service.ContractService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.support.service.TaxPublishService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ContractController {

	@Resource(name="KmsContractService")
	private ContractService contractService;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;
    
	@Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;
	
	@RequestMapping("/management/contractL.do")
	public String selectContractList(Map<String, Object> commandMap
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		Map<String, Object> param = commandMap;

		param.put("pageUnit", propertyService.getInt("pageUnit_15"));
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		int pageIndex = 1;
		if (commandMap.get("pageIndex") != null && !commandMap.get("pageIndex").toString().equals(""))
			pageIndex = Integer.parseInt(commandMap.get("pageIndex").toString());
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		List resultList = contractService.selectContractList(param);
		model.addAttribute("resultList", resultList);
		
		int totCnt = contractService.selectContractListCnt(param);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageIndex", pageIndex);
		
		setSearchVO(commandMap, model);
		
		if (commandMap.get("searchTyp").equals("W"))
			return "management/mgmt_WinContractL";
		else if (commandMap.get("searchTyp").equals("O"))
			return "management/mgmt_OrdContractL";
		else
			return "management/mgmt_WinContractL";
	}
	
	@RequestMapping("/management/contractV.do")
	public String selectContract(Map<String, Object> commandMap
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		Map<String, Object> result = contractService.selectContract(commandMap);
		
		MemberVO user = SessionUtil.getMember(request);
		
		boolean readAuth = false;
		
		if (user.isAdmin() || user.isLeader())
			readAuth = true;
		
		if (!readAuth && user.getNo().equals(Integer.parseInt(result.get("userNo").toString())))
			readAuth = true;
		
		List authList = contractService.selectAuthList(commandMap);
		if (!readAuth) {
			for (int i = 0; i < authList.size(); i++) {
				Map<String, Object> auth = (Map<String, Object>) authList.get(i);
				if (user.getNo().equals(Integer.parseInt(auth.get("userNo").toString()))) {
					readAuth = true;
					break;
				}
			}
		}
		
		model.addAttribute("result", result);
		model.addAttribute("authList", authList);
		model.addAttribute("readAuth", readAuth);
		
		setSearchVO(commandMap, model);
		
		return "management/mgmt_ContractV";
	}
	
	@RequestMapping("/management/contractW.do")
	public String writeContract(Map<String, Object> commandMap
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		/* 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		model.addAttribute("typ", commandMap.get("typ"));
		
		setSearchVO(commandMap, model);
		
		return "management/mgmt_ContractW";
	}
	
	@RequestMapping("/management/contractI.do")
	public String insertContract(Map<String, Object> commandMap
			, MultipartHttpServletRequest multiRequest
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		/* 파일 첨부 Start */
		List<FileVO> result = null;
	    String atchFileId = "";
	    
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
	    	result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(result);
	    }
	    commandMap.put("atchFileId", atchFileId);
	    /* 파일 첨부 End */
		
	    MemberVO member = SessionUtil.getMember(multiRequest);
		commandMap.put("writerNo", member.getNo());
		contractService.insertContract(commandMap);
		
		setSearchVO(commandMap, model);
		
		return "redirect:/management/contractL.do?searchTyp=" + commandMap.get("searchTyp");
	}
	
	@RequestMapping("/management/contractD.do")
	public String deleteContract(Map<String, Object> commandMap
			, ModelMap model) throws Exception {
		
		contractService.deleteContract(commandMap);
		
		setSearchVO(commandMap, model);
		
		return "redirect:/management/contractL.do?searchTyp=" + commandMap.get("searchTyp");
	}
	
	@RequestMapping("/management/contractM.do")
	public String modifyContract(Map<String, Object> commandMap
			, ModelMap model) throws Exception {
		
		/* 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		Map<String, Object> result = contractService.selectContract(commandMap);
		
		model.addAttribute("result", result);
		
		setSearchVO(commandMap, model);
		
		return "management/mgmt_ContractM";
	}
	
	@RequestMapping("/management/contractU.do")
	public String updateContract(Map<String, Object> commandMap
			, MultipartHttpServletRequest multiRequest
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		// 실적신고여부만 업데이트 하는 경우 파일 첨부 안 함
		if (commandMap.get("resultRegister") == null || commandMap.get("resultRegister").toString().equals("")) {
			/* 파일첨부 Start */
			String atchFileId = commandMap.get("atchFileId").toString();
			
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				if (atchFileId == null || "".equals(atchFileId) ) {
					List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
					atchFileId = fileMngService.insertFileInfs(result);
					commandMap.put("atchFileId", atchFileId);
				} else {
					FileVO fvo = new FileVO();
					fvo.setAtchFileId(atchFileId);
					int cnt = fileMngService.getMaxFileSN(fvo);
					List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
					fileMngService.updateFileInfs(_result);
				}
			}
			/* 파일첨부 End */
		}
		
		contractService.updateContract(commandMap);
		
		return selectContract(commandMap, multiRequest, response, model);
	}
	
	@RequestMapping("/management/contractAuthList.do")
	public String selectContractAuthList(Map<String, Object> commandMap
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		return "management/mgmt_WinContractMgmt";
	}
	
	@RequestMapping("/management/insertAuthList.do")
	public String insertContractAuthList(Map<String, Object> commandMap
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		return "management/mgmt_WinContractMgmt";
	}
	
	@RequestMapping("/management/updateAuthList.do")
	public String updateContractAuthList(Map<String, Object> commandMap
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		contractService.updateAuthList(commandMap);
		
		return selectContract(commandMap, request, response, model);
	}
	/*
	private void setPageIndex(Map<String, Object> commandMap, ModelMap model) {
		int pageIndex = 1;
		if (commandMap.get("pageIndex") != null && !commandMap.get("pageIndex").toString().equals(""))
			pageIndex = Integer.parseInt(commandMap.get("pageIndex").toString());
		model.addAttribute("pageIndex", pageIndex);
	}
	*/
	private void setSearchVO(Map<String, Object> commandMap, ModelMap model) {
		
		String sj = "";
		String cn = "";
		String nm = "";
		String orgnztNm = "";
		String prjNm = "";
		int pageIndex = 1;
		String typ = "W";
		
		if (commandMap.get("searchSj") != null && !commandMap.get("searchSj").equals(""))
			sj = commandMap.get("searchSj").toString();
		if (commandMap.get("searchCn") != null && !commandMap.get("searchCn").equals(""))
			cn = commandMap.get("searchCn").toString();
		if (commandMap.get("searchNm") != null && !commandMap.get("searchNm").equals(""))
			nm = commandMap.get("searchNm").toString();
		if (commandMap.get("searchOrgnztNm") != null && !commandMap.get("searchOrgnztNm").equals(""))
			orgnztNm = commandMap.get("searchOrgnztNm").toString();
		if (commandMap.get("searchPrjNm") != null && !commandMap.get("searchPrjNm").equals(""))
			prjNm = commandMap.get("searchPrjNm").toString();
		if (commandMap.get("pageIndex") != null && !commandMap.get("pageIndex").toString().equals(""))
			pageIndex = Integer.parseInt(commandMap.get("pageIndex").toString());
		if (commandMap.get("searchTyp") != null && !commandMap.get("searchTyp").equals(""))
			typ = commandMap.get("searchTyp").toString();
		
		Map<String, Object> searchVO = new EgovMap();
		searchVO.put("searchSj", sj);
		searchVO.put("searchCn", cn);
		searchVO.put("searchNm", nm);
		searchVO.put("searchOrgnztNm", orgnztNm);
		searchVO.put("searchPrjNm", prjNm);
		searchVO.put("pageIndex", pageIndex);
		searchVO.put("searchTyp", typ);
		model.addAttribute("searchVO", searchVO);
	}
}
