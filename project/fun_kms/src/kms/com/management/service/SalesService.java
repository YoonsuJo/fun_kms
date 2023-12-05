package kms.com.management.service;

import java.util.List;

import kms.com.app.service.ApprovalVO;
import kms.com.management.fm.BizStatisticFm;
import kms.com.management.vo.MonthResultVO;

public interface SalesService {

	List<InnerSalesVO> selectInnerSalesList(InnerSalesVO innerSalesVO) throws Exception;

	List<InnerSalesDetailVO> selectInnerSalesDetailList(InnerSalesVO innerSalesVO) throws Exception;

	List<SalesVO> selectSalesList(SalesVO searchVO);
	
	List<SalesVO> selectSalesSum(SalesVO searchVO);
	
	/** 사외 매입 합계 조회 */
	List<OuterPurchaseVO> selectOuterPurchaseSumList(OuterPurchaseVO outerPurchaseVO) throws Exception;
	
	/** 사외 매입 조회 */
	List<OuterPurchaseVO> selectOuterPurchaseList(OuterPurchaseVO outerPurchaseVO) throws Exception;

	// TENY_170508
	public List<MonthResultVO> selectMonthResultList(BizStatisticFm bsFm) throws Exception;
	public List<MonthResultVO> selectMonthLaborOfProject(BizStatisticFm bsFm) throws Exception;
	

}
