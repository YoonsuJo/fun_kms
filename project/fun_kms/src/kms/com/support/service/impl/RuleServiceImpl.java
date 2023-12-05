package kms.com.support.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
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
import kms.com.support.service.RuleService;
import kms.com.support.service.TaxPublishService;
import kms.com.support.service.TaxPublishVO;

@Service("KmsRuleService")
public class RuleServiceImpl implements RuleService {

	@Resource(name="KmsRuleDAO")
	private RuleDAO ruleDAO;

	@Override
	public List searchRuleList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return ruleDAO.searchTitleList(param);
	}
	
	@Override
	public List selectRuleList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return ruleDAO.selectTitleList(param);
	}

	@Override
	public Map<String, Object> selectRule(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return ruleDAO.selectContent(param);
	}
	
	@Override
	public int insertRule(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		
		int titleNo = ruleDAO.selectMaxTitleNo(param);
		param.put("titleNo", titleNo);
		int ord = ruleDAO.selectMaxTitleOrd(param);
		param.put("ord", ord);
		ruleDAO.insertTitle(param);
		
		param.put("titleNo", null);
		int contentNo = ruleDAO.selectMaxContentNo(param);
		param.put("titleNo", titleNo);
		param.put("contentNo", contentNo);
		ruleDAO.insertContent(param);
		
		param.put("typ", "REG");
		ruleDAO.insertHistory(param);
		
		return contentNo;
	}
	
	@Override
	public int updateRule(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		
		ruleDAO.updateTitle(param);
		
		param.put("useAt", "N");
		ruleDAO.updateContent(param);

		int titleNo = Integer.parseInt(param.get("titleNo").toString());
		param.put("titleNo", null);
		int contentNo = ruleDAO.selectMaxContentNo(param);
		param.put("titleNo", titleNo);
		param.put("contentNo", contentNo);
		ruleDAO.insertContent(param);
		
		param.put("typ", "MOD");
		ruleDAO.insertHistory(param);
		
		return contentNo;
	}
	
	@Override
	public int updateRuleOrder(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		List ruleList = ruleDAO.selectTitleList(param);
		
		int chngOrd = Integer.parseInt(param.get("ord").toString());
		int searchTitleNo = Integer.parseInt(param.get("titleNo").toString());
		int oldOrd = 0;
		
		for (int i = 0; i < ruleList.size(); i++) {
			Map<String, Object> obj = (Map<String, Object>) ruleList.get(i);
			int titleNo = Integer.parseInt(obj.get("titleNo").toString());
			if (titleNo == searchTitleNo) {
				oldOrd = Integer.parseInt(obj.get("ord").toString());
				break;
			}
		}
		for (int i = 0; i < ruleList.size(); i++) {
			Map<String, Object> obj = (Map<String, Object>) ruleList.get(i);
			int ord = Integer.parseInt(obj.get("ord").toString());
			if (ord == chngOrd) {
				obj.put("ord", oldOrd);
				ruleDAO.updateTitle(obj);
				break;
			}
		}
		ruleDAO.updateTitle(param);
		
		return Integer.parseInt(param.get("contentNo").toString());
	}
	
	@Override
	public void updateRuleList(Map<String, Object> param) throws Exception {
		
		String titleNoList[] = (String[]) param.get("ord_titleNo");
		String ordList[] = (String[]) param.get("ord_ord");
		for (int i = 0; i < titleNoList.length; i++) {
			Map<String, Object> ordParam = new HashMap<String, Object>(); 
			ordParam.put("titleNo", titleNoList[i]);
			ordParam.put("ord", ordList[i]);
			ruleDAO.updateTitle(ordParam);
		}
	}

	@Override
	public int deleteRule(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		
		param.put("useAt", "N");
		ruleDAO.updateTitle(param);
		
		param.put("typ", "DEL");
		ruleDAO.insertHistory(param);
		
		sortRuleList();
		
		return Integer.parseInt(param.get("contentNo").toString());
	}
	
	@Override
	public int recoverRule(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		
		param.put("useAt", "Y");
		ruleDAO.updateTitle(param);
		
		param.put("typ", "RCV");
		ruleDAO.insertHistory(param);
		
		sortRuleList();
		
		return Integer.parseInt(param.get("contentNo").toString());
	}

	@Override
	public List selectRuleHistoryList(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return ruleDAO.selectHistoryList(param);
	}

	@Override
	public void sortRuleList() throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> param = new HashMap<String, Object>(); 
		param.put("searchUseAt", "Y");
		List ruleList = ruleDAO.selectTitleList(param);
		
		for (int i = 0; i < ruleList.size(); i++) {
			Map<String, Object> ordParam = new HashMap<String, Object>(); 
			ordParam.put("titleNo", ((Map<String, Object>) ruleList.get(i)).get("titleNo"));
			ordParam.put("ord", (i + 1));
			ruleDAO.updateTitle(ordParam);
		}
		
	}

}
