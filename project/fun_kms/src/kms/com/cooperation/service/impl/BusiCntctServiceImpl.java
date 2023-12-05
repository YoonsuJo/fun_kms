package kms.com.cooperation.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kms.com.common.utils.CommonUtil;
import kms.com.cooperation.service.BusiCntctService;
import kms.com.cooperation.service.BusinessContact;
import kms.com.cooperation.service.BusinessContactComment;
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.BusinessContactVO;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("KmsBusinessContactService")
public class BusiCntctServiceImpl implements BusiCntctService {

	@Resource(name = "KmsBusinessContactDAO")
	private BusiCntctDAO bcDAO;
	
	@Resource(name = "kmsBusinessContactIdGnrService")
	private EgovIdGnrService idGnrService;
	
	@Override
	public List<BusinessContactVO> selectBusinessContactList(BusinessContactVO businessContactVO) throws Exception {
		return bcDAO.selectBusinessContactList(businessContactVO);
	}

	@Override
	public int selectBusinessContactListTotCnt(BusinessContactVO businessContactVO) throws Exception {
		return bcDAO.selectBusinessContactListTotCnt(businessContactVO);
	}

	@Override
	public BusinessContactVO selectBusinessContact(BusinessContactVO businessContactVO) throws Exception {
		bcDAO.setReadtime(businessContactVO);
		BusinessContactVO result = bcDAO.selectBusinessContact(businessContactVO);
		List<BusinessContactRecieve> rList = selectBusinessContactRecieve(businessContactVO);
		
		for (int i=0; i<rList.size(); i++) {
			BusinessContactRecieve r = rList.get(i);
			if (r.getRecieveTyp().equals("RE")) {
				result.addRecieveList(r);
			}
			else if (r.getRecieveTyp().equals("RF")) {
				result.addReferenceList(r);
			}
		}
		
		return result;
	}

	@Override
	public List<BusinessContactRecieve> selectBusinessContactRecieve(BusinessContactVO businessContactVO) throws Exception {
		return bcDAO.selectBusinessContactRecieve(businessContactVO);
	}

	@Override
	public String insertBusinessContact(BusinessContact businessContact, BusinessContactRecieve businessContactRecieve) throws Exception {
		String bcId = idGnrService.getNextStringId();
		businessContact.setBcId(bcId);
		businessContactRecieve.setBcId(bcId);
		
		bcDAO.insertBusinessContact(businessContact);
		insertBusinessContactRecieve(businessContactRecieve);
		
		return bcId;
	}

	@Override
	public void updateBusinessContact(BusinessContact businessContact) throws Exception {
		bcDAO.updateBusinessContact(businessContact);
	}
	@Override
	public void updateBusinessContact(BusinessContact businessContact, BusinessContactRecieve businessContactRecieve) throws Exception {
		bcDAO.updateBusinessContact(businessContact);
		
		List<Integer> userList = bcDAO.selectInterestUserNoList(businessContactRecieve);
		
		//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
		List<Integer> alarmUserList = bcDAO.selectAlarmUserNoList(businessContactRecieve);		
		
		
		bcDAO.deleteBusinessContactRecieve(businessContactRecieve);
		
		if (CommonUtil.isMixedId(businessContactRecieve.getRecUserMixes())) {
			businessContactRecieve.setRecUserIdList(CommonUtil.parseIdFromMixs(businessContactRecieve.getRecUserMixes()));
		}
		if (CommonUtil.isMixedId(businessContactRecieve.getRefUserMixes())) {
			businessContactRecieve.setRefUserIdList(CommonUtil.parseIdFromMixs(businessContactRecieve.getRefUserMixes()));
		}
		bcDAO.insertBusinessContactRecieve(businessContactRecieve);
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("bcId", businessContactRecieve.getBcId());
		param.put("userList", userList);
		bcDAO.setInterestBc(param);
		

		//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
		Map<String,Object> alarmParam = new HashMap<String,Object>();
		alarmParam.put("bcId", businessContactRecieve.getBcId());
		alarmParam.put("alarmUserList", alarmUserList);
		bcDAO.setAlarmBc(alarmParam);
		
		
	}

