package kms.com.app.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.app.service.*;
import kms.com.cooperation.service.ProjectVO;
import kms.com.member.service.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
 * 
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 * 
 * </pre>
 */
@Repository("approvalDAO")
public class ApprovalDAO extends EgovAbstractDAO {

	/** log */
	protected static final Log LOG = LogFactory.getLog(ApprovalDAO.class);

	@SuppressWarnings("unchecked")
	public List<ApprovalVO> selectApprovalList(ApprovalVO vo){
		return list("ApprovalDAO.selectApprovalList", vo);
	}

	/**
	 * 전자결재 해당 건의 문서 갯수를 조회한다
	 * mode와 id를 setting해주면 된다.
	 * mode  -  1: 내가 저장한 문서
	 * 			2: 내가 결재할 문서
	 * 			3: 내가 기안한 문서 (전결전)
	 * 			4: 내가 승인한 문서 (전결전)
	 * 			5: 반려문서 확인 (확인전)
	 * 			6: 반려문서 (확인 후)
	 * 			10: 내가 기안한 완료문서
	 * 			11: 내가 승인한 완료문서
	 * 			12: 내가 참조할 문서
	 * 			13: 내가 처리할 문서
	 * 			14: 모든문서
	 * @param vo
	 * @return
	 */
	public int selectApprovalListCnt(ApprovalVO vo) {
		return (Integer) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectApprovalListCnt", vo);
	}

	public void insertApprovalCmm(ApprovalVO approvalVO) {
		insert("ApprovalDAO.insertApprovalCmm", approvalVO);
	}

	public void insertApprovalReaders(String docNo, String approvalType, List<String> readers) {

		for (String reader : readers) {
			if(reader!=null && !"".equals(reader)) {
				ApprovalReaderVO vo = new ApprovalReaderVO(docNo, approvalType, reader);
				insert("ApprovalDAO.insertApprovalReader", vo);
			}
		}

	}

	/**
	 * 전자결재 문서 정보를 득한다.
	 * 
	 * @param vo
	 * @return
	 */
	public ApprovalVO viewApprovalDoc(ApprovalVO vo) {
		return (ApprovalVO) selectByPk("ApprovalDAO.viewApprovalDoc", vo);
	}

	@SuppressWarnings("unchecked")
	public List<ApprovalReaderVO> viewApprovalReader(ApprovalVO vo) {
		return (List<ApprovalReaderVO>) list("ApprovalDAO.viewApprovalReader", vo);
	}

	public String selectUserMixByUserNo(int readerNo) {
		return (String) selectByPk("ApprovalDAO.selectUserMixByUserNo", readerNo);
	}

	public void updateReaderStat(ApprovalReaderVO readerVO) {
		update("ApprovalDAO.updateReaderStat", readerVO);
	}

	public int selectReaderNo(ApprovalReaderVO readerVO) {
		Object result = getSqlMapClientTemplate().queryForObject("ApprovalDAO.selectReaderNo", readerVO);
		return result==null? 0:(Integer)result ;
	}

	public void updateDocStat(ApprovalVO vo) {
		update("ApprovalDAO.updateDocStat", vo);
	}

	public int countUnAppReaderByTyp(ApprovalReaderVO readerVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.countUnAppReaderByTyp", readerVO);
	}

	public void updateReaderSrchDt(ApprovalReaderVO readerVO) {
		update("ApprovalDAO.updateReaderSrchDt", readerVO);
	}

	public void incrementReUseCnt(String docId) {
		update("ApprovalDAO.incrementReUseCnt", docId);
	}

	public void upDateDocNewAt(ApprovalVO parntVO) {
		update("ApprovalDAO.upDateDocNewAt", parntVO);
	}
	
	public void updateDocContent(ApprovalVO parntVO) {
		update("ApprovalDAO.updateDocContent", parntVO);
	}	

	public List<ApprovalVO> selectApprovalCntSummary1(ApprovalVO searchVO) {
		return (List<ApprovalVO>) list("ApprovalDAO.selectApprovalCntSummary1",	searchVO);
	}

