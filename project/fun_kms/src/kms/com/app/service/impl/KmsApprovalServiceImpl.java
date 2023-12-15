package kms.com.app.service.impl;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.admin.authority.service.KmsAdminAuthService;
import kms.com.app.service.*;
import kms.com.app.web.KmsApprovalController;
import kms.com.common.exception.IdMixInputException;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.cooperation.service.ProjectInputVO;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.ProjectVO;
import kms.com.management.service.impl.FundDAO;
import kms.com.member.service.*;
import kms.com.salary.service.KmsSalaryHolService;
import kms.com.support.service.impl.StockDAO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  
 *  </pre>
 */
/**
 * @author blind
 *
 */
/**
 * @author blind
 *
 */
@Service("approvalService")
public class KmsApprovalServiceImpl extends AbstractServiceImpl implements
	KmsApprovalService {

    @Resource(name="approvalDAO")
    private ApprovalDAO approvalDAO;
    
    @Resource(name = "kmsExpIdGnrService")
	private EgovIdGnrService expIdgenService;
    
    @Resource(name = "projectService")
	private ProjectService projectService;
    
    @Resource(name = "kmsAdminAuthService")
    private KmsAdminAuthService adminAuthService;

    @Resource(name = "KmsSalaryHolService")
	private KmsSalaryHolService salaryHolService;
    
    @Resource(name = "KmsFundDAO")
	FundDAO fundDAO;

    @Resource(name="KmsStockDAO")
	private StockDAO stockDAO;
    
    @Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    @Override
	public ApprovalVO viewApprovalDoc(ApprovalVO vo) throws Exception {
    	return approvalDAO.viewApprovalDoc(vo);
	}

	@Override
	public Map<String, Object> selectApprovalList(ApprovalVO vo)
			throws Exception {
		List<ApprovalVO> list = approvalDAO.selectApprovalList(vo);
		int cnt = approvalDAO.selectApprovalListCnt(vo);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));

		return map;
	}
	
	@Override
	public List<ApprovalVO> selectApprovalMainAjax(ApprovalVO vo) {
		return approvalDAO.selectApprovalList(vo);
	}
	
	@Override
	public int selectApprovalMainAjaxCnt(ApprovalVO vo) {
		return approvalDAO.selectApprovalListCnt(vo);
	}

	@Override
	public void insertApprovalCmm(ApprovalVO approvalVO) {
		approvalDAO.insertApprovalCmm(approvalVO);		
	}

	@Override
	public void insertApprovalReaders(String docNo, String approvalType, List<String> readers) {
		approvalDAO.insertApprovalReaders(docNo, approvalType,readers);		
	}

	@Override
	public List<ApprovalReaderVO> viewApprovalReader(ApprovalVO searchVO) {
		return approvalDAO.viewApprovalReader(searchVO);
	}

	@Override
	public String selectUserMixByUserNo(int readerNo) {
		return approvalDAO.selectUserMixByUserNo(readerNo);		
	}

	@Override
	public void updateReaderStat(ApprovalReaderVO searchVO) {
		approvalDAO.updateReaderStat(searchVO);		
	}

	@Override
	public int selectReaderNo(ApprovalReaderVO readerVO) {
		return approvalDAO.selectReaderNo(readerVO);
	}

	@Override
	public void updateDocStat(ApprovalVO vo) {
		approvalDAO.updateDocStat(vo);		
	}

	@Override
	public int countUnAppReaderByTyp(ApprovalReaderVO readerVO) {
		return approvalDAO.countUnAppReaderByTyp(readerVO);
	}

	@Override
	public void updateReaderSrchDt(ApprovalReaderVO readerVO) {
		approvalDAO.updateReaderSrchDt(readerVO);
	}

	@Override
	public void incrementReUseCnt(String docId) {
		approvalDAO.incrementReUseCnt(docId);		
	}

	@Override
	public void updateDocNewAt(ApprovalVO parntVO) {
		approvalDAO.upDateDocNewAt(parntVO);		
	}
	
	@Override
	public void updateDocContent(ApprovalVO parntVO) {
		approvalDAO.updateDocContent(parntVO);		
	}	

	@Override
	public ApprovalVO selectApprovalCntSummary(ApprovalVO searchVO) {
		ApprovalVO summaryVO = new ApprovalVO ();
		List<ApprovalVO> queryResult1=  approvalDAO.selectApprovalCntSummary1(searchVO);
		for(ApprovalVO vo : queryResult1) {
			if(vo.getDocStat().equals(KmsApprovalController.reviewingC))
				summaryVO.setReviewCnt(vo.getDocStatCnt());
			else if(vo.getDocStat().equals(KmsApprovalController.cooperatingC))
				summaryVO.setCooperationCnt(vo.getDocStatCnt());
			else if(vo.getDocStat().equals(KmsApprovalController.decidingC))
				summaryVO.setDecideCnt(vo.getDocStatCnt());
			else if(vo.getDocStat().equals(KmsApprovalController.rejectC))
				summaryVO.setRejectCnt(vo.getDocStatCnt());
			else if(vo.getDocStat().equals("HANDLING"))
				summaryVO.setWhileHandingCnt(vo.getDocStatCnt());			
		}
		searchVO.setMode("2");
		summaryVO.setDoApprovalCnt(approvalDAO.selectApprovalListCnt(searchVO));
		return summaryVO;		
	}

	@Override
	public void insertApprovalVac(ApprovalVacVO vacVO) {
		approvalDAO. insertApprovalVac(vacVO);		
	}

	@Override
	public void updateApprovalVac(ApprovalVacVO vacVO) {
		approvalDAO.updateApprovalVac(vacVO);
	}

	@Override
	public ApprovalVacVO viewApprovalVac(ApprovalVO searchVO) {
		return approvalDAO.viewApprovalVac(searchVO);		
	}
		
	/* for offical doc*/
	
	/**
	 * TBL_EAPP_OFFICIAL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 TblEappOfficialVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertApprovalOfficial(ApprovalOfficialVO vo) throws Exception {
    	log.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	log.debug(vo.toString());
    	
    	approvalDAO.insertApprovalOfficial(vo);
    }

    @Override
	public void updateOfficialId(ApprovalVO vo) {
    	approvalDAO.updateOfficialId(vo);
		
	}

    /**
	 * TBL_EAPP_OFFICIAL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 TblEappOfficialVO
	 * @return 조회한 TBL_EAPP_OFFICIAL
	 * @exception Exception
	 */
    public ApprovalOfficialVO viewApprovalOfficial(ApprovalVO vo) throws Exception {
        ApprovalOfficialVO resultVO = approvalDAO.viewOfficialVac(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

   /* for jobg*/    
	@Override
	public ApprovalJobgVO viewApprovalJobg(ApprovalVO searchVO) {
		ApprovalJobgVO vo = approvalDAO.viewApprovalJobg(searchVO);
		vo.setEducationList(vo.getEducation().split(","));
		vo.setRankIdList(vo.getRankId().split(","));
		return vo;
	}

	@Override
	public void insertApprovalJobg(ApprovalJobgVO approvalJobgVO) {
		String education="";
		for(int i = 0; i<approvalJobgVO.getEducationList().length; i++ )
		{
			if(education=="")
				education += approvalJobgVO.getEducationList()[i];
			else
				education += "," + approvalJobgVO.getEducationList()[i];
		}
		approvalJobgVO.setEducation(education);
		
		String rankId="";
		for(int i = 0; i<approvalJobgVO.getRankIdList().length; i++ )
		{
			if(rankId=="")
				rankId += approvalJobgVO.getRankIdList()[i];
			else
				rankId += "," + approvalJobgVO.getRankIdList()[i];
		}
		approvalJobgVO.setRankId(rankId);
		approvalDAO.insertApprovalJobg(approvalJobgVO);
		
	}

	@Override
	public void updateHandleStat(ApprovalVO searchVO) {
		approvalDAO.updateHandleStat(searchVO);		
	}
	
	@Override
	public void updateExp(ApprovalVO approvalVO) {
		approvalDAO.updateExp(approvalVO);		
	}
	
	@Override
	public void updateExpDocId(ApprovalVO approvalVO) {
		approvalDAO.updateExpDocId(approvalVO);		
	}
	
	@Override
	public void deleteDoc(String docId) {
		approvalDAO.deleteDoc(docId);		
	}
	
	@Override
	public void deleteDocVac(String docId) {
		approvalDAO.deleteDocVac(docId);		
	}

	@Override
	public EgovMap selectVacationSummary(WorkStateVO searchVO) throws Exception {
		EgovMap result = approvalDAO.selectVacationSummary(searchVO);
		return result;
	}

	@Override
	public List<EgovMap> selectVacationSummaryList(WorkStateVO searchVO) throws Exception {
		List<EgovMap> result =  approvalDAO.selectVacationSummaryList(searchVO);
		return result;
	}

	@Override
	public List<EgovMap> selectVacationSummaryDetail(WorkStateVO searchVO) throws Exception {
		return approvalDAO.selectVacationSummaryDetail(searchVO);
	}

	@Override
	public List<EgovMap> selectJobgList(ApprovalVO vo) {
		return approvalDAO.selectJobgList(vo);
	}

	@Override
	public ApprovalVO getChildDoc(ApprovalVO vo) {
		return approvalDAO.getChildDoc(vo);
	}

	@Override
	public ApprovalVO getParentDoc(ApprovalVO vo) {
		return approvalDAO.getParentDoc(vo);
	}
		
	@Override
	public String checkApprovalExpense(ApprovalExpenseVO approvalExpenseVO) 
		throws UnsupportedEncodingException, ParseException, FdlException {
		
		String expenseArray = CommonUtil.unescape(approvalExpenseVO.getExpenseArrayJ());
        JSONArray expenseArrayJ = (JSONArray)JSONValue.parseWithException(expenseArray);
        Iterator it = expenseArrayJ.iterator();
        boolean result = false;
        
        while(it.hasNext()) {
        	JSONObject ob = (JSONObject)it.next();
        	
        	String prjId = (String) ob.get("prjId");
			
			ProjectVO searchProjectVO = new ProjectVO();
			searchProjectVO.setPrjId(prjId);
			ProjectVO projectVO = projectService.selectProjectView(searchProjectVO);
	
			if (projectVO.getManageCostRule().equals("Y")) {
				ProjectInputVO projectInputVO = new ProjectInputVO();
				projectInputVO.setPrjId(prjId);
				projectInputVO.setYear(Integer.toString(CalendarUtil.getYear()));
				List<EgovMap> prjInputList = projectService.selectProjectInput(projectInputVO);
				
			    boolean isInputMember = false;
				for (int i = 0; i < prjInputList.size(); i++) {
					if (prjInputList.get(i) == null)
						continue;
					EgovMap egovMap = (EgovMap) prjInputList.get(i);
					
				    if (egovMap.get("userNo").equals(approvalExpenseVO.getWriterNo()) ) {
						int input = 0;
						input = Integer.parseInt(egovMap.get("month" + CalendarUtil.getMonth() + "List").toString());
						
						if (input == 1) {
							isInputMember = true;
							i = prjInputList.size();
							break;
						}
					}
				}
				
				// 투입되지 않은 프로젝트에 지출결의서를 상신할 수 있는 권한 확인
				boolean isExpAuthUser = false;
				Map<String, Object> commandMap = new HashMap<String, Object>();
				commandMap.put("userNo", approvalExpenseVO.getWriterNo());
			    List<String> authList = adminAuthService.selectUserAuthList(commandMap);
			    for(int j = 0; j < authList.size(); j++) {
			    	if ("expauth".equals(authList.get(j))) {
			    		isExpAuthUser = true;
			    		break;
			    	}
			    }

				if (!isInputMember && !isExpAuthUser) {
					// 해당 프로젝트는 지출결의서 상신 옵션이 Y
					// (해당 프로젝트 투입 인력이 아니므로 지결서 상신 불가)
					return "Y";
				}
			} else if (projectVO.getManageCostRule().equals("N")) {
				// 해당 프로젝트는 지출결의서 상신 옵션이 N
				// (지결서 상신 불가)
				return "N";
			}
        }
        
        // 지결서 상신 가능
		return "T";
	}

	@Override
	public String checkApprovalHol(ApprovalHolVO approvalHolVO) throws UnsupportedEncodingException, ParseException, FdlException {
        boolean result = false;
        
        String prjId = (String) approvalHolVO.getPrjId();
        
		ProjectVO searchProjectVO = new ProjectVO();
		searchProjectVO.setPrjId(prjId);
		ProjectVO projectVO = projectService.selectProjectView(searchProjectVO);
        
	
		if (projectVO.getManageCostRule().equals("Y")) {
			ProjectInputVO projectInputVO = new ProjectInputVO();
			projectInputVO.setPrjId(prjId);
			projectInputVO.setYear(Integer.toString(CalendarUtil.getYear()));
			List<EgovMap> prjInputList = projectService.selectProjectInput(projectInputVO);
			
		    boolean isInputMember = false;
			for (int i = 0; i < prjInputList.size(); i++) {
				if (prjInputList.get(i) == null)
					continue;
				EgovMap egovMap = (EgovMap) prjInputList.get(i);
				
			    if (egovMap.get("userNo").equals(approvalHolVO.getUserNo()))
				{
					int input = 0;
					input = Integer.parseInt(egovMap.get("month" + CalendarUtil.getMonth() + "List").toString());
					
					if (input == 1) {
						isInputMember = true;
						i = prjInputList.size();
						break;
					}
				}
			}
			
			if (!isInputMember) {
				// 해당 프로젝트는 비용지출 옵션이 Y
				// (해당 프로젝트 투입 인력이 아니므로 휴일근무보고서 상신 불가)
				return "Y";
			}
		} else if (projectVO.getManageCostRule().equals("N")) {
			// 해당 프로젝트는 비용지출 상신 옵션이 N
			// (지결서 상신 불가)
			return "N";
		}
        
        // 휴일근무보고서 상신 가능
		return "T";
	}
	@Override
	public String varifySaveDocApprovalExpense(JSONArray expenseArrayJ) 
		throws UnsupportedEncodingException, ParseException, FdlException {
	
		Iterator it = expenseArrayJ.iterator();
		                
        it = expenseArrayJ.iterator();
        while(it.hasNext()) {
        	JSONObject ob = (JSONObject)it.next();
        	String prjId = (String) ob.get("prjId");
    		ob.put("expBudgetPrj", approvalDAO.selectBudgetPrj(prjId));
    		
    		//판관비계획 금액초과 검사 //잔여금액 - 지출결의 금액
    		Long remainPlanExp = approvalDAO.selectRemainPlanExp(ob);
    		Long expSpend = Long.parseLong(String.valueOf(ob.get("expSpend")) );
    		remainPlanExp = remainPlanExp - expSpend;
        	if( remainPlanExp < 0) { //잔여금액이 마이너스
        		ob.put("exceedManage","Y");     		
        	} else {
        		ob.put("exceedManage","N");
        	} 
        	//기한초과 검사
        	String expDt = (String) ob.get("expDt");
        	int expYear = Integer.parseInt(expDt.substring(0, 4));
        	int expMonth = Integer.parseInt(expDt.substring(4, 6)) - 1;
        	int expDate = Integer.parseInt(expDt.substring(6, 8));
        	//밀리초 단위 비교라서 오늘 기준을 먼저 선언해야함
        	Calendar thisCal = Calendar.getInstance(); 
        	Calendar cal = Calendar.getInstance();
        	cal.set(expYear, expMonth, expDate);
        	cal.add(cal.DATE, 7);        	        
        	if (cal.compareTo(thisCal) < 0) {
        		ob.put("expiredDate","Y");
        	} else {
        		ob.put("expiredDate","N");
        	}        	
        	approvalDAO.updateExpExceedManage(ob);
        }
        return "TT";   
	}
	
	@Override
	public String insertApprovalExpense(ApprovalExpenseVO approvalExpenseVO) 
		throws UnsupportedEncodingException, ParseException, FdlException {
		
		//지출결의서 10업무경비 11자기개발비 12부서운영비(미사용) 13상품매입
		String expenseArray = CommonUtil.unescape(approvalExpenseVO.getExpenseArrayJ());
        JSONArray expenseArrayJ =  (JSONArray)JSONValue.parseWithException(expenseArray);
        Iterator it = expenseArrayJ.iterator();
        String exceedManage = "F";
        String expiredDate = "F";
        String cardSpendNoManage = "F";
        
        while(it.hasNext()) {
        	JSONObject ob = (JSONObject)it.next();
        	String expId = expIdgenService.getNextStringId();
        	String prjId = (String) ob.get("prjId");
        	ob.put("docId", approvalExpenseVO.getDocId());
        	ob.put("expId", expId);
        	ob.put("expBudgetPrj", approvalDAO.selectBudgetPrj(prjId));
        	
        	//13상품매입 외 10업무경비 11자기개발비 경우 판관비 초과여부 검사 
        	if(approvalExpenseVO.getTempltId() != 13) {      	
                Long remainPlanExp = approvalDAO.selectRemainPlanExp(ob);            	
        		remainPlanExp = remainPlanExp - (Long) ob.get("expSpend");
	        	if( remainPlanExp < 0) { //잔여금액이 마이너스
	        		ob.put("exceedManage","Y");
	        		exceedManage = "T";
	        	} else
	        		ob.put("exceedManage","N");
        	}
        	//기한초과 검사
        	String expDt = (String) ob.get("expDt");
        	int expYear = Integer.parseInt(expDt.substring(0, 4));
        	int expMonth = Integer.parseInt(expDt.substring(4, 6)) - 1;
        	int expDate = Integer.parseInt(expDt.substring(6, 8));
        	//밀리초 단위 비교라서 오늘 기준을 먼저 선언해야 한다.
        	Calendar thisCal = Calendar.getInstance(); 
        	Calendar cal = Calendar.getInstance();
        	cal.set(expYear, expMonth, expDate);
        	cal.add(cal.DATE, 7);        	        
        	if (cal.compareTo(thisCal) < 0) {
        		ob.put("expiredDate","Y");
        		expiredDate = "T";
        	} else {
        		ob.put("expiredDate","N");
        	}
        	//Debug watch 용도
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        	String tmp = sdf.format(cal.getTime());
        	String tmp2 = sdf.format(thisCal.getTime());
        	
        	String expSpendTyp = ob.get("expSpendTyp").toString();
        	// 회사결재(CP)이고 선지급이 아닐 경우 자금보고 건 INSERT (바로 상신하는 경우만)
    		//save==0 상신 save==1 문서 저장 (최초상신)
        	//save==2 저장문서 업데이트 save==3 저장 문서 업데이트 & 상신 (저장문서 수정)        	
        	if (approvalExpenseVO.getSave() != 1 && approvalExpenseVO.getSave() != 3 && 
        			expSpendTyp.equals("CP") && ob.get("alreadyPaid") == null) {
        		Map<String, Object> m = new HashMap<String, Object>();
        		m.put("docId", ob.get("docId").toString());
            	m.put("prjId", ob.get("prjId").toString());
            	m.put("date", ob.get("payingDueDate").toString());
            	m.put("expense", Long.parseLong(ob.get("expSpend").toString()));
            	//IE9에서 문서 재사용하거나 뒤로 가기해서 상신할 경우 expCt 값이 없어서 널포인터 예외 발생하는 경우가 있음. 
            	//정확한 조건 재현은 안되고 여러번 시도하면 가끔 발생하므로 일단 여기서 핸들링 2013-02-19
            	if(ob.get("expCt") == null)  
            		m.put("note", "");
            	else
            		m.put("note", ob.get("expCt").toString());
            	m.put("companyCd", ob.get("companyCd").toString());
            	m.put("plan", "Y");
            	m.put("type", "W");
            	m.put("bankBook", "");
            	m.put("account", "");
            	fundDAO.insertFund(m);
        	}
        	        	
        	/* 재고 출고 관련 로직
        	String stockList = "";
        	// 출고목록 임시 저장 (전결 시점에서 실제로 출고됨)
        	if (ob.get("tmpSaveStockList") != null) {
	        	Map<String, Object> stockParam = new HashMap<String, Object>();
	        	stockParam.put("status", 0);
	        	stockParam.put("tempSaverNo", approvalExpenseVO.getWriterNo());
	        	stockParam.put("expId", approvalExpenseVO.getExpId());
	        	stockParam.put("tmpSaveStockList", ob.get("tmpSaveStockList").toString().split(","));
	        	stockDAO.updateStock(stockParam);
	        	
	        	stockList = ob.get("tmpSaveStockList").toString();
        	}
        	ob.put("stockList", stockList);
        	*/
        	
        	String cardSpendNo = "";
        	if(ob.get("cardSpendNo") != null)
        		cardSpendNo = ob.get("cardSpendNo").toString();
        	
        	boolean insertExpBool = true;
        	//법인카드인 경우 tbl_card_spend 테이블에 status = 3 경우에만 입력
        	if (expSpendTyp.equals("CC")) {
        		if(cardSpendNo.equals(""))
        			insertExpBool = false;
        		String status = approvalDAO.selectCardSpendNoStatus(cardSpendNo);
        		if(status.equals("3") == false) // 결재실패, 미상신 3 이면 입력, 결재중 1 전결승인완료 2 이미 상신되었으면 실패
        			insertExpBool = false;
        	}
        	
        	//jsonObject 자체가 맵이므로 그대로 사용해서 insert 가능.
        	if(insertExpBool)
        		approvalDAO.insertApprovalExpense(ob);
        	else
        		cardSpendNoManage = "T"; //이미 상신된 카드번호 
        	
        	//회식비일 경우 추가 테이블에 자료 삽입 (미사용 양식)
        	if(approvalExpenseVO.getTempltId() == 12) {
        		JSONArray orgnztIdArray = (JSONArray)ob.get("expDiningOrgnztId");
        		JSONArray spendArray = (JSONArray)ob.get("expDiningSpend");
        		Iterator it2 = orgnztIdArray.iterator();
        		Iterator it3 = spendArray.iterator();
        		while(it2.hasNext()) {
        			String orgnztId  = (String)it2.next();
        			long diningSpend  = (Long)it3.next();
        			JSONObject js = new JSONObject();
        			js.put("expId",expId );
        			js.put("orgnztId", orgnztId);
        			js.put("diningSpend", diningSpend);
        			approvalDAO.insertApprovalDining(js);
        		}
        	}
        }
        
        return exceedManage + expiredDate + cardSpendNoManage;
	}

	@Override
	public List<JSONObject> selectExpenseList(ApprovalVO searchVO) {
		
		List<JSONObject> result = approvalDAO.selectExpenseList(searchVO);
		//회식비일 경우 추가 정보를 더 불러옴 //회식비 사용안함
		if("12".equals(searchVO.getTempltId())) {
			Iterator it = result.iterator();
			while(it.hasNext()) {
				JSONObject obj = (JSONObject) it.next();
				String expId = (String)obj.get("expId");
				obj.put("expDiningList",approvalDAO.selectDiningList(expId));				
			}
		}		
		//매출영업비일 경우 추가 정보를 더 불러옴. 
		if("13".equals(searchVO.getTempltId())) {
			Iterator it = result.iterator();
			while(it.hasNext()) {
				JSONObject obj = (JSONObject) it.next();
				obj.putAll(approvalDAO.selectExpenseSalesDocInfo(obj));				
			}
		}		
		return result;
	}

	@Override
	public int selectExpenseCnt(ApprovalVO searchVO) {
		return approvalDAO.selectExpenseCnt(searchVO);
	}
	
	@Override
	public JSONObject selectExpenseSum(ApprovalVO searchVO) {
		return approvalDAO.selectExpenseSum(searchVO);
	}

	@Override
	public ApprovalHolVO viewApprovalHol(ApprovalVO searchVO) {
		return approvalDAO.viewApprovalHol(searchVO);
	}

	@Override
	public String insertApprovalHol(ApprovalHolVO approvalHolVO) {
        boolean exceedManage = false;

    	JSONObject planExpOb = new JSONObject();
    	planExpOb.put("expDt", (String) approvalHolVO.getStDt());
    	planExpOb.put("expBudgetPrj", (String) approvalHolVO.getPrjId());

    	JSONObject holSalaryOb = salaryHolService.selectUserHolSalaryInfo(approvalHolVO);
    	BigInteger cost = (BigInteger) holSalaryOb.get("maxSalary");

    	if(approvalDAO.selectRemainPlanExp(planExpOb) - cost.longValue() < 0) {
    		exceedManage = true;
    		approvalHolVO.setExceedManage("Y");
    	}
    	
        approvalDAO.insertApprovalHol(approvalHolVO);
        
        if (exceedManage) {
        	return "TF";
        } else {
        	return "FF";
        }
       
	}


	@Override
	public String insertApprovalTotalSales(JSONObject totalSalesJ) {
		String sPrjId = (String) totalSalesJ.get("sPrjId");
		String pPrjId = (String) totalSalesJ.get("pPrjId");
		String docId  = (String) totalSalesJ.get("docId");
		long stYear = (Long) totalSalesJ.get("stYear");
		long stMonth = (Long) totalSalesJ.get("stMonth");
		String decideYn = (String) totalSalesJ.get("decideYn");
		//save doc
		
		// 20140731, 매출액이 1천만원 이상인 경우 "T", 아니면 "F"
		String resultStr = "F";
		long cost = Long.parseLong(totalSalesJ.get("salesSum").toString());
		if (cost >= 10000000)
			/**
			 * @author 이유수
			 * 새하컴즈와 도사 대표이사 분리로 인하여 1000만원 이상이어도 F로 동작하도록 수정.
			 */
			resultStr = "F";
		
		JSONObject doc = new JSONObject();
		
		doc.put("docId",totalSalesJ.get("docId"));
		doc.put("sPrjId",sPrjId);
		doc.put("pPrjId",pPrjId);
		doc.put("cost", totalSalesJ.get("salesSum"));
		doc.put("deposit", totalSalesJ.get("deposit"));
		doc.put("maintenance", totalSalesJ.get("maintenance"));
		doc.put("stDt",totalSalesJ.get("stDt"));
		doc.put("edDt",totalSalesJ.get("edDt"));
		doc.put("colDueDt",totalSalesJ.get("colDueDt"));
		doc.put("salesSj", totalSalesJ.get("salesSj"));
		doc.put("decideYn",decideYn);
		approvalDAO.insertApprovalTotalSalesDoc(doc);
		
		//insert Sales
		JSONArray salesArray = (JSONArray) totalSalesJ.get("salesObj");
		if(salesArray!=null)
		{
			Iterator it = salesArray.iterator();
			while(it.hasNext())
			{
				JSONObject sales = (JSONObject) it.next();
				sales.put("prjId", sPrjId);
				sales.put("docId", docId);
				sales.put("ct", totalSalesJ.get("salesSj"));
				sales.put("decideYn",decideYn);
				approvalDAO.insertSales(sales);
			}
		}
		
		//insert purchaseOut
		JSONArray purchaseOutArray = (JSONArray) totalSalesJ.get("purchaseOutObj");
		if(purchaseOutArray !=null)
		{
			Iterator it = purchaseOutArray.iterator();
			while(it.hasNext())
			{	
				JSONObject purchaseOut = (JSONObject) it.next();
				purchaseOut.put("prjId", sPrjId);
				purchaseOut.put("docId", docId);
				purchaseOut.put("decideYn",decideYn);
				approvalDAO.insertPurchaseOut(purchaseOut);
			}
		}
		
		//insert purchaseIn
		JSONArray purchaseInGeneralArray = (JSONArray) totalSalesJ.get("purchaseInGeneralObj");
		if(purchaseInGeneralArray !=null) {
			Iterator it = purchaseInGeneralArray.iterator();
			while(it.hasNext()) {
				JSONObject purchaseIn = (JSONObject) it.next();
				purchaseIn.put("sPrjId", sPrjId);
				purchaseIn.put("typ", "G");
				purchaseIn.put("docId", docId);
				purchaseIn.put("decideYn",decideYn);
				approvalDAO.insertPurchaseIn(purchaseIn);
			}
		}
		
		JSONObject sPrjExpenseObj = (JSONObject) totalSalesJ.get("sPrjExpenseObj");
		Set set = sPrjExpenseObj.keySet();
		Iterator it = set.iterator();
		while(it.hasNext()) {
			String year = (String)it.next();
			JSONObject expenseYear = (JSONObject) sPrjExpenseObj.get(year);
			for(int i =1 ; i<=12; i++) {
				JSONObject expenseMonth = (JSONObject) expenseYear.get(""+i);
				//if에 걸리는 경우가 있으면 안됨.
				if(expenseMonth==null)
					continue;
				else {
					expenseMonth.put("typ", "S");
					expenseMonth.put("prjId", sPrjId);
					expenseMonth.put("docId", docId);
					expenseMonth.put("year",year);
					expenseMonth.put("month", i);
					expenseMonth.put("decideYn",decideYn);
					approvalDAO.insertPlanExpense(expenseMonth);					
				}
			}
		}
		
		/* 2012.4.19 추가
		 * 날짜 단위로 인력투입 insert */
		// 1. 기존의 eapp_user_input 데이터 삭제
		JSONObject delUserInputObj = new JSONObject();
		delUserInputObj.put("docId", docId);
		approvalDAO.deleteUserInput(delUserInputObj);
		// 2. 신규 데이터 eapp_user_input 에 insert
		JSONArray userInputObjArray = (JSONArray) totalSalesJ.get("userInputObj");
		if(userInputObjArray != null)
		{
			Iterator itr = userInputObjArray.iterator();
			while(itr.hasNext())
			{
				JSONObject userInput = (JSONObject) itr.next();
				userInput.put("docId", docId);
				approvalDAO.insertUserInput(userInput);
			}
		}
		
		JSONObject pPrjLaborObj = (JSONObject) totalSalesJ.get("pPrjLaborObj");
		set = pPrjLaborObj.keySet();
		it = set.iterator();
		while(it.hasNext())
		{
			String year = (String)it.next();
			JSONObject laborYear = (JSONObject)  pPrjLaborObj.get(year);
			for(int i =1 ; i<=12; i++)
			{
				JSONObject laborMonth = (JSONObject) laborYear.get(""+i);
				//if에 걸리는 경우가 있으면 안됨.
				if(laborMonth==null)
					continue;
				else
				{
					JSONObject userArray = (JSONObject) laborMonth.get("user");
					Set set2 = userArray.keySet();
					Iterator it2 = set2.iterator();
					while(it2.hasNext())
					{
						JSONObject user = (JSONObject) userArray.get(it2.next());
						user.put("typ", "P");
						user.put("prjId", pPrjId);
						user.put("docId", docId);
						user.put("year",year);
						user.put("month",i);
						user.put("decideYn",decideYn);
						approvalDAO.insertPlanLabor(user);
						
						//p project의 경우 사내매입에도 값을 넣어준다.
						user.put("sPrjId", sPrjId);
						user.put("pPrjId", pPrjId);
						approvalDAO.insertPurchaseInLabor(user);
					}
					
				}
			}
		}
		JSONObject pPrjExpenseObj = (JSONObject) totalSalesJ.get("pPrjExpenseObj");
		set = pPrjExpenseObj.keySet();
		it = set.iterator();
		while(it.hasNext())
		{
			String year = (String)it.next();
			JSONObject expenseYear = (JSONObject) pPrjExpenseObj.get(year);
			for(int i =1 ; i<=12; i++)
			{
				JSONObject expenseMonth = (JSONObject) expenseYear.get(""+i);
				
				//if에 걸리는 경우가 있으면 안됨.
				if(expenseMonth==null)
					continue;
				else
				{
					expenseMonth.put("typ", "P");
					expenseMonth.put("prjId", pPrjId);
					expenseMonth.put("docId", docId);
					expenseMonth.put("year", year);
					expenseMonth.put("month", i);
					expenseMonth.put("decideYn",decideYn);
					approvalDAO.insertPlanExpense(expenseMonth);
					
					//p project의 경우 사내매입에도 값을 넣어준다.
					expenseMonth.put("sPrjId", sPrjId);
					expenseMonth.put("pPrjId", pPrjId);
					expenseMonth.put("typ", "PE");
					approvalDAO.insertPurchaseIn(expenseMonth);
				}
			}
		}
		
		return resultStr;
	}
	//종합매출보고서 시작 //불러온 기초 데이터는 approval20.jquery.js 에서 가공해서 jsp 에 데이터 생성
	@Override
	public JSONObject selectTotalSales(ApprovalVO searchVO) {
		
		JSONObject doc = new JSONObject();
		String docId = searchVO.getDocId();
		doc = approvalDAO.selectApprovalTotalSalesDoc(docId);
		doc.put("salesObj",approvalDAO.selectSales(docId));
		doc.put("purchaseOutObj",approvalDAO.selectPurchaseOut(docId));
		JSONObject searchJ = new JSONObject();
		searchJ.put("docId",docId);
		searchJ.put("typ", "G");
		doc.put("purchaseInGeneralObj",approvalDAO.selectPurchaseIn(searchJ));
		
		JSONObject pPrjLaborObj = new JSONObject();
		JSONObject sPrjExpenseObj = new JSONObject();
		JSONObject pPrjExpenseObj = new JSONObject();
		int stYear, stMonth, edYear, edMonth;
		stYear = Integer.parseInt((String)doc.get("stYear"));
		stMonth = Integer.parseInt((String)doc.get("stMonth"));
		edYear = Integer.parseInt((String)doc.get("edYear"));
		edMonth= Integer.parseInt((String)doc.get("edMonth"));
		int searchYear = stYear;
		while(searchYear <= edYear) {
			searchJ = new JSONObject();
			searchJ.put("year",searchYear);
			JSONObject pPrjLaborYear = new JSONObject();
			pPrjLaborYear.put("_valid",true);
			pPrjLaborYear.put("year",searchYear);
			for(int searchMonth=1; searchMonth<=12; searchMonth++) {
				JSONObject laborMonth = new JSONObject();
				
				if((searchYear==stYear&& searchMonth<stMonth) || (searchYear==edYear && searchMonth>edMonth))
					laborMonth.put("_valid", false);
				else
					laborMonth.put("_valid", true);
				searchJ.put("month",searchMonth);
				searchJ.put("typ", "P");
				searchJ.put("docId",docId);
				JSONObject user = new JSONObject();
				List laborList = approvalDAO.selectPlanLabor(searchJ);
				Iterator it = laborList.iterator();
				while(it.hasNext()) {
					JSONObject js = (JSONObject) it.next();
					user.put(js.get("userId"), js);
				}
				laborMonth.put("user", user);
				pPrjLaborYear.put(searchMonth,laborMonth);
			}
			pPrjLaborObj.put(searchYear, pPrjLaborYear);
			searchYear++;
		}
		doc.put("pPrjLaborObj", pPrjLaborObj);		
		doc.put("userInputObj", approvalDAO.selectUserInput(searchJ));
		
		searchYear = stYear;
		while(searchYear<=edYear) {
			searchJ = new JSONObject();
			searchJ.put("year",searchYear);
			JSONObject sPrjExpenseYear = new JSONObject();
			sPrjExpenseYear.put("_valid",true);
			sPrjExpenseYear.put("year",searchYear);
			for(int searchMonth=1; searchMonth<=12; searchMonth++) {
				searchJ.put("typ", "S");
				searchJ.put("docId",docId);
				searchJ.put("month",searchMonth);
				List expenseList = approvalDAO.selectPlanExpense(searchJ);
				JSONObject expenseMonth = new JSONObject();
				if(expenseList.size() > 0)
					expenseMonth = (JSONObject) expenseList.get(0);
				//JSONObject expenseMonth = (JSONObject) expenseList.get(0);
				if((searchYear==stYear && searchMonth<stMonth) || (searchYear==edYear&& searchMonth>edMonth))
					expenseMonth.put("_valid", false);
				else
					expenseMonth.put("_valid", true);				
				sPrjExpenseYear.put(searchMonth,expenseMonth);
			}
			sPrjExpenseObj.put(searchYear, sPrjExpenseYear);
			searchYear++;
		}
		doc.put("sPrjExpenseObj",sPrjExpenseObj);
		
		searchYear = stYear;
		while(searchYear <= edYear) {
			searchJ = new JSONObject();
			searchJ.put("year", searchYear);
			JSONObject pPrjExpenseYear = new JSONObject();
			pPrjExpenseYear.put("_valid",true);
			pPrjExpenseYear.put("year",searchYear);
			for(int searchMonth=1; searchMonth<=12; searchMonth++) {
				searchJ.put("typ", "P");
				searchJ.put("docId",docId);
				searchJ.put("month",searchMonth);
				List expenseList = approvalDAO.selectPlanExpense(searchJ);
				JSONObject expenseMonth = new JSONObject();
				if(expenseList.size() > 0)
					expenseMonth = (JSONObject) expenseList.get(0);
				//JSONObject expenseMonth = (JSONObject) expenseList.get(0);
				if((searchYear==stYear&& searchMonth<stMonth) ||(searchYear==edYear&& searchMonth>edMonth))
					expenseMonth.put("_valid", false);
				else
					expenseMonth.put("_valid", true);
				
				pPrjExpenseYear.put(searchMonth,expenseMonth);
			}
			pPrjExpenseObj.put(searchYear, pPrjExpenseYear);
			searchYear++;
		}
		doc.put("pPrjExpenseObj",pPrjExpenseObj);		
		return doc;
	}
	//종합매출보고서 끝
	
	//일반매출보고서 시작
	@Override
	public String insertApprovalGeneralSales(JSONObject generalSalesJ) {
		String sPrjId = (String) generalSalesJ.get("sPrjId");
		String docId  = (String) generalSalesJ.get("docId");
		long stYear = (Long) generalSalesJ.get("stYear");
		long stMonth = (Long) generalSalesJ.get("stMonth");
		String decideYn = (String) generalSalesJ.get("decideYn");
		String stDt = (String) generalSalesJ.get("stDt");
		String colDueDt = (String) generalSalesJ.get("colDueDt");	// 2014-04-22 최종수금예정일 추가
		if(stDt != null && stDt.length() > 5) {
			//문서 재사용시 approval21.jquery.js 파일 기능 오류로 인해 변경된 매출 일자가 stYear, stMonth 반영이 안되는 오류
			//일반매출보고서는 매출 일자에 다 따라가므로 여기서 일괄 수정 2013-02-22
			stYear = Long.parseLong(stDt.substring(0,4));
			stMonth = Long.parseLong(stDt.substring(4,6));
		}
		
		// 20140731, 매출액이 1천만원 이상인 경우 "T", 아니면 "F"
		String resultStr = "F";
		long cost = Long.parseLong(generalSalesJ.get("cost").toString());
		if (cost >= 10000000)
			/**
			 * @author 이유수
			 * 새하컴즈와 도사 대표이사 분리로 인하여 1000만원 이상이어도 F로 동작하도록 수정.
			 */
			resultStr = "F";
		
		//save doc 일반매출
		JSONObject doc = new JSONObject();
		
		doc.put("docId",generalSalesJ.get("docId"));
		doc.put("sPrjId",sPrjId);
		doc.put("cost", generalSalesJ.get("cost"));
		doc.put("stDt", stDt);
		doc.put("colDueDt", colDueDt);
		doc.put("salesSj", generalSalesJ.get("salesSj"));
		doc.put("decideYn", decideYn);
		approvalDAO.insertApprovalGeneralSalesDoc(doc);
		
		//insert Sales 매출
		JSONArray salesArray = (JSONArray) generalSalesJ.get("salesObj");
		Iterator it = salesArray.iterator();
		while(it.hasNext()) {
			JSONObject sales = (JSONObject) it.next();
			sales.put("prjId", sPrjId);
			sales.put("docId", docId);
			sales.put("ct", generalSalesJ.get("salesSj"));
			sales.put("decideYn", decideYn);
			approvalDAO.insertSales(sales);
		}
		
		//insert purchaseOut 사외매입
		JSONArray purchaseOutArray = (JSONArray) generalSalesJ.get("purchaseOutObj");
		it = purchaseOutArray.iterator();
		while(it.hasNext()) {	
			JSONObject purchaseOut = (JSONObject) it.next();
			purchaseOut.put("prjId", sPrjId);
			purchaseOut.put("docId", docId);
			purchaseOut.put("decideYn", decideYn);
			//재사용 날짜 오류 해결 날짜 설정
			purchaseOut.put("year", stYear);
			purchaseOut.put("month", stMonth);
			approvalDAO.insertPurchaseOut(purchaseOut);
		}
		
		//insert purchaseIn 사내매입
		JSONArray jsArray = (JSONArray) generalSalesJ.get("purchaseInGeneralObj");
		it = jsArray.iterator();
		while(it.hasNext()) {
			JSONObject js = (JSONObject) it.next();
			js.put("sPrjId", sPrjId);
			js.put("typ", "G");
			js.put("docId", docId);
			js.put("decideYn", decideYn);
			//재사용 날짜 오류 해결 날짜 설정
			js.put("year", stYear);
			js.put("month", stMonth);
			approvalDAO.insertPurchaseIn(js);
		}
		
		//insert expenseObj 영업경비
		JSONArray expenseArray = (JSONArray) generalSalesJ.get("expenseObj");
		it = expenseArray.iterator();
		while(it.hasNext()) {
			JSONObject expense = (JSONObject) it.next();
			expense.put("prjId", sPrjId);
			expense.put("docId", docId);
			expense.put("decideYn", decideYn);
			//재사용 날짜 오류 해결 날짜 설정
			expense.put("year", stYear);
			expense.put("month", stMonth);
			approvalDAO.insertPlanExpense(expense);
		}
		
		return resultStr;
	}


	@Override
	public JSONObject selectGeneneralSales(ApprovalVO searchVO) {
		//save doc
		String docId = searchVO.getDocId();
		JSONObject doc = new JSONObject();
		doc = approvalDAO.selectApprovalGeneralSalesDoc(docId);
		doc.put("salesObj",approvalDAO.selectSales(docId));
		doc.put("purchaseOutObj",approvalDAO.selectPurchaseOut(docId));
		JSONObject searchJ = new JSONObject();
		searchJ.put("docId",docId);
		doc.put("purchaseInGeneralObj",approvalDAO.selectPurchaseIn(searchJ));
		searchJ.put("docId",docId);
		doc.put("expenseObj",approvalDAO.selectPlanExpense(searchJ));
		return doc;
	}



	@Override
	public List<HolidayWorkStatistic> selectHolidayWorkStatisticList(HolidayWorkStatistic searchVO) throws Exception {
		return approvalDAO.selectHolidayWorkStatisticList(searchVO);
	}
	
	@Override
	public HolidayWorkStatistic selectHolidayWorkStatistic(HolidayWorkStatistic searchVO) throws Exception {
		return approvalDAO.selectHolidayWorkStatistic(searchVO);
	}
	
	@Override
	public List<HolidayWorkDetail> selectHolidayWorkDetail(HolidayWorkStatistic searchVO) throws Exception {
		return approvalDAO.selectHolidayWorkDetail(searchVO);
	}



	

	@Override
	public List<SelfDevStatistic> selectSelfDevStatisticList(SelfDevStatistic searchVO) throws Exception {
		return approvalDAO.selectSelfDevStatisticList(searchVO);
	}
	
	@Override
	public SelfDevStatistic selectSelfDevStatistic(SelfDevStatistic searchVO) throws Exception {
		return approvalDAO.selectSelfDevStatistic(searchVO);
	}
	
	@Override
	public List<SelfDevDetail> selectSelfDevStatisticDetail(SelfDevDetail searchVO) throws Exception {
		return approvalDAO.selectSelfDevStatisticDetail(searchVO);
	}

	@Override
	public void updateApprovalCmm(ApprovalVO approvalVO) { //이 함수를 호출하는 부분이 없음
		approvalDAO.updateApprovalCmm(approvalVO);		
	}

	@Override
	public void insertApprovalBusinessPlan(
			ApprovalBusinessPlanVO bulkVO) {
		for(int i=0; i<12 ;i++)
		{
			String month = i+1 <10 ? "0"+ (i+1) : ""+ (i+1);
			ApprovalBusinessPlanVO vo = new ApprovalBusinessPlanVO();
			vo.setDocId(bulkVO.getDocId());
			vo.setOrgnztId(bulkVO.getOrgnztId());
			vo.setSalesOut(bulkVO.getSalesOutList()[i]);
			vo.setSalesIn(bulkVO.getSalesInList()[i]);
			vo.setPurchaseOut(bulkVO.getPurchaseOutList()[i]);
			vo.setPurchaseIn(bulkVO.getPurchaseInList()[i]);
			vo.setLabor(bulkVO.getLaborList()[i]);
			vo.setExpense(bulkVO.getExpenseList()[i]);
			vo.setYyyymm(Integer.toString(bulkVO.getYear()) + month);
			approvalDAO.insertApprovalBusinessPlan(vo);
			
			//사내매입에 공통비를 넣음. typ 는 C.
			JSONObject js = new JSONObject();
			js.put("docId", bulkVO.getDocId());
			js.put("sPrjId", bulkVO.getSalesPrjId());
			js.put("pPrjId", bulkVO.getPurchasePrjId());
			js.put("typ", "C");
			js.put("cost", bulkVO.getPurchaseInCommonList()[i]);
			js.put("year", bulkVO.getYear());
			js.put("month", i+1);
			js.put("decideYn", "Y");
			approvalDAO.insertPurchaseIn(js);
			
		}
		
	}


	@Override
	public List<ApprovalBusinessPlanVO> selectBusinessPlan(ApprovalVO searchVO) {
		return approvalDAO.selectBusinessPlanList(searchVO);
	}


	@Override
	public void insertBudgetAllocate(JSONObject budgetAllocateJ) throws IdMixInputException {
		
		int year = Integer.parseInt((String) budgetAllocateJ.get("year"));
		JSONArray expenseList = (JSONArray) budgetAllocateJ.get("expense");
		JSONArray laborList = (JSONArray) budgetAllocateJ.get("labor"); // 미사용
		String userId = CommonUtil.parseIdFromMixs((String)budgetAllocateJ.get("userMix"))[0];
		String docId = (String)  budgetAllocateJ.get("docId");
		String decideYn = "Y";
		budgetAllocateJ.put("userId",userId);
		approvalDAO.insertBudgetAllocate(budgetAllocateJ);
		
		if(expenseList != null) {
			Iterator it = expenseList.iterator();
			int identifyNo = 0;
			while(it.hasNext()) { //추가된 개수대로 반복
				JSONObject expenseTotal = (JSONObject) it.next();
				JSONArray monthList = (JSONArray) expenseTotal.get("month");
				Iterator it2 = monthList.iterator();
				int month = 1;
				
				while(it2.hasNext()) { //12개월 12번 반복
					JSONObject expense = new JSONObject();
					long cost = (Long) it2.next();
					expense.put("docId", docId);
					expense.put("cost", cost);
					expense.put("year", year);
					expense.put("prjId", expenseTotal.get("prjId"));
					expense.put("month",month);
					expense.put("identifyNo",identifyNo);
					expense.put("decideYn",decideYn);
					approvalDAO.insertPlanExpense(expense);
					month++;
				}
				identifyNo ++;
			}
		}	
	}
	
	public JSONObject selectBudgetAllocateDoc(ApprovalVO searchVO) {
		return approvalDAO.selectBudgetAllocate(searchVO);
	}
	/*
	public List selectBudgetAllocateLaborList(ApprovalVO searchVO)
	{
		return approvalDAO.selectBudgetAllocateLaborList(searchVO);
	}*/
	public List selectBudgetAllocateExpenseList(ApprovalVO searchVO)
	{
		return approvalDAO.selectBudgetAllocateExpenseList(searchVO);
	}

	
	@Override
	public void insertBudgetAllocate2(JSONObject totalSalesJ) {
		String prjId = (String) totalSalesJ.get("prjId");
		String docId  = (String) totalSalesJ.get("docId");
		long stYear = (Long) totalSalesJ.get("stYear");
		long stMonth = (Long) totalSalesJ.get("stMonth");
		
		JSONObject doc = new JSONObject();
		
		doc.put("docId",totalSalesJ.get("docId"));
		doc.put("prjId",prjId);
		doc.put("stDt",totalSalesJ.get("stDt"));
		doc.put("edDt",totalSalesJ.get("edDt"));
		doc.put("salesSj", totalSalesJ.get("salesSj"));
		doc.put("decideYn","Y");
		approvalDAO.insertBudgetAllocate2(doc);
		
		JSONObject prjLaborObj = (JSONObject) totalSalesJ.get("prjLaborObj");
		Set set = prjLaborObj.keySet();
		Iterator it = set.iterator();
		while(it.hasNext())
		{
			String year = (String)it.next();
			JSONObject laborYear = (JSONObject)  prjLaborObj.get(year);
			for(int i =1 ; i<=12; i++)
			{
				JSONObject laborMonth = (JSONObject) laborYear.get(""+i);
				//if에 걸리는 경우가 있으면 안됨.
				if(laborMonth==null)
					continue;
				else
				{
					JSONObject userArray = (JSONObject) laborMonth.get("user");
					Set set2 = userArray.keySet();
					Iterator it2 = set2.iterator();
					while(it2.hasNext())
					{
						JSONObject user = (JSONObject) userArray.get(it2.next());
						user.put("typ", "S");
						user.put("prjId", prjId);
						user.put("docId", docId);
						user.put("year",year);
						user.put("month",i);
						user.put("decideYn","Y");
						approvalDAO.insertPlanLabor(user);
					}
					
				}
			}
		}
		
		JSONObject prjExpenseObj = (JSONObject) totalSalesJ.get("prjExpenseObj");
		set = prjExpenseObj.keySet();
		it = set.iterator();
		while(it.hasNext())
		{
			String year = (String)it.next();
			JSONObject expenseYear = (JSONObject) prjExpenseObj.get(year);
			for(int i =1 ; i<=12; i++)
			{
				JSONObject expenseMonth = (JSONObject) expenseYear.get(""+i);
				//if에 걸리는 경우가 있으면 안됨.
				if(expenseMonth==null)
					continue;
				else
				{
					expenseMonth.put("typ", "S");
					expenseMonth.put("prjId", prjId);
					expenseMonth.put("docId", docId);
					expenseMonth.put("year",year);
					expenseMonth.put("month", i);
					expenseMonth.put("decideYn","Y");
					approvalDAO.insertPlanExpense(expenseMonth);
				}
			}
		}
	}
	
	@Override
	public JSONObject selectBudgetAllocate2(ApprovalVO searchVO) {
		
		/*JSONObject doc = new JSONObject();
		
		doc = approvalDAO.selectApprovalTotalSalesDoc(docId);
		doc.put("salesObj",approvalDAO.selectSales(docId));
		doc.put("purchaseOutObj",approvalDAO.selectPurchaseOut(docId));*/
		String docId = searchVO.getDocId();
		JSONObject doc = approvalDAO.selectBudgetAllocate2(docId); 
		JSONObject searchJ = new JSONObject();
		searchJ.put("docId",docId);
		
		JSONObject prjLaborObj = new JSONObject();
		JSONObject prjExpenseObj = new JSONObject();
		int stYear, stMonth, edYear, edMonth;
		stYear = Integer.parseInt((String)doc.get("stYear"));
		stMonth = Integer.parseInt((String)doc.get("stMonth"));
		edYear = Integer.parseInt((String)doc.get("edYear"));
		edMonth= Integer.parseInt((String)doc.get("edMonth"));
		int searchYear = stYear;
		while(searchYear<=edYear)
		{
			searchJ = new JSONObject();
			searchJ.put("year",searchYear);
			JSONObject prjLaborYear = new JSONObject();
			prjLaborYear.put("_valid",true);
			prjLaborYear.put("year",searchYear);
			for(int searchMonth=1; searchMonth<=12;searchMonth++)
			{
				JSONObject laborMonth = new JSONObject();
				
				if((searchYear==stYear&& searchMonth<stMonth) ||(searchYear==edYear&& searchMonth>edMonth))
					laborMonth.put("_valid", false);
				else
					laborMonth.put("_valid", true);
				searchJ.put("month",searchMonth);
				searchJ.put("typ", "S");
				searchJ.put("docId",docId);
				JSONObject user = new JSONObject();
				List laborList = approvalDAO.selectPlanLabor(searchJ);
				Iterator it = laborList.iterator();
				while(it.hasNext())
				{
					JSONObject js = (JSONObject) it.next();
					user.put(js.get("userId"), js);
				}
				laborMonth.put("user", user);
				prjLaborYear.put(searchMonth,laborMonth);
			}
			prjLaborObj.put(searchYear, prjLaborYear);
			searchYear++;
		}
		doc.put("prjLaborObj",prjLaborObj);
		
		searchYear = stYear;
		while(searchYear<=edYear)
		{
			searchJ = new JSONObject();
			searchJ.put("year",searchYear);
			JSONObject prjExpenseYear = new JSONObject();
			prjExpenseYear.put("_valid",true);
			prjExpenseYear.put("year",searchYear);
			for(int searchMonth=1; searchMonth<=12;searchMonth++)
			{
				searchJ.put("typ", "S");
				searchJ.put("docId",docId);
				searchJ.put("month",searchMonth);
				List expenseList = approvalDAO.selectPlanExpense(searchJ);
				JSONObject expenseMonth = (JSONObject) expenseList.get(0);
				if((searchYear==stYear&& searchMonth<stMonth) ||(searchYear==edYear&& searchMonth>edMonth))
					expenseMonth.put("_valid", false);
				else
					expenseMonth.put("_valid", true);
				
				prjExpenseYear.put(searchMonth,expenseMonth);
			}
			prjExpenseObj.put(searchYear, prjExpenseYear);
			searchYear++;
		}
		doc.put("prjExpenseObj",prjExpenseObj);
		return doc;
	}
	
	@Override
	public void insertApprovalSalesIn(JSONObject totalSalesJ) {
		String sPrjId = (String) totalSalesJ.get("sPrjId");
		String pPrjId = (String) totalSalesJ.get("pPrjId");
		String docId  = (String) totalSalesJ.get("docId");
		long stYear = (Long) totalSalesJ.get("stYear");
		long stMonth = (Long) totalSalesJ.get("stMonth");
		String decideYn= "Y";
		JSONObject doc = new JSONObject();
		
		doc.put("docId",totalSalesJ.get("docId"));
		doc.put("sPrjId",sPrjId);
		doc.put("pPrjId",pPrjId);
		doc.put("stDt",totalSalesJ.get("stDt"));
		doc.put("edDt",totalSalesJ.get("edDt"));
		doc.put("salesSj", totalSalesJ.get("salesSj"));
		doc.put("decideYn",decideYn);
		doc.put("templtId","25");
		approvalDAO.insertApprovalSalesIn(doc);
		
		/* 2012.4.19 추가
		 * 날짜 단위로 인력투입 insert */
		// 1. 기존의 eapp_user_input 데이터 삭제
		JSONObject delUserInputObj = new JSONObject();
		delUserInputObj.put("docId", docId);
		approvalDAO.deleteUserInput(delUserInputObj);
		// 2. 신규 데이터 eapp_user_input 에 insert
		JSONArray userInputObjArray = (JSONArray) totalSalesJ.get("userInputObj");
		if(userInputObjArray != null)
		{
			Iterator itr = userInputObjArray.iterator();
			while(itr.hasNext())
			{
				JSONObject userInput = (JSONObject) itr.next();
				userInput.put("docId", docId);
				approvalDAO.insertUserInput(userInput);
			}
		}
		
		//insert purchaseOut
		JSONArray purchaseOutArray = (JSONArray) totalSalesJ.get("purchaseOutObj");
		if(purchaseOutArray !=null)
		{
			Iterator it = purchaseOutArray.iterator();
			while(it.hasNext())
			{	
				JSONObject purchaseOut = (JSONObject) it.next();
				purchaseOut.put("prjId", pPrjId);
				purchaseOut.put("docId", docId);
				purchaseOut.put("decideYn",decideYn);
				approvalDAO.insertPurchaseOut(purchaseOut);
				
				// 사내매출/매입 테이블에 등록
				purchaseOut.put("decideYn",decideYn);
				purchaseOut.put("sPrjId", sPrjId);
				purchaseOut.put("pPrjId", pPrjId);
				purchaseOut.put("typ", "PO");
				approvalDAO.insertPurchaseIn(purchaseOut);
			}
		}
		
		JSONObject prjLaborObj = (JSONObject) totalSalesJ.get("prjLaborObj");
		Set set = prjLaborObj.keySet();
		Iterator it = set.iterator();
		while(it.hasNext()) {
			String year = (String)it.next();
			JSONObject laborYear = (JSONObject)  prjLaborObj.get(year);
			for(int i =1 ; i<=12; i++) {
				JSONObject laborMonth = (JSONObject) laborYear.get(""+i);
				//if에 걸리는 경우가 있으면 안됨.
				if(laborMonth==null)
					continue;
				else {
					JSONObject userArray = (JSONObject) laborMonth.get("user");
					Set set2 = userArray.keySet();
					Iterator it2 = set2.iterator();
					while(it2.hasNext()) {
						JSONObject user = (JSONObject) userArray.get(it2.next());
						user.put("typ", "P");
						user.put("docId", docId);
						user.put("year",year);
						user.put("month",i);
						user.put("decideYn",decideYn);
						user.put("sPrjId", sPrjId);
						user.put("pPrjId", pPrjId);
						approvalDAO.insertPurchaseInLabor(user);
						
						user.put("prjId", pPrjId);
						approvalDAO.insertPlanLabor(user);
					}
					
				}
			}
		}
		
		JSONObject prjExpenseObj = (JSONObject) totalSalesJ.get("prjExpenseObj");
		set = prjExpenseObj.keySet();
		it = set.iterator();
		while(it.hasNext()) {
			String year = (String)it.next();
			JSONObject expenseYear = (JSONObject) prjExpenseObj.get(year);
			for(int i =1 ; i<=12; i++) {
				JSONObject expenseMonth = (JSONObject) expenseYear.get(""+i);
				//if에 걸리는 경우가 있으면 안됨.
				if(expenseMonth==null)
					continue;
				else {
					expenseMonth.put("docId", docId);
					expenseMonth.put("year",year);
					expenseMonth.put("month", i);
					expenseMonth.put("decideYn",decideYn);
					expenseMonth.put("sPrjId", sPrjId);
					expenseMonth.put("pPrjId", pPrjId);
					expenseMonth.put("typ", "P");
					approvalDAO.insertPurchaseIn(expenseMonth);
					
					expenseMonth.put("prjId", pPrjId);
					approvalDAO.insertPlanExpense(expenseMonth);					
				}
			}
		}
	}
	
	@Override
	public JSONObject selectApprovalSalesIn(ApprovalVO searchVO) {
		
		/*JSONObject doc = new JSONObject();
		
		doc = approvalDAO.selectApprovalTotalSalesDoc(docId);
		doc.put("salesObj",approvalDAO.selectSales(docId));
		doc.put("purchaseOutObj",approvalDAO.selectPurchaseOut(docId));*/
		String docId = searchVO.getDocId();
		JSONObject doc = approvalDAO.selectApprovalSalesIn(docId); 
		JSONObject searchJ = new JSONObject();
		searchJ.put("docId",docId);
		
		doc.put("purchaseOutObj",approvalDAO.selectPurchaseOut(docId));
		doc.put("userInputObj", approvalDAO.selectUserInput(searchJ));
		
		JSONObject prjLaborObj = new JSONObject();
		JSONObject prjExpenseObj = new JSONObject();
		int stYear, stMonth, edYear, edMonth;
		stYear = Integer.parseInt((String)doc.get("stYear"));
		stMonth = Integer.parseInt((String)doc.get("stMonth"));
		edYear = Integer.parseInt((String)doc.get("edYear"));
		edMonth= Integer.parseInt((String)doc.get("edMonth"));
		int searchYear = stYear;
		while(searchYear<=edYear) {
			searchJ = new JSONObject();
			searchJ.put("year",searchYear);
			JSONObject prjLaborYear = new JSONObject();
			prjLaborYear.put("_valid",true);
			prjLaborYear.put("year",searchYear);
			for(int searchMonth=1; searchMonth<=12;searchMonth++) {
				JSONObject laborMonth = new JSONObject();
				
				if((searchYear==stYear&& searchMonth<stMonth) ||(searchYear==edYear&& searchMonth>edMonth))
					laborMonth.put("_valid", false);
				else
					laborMonth.put("_valid", true);
				searchJ.put("month",searchMonth);
				searchJ.put("typ", "P");
				searchJ.put("docId",docId);
				JSONObject user = new JSONObject();
				List laborList = approvalDAO.selectPurchaseInLabor(searchJ);
				Iterator it = laborList.iterator();
				while(it.hasNext())
				{
					JSONObject js = (JSONObject) it.next();
					user.put(js.get("userId"), js);
				}
				laborMonth.put("user", user);
				prjLaborYear.put(searchMonth, laborMonth);
			}
			prjLaborObj.put(searchYear, prjLaborYear);
			searchYear++;
		}
		doc.put("prjLaborObj",prjLaborObj);
		
		searchYear = stYear;
		while(searchYear<=edYear) {
			searchJ = new JSONObject();
			searchJ.put("year",searchYear);
			JSONObject prjExpenseYear = new JSONObject();
			prjExpenseYear.put("_valid",true);
			prjExpenseYear.put("year",searchYear);
			for(int searchMonth=1; searchMonth<=12;searchMonth++) {
				searchJ.put("typ", "P");
				searchJ.put("docId",docId);
				searchJ.put("month",searchMonth);
				List expenseList = approvalDAO.selectPurchaseIn(searchJ);
				JSONObject expenseMonth = (JSONObject) expenseList.get(0);
				if((searchYear==stYear && searchMonth<stMonth) || (searchYear==edYear && searchMonth>edMonth))
					expenseMonth.put("_valid", false);
				else
					expenseMonth.put("_valid", true);
				
				prjExpenseYear.put(searchMonth, expenseMonth);
			}
			prjExpenseObj.put(searchYear, prjExpenseYear);
			searchYear++;
		}
		doc.put("prjExpenseObj",prjExpenseObj);
		return doc;
	}
	
	@Override
	public String insertApprovalTeamExp(ApprovalExpenseVO approvalExpenseVO) 
		throws UnsupportedEncodingException, ParseException, FdlException, Exception {
		
		//10번 지출결의서 + 25번 종합매출보고서 참고  
		String expenseArray = CommonUtil.unescape(approvalExpenseVO.getExpenseArrayJ());
        JSONArray expenseArrayJ =  (JSONArray)JSONValue.parseWithException(expenseArray);
        Iterator it = expenseArrayJ.iterator();
        //기본변수 설정
        JSONObject ob1 = (JSONObject) expenseArrayJ.get(0);
        String docId = approvalExpenseVO.getDocId(); //docId PK
        String sPrjId = (String) ob1.get("sPrjId"); //매입해주는 프로젝트
        String expDt = (String) ob1.get("expDt"); //매입일자
        String stDt = expDt.substring(0,6) + "01";
        String edDt = expDt.substring(0,6) + Integer.toString(CalendarUtil.getLastDateOfMonth(stDt.substring(0,4), stDt.substring(4,6)) );
        String year = stDt.substring(0,4);
        String month = Integer.toString(Integer.parseInt(stDt.substring(4,6)) );
        
        JSONObject doc = new JSONObject();
        doc.put("docId", docId);
		doc.put("sPrjId", sPrjId);
		doc.put("stDt", stDt);
		doc.put("edDt", edDt);
		doc.put("year", year);
		doc.put("month", month);
		doc.put("typ", "P");
		doc.put("decideYn", "Y");
		
        Long expSum = 0L;
        Long remain = 0L;
        Long budget = 0L;
        Long spend = 0L;        
        //팀장경비 최상위 프로젝트 코드 가져오기
        ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("KMS040");
    	List<CmmnDetailCode> rootPrjIdList = cmmUseService.selectCmmCodeDetail(codeVO);    	
    	CmmnDetailCode rootPrjIdCode = new CmmnDetailCode();
    	if(rootPrjIdList.size() > 0)
    		rootPrjIdCode = (CmmnDetailCode)rootPrjIdList.get(0);
    	String rootPrjId = rootPrjIdCode.getCodeDc();    	    	
    	//잔액 검사
        if(sPrjId.equals(rootPrjId) == false){
        	approvalExpenseVO.setPrjId(sPrjId);
        	approvalExpenseVO.setExpDt(expDt.substring(0,6));
        	//잔액 검사 수정 - 저장된 문서는 제외하도록 수정
        	EgovMap checkPrjBudget = approvalDAO.selectApprovalTeamExpBudget(approvalExpenseVO);
        	if(checkPrjBudget != null && checkPrjBudget.size() > 0) {
        		remain = Long.parseLong(checkPrjBudget.get("remain").toString());
        		budget = Long.parseLong(checkPrjBudget.get("budget").toString());
        		spend = Long.parseLong(checkPrjBudget.get("spend").toString());
        	}
        	else
        		return "팀장경비를 할당받지 못한 프로젝트입니다."; //Fail
        	
        	it.next(); //처음 JSONObject 는 팀장경비 나누어주는 프로젝트 이므로 지나감
	        while(it.hasNext()) {
	        	JSONObject ob = (JSONObject)it.next();	        	
	        	expSum += Long.parseLong(ob.get("expSpend").toString());
	        }
	        
	        if(remain < expSum){
        		return "프로젝트 팀장경비 잔액초과입니다.\\n신청액: " + CommonUtil.insertComma(expSum) 
        			+ "원\\n잔액: " + CommonUtil.insertComma(remain)
        			+ "원\\n할당액: " + CommonUtil.insertComma(budget)
        			+ "원\\n사용액: " + CommonUtil.insertComma(spend) + "원"; //Fail
        	} else {
        		//최종금액 차감
        		if(sPrjId.equals(rootPrjId) == false) {
        			doc.put("prjId", sPrjId);
        			doc.put("cost", -1 * expSum);
        			doc.put("ct", "팀장경비 지출 프로젝트");
            		approvalDAO.insertPlanExpense(doc);
        		}
        	}
	        it = expenseArrayJ.iterator();
	        it.next(); //처음 JSONObject 는 팀장경비 나누어주는 프로젝트 이므로 지나감
        }else{
        	it.next(); //처음 JSONObject 는 팀장경비 나누어주는 프로젝트 이므로 지나감  2013.08.30 김대현 추가
        }
        
        //DB 입력
        while(it.hasNext()) {
        	JSONObject ob = (JSONObject)it.next();
        	String pPrjId = (String) ob.get("prjId");
        	
        	Long cost = Long.parseLong(ob.get("expSpend").toString()); //(String) ob.get("expSpend");        	
        	String expCt = (String) ob.get("expCt");
        		        
        	 //사내매출 입력 #docId#, #sPrjId#, #pPrjId#(변동), #stDt#, #edDt#
    		doc.put("pPrjId", pPrjId);
    		doc.put("templtId","26");
    		approvalDAO.insertApprovalSalesIn(doc);
    		
    		//사내매입  입력 #docId#, #pPrjId#(변동), #sPrjId#, #typ#, #cost#(변동), #year#, #month#, #ct#(변동), #identifyNo#, #decideYn#
    		doc.put("cost", cost);
    		doc.put("ct", "팀장경비");
    		approvalDAO.insertPurchaseIn(doc);
    		
    		//판관비계획 입력 #docId#, #typ#, #prjId#(변동), #year#, #month#, #cost#(변동), #ct#(변동), #identifyNo#, #decideYn#
    		doc.put("prjId", pPrjId);
    		doc.put("ct", expCt);
    		approvalDAO.insertPlanExpense(doc);    		    		
        }        
        return "T"; //True
	}
	//팀장경비신청서 조회 시작	
	@Override
	public JSONObject selectApprovalTeamSalesIn(ApprovalVO searchVO) {
		JSONObject result = approvalDAO.selectApprovalTeamSalesIn(searchVO);
		return result;
	}	
	@Override
	public List<JSONObject> selectApprovalTeamExp(ApprovalVO searchVO) {
		List<JSONObject> result = approvalDAO.selectApprovalTeamExp(searchVO);
		return result;
	}	
	@Override
	public int selectApprovalTeamExpCnt(ApprovalVO searchVO) {
		return approvalDAO.selectApprovalTeamExpCnt(searchVO);
	}	
	@Override
	public EgovMap selectApprovalTeamExpBudget(ApprovalExpenseVO searchVO) throws Exception {		
    	EgovMap result = approvalDAO.selectApprovalTeamExpBudget(searchVO);
		return result;
	}
	@Override
	public List selectApprovalTeamExpBudgetAjax(JSONObject searchVO) throws Exception {		
		List result = approvalDAO.selectApprovalTeamExpBudgetAjax(searchVO);
		return result;
	}	
	//팀장경비신청서 조회 끝
	
	//영업경비 신청서 입력
	@Override
	public String insertApprovalSalesExp(ApprovalExpenseVO approvalExpenseVO)
			throws UnsupportedEncodingException, ParseException, FdlException, Exception {
			//26번 팀장경비신청서 코드 참고 
			String expenseArray = CommonUtil.unescape(approvalExpenseVO.getExpenseArrayJ());
	        JSONArray expenseArrayJ = (JSONArray)JSONValue.parseWithException(expenseArray);
	        Iterator it = expenseArrayJ.iterator();	        	        
	        String docId = approvalExpenseVO.getDocId(); //docId PK
	        
	        //판관비계획 입력 #docId#, #typ#, #prjId#(변동), #year#(변동), #month#(변동), #cost#(변동), #ct#(변동), #identifyNo#, #decideYn#
	        JSONObject doc = new JSONObject();
	        doc.put("docId", docId);
			doc.put("typ", null);
			doc.put("identifyNo", "0"); //문서는 없으나 데이터 분석결과 기초영업비만 0으로 들어가고 나머지는 null 값
			doc.put("decideYn", "Y");
				        	        
	        //DB 입력
	        while(it.hasNext()) {
	        	JSONObject ob = (JSONObject)it.next();
	        	String prjId = (String) ob.get("prjId"); //매입해주는 프로젝트
		        String expDt = (String) ob.get("expDt"); //매입일자
		        String year = expDt.substring(0,4);
		        String month = Integer.toString(Integer.parseInt(expDt.substring(4,6)) );
		        Long cost = Long.parseLong(ob.get("expSpend").toString());
	        	String expCt = (String) ob.get("expCt");
	        	
	    		doc.put("prjId", prjId);
	    		doc.put("year", year);
				doc.put("month", month);				
	    		doc.put("cost", cost);
	    		doc.put("ct", expCt);
	    		approvalDAO.insertPlanExpense(doc);    		    		
	        }        
	        return "T"; //True
	}
	
	
	@Override
	public double selectVacDateSum(ApprovalVacVO searchVO) {
		return approvalDAO.selectVacDateSum(searchVO);
	}

	@Override
	public void updateSalesDocDecideYn(ApprovalVO approvalVO) {
		approvalDAO.updateSalesDocDecideYn(approvalVO);
	}


	@Override
	public void updateSalesDocBondManageYn(ApprovalVO approvalVO) {
		approvalDAO.updateSalesDocBondManageYn(approvalVO);
	}
	
	@Override
	public ApprovalBusinessPlanVO selectBusinessPlanSum(ApprovalVO searchVO) {
		return approvalDAO.selectBusinessPlanSum(searchVO);
	}

	@Override
	public List selectSaelsPurchaseOutList(JSONObject searchVO) {
		return approvalDAO.selectSaelsPurchaseOutList(searchVO);
	}

	@Override
	public String getExceedDecider(Object object) {
		return approvalDAO.getExceedDecider(object);
	}
	
	@Override
	public List<ApprovalVO> selectApprovalListAjax(Map<String, Object> param) {
		return approvalDAO.selectApprovalListAjax(param);
	}
	
	@Override
	public List<ApprovalVO> selectSalesListAjax(Map<String, Object> param) {
		return approvalDAO.selectSalesListAjax(param);
	}	
	
	@Override
	public int selectApprovalListAjaxTotCnt(Map<String, Object> param) {
		return approvalDAO.selectApprovalListAjaxTotCnt(param);
	}
	
	@Override
	public int selectSalesListAjaxTotCnt(Map<String, Object> param) {
		return approvalDAO.selectSalesListAjaxTotCnt(param);
	}

	@Override
	public List<ApprovalVO> selectBondSalesListAjax(Map<String, Object> param) {
		return approvalDAO.selectBondSalesListAjax(param);
	}

	
	@Override
	public List<ApprovalVO> selectPurchaseInAjax(ProjectVO projectVO) {
		return approvalDAO.selectPurchaseInAjax(projectVO);
	}


	@Override
	public List<ApprovalVO> selectPurchaseOutAjax(ProjectVO projectVO) {
		return approvalDAO.selectPurchaseOutAjax(projectVO);
	}


	@Override
	public int selectDuplicateCardSpendCnt(ApprovalVO searchVO) {
		return approvalDAO.selectDuplicateCardSpendCnt(searchVO);
	}
    
    @Override
    public void insertReferencer(Map<String, String> param) throws Exception {
    	String strUserInfoList = param.get("refUserMixes");
    	if(strUserInfoList == null || "".equals(strUserInfoList))
    		return;
    	
    	if(CommonUtil.isMixedId(strUserInfoList)) {
    		String docId = param.get("docId"); 
    		String[] userIdList = CommonUtil.parseIdFromMixs(strUserInfoList);
    		
    		Map<String, Object> param2 = new HashMap<String, Object>();
    		param2.put("docId", docId);
    		param2.put("userIdList", userIdList);
    		
    		approvalDAO.insertReferencer(param2);
    		approvalDAO.setInsertRefDocStat(param2);
    	}    	
    }
    
    @Override
    public void updateWriterNo(Map<String, Object> param) throws Exception {
    	approvalDAO.updateWriterNo(param);
    }
        
    @Override
	public ApprovalVO viewApprovalLeader(ApprovalVO searchVO) {
		return approvalDAO.viewApprovalLeader(searchVO);
	}

    /**
	 * 매출이관 보고서
	 * 프로젝트에 할당된 매출 조회(인건비, 판관비)
	 */
    @Override
	public JSONObject selectProjectPlan(JSONObject searchVO) {
		
		JSONObject searchJ = new JSONObject();
		JSONObject prjPlanObj = new JSONObject();
		
		String prjId = (String)searchVO.get("prjId");
		String stSt = (String)searchVO.get("stDt");
		String edSt = (String)searchVO.get("edDt");
				
		int stYear, stMonth, edYear, edMonth;
		
		stYear = Integer.parseInt(stSt.substring(0, 4));
		stMonth = Integer.parseInt(stSt.substring(4, 6));
		edYear = Integer.parseInt(edSt.substring(0, 4));
		edMonth= Integer.parseInt(edSt.substring(4, 6));
		
		int searchYear = stYear;
		while(searchYear<=edYear) {
			searchJ.put("year",searchYear);
			
			JSONObject jsonResultYear = new JSONObject();
			jsonResultYear.put("_valid",true);
			jsonResultYear.put("year",searchYear);
			
			for(int searchMonth=1; searchMonth<=12;searchMonth++) {
				//searchJ.put("typ", "P");
				searchJ.put("prjId",prjId);
				searchJ.put("month",searchMonth);
				
				JSONObject jsonResultMonth = new JSONObject();
				
				// 인건비 및 판관비 값 가져오기
				List planList = approvalDAO.selectProjectPlan(searchJ);
				
				JSONObject plan = new JSONObject();
				if (planList.size() > 0) {
					plan = (JSONObject)planList.get(0);
					jsonResultMonth.put("planLabor", plan.get("PLAN_LABOR"));
					jsonResultMonth.put("planExpense", plan.get("PLAN_EXP"));
				} else {
					jsonResultMonth.put("planLabor", 0);
					jsonResultMonth.put("planExpense", 0);
				}
				
				if((searchYear==stYear && searchMonth<stMonth) || (searchYear==edYear && searchMonth>edMonth))
					jsonResultMonth.put("_valid", false);
				else
					jsonResultMonth.put("_valid", true);
				
				jsonResultYear.put(searchMonth, jsonResultMonth);
			}
			prjPlanObj.put(searchYear, jsonResultYear);
			searchYear++;
		}
		
		return prjPlanObj;
	}
    
    /**
	 * 매출이관 보고서(view)
	 * 문서 저장시 저장된 기존매출 조회(인건비, 판관비)
	 */
    @Override
	public JSONObject selectProjectSavedPlan(JSONObject searchVO) {
		
		JSONObject searchJ = new JSONObject();
		JSONObject prjPlanObj = new JSONObject();
		
		String docId = (String)searchVO.get("docId");
		String stSt = (String)searchVO.get("stDt");
		String edSt = (String)searchVO.get("edDt");
				
		int stYear, stMonth, edYear, edMonth;
		
		stYear = Integer.parseInt(stSt.substring(0, 4));
		stMonth = Integer.parseInt(stSt.substring(4, 6));
		edYear = Integer.parseInt(edSt.substring(0, 4));
		edMonth= Integer.parseInt(edSt.substring(4, 6));
		
		int searchYear = stYear;
		while(searchYear<=edYear) {
			searchJ.put("year",searchYear);
			
			JSONObject jsonResultYear = new JSONObject();
			jsonResultYear.put("_valid",true);
			jsonResultYear.put("year",searchYear);
			
			for(int searchMonth=1; searchMonth<=12;searchMonth++) {
				//searchJ.put("typ", "P");
				searchJ.put("docId",docId);
				searchJ.put("month",searchMonth);
				
				JSONObject jsonResultMonth = new JSONObject();
				
				// 인건비 및 판관비 값 가져오기
				List planList = approvalDAO.selectProjectSavedPlan(searchJ);
				
				JSONObject plan = new JSONObject();
				if (planList.size() > 0) {
					plan = (JSONObject)planList.get(0);
					jsonResultMonth.put("planLabor", plan.get("costLabor"));
					jsonResultMonth.put("planExpense", plan.get("costExpense"));
				} else {
					jsonResultMonth.put("planLabor", 0);
					jsonResultMonth.put("planExpense", 0);
				}
				
				if((searchYear==stYear && searchMonth<stMonth) || (searchYear==edYear && searchMonth>edMonth))
					jsonResultMonth.put("_valid", false);
				else
					jsonResultMonth.put("_valid", true);
				
				jsonResultYear.put(searchMonth, jsonResultMonth);
			}
			prjPlanObj.put(searchYear, jsonResultYear);
			searchYear++;
		}
		
		return prjPlanObj;
	}
	
	@Override
	public void insertApprovalSalesTrans(JSONObject totalSalesJ) {
		String sPrjId = (String) totalSalesJ.get("sPrjId");
		String docId  = (String) totalSalesJ.get("docId");
		long stYear = (Long) totalSalesJ.get("stYear");
		long stMonth = (Long) totalSalesJ.get("stMonth");
		String decideYn= "Y";
		JSONObject doc = new JSONObject();
		
		
		doc.put("docId",totalSalesJ.get("docId"));
		doc.put("sPrjId",sPrjId);
		doc.put("pPrjId",sPrjId);
		doc.put("stDt",totalSalesJ.get("stDt"));
		doc.put("edDt",totalSalesJ.get("edDt"));
		doc.put("templtId","28");
		approvalDAO.insertApprovalSalesIn(doc);
		
		// 기존 매출 삭제 후 저장
		JSONObject delSalesTransObj = new JSONObject();
		delSalesTransObj.put("docId", docId);
		approvalDAO.deleteSalesTrans(delSalesTransObj);
		
		JSONObject prjPlanObj = (JSONObject) totalSalesJ.get("prjPlanObj");
		Set set = prjPlanObj.keySet();
		Iterator it = set.iterator();
		while(it.hasNext()) {
			String year = (String)it.next();
			JSONObject jsonYear = (JSONObject) prjPlanObj.get(year);
			
			if ((Boolean)jsonYear.get("_valid")) {
				for(int i =1 ; i<=12; i++) {
					JSONObject jsonMonth = (JSONObject) jsonYear.get(""+i);
					//if에 걸리는 경우가 있으면 안됨.
					if(jsonMonth==null)
						continue;
					else {
						String planLabor = "0";
						String planExpense = "0";
						// _valid가 true이면
						if ((Boolean)jsonMonth.get("_valid")) {
							planLabor = jsonMonth.get("planLabor").toString();
							planExpense = jsonMonth.get("planExpense").toString();
						}

						jsonMonth.put("docId", docId);
						jsonMonth.put("prjId", sPrjId);
						jsonMonth.put("year",year);
						jsonMonth.put("month", i);
						jsonMonth.put("costLabor", planLabor);
						jsonMonth.put("costExp", planExpense);
						
						// 인건비, 수행경비 기존실적 삽입
						approvalDAO.insertSalesTrans(jsonMonth);
					}
				}
			}
		}
		
		
		// 이관 매출 저장
		JSONObject prjLaborObj = (JSONObject) totalSalesJ.get("prjLaborObj");
		set = prjLaborObj.keySet();
		it = set.iterator();
		while(it.hasNext()) {
			String year = (String)it.next();
			JSONObject jsonYear = (JSONObject) prjLaborObj.get(year);
			for(int i =1 ; i<=12; i++) {
				JSONObject jsonMonth = (JSONObject) jsonYear.get(""+i);
				//if에 걸리는 경우가 있으면 안됨.
				if(jsonMonth==null)
					continue;
				else {
					// 사내매출 인건비 삽입
					jsonMonth.put("docId", docId);
					jsonMonth.put("year",year);
					jsonMonth.put("month", i);
					jsonMonth.put("decideYn",decideYn);
					
					jsonMonth.put("typ", "P");
					jsonMonth.put("cost", jsonMonth.get("costLabor"));
					jsonMonth.put("sPrjId", "");
					jsonMonth.put("pPrjId", sPrjId);
					approvalDAO.insertPurchaseInLaborSalesTrans(jsonMonth);
					
					// 인건비 예산 삽입
					jsonMonth.put("prjId", sPrjId);
					approvalDAO.insertPlanLaborSalesTrans(jsonMonth);
					
					
					// 사내매출 수행경비(판관비) 삽입
					jsonMonth.put("cost", jsonMonth.get("costExpense"));
					approvalDAO.insertPurchaseIn(jsonMonth);
					
					// 판관비 예산
					approvalDAO.insertPlanExpense(jsonMonth);
				}
			}
		}
		
	}
	
	@Override
	public JSONObject selectApprovalSalesTrans(ApprovalVO searchVO) {
		
		// 매출이관 보고서 문서 정보 가져오기
		String docId = searchVO.getDocId();
		JSONObject doc = approvalDAO.selectApprovalSalesIn(docId); 
		JSONObject searchJ = new JSONObject();
		searchJ.put("docId",docId);
		
		
		// 인건비, 판관비 예산 가져오기
		JSONObject searchJ1 = new JSONObject();
		searchJ1.put("docId", docId);
		searchJ1.put("prjId", (String)doc.get("pPrjId"));
		searchJ1.put("stDt", (String)doc.get("stDt"));
		searchJ1.put("edDt", (String)doc.get("edDt"));
		
		
		JSONObject prjPlanObj = new JSONObject();
		
		if (!"RU".equals(searchVO.getMode()) && !"RW".equals(searchVO.getMode()))	// 저장된 매출을 가져옴
			prjPlanObj = selectProjectSavedPlan(searchJ1);
		else 		// 문서재사용 및 수정기안인 경우, 현재 집계된 매출을 가져옴
			prjPlanObj = selectProjectPlan(searchJ1);
		
		doc.put("prjPlanObj", prjPlanObj);
		
		JSONObject prjLaborObj = new JSONObject();
		int stYear, stMonth, edYear, edMonth;
		stYear = Integer.parseInt((String)doc.get("stYear"));
		stMonth = Integer.parseInt((String)doc.get("stMonth"));
		edYear = Integer.parseInt((String)doc.get("edYear"));
		edMonth= Integer.parseInt((String)doc.get("edMonth"));
		
		// 문서의 기록했던 인건비와 판관비 이관 매출 금액 바인딩
		int searchYear = stYear;
		while(searchYear<=edYear) {
			searchJ = new JSONObject();
			searchJ.put("year",searchYear);
			JSONObject jsonYear = new JSONObject();
			jsonYear.put("_valid",true);
			jsonYear.put("year",searchYear);
			for(int searchMonth=1; searchMonth<=12;searchMonth++) {
				searchJ.put("typ", "P");
				searchJ.put("docId",docId);
				searchJ.put("month",searchMonth);
				List planList = approvalDAO.selectPlanLaborExpense(searchJ);
				JSONObject jsonMonth = (JSONObject) planList.get(0);
				if((searchYear==stYear && searchMonth<stMonth) || (searchYear==edYear && searchMonth>edMonth))
					jsonMonth.put("_valid", false);
				else
					jsonMonth.put("_valid", true);
				
				jsonYear.put(searchMonth, jsonMonth);
			}
			prjLaborObj.put(searchYear, jsonYear);
			searchYear++;
		}
		doc.put("prjLaborObj",prjLaborObj);
		return doc;
	}

	/**
	 * ajax로 문서 정보(템플릿ID, 매출일, 최종수금예정일) 가져오기
	 */
	@Override
	public JSONObject selectDocStDt(String docId) {
		List<JSONObject> resultList = approvalDAO.selectDocStDt(docId);
		JSONObject result = resultList.get(0);
		return result;
	}

	
	/**
	 * 일반매출 : 매출일, 최종수금일 변경
	 */
	@Override
	public void updateGenSales(Map<String, String> param) throws Exception {
		approvalDAO.updateGenSales(param);
		
		String stDt = param.get("stDt");
		stDt = stDt.substring(0, 6) + "01";
		param.put("stDt", stDt);
		approvalDAO.updateSalesDt(param);
		approvalDAO.updatePurchaseOutDt(param);
		approvalDAO.updatePurchaseInDt(param);
		approvalDAO.updatePlanExp(param);
	}
	
	/**
	 * 종합매출 : 최종수금일 변경
	 */
	@Override
	public void updateTotSales(Map<String, String> param) throws Exception {
		approvalDAO.updateTotSales(param);
	}

	@Override
	public String selectReusedDoc(String parntId) throws Exception {
		return approvalDAO.selectReusedDoc(parntId);
	}
}
