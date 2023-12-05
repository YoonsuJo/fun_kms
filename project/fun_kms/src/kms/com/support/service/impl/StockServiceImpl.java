package kms.com.support.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kms.com.common.utils.CalendarUtil;
import kms.com.support.service.StockService;
import kms.com.support.service.StockVO;

@Service("KmsStockService")
public class StockServiceImpl implements StockService {

	@Resource(name="KmsStockDAO")
	private StockDAO stockDAO;

	@Override
	public Map<String, Object> selectStock(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectStock(param);
	}
	
	@Override
	public List selectStockList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectStockList(param);
	}
	
	@Override
	public void insertStock(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		List itemList = stockDAO.selectStockItem(param);
		Map<String, Object> m = (Map<String, Object>) itemList.get(0);
		int amount = Integer.parseInt(param.get("amount").toString());
		for (int i = 0; i < amount; i++) {
			String serialNo = m.get("serialCode").toString() + m.get("itemCode").toString() + param.get("inputDate").toString();
			param.put("serialNo", serialNo);
			stockDAO.insertStock(param);
			Map<String, Object> p = new HashMap<String, Object>();
			p.put("userNo", param.get("inputUserNo"));
			p.put("sDate", param.get("inputDate"));
			p.put("status", 0);
			p.put("enduser", "");
			p.put("installPlace", "");
			p.put("note", "");
			stockDAO.insertStockHistory(p);
		}
		int avgPrice = Integer.parseInt(m.get("avgPrice").toString());
		int inputCnt = Integer.parseInt(m.get("inputCnt").toString());
		int totalExpense = Integer.parseInt(param.get("totalExpense").toString());
		param.put("avgPrice", (int) (avgPrice * inputCnt + totalExpense) / (inputCnt + amount));
		param.put("inputCnt", inputCnt + amount);
		stockDAO.updateStockItemPrice(param);
	}
	
	@Override
	public void updateStock(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.updateStock(param);
	}
	
	@Override
	public void deleteSavedStock(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.deleteSavedStock(param);
	}
	
	@Override
	public void insertStockHistory(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.insertStockHistory(param);
	}
	
	@Override
	public void updateStockHistory(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.updateStockHistory(param);
	}
	
	@Override
	public List selectStockCategory(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectStockCategory(param);
	}

	@Override
	public void insertStockCategory(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.insertStockCategory(param);
	}
	
	@Override
	public void updateStockCategory(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.updateStockCategory(param);
	}
	
	@Override
	public void deleteStockCategory(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.deleteStockCategory(param);
	}
	
	@Override
	public List selectStockItem(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectStockItem(param);
	}
	
	@Override
	public void insertStockItem(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.insertStockItem(param);
	}

	@Override
	public void updateStockItem(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.updateStockItem(param);
	}

	@Override
	public void updateStockItemPrice(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		stockDAO.updateStockItemPrice(param);
	}
	
	@Override
	public void deleteStockItem(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.deleteStockItem(param);
	}

	@Override
	public List selectStockState(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectStockState(param);
	}
	@Override
	public List selectOldStockStateTotal(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectOldStockStateTotal(param);
	}
	@Override
	public List selectStockListAjax(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectStockListAjax(param);
	}
	@Override
	public List selectStockStatusList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectStockStatusList(param);
	}
	@Override
	public List selectStockSalesList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectStockSalesList(param);
	}
	@Override
	public List selectStockStatsStock(Map<String, Object> param) throws Exception {
		return stockDAO.selectStockStatsStock(param);
	}
	
	@Override
	public List selectStockStatsBuy(Map<String, Object> param) throws Exception {
		return stockDAO.selectStockStatsBuy(param);
	}
	
	@Override
	public List selectStockStatsSell(Map<String, Object> param) throws Exception {
		return stockDAO.selectStockStatsSell(param);
	}
	
	@Override
	public List selectStockDetailList(StockVO stockVO) throws Exception {
		return stockDAO.selectStockDetailList(stockVO);
	}
	
	@Override
	public int selectStockDetailListCount(StockVO stockVO) throws Exception {
		Map<String, Object> map = stockDAO.selectStockDetailListCount(stockVO);
		return Integer.parseInt(map.get("cnt").toString());
	}
	
	@Override
	public List selectOldStockDetailList(StockVO stockVO) throws Exception {
		return stockDAO.selectOldStockDetailList(stockVO);
	}
	
	@Override
	public int selectOldStockDetailListCount(StockVO stockVO) throws Exception {
		Map<String, Object> map = stockDAO.selectOldStockDetailListCount(stockVO);
		return Integer.parseInt(map.get("cnt").toString());
	}

	@Override
	public Map<String, Object> selectHistoryList(StockVO stockVO) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> itemInfo = stockDAO.selectItemInfo(stockVO);
		Map<String, Object> stockInfo = stockDAO.selectStockInfo(stockVO);
		List historyList = stockDAO.selectHistoryList(stockVO);
		List installList = stockDAO.selectStockInstallL(stockVO);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("itemInfo", itemInfo);
		returnMap.put("stockInfo", stockInfo);
		returnMap.put("historyList", historyList);
		returnMap.put("installList", installList);
		return returnMap;
	}

	@Override
	public int checkStockSerialNo(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.checkStockSerialNo(param);
	}

	@Override
	public List selectStockStatistic(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return stockDAO.selectStockStatistic(param);
	}

	@Override
	public void deleteStockInstall(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.deleteStockInstall(param);
	}

	@Override
	public void insertStockInstall(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		stockDAO.insertStockInstall(param);
	}
}
