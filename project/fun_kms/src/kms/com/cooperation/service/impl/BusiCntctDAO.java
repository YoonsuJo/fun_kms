package kms.com.cooperation.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.cooperation.service.BusinessContactComment;
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.DayReport;
import kms.com.cooperation.service.DayReportVO;
import kms.com.cooperation.service.Task;
import kms.com.cooperation.service.TaskContent;
import kms.com.cooperation.service.TaskVO;
import kms.com.cooperation.service.BusinessContact;
import kms.com.cooperation.service.BusinessContactVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("KmsBusinessContactDAO")
public class BusiCntctDAO extends EgovAbstractDAO {

	public List<BusinessContactVO> selectBusinessContactList(BusinessContactVO businessContactVO) {
		return list("BusinessContactDAO.selectBusinessContactList", businessContactVO);
	}
	
	public int selectBusinessContactListTotCnt(BusinessContactVO businessContactVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("BusinessContactDAO.selectBusinessContactListTotCnt", businessContactVO);
	}

	public BusinessContactVO selectBusinessContact(BusinessContactVO businessContactVO) {
		return (BusinessContactVO)selectByPk("BusinessContactDAO.selectBusinessContact", businessContactVO);
	}

	public List<BusinessContactRecieve> selectBusinessContactRecieve(BusinessContactVO businessContactVO) {
		return list("BusinessContactDAO.selectBusinessContactRecieve", businessContactVO);
	}

	public void insertBusinessContact(BusinessContact businessContact) {
		insert("BusinessContactDAO.insertBusinessContact", businessContact);
	}

	public void updateBusinessContact(BusinessContact businessContact) {
		update("BusinessContactDAO.updateBusinessContact", businessContact);
	}

	
	
	public void deleteBusinessContact(BusinessContact businessContact) {
		update("BusinessContactDAO.deleteBusinessContact", businessContact);
	}

	public void insertBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) {
		insert("BusinessContactDAO.insertBusinessContactRecieve", businessContactRecieve);
	}

	public void updateBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) {
		update("BusinessContactDAO.updateBusinessContactRecieve", businessContactRecieve);
	}

	public void deleteBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) {
		delete("BusinessContactDAO.deleteBusinessContactRecieve", businessContactRecieve);
	}

	//2013.08.13 업무연락 알람 ON/OFF
	public void updateBusinessContactAlarm(BusinessContactRecieve businessContactRecieve) {
		// TODO Auto-generated method stub
		update("BusinessContactDAO.updateBusinessContactAlarm", businessContactRecieve);
		
	}

	
	public void setReadtime(BusinessContactVO businessContactVO) {
		update("BusinessContactDAO.setReadtime", businessContactVO);
	}

	public void deleteReadTime(BusinessContactComment businessContactComment) {
		update("BusinessContactDAO.deleteReadtime", businessContactComment);
	}
	
	public List<BusinessContactComment> selectBusinessContactCommentList(BusinessContactComment businessContactComment) {
		return list("BusinessContactDAO.selectBusinessContactCommentList", businessContactComment);
	}
	
	public int selectBusinessContactCommentListCnt(BusinessContactComment businessContactComment) {
		return (Integer)getSqlMapClientTemplate().queryForObject("BusinessContactDAO.selectBusinessContactCommentListCnt", businessContactComment);
	}

	public void insertBusinessContactComment(BusinessContactComment businessContactComment) {
		insert("BusinessContactDAO.insertBusinessContactComment", businessContactComment);
	}

	public void updateBusinessContactComment(BusinessContactComment businessContactComment) {
		update("BusinessContactDAO.updateBusinessContactComment", businessContactComment);		
	}

	public List<BusinessContactVO> selectBusinessContactListHeadSearch(BusinessContactVO bcVO) {
		return list("BusinessContactDAO.selectBusinessContactListHeadSearch", bcVO);
	}

	public int selectBusinessContactListTotCntHeadSearch(BusinessContactVO bcVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("BusinessContactDAO.selectBusinessContactListTotCntHeadSearch", bcVO);
	}

	public List<Integer> selectInterestUserNoList(BusinessContactRecieve businessContactRecieve) {
		return list("BusinessContactDAO.selectInterestUserNoList", businessContactRecieve);
	}

	public void setInterestBc(Map<String,Object> param) {
		update("BusinessContactDAO.setInterestBc", param);
	}

	
	//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
	public List<Integer> selectAlarmUserNoList(BusinessContactRecieve businessContactRecieve) {
		return list("BusinessContactDAO.selectAlarmUserNoList", businessContactRecieve);
	}


	public void setAlarmBc(Map<String,Object> param) {
	
		update("BusinessContactDAO.setAlarmBc", param);
	}





}
