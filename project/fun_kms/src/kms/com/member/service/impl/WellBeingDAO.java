package kms.com.member.service.impl;

import java.util.List;

import kms.com.member.service.DiningMoneyAdd;
import kms.com.member.service.DiningMoneyDetail;
import kms.com.member.service.DiningMoneyMonth;
import kms.com.member.service.DiningMoneyStatistic;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsWellBeingDAO")
public class WellBeingDAO extends EgovAbstractDAO{

	public List<DiningMoneyStatistic> selectDiningMoneyStatisticList(DiningMoneyStatistic searchVO) {
		return list("WellBeingDAO.selectDiningMoneyStatisticList", searchVO);
	}

	public DiningMoneyStatistic selectDiningMoneyStatistic(DiningMoneyStatistic searchVO) {
		return (DiningMoneyStatistic)selectByPk("WellBeingDAO.selectDiningMoneyStatistic", searchVO);
	}

	public List<DiningMoneyDetail> selectDiningMoneyDetailList(DiningMoneyDetail searchVO) {
		return list("WellBeingDAO.selectDiningMoneyDetailList", searchVO);
	}

	public List<DiningMoneyMonth> selectDiningMoneyMonth(DiningMoneyMonth searchVO) {
		return list("WellBeingDAO.selectDiningMoneyMonth", searchVO);
	}

	public List<DiningMoneyAdd> selectDiningMoneyAddList(DiningMoneyMonth searchVO) {
		return list("WellBeingDAO.selectDiningMoneyAddList", searchVO);
	}

	public void insertDiningMoneyAdd(DiningMoneyAdd diningMoneyAdd) {
		insert("WellBeingDAO.insertDiningMoneyAdd", diningMoneyAdd);
	}

	public void deleteDiningMoneyAdd(DiningMoneyAdd diningMoneyAdd) {
		delete("WellBeingDAO.deleteDiningMoneyAdd", diningMoneyAdd);
	}

}
