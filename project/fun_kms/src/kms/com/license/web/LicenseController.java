package kms.com.license.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.utils.SessionUtil;
import kms.com.license.service.LicenseVO;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ibm.icu.text.SimpleDateFormat;
import com.saeha.chorusvc.license.client.License;
import com.saeha.chorusvc.license.client.LicenseHistory;
import com.saeha.chorusvc.license.client.LicenseSource;
import com.saeha.chorusvc.license.client.ListPage;
import com.saeha.chorusvc.license.client.SaehaLicenseApi;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class LicenseController {
	
	/* 라이선스 목록 조회 */
	@RequestMapping("/license/licenseList.do")
	public String licenseList(@ModelAttribute("searchVO") LicenseVO licenseVO, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception{
		
		String serverUrl = "https://172.16.30.197:51998";

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("companyName", licenseVO.getSearchCompanyName());
		searchMap.put("product", licenseVO.getSearchProduct());
		searchMap.put("page", licenseVO.getPage());

		
		if("".equals(licenseVO.getSearchExpireDateStart()) && !("".equals(licenseVO.getSearchExpireDateEnd()))){
			searchMap.put("expireDateStart","11111111");
			searchMap.put("expireDateEnd", licenseVO.getSearchExpireDateEnd());
		}else if(!("".equals(licenseVO.getSearchExpireDateStart())) && "".equals(licenseVO.getSearchExpireDateEnd())){
			searchMap.put("expireDateStart",licenseVO.getSearchExpireDateStart());
			searchMap.put("expireDateEnd", "99999999");
		}else{
			searchMap.put("expireDateStart",licenseVO.getSearchExpireDateStart());
			searchMap.put("expireDateEnd", licenseVO.getSearchExpireDateEnd());
		}
		
		SaehaLicenseApi api = new SaehaLicenseApi(serverUrl);
		
		ListPage<License> listPage = api.getLicenseList(searchMap);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(listPage.getPage());
		paginationInfo.setRecordCountPerPage(listPage.getRowLen());
		paginationInfo.setPageSize(15);
		
		licenseVO.setPage(listPage.getPage());
		licenseVO.setPageTotalCount(listPage.getPageTotalCount());
		licenseVO.setRowTotalCount(listPage.getRowTotalCount());
		
		paginationInfo.setTotalRecordCount(listPage.getRowTotalCount());
		model.addAttribute("listPage", paginationInfo);
		model.addAttribute("licenseList", listPage.getList());
		
		return "/license/licenseList";
	}
	
	/* 라이선스 등록 화면 이동 */
	@RequestMapping("/license/licenseIssue.do")
	public String licenseAdd(HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception{
		return "/license/licenseIssue";
	}
	
	/* 라이선스 등록 실행 */
	@RequestMapping("/license/licenseIssueSave.do")
	public String licenseAddSave(@ModelAttribute("searchVO") LicenseVO licenseVO, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception{
		
		String serverUrl = "https://172.16.30.197:51998";
		
		SaehaLicenseApi api = new SaehaLicenseApi(serverUrl);
		//licenseSource 라이선스 생성 소스 VO : licenseId 입력 시 재발급
		MemberVO user = SessionUtil.getMember(req);
		
		//System.out.println(model.get("licenseId"));
		
		LicenseSource licenseSource = new LicenseSource();
		licenseSource.setLicenseId(licenseVO.getLicenseId());
		licenseSource.setProduct(licenseVO.getProduct());
		licenseSource.setCompanyName(licenseVO.getCompanyName());
		licenseSource.setPerson(licenseVO.getPerson());
		licenseSource.setPhone(licenseVO.getPhone());
		licenseSource.setServerIpAddr(licenseVO.getServerIpAddr());
		licenseSource.setServerMacAddr(licenseVO.getServerMacAddr());
		licenseSource.setMaxUser(licenseVO.getMaxUser());
		licenseSource.setMaxUserLimit(licenseVO.getMaxUserLimit());
		licenseSource.setClientList(licenseVO.getClientList());
		licenseSource.setFunctionList(licenseVO.getFunctionList());
		licenseSource.setUnlimited(licenseVO.isUnlimited());
		licenseSource.setExpireDate(licenseVO.getExpireDate());
		licenseSource.setMemo(licenseVO.getMemo());
		licenseSource.setRegUserId(user.getUserId());//발급자 ID
		licenseSource.setRegUserName(user.getUserNm());//발급자 이름

		//라이선스 발급 함수 호출

		api.createLicense(licenseSource);
		
		return "redirect:/license/licenseList.do";
	}
	
		
	/* 라이선스 상세 조회 및 화면 하단의 이력 리스트  */
	@RequestMapping("/license/licenseView.do")
	public String licenseView(@ModelAttribute("searchVO") LicenseVO licenseVO, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception{
		
		String urlStr = "https://172.16.30.197:51998";
		String licenseId = licenseVO.getLicenseId();
		String historyId = licenseVO.getHistoryId();
		
		String flag = licenseVO.getFlagVM();
		String cnt = licenseVO.getCount();

		SaehaLicenseApi api = new SaehaLicenseApi(urlStr);
		License license = api.getLicense(licenseId);
		LicenseHistory licenseHistory = api.getLicenseHistory(licenseId, historyId);

		model.addAttribute("result", license);
		model.addAttribute("result2", licenseHistory);
		model.addAttribute("result3", cnt);
		
		if(flag.equals("view")){	//상세 조회 화면일 경우에만 세팅
			List<LicenseHistory> licenseHistoryList = api.getLicenseHistoryList(licenseId);
			model.addAttribute("licenseHistoryList", licenseHistoryList);
		}
	
		if(flag.equals("view")){	//상세 조회 화면으로 이동	
			return "/license/licenseView";
		}else{						//수정 화면으로 이동
			return "/license/licenseModify";
		}
	}
	
	/* 라이선스 이력 상세 조회  */
	@RequestMapping("/license/licenseHistoryDetail.do")
	public String licenseHistoryDetail(@ModelAttribute("searchVO") LicenseVO licenseVO, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception{
		
		String urlStr = "https://172.16.30.197:51998";
		String licenseId = licenseVO.getLicenseId();
		String historyId = licenseVO.getHistoryId();
		
		SaehaLicenseApi api = new SaehaLicenseApi(urlStr);
		/*
		licenseId 라이선스ID
		historyId 이력ID
		 */
		
		LicenseHistory licenseHistory = api.getLicenseHistory(licenseId, historyId);
		List<LicenseHistory> licenseHistoryList = api.getLicenseHistoryList(licenseId);
		
		//System.out.println("licenseHistory :::: " + licenseHistory);
		model.addAttribute("result", licenseHistory);
		model.addAttribute("licenseHistoryList", licenseHistoryList);
		
		return "/license/licenseHistoryView";
	}
	
	/* 라이선스 수정 진행 */
	@RequestMapping("/license/licenseModify.do")
	public String licenseModify(@ModelAttribute("searchVO") LicenseVO licenseVO, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception{

		String urlStr = "https://172.16.30.197:51998";
				
		SaehaLicenseApi api = new SaehaLicenseApi(urlStr);
		MemberVO user = SessionUtil.getMember(req);
		/*
		user.getNo();
		user.getUserId(); = id
		user.getUserNm(); = 이름
		*/
		String licenseId = licenseVO.getLicenseId();
		String modifyUserId = user.getUserId();
		String modifyUserName = user.getUserNm();
		String companyName = licenseVO.getCompanyName();
		String person = licenseVO.getPerson();
		String phone = licenseVO.getPhone();
		String memo = licenseVO.getMemo();
		
		/*
		licenseId 라이선스ID
		modifyUserId 수정자ID
		modifyUserName 수정자명
		companyName 회사명
		person 담당자명
		phone 연락처
		memo 메모
		*/
		
		api.modifyLicense(licenseId, modifyUserId, modifyUserName, companyName, person, phone, memo);
		
		License license = api.getLicense(licenseId);
		
		List<LicenseHistory> licenseHistoryList = api.getLicenseHistoryList(licenseId);
		
		model.addAttribute("result", license);
		model.addAttribute("licenseHistoryList", licenseHistoryList);
		
		return "/license/licenseView";
	}
	
	
	/* 라이선스 재발급 호출 (기존 정보 가져가기) */
	@RequestMapping("/license/licenseIssueAgain.do")
	public String licenseIssueAgain(@ModelAttribute("searchVO") LicenseVO licenseVO, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception{
		
		String urlStr = "https://172.16.30.197:51998";
		String licenseId = licenseVO.getLicenseId();
		
		SaehaLicenseApi api = new SaehaLicenseApi(urlStr);
		
		License license = api.getLicense(licenseId);

		model.addAttribute("result", license);
		
		return "/license/licenseIssueAgain";
	}
	
	@RequestMapping("/license/licenseDel.do")
	public String licenseDel(@ModelAttribute("searchVO") LicenseVO licenseVO, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception{
		
		String urlStr = "https://172.16.30.197:51998";
		MemberVO user = SessionUtil.getMember(req);
		
		String licenseId = licenseVO.getLicenseId();
		String historyId = licenseVO.getHistoryId();
		String deleteUserId = user.getUserId();
		String deleteUserName = user.getUserNm();
		
		SaehaLicenseApi api = new SaehaLicenseApi(urlStr);
		/*
		licenseId 라이선스ID 
		deleteUserId 삭제자ID
		deleteUserName 삭제자명
		*/
		api.deleteLicense(licenseId, deleteUserId, deleteUserName);
		
		return "redirect:/license/licenseList.do";
	}
}
