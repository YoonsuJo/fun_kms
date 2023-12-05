package kms.com.common.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.common.service.BannerVO;
import kms.com.common.service.Expansion;
import kms.com.common.service.ExpansionService;
import kms.com.common.service.ExpansionVO;

@Service("KmsExpansionService")
public class ExpansionServiceImpl extends AbstractServiceImpl implements ExpansionService {

	@Resource(name = "KmsExpansionDAO")
	private ExpansionDAO expDAO;

	@Resource(name="kmsExpansionIdGnrService")
	private EgovIdGnrService idGnrService;
	
	@Override
	public List<ExpansionVO> selectExpansionList(ExpansionVO expVO) throws Exception {
		return expDAO.selectExpansionList(expVO);
	}

	@Override
	public int selectExpansionListTotCnt(ExpansionVO expVO) throws Exception {
		return expDAO.selectExpanstionListTotCnt(expVO);
	}

	@Override
	public void insertExpansion(Expansion exp) throws Exception {
		String expId = idGnrService.getNextStringId();
		exp.setExpId(expId);
		
		String accessUserNo = "";

		if (exp.getAccessUserList() != null && exp.getAccessUserList().length > 0) {
			List<Integer> userNoList = expDAO.getUserNo(exp);
			for (int i=0; i<userNoList.size(); i++) {
				if (i != 0) accessUserNo += ",";
				accessUserNo += userNoList.get(i);
			}
		}
		
		exp.setAccessUserNo(accessUserNo);
		
		expDAO.insertExpansion(exp);
	}

	@Override
	public void updateExpansionSort(ExpansionVO expVO) throws Exception {
		expDAO.updateExpansionSort(expVO);
	}

	@Override
	public ExpansionVO selectExpansion(ExpansionVO expVO) throws Exception {
		ExpansionVO result = expDAO.selectExpansion(expVO);
		//if ("L".equals(result.getAccess())) {
			List<EgovMap> accessUserList = expDAO.selectExpansionAccessUserList(expVO);
			
			String accessUser = "";
			for (int i=0; i<accessUserList.size(); i++) {
				EgovMap tmp = accessUserList.get(i);
				
				accessUser += tmp.get("userNm") + "(" + tmp.get("userId") + "),";
			}
			result.setAccessUser(accessUser);
		//}
		return result;
	}

	@Override
	public void updateExpansion(Expansion exp) throws Exception {

		String accessUserNo = "";

		if (exp.getAccessUserList() != null && exp.getAccessUserList().length > 0) {
			List<Integer> userNoList = expDAO.getUserNo(exp);
			for (int i=0; i<userNoList.size(); i++) {
				if (i != 0) accessUserNo += ",";
				accessUserNo += userNoList.get(i);
			}
		}

		exp.setAccessUserNo(accessUserNo);
		
		expDAO.updateExpansion(exp);
	}
}
