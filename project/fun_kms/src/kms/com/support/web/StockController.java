package kms.com.support.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.service.CommonService;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.management.service.FundVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.ResourceService;
import kms.com.support.service.Stock;
import kms.com.support.service.StockService;
import kms.com.support.service.StockVO;

import oracle.sql.DATE;

import org.bouncycastle.asn1.x509.qualified.TypeOfBiometricData;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class StockController {

	@Resource(name = "KmsResourceService")
	private ResourceService resourceService;

	@Resource(name = "KmsStockService")
	private StockService stockService;

	@Resource(name = "KmsMemberService")
	MemberService memberService;

	@Resource(name = "KmsCommonService")
	private CommonService commonService;

	@RequestMapping("/support/stockW.do")
	public String writeStock(ModelMap model) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		List categoryList = stockService.selectStockCategory(param);
		List itemList = stockService.selectStockItem(param);

		MemberVO memberVO = new MemberVO();
		memberVO.setWorkStList(new String[] { "W" });
		memberVO.setOrderBy("name");

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("itemList", itemList);
		model.addAttribute("today", CalendarUtil.getToday());
		model.addAttribute("memList", memberService.selectMemberList(memberVO));

		return "support/sprt_stockW";
	}

	@RequestMapping("/support/stockI.do")
	public String insertStock(@ModelAttribute("searchVO") Stock stock,
			Map<String, Object> commandMap, ModelMap model) throws Exception {

		stockService.insertStock(commandMap);

		return "redirect:/support/stockW.do";
	}

	@RequestMapping("/support/stockM.do")
	public String modifyStock(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		List categoryList = stockService.selectStockCategory(param);
		List itemList = stockService.selectStockItem(param);

		MemberVO memberVO = new MemberVO();
		memberVO.setWorkStList(new String[] { "W" });
		memberVO.setOrderBy("name");

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("itemList", itemList);
		model.addAttribute("memList", memberService.selectMemberList(memberVO));

		Map<String, Object> result = stockService.selectStock(commandMap);
		model.addAttribute("result", result);

		return "support/sprt_stockM";
	}

	@RequestMapping("/support/stockU.do")
	public String updateStock(Map<String, Object> commandMap, ModelMap model)
			throws Exception {
		
		String err = "";
		if (commandMap.get("oldOne").toString().equals(commandMap.get("serialNo").toString())
				|| stockService.checkStockSerialNo(commandMap) == 0)
			stockService.updateStock(commandMap);
		else
			err = "&err=Y";

		return "redirect:/support/stockHistoryL.do?itemCode=" + commandMap.get("itemCode") + "&stockNo=" + commandMap.get("stockNo") + err;
	}

	@RequestMapping("/support/stockS.do")
	public String saveTempStock(Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		int stockLength = Integer.parseInt(commandMap.get("stockLength").toString());

		MemberVO user = SessionUtil.getMember(req);
		commandMap.put("tempSaverNo", user.getNo());

		if (stockLength == 1) {
			commandMap.put("stockNo", commandMap.get("saveStockNo"));
			stockService.updateStock(commandMap);
		} else if (stockLength >= 2) {
			String[] stockNoList = (String[]) commandMap.get("saveStockNo");

			for (int i = 0; i < stockNoList.length; i++) {
				commandMap.put("stockNo", stockNoList[i]);
				stockService.updateStock(commandMap);
			}
		}

		return "redirect:/support/stockR.do";
	}

	@RequestMapping("/support/stockR.do")
	public String releaseWriteStock(Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		MemberVO user = SessionUtil.getMember(req);
		param.put("tempSaverNo", user.getNo());

		List resultList = stockService.selectStockList(param);

		model.addAttribute("resultList", resultList);

		MemberVO memberVO = new MemberVO();
		memberVO.setWorkStList(new String[] { "W" });
		memberVO.setOrderBy("name");

		model.addAttribute("memList", memberService.selectMemberList(memberVO));

		model.addAttribute("today", CalendarUtil.getToday());

		Map<String, Object> codeParam = new HashMap<String, Object>();
		codeParam.put("codeId", "KMS026");
		List statusList = commonService.selectComtccmmndetailcode(codeParam);

		model.addAttribute("statusList", statusList);

		return "support/sprt_stockR";
	}

	@RequestMapping("/support/stockRU.do")
	public String releaseStock(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		int stockLength = Integer.parseInt(commandMap.get("stockLength").toString());

		if (stockLength == 1) {
			commandMap.put("tempSaverNo", -1);
			stockService.updateStock(commandMap);
			stockService.updateStockHistory(commandMap);
			stockService.insertStockHistory(commandMap);
		} else if (stockLength >= 2) {
			String[] stockNoList = (String[]) commandMap.get("stockNo");
			commandMap.put("tempSaverNo", -1);

			for (int i = 0; i < stockNoList.length; i++) {
				commandMap.put("stockNo", stockNoList[i]);
				stockService.updateStock(commandMap);
				stockService.updateStockHistory(commandMap);
				stockService.insertStockHistory(commandMap);
			}
		}

		return "redirect:/support/stockR.do";
	}

	@RequestMapping("/support/stockDS.do")
	public String deleteSavedStock(Map<String, Object> commandMap,
			ModelMap model) throws Exception {

		int stockLength = Integer.parseInt(commandMap.get("stockLength").toString());

		if (stockLength == 1) {
			String[] stockNoList = { "", "" };
			stockNoList[0] = commandMap.get("stockNo").toString();
			stockNoList[1] = commandMap.get("stockNo").toString();
			commandMap.put("stockNo", stockNoList);
			stockService.deleteSavedStock(commandMap);
		} else if (stockLength >= 2) {
			stockService.deleteSavedStock(commandMap);
		}

		return "redirect:/support/stockR.do";
	}

	@RequestMapping("/support/stockC.do")
	public String changeStock(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		List categoryList = stockService.selectStockCategory(commandMap);
		List itemList = stockService.selectStockItem(commandMap);

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("itemList", itemList);

		if (commandMap.get("searchType") == null)
			commandMap.put("searchType", "N");

		int searchStatusList[] = { 1, 2, 3, 4 };
		commandMap.put("searchStatusList", searchStatusList);

		List stockList = stockService.selectStockList(commandMap);

		model.addAttribute("stockList", stockList);

		model.addAttribute("searchVO", commandMap);

		MemberVO memberVO = new MemberVO();
		memberVO.setWorkStList(new String[] { "W" });
		memberVO.setOrderBy("name");

		model.addAttribute("memList", memberService.selectMemberList(memberVO));

		model.addAttribute("today", CalendarUtil.getToday());

		Map<String, Object> codeParam = new HashMap<String, Object>();
		codeParam.put("codeId", "KMS026");
		List statusList = commonService.selectComtccmmndetailcode(codeParam);

		model.addAttribute("statusList", statusList);

		return "/support/sprt_stockC";
	}

	@RequestMapping("/support/stockCU.do")
	public String changeUpdateStock(Map<String, Object> commandMap,
			ModelMap model) throws Exception {

		int stockLength = Integer.parseInt(commandMap.get("stockLength")
				.toString());

		if (stockLength == 1) {
			commandMap.put("tempSaverNo", -1);
			stockService.updateStock(commandMap);
			stockService.updateStockHistory(commandMap);
			stockService.insertStockHistory(commandMap);
		} else if (stockLength >= 2) {
			String[] stockNoList = (String[]) commandMap.get("stockNo");
			commandMap.put("tempSaverNo", -1);

			for (int i = 0; i < stockNoList.length; i++) {
				commandMap.put("stockNo", stockNoList[i]);
				stockService.updateStock(commandMap);
				stockService.updateStockHistory(commandMap);
				stockService.insertStockHistory(commandMap);
			}
		}

		return "redirect:/support/stockC.do";
	}

	@RequestMapping("/support/stockCategoryL.do")
	public String selectCategory(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		List resultList = stockService.selectStockCategory(commandMap);
		model.addAttribute("resultList", resultList);

		return "/support/sprt_stockCategoryL";
	}

	@RequestMapping("/support/stockCategoryW.do")
	public String writeCategory(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		return "/support/sprt_stockCategoryW";
	}

	@RequestMapping("/support/stockCategoryI.do")
	public String insertCategory(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		stockService.insertStockCategory(commandMap);

		return "redirect:/support/sprt_stockCategoryL";
	}

	@RequestMapping("/support/stockCategoryM.do")
	public String modifyCategory(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		List resultList = stockService.selectStockCategory(commandMap);
		model.addAttribute("result", resultList.get(0));

		return "/support/sprt_stockCategoryM";
	}

	@RequestMapping("/support/stockCategoryU.do")
	public String updateCategory(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		stockService.updateStockCategory(commandMap);

		return "redirect:/support/stockCategoryL.do";
	}

	@RequestMapping("/support/stockCategoryD.do")
	public String deleteCategory(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		stockService.deleteStockCategory(commandMap);

		return "redirect:/support/stockCategoryL.do";
	}

	@RequestMapping("/support/stockItemL.do")
	public String selectItem(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		List resultList = stockService.selectStockItem(commandMap);
		model.addAttribute("resultList", resultList);

		return "/support/sprt_stockItemL";
	}

	@RequestMapping("/support/stockItemW.do")
	public String writeItem(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		List categoryList = stockService.selectStockCategory(commandMap);
		model.addAttribute("categoryList", categoryList);

		return "/support/sprt_stockItemW";
	}

	@RequestMapping("/support/stockItemI.do")
	public String insertItem(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		stockService.insertStockItem(commandMap);

		return "redirect:/support/stockItemL.do";
	}

	@RequestMapping("/support/stockItemM.do")
	public String modifyItem(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		List categoryList = stockService.selectStockCategory(commandMap);
		model.addAttribute("categoryList", categoryList);

		List resultList = stockService.selectStockItem(commandMap);
		model.addAttribute("result", resultList.get(0));

		return "/support/sprt_stockItemM";
	}

	@RequestMapping("/support/stockItemU.do")
	public String updateItem(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		stockService.updateStockItem(commandMap);

		return "redirect:/support/stockItemL.do";
	}

	@RequestMapping("/support/stockItemD.do")
	public String deleteItem(Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		stockService.deleteStockItem(commandMap);

		return "redirect:/support/stockItemL.do";
	}

	@RequestMapping(value = { "/ajax/support/stockL.do" })
	public String selectStockListAjax(Map<String, Object> commandMap,
			ModelMap model) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		List resultList = stockService.selectStockListAjax(param);
		model.addAttribute("resultList", resultList);

		return "/support/include/stockL";
	}
	
	@RequestMapping(value={"/support/stockStatusL.do"})
    public String selectStockStatusList(Map<String, Object> commandMap, ModelMap model)
            throws Exception {
    	
		Map<String, Object> param = new HashMap<String, Object>();
		List resultList = stockService.selectStockStatusList(param);
		
		int totalAddPrice=0;
		
		Stock stock = new Stock();
		
		for(int i=0;i<resultList.size();i++){
			stock = (Stock)resultList.get(i);
			System.out.println("/support/stockStatusL.do - stock.getTotalPrice() = " + stock.getTotalPrice());
			totalAddPrice += Integer.parseInt(stock.getTotalPrice());
			System.out.println("/support/stockStatusL.do - totalAddPrice : " + totalAddPrice);
		}
			
		model.addAttribute("totalAddPrice",totalAddPrice);
		model.addAttribute("resultList", resultList);
		
		return "/support/sprt_stockStatusL";
    }
	
	@RequestMapping(value={"/support/stockSalesL.do"})
    public String selectStockSalesList(Map<String, Object> commandMap, ModelMap model)
            throws Exception {
    	
		Map<String, Object> param = new HashMap<String, Object>();
		List resultList = stockService.selectStockSalesList(param);
		int totalAddPrice=0;
		
		Stock stock = new Stock();
		
		for(int i=0;i<resultList.size();i++){
			stock = (Stock)resultList.get(i);
			System.out.println("/support/stockSalesL.do - stock.getTotalPrice() : " + stock.getTotalPrice());
			totalAddPrice += Integer.parseInt(stock.getTotalPrice());
			System.out.println("/support/stockSalesL.do - totalAddPrice : " + totalAddPrice);
		}
			
		model.addAttribute("totalAddPrice",totalAddPrice);
		model.addAttribute("resultList", resultList);
		
		return "/support/sprt_stockSalesL";
    }
	
	@RequestMapping(value={"/support/stockStatisticL.do"})
	public String selectStockStatistic(Map <String, Object> commandMap, ModelMap model) throws Exception {
		
		String searchYear = new SimpleDateFormat("yyyy").format(new Date()).toString();
		try {
			searchYear = commandMap.get("searchYear").toString();
		}
		catch (Exception e) {
			searchYear = new SimpleDateFormat("yyyy").format(new Date()).toString();
			commandMap.put("searchYear", searchYear);
		}		
		
		String type = commandMap.get("type").toString();
		if (type.equals("sale"))
		{
			model.addAttribute("subTitle",  "월별 판매 현황");
		}	
		else if (type.equals("buy"))
		{
			model.addAttribute("subTitle",  "월별 구매 현황");
		}
		else {
			model.addAttribute("subTitle",  "월별 재고 현황");
		}
		model.addAttribute("resultList", stockService.selectStockStatistic(commandMap));
		
		model.addAttribute("type", type);
		model.addAttribute("year", searchYear);
		
		return "/support/sprt_stockStatisticL";
	}
	
	@RequestMapping(value={"/support/stockStatsL.do"})
	public String selectStockStats(Map <String, Object> commandMap, ModelMap model) throws Exception {
		
		String subTitle = "";
		
		String type = "stock";
		try	{
			type = commandMap.get("type").toString();
		}
		catch(Exception e) {
			type = "stock";
		}		

		String year = new SimpleDateFormat("yyyy").format(new Date()).toString();
		try {
			year = commandMap.get("year").toString();
		}
		catch (Exception e) {
			year = new SimpleDateFormat("yyyy").format(new Date()).toString();
			commandMap.put("year", year);
		}		
		
		if("sell".equals(type)){
			model.addAttribute("resultList", stockService.selectStockStatsSell(commandMap));
			model.addAttribute("subTitle",  "월별 판매 현황");
		}	
		else if("buy".equals(type)) {
			model.addAttribute("resultList", stockService.selectStockStatsBuy(commandMap));
			model.addAttribute("subTitle",  "월별 구매 현황");
		}
		else {
			model.addAttribute("resultList", stockService.selectStockStatsStock(commandMap));
			model.addAttribute("subTitle",  "월별 재고 현황");
		}
		
		model.addAttribute("type", type);
		model.addAttribute("year", year);
		
		return "/support/sprt_stockStatsL";
	}

	@RequestMapping(value={"/support/stockL.do"})
	public String selectStockList(Map <String, Object> commandMap, ModelMap model) throws Exception {
		
		String searchType = "";
		if (commandMap.get("searchType") != null && !commandMap.get("searchType").equals(""))
			searchType = commandMap.get("searchType").toString();
		
		model.addAttribute("new", "new");
		
		if (searchType.equals("sale"))
		{
			Map<String, Object> param = new HashMap<String, Object>();
			List resultList = stockService.selectStockState(param);
			long totlaAddPrice = 0;
			for (int i = 0; i < resultList.size(); i++) {
				Map<String, Object> result = (Map<String, Object>) resultList.get(i);
				totlaAddPrice += Long.parseLong(result.get("totalSale").toString());
			}
				
			model.addAttribute("totalAddPrice",totlaAddPrice);
			model.addAttribute("resultList", resultList);
			
			return "/support/sprt_stockSalesL";
		}
		else if (searchType.equals("stock"))
		{
			Map<String, Object> param = new HashMap<String, Object>();
			List resultList = stockService.selectStockState(param);
			long totlaAddPrice = 0;
			for (int i = 0; i < resultList.size(); i++) {
				Map<String, Object> result = (Map<String, Object>) resultList.get(i);
				totlaAddPrice += Long.parseLong(result.get("totalPrice").toString());
			}
				
			model.addAttribute("totalAddPrice",totlaAddPrice);
			model.addAttribute("resultList", resultList);
			
			return "/support/sprt_stockStatusL";
		} 
		else //if (searchType.equals("all"))
		{
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("division", "H");
			List hardwareList = stockService.selectStockState(param);
			param.put("division", "S");
			List softwareList = stockService.selectStockState(param);
			
			model.addAttribute("hardware", hardwareList);
			model.addAttribute("software", softwareList);
			
			return "/support/sprt_stockStateTotalL";
		}
	}
	
	@RequestMapping("/support/stockStateTotalL.do")
	public String selectOldStockStateTotal(ModelMap model) throws Exception{
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("flag", "1");
		List hardware = stockService.selectOldStockStateTotal(param);
		param.put("flag", "2");
		List software = stockService.selectOldStockStateTotal(param);
		
		model.addAttribute("hardware", hardware);
		model.addAttribute("software", software);
		
		return "/support/sprt_stockStateTotalL";
	}
	
	@RequestMapping("/support/stockDetailList.do")
	public String selectStockDetailList(@ModelAttribute("searchVO") StockVO stockVO, Map <String, Object> commandMap, ModelMap model) throws Exception {

		String type = (String) commandMap.get("type");
		String itemCode = (String) commandMap.get("itemCode");
		
		if(type.equals("") || type == null) type = "all"; 
		if(itemCode.equals("") || itemCode == null) itemCode = "all"; 
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(stockVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(stockVO.getPageUnit());
		paginationInfo.setPageSize(stockVO.getPageSize());
		
		stockVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		stockVO.setLastIndex(paginationInfo.getLastRecordIndex());
		stockVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		stockVO.setItemCode(itemCode);
		stockVO.setType(type);
	
		List resultList = stockService.selectStockDetailList(stockVO);
		int totCnt = stockService.selectStockDetailListCount(stockVO);
				
		paginationInfo.setTotalRecordCount(totCnt);
		
		System.out.println("stockVO    "+ stockVO.toString());
		
		if("all".equals(type)){
			model.addAttribute("mainTitle", "전체 현황");
			model.addAttribute("subTitle", "전체 상세 현황");
		}
		else if("stock".equals(type)){
			model.addAttribute("mainTitle", "재고 현황");
			model.addAttribute("subTitle", "재고 상세 현황");
		}
		else if("sell".equals(type)){
			model.addAttribute("mainTitle", "판매 현황");
			model.addAttribute("subTitle", "판매 상세 현황");
		}
		model.addAttribute("type", type);
		model.addAttribute("itemCode", itemCode);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", stockVO);
		
		return "/support/sprt_stockDetailL";
	}
	
	@RequestMapping("/support/stockDetailListOld.do")
	public String selectStockDetailListOld(@ModelAttribute("searchVO") StockVO stockVO, Map <String, Object> commandMap, ModelMap model) throws Exception {

		String type = (String) commandMap.get("type");
		String itemCode = (String) commandMap.get("itemCode");
		
		if(type.equals("") || type == null) type = "all"; 
		if(itemCode.equals("") || itemCode == null) itemCode = "all"; 
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(stockVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(stockVO.getPageUnit());
		paginationInfo.setPageSize(stockVO.getPageSize());
		
		stockVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		stockVO.setLastIndex(paginationInfo.getLastRecordIndex());
		stockVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		stockVO.setItemCode(itemCode);
		stockVO.setType(type);
	
		List resultList = stockService.selectOldStockDetailList(stockVO);
		int totCnt = stockService.selectOldStockDetailListCount(stockVO);
				
		paginationInfo.setTotalRecordCount(totCnt);
		
		System.out.println("stockVO    "+ stockVO.toString());
		
		if("all".equals(type)){
			model.addAttribute("mainTitle", "전체 현황");
			model.addAttribute("subTitle", "전체 상세 현황");
		}
		else if("stock".equals(type)){
			model.addAttribute("mainTitle", "재고 현황");
			model.addAttribute("subTitle", "재고 상세 현황");
		}
		else if("sell".equals(type)){
			model.addAttribute("mainTitle", "판매 현황");
			model.addAttribute("subTitle", "판매 상세 현황");
		}
		model.addAttribute("type", type);
		model.addAttribute("itemCode", itemCode);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", stockVO);
		
		return "/support/sprt_stockDetailL_old";
	}
	
	@RequestMapping("/support/stockHistoryL.do")
	public String selectStockHistoryList(@ModelAttribute("searchVO") StockVO stockVO, Map <String, Object> commandMap, ModelMap model) throws Exception{
		
		Map <String, Object> map = stockService.selectHistoryList(stockVO);
		model.addAttribute("result", map);
		model.addAttribute("searchVO", stockVO);
		
		if (commandMap.get("err") != null && commandMap.get("err").toString().equals("Y"))
			model.addAttribute("errorMessage", "중복된 시리얼넘버입니다.");
		
		return "/support/sprt_stockHistoryL";
	}

	@RequestMapping("/support/installL.do")
	public String selectInstallList(@ModelAttribute("searchVO") StockVO stockVO, Map<String, Object> commandMap, ModelMap model) throws Exception{
		
		List resultList = null;
		if (commandMap.get("searchItemNo") != null)
			resultList = stockService.selectStockList(commandMap);
		model.addAttribute("resultList", resultList);
		model.addAttribute("search", commandMap);
		
		Map<String, Object> param = new HashMap<String, Object>();
		List categoryList = stockService.selectStockCategory(param);
		List itemList = stockService.selectStockItem(param);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("itemList", itemList);
		
		return "/support/sprt_installL";
	}
	
	@RequestMapping("/support/installI.do")
	public String insertStockInstall(@ModelAttribute("searchVO") StockVO stockVO, Map<String, Object> commandMap, ModelMap model) throws Exception{
		stockService.insertStockInstall(commandMap);
		return "/support/sprt_closePage";
	}
	
	@RequestMapping("/support/installD.do")
	public String deleteStockInstall(@ModelAttribute("searchVO") StockVO stockVO, Map<String, Object> commandMap, ModelMap model) throws Exception{
		stockService.deleteStockInstall(commandMap);
		return "redirect:/support/stockHistoryL.do?stockNo=" + commandMap.get("swNo") + "&itemCode=" + commandMap.get("itemCode");
	}

}