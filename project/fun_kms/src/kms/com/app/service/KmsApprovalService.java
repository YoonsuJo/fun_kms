package kms.com.app.service;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;

import kms.com.common.exception.IdMixInputException;
import kms.com.cooperation.service.ProjectVO;
import kms.com.management.service.SalesVO;
import kms.com.member.service.HolidayWorkDetail;
import kms.com.member.service.HolidayWorkStatistic;
import kms.com.member.service.SelfDevDetail;
import kms.com.member.service.SelfDevStatistic;
import kms.com.member.service.WorkStateVO;
import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
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
public interface KmsApprovalService {
	
		
	/**
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	ApprovalVO viewApprovalDoc(ApprovalVO vo) throws Exception;
	Map<String, Object> selectApprovalList(ApprovalVO vo) throws Exception;
	List<ApprovalVO> selectApprovalMainAjax(ApprovalVO vo);
	int selectApprovalMainAjaxCnt(ApprovalVO vo);
	/**
	 * @param approvalVO
	 * 전자결재 공통 부분에 해당되는 부분을 삽입하는 method
	 */
	void insertApprovalCmm(ApprovalVO approvalVO);
	void insertApprovalReaders(String docNo, String approvalType, List<String> readers);
	/**
	 * @param searchVO
	 * @return
	 */
	List<ApprovalReaderVO> viewApprovalReader(ApprovalVO searchVO);
	String selectUserMixByUserNo(int readerNo);
	/**
	 * approval reader stat을 업데이트 하는 함수.
	 * @param readerVO
	 */
	void updateReaderStat(ApprovalReaderVO readerVO);
	/**
	 * @param readerVO
	 * readerNo정보를 리턴(docId, appTyp, userNo 값을 set 해야 함0
	 */
	int selectReaderNo(ApprovalReaderVO readerVO);
	/**
	 * @param vo
	 * doc Status를 update해줌
	 */
	void updateDocStat(ApprovalVO vo);
	/**
	 * @param readerVO
	 * doc에서 approval type으로 검색, 아직 승인 하지 않은 reader를 count해줌
	 */
	int countUnAppReaderByTyp(ApprovalReaderVO readerVO);
	/**
	 * @param readerVO
	 * 조회일자를 setting 해주는 method
	 */
	void updateReaderSrchDt(ApprovalReaderVO readerVO);
	/**
	 * 재기안 횟수를 늘려주는 method
	 * @param docId
	 */
	void incrementReUseCnt(String docId);
	/**
	 * newAt 값을 0 으로 변경
	 * @param parnt
	 */
	void updateDocNewAt(ApprovalVO parnt);
	
	//content 값만 변경
	void updateDocContent(ApprovalVO parnt);
	
	/**
	 * main 에 들어갈 summary 를 만들어주는 함수.
	 * @param searchVO
	 * @return
	 */
	ApprovalVO selectApprovalCntSummary(ApprovalVO searchVO);
	/**
	 * vacation 신청 문서 생성
	 * @param vacVO
	 */
	void insertApprovalVac(ApprovalVacVO vacVO);
	void updateApprovalVac(ApprovalVacVO vacVO);
	/**
	 * vaction 문서 정보 select
	 * @param searchVO
	 */
	ApprovalVacVO viewApprovalVac(ApprovalVO searchVO);
		
		
	/* for official doc */
	
	public ApprovalOfficialVO viewApprovalOfficial(ApprovalVO vo) throws Exception ;
	
	/**
	 * TBL_EAPP_OFFICIAL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 TblEappOfficialVO
	 * @return 등록 결과
	 * @exception Exception
	 */
		void insertApprovalOfficial(ApprovalOfficialVO vo) throws Exception;
		
		
		/* for jobg*/
		ApprovalJobgVO viewApprovalJobg(ApprovalVO searchVO);
	void insertApprovalJobg(ApprovalJobgVO approvalJobgVO);
	/**
	 * handle stat을 변경해주는 method
	 * @param searchVO
	 */
	void updateHandleStat(ApprovalVO searchVO);
	
	void updateExp(ApprovalVO approvalVO);
	void updateExpDocId(ApprovalVO searchVO);
	
	/**
	 * 문서삭제
	 * @param searchVO
	 */
	void deleteDoc(String docId);	
	void deleteDocVac(String docId);	
	
	EgovMap selectVacationSummary(WorkStateVO searchVO) throws Exception;
	List<EgovMap> selectVacationSummaryList(WorkStateVO searchVO) throws Exception;
	List<EgovMap> selectVacationSummaryDetail(WorkStateVO searchVO) throws Exception;
	List<EgovMap> selectJobgList(ApprovalVO vo2);
	/**
	 * 자식 doc list를 불러옴. 
	 * @param vo2
	 * @return
	 */
	ApprovalVO getChildDoc(ApprovalVO vo2);
	ApprovalVO getParentDoc(ApprovalVO vo);
	String varifySaveDocApprovalExpense(JSONArray expenseArrayJ) throws UnsupportedEncodingException, ParseException, FdlException;
	String insertApprovalExpense(ApprovalExpenseVO approvalExpenseVO) throws UnsupportedEncodingException, ParseException, FdlException;
	String checkApprovalExpense(ApprovalExpenseVO approvalExpenseVO) throws UnsupportedEncodingException, ParseException, FdlException;
	String insertApprovalHol(ApprovalHolVO approvalHolVO);
	String checkApprovalHol(ApprovalHolVO approvalHolVO) throws UnsupportedEncodingException, ParseException, FdlException;
	List selectExpenseList(ApprovalVO searchVO);
	int selectExpenseCnt(ApprovalVO searchVO);
	Object selectExpenseSum(ApprovalVO searchVO);
	ApprovalHolVO viewApprovalHol(ApprovalVO searchVO);

