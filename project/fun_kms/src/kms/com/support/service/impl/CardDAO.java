package kms.com.support.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarVO;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.CardVO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsCardDAO")
public class CardDAO extends EgovAbstractDAO{

	public List selectCardList(CardVO searchVO) {
		return list("CardDAO.selectCardList",searchVO); 		
	}
	
	public List<JSONObject> selectCardSpendForExp(CardSpendVO searchVO) {
		JSONArray expenseArray = new JSONArray();
		List expenseListJ =  (List<JSONObject>) list("CardDAO.selectCardSpendForExp", searchVO);
		expenseArray.addAll(expenseListJ);
		return expenseArray;		
	}
	
	public CardVO selectCardView(CardVO searchVO) {
		return (CardVO)selectByPk("CardDAO.selectCardView",searchVO); 		
	}
	
	public int selectCardCnt(CardVO cardVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject("CardDAO.selectCardCnt",cardVO);		
	}

	public void insertCard(CardVO cardVO) {
		insert("CardDAO.insertCard",cardVO);		
	}

	public void updateCard(CardVO cardVO) {
		update("CardDAO.updateCard",cardVO);		
	}

	public void insertCardHistory(CardVO cardHistoryVO) {
		insert("CardDAO.insertCardHistory",cardHistoryVO);		
	}
	
	public void updateCardHistory(CardVO cardHistoryVO) {
		update("CardDAO.updateCardHistory",cardHistoryVO);		
	}

	public void updateLastestCardHistory(CardVO cardHistoryVO) {
		update("CardDAO.updateLastestCardHistory",cardHistoryVO);		
	}
	public void resetCardHistoryFisrtRegister(CardVO cardHistoryVO) {
		update("CardDAO.resetCardHistoryFisrtRegister",cardHistoryVO);		
	}
	public void updateCardHistoryFisrtRegister(CardVO cardHistoryVO) {
		update("CardDAO.updateCardHistoryFisrtRegister",cardHistoryVO);		
	}

	public List selectCardHistoryList(CardVO searchVO) {
		return list("CardDAO.selectCardHistoryList",searchVO);
	}

	public void insertCardSpendExcel(CardSpendVO cardSpendVO) {
		insert("CardDAO.insertCardSpendExcel",cardSpendVO);		
	}

	public List selectCardSpendList(CardSpendVO searchVO) {
		return list("CardDAO.selectCardSpendList",searchVO);		
	}
	
	public List selectCardSpendListAdmin(CardSpendVO searchVO) {
		return list("CardDAO.selectCardSpendListAdmin",searchVO);		
	}

	public int selectCardSpendSum(CardSpendVO searchVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject("CardDAO.selectCardSpendSum",searchVO);
	}

	public void deleteCardSpend(CardSpendVO searchVO) {
		delete("CardDAO.deleteCardSpend",searchVO);		
	}

}
