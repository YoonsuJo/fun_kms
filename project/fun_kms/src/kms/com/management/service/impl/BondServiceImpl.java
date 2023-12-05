package kms.com.management.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.springframework.stereotype.Service;

import kms.com.app.service.ApprovalVO;
import kms.com.management.service.BondService;
import kms.com.management.service.BondVO;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.SalesService;
import kms.com.management.service.SalesVO;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.TaxPublishService;

@Service("KmsBondService")
public class BondServiceImpl implements BondService {

	@Resource(name = "KmsBondDAO")
	BondDAO bondDAO;

	@Resource(name = "KmsTaxPublishService")
	private TaxPublishService taxPublishService;
	
	@Override
	public List<BondVO> selectBondOrgSumList(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selectBondOrgSumList(bondVO);
	}

	@Override
	public List<BondVO> selectBondPrjSumList(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selectBondPrjSumList(bondVO);
	}

	@Override
	public BondVO selectBondPrjSum(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selectBondPrjSum(bondVO);
	}

	@Override
	public BondVO selectBondCollectionSum(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selectBondCollectionSum(bondVO);
	}

//	@Override
//	public List<BondVO> selectBondPrj(BondVO bondVO) throws Exception {
//		// TODO Auto-generated method stub
//		return bondDAO.selectBondPrj(bondVO);
//	}

	@Override
	public List<BondVO> selectBondTaxPublish(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selectBondTaxPublish(bondVO);
	}

	@Override
	public List<BondVO> selectNoPublish(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selectNoPublish(bondVO);
	}

	@Override
	public List<BondVO> selectCollectionList(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selectCollectionList(bondVO);
	}

	@Override
	public void insertCollection(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		bondDAO.insertCollection(bondVO);
	}
	
	@Override
	public BondVO selectCollection(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selectCollection(bondVO);
	}
	
	@Override
	public void updateCollection(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		bondDAO.updateCollection(bondVO);
	}

	@Override
	public void deleteCollection(BondVO bondVO) throws Exception {
		// TODO Auto-generated method stub
		bondDAO.deleteCollection(bondVO);
	}

	@Override
	public List selecCollectionFullList(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selecCollectionFullList(param);
	}

	@Override
	public int selecCollectionFullListCnt(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selecCollectionFullListCnt(param);
	}
	
	// 수금내역 총합계
	@Override
	public long selecCollectionFullListSum(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return bondDAO.selecCollectionFullListSum(param);
	}

	@Override
	public List insertCollectionExcel(Workbook workbook) throws Exception {
		// TODO Auto-generated method stub
		
		Sheet sheet = null;
		Cell[] cell = null;

		sheet = workbook.getSheet(0);
		
		List list = new ArrayList();
		
		for(int p = 1; p < sheet.getRows() - 1; p++)
		{
			cell = sheet.getRow(p);
			
			String date = cell[1].getContents().trim();
			date = date.substring(0, 10).replace(".", "");
			
			String contents = cell[3].getContents().trim();
			
			String strWithdraw = cell[4].getContents().trim();
			strWithdraw = strWithdraw.replace(",", "");
			int withdraw = Integer.parseInt(strWithdraw);
			
			String strDeposit = cell[5].getContents().trim();
			strDeposit = strDeposit.replace(",", "");
			int deposit = Integer.parseInt(strDeposit);
			
			deposit = deposit - withdraw;
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("searchNm", contents.replace(" ", "").replace("(주)", "").replace("주)", "").replace("（주）", "").replace("（주）", "").substring(0, 3));
			List resultList = taxPublishService.selectBondPrjNo(param);
			String autoPrjNo = "";
			String autoPublishDate = ""; 
			String autoCustNm = "";
			String autoPrjId = "";
			String autoPrjNm = "";
			String autoPrjCd = "";
			boolean chk = false;
			if (resultList.size() > 0)
			{
				autoPrjNo = ((Map<String, Object>)resultList.get(0)).get("prjNo").toString();
				autoPublishDate = ((Map<String, Object>)resultList.get(0)).get("publishDate").toString();
				autoCustNm = ((Map<String, Object>)resultList.get(0)).get("custNm").toString();
				autoPrjId = ((Map<String, Object>)resultList.get(0)).get("prjId").toString();
				autoPrjNm = ((Map<String, Object>)resultList.get(0)).get("prjNm").toString();
				autoPrjCd = ((Map<String, Object>)resultList.get(0)).get("prjCd").toString();
				chk = true;
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("date", date);
			map.put("contents", contents);
			map.put("deposit", deposit);
			map.put("autoPrjId", autoPrjId);
			map.put("autoPrjNo", autoPrjNo);
			map.put("autoPublishDate", autoPublishDate);
			map.put("autoCustNm", autoCustNm);
			map.put("autoPrjNm", autoPrjNm);
			map.put("autoPrjCd", autoPrjCd);
			map.put("chk", chk);
			
			list.add(map);
		}
		
		return list;
	}

	@Override
	public void insertCollectionTable(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		
		int collectionLength = Integer.parseInt(param.get("collectionLength").toString());
		
		if (collectionLength >= 2)
		{
			
			String[] checkList = (String[]) param.get("checkList");
			String[] bondPrjNoList = (String[]) param.get("insertBondPrjNo");
			String[] collectionDateList = (String[]) param.get("collectionDate");
			String[] expenseList = (String[]) param.get("insertExpense");
			String[] noteList = (String[]) param.get("note");
			
			for (int i = 0; i < checkList.length; i++) {
				
				if (!checkList[i].toString().equals("on"))
					continue;
				
				BondVO bondVO = new BondVO();
				
				bondVO.setBondPrjNo(Integer.parseInt(bondPrjNoList[i].toString()));
				bondVO.setCollectionDate(collectionDateList[i].toString());
				bondVO.setExpense(Long.parseLong(expenseList[i].toString()));
				bondVO.setNote(noteList[i].toString());
				
				bondDAO.insertCollection(bondVO);
			}
		}
		else if (collectionLength == 1)
		{
			if (!param.get("checkList").toString().equals("on"))
				return;
			
			BondVO bondVO = new BondVO();
			
			bondVO.setBondPrjNo(Integer.parseInt(param.get("insertBondPrjNo").toString()));
			bondVO.setCollectionDate(param.get("collectionDate").toString());
			bondVO.setExpense(Long.parseLong(param.get("insertExpense").toString()));
			bondVO.setNote(param.get("note").toString());
			
			bondDAO.insertCollection(bondVO);
		}
		else
			return;
		
	}
	
	@Override
	public void insertSalesBond(BondVO bondVO) throws Exception {
		bondDAO.insertSalesBond(bondVO);
	}

	@Override
	public void deleteSalesBond(BondVO bondVO) throws Exception {
		bondDAO.deleteSalesBond(bondVO);
	}
}
