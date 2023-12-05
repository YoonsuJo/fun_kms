package kms.com.management.service;

import java.util.List;
import java.util.Map;

import jxl.Workbook;

public interface BondService {

	List<BondVO> selectBondOrgSumList(BondVO bondVO) throws Exception;
	List<BondVO> selectBondPrjSumList(BondVO bondVO) throws Exception;
	BondVO selectBondPrjSum(BondVO bondVO) throws Exception;
	BondVO selectBondCollectionSum(BondVO bondVO) throws Exception;
//	List<BondVO> selectBondPrj(BondVO bondVO) throws Exception;
	List<BondVO> selectBondTaxPublish(BondVO bondVO) throws Exception;
	List<BondVO> selectNoPublish(BondVO bondVO) throws Exception;
	List<BondVO> selectCollectionList(BondVO bondVO) throws Exception;
	
	void insertCollection(BondVO bondVO) throws Exception;
	BondVO selectCollection(BondVO bondVO) throws Exception;
	void updateCollection(BondVO bondVO) throws Exception;
	void deleteCollection(BondVO bondVO) throws Exception;
	
	List selecCollectionFullList(Map<String, Object> param) throws Exception;
	int selecCollectionFullListCnt(Map<String, Object> param) throws Exception;
	
	// 수금내역 총합계
	long selecCollectionFullListSum(Map<String, Object> param) throws Exception;
	
	public List insertCollectionExcel(Workbook workbook) throws Exception;
	void insertCollectionTable(Map<String, Object> param) throws Exception;
	
	void insertSalesBond(BondVO bondVO) throws Exception;
	void deleteSalesBond(BondVO bondVO) throws Exception;
}