	public void insertApprovalVac(ApprovalVacVO vacVO) {
		insert("ApprovalDAO.insertApprovalVac", vacVO);
	}
	
	public void updateApprovalVac(ApprovalVacVO vacVO) {
		update("ApprovalDAO.updateApprovalVac", vacVO);
	}

	public ApprovalVacVO viewApprovalVac(ApprovalVO searchVO) {
		return (ApprovalVacVO) selectByPk("ApprovalDAO.viewApprovalVac", searchVO);
	}

	public void updateHandleStat(ApprovalVO searchVO) {
		update("ApprovalDAO.updateHandleStat", searchVO);
	}

	/* for official doc */

	/**
	 * TBL_EAPP_OFFICIAL을 등록한다.
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 TblEappOfficialVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	public String insertApprovalOfficial(ApprovalOfficialVO vo)
			throws Exception {
		return (String) insert("ApprovalDAO.insertApprovalOfficial", vo);
	}

	//공문 번호를 update
	public void updateOfficialId(ApprovalVO vo) {
		update("ApprovalDAO.updateOfficialId",vo);
	}

	/**
	 * TBL_EAPP_OFFICIAL을 조회한다.
	 * 
	 * @param vo
	 *            - 조회할 정보가 담긴 TblEappOfficialVO
	 * @return 조회한 TBL_EAPP_OFFICIAL
	 * @exception Exception
	 */
	public ApprovalOfficialVO viewOfficialVac(ApprovalVO vo) throws Exception {
		return (ApprovalOfficialVO) selectByPk(
				"ApprovalDAO.viewApprovalOfficial", vo);
	}

	/* for job */

	

	/**
	 * TBL_EAPP_JOBG을 조회한다.
	 * 
	 * @param vo
	 *            - 조회할 정보가 담긴 TblEappJobgVO
	 * @return 조회한 TBL_EAPP_JOBG
	 * @exception Exception
	 */
	public ApprovalJobgVO selectTblEappJobg(ApprovalJobgVO vo) throws Exception {
		return (ApprovalJobgVO) selectByPk(
				"ApprovalDAO.viewApprovalJobj", vo);
	}

	public ApprovalJobgVO viewApprovalJobg(ApprovalVO searchVO) {
		return (ApprovalJobgVO) selectByPk(
				"ApprovalDAO.viewApprovalJobj", searchVO);
	}

	public void insertApprovalJobg(ApprovalJobgVO approvalJobgVO) {
		insert("ApprovalDAO.insertApprovalJobg", approvalJobgVO);

	}

	public void updateExp(ApprovalVO approvalVO) {
		update("ApprovalDAO.updateExpense", approvalVO);
	}
	public void updateExpExceedManage(JSONObject ob) {
		update("ApprovalDAO.updateExpenseExceedManage", ob);
	}
	
	public void updateExpDocId(ApprovalVO approvalVO) {
		update("ApprovalDAO.updateExpenseDocId", approvalVO);
	}
	
	public void deleteDoc(String docId) {
		delete("ApprovalDAO.deleteDoc", docId);
		delete("ApprovalDAO.deleteComment", docId);
		delete("ApprovalDAO.deleteReader", docId);
		/*for specific doc  */
		delete("ApprovalDAO.deleteApprovalOfficial", docId); //2
		delete("ApprovalDAO.deleteApprovalJobg", docId);//3
		delete("ApprovalDAO.deleteApprovalVac", docId);	//4
		delete("ApprovalDAO.deleteApprovalHol", docId);//5
		delete("ApprovalDAO.deleteApprovalExpenseDining", docId);//12
		delete("ApprovalDAO.deleteApprovalExpense", docId);//10
		delete("ApprovalDAO.deleteApprovalGeneralSales", docId);//20
		delete("ApprovalDAO.deleteApprovalTotalSales", docId);//21
		delete("ApprovalDAO.deleteApprovalBusinessPlan", docId);//22
		delete("ApprovalDAO.deleteApprovalBudgetAllocate", docId);//23
		delete("ApprovalDAO.deleteApprovalBudgetAllocate2", docId);//24
		delete("ApprovalDAO.deleteApprovalSalesIn", docId);//24
		delete("ApprovalDAO.deleteSalesTrans", docId);//28
		/*delete general sales*/		
		delete("ApprovalDAO.deleteSales", docId);
		delete("ApprovalDAO.deletePurchaseOut", docId);
		delete("ApprovalDAO.deletePurchaseIn", docId);
		delete("ApprovalDAO.deletePurchaseInLabor", docId);
		delete("ApprovalDAO.deletePlanExpense", docId);
		delete("ApprovalDAO.deletePlanLabor", docId);		
	}
	
