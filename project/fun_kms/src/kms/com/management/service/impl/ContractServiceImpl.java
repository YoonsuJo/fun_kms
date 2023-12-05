package kms.com.management.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kms.com.app.service.ApprovalVO;
import kms.com.common.utils.CommonUtil;
import kms.com.management.service.BondService;
import kms.com.management.service.BondVO;
import kms.com.management.service.ContractService;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.SalesService;
import kms.com.management.service.SalesVO;

@Service("KmsContractService")
public class ContractServiceImpl implements ContractService {

	@Resource(name = "KmsConractDAO")
	ContractDAO contractDAO;

	@Override
	public List selectContractList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return contractDAO.selectContractList(param);
	}

	@Override
	public int selectContractListCnt(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return contractDAO.selectContractListCnt(param);
	}
	
	@Override
	public Map<String, Object> selectContract(Map<String, Object> param)
	throws Exception {
		// TODO Auto-generated method stub
		return contractDAO.selectContract(param);
	}
	
	@Override
	public void insertContract(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		contractDAO.insertContract(param);
	}
	
	@Override
	public void deleteContract(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		contractDAO.deleteContract(param);
	}

	@Override
	public void updateContract(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		if (param.get("resultRegister") == null || param.get("resultRegister").toString().equals(""))
			contractDAO.updateContract(param);
		else
			contractDAO.updateContractResultRegister(param);
	}
	
	@Override
	public List selectAuthList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return contractDAO.selectAuthList(param);
	}

	@Override
	public void insertAuthList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		if (param.get("authListMix") == null)
			return;
		
		String authListMix = param.get("authListMix").toString();
		if (CommonUtil.isMixedId(authListMix)) {
			String[] authList = CommonUtil.parseIdFromMixs(authListMix);
			param.put("authList", authList);
			contractDAO.insertAuthList(param);
		}
	}

	@Override
	public void updateAuthList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		if (param.get("authListMix") == null)
			return;
		
		String authListMix = param.get("authListMix").toString();
		if (authListMix.equals("")) {
			contractDAO.deleteAuthList(param);
		} else if (CommonUtil.isMixedId(authListMix)) {
			String[] authList = CommonUtil.parseIdFromMixs(authListMix);
			param.put("authList", authList);
			contractDAO.deleteAuthList(param);
			contractDAO.insertAuthList(param);
		}
	}
}