	String insertApprovalTotalSales(JSONObject totalSalesJ);
	String insertApprovalGeneralSales(JSONObject generalSalesJ);
	JSONObject selectGeneneralSales(ApprovalVO searchVO);

	
	
	List<HolidayWorkStatistic> selectHolidayWorkStatisticList(HolidayWorkStatistic searchVO) throws Exception;
	HolidayWorkStatistic selectHolidayWorkStatistic(HolidayWorkStatistic searchVO) throws Exception;
	List<HolidayWorkDetail> selectHolidayWorkDetail(HolidayWorkStatistic searchVO) throws Exception;
	
	
	List<SelfDevStatistic> selectSelfDevStatisticList(SelfDevStatistic searchVO) throws Exception;
	SelfDevStatistic selectSelfDevStatistic(SelfDevStatistic searchVO) throws Exception;
	List<SelfDevDetail> selectSelfDevStatisticDetail(SelfDevDetail searchVO) throws Exception;
	
	void updateApprovalCmm(ApprovalVO approvalVO);
	void insertApprovalBusinessPlan(ApprovalBusinessPlanVO approvalBusinnesPlanVO);
	List<ApprovalBusinessPlanVO> selectBusinessPlan(ApprovalVO searchVO);
	JSONObject selectTotalSales(ApprovalVO searchVO);
	void insertBudgetAllocate(JSONObject budgetAllocateJ) throws IdMixInputException;
	JSONObject selectBudgetAllocateDoc(ApprovalVO searchVO);
	/*List selectBudgetAllocateLaborList(ApprovalVO searchVO);*/
	List selectBudgetAllocateExpenseList(ApprovalVO searchVO);
	double selectVacDateSum(ApprovalVacVO searchVO);
	void updateOfficialId(ApprovalVO vo);
	void updateSalesDocDecideYn(ApprovalVO approvalVO);
	void updateSalesDocBondManageYn(ApprovalVO approvalVO);
	ApprovalBusinessPlanVO selectBusinessPlanSum(ApprovalVO searchVO);
	List selectSaelsPurchaseOutList(JSONObject object);
	String getExceedDecider(Object object);
	void insertBudgetAllocate2(JSONObject totalSalesJ);
	JSONObject selectBudgetAllocate2(ApprovalVO searchVO);
	void insertApprovalSalesIn(JSONObject salesInJ);
	JSONObject selectApprovalSalesIn(ApprovalVO searchVO);
	
	/**
	 * 매출이관 보고서(write, modify)
	 * 프로젝트에 할당된 매출 조회(인건비, 판관비)
	 */
	JSONObject selectProjectPlan(JSONObject searchVO);
	
	/**
	 * 매출이관 보고서(view)
	 * 문서 저장시 저장된 기존매출 조회(인건비, 판관비)
	 */
	JSONObject selectProjectSavedPlan(JSONObject searchVO);
	
	void insertApprovalSalesTrans(JSONObject salesTransJ);
	JSONObject selectApprovalSalesTrans(ApprovalVO searchVO);
	
	//팀장경비신청서 입력
	String insertApprovalTeamExp(ApprovalExpenseVO approvalExpenseVO) throws UnsupportedEncodingException, ParseException, FdlException, Exception;
	//팀장경비신청서 조회 시작
	JSONObject selectApprovalTeamSalesIn(ApprovalVO searchVO);
	List selectApprovalTeamExp(ApprovalVO searchVO);
	int selectApprovalTeamExpCnt(ApprovalVO searchVO);
	EgovMap selectApprovalTeamExpBudget(ApprovalExpenseVO searchVO) throws Exception;
	List selectApprovalTeamExpBudgetAjax(JSONObject searchVO) throws Exception;
	//팀장경비신청서 조회 끝
	//영업경비신청서 입력
	String insertApprovalSalesExp(ApprovalExpenseVO approvalExpenseVO) throws UnsupportedEncodingException, ParseException, FdlException, Exception;
		
	List<ApprovalVO> selectApprovalListAjax(Map<String, Object> param);
	List<ApprovalVO> selectSalesListAjax(Map<String, Object> param);
	List<ApprovalVO> selectBondSalesListAjax(Map<String, Object> param);
	List<ApprovalVO> selectPurchaseInAjax(ProjectVO projectVO);
	List<ApprovalVO> selectPurchaseOutAjax(ProjectVO projectVO);
	
	int selectApprovalListAjaxTotCnt(Map<String, Object> param);
	int selectSalesListAjaxTotCnt(Map<String, Object> param);
	
	int selectDuplicateCardSpendCnt(ApprovalVO searchVO);
	void insertReferencer(Map<String, String> param) throws Exception;
	void updateWriterNo(Map<String, Object> param) throws Exception;    
	ApprovalVO viewApprovalLeader(ApprovalVO searchVO);
	
	/**
	 * ajax로 문서 정보(템플릿ID, 매출일, 최종수금예정일) 가져오기
	 */
	JSONObject selectDocStDt(String docId);
	
	/**
	 * 일반매출, 종합매출 : 매출일 or 종합매출일 변경
	 */
	void updateGenSales(Map<String, String> param) throws Exception;
	void updateTotSales(Map<String, String> param) throws Exception;
	
	/**
	 * ajax로 부모문서 기준, 진행중or결재완료된 문서정보 조회
	 */
	String selectReusedDoc(String parntId) throws Exception;
}