	public void deleteDocVac(String docId) {
		delete("ApprovalDAO.deleteApprovalVac", docId);
	}
	
	public EgovMap selectVacationSummary(WorkStateVO searchVO) {
		return (EgovMap)selectByPk("ApprovalDAO.selectVacationSummary", searchVO);
	}

	public List<EgovMap> selectVacationSummaryList(WorkStateVO searchVO) {
		return list("ApprovalDAO.selectVacationSummaryList", searchVO);
	}

	public List<EgovMap> selectVacationSummaryDetail(WorkStateVO searchVO) {
		return list("ApprovalDAO.selectVacationSummaryDetail", searchVO);
	}

	public List<EgovMap> selectJobgList(ApprovalVO vo) {
		return list("ApprovalDAO.selectJobgList", vo);
	}

	public ApprovalVO getChildDoc(ApprovalVO vo) {
		return (ApprovalVO) selectByPk("ApprovalDAO.getChildDoc", vo);
	}

	public ApprovalVO getParentDoc(ApprovalVO vo) {
		return (ApprovalVO) selectByPk("ApprovalDAO.getParentDoc", vo);
	}

	public void insertApprovalExpense(JSONObject ob) {
		insert("ApprovalDAO.insertApprovalExpense",ob);
	}

	public List<JSONObject> selectExpenseList(ApprovalVO searchVO) {
		JSONArray expenseArray = new JSONArray();
		List expenseListJ =  (List<JSONObject>) list("ApprovalDAO.selectExpenseList", searchVO);
		expenseArray.addAll(expenseListJ);
		return expenseArray;
	}

	public int selectExpenseCnt(ApprovalVO searchVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectExpenseCnt", searchVO);
	}
	
	public JSONObject selectExpenseSum(ApprovalVO searchVO) {
		JSONObject expenseSum =  (JSONObject) selectByPk("ApprovalDAO.selectExpenseSum", searchVO);
		return expenseSum;
	}

	public void insertApprovalDining(JSONObject js) {
		insert("ApprovalDAO.insertApprovalDining",js);
		
	}

	public List selectDiningList(String expId) {
		JSONArray diningArray = new JSONArray();
		List diningListJ =  (List<JSONObject>) list("ApprovalDAO.selectDiningList", expId);
		diningArray.addAll(diningListJ);
		return diningArray;
	}

	public ApprovalHolVO viewApprovalHol(ApprovalVO searchVO) {
		return (ApprovalHolVO) selectByPk("ApprovalDAO.viewApprovalHol", searchVO); 
	}

	public void insertApprovalHol(ApprovalHolVO approvalHolVO) {
		insert("ApprovalDAO.insertApprovalHol",approvalHolVO);
		
	}


	public void insertApprovalTotalSalesDoc(JSONObject doc) {
		insert("ApprovalDAO.insertApprovalTotalSalesDoc",doc);
		
	}

	public void insertSales(JSONObject sales) {
		insert("ApprovalDAO.insertSales",sales);
		
	}

