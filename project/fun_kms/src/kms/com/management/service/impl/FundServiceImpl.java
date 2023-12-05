package kms.com.management.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kms.com.app.service.ApprovalVO;
import kms.com.management.service.FundService;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.SalesService;
import kms.com.management.service.SalesVO;

@Service("KmsFundService")
public class FundServiceImpl implements FundService {

	@Resource(name = "KmsFundDAO")
	FundDAO fundDAO;

	@Override
	public Map<String, Object> selectFund(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.selectFund(param);
	}
	
	@Override
	public void insertFund(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		fundDAO.insertFund(param);
	}

	@Override
	public void updateFund(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		fundDAO.updateFund(param);
	}

	@Override
	public void deleteFund(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		fundDAO.deleteFund(param);
	}
	
	@Override
	public void deleteFundByDocId(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		fundDAO.deleteFundByDocId(param);
	}	

	@Override
	public List selectFundListWeeklyDetail(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.selectFundWeeklyDetail(param);
	}

	@Override
	public List selectFundListWeekly(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.selectFundWeekly(param);
	}

	@Override
	public List selectFundListMonthly(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.selectFundMonthly(param);
	}

	@Override
	public List selectFundListYearly(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.selectFundYearly(param);
	}
	
}