	@Override
	public void insertBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) throws Exception {
		if (CommonUtil.isMixedId(businessContactRecieve.getRecUserMixes())) {
			businessContactRecieve.setRecUserIdList(CommonUtil.parseIdFromMixs(businessContactRecieve.getRecUserMixes()));
		}
		if (CommonUtil.isMixedId(businessContactRecieve.getRefUserMixes())) {
			businessContactRecieve.setRefUserIdList(CommonUtil.parseIdFromMixs(businessContactRecieve.getRefUserMixes()));
		}
		bcDAO.insertBusinessContactRecieve(businessContactRecieve);
	}
	
	@Override
	public void updateBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) throws Exception {
		bcDAO.updateBusinessContactRecieve(businessContactRecieve);
	}
	
	@Override
	public void deleteBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) throws Exception {
		bcDAO.deleteBusinessContactRecieve(businessContactRecieve);
	}
	
	@Override
	public void changeBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) throws Exception {

		//전체 삭제후 재입력
		List<Integer> userList = bcDAO.selectInterestUserNoList(businessContactRecieve);
		bcDAO.deleteBusinessContactRecieve(businessContactRecieve);
		
		if (CommonUtil.isMixedId(businessContactRecieve.getRecUserMixes())) {
			businessContactRecieve.setRecUserIdList(CommonUtil.parseIdFromMixs(businessContactRecieve.getRecUserMixes()));
		}
		if (CommonUtil.isMixedId(businessContactRecieve.getRefUserMixes())) {
			businessContactRecieve.setRefUserIdList(CommonUtil.parseIdFromMixs(businessContactRecieve.getRefUserMixes()));
		}
		bcDAO.insertBusinessContactRecieve(businessContactRecieve);
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("bcId", businessContactRecieve.getBcId());
		param.put("userList", userList);
		bcDAO.setInterestBc(param);
	}

	
	//2013.08.13 업무연락 알람 ON/OFF
	@Override
	public void updateBusinessContactAlarm(
			BusinessContactRecieve businessContactRecieve) throws Exception {
		// TODO Auto-generated method stub
		bcDAO.updateBusinessContactAlarm(businessContactRecieve);
		
	}
	
	
	@Override
	public List<BusinessContactComment> selectBusinessContactCommentList(BusinessContactComment businessContactComment) throws Exception {
		return bcDAO.selectBusinessContactCommentList(businessContactComment);
	}
	
	@Override
	public int selectBusinessContactCommentListCnt(BusinessContactComment businessContactComment) throws Exception {
		return bcDAO.selectBusinessContactCommentListCnt(businessContactComment);
	}
	
	@Override
	public BusinessContactComment selectBusinessContactComment(BusinessContactComment businessContactComment) throws Exception {
		List<BusinessContactComment> list = selectBusinessContactCommentList(businessContactComment);
		
		if (list.size() == 1)
			return list.get(0);
		else
			return new BusinessContactComment();
	}
	
	@Override
	public void insertBusinessContactComment(BusinessContactComment businessContactComment) throws Exception {
		bcDAO.insertBusinessContactComment(businessContactComment);
		bcDAO.deleteReadTime(businessContactComment);
	}
	
	@Override
	public void updateBusinessContactComment(BusinessContactComment businessContactComment) throws Exception {
		bcDAO.updateBusinessContactComment(businessContactComment);
		bcDAO.deleteReadTime(businessContactComment);
	}
	
	@Override
	public void updateBusinessContactCommentWithoutDeleteReadTime(BusinessContactComment businessContactComment) throws Exception {
		bcDAO.updateBusinessContactComment(businessContactComment);
	}

	@Override
	public List<BusinessContactVO> selectBusinessContactListHeadSearch(BusinessContactVO bcVO) throws Exception {
		return bcDAO.selectBusinessContactListHeadSearch(bcVO);
	}

	@Override
	public int selectBusinessContactListTotCntHeadSearch(BusinessContactVO bcVO) throws Exception {
		return bcDAO.selectBusinessContactListTotCntHeadSearch(bcVO);
	}


	
}
