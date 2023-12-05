package kms.com.common.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.common.service.BusinessSectorVO;
import kms.com.common.service.Expansion;
import kms.com.common.service.ExpansionVO;
import kms.com.common.service.StatisticSectorVO;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("KmsCommonDAO")
public class CommonDAO extends EgovAbstractDAO {

	public List<EgovMap> getCheckList(MemberVO user) {
		return list("CommonDAO.getCheckList", user);
	}
	
	public List<EgovMap> getReferenceList(MemberVO user) {
		return list("CommonDAO.getReferenceList", user);
	}

	public List<EgovMap> getCommunityUnreadCnt(MemberVO user) {
		return list("CommonDAO.getCommunityUnreadCnt", user);
	}
	
	public List<EgovMap> getTaxCheckList(Map<String, Object> param) {
		return list("CommonDAO.getTaxCheckList", param);
	}
	
	
	public List<ExpansionVO> getExpansionList(MemberVO user) {
		return list("CommonDAO.getExpansionList", user);
	}
	
	public List<ExpansionVO> getUnuseExpansionList(MemberVO user) {
		return list("CommonDAO.getUnuseExpansionList", user);
	}

	public void updateExpansionOrder(Map<String, Object> map) {
		update("CommonDAO.updateExpansionOrder", map);
	}

	public void deleteExpansionUse(Map<String, Object> commandMap) {
		delete("CommonDAO.deleteExpansionUse", commandMap);
	}

	public void insertExpansionUse(Map<String, Object> commandMap) {
		delete("CommonDAO.insertExpansionUse", commandMap);
	}
	
	

	public List<EgovMap> getMyMenuList(MemberVO user) {
		return list("CommonDAO.getMyMenuList", user);
	}

	public void insertMymenu(Map<String, Object> commandMap) {
		insert("CommonDAO.insertMymenu", commandMap);
	}

	public EgovMap getMyMynu(Map<String, Object> commandMap) {
		return (EgovMap)selectByPk("CommonDAO.getMyMenu", commandMap);
	}

	public void updateMymenu(Map<String, Object> commandMap) {
		update("CommonDAO.updateMymenu", commandMap);
	}

	public void deleteMymenu(Map<String, Object> commandMap) {
		update("CommonDAO.deleteMymenu", commandMap);
	}

	
	public List<EgovMap> selectBusiIdList(Map<String, Object> commandMap) {
		return list("CommonDAO.selectBusiIdList", commandMap);
	}

	public List<EgovMap> selectOrgList(Map<String, Object> param) {
		return list("CommonDAO.selectOrgList", param);
	}

	public List<EgovMap> selectUnderOrgList(Map<String, Object> param) {
		return list("CommonDAO.selectUnderOrgList", param);
	}
	
	public List<BusinessSectorVO> selectBusinessSectorList(Map<String, Object> commandMap) {
		return list("CommonDAO.selectBusinessSectorList", commandMap);
	}

	public void insertBusinessSector(Map<String, Object> commandMap) {
		insert("CommonDAO.insertBusinessSector", commandMap);
	}

	public void updateBusinessSector(Map<String, Object> commandMap) {
		update("CommonDAO.updateBusinessSector", commandMap);
	}
	
	public void updateBusinessSectorOrd(Map<String, Object> commandMap) {
		update("CommonDAO.updateBusinessSectorOrd", commandMap);
	}

	public List<EgovMap> selectBusinessSectorListSelBox(Map<String, Object> param) {
		return list("CommonDAO.selectBusinessSectorListSelBox", param);
	}

	
	public List<EgovMap> selectCurrentUserList() {
		return list("CommonDAO.selectCurrentUserList", null);
	}
	
	public int selectCurrentUserCntChek(Map<String, Object> param) {
		return (Integer) getSqlMapClientTemplate().queryForObject("CommonDAO.selectCurrentUserCntChek", param);
	}

	public void insertCurrentUser(Map<String, Object> commandMap) {
		insert("CommonDAO.insertCurrentUser", commandMap);
	}

	public void updateCurrentUser(Map<String, Object> commandMap) {
		update("CommonDAO.updateCurrentUser", commandMap);
	}
	
	public EgovMap selectCurrentUser(Map<String, Object> param) {
		return (EgovMap) selectByPk("CommonDAO.selectCurrentUser", param);
	}
	
	public List<EgovMap> getScrapList(Map<String, Object> commandMap) {
		return list("CommonDAO.getScrapList", commandMap);
	}
	
	public int getScrapListCnt(Map<String, Object> commandMap) {
		return (Integer) getSqlMapClientTemplate().queryForObject("CommonDAO.getScrapListCnt", commandMap);
	}

	public void insertScrap(Map<String, Object> commandMap) {
		insert("CommonDAO.insertScrap", commandMap);
	}

	public void deleteScrap(Map<String, Object> commandMap) {
		update("CommonDAO.deleteScrap", commandMap);
	}
	
	public List<EgovMap> getMyArticleList(Map<String, Object> commandMap) {
		return list("CommonDAO.getMyArticleList", commandMap);
	}
	
	public int getMyArticleListCnt(Map<String, Object> commandMap) {
		return (Integer) getSqlMapClientTemplate().queryForObject("CommonDAO.getMyArticleListCnt", commandMap);
	}
	
	public List selectComtccmmndetailcode(Map<String, Object> commandMap) {
		return list("CommonDAO.selectComtccmmndetailcode", commandMap);
	}

	public List<StatisticSectorVO> selectStatisticSectorList(Map<String, Object> commandMap) {
		return list("CommonDAO.selectStatisticSectorList", commandMap);
	}

	public void insertStatisticSector(Map<String, Object> commandMap) {
		insert("CommonDAO.insertStatisticSector", commandMap);
	}

	public void updateStatisticSector(Map<String, Object> commandMap) {
		update("CommonDAO.updateStatisticSector", commandMap);
	}
	
	public void deleteStatisticSector(Map<String, Object> commandMap) {
		delete("CommonDAO.deleteStatisticSector", commandMap);
	}
	
	public void updateStatisticSectorOrd(Map<String, Object> commandMap) {
		update("CommonDAO.updateStatisticSectorOrd", commandMap);
	}
	
	// 외부 접속 로그 확인 처리
	public void updataOuterNetLoginLog(MemberVO user) {
		update("CommonDAO.updataOuterNetLoginLog", user);
	}
}
