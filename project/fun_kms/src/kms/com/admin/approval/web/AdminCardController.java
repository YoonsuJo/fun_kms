package kms.com.admin.approval.web;

import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import jxl.Workbook;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.support.service.CardService;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.CardVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * @Class Name : KmsApprovalTypController.java
 * @Description : KmsApprovalTypController class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class AdminCardController {

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsCardService")
	private CardService cardService;
	
	
	/**
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/approval/selectCardSpendList.do")
	public String selectAccountList(@ModelAttribute("searchVO") CardSpendVO searchVO, 
			ModelMap model)
			throws Exception {
		
		// Default Value : Status = 3 (미상신)
		if (searchVO.getSearchStatus() == null) {
			searchVO.setSearchStatus(new String[] {"3"});
		}
		
		// [20140722, 김동우] 사용자 여러명 선택 가능토록 수정
		if (searchVO.getSearchUserNm() != null) {
			String[] searchUserNmArr = CommonUtil.parseNmFromMixs(searchVO.getSearchUserNm());
			searchVO.setSearchUserNmArr(searchUserNmArr);
		}
		
		// 월선택 라디오 버튼 초기값 설정을 위해 LPAD 0을 제거하는 toInt toString 캐스팅
		searchVO.setSearchMonth(Integer.toString(Integer.parseInt(searchVO.getSearchMonth()) ) );    	
		model.addAttribute("resultList", cardService.selectCardSpendListAdmin(searchVO));
		//model.addAttribute("resultSum", cardService.selectCardSpendSum(searchVO));
		
		// checkbox에 바인딩된 내용, javascript에서 쓸수있도록 String형 전환
		// [1, 2] -> "1,2"
		if (searchVO.getSearchStatus() != null)
			searchVO.setSearchStatusStr(CommonUtil.convertSearchData(searchVO.getSearchStatus()));
		
		return "admin/approval/cardSpendL";
	}
	
	@RequestMapping(value="/admin/approval/writeCardSpendExcel.do")
	public String writeCardSpendExcel(@ModelAttribute("searchVO") CardVO searchVO, 
			ModelMap model)
	throws Exception {
		
		return "admin/approval/cardSpendExcelW";
	}
	
	@RequestMapping(value="/admin/approval/insertCardSpendExcel.do")
	public String insertCardSpendExcel(final MultipartHttpServletRequest multiRequest
			,@ModelAttribute("searchVO") CardVO searchVO, 
			ModelMap model)
	throws Exception {
		
		List<FileVO> result = null;
		String atchFileId = "";
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "CARD_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		Workbook workbook = Workbook.getWorkbook(new File(result.get(0).getFileStreCours() + result.get(0).getStreFileNm()));
//		Workbook workbook = Workbook.getWorkbook(new File(result.get(0).getFileStreCours() + File.separator + result.get(0).getStreFileNm() + "." + result.get(0).getFileExtsn()));
		cardService.insertCardSpendExcel(workbook);
		
		return "redirect:/admin/approval/selectCardSpendList.do";
	}
	
	@RequestMapping(value="/admin/approval/deleteCardSpend.do")
	public String deleteCardSpend(final MultipartHttpServletRequest multiRequest
			,@ModelAttribute("searchVO") CardSpendVO searchVO, 
			ModelMap model)
	throws Exception {
		
		cardService.deleteCardSpend(searchVO);
		
		return "redirect:/admin/approval/selectCardSpendList.do?"+ 
				"searchYear" + searchVO.getSearchYear() +"&" +
				"searchMonth" + searchVO.getSearchMonth() +"&" +
				"searchCardId" + searchVO.getSearchCardId() +"&" +
				"searchUserNm" + searchVO.getSearchUserNm();
	}
	  
}
