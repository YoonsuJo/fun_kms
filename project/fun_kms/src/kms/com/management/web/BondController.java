package kms.com.management.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;

import kms.com.app.service.ApprovalVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.ProjectVO;
import kms.com.management.service.BondService;
import kms.com.management.service.BondVO;
import kms.com.management.service.FundService;
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
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BondController {

	@Resource(name="KmsBondService")
	private BondService bondService;
	
	@Resource(name = "projectService")
	private ProjectService projectService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "approvalService")
	private KmsApprovalService approvalService;
	
	@Resource(name = "KmsTaxPublishService")
	private TaxPublishService taxPublishService;
	
	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name="KmsFundService")
	private FundService fundService;
	
	@RequestMapping("/management/bondOrg.do")
	public String selectBondOrgSumList(@ModelAttribute("searchVO") BondVO bondVO, 
			HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		//setSearchDate(bondVO);
		
		MemberVO user = SessionUtil.getMember(request);
		bondVO.setSearchUserNo(user.getNo());

		List<BondVO> resultList = bondService.selectBondOrgSumList(bondVO);
		
		BondVO sumVO = new BondVO();
		
		for (BondVO vo : resultList) {
			sumVO.setSumExpense(sumVO.getSumExpense() + vo.getSumExpense());
			sumVO.setSumSales(sumVO.getSumSales() + vo.getSumSales());
			sumVO.setSumWillCollect(sumVO.getSumWillCollect() + vo.getSumWillCollect());
			sumVO.setSumCollection(sumVO.getSumCollection() + vo.getSumCollection());
			sumVO.setAccSumExpense(sumVO.getAccSumExpense() + vo.getAccSumExpense());
			sumVO.setAccSumWillCollect(sumVO.getAccSumWillCollect() + vo.getAccSumWillCollect());
			sumVO.setAccSumCollection(sumVO.getAccSumCollection() + vo.getAccSumCollection());
			sumVO.setAccSumSales(sumVO.getAccSumSales() + vo.getAccSumSales());
		}
		
		model.addAttribute("searchVO", bondVO);
		model.addAttribute("resultSum", sumVO);
		model.addAttribute("resultList", resultList);
		
		return "management/mgmt_BondOrgnzt";
	}
	
	@RequestMapping("/management/bondPrj.do")
	public String selectBondPrjSumList(@ModelAttribute("searchVO") BondVO bondVO, HttpServletRequest request, ModelMap model) throws Exception {
		
		//setSearchDate(bondVO);		
		MemberVO user = SessionUtil.getMember(request);
		bondVO.setSearchUserNo(user.getNo());		
		bondVO.setSearchOrgIdList(CommonUtil.makeValidIdList(bondVO.getSearchOrgId()));
		
		List<BondVO> resultList = bondService.selectBondPrjSumList(bondVO);	
		
		BondVO sumVO = new BondVO();		
		for (BondVO vo : resultList) {
			sumVO.setSumExpense(sumVO.getSumExpense() + vo.getSumExpense());
			sumVO.setSumSales(sumVO.getSumSales() + vo.getSumSales());
			sumVO.setSumWillCollect(sumVO.getSumWillCollect() + vo.getSumWillCollect());
			sumVO.setSumCollection(sumVO.getSumCollection() + vo.getSumCollection());
			sumVO.setAccSumExpense(sumVO.getAccSumExpense() + vo.getAccSumExpense());
			sumVO.setAccSumWillCollect(sumVO.getAccSumWillCollect() + vo.getAccSumWillCollect());
			sumVO.setAccSumCollection(sumVO.getAccSumCollection() + vo.getAccSumCollection());
			sumVO.setAccSumSales(sumVO.getAccSumSales() + vo.getAccSumSales());
		}
		
		model.addAttribute("searchVO", bondVO);
		model.addAttribute("resultSum", sumVO);
		model.addAttribute("resultList", resultList);
		
		return "management/mgmt_BondProject";
	}
	
	@RequestMapping("/management/bondTaxPublish.do")
	public String selectBondTaxPublish(@ModelAttribute("searchVO") BondVO bondVO, ModelMap model) throws Exception {
		
		//setSearchDate(bondVO);		
		List<BondVO> resultList = bondService.selectBondTaxPublish(bondVO);
		
		ProjectVO prjVO = new ProjectVO();
		prjVO.setPrjId(bondVO.getPrjId());
		ProjectVO projectVO = projectService.selectProjectView(prjVO);
		
		model.addAttribute("searchVO", bondVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("projectVO", projectVO);
		
		return "management/mgmt_BondTaxPublish";
	}
	
	@RequestMapping("/management/bondNoPublish.do")
	public String selectNoPublish(@ModelAttribute("searchVO") BondVO bondVO, ModelMap model) throws Exception {
				
		BondVO sumVO = bondService.selectBondPrjSum(bondVO);		
		List<BondVO> taxPublishList = bondService.selectBondTaxPublish(bondVO);
		
		model.addAttribute("searchVO", bondVO);
		model.addAttribute("resultSum", sumVO);
		model.addAttribute("taxPublishList", taxPublishList);
		
		return "management/mgmt_TaxNoPublish";
	}
	
	@RequestMapping("/management/ajax/salesBond.do")
	public String selectNoPublishAjax(Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("prjId", commandMap.get("prjId"));
		param.put("bondPrjNo", commandMap.get("bondPrjNo"));
		
		List<ApprovalVO> resultList = approvalService.selectBondSalesListAjax(param);
		model.addAttribute("resultList", resultList);
		
		return "management/include/bondSales_layer";
	}
	
	@RequestMapping("/management/ajax/taxPublishList.do")
	public String selectTaxPublishListAjax(BondVO bondVO, ModelMap model) throws Exception {
		
		//bondVO.setSearchMappingFlag("LIST");
		List<BondVO> taxPublishList = bondService.selectBondTaxPublish(bondVO);
		
		model.addAttribute("taxPublishList", taxPublishList);
		model.addAttribute("mode", "LIST");
		
		return "management/include/taxPublish";
	}
	
	@RequestMapping("/management/ajax/taxPublishDetail.do")
	public String selectTaxPublishDetailAjax(BondVO bondVO, ModelMap model) throws Exception {
		
		bondVO.setSearchMappingFlag("DETAIL");
		List<BondVO> taxPublishList = bondService.selectBondTaxPublish(bondVO);
		
		model.addAttribute("taxPublishList", taxPublishList);
		model.addAttribute("mode", "DETAIL");
		
		return "management/include/taxPublish";
	}
	
	@RequestMapping("/management/collectL.do")
	public String selectCollectL(@ModelAttribute("searchVO") BondVO bondVO, ModelMap model) throws Exception {
		
		BondVO searchVO = new BondVO();
		searchVO.setBondPrjNo(bondVO.getBondPrjNo());
		
		BondVO sumVO = bondService.selectBondCollectionSum(searchVO);
		List<BondVO> resultList = bondService.selectCollectionList(searchVO);
		
		model.addAttribute("resultSum", sumVO);
		model.addAttribute("resultList", resultList);
		
		return "management/mgmt_pop_collectL";
	}
	
	@RequestMapping("/management/collectW.do")
	public String selectCollectW(@ModelAttribute("searchVO") BondVO bondVO, ModelMap model) throws Exception {
		model.addAttribute("bondVO", bondVO);
		
		/* 상세코드 불러오기 Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS021");
		List typeList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("typeList", typeList);
		
		vo.setCodeId("KMS022");
		List accountList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("accountList", accountList);
		
		vo.setCodeId("KMS023");
		List bankBookList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("bankBookList", bankBookList);
		/* 상세코드 불러오기 End */
		
		// 회사구분을 불러옵니다. Start */
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		return "management/mgmt_pop_collectW";
	}
	
	@RequestMapping("/management/collectI.do")
	public String selectCollectI(@ModelAttribute("searchVO") BondVO bondVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		/* 자금보고건 자동 insert start */
		if (commandMap.get("fundAutoInsertCheck") != null && commandMap.get("fundAutoInsertCheck").toString().equals("Y"))
    	{
			String prjId = commandMap.get("prjId").toString();
			String date = commandMap.get("collectionDate").toString();
			String type = commandMap.get("type").toString();
			String expense = commandMap.get("expense").toString();
			String note = commandMap.get("note").toString();
    		String bankBook = commandMap.get("bankBook").toString();
    		String account = commandMap.get("account").toString();
    		String companyCd = commandMap.get("companyCd").toString();
			
    		Map<String, Object> param = new HashMap<String, Object>();
			
			param.put("date", date);
			param.put("type", type);
			param.put("account", account);
			param.put("bankBook", bankBook);
			param.put("expense", expense);
			param.put("prjId", prjId);
			param.put("note", note);
			param.put("companyCd", companyCd);
			
			fundService.insertFund(param);
			//TBL_FUND랑 연결하려면 미리 no 생성해서 입력후 bond_collection에 컬럼 추가해서 연결해줘야함 
    	}
		/* 자금보고건 자동 insert end */
		
		bondService.insertCollection(bondVO);
		
		return "redirect:/management/collectL.do?bondPrjNo=" + bondVO.getBondPrjNo() + "&prjId=" + bondVO.getPrjId();
	}
	
	@RequestMapping("/management/collectM.do")
	public String selectCollectM(@ModelAttribute("searchVO") BondVO bondVO, ModelMap model) throws Exception {
		
		//collectW.do 부분 시작
		model.addAttribute("bondVO", bondVO);
		
		/* 상세코드 불러오기 Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS021");
		List typeList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("typeList", typeList);
		
		vo.setCodeId("KMS022");
		List accountList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("accountList", accountList);
		
		vo.setCodeId("KMS023");
		List bankBookList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("bankBookList", bankBookList);
		/* 상세코드 불러오기 End */
		
		// 회사구분을 불러옵니다. Start */
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		//collectW.do 부분 시작 끝
			
		BondVO resultVO = bondService.selectCollection(bondVO);

		resultVO.setPrjId(bondVO.getPrjId());
		resultVO.setBondPrjNo(bondVO.getBondPrjNo());
		
		model.addAttribute("result", resultVO);
		
		return "management/mgmt_pop_collectM";
	}
	
	@RequestMapping("/management/collectU.do")
	public String selectCollectU(@ModelAttribute("searchVO") BondVO bondVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
	
		bondService.updateCollection(bondVO);
		/* 자금보고건 자동 insert start */
		/*
		if (commandMap.get("fundAutoInsertCheck") != null && commandMap.get("fundAutoInsertCheck").toString().equals("Y"))
    	{
			String prjId = commandMap.get("prjId").toString();
			String date = commandMap.get("collectionDate").toString();
			String type = commandMap.get("type").toString();
			String expense = commandMap.get("expense").toString();
			String note = commandMap.get("note").toString();
    		String bankBook = commandMap.get("bankBook").toString();
    		String account = commandMap.get("account").toString();
    		String companyCd = commandMap.get("companyCd").toString();
    		String fundNo = commandMap.get("fundNo").toString();
			
    		Map<String, Object> param = new HashMap<String, Object>();
			
    		//update 파라메터
			param.put("date", date);
			param.put("type", type);
			param.put("account", account);
			param.put("bankBook", bankBook);
			param.put("expense", expense);
			param.put("prjId", prjId);
			param.put("note", note);
			param.put("companyCd", companyCd);
			
			//update record 식별할 primary key 이걸 가져올 방법이 없네...
			param.put("fundNo", fundNo);

			//fundService.updateFund(param);
    	}
    	*/
		/* 자금보고건 자동 insert end */
		return "redirect:/management/collectL.do?bondPrjNo=" + bondVO.getBondPrjNo() + "&prjId=" + bondVO.getPrjId();
	}

	@RequestMapping("/management/collectD.do")
	public String selectCollectD(@ModelAttribute("searchVO") BondVO bondVO, ModelMap model) throws Exception {
		
		bondService.deleteCollection(bondVO);
		
		return "redirect:/management/collectL.do?bondPrjNo=" + bondVO.getBondPrjNo() + "&prjId=" + bondVO.getPrjId();
	}
	
	@RequestMapping("/ajax/bondSalesList.do")
	public String bondSalesListAjax(@ModelAttribute("searchVO") ProjectVO projectVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("prjId", commandMap.get("prjId"));
		
		List<ApprovalVO> resultList = approvalService.selectBondSalesListAjax(param);

		model.addAttribute("resultList", resultList);
		
		return "/management/include/bondSales";
	}
	
	@RequestMapping("/management/collectionFullL.do")
	public String selectCollectionFullL(@ModelAttribute("searchVO") BondVO bondVO,
			Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		Map<String, Object> param = commandMap;
		
		if (param.get("startDate") == null || param.get("startDate").equals(""))
			param.put("startDate", CalendarUtil.getToday().substring(0,6) + "01");
		if (param.get("endDate") == null || param.get("endDate").equals(""))
			param.put("endDate", CalendarUtil.getToday().substring(0,8));
		
		if (bondVO.getSearchOrgId() != null && !bondVO.getSearchOrgId().equals(""))
			param.put("searchOrgIdList", CommonUtil.makeValidIdList(bondVO.getSearchOrgId()));
		else
			param.put("searchOrgId", "");

		param.put("pageUnit", 50);
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		int pageIndex = 1;
		if (param.get("pageIndex") != null && !param.get("pageIndex").toString().equals(""))
			pageIndex = Integer.parseInt(param.get("pageIndex").toString());
		param.put("pageIndex", pageIndex);
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		List resultList = bondService.selecCollectionFullList(param);
		model.addAttribute("resultList", resultList);
		
		int totCnt = bondService.selecCollectionFullListCnt(param);
		paginationInfo.setTotalRecordCount(totCnt);
		long totResSum = bondService.selecCollectionFullListSum(param);
		model.addAttribute("totResSum", totResSum);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", param);
		
		return "management/mgmt_CollectionL";
	}
	
	@RequestMapping(value="/management/collectionExcelW.do")
    public String writeCollectionExcel(@ModelAttribute("searchVO") BondVO bondVO,
			Map<String, Object> commandMap, ModelMap model)
    throws Exception {
    	
    	return "/management/mgmt_CollectionExcelW";
    }
	
    @RequestMapping(value="/management/collectionExcelI.do")
    public String insertCollectionExcel(final MultipartHttpServletRequest multiRequest,
    		ModelMap model)
    throws Exception {
    	
    	List<FileVO> result = null;
    	String atchFileId = "";
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "COLL_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		Workbook workbook = Workbook.getWorkbook(new File(result.get(0).getFileStreCours() + result.get(0).getStreFileNm()));
		List list = bondService.insertCollectionExcel(workbook);
		
		model.addAttribute("excelList", list);
		
		/* 상세코드 불러오기 Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS021");
		List typeList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("typeList", typeList);
		
		vo.setCodeId("KMS022");
		List accountList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("accountList", accountList);
		
		vo.setCodeId("KMS023");
		List bankBookList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("bankBookList", bankBookList);
		/* 상세코드 불러오기 End */
		
		// 회사구분을 불러옵니다. Start */
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		return "/management/mgmt_CollectionTableW";
    }

    @RequestMapping(value="/management/collectionTableI.do")
    public String insertCollectionTable(@ModelAttribute("searchVO") BondVO bondVO,
    		Map<String, Object> commandMap, ModelMap model)
    throws Exception {
    	
    	bondService.insertCollectionTable(commandMap);
    	
    	int collectionLength = Integer.parseInt(commandMap.get("collectionLength").toString());
    	
    	/* 자금보고건 자동 insert start */
    	if (commandMap.get("fundAutoInsertCheck") != null && commandMap.get("fundAutoInsertCheck").toString().equals("Y"))
    	{
    		if (collectionLength >= 2)
    		{
    			String[] checkList = (String[]) commandMap.get("checkList");
    			String[] prjIdList = (String[]) commandMap.get("insertBondPrjId");
    			String[] dateList = (String[]) commandMap.get("collectionDate");
    			String[] typeList = (String[]) commandMap.get("type");
    			String[] expenseList = (String[]) commandMap.get("insertExpense");
    			String[] noteList = (String[]) commandMap.get("note");
        		String bankBook = commandMap.get("bankBook").toString();
        		String[] accountList = (String[]) commandMap.get("account");
        		String companyCd = commandMap.get("companyCd").toString();
    			
    			for (int i = 0; i < checkList.length; i++) {
    				
    				if (!checkList[i].toString().equals("on"))
    					continue;
    				
    				Map<String, Object> param = new HashMap<String, Object>();
    				
    				param.put("date", dateList[i]);
    				param.put("type", typeList[i]);
    				param.put("account", accountList[i]);
    				param.put("bankBook", bankBook);
    				if (typeList[i].equals("W") || typeList[i].equals("RW"))
    					expenseList[i] = Integer.parseInt((-1 * Long.parseLong(expenseList[i])) + "") + "";
    				param.put("expense", expenseList[i]);
    				param.put("prjId", prjIdList[i]);
    				param.put("note", noteList[i]);
    				param.put("companyCd", companyCd);
    				
    				fundService.insertFund(param);
    			}
    		}
    		else if (collectionLength == 1)
    		{
    			String prjId = commandMap.get("insertBondPrjId").toString();
    			String date = commandMap.get("collectionDate").toString();
    			String type = commandMap.get("type").toString();
    			String expense = commandMap.get("insertExpense").toString();
    			String note = commandMap.get("note").toString();
        		String bankBook = commandMap.get("bankBook").toString();
        		String account = commandMap.get("account").toString();
        		String companyCd = commandMap.get("companyCd").toString();
    			
        		Map<String, Object> param = new HashMap<String, Object>();
				
				param.put("date", date);
				param.put("type", type);
				param.put("account", account);
				param.put("bankBook", bankBook);
				if (type.equals("W") || type.equals("RW"))
					expense = Integer.parseInt((-1 * Long.parseLong(expense)) + "") + "";
				param.put("expense", expense);
				param.put("prjId", prjId);
				param.put("note", note);
				param.put("companyCd", companyCd);
				
				fundService.insertFund(param);
    		}
    	}
    	/* 자금보고건 자동 insert end */
    	
    	String max = "19000101";
    	String min = "29991231";
    	if (collectionLength >= 2)
		{
    		String[] collectionDateList = (String[]) commandMap.get("collectionDate");
        	for (int i = 0; i < collectionDateList.length; i++) {
        		if (max.compareTo(collectionDateList[i]) < 0)
        			max = collectionDateList[i];
        		if (min.compareTo(collectionDateList[i]) > 0)
        			min = collectionDateList[i];
        	}
		}
    	else if (collectionLength == 1)
    	{
    		max = commandMap.get("collectionDate").toString();
    		min = commandMap.get("collectionDate").toString();
    	}
    	else
    		;
    	
    	return "redirect:/management/collectionFullL.do?startDate=" + min + "&endDate=" + max;
    }
    
    // 매출보고서 - 세금계산서 매핑 데이터 삽입 
    @RequestMapping("/management/ajax/insertSalesBond.do")
	public String insertSalesBondjax(String docId, String strBondPrjNo, HttpServletRequest req) throws Exception {
		
    	MemberVO user = SessionUtil.getMember(req);
    	
		BondVO bondVO = new BondVO();
		bondVO.setDocId(docId);
		bondVO.setRegUserNo(user.getUserNo());
		
		String[] arrBondPrjNo = strBondPrjNo.split(",");
		for (String bondPrjNo: arrBondPrjNo) {
			bondVO.setBondPrjNo(Integer.parseInt(bondPrjNo));
			//bondService.selectBondTaxPublish(bondVO);
			bondService.insertSalesBond(bondVO);
		}
		return "success";
	}
    
    // 매출보고서 - 세금계산서 매핑 데이터 삽입 
    @RequestMapping("/management/ajax/deleteSalesBond.do")
	public String selectTaxPublishAjax(BondVO bondVO) throws Exception {
    	bondService.deleteSalesBond(bondVO);
		return "success";
	}
}
