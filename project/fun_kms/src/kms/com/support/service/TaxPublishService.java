package kms.com.support.service;

import java.util.List;
import java.util.Map;

public interface TaxPublishService {
	List<TaxPublishVO> selectTaxPublishListAll(Map<String, Object> param) throws Exception;
	List<TaxPublishVO> selectTaxPublishList(Map<String, Object> param) throws Exception;
	int selectTaxPublishListTotCnt(Map<String, Object> param) throws Exception;
	
	void insertTaxPublishList(TaxPublishVO taxPublishVO) throws Exception;
	
	TaxPublishVO selectTaxPublish(Map<String, Object> param) throws Exception;
	List<TaxPublishVO> selectBondExpenseList(Map<String, Object> param) throws Exception;
	List<TaxPublishVO> selectBondProjectList(Map<String, Object> param) throws Exception;
	
	void updateTaxPublishList(TaxPublishVO taxPublishVO) throws Exception;
	void deleteTaxPublishList(TaxPublishVO taxPublishVO) throws Exception;
	
	void updateTaxPublishProjectList(TaxPublishVO taxPublishVO) throws Exception;
	void updateTaxPublishState(TaxPublishVO taxPublishVO) throws Exception;
	
	TaxPublishVO selectTaxProject(Map<String, Object> param) throws Exception;
	
	List selectBondPrjNo(Map<String, Object> param) throws Exception;
}
