package kms.com.support.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.app.service.ApprovalCommentVO;
import kms.com.app.service.ApprovalVO;
import kms.com.common.config.PathConfig;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.Task;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.Msn;
import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarReservationVO;
import kms.com.support.service.CarVO;
import kms.com.support.service.ResourceService;
import kms.com.support.service.TaxPublishService;
import kms.com.support.service.TaxPublishVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class TaxPublishController {

	@Resource(name = "KmsResourceService")
	private ResourceService resourceService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	@Resource(name = "KmsTaxPublishService")
	private TaxPublishService taxPublishService;
	
	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;
	
	@RequestMapping("/support/taxPublishL.do")
	public String selectTaxPublishL(@ModelAttribute("taxPublishVO") TaxPublishVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		/* 검색 조건 관련 내용 Start */
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("searchCompanyCd", searchVO.getSearchCompanyCd());

		param.put("searchSj", searchVO.getSearchSj());
		param.put("searchNm", searchVO.getSearchNm());
		param.put("userNm", searchVO.getUserNm());
		
		param.put("bondStatN", searchVO.getBondStatN());
		param.put("bondStatY", searchVO.getBondStatY());
		param.put("bondStatC", searchVO.getBondStatC());
		
		param.put("searchPrjId", searchVO.getSearchPrjId());
		
		if (commandMap.get("untilToday") != null && commandMap.get("untilToday").equals("Y"))
			param.put("searchDate", CalendarUtil.getToday());
		
		/*
		param.put("searchSj", commandMap.get("searchSj"));
		param.put("searchNm", commandMap.get("searchNm"));
		param.put("userNm", commandMap.get("userNm"));
		
		param.put("bondStatN", commandMap.get("bondStatN"));
		param.put("bondStatY", commandMap.get("bondStatY"));
		param.put("bondStatC", commandMap.get("bondStatC"));
		
		if (commandMap.get("untilToday") != null && commandMap.get("untilToday").equals("Y"))
			param.put("searchDate", CalendarUtil.getDate(CalendarUtil.getToday(), 7));		
		*/
		/* 검색 조건 관련 내용 End */
		
		/* 페이징 관련 내용 Start */
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
		/* 페이징 관련 내용 End */
		
		List<TaxPublishVO> resultList = taxPublishService.selectTaxPublishList(param);
		int totCnt = taxPublishService.selectTaxPublishListTotCnt(param);

		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
	
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List compList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("compList", compList);
		/*
		model.addAttribute("bondStatN", commandMap.get("bondStatN"));
		model.addAttribute("bondStatY", commandMap.get("bondStatY"));
		model.addAttribute("bondStatC", commandMap.get("bondStatC"));
		
		model.addAttribute("untilToday", commandMap.get("untilToday"));
		*/
		
		model.addAttribute("taxPublishVO", searchVO);
		
		return "support/sprt_taxPublishL";
	}
	
	@RequestMapping("/support/taxPublishW.do")
	public String taxPublishW(@ModelAttribute("taxPublishVO") TaxPublishVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		/* 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		return "support/sprt_taxPublishW";
	}
	
	@RequestMapping("/support/taxPublishI.do")
	public String insertTaxPublish(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			String jsonExpenseString, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		MemberVO user = SessionUtil.getMember(multiRequest);
		
		taxPublishVO.setJsonExpenseString(jsonExpenseString);
		taxPublishVO.setJsonProjectString(jsonProjectString);
		
		taxPublishVO.setWriterNo(user.getUserNo());
		
		if (taxPublishVO.getRepeat() != null && taxPublishVO.getRepeat().equals("Y")) {
			/* from부터 to까지 반복 발행 */
			String from = taxPublishVO.getPublishDate();
			String to = taxPublishVO.getPublishToDate();
			
			for (String date = from; date.compareTo(to) <= 0;) {				
				String day = date;
				int tmpAtDate = 1;
				if (taxPublishVO.getPublishAtDate() != null && !taxPublishVO.getPublishAtDate().equals(""))
					tmpAtDate = Integer.parseInt(taxPublishVO.getPublishAtDate());
				String atDay = date.substring(0, 6) + String.format("%02d", tmpAtDate);
				
				if (day.compareTo(atDay) > 0) {
					int month = Integer.parseInt(date.substring(4, 6)) + 1;
					date = date.substring(0, 4) + String.format("%02d", month) + "01";
					continue;
				}
				
				boolean overMonth = false;
				boolean overToDate = false;
				while (day.compareTo(atDay) < 0 && !overToDate && !overMonth) {
					
					String tmp = day;
					day = CalendarUtil.getDate(day, 1);
					if (!tmp.substring(4, 6).equals(day.substring(4, 6))) {
						day = tmp;
						overMonth = true;
					}					
					if (day.compareTo(to) > 0)
						overToDate = true;
				}
				if (overToDate)
					break;
				
				date = day;
				
				taxPublishVO.setPublishDate(date);
				
				/* 파일 첨부 Start */
				List<FileVO> result = null;
				String atchFileId = "";
				
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				if (!files.isEmpty()) {
					result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
					atchFileId = fileMngService.insertFileInfs(result);
				}
				taxPublishVO.setAtchFileId(atchFileId);
				/* 파일 첨부 End */
				
				taxPublishService.insertTaxPublishList(taxPublishVO);
				
				int month = Integer.parseInt(date.substring(4, 6)) + 1;
				int year = Integer.parseInt(date.substring(0, 4));
				if (month == 13) {
					month = 1;
					year = year + 1;
				}
				date = year + String.format("%02d", month) + "01";
			}
			
			String date = CalendarUtil.getDate(taxPublishVO.getPublishDate(), -1);
			
			TaxPublishVO t = taxPublishVO;
			String params = "";
			params = params + "?bondStatN=" + t.getBondStatN();
			params = params + "&bondStatY=" + t.getBondStatY();
			params = params + "&bondStatC=" + t.getBondStatC();
			params = params + "&untilToday=" + t.getUntilToday();
			params = params + "&searchSj=" + URLEncoder.encode(t.getSearchSj(), "UTF-8");
			params = params + "&userNm=" + URLEncoder.encode(t.getUserNm(), "UTF-8");
			params = params + "&searchNm=" + URLEncoder.encode(t.getSearchNm(), "UTF-8");
			params = params + "&searchCompanyCd=" + URLEncoder.encode(t.getSearchCompanyCd(), "UTF-8");
			params = params + "&pageIndex=" + Integer.toString(t.getPageIndex());

			return "redirect:/support/taxPublishL.do" + params;
		} else {
			/* 파일 첨부 Start */
			List<FileVO> result = null;
			String atchFileId = "";
			
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}
			taxPublishVO.setAtchFileId(atchFileId);
			/* 파일 첨부 End */
			
			taxPublishService.insertTaxPublishList(taxPublishVO);
			
			TaxPublishVO t = taxPublishVO;
			String params = "";
			params = params + "&bondStatN=" + t.getBondStatN();
			params = params + "&bondStatY=" + t.getBondStatY();
			params = params + "&bondStatC=" + t.getBondStatC();
			params = params + "&untilToday=" + t.getUntilToday();
			params = params + "&searchSj=" + URLEncoder.encode(t.getSearchSj(), "UTF-8");
			params = params + "&userNm=" + URLEncoder.encode(t.getUserNm(), "UTF-8");
			params = params + "&searchNm=" + URLEncoder.encode(t.getSearchNm(), "UTF-8");
			params = params + "&searchCompanyCd=" + URLEncoder.encode(t.getSearchCompanyCd(), "UTF-8");
			params = params + "&pageIndex=" + Integer.toString(t.getPageIndex());
			
			return "redirect:/support/taxPublishV.do?bondId=" + taxPublishVO.getBondId() + params;
		}
	}
	
	@RequestMapping("/support/taxPublishV.do")
	public String selectTaxPublishV(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bondId", commandMap.get("bondId"));
		
		TaxPublishVO result = taxPublishService.selectTaxPublish(param);
		List<TaxPublishVO> resultExpenseList = taxPublishService.selectBondExpenseList(param);
		List<TaxPublishVO> resultProjectList = taxPublishService.selectBondProjectList(param);
		
		/* 공급가액, 세액, 총액 관련 Start */
		long supSum = 0;
		long taxSum = 0;
		long pubSum = 0;
		for (int i = 0; i < resultExpenseList.size(); i++) {
			long supExp = resultExpenseList.get(i).getSupplyExpense();
			long taxExp = resultExpenseList.get(i).getTaxExpense();
			supSum = supSum + supExp;
			taxSum = taxSum + taxExp;
			pubSum = pubSum + supExp + taxExp;
		}
		result.setSupSum(supSum);
		result.setTaxSum(taxSum);
		result.setPubSum(pubSum);
		/* 공급가액, 세액, 총액 관련 End */
		
		model.addAttribute("taxPublishVO", taxPublishVO);
		model.addAttribute("result", result);
		model.addAttribute("resultExpenseList", resultExpenseList);
		model.addAttribute("resultProjectList", resultProjectList);
		
		return "support/sprt_taxPublishV";
	}
	
	@RequestMapping("/support/taxPublishRW.do")
	public String selectTaxPublishRW(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		/* 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bondId", commandMap.get("bondId"));
		
		TaxPublishVO result = taxPublishService.selectTaxPublish(param);
		List<TaxPublishVO> resultExpenseList = taxPublishService.selectBondExpenseList(param);
		List<TaxPublishVO> resultProjectList = taxPublishService.selectBondProjectList(param);
		
		/* 공급가액, 세액, 총액 관련 Start */
		long supSum = 0;
		long taxSum = 0;
		long pubSum = 0;
		for (int i = 0; i < resultExpenseList.size(); i++) {
			long supExp = resultExpenseList.get(i).getSupplyExpense();
			long taxExp = resultExpenseList.get(i).getTaxExpense();
			supSum = supSum + supExp;
			taxSum = taxSum + taxExp;
			pubSum = pubSum + supExp + taxExp;
		}
		result.setSupSum(supSum);
		result.setTaxSum(taxSum);
		result.setPubSum(pubSum);
		/* 공급가액, 세액, 총액 관련 End */
		
		model.addAttribute("taxPublishVO", taxPublishVO);
		model.addAttribute("result", result);
		model.addAttribute("resultExpenseList", resultExpenseList);
		model.addAttribute("resultExpenseCnt", resultExpenseList.size());
		model.addAttribute("resultProjectList", resultProjectList);
		model.addAttribute("resultProjectCnt", resultProjectList.size());
		
		return "support/sprt_taxPublishRW";
	}
	
	@RequestMapping("/support/taxPublishRI.do")
	public String reInsertTaxPublish(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			MultipartHttpServletRequest multiRequest, HttpServletRequest request, HttpServletResponse response,
			String jsonExpenseString, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
				
		taxPublishVO.setJsonExpenseString(jsonExpenseString);
		taxPublishVO.setJsonProjectString(jsonProjectString);
		
		/* 파일첨부 Start */
		String atchFileId = taxPublishVO.getAtchFileId();

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
		if (atchFileId == null || "".equals(atchFileId) ) {
			List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
			atchFileId = fileMngService.insertFileInfs(result);
			taxPublishVO.setAtchFileId(atchFileId);
		} else {
			FileVO fvo = new FileVO();
			fvo.setAtchFileId(atchFileId);
			int cnt = fileMngService.getMaxFileSN(fvo);
			List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
			fileMngService.updateFileInfs(_result);
		}
		}
		/* 파일첨부 End */
		
		MemberVO user = SessionUtil.getMember(multiRequest);
		taxPublishVO.setWriterNo(user.getUserNo());
		
		taxPublishService.insertTaxPublishList(taxPublishVO);
		
		TaxPublishVO t = taxPublishVO;
		String params = "";
		params = params + "&bondStatN=" + t.getBondStatN();
		params = params + "&bondStatY=" + t.getBondStatY();
		params = params + "&bondStatC=" + t.getBondStatC();
		params = params + "&untilToday=" + t.getUntilToday();
		params = params + "&searchSj=" + URLEncoder.encode(t.getSearchSj(), "UTF-8");
		params = params + "&userNm=" + URLEncoder.encode(t.getUserNm(), "UTF-8");
		params = params + "&searchNm=" + URLEncoder.encode(t.getSearchNm(), "UTF-8");
		params = params + "&searchCompanyCd=" + URLEncoder.encode(t.getSearchCompanyCd(), "UTF-8");
		params = params + "&pageIndex=" + Integer.toString(t.getPageIndex());
		
		return "redirect:/support/taxPublishV.do?bondId=" + taxPublishVO.getBondId() + params;
	}
	
	@RequestMapping("/support/taxPublishM.do")
	public String selectTaxPublishM(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		/* 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bondId", commandMap.get("bondId"));
		
		TaxPublishVO result = taxPublishService.selectTaxPublish(param);
		List<TaxPublishVO> resultExpenseList = taxPublishService.selectBondExpenseList(param);
		List<TaxPublishVO> resultProjectList = taxPublishService.selectBondProjectList(param);
		
		/* 공급가액, 세액, 총액 관련 Start */
		long supSum = 0;
		long taxSum = 0;
		long pubSum = 0;
		for (int i = 0; i < resultExpenseList.size(); i++) {
			long supExp = resultExpenseList.get(i).getSupplyExpense();
			long taxExp = resultExpenseList.get(i).getTaxExpense();
			supSum = supSum + supExp;
			taxSum = taxSum + taxExp;
			pubSum = pubSum + supExp + taxExp;
		}
		result.setSupSum(supSum);
		result.setTaxSum(taxSum);
		result.setPubSum(pubSum);
		/* 공급가액, 세액, 총액 관련 End */
		
		model.addAttribute("taxPublishVO", taxPublishVO);
		model.addAttribute("result", result);
		model.addAttribute("resultExpenseList", resultExpenseList);
		model.addAttribute("resultExpenseCnt", resultExpenseList.size());
		model.addAttribute("resultProjectList", resultProjectList);
		model.addAttribute("resultProjectCnt", resultProjectList.size());
		
		return "support/sprt_taxPublishM";
	}
	
	@RequestMapping("/support/taxPublishU.do")
	public String updateTaxPublish(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			MultipartHttpServletRequest multiRequest, HttpServletRequest request, HttpServletResponse response,
			String jsonExpenseString, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		/* 수정하려는 세금계산서가  미발행 상태인지 검사합니다. Start */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bondId", commandMap.get("bondId"));
		
		TaxPublishVO chkPublishStat = taxPublishService.selectTaxPublish(param);
		
		if (!chkPublishStat.getBondStat().equals("N") && !chkPublishStat.getBondStat().equals("C")) {
			model.addAttribute("message","미발행 상태의 세금계산서만 수정할 수 있습니다.");
			model.addAttribute("redirectUrl", "/support/taxPublishV.do?bondId=" + taxPublishVO.getBondId());
			return "error/messageRedirect";
		}
		/* 수정하려는 세금계산서가  미발행 상태인지 검사합니다. End */
		
		taxPublishVO.setJsonExpenseString(jsonExpenseString);
		taxPublishVO.setJsonProjectString(jsonProjectString);
		
		/* 파일첨부 Start */
		String atchFileId = taxPublishVO.getAtchFileId();

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
		if (atchFileId == null || "".equals(atchFileId) ) {
			List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
			atchFileId = fileMngService.insertFileInfs(result);
			taxPublishVO.setAtchFileId(atchFileId);
		} else {
			FileVO fvo = new FileVO();
			fvo.setAtchFileId(atchFileId);
			int cnt = fileMngService.getMaxFileSN(fvo);
			List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
			fileMngService.updateFileInfs(_result);
		}
		}
		/* 파일첨부 End */
		
		taxPublishService.updateTaxPublishList(taxPublishVO);
		
		TaxPublishVO t = taxPublishVO;
		String params = "";
		params = params + "&bondStatN=" + t.getBondStatN();
		params = params + "&bondStatY=" + t.getBondStatY();
		params = params + "&bondStatC=" + t.getBondStatC();
		params = params + "&untilToday=" + t.getUntilToday();
		params = params + "&searchSj=" + URLEncoder.encode(t.getSearchSj(), "UTF-8");
		params = params + "&userNm=" + URLEncoder.encode(t.getUserNm(), "UTF-8");
		params = params + "&searchNm=" + URLEncoder.encode(t.getSearchNm(), "UTF-8");
		params = params + "&searchCompanyCd=" + URLEncoder.encode(t.getSearchCompanyCd(), "UTF-8");
		params = params + "&pageIndex=" + Integer.toString(t.getPageIndex());
		
		return "redirect:/support/taxPublishV.do?bondId=" + taxPublishVO.getBondId() + params;
	}
	
	@RequestMapping("/support/taxPublishD.do")
	public String deleteTaxPublish(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			HttpServletRequest request, HttpServletResponse response,
			String jsonExpenseString, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		taxPublishService.deleteTaxPublishList(taxPublishVO);
		
		TaxPublishVO t = taxPublishVO;
		String params = "";
		params = params + "?bondStatN=" + t.getBondStatN();
		params = params + "&bondStatY=" + t.getBondStatY();
		params = params + "&bondStatC=" + t.getBondStatC();
		params = params + "&untilToday=" + t.getUntilToday();
		params = params + "&searchSj=" + URLEncoder.encode(t.getSearchSj(), "UTF-8");
		params = params + "&userNm=" + URLEncoder.encode(t.getUserNm(), "UTF-8");
		params = params + "&searchNm=" + URLEncoder.encode(t.getSearchNm(), "UTF-8");
		params = params + "&searchCompanyCd=" + URLEncoder.encode(t.getSearchCompanyCd(), "UTF-8");
		params = params + "&pageIndex=" + Integer.toString(t.getPageIndex());
		
		return "redirect:/support/taxPublishL.do" + params;
	}
	
	@RequestMapping("/support/taxPublishProjectM.do")
	public String selectTaxProjectM(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bondId", commandMap.get("bondId"));
		
		TaxPublishVO result = taxPublishService.selectTaxPublish(param);
		List<TaxPublishVO> resultExpenseList = taxPublishService.selectBondExpenseList(param);
		List<TaxPublishVO> resultProjectList = taxPublishService.selectBondProjectList(param);
		
		/* 공급가액, 세액, 총액 관련 Start */
		long supSum = 0;
		long taxSum = 0;
		long pubSum = 0;
		for (int i = 0; i < resultExpenseList.size(); i++) {
			long supExp = resultExpenseList.get(i).getSupplyExpense();
			long taxExp = resultExpenseList.get(i).getTaxExpense();
			supSum = supSum + supExp;
			taxSum = taxSum + taxExp;
			pubSum = pubSum + supExp + taxExp;
		}
		result.setSupSum(supSum);
		result.setTaxSum(taxSum);
		result.setPubSum(pubSum);
		/* 공급가액, 세액, 총액 관련 End */
		
		model.addAttribute("taxPublishVO", taxPublishVO);
		model.addAttribute("result", result);
		model.addAttribute("resultExpenseList", resultExpenseList);
		model.addAttribute("resultProjectList", resultProjectList);
		model.addAttribute("resultProjectCnt", resultProjectList.size());
		
		return "support/sprt_taxPublishProjectM";
	}
	
	@RequestMapping("/support/taxPublishProjectU.do")
	public String updateTaxPublishProject(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			HttpServletRequest request, HttpServletResponse response, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		taxPublishVO.setJsonProjectString(jsonProjectString);
		
		taxPublishService.updateTaxPublishProjectList(taxPublishVO);
		
		TaxPublishVO t = taxPublishVO;
		String params = "";
		params = params + "&bondStatN=" + t.getBondStatN();
		params = params + "&bondStatY=" + t.getBondStatY();
		params = params + "&bondStatC=" + t.getBondStatC();
		params = params + "&untilToday=" + t.getUntilToday();
		params = params + "&searchSj=" + URLEncoder.encode(t.getSearchSj(), "UTF-8");
		params = params + "&userNm=" + URLEncoder.encode(t.getUserNm(), "UTF-8");
		params = params + "&searchNm=" + URLEncoder.encode(t.getSearchNm(), "UTF-8");
		params = params + "&searchCompanyCd=" + URLEncoder.encode(t.getSearchCompanyCd(), "UTF-8");
		params = params + "&pageIndex=" + Integer.toString(t.getPageIndex());
		
		return "redirect:/support/taxPublishV.do?bondId=" + taxPublishVO.getBondId() + params;
	}
	
	@RequestMapping("/support/taxPublishStateU.do")
	public String updateTaxPublishState(@ModelAttribute("taxPublishVO") TaxPublishVO taxPublishVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{

		MemberVO user = SessionUtil.getMember(request);
		taxPublishVO.setFnshUserNo(user.getUserNo());
		
		taxPublishService.updateTaxPublishState(taxPublishVO);
		
		TaxPublishVO t = taxPublishVO;
		String params = "";
		params = params + "&bondStatN=" + t.getBondStatN();
		params = params + "&bondStatY=" + t.getBondStatY();
		params = params + "&bondStatC=" + t.getBondStatC();
		params = params + "&untilToday=" + t.getUntilToday();
		params = params + "&searchSj=" + URLEncoder.encode(t.getSearchSj(), "UTF-8");
		params = params + "&userNm=" + URLEncoder.encode(t.getUserNm(), "UTF-8");
		params = params + "&searchNm=" + URLEncoder.encode(t.getSearchNm(), "UTF-8");
		params = params + "&searchCompanyCd=" + URLEncoder.encode(t.getSearchCompanyCd(), "UTF-8");
		params = params + "&pageIndex=" + Integer.toString(t.getPageIndex());
		
		return "redirect:/support/taxPublishV.do?bondId=" + taxPublishVO.getBondId() + params;
	}
}
