package kms.com.management.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kms.com.app.service.ApprovalVO;
import kms.com.common.utils.CommonUtil;
import kms.com.management.dao.SalesDAO;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.OuterPurchaseVO;
import kms.com.management.service.SalesService;
import kms.com.management.service.SalesVO;
import kms.com.management.vo.MonthResultVO;
import kms.com.management.fm.BizStatisticFm;

@Service("KmsSalesService")
public class SalesServiceImpl implements SalesService {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name = "KmsSalesDAO")
	SalesDAO salesDAO;

	@Override
	public List<InnerSalesVO> selectInnerSalesList(InnerSalesVO innerSalesVO) throws Exception {
		return salesDAO.selectInnerSalesList(innerSalesVO);
	}

	@Override
	public List<InnerSalesDetailVO> selectInnerSalesDetailList(InnerSalesVO innerSalesVO) throws Exception {
		return salesDAO.selectInnerSalesDetailList(innerSalesVO);
	}

	@Override
	public List<SalesVO> selectSalesList(SalesVO searchVO) {
		return salesDAO.selectSalesList(searchVO);
	}

	@Override
	public List<SalesVO> selectSalesSum(SalesVO searchVO) {
		//return salesDAO.selectSalesSum(searchVO);
		
		// 부서별 합계를 가공하여, 상위부서합계, 전체 합계 를 포함한 resultSet 생성
		List<SalesVO> resultSum = new ArrayList<SalesVO>();
		List<SalesVO> sourceSum = salesDAO.selectSalesDeptSum(searchVO);
		
		String preOrgnztUpNm = "";
		// 부서별합계
		long salesSum = 0;
		long sales = 0;
		long purchaseOut = 0;
		long purchaseIn = 0;
		// 총합계
		long totalSalesSum = 0;
		long totalSales = 0;
		long totalPurchaseOut = 0;
		long totalPurchaseIn = 0;
		
		SalesVO upSalesVO = new SalesVO();
		SalesVO totalSalesVO = new SalesVO();
		
		for(SalesVO tmpVO: sourceSum) {
			
			// 상위부서 삽입
			if ( !"".equals(preOrgnztUpNm) && !preOrgnztUpNm.equals(tmpVO.getOrgnztUpNm()) ) {
				// 상위부서값 갱신
				upSalesVO = new SalesVO();
				upSalesVO.setOrgnztNm(preOrgnztUpNm + " 소계");
				upSalesVO.setSalesSum(salesSum);
				upSalesVO.setSales(sales);
				upSalesVO.setPurchaseOut(purchaseOut);
				upSalesVO.setPurchaseIn(purchaseIn);
				upSalesVO.setPrjId("up");
				resultSum.add(upSalesVO);
				
				salesSum = 0;
				sales = 0;
				purchaseOut = 0;
				purchaseIn = 0;
			}
			
			tmpVO.setOrgnztNm(tmpVO.getOrgnztNm() + " 소계");
			resultSum.add(tmpVO);	// 삽입
			
			// 합계 계산
			salesSum += tmpVO.getSalesSum();
			sales += tmpVO.getSales();
			purchaseOut += tmpVO.getPurchaseOut();
			purchaseIn += tmpVO.getPurchaseIn();
			
			totalSalesSum += tmpVO.getSalesSum();
			totalSales += tmpVO.getSales();
			totalPurchaseOut += tmpVO.getPurchaseOut();
			totalPurchaseIn += tmpVO.getPurchaseIn();
			
			preOrgnztUpNm = tmpVO.getOrgnztUpNm();
		}
		
		// 마지막 상위부서 삽입
		upSalesVO = new SalesVO();
		upSalesVO.setOrgnztNm(preOrgnztUpNm + " 소계");
		upSalesVO.setSalesSum(salesSum);
		upSalesVO.setSales(sales);
		upSalesVO.setPurchaseOut(purchaseOut);
		upSalesVO.setPurchaseIn(purchaseIn);
		upSalesVO.setPrjId("up");
		resultSum.add(upSalesVO);
		
		// 합계 삽입
		totalSalesVO = new SalesVO();
		totalSalesVO.setOrgnztNm("합계");
		totalSalesVO.setSalesSum(totalSalesSum);
		totalSalesVO.setSales(totalSales);
		totalSalesVO.setPurchaseOut(totalPurchaseOut);
		totalSalesVO.setPurchaseIn(totalPurchaseIn);
		totalSalesVO.setPrjId("up");
		resultSum.add(totalSalesVO);
		
		return resultSum;
	}
	
	@Override
	public List<OuterPurchaseVO> selectOuterPurchaseSumList(OuterPurchaseVO outerPurchaseVO) throws Exception {
		return salesDAO.selectOuterPurchaseSumList(outerPurchaseVO);
	}
	
	@Override
	public List<OuterPurchaseVO> selectOuterPurchaseList(OuterPurchaseVO outerPurchaseVO) throws Exception {
		return salesDAO.selectOuterPurchaseList(outerPurchaseVO);
	}
	
	@Override
	public List<MonthResultVO> selectMonthResultList(BizStatisticFm bsFm) throws Exception {
		logT.debug("START");
		logT.debug("searchYM : " + bsFm.getSearchYM() + "searchOrgId : " + bsFm.getSearchOrgId());
		List<MonthResultVO> mrVOList;
		switch(bsFm.getSearchResultType()) {
		case 10 :
			mrVOList = salesDAO.selectMonthSalesOutList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 11 :
			mrVOList = salesDAO.selectMonthSumSalesOutList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 20 :
			mrVOList = salesDAO.selectMonthSalesInList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 21 :
			mrVOList = salesDAO.selectMonthSumSalesInList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 30 :
			mrVOList = salesDAO.selectMonthPurchaseOutList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 31 :
			mrVOList = salesDAO.selectMonthSumPurchaseOutList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 40 :
			mrVOList = salesDAO.selectMonthPurchaseInList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 41 :
			mrVOList = salesDAO.selectMonthSumPurchaseInList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 50 :
			mrVOList = salesDAO.selectMonthLaborList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 51 :
			mrVOList = salesDAO.selectMonthSumLaborList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 60 :
			mrVOList = salesDAO.selectMonthExpenseList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		case 61 :
			mrVOList = salesDAO.selectMonthSumExpenseList(bsFm.getSearchYM(), bsFm.getSearchOrgId());
			break;
		default : 
			mrVOList = null;
			bsFm.setAmountSum(0);
			break;
		}
		bsFm.setAmountSum(bsFm.addAmount(mrVOList));
		return mrVOList;
	}
	
	@Override
	public List<MonthResultVO> selectMonthLaborOfProject(BizStatisticFm bsFm) throws Exception {
		logT.debug("START");
		logT.debug("searchYM : " + bsFm.getSearchYM() + "searchOrgId : " + bsFm.getSearchPrjId());
		
		List<MonthResultVO> mrVOList = salesDAO.selectMonthLaborOfProject(bsFm.getSearchYM(), bsFm.getSearchPrjId());
		
		bsFm.setAmountSum(bsFm.addAmount(mrVOList));
		
		return mrVOList;
	}
	
}
