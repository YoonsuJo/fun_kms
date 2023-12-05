package kms.com.support.service;

import java.util.List;
import java.util.Map;

import jxl.Workbook;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface CardService {

	List<EgovMap> selectCardList(CardVO searchVO);
	
	List selectCardSpendForExp(CardSpendVO searchVO);

	CardVO selectCardView(CardVO searchVO);

	List selectCardHistoryList(CardVO searchVO);

	int selectCardCnt(CardVO cardVO);
	
	void insertCard(CardVO cardVO);

	void updateCard(CardVO cardVO);

	void insertCardHistory(CardVO cardHistoryVO);
	
	void updateCardHistory(CardVO cardHistoryVO);

	void insertCardSpendExcel(Workbook workbook);

	List selectCardSpendList(CardSpendVO searchVO);
	
	List selectCardSpendListAdmin(CardSpendVO searchVO);

	int selectCardSpendSum(CardSpendVO searchVO);

	void deleteCardSpend(CardSpendVO searchVO);


}
