package kms.com.admin.salary.web;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.impl.MemberDAO;
import kms.com.salary.service.KmsSalaryService;
import kms.com.salary.service.MemberEvaVO;
import kms.com.salary.service.SalaryVO;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 인건비 관리를 위한 웹 서비스를 기반으로 만든
 * 실제 연봉 관리를 위한 웹 서비스
 * 
 * 인건비관리가 labor cost, payroll expense, personnel expenditure 
 * 이렇게 되어야하는데 그냥 salary로 만들어져 있어서 실제연봉관리는 salaryReal로 명명
 *  
 * @author 웹개발팀 박기현
 * @since 2012.10.19
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2012.10.19  박기현           생성
 *
 * </pre>
 */
@Controller
public class AdminSalaryRealController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "KmsMemberService")
	private MemberService memberService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "KmsSalaryService")
	private KmsSalaryService salaryService;
	
	@Resource(name = "KmsMemberDAO")
	private MemberDAO memberDAO;
	
	@Autowired
	private DefaultBeanValidator beanValidator;

	Logger log = Logger.getLogger(this.getClass());


	@RequestMapping("/admin/salary/salaryRealMain.do")
	public String selectSalaryRealList(@ModelAttribute("searchVO") SalaryVO salaryVO, 
			HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		boolean auth = false;     
		if (user.isSalaryadmin()) {
			auth = true;
		}        
		if(auth == false){
			model.addAttribute("message", "조회 권한이 없습니다.");
			return "error/messageError";
		}
		
		salaryVO.setSearchOrgIdList(CommonUtil.makeValidIdList(salaryVO.getSearchOrgId()));
		salaryVO.setWorkStList(salaryVO.getWorkStArray());
		String[] sWorkStList = salaryVO.getWorkStList();    		
		if(sWorkStList[0].equals("R") == true)
			salaryVO.setOrderBy("RetireDate");
		
		Calendar cal = Calendar.getInstance();    	
		if(salaryVO.getYear()==null)
			salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS033");
		List<CmmnDetailCode> degreeCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("degreeCode", degreeCode);
		
		codeVO.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(codeVO);    	
		model.addAttribute("rankList", rankList);
		
		codeVO.setCodeId("KMS034");
		List<CmmnDetailCode> statusCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("statusCode", statusCode);
		
		codeVO.setCodeId("KMS036");
		List exceptionList = cmmUseService.selectCmmCodeDetail(codeVO);
		CmmnDetailCode exceptionUsers = (CmmnDetailCode)exceptionList.get(0);    	
		salaryVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
				
		model.addAttribute("resultList1", salaryService.selectRankSalaryRealList(salaryVO));
		model.addAttribute("resultList2", salaryService.selectUserSalaryRealList(salaryVO));
				
		model.addAttribute("year", salaryVO.getYear());
		return "admin/salary/salaryRealMain";
	}
	
	@RequestMapping("/admin/salary/salaryRealCEOMain.do")
	public String selectSalaryRealCEOList(@ModelAttribute("searchVO") SalaryVO salaryVO, 
			HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		boolean auth = false;      
		if (user.isSalaryadmin()) {
			auth = true;
		}       
		if(auth == false){
			model.addAttribute("message", "조회 권한이 없습니다.");
			return "error/messageError";
		}
		
		salaryVO.setSearchOrgIdList(CommonUtil.makeValidIdList(salaryVO.getSearchOrgId()));
		salaryVO.setWorkStList(salaryVO.getWorkStArray());
		String[] sWorkStList = salaryVO.getWorkStList();    		
		if(sWorkStList[0].equals("R") == true)
			salaryVO.setOrderBy("RetireDate");
		
		Calendar cal = Calendar.getInstance();
		if(salaryVO.getYear()==null || salaryVO.getYear().equals("")){
			if( cal.get(Calendar.MONTH) < 3)
				salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR) - 1) );
			else
				salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)) );
		}
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(codeVO);    	
		model.addAttribute("rankList", rankList);
		
		codeVO.setCodeId("KMS033");
		List<CmmnDetailCode> degreeCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("degreeCode", degreeCode);
		
		codeVO.setCodeId("KMS034");
		List<CmmnDetailCode> statusCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("statusCode", statusCode);
		
		codeVO.setCodeId("KMS036");
		List exceptionList = cmmUseService.selectCmmCodeDetail(codeVO);
		CmmnDetailCode exceptionUsers = (CmmnDetailCode)exceptionList.get(0);    	
		salaryVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
		
		/** Paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(salaryVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(salaryVO.getPageUnit());
		paginationInfo.setPageSize(salaryVO.getPageSize());
		
		salaryVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		salaryVO.setLastIndex(paginationInfo.getLastRecordIndex());
		salaryVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List resultList = salaryService.selectUserSalaryRealListCEO(salaryVO);
		//List resultListSum = salaryService.selectUserSalaryRealListCEOSum(salaryVO);
		SalaryVO resultListSum = salaryService.selectUserSalaryRealListCEOSum2(salaryVO);
		List statusCntList = salaryService.selectUserSalaryRealListCEOStatusCnt(salaryVO);    	
		
		//검색시 페이지 번호 넘어가는 경우 예외처리
		if(resultList.size()<1){ 
			salaryVO.setPageIndex(1);
			paginationInfo.setCurrentPageNo(salaryVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(salaryVO.getPageUnit());
			paginationInfo.setPageSize(salaryVO.getPageSize());    		
			salaryVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			salaryVO.setLastIndex(paginationInfo.getLastRecordIndex()); //필요한가
			salaryVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			resultList = salaryService.selectUserSalaryRealListCEO(salaryVO);
		}
		
		int totCnt = salaryService.selectUserSalaryRealListCEOTotCnt(salaryVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListSum", resultListSum);
		model.addAttribute("statusCntList", statusCntList);
		model.addAttribute("year", salaryVO.getYear());

		model.addAttribute("thisYear", Integer.toString(cal.get(Calendar.YEAR)));
		
		model.addAttribute("totCnt", totCnt);
		return "human_resource/salaryRealCEOMain";
		//return "admin/salary/salaryRealCEOMain";
	}
	
	@RequestMapping("/ajax/admin/salary/salaryRealCEOHistory.do")
	public String salaryRealCEOHistory(@ModelAttribute("searchVO") SalaryVO salaryVO, 
		HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		//userNo 없는 조회 초기값 초기화
		String salaryUserNo = salaryVO.getUserNo();		
		if(salaryUserNo == null || salaryUserNo.equals("") ){
			salaryUserNo = user.getStringNo();
			salaryVO.setUserNo(salaryUserNo);
		}
				  
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();        	
		codeVO.setCodeId("KMS036");
		List exceptionList = cmmUseService.selectCmmCodeDetail(codeVO);
		CmmnDetailCode exceptionUsers = (CmmnDetailCode)exceptionList.get(0);    	
		salaryVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
		
		String year = salaryVO.getYear();    	    	
		List resultList = salaryService.selectMemberSalaryNego(salaryVO);
		
		if(resultList.size()>0){
			model.addAttribute("memberVO", resultList.get(0));	    	
		} else{
			model.addAttribute("memberVO", resultList);
		}
		model.addAttribute("resultList", resultList);  	
		model.addAttribute("year", year);
		return "human_resource/salaryRealCEOHistory";
	}
	
	@RequestMapping("/admin/salary/selectEmpContractList.do")
	public String selectEmpContractList(@ModelAttribute("searchVO") SalaryVO salaryVO, 
			HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		boolean auth = false;      
		if (user.isSalaryadmin()) {
			auth = true;
		}        
		if(auth == false){
			model.addAttribute("message", "조회 권한이 없습니다.");
			return "error/messageError";
		}
		
		salaryVO.setSearchOrgIdList(CommonUtil.makeValidIdList(salaryVO.getSearchOrgId()));
		salaryVO.setWorkStList(salaryVO.getWorkStArray());
		String[] sWorkStList = salaryVO.getWorkStList();    		
		if(sWorkStList[0].equals("R") == true)
			salaryVO.setOrderBy("RetireDate");
		
		Calendar cal = Calendar.getInstance();    	
		if(salaryVO.getYear()==null)
			salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(codeVO);    	
		model.addAttribute("rankList", rankList);
		
		codeVO.setCodeId("KMS033");
		List<CmmnDetailCode> degreeCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("degreeCode", degreeCode);
		
		codeVO.setCodeId("KMS034");
		List<CmmnDetailCode> statusCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("statusCode", statusCode);
		
		codeVO.setCodeId("KMS036");
		List exceptionList = cmmUseService.selectCmmCodeDetail(codeVO);
		CmmnDetailCode exceptionUsers = (CmmnDetailCode)exceptionList.get(0);    	
		salaryVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
   
		/** Paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(salaryVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(salaryVO.getPageUnit());
		paginationInfo.setPageSize(salaryVO.getPageSize());
		
		salaryVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		salaryVO.setLastIndex(paginationInfo.getLastRecordIndex());
		salaryVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List resultList = salaryService.selectUserSalaryRealListCEO(salaryVO);
				
		//검색시 페이지 번호 넘어가는 경우 예외처리
		if(resultList.size()<1){ 
			salaryVO.setPageIndex(1);
			paginationInfo.setCurrentPageNo(salaryVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(salaryVO.getPageUnit());
			paginationInfo.setPageSize(salaryVO.getPageSize());    		
			salaryVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			salaryVO.setLastIndex(paginationInfo.getLastRecordIndex()); //필요한가
			salaryVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			resultList = salaryService.selectUserSalaryRealListCEO(salaryVO);
		}
		
		int totCnt = salaryService.selectUserSalaryRealListCEOTotCnt(salaryVO);
		paginationInfo.setTotalRecordCount(totCnt);
				
		model.addAttribute("paginationInfo", paginationInfo);   
		model.addAttribute("resultList", resultList);    	
		model.addAttribute("year", salaryVO.getYear());
		//return "human_resource/salaryRealCEOMain";
		return "admin/salary/empContractListMain";
		
	}
	
	@RequestMapping("/admin/salary/memberEvaluationMain.do")
	public String memberEvaluationList(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {

		salaryVO.setSearchOrgIdList(CommonUtil.makeValidIdList(salaryVO.getSearchOrgId()));
		salaryVO.setWorkStList(salaryVO.getWorkStArray());
		String[] sWorkStList = salaryVO.getWorkStList();    		
		if(sWorkStList[0].equals("R") == true)
			salaryVO.setOrderBy("RetireDate");
		
		Calendar cal = Calendar.getInstance();    	
		if(salaryVO.getYear()==null)
			salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS033");
		List<CmmnDetailCode> degreeCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("degreeCode", degreeCode);
		
		codeVO.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(codeVO);    	
		model.addAttribute("rankList", rankList);
		
		codeVO.setCodeId("KMS034");
		List<CmmnDetailCode> statusCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("statusCode", statusCode);
		
		codeVO.setCodeId("KMS036");
		List exceptionList = cmmUseService.selectCmmCodeDetail(codeVO);
		CmmnDetailCode exceptionUsers = (CmmnDetailCode)exceptionList.get(0);    	
		salaryVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
		
		model.addAttribute("resultList", salaryService.selectUserSalaryEva(salaryVO));
				
		model.addAttribute("year", salaryVO.getYear());
		return "admin/salary/salaryMemberEvaMain";
	}
	
	@RequestMapping("/ajax/admin/salary/userSalaryMemberEvaU.do")
	public String userSalaryMemberEvaUpdate(@ModelAttribute("searchVO") MemberEvaVO memberEvaVO,    		
			ModelMap model) throws Exception {
		
		MemberEvaVO memberEvaVO2 = salaryService.selectUserSalaryMemberEva(memberEvaVO);
		
		//평가자 번호 입력
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchUserNm", memberEvaVO.getEva1Nm());
		int eva1 = memberDAO.selectUserNo(param);
		memberEvaVO.setEva1(Integer.toString(eva1));		
		param.put("searchUserNm", memberEvaVO.getEva2Nm());
		int eva2 = memberDAO.selectUserNo(param);
		memberEvaVO.setEva2(Integer.toString(eva2));
		
		//수정을 DELETE INSERT로 하므로 기존 정보 유지
		memberEvaVO.setExpCompId(memberEvaVO2.getExpCompId());
		memberEvaVO.setCompnyId(memberEvaVO2.getCompnyId());
		memberEvaVO.setOrgnztId(memberEvaVO2.getOrgnztId());
		memberEvaVO.setRankId(memberEvaVO2.getRankId());
		memberEvaVO.setPosition(memberEvaVO2.getPosition());
		memberEvaVO.setWorkSt(memberEvaVO2.getWorkSt());
		memberEvaVO.setDegree(memberEvaVO2.getDegree());
		memberEvaVO.setPromotionYear(memberEvaVO2.getPromotionYear());
		memberEvaVO.setCareerLength(memberEvaVO2.getCareerLength());		
		
		//설계 구현은 해뒀으나 현재 안쓰는 필드
		memberEvaVO.setEva3(memberEvaVO2.getEva3());
		memberEvaVO.setScore3(memberEvaVO2.getScore3());
		memberEvaVO.setScoreSelf(memberEvaVO2.getScoreSelf());
		
		try{
			salaryService.updateUserSalaryMemberEva(memberEvaVO);
		} catch(Exception e){
			String ex = e.getMessage();
			String ex2 = e.toString();
		}
		
		return "success";
	}
		
	@RequestMapping("/ajax/admin/salary/rankSalaryRealU.do")
	public String rankSalaryUpdate(@ModelAttribute("searchVO") 
			SalaryVO salaryVO, ModelMap model) throws Exception {    	
		
		Calendar cal = Calendar.getInstance();	    	
		salaryService.updateRankSalaryReal(salaryVO); 
		return "success";
	}    
	
	@RequestMapping("/ajax/admin/salary/rankSalaryRealAjax.do")
	public String rankSalaryAjax(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {
		
		Calendar cal = Calendar.getInstance();
		
		if(salaryVO.getYear()==null)
			salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		List resultList = salaryService.selectRankSalaryRealList(salaryVO);
		if(resultList.isEmpty())
			return "fail";
		else{
			model.addAttribute("resultList1",resultList);
			return "admin/salary/include/rankSalaryReal";
		}    	
	}
	
	@RequestMapping("/ajax/admin/salary/userSalaryRealU.do")
	public String userSalaryUpdate(@ModelAttribute("searchVO") SalaryVO salaryVO,
			@ModelAttribute("memberVO") MemberVO memberVO,
			ModelMap model) throws Exception {
		
		Calendar cal = Calendar.getInstance();    	
		memberVO.setNo(Integer.parseInt(salaryVO.getUserNo()));    	
		memberService.updtMember2(memberVO); //promotionYear, degree, careerMonth 컬럼 정보 TBL_USERINFO 에 입력
		salaryService.updateUserSalaryReal(salaryVO);//연봉정보 업데이트
		
		memberVO = memberService.selectMemberBasic(memberVO);
		salaryService.insertMemberEvaAuto(memberVO, salaryVO.getYear()); //평가정보 같이 입력
						
		//동의인 경우 차년도 데이터 입력
		if(salaryVO.getStatus().equals("2")){			
			salaryService.insertMemberSalaryNextYear(salaryVO); //차년도 연봉
			salaryService.insertMemberEvaAuto(memberVO, salaryVO.getNextYear()); //차년도 평가정보
		}		
		return "success";
	}
		
	@RequestMapping("/ajax/admin/salary/userSalaryRealAjax.do")
	public String userSalaryAjax(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {
		
		Calendar cal = Calendar.getInstance();
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS033");
		List<CmmnDetailCode> degreeCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("degreeCode", degreeCode);
		
		codeVO.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(codeVO);    	
		model.addAttribute("rankList", rankList);
		
		if(salaryVO.getYear()==null)
			salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		List resultList = salaryService.selectUserSalaryRealList(salaryVO);
		
		if(resultList.isEmpty())
			return "fail";
		else
		{
			model.addAttribute("resultList2",resultList);
			return "admin/salary/include/userSalaryReal";
		}    	
	}
	
	@RequestMapping("/ajax/admin/salary/userSalaryRealCEOAjax.do")
	public String userSalaryCEOAjax(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {
		
		salaryVO.setSearchOrgIdList(CommonUtil.makeValidIdList(salaryVO.getSearchOrgId()));
		salaryVO.setWorkStList(salaryVO.getWorkStArray());
		String[] sWorkStList = salaryVO.getWorkStList();    		
		if(sWorkStList[0].equals("R") == true)
			salaryVO.setOrderBy("RetireDate");
		
		Calendar cal = Calendar.getInstance();    	
		if(salaryVO.getYear()==null)
			salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS033");
		List<CmmnDetailCode> degreeCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("degreeCode", degreeCode);
		
		codeVO.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(codeVO);    	
		model.addAttribute("rankList", rankList);

		codeVO.setCodeId("KMS034");
		List<CmmnDetailCode> statusCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("statusCode", statusCode);
		
		model.addAttribute("resultList", salaryService.selectUserSalaryRealListCEO(salaryVO));
				
		model.addAttribute("year", salaryVO.getYear());
		return "human_resource/include/userSalaryRealCEO";
		//return "admin/salary/include/userSalaryRealCEO";   	
	}
	
}
