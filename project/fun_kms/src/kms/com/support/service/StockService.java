package kms.com.support.service;

import java.util.List;
import java.util.Map;

public interface StockService {

	public Map<String, Object> selectStock(Map<String, Object> param) throws Exception;
	public List selectStockList(Map<String, Object> param) throws Exception;
	public void insertStock(Map<String, Object> param) throws Exception;
	public void updateStock(Map<String, Object> param) throws Exception;
	public void deleteSavedStock(Map<String, Object> param) throws Exception;
	
	public void insertStockHistory(Map<String, Object> param) throws Exception;
	public void updateStockHistory(Map<String, Object> param) throws Exception;
	
	public List selectStockCategory(Map<String, Object> param) throws Exception;
	public void insertStockCategory(Map<String, Object> param) throws Exception;
	public void updateStockCategory(Map<String, Object> param) throws Exception;
	public void deleteStockCategory(Map<String, Object> param) throws Exception;
	
	public List selectStockItem(Map<String, Object> param) throws Exception;
	public void insertStockItem(Map<String, Object> param) throws Exception;
	public void updateStockItem(Map<String, Object> param) throws Exception;
	public void updateStockItemPrice(Map<String, Object> param) throws Exception;
	public void deleteStockItem(Map<String, Object> param) throws Exception;
	
	public List selectStockListAjax(Map<String, Object> param) throws Exception;
	
	public List selectStockStatistic(Map<String, Object> param) throws Exception;
	public List selectStockStatsStock(Map<String, Object> param) throws Exception;
	public List selectStockStatsBuy(Map<String, Object> param) throws Exception;
	public List selectStockStatsSell(Map<String, Object> param) throws Exception;
	
	public List selectStockState(Map<String, Object> param) throws Exception;
	public List selectOldStockStateTotal(Map<String, Object> param) throws Exception;
	
	public List selectStockStatusList(Map<String, Object> param) throws Exception;
	public List selectStockSalesList(Map<String, Object> param) throws Exception;	
	
	public List selectStockDetailList(StockVO stockVO) throws Exception;
	public int selectStockDetailListCount(StockVO stockVO) throws Exception;
	public List selectOldStockDetailList(StockVO stockVO) throws Exception;
	public int selectOldStockDetailListCount(StockVO stockVO) throws Exception;
	
	public Map<String, Object> selectHistoryList(StockVO stockVO) throws Exception;
	public int checkStockSerialNo(Map<String, Object> param) throws Exception;
	
	public void insertStockInstall(Map<String, Object> param) throws Exception;
	public void deleteStockInstall(Map<String, Object> param) throws Exception;
}
