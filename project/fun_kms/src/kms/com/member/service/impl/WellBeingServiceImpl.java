package kms.com.member.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kms.com.member.service.DiningMoneyAdd;
import kms.com.member.service.DiningMoneyDetail;
import kms.com.member.service.DiningMoneyMonth;
import kms.com.member.service.DiningMoneyStatistic;
import kms.com.member.service.WellBeingService;

@Service("KmsWellBeingService")
public class WellBeingServiceImpl implements WellBeingService {

	@Resource(name="KmsWellBeingDAO")
	WellBeingDAO wbDAO;
	
	@Override
	public List<DiningMoneyStatistic> selectDiningMoneyStatisticList(DiningMoneyStatistic searchVO) throws Exception {
		return wbDAO.selectDiningMoneyStatisticList(searchVO);
	}

	@Override
	public DiningMoneyStatistic selectDiningMoneyStatistic(DiningMoneyStatistic searchVO) throws Exception {
		return wbDAO.selectDiningMoneyStatistic(searchVO);
	}

	@Override
	public List<DiningMoneyDetail> selectDiningMoneyDetailList(DiningMoneyDetail searchVO) throws Exception {
		return wbDAO.selectDiningMoneyDetailList(searchVO);
	}

	@Override
	public List<DiningMoneyMonth> selectDiningMoneyMonth(DiningMoneyMonth searchVO) throws Exception {
		return wbDAO.selectDiningMoneyMonth(searchVO);
	}

	@Override
	public
	List<DiningMoneyAdd> selectDiningMoneyAddList(DiningMoneyMonth searchVO) throws Exception {
		return wbDAO.selectDiningMoneyAddList(searchVO);
	}
	
	@Override
	public void insertDiningMoneyAdd(DiningMoneyAdd diningMoneyAdd) throws Exception {
		wbDAO.insertDiningMoneyAdd(diningMoneyAdd);
	}

	@Override
	public void deleteDiningMoneyAdd(DiningMoneyAdd diningMoneyAdd) throws Exception {
		wbDAO.deleteDiningMoneyAdd(diningMoneyAdd);
	}
}
