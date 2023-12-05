package kms.com.support.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.app.service.ApprovalVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.CalendarVO;
import kms.com.community.service.ScheduleVO;
import kms.com.support.service.CardService;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.CardVO;
import kms.com.support.service.ResourceService;
import kms.com.support.service.TaxPublishService;
import kms.com.support.service.TaxPublishVO;

@Service("KmsTaxPublishService")
public class TaxPublishServiceImpl implements TaxPublishService {

	@Resource(name="KmsTaxPublishDAO")
	private TaxPublishDAO taxPublishDAO;

	@Override
	public List<TaxPublishVO> selectTaxPublishListAll(
			Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return taxPublishDAO.selectTaxPublishListAll(param);
	}
	
	@Override
	public List<TaxPublishVO> selectTaxPublishList(
			Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return taxPublishDAO.selectTaxPublishList(param);
	}

	@Override
	public int selectTaxPublishListTotCnt(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return taxPublishDAO.selectTaxPublishListTotCnt(param);
	}

	@Override
	public void insertTaxPublishList(TaxPublishVO taxPublishVO)
			throws Exception {
		// TODO Auto-generated method stub
		
		/* 새로 입력되는 세금계산서의 id값을 세팅함 */
		String newBondId = "BOND_000000000000000";
		String tmpStringId = "";
		int tmpIntId = 0;
		tmpStringId = taxPublishDAO.selectMaxBondId();
		tmpIntId = Integer.parseInt(tmpStringId.substring(5));
		tmpIntId++;
		newBondId = newBondId.substring(0, 5) + String.format("%015d", tmpIntId);
		
		taxPublishVO.setBondId(newBondId);
		if (taxPublishVO.getZeroTaxRate() == null) {
			taxPublishVO.setZeroTaxRate("N");
		}
		
		taxPublishDAO.insertTaxPublish(taxPublishVO);
		
		String expenseArray = CommonUtil.unescape(taxPublishVO.getJsonExpenseString());
        JSONArray expenseArrayJ = (JSONArray)JSONValue.parseWithException(expenseArray);
        Iterator eIt = expenseArrayJ.iterator();
        while(eIt.hasNext())
        {
        	JSONObject ob = (JSONObject)eIt.next();
        	ob.put("bondId", newBondId);
        	
        	if (ob.get("containVat") == null)
        	{
        		ob.put("containVat", "N");
        	}
        	
        	taxPublishDAO.insertBondExpense(ob);
        }
        
        String projectArray = CommonUtil.unescape(taxPublishVO.getJsonProjectString());
        JSONArray projectArrayJ = (JSONArray)JSONValue.parseWithException(projectArray);
        Iterator pIt = projectArrayJ.iterator();
        while(pIt.hasNext())
        {
        	JSONObject ob = (JSONObject)pIt.next();
        	ob.put("bondId", newBondId);
        	taxPublishDAO.insertBondProject(ob);
        }
	}
	
	@Override
	public TaxPublishVO selectTaxPublish(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return taxPublishDAO.selectTaxPublish(param);
	}

	@Override
	public List<TaxPublishVO> selectBondExpenseList(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return taxPublishDAO.selectBondExpenseList(param);
	}

	@Override
	public List<TaxPublishVO> selectBondProjectList(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return taxPublishDAO.selectBondProjectList(param);
	}

	@Override
	public void updateTaxPublishList(TaxPublishVO taxPublishVO)
			throws Exception {
		// TODO Auto-generated method stub
		
		if (taxPublishVO.getZeroTaxRate() == null) {
			taxPublishVO.setZeroTaxRate("N");
		}
		
		taxPublishDAO.updateTaxPublish(taxPublishVO);
		
		String expenseArray = CommonUtil.unescape(taxPublishVO.getJsonExpenseString());
        JSONArray expenseArrayJ = (JSONArray)JSONValue.parseWithException(expenseArray);
        Iterator eIt = expenseArrayJ.iterator();
        while(eIt.hasNext())
        {
        	JSONObject ob = (JSONObject)eIt.next();
        	ob.put("bondId", taxPublishVO.getBondId());
        	if (ob.get("containVat") == null)
        	{
        		ob.put("containVat", "N");
        	}
        	
        	if (ob.get("expenseNo") == null)
        	{
        		if (ob.get("useAt").equals("Y"))
        			taxPublishDAO.insertBondExpense(ob);
        	}
        	else
        	{
        		taxPublishDAO.updateBondExpense(ob);
        	}
        }
        
        String projectArray = CommonUtil.unescape(taxPublishVO.getJsonProjectString());
        JSONArray projectArrayJ = (JSONArray)JSONValue.parseWithException(projectArray);
        Iterator pIt = projectArrayJ.iterator();
        while(pIt.hasNext())
        {
        	JSONObject ob = (JSONObject)pIt.next();
        	ob.put("bondId", taxPublishVO.getBondId());
        	
        	if (ob.get("prjNo") == null)
        	{
        		if (ob.get("useAt").equals("Y"))
        			taxPublishDAO.insertBondProject(ob);
        	}
        	else
        	{
        		taxPublishDAO.updateBondProject(ob);
        	}
        }
	}

	@Override
	public void deleteTaxPublishList(TaxPublishVO taxPublishVO)
			throws Exception {
		// TODO Auto-generated method stub
		taxPublishDAO.deleteTaxPublish(taxPublishVO);
	}

	@Override
	public void updateTaxPublishProjectList(TaxPublishVO taxPublishVO)
			throws Exception {
		// TODO Auto-generated method stub
		
		String projectArray = CommonUtil.unescape(taxPublishVO.getJsonProjectString());
        JSONArray projectArrayJ = (JSONArray)JSONValue.parseWithException(projectArray);
        Iterator pIt = projectArrayJ.iterator();
        while(pIt.hasNext())
        {
        	JSONObject ob = (JSONObject)pIt.next();
        	ob.put("bondId", taxPublishVO.getBondId());
        	
        	if (ob.get("prjNo") == null)
        	{
        		if (ob.get("useAt").equals("Y"))
        			taxPublishDAO.insertBondProject(ob);
        	}
        	else
        	{
        		taxPublishDAO.updateBondProject(ob);
        	}
        }
	}

	@Override
	public void updateTaxPublishState(TaxPublishVO taxPublishVO)
			throws Exception {
		// TODO Auto-generated method stub
		taxPublishDAO.updateTaxPublishState(taxPublishVO);
	}

	@Override
	public TaxPublishVO selectTaxProject(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return taxPublishDAO.selectTaxProject(param);
	}

	@Override
	public List selectBondPrjNo(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return taxPublishDAO.selectBondPrjNo(param);
	}

}
