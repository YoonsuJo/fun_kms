package kms.com.member.service;

import java.util.List;

public interface WellBeingService {

	List<DiningMoneyStatistic> selectDiningMoneyStatisticList(DiningMoneyStatistic searchVO) throws Exception;

	DiningMoneyStatistic selectDiningMoneyStatistic(DiningMoneyStatistic searchVO) throws Exception;

	List<DiningMoneyDetail> selectDiningMoneyDetailList(DiningMoneyDetail searchVO) throws Exception;

	List<DiningMoneyMonth> selectDiningMoneyMonth(DiningMoneyMonth searchVO) throws Exception;

	List<DiningMoneyAdd> selectDiningMoneyAddList(DiningMoneyMonth searchVO) throws Exception;

	void insertDiningMoneyAdd(DiningMoneyAdd diningMoneyAdd) throws Exception;

	void deleteDiningMoneyAdd(DiningMoneyAdd diningMoneyAdd) throws Exception;

}
