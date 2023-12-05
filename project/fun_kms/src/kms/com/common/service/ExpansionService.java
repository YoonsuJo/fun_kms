package kms.com.common.service;

import java.util.List;

public interface ExpansionService {

	List<ExpansionVO> selectExpansionList(ExpansionVO expVO) throws Exception;

	int selectExpansionListTotCnt(ExpansionVO expVO) throws Exception;

	void insertExpansion(Expansion exp) throws Exception;

	void updateExpansionSort(ExpansionVO expVO) throws Exception;

	ExpansionVO selectExpansion(ExpansionVO expVO) throws Exception;

	void updateExpansion(Expansion exp) throws Exception;


}
