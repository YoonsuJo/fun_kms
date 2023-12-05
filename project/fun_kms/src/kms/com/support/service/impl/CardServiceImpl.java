package kms.com.support.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;


import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.common.utils.CalendarUtil;
import kms.com.community.service.CalendarVO;
import kms.com.community.service.ScheduleVO;
import kms.com.support.service.CardService;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.CardVO;
import kms.com.support.service.ResourceService;

@Service("KmsCardService")
public class CardServiceImpl implements CardService {

	@Resource(name="KmsCardDAO")
	private CardDAO cardDAO;

	@Override
	public List<EgovMap> selectCardList(CardVO searchVO) {
		return cardDAO.selectCardList(searchVO);
	}
	
	@Override
	public List<JSONObject> selectCardSpendForExp(CardSpendVO searchVO) {
		List<JSONObject> result = cardDAO.selectCardSpendForExp(searchVO);
		return result;
	}	

	@Override
	public CardVO selectCardView(CardVO searchVO) {
		return cardDAO.selectCardView(searchVO);
	}
	
	@Override
	public int selectCardCnt(CardVO cardVO) {
		return cardDAO.selectCardCnt(cardVO);
	}
	
	@Override
	public void insertCard(CardVO cardVO) {
		cardDAO.insertCard(cardVO);
		CardVO vo = new CardVO();
		vo.setCardId(cardVO.getCardId());
		cardDAO.insertCardHistory(vo);
	}

	@Override
	public void updateCard(CardVO cardVO) {
		cardDAO.updateCard(cardVO);		
	}	
	
	@Override
	public List selectCardHistoryList(CardVO searchVO) {
		return cardDAO.selectCardHistoryList(searchVO);
	}

	@Override
	public void insertCardHistory(CardVO cardHistoryVO) {
		cardDAO.updateLastestCardHistory(cardHistoryVO);
		cardDAO.insertCardHistory(cardHistoryVO);		
	}
	
	@Override
	public void updateCardHistory(CardVO cardHistoryVO) {
		cardDAO.updateCardHistory(cardHistoryVO);		
	}

	@Override
	public void insertCardSpendExcel(Workbook workbook) {
		Sheet sheet = null;
		Cell[] cell = null;
		
		sheet = workbook.getSheet(0);
		for(int p=1; p < sheet.getRows()-1; p++)
		{
			cell = sheet.getRow(p);
			CardSpendVO cardSpendVO = new CardSpendVO();
			int q = 0;
			cardSpendVO.setReceiveInfoTyp(cell[q++].getContents().trim());
			cardSpendVO.setCardId(cell[q++].getContents().trim());
			if(cardSpendVO.getCardId() == "")
				break;
			cardSpendVO.setCardTyp(cell[q++].getContents().trim());
			cardSpendVO.setPayAccountNumber(cell[q++].getContents().trim());
			cardSpendVO.setPayBankNm(cell[q++].getContents().trim());
			cardSpendVO.setSpecifierNm(cell[q++].getContents().trim());
			cardSpendVO.setDomesticForeign(cell[q++].getContents().trim());
			cardSpendVO.setApprovalNo(cell[q++].getContents().trim());
			cardSpendVO.setApprovalDt(cell[q++].getContents().trim());
			cardSpendVO.setApprovalTm(cell[q++].getContents().trim());
			cardSpendVO.setSalesTyp(cell[q++].getContents().trim());
			cardSpendVO.setApprovedSpend(Integer.parseInt(cell[q++].getContents().trim().replaceAll(",", "")));
			cardSpendVO.setApprovedSpendForeignCurrency(Integer.parseInt(cell[q++].getContents().trim().replaceAll(",", "")));
			cardSpendVO.setSpendSignCd(cell[q++].getContents().trim());
			cardSpendVO.setRealSpend(Integer.parseInt(cell[q++].getContents().trim().replaceAll(",", "")));
			cardSpendVO.setSurtax(Integer.parseInt(cell[q++].getContents().trim().replaceAll(",", "")));
			cardSpendVO.setServiceCharge(Integer.parseInt(cell[q++].getContents().trim().replaceAll(",", "")));
			cardSpendVO.setInstallmentPeriod(cell[q++].getContents().trim());
			cardSpendVO.setExchangeRate(cell[q++].getContents().trim());
			cardSpendVO.setExchangeNationCd(cell[q++].getContents().trim());
			cardSpendVO.setExchangeNationNm(cell[q++].getContents().trim());
			cardSpendVO.setStoreBusinessNo(cell[q++].getContents().trim());
			cardSpendVO.setStoreBusinessNm(cell[q++].getContents().trim());
			cardSpendVO.setStoreBusinessTyp(cell[q++].getContents().trim());
			cardSpendVO.setStoreZipCd(cell[q++].getContents().trim());
			cardSpendVO.setStoreAddress1(cell[q++].getContents().trim());
			cardSpendVO.setStoreAddress2(cell[q++].getContents().trim());
			cardSpendVO.setStorePhoneNumber(cell[q++].getContents().trim());
			cardSpendVO.setAccountCd(cell[q++].getContents().trim());
			cardSpendVO.setAccountNm(cell[q++].getContents().trim());
			cardSpendVO.setHeadquaterNm(cell[q++].getContents().trim());
			cardSpendVO.setDepartmentNm(cell[q++].getContents().trim());
			cardDAO.insertCardSpendExcel(cardSpendVO);
		}		
	}

	@Override
	public List selectCardSpendList(CardSpendVO searchVO) {
		return cardDAO.selectCardSpendList(searchVO);
	}
	
	@Override
	public List selectCardSpendListAdmin(CardSpendVO searchVO) {
		return cardDAO.selectCardSpendListAdmin(searchVO);
	}

	@Override
	public int selectCardSpendSum(CardSpendVO searchVO) {
		return cardDAO.selectCardSpendSum(searchVO);
	}

	@Override
	public void deleteCardSpend(CardSpendVO searchVO) {
		cardDAO.deleteCardSpend(searchVO);
	}
}
