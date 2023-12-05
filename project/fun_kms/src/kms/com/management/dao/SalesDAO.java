package kms.com.management.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import kms.com.app.service.ApprovalVO;
import kms.com.common.utils.CommonUtil;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.OuterPurchaseVO;
import kms.com.management.service.PlanCostVO;
import kms.com.management.service.SalesVO;
import kms.com.management.vo.MonthResultVO;


@Repository("KmsSalesDAO")
public class SalesDAO extends EgovAbstractDAO{
	Logger logT = Logger.getLogger("TENY");

	public List<InnerSalesVO> selectInnerSalesList(InnerSalesVO innerSalesVO) {
		return list("KmsSalesDAO.selectInnerSalesList", innerSalesVO);
	}

	public List<InnerSalesDetailVO> selectInnerSalesDetailList(InnerSalesVO innerSalesVO) {
		return list("KmsSalesDAO.selectInnerSalesDetailList", innerSalesVO);
	}

	public List<SalesVO> selectSalesList(SalesVO searchVO) {
		return (List<SalesVO>) list("KmsSalesDAO.selectSalesList", searchVO);
	}

	public SalesVO selectSalesSum(SalesVO searchVO) {
		return (SalesVO)getSqlMapClientTemplate().queryForObject("KmsSalesDAO.selectSalesSum", searchVO);
	}
	
	public List<SalesVO> selectSalesDeptSum(SalesVO searchVO) {
		return (List<SalesVO>) list("KmsSalesDAO.selectSalesDeptSum", searchVO);
	}
	
	public List<OuterPurchaseVO> selectOuterPurchaseSumList(OuterPurchaseVO outerPurchaseVO) {
		return list("KmsSalesDAO.selectOuterPurchaseSumList", outerPurchaseVO);
	}
	
	public List<OuterPurchaseVO> selectOuterPurchaseList(OuterPurchaseVO outerPurchaseVO) {
		return list("KmsSalesDAO.selectOuterPurchaseList", outerPurchaseVO);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// TENY_170504 월간사업실적에서 실적부분을 Popup으로 띄우는 기능들.
	// TENY_170504 월별 사외매출목록을 조회
	public List<MonthResultVO> selectMonthSalesOutList(String searchYM, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthSalesOutList", map);
	}
	// TENY_170504 해당월까지의 누적 사외매출목록을 조회
	// TENY_170504 selectMonthSalesList와 같은 조회문을 쓰되 파라미터로 searchYM대신 searchYMTo를 보낸다
	public List<MonthResultVO> selectMonthSumSalesOutList(String searchYMTo, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYMTo", searchYMTo);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthSalesOutList", map);
	}
	
	// TENY_170507 월별 사내매출목록을 조회
	public List<MonthResultVO> selectMonthSalesInList(String searchYM, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthSalesInList", map);
	}
	// TENY_170507 해당월까지의 누적 사내매출목록을 조회
	// TENY_170507 selectMonthSalesList와 같은 조회문을 쓰되 파라미터로 searchYM대신 searchYMTo를 보낸다
	public List<MonthResultVO> selectMonthSumSalesInList(String searchYMTo, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYMTo", searchYMTo);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthSalesInList", map);
	}
	
	// TENY_170507 월별 사외매입 세부목록을 조회
	public List<MonthResultVO> selectMonthPurchaseOutList(String searchYM, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthPurchaseOutList", map);
	}
	public List<MonthResultVO> selectMonthSumPurchaseOutList(String searchYMTo, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYMTo", searchYMTo);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthPurchaseOutList", map);
	}
	
	// TENY_170507 월별 사내매입 세부목록을 조회
	// TENY_170507 selectMonthSalesList와 같은 조회문을 쓰되 파라미터로 searchYM대신 searchYMTo를 보낸다
	public List<MonthResultVO> selectMonthPurchaseInList(String searchYM, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthPurchaseInList", map);
	}
	public List<MonthResultVO> selectMonthSumPurchaseInList(String searchYMTo, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYMTo", searchYMTo);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthPurchaseInList", map);
	}
	
	// TENY_170508 월별 프로젝트별 투입 인건비 세부목록을 조회
	// TENY_170507 selectMonthSalesList와 같은 조회문을 쓰되 파라미터로 searchYM대신 searchYMTo를 보낸다
	public List<MonthResultVO> selectMonthLaborList(String searchYM, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthLaborList", map);
	}
	public List<MonthResultVO> selectMonthSumLaborList(String searchYMTo, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYMTo", searchYMTo);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthLaborList", map);
	}
	
	// TENY_170508 월별 프로젝트별 투입 판관비 세부목록을 조회
	public List<MonthResultVO> selectMonthExpenseList(String searchYM, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthExpenseList", map);
	}
	public List<MonthResultVO> selectMonthSumExpenseList(String searchYMTo, String searchOrgnztIdList) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYMTo", searchYMTo);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		return list("KmsSalesDAO.selectMonthExpenseList", map);
	}
	
	// TENY_170607 특정월의 프로젝트에 투입된 인력들의 인건비, 시간등 세부목록을 조회
	public List<MonthResultVO> selectMonthLaborOfProject(String searchYM, String searchPrjId) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchPrjId", searchPrjId);
		return list("KmsSalesDAO.selectMonthLaborOfProject", map);
	}

	// TENY_170607 특정인원이 투입된 프로젝트별 인건비, 투입시간 세부목록조회
	public List<MonthResultVO> selectMonthLaborOfUser(String searchYM, int searchUserNo) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchUserNo", searchUserNo);
		return list("KmsSalesDAO.selectMonthLaborOfUser", map);
	}
}
