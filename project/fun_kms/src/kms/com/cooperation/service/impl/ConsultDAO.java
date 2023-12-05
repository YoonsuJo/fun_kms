package kms.com.cooperation.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.cooperation.service.ConsultCommentVO;
import kms.com.cooperation.service.ConsultManage;
import kms.com.cooperation.service.ConsultManageRecieve;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsConsultDAO")
public class ConsultDAO extends EgovAbstractDAO {

	public List selectCustomerList(Map<String, Object> param) {
		return list("ConsultCustomerDAO.selectCustomerList", param);
	}

	public int selectCustomerListCnt(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ConsultCustomerDAO.selectCustomerListCnt", param);
	}
	
	public Map<String, Object> selectCustomer(Map<String, Object> param) {
		return (Map<String, Object>) selectByPk("ConsultCustomerDAO.selectCustomer", param);
	}

	public void insertCustomer(Map<String, Object> param) {
		insert("ConsultCustomerDAO.insertCustomer", param);
	}

	public void updateCustomer(Map<String, Object> param) {
		update("ConsultCustomerDAO.updateCustomer", param);
	}
	
	public void deleteCustomer(Map<String, Object> param) {
		update("ConsultCustomerDAO.deleteCustomer", param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 List 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 List 상담관리 return
	 * @참조 : 
	 */
	public List selectConsultManageList(Map<String, Object> param) {
		return list("ConsultCustomerDAO.selectConsultManageList", param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 건수 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 건수 상담관리 return
	 * @참조 : 
	 */
	public int selectConsultManageListCnt(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ConsultCustomerDAO.selectConsultManageListCnt", param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 상세 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 상세 상담관리 return
	 * @참조 : 
	 */
	public ConsultManage selectConsultManage(ConsultManage consultManage) {
		return (ConsultManage ) selectByPk("ConsultCustomerDAO.selectConsultManage", consultManage);
	}
	
	public void setReadtime(ConsultManageRecieve consultManageReceive) {
		update("ConsultCustomerDAO.setReadtime", consultManageReceive);
	}
	
	
	public List<ConsultManageRecieve> selectConsultManageRecieve(ConsultManage consultManage) {
		return list("ConsultCustomerDAO.selectConsultManageRecieve", consultManage);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 인서트 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 인서트 상담관리 return
	 * @참조 : 
	 */
	public void insertConsultManage(ConsultManage consultManage) {
		insert("ConsultCustomerDAO.insertConsultManage", consultManage);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 인서트 상담관리 담당자/참조자 return
	 * @throws Exception
	 * @내용 : tbl_consult table 인서트 상담관리 담당자/참조자 return
	 * @참조 : 
	 */
	public void insertConsultManageReceive(ConsultManageRecieve consultManageReceive) {
		insert("ConsultCustomerDAO.insertConsultManageRecieve", consultManageReceive);
	}
	
	public void updateConsultManageReceive(ConsultManageRecieve consultManageReceive) {
		insert("ConsultCustomerDAO.updateConsultManageRecieve", consultManageReceive);
	}

	/**
	 * @param 
	 * @return tbl_consult table 수정 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 수정 상담관리 return
	 * @참조 : 
	 */
	public void updateConsultManage(ConsultManage consultManage) {
		update("ConsultCustomerDAO.updateConsultManage", consultManage);
	}
	
	public List<Integer> selectInterestUserNoList(ConsultManageRecieve consultManageReceive) {
		return list("ConsultCustomerDAO.selectInterestUserNoList", consultManageReceive);
	}

	public void setInterestCon(Map<String,Object> param) {
		update("ConsultCustomerDAO.setInterestCon", param);
	}

	public void deleteConsultManageRecieve(ConsultManageRecieve consultManageReceive) {
		delete("ConsultCustomerDAO.deleteConsultManageRecieve", consultManageReceive);
	}
	
	public void deleteConsultManage(Map<String, Object> param) {
		update("ConsultCustomerDAO.deleteConsultManage", param);
	}
	
	public List selectCustList(Map<String, Object> param) {
		return list("ConsultCustomerDAO.selectCustList", param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 인서트 상담관리덧글 return
	 * @throws Exception
	 * @내용 : tbl_consult table 인서트 상담관리덧글 return
	 * @참조 : 
	 */
	public void insertConsultManageComment(Map<String, Object> param) {
		insert("ConsultCustomerDAO.insertConsultManageComment", param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 인서트 상담관리덧글 인서트 시 read_tm 처리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 인서트 상담관리덧글 인서트 시 read_tm 처리 return
	 * @참조 : 
	 */
	public void deleteReadtm(Map<String, Object> param) {
		update("ConsultCustomerDAO.deleteReadtm", param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 List return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글 List return
	 * @참조 : 
	 */
	public List<ConsultCommentVO> selectConsultCommentList(ConsultCommentVO consultCommentVO)
		throws Exception {
		return list("ConsultCustomerDAO.selectConsultCommentList",consultCommentVO);
	}	
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 인서트 덧글 return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 인서트 덧글 return
	 * @참조 : 
	 */
	public void insertConsultComment(ConsultCommentVO consultCommentVO) {
		insert("ConsultCustomerDAO.insertConsultComment", consultCommentVO);
	}
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 업데이트 return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글  return
	 * @참조 : 
	 */
	public void updateConsultComment(ConsultCommentVO consultCommentVO) {
		update("ConsultCustomerDAO.updateConsultComment", consultCommentVO);
	}
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 삭제 return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글  return
	 * @참조 : 
	 */
	public void deleteConsultComment(ConsultCommentVO consultCommentVO) {
		update("ConsultCustomerDAO.deleteConsultComment", consultCommentVO);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 처리상태  return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 처리상태  return
	 * @참조 : 
	 */
	public ConsultManage selectConsultState(ConsultManage consultManage) {
		return (ConsultManage) selectByPk("ConsultCustomerDAO.selectConsultState", consultManage);
	}
	/**
	 * @param 
	 * @return tbl_consult_comment table 상담관리 처리상태 변경  return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 상담관리 처리상태 변경  return
	 * @참조 : 
	 */
	public void updateConsultState(ConsultManage consultManage) {
		update("ConsultCustomerDAO.updateConsultState", consultManage);
	}

	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 지라  return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 지라  return
	 * @참조 : 
	 */
	public ConsultManage selectConsultJira(ConsultManage consultManage) {
		return (ConsultManage) selectByPk("ConsultCustomerDAO.selectConsultJira", consultManage);
	}
	/**
	 * @param 
	 * @return tbl_consult_comment table 상담관리 지라 변경  return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 상담관리 지라 변경  return
	 * @참조 : 
	 */
	public void updateConsultJira(ConsultManage consultManage) {
		update("ConsultCustomerDAO.updateConsultJira", consultManage);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 통계 검색기간이전 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 통계 검색기간이전 return
	 * @참조 : 
	 */
	public List selectConsultManageList2(Map<String, Object> param) {
		return list("ConsultCustomerDAO.selectConsultManageList2", param);
	}
	
	public List selectConsultManageList3(Map<String, Object> param) {
		return list("ConsultCustomerDAO.selectConsultManageList3", param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 통계 검색기간이전 카운트 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 통계 검색기간이전 카운트 return
	 * @참조 : 
	 */
	public int selectConsultManageList2Cnt(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ConsultCustomerDAO.selectConsultManageList2Cnt", param);
	}
	
	public List selectConsultStatisticsList(Map<String, Object> param) {
		return list("ConsultCustomerDAO.selectConsultStatisticsList", param);
	}
	
	public List selectConsultStatisticsList(Map<String, Object> param, String type) {
		
		List resultList = new ArrayList();
		
		if ("type1".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType1", param);
		} else if ("type2".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType2", param);
		} else if ("type3".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType3", param);
		} else if ("type4".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType4", param);
		} else if ("type5".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType5", param);
		} else if ("type6".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType6", param);
		} else if ("type7".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType7", param);
		} else if ("type8".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType8", param);
		} else if ("type9".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType9", param);
		} else if ("type10".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType10", param);
		} else if ("type11".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType11", param);
		} else if ("type12".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType12", param);
		} else if ("type13".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType13", param);
		} else if ("type14".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType14", param);
		} else if ("type15".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType15", param);
		} else if ("type16".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType16", param);
		} else if ("type17".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType17", param);
		} else if ("type18".equals(type)) {
			resultList = list("ConsultCustomerDAO.selectConsultStatisticsListType18", param);
		}
		
		return resultList;
		
	}
	
	public List selectCompDurationService(Map<String, Object> param) {
		List resultList = list("ConsultCustomerDAO.selectCompDurationService", param);
		
		return resultList;
	}
	
	public List selectCompDurationError(Map<String, Object> param) {
		List resultList = list("ConsultCustomerDAO.selectCompDurationError", param);
		
		return resultList;
	}
	
	public List selectCompDurationDetail(Map<String, Object> param) {
		List resultList = list("ConsultCustomerDAO.selectCompDurationDetail", param);
		
		return resultList;
	}
	
	public List selectCompDurationTotal(Map<String, Object> param) {
		List resultList = list("ConsultCustomerDAO.selectCompDurationTotal", param);
		
		return resultList;
	}
	
	public List selectConsultStatList(Map<String, Object> param) {
		return list("ConsultCustomerDAO.selectConsultStatList", param);
	}
	
	public void updateIssue(ConsultManage consultManage) {
		update("ConsultCustomerDAO.updateIssue", consultManage);
	}
	
	/**
	 * 상품관리번호 삭제
	 */
	public void deleteRequestId(String consultNo) {
		update("ConsultCustomerDAO.deleteRequestId", consultNo);
	}
}