	public int selectPurchaseOutNextIdentifyNo() {
		return (Integer) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectPurchaseOutNextIdentifyNo",3
			);
	}

	public void insertPurchaseOut(JSONObject purchaseOut) {
		insert("ApprovalDAO.insertPurchaseOut",purchaseOut);
	}


	public void insertPurchaseIn(JSONObject purchaseIn) {
		insert("ApprovalDAO.insertPurchaseIn",purchaseIn);
	}

	public void insertUserInput(JSONObject user) {
		insert("ApprovalDAO.insertUserInput",user);
		
	}
	
	public void deleteUserInput(JSONObject user) {
		delete("ApprovalDAO.deleteUserInput",user);
		
	}
	
	public void insertPurchaseInLabor(JSONObject user) {
		insert("ApprovalDAO.insertPurchaseInLabor",user);
		
	}
	
	public void insertPlanLabor(JSONObject user) {
		insert("ApprovalDAO.insertPlanLabor",user);
	}
	
	// 매출이관용 기존매출(인건비, 수행경비) 삽입
	public void insertSalesTrans(JSONObject user) {
		insert("ApprovalDAO.insertSalesTrans",user);
	}
	
	// 매출이관용 기존매출(인건비, 수행경비) 삭제
	public void deleteSalesTrans(JSONObject user) {
		delete("ApprovalDAO.deleteSalesTrans",user);
		
	}
		
	// 매출이관용 인건비 삽입
	public void insertPlanLaborSalesTrans(JSONObject user) {
		insert("ApprovalDAO.insertPlanLaborSalesTrans",user);
	}
	
	// 매출이관용 인건비 예산 삽입
	public void insertPurchaseInLaborSalesTrans(JSONObject user) {
		insert("ApprovalDAO.insertPurchaseInLaborSalesTrans",user);
	}

	public void insertApprovalGeneralSalesDoc(JSONObject doc) {
		insert("ApprovalDAO.insertApprovalGeneralSalesDoc",doc);
	}

	public void insertPlanExpense(JSONObject expense) {
		insert("ApprovalDAO.insertPlanExpense",expense);		
	}

	public JSONObject selectApprovalGeneralSalesDoc(String docId) {
		return (JSONObject) selectByPk("ApprovalDAO.selectApprovalGeneralSalesDoc", docId);
	}
	
	public List<JSONObject> selectSales(String docId) {
		return (List<JSONObject> ) list("ApprovalDAO.selectSales", docId); 
	}

	public List<JSONObject>  selectPurchaseOut(String docId) {
		return (List<JSONObject> ) list("ApprovalDAO.selectPurchaseOut", docId); 
	}

	public List<JSONObject>  selectPurchaseIn(JSONObject js) {
		return (List<JSONObject> ) list("ApprovalDAO.selectPurchaseIn", js); 
	}

	public List<JSONObject>  selectPlanExpense(JSONObject js) {
		return (List<JSONObject> ) list("ApprovalDAO.selectPlanExpense", js); 
	}
	
	public List<HolidayWorkStatistic> selectHolidayWorkStatisticList(HolidayWorkStatistic searchVO) {
		return list("ApprovalDAO.selectHolidayWorkStatisticList", searchVO);
	}

	public HolidayWorkStatistic selectHolidayWorkStatistic(HolidayWorkStatistic searchVO) {
		return (HolidayWorkStatistic)selectByPk("ApprovalDAO.selectHolidayWorkStatistic", searchVO);
	}

	public List<HolidayWorkDetail> selectHolidayWorkDetail(HolidayWorkStatistic searchVO) {
		return list("ApprovalDAO.selectHolidayWorkDetailList", searchVO);
	}

	public List<SelfDevStatistic> selectSelfDevStatisticList(SelfDevStatistic searchVO) {
		return list("ApprovalDAO.selectSelfDevStatisticList", searchVO);
	}

	public SelfDevStatistic selectSelfDevStatistic(SelfDevStatistic searchVO) {
		return (SelfDevStatistic)selectByPk("ApprovalDAO.selectSelfDevStatistic", searchVO);
	}

	public List<SelfDevDetail> selectSelfDevStatisticDetail(SelfDevDetail searchVO) {
		return list("ApprovalDAO.selectSelfDevDetailList", searchVO);
	}

	public void updateApprovalCmm(ApprovalVO approvalVO) {
		update("ApprovalDAO.updateApprovalCmm", approvalVO);
		
	}

	public void insertApprovalBusinessPlan(ApprovalBusinessPlanVO vo) {
		insert("ApprovalDAO.insertApprovalBusinessPlan", vo);
		
	}

	public List<ApprovalBusinessPlanVO> selectBusinessPlanList(ApprovalVO searchVO) {
		return list("ApprovalDAO.selectBusinessPlanList", searchVO);
	}
	
	public ApprovalBusinessPlanVO selectBusinessPlanSum(ApprovalVO searchVO) {
		return (ApprovalBusinessPlanVO) selectByPk("ApprovalDAO.selectBusinessPlanSum", searchVO);
	}
	

	public JSONObject selectApprovalTotalSalesDoc(String docId) {
		return (JSONObject) selectByPk("ApprovalDAO.selectApprovalTotalSalesDoc", docId);
	}

	public List<JSONObject> selectPlanLabor(JSONObject searchJ) {
		return list("ApprovalDAO.selectPlanLabor", searchJ);
	}
	
	public List<JSONObject> selectUserInput(JSONObject searchJ) {
		return list("ApprovalDAO.selectUserInput", searchJ);
	}

	public void insertBudgetAllocate(JSONObject budgetAllocateJ) {
		insert("AproovalDAO.insertBudgetAllocate",budgetAllocateJ);
		
	}

	public JSONObject selectBudgetAllocate(ApprovalVO searchVO) {
		return (JSONObject) selectByPk("ApprovalDAO.selectBudgetAllocate", searchVO);
	}
	/*
	public List selectBudgetAllocateLaborList(ApprovalVO searchVO) {
		return list("ApprovalDAO.selectBudgetAllocateLaborList", searchVO);
	}
	 */
	public List selectBudgetAllocateExpenseList(ApprovalVO searchVO) {
		return list("ApprovalDAO.selectBudgetAllocateExpenseList", searchVO);
	}

	public double selectVacDateSum(ApprovalVacVO searchVO) {
		return (Double) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectVacDateSum", searchVO);
	}

	public void updateSalesDocDecideYn(ApprovalVO searchVO){
		update("ApprovalDAO.updateGenSalesDecideYn", searchVO);
		update("ApprovalDAO.updateTotSalesDecideYn", searchVO);
		update("ApprovalDAO.updatePurchaseInDecideYn", searchVO);
		update("ApprovalDAO.updatePurchaseOutDecideYn", searchVO);
		update("ApprovalDAO.updatePlanExpDecideYn", searchVO);
		update("ApprovalDAO.updatePlanLaborDecideYn", searchVO);
		update("ApprovalDAO.updateSalesDecideYn", searchVO);
		update("ApprovalDAO.updatePurchaseInLaborDecideYn", searchVO);
	}
	
	public void updateSalesDocBondManageYn(ApprovalVO searchVO){
		update("ApprovalDAO.updateGenSalesBondManageYn", searchVO);
		update("ApprovalDAO.updateTotSalesBondManageYn", searchVO);
		update("ApprovalDAO.updateSalesBondManageYn", searchVO);
	}

	public List selectSaelsPurchaseOutList(JSONObject searchVO) {
		return list("ApprovalDAO.selectSalesPurchaseOutList", searchVO);
	}

	public Long selectRemainPlanExp(JSONObject ob) {
		return (Long) getSqlMapClientTemplate().queryForObject("ApprovalDAO.selectRemainPlanExp", ob);		
	}

	public String selectCardSpendNoStatus(String cardSpendNo) {
		return (String) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectCardSpendNoStatus", cardSpendNo);
	}
	
	public String selectBudgetPrj(String prjId) {
		return (String) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectBudgetPrj", prjId);
	}

	public String getExceedDecider(Object object) {
		return (String) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.getExceedDecider", object);
	}

	public JSONObject selectExpenseSalesDocInfo(JSONObject js) {
		return (JSONObject) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectExpenseSalesDocInfo", js);
	}

	public void insertBudgetAllocate2(JSONObject doc) {
		insert("ApprovalDAO.insertBudgetAllocate2", doc);
	}

	public JSONObject selectBudgetAllocate2(String docId) {
		return (JSONObject) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectBudgetAllocate2", docId);
	}

	public void insertApprovalSalesIn(JSONObject doc) {
		insert("ApprovalDAO.insertApprovalSalesIn", doc);
		
	}

	public JSONObject selectApprovalSalesIn(String docId) {
		return (JSONObject) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectApprovalSalesIn", docId);
	}

	public List selectPurchaseInLabor(JSONObject searchJ) {
		return list("ApprovalDAO.selectPurchaseInLabor", searchJ);
	}
	
	public List<ApprovalVO> selectApprovalListAjax(Map<String, Object> param) {
		return (List<ApprovalVO>) list("ApprovalDAO.selectApprovalListAjax", param);
	}
	
	public List<ApprovalVO> selectSalesListAjax(Map<String, Object> param) {
		return (List<ApprovalVO>) list("ApprovalDAO.selectSalesListAjax", param);
	}
	
	//팀장경비신청서 조회 시작
	public JSONObject selectApprovalTeamSalesIn(ApprovalVO searchVO) {
		JSONObject expenseSum =  (JSONObject) selectByPk("ApprovalDAO.selectApprovalTeamSalesIn", searchVO);
		return expenseSum;
	}
	public List<JSONObject> selectApprovalTeamExp(ApprovalVO searchVO) {
		JSONArray expenseArray = new JSONArray();
		List expenseListJ =  (List<JSONObject>) list("ApprovalDAO.selectApprovalTeamExp", searchVO);
		expenseArray.addAll(expenseListJ);
		return expenseArray;
	}		 
	public int selectApprovalTeamExpCnt(ApprovalVO searchVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ApprovalDAO.selectApprovalTeamExpCnt", searchVO);
	}
	public EgovMap selectApprovalTeamExpBudget(ApprovalExpenseVO searchVO) {
		return (EgovMap)selectByPk("ApprovalDAO.selectApprovalTeamExpBudget", searchVO);
	}
	public List selectApprovalTeamExpBudgetAjax(JSONObject searchVO) {
		return list("ApprovalDAO.selectApprovalTeamExpBudgetAjax", searchVO);
	}	
	//팀장경비신청서 조회 끝
	
	public int selectApprovalListAjaxTotCnt(Map<String, Object> param) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ApprovalDAO.selectApprovalListAjaxTotCnt", param);
	}
	
	public int selectSalesListAjaxTotCnt(Map<String, Object> param) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ApprovalDAO.selectSalesListAjaxTotCnt", param);
	}

	public List<ApprovalVO> selectBondSalesListAjax(Map<String, Object> param) {
		return (List<ApprovalVO>) list("ApprovalDAO.selectBondSalesListAjax", param);
	}

	public List<ApprovalVO> selectPurchaseInAjax(ProjectVO projectVO) {
		return (List<ApprovalVO>) list("ApprovalDAO.selectPurchaseInAjax", projectVO);
	}
	
	public List<ApprovalVO> selectPurchaseOutAjax(ProjectVO projectVO) {
		return (List<ApprovalVO>) list("ApprovalDAO.selectPurchaseOutAjax", projectVO);
	}

	public int selectDuplicateCardSpendCnt(ApprovalVO searchVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ApprovalDAO.selectDuplicateCardSpendCnt", searchVO);
	}
	
	public void insertReferencer(Map<String, Object> param) {
		insert("ApprovalDAO.insertReferencer", param);
	}
	
	public void updateWriterNo(Map<String, Object> param) {
		update("ApprovalDAO.updateWriterNo", param);
	}

	public void setInsertRefDocStat(Map<String, Object> param) {
		update("Approval.setInsertRefDocStat", param);
	}
	
	public ApprovalVO viewApprovalLeader(ApprovalVO searchVO) {
		return (ApprovalVO) selectByPk("ApprovalDAO.selectApprovalLeader", searchVO);
	}

	/*
	 *
		CALC_VAC 함수 생성 쿼리
		DELIMITER $$
		DROP FUNCTION IF EXISTS CALC_VAC$$
		CREATE FUNCTION CALC_VAC($CIN_DT CHAR(8), $CMP_DT CHAR(8)) RETURNS INT
		BEGIN
				DECLARE cinY INT DEFAULT CONVERT(SUBSTRING($CIN_DT,1,4), UNSIGNED);
				DECLARE cinM INT DEFAULT CONVERT(SUBSTRING($CIN_DT,5,2), UNSIGNED);
				DECLARE cinD INT DEFAULT CONVERT(SUBSTRING($CIN_DT,7,2), UNSIGNED);
				DECLARE cmpY INT DEFAULT CONVERT(SUBSTRING($CMP_DT,1,4), UNSIGNED);
				DECLARE cmpM INT DEFAULT CONVERT(SUBSTRING($CMP_DT,5,2), UNSIGNED);
				DECLARE cmpD INT DEFAULT CONVERT(SUBSTRING($CMP_DT,7,2), UNSIGNED);
				DECLARE mon INT DEFAULT 0;
				DECLARE yr INT DEFAULT 0;
				DECLARE r INT DEFAULT 0;
				
				IF cmpD < cinD THEN SET mon = -1; END IF;
				IF cmpM < cinM OR (cmpM = cinM AND cmpD < cinD) THEN SET yr = -1; END IF;
				SET mon = mon + cmpM - cinM;
				SET yr = yr + cmpY - cinY;
				
				IF yr = 0 THEN SET r=mon;
				ELSE
					IF yr < 3 THEN SET r=15;
					ELSE
						IF (yr%2)=1 THEN SET r=14 + (yr/2);
						ELSE SET r=13 + (yr/2);
						END IF;
					END IF;
				END IF;
				
				RETURN r;
			END$$
		DELIMITER ;
	 * 
	 */
	
	/**
	 * 통계테이블에 집계된 프로젝트별 예산 확인
	 */
	public List<JSONObject>  selectProjectPlan(JSONObject js) {
		return (List<JSONObject> ) list("ApprovalDAO.selectProjectPlan", js); 
	}
	
	/**
	 * 매출이관 보고서 양식에 맞게 데이터 조회(json)
	 */
	public List<JSONObject> selectPlanLaborExpense(JSONObject searchJ) {
		return list("ApprovalDAO.selectPlanLaborExpense", searchJ);
	}
	
	/**
	 * 문서 저장시 저장된 프로젝트별 기존매출(인건비, 수행경비) 확인
	 */
	public List<JSONObject>  selectProjectSavedPlan(JSONObject js) {
		return (List<JSONObject> ) list("ApprovalDAO.selectProjectSavedPlan", js); 
	}

	/**
	 * ajax로 문서 정보(템플릿ID, 매출일, 최종수금예정일) 가져오기
	 */
	public List<JSONObject> selectDocStDt(String docId) {
		return (List<JSONObject>) list("ApprovalDAO.selectDocStDt", docId);
	}
	
	/**
	 * 일반매출 : 매출일, 최종수금일 변경
	 */
	public void updateGenSales(Map<String, String> param) {
		update("ApprovalDAO.updateGenSales", param);
	}
	public void updateSalesDt(Map<String, String> param) {
		update("ApprovalDAO.updateSalesDt", param);
	}
	public void updatePurchaseOutDt(Map<String, String> param) {
		update("ApprovalDAO.updatePurchaseOutDt", param);
	}
	public void updatePurchaseInDt(Map<String, String> param) {
		update("ApprovalDAO.updatePurchaseInDt", param);
	}
	public void updatePlanExp(Map<String, String> param) {
		update("ApprovalDAO.updatePlanExp", param);
	}
	
	/**
	 * 종합매출 : 최종수금일 변경
	 */
	public void updateTotSales(Map<String, String> param) {
		update("ApprovalDAO.updateTotSales", param);
	}
	
	/**
	 * ajax로 부모문서 기준, 진행중or결재완료된 문서정보 조회
	 */
	public String selectReusedDoc(String parntId) {
		return (String) getSqlMapClientTemplate().queryForObject(
				"ApprovalDAO.selectReusedDoc",parntId);
	}
}
