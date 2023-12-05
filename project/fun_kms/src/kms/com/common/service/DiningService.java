package kms.com.common.service;

import java.util.List;

public interface DiningService {

	List<DiningVO> selectAllDiningList(DiningVO diningVO) throws Exception;
	int selectAllDiningListTotCnt(DiningVO diningVO) throws Exception;
	DiningVO selectDining(DiningVO diningVO) throws Exception;
	void insertDining(Dining dining) throws Exception;
	void updateDining(Dining dining) throws Exception;
}
