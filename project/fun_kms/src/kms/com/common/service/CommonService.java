package kms.com.common.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.member.service.MemberVO;

public interface CommonService {
	EgovMap getCheckList(MemberVO user) throws Exception;
	
	EgovMap getReferenceList(MemberVO user) throws Exception;

	EgovMap getCommunityUnreadCnt(MemberVO user) throws Exception;
	
	List<EgovMap> getTaxCheckList(Map<String, Object> param) throws Exception;
	

	List<ExpansionVO> getExpansionList(MemberVO user) throws Exception;

	List<ExpansionVO> getUnuseExpansionList(MemberVO user) throws Exception;

	void updateExpansionOrder(Map<String, Object> map) throws Exception;

	void insertExpansionUse(Map<String, Object> commandMap) throws Exception;

	void deleteExpansionUse(Map<String, Object> commandMap) throws Exception;
	
	

	List<EgovMap> getMyMenuList(MemberVO user) throws Exception;

	EgovMap getCalendar(Map<String, Object> commandMap, MemberVO user) throws Exception;

	EgovMap getSchedule(Map<String, Object> commandMap, MemberVO user) throws Exception;

	void insertMymenu(Map<String, Object> commandMap) throws Exception;

	EgovMap getMyMenu(Map<String, Object> commandMap) throws Exception;

	void updateMymenu(Map<String, Object> commandMap) throws Exception;

	void deleteMymenu(Map<String, Object> commandMap) throws Exception;

	List<EgovMap> selectBusiIdList(int searchYear) throws Exception;

	List<EgovMap> selectOrgList(String searchOrgId) throws Exception;
	List<EgovMap> selectUnderOrgList(String[] searchBusiIdList) throws Exception;
	
	List<BusinessSectorVO> selectBusinessSectorList(Map<String, Object> commandMap) throws Exception;
	List<BusinessSectorVO> selectBusinessSectorList(int searchYear) throws Exception;
	List<EgovMap> selectBusinessSectorListSelBox(Map<String, Object> commandMap) throws Exception;
	List<EgovMap> selectBusinessSectorListSelBox(int searchYear) throws Exception;
	void insertBusinessSector(Map<String, Object> commandMap) throws Exception;
	void updateBusinessSector(Map<String, Object> commandMap) throws Exception;
	void updateBusinessSectorOrd(Map<String, Object> commandMap) throws Exception;

	List<EgovMap> selectCurrentUserList() throws Exception;
	void updateCurrentUser(Map<String, Object> commandMap) throws Exception;
	
	List<EgovMap> getScrapList(Map<String, Object> commandMap) throws Exception;
	int getScrapListCnt(Map<String, Object> commandMap) throws Exception;
	void insertScrap(Map<String, Object> commandMap) throws Exception;
	void deleteScrap(Map<String, Object> commandMap) throws Exception;
	
	List<EgovMap> getMyArticleList(Map<String, Object> commandMap) throws Exception;
	int getMyArticleListCnt(Map<String, Object> commandMap) throws Exception;
	
	List selectComtccmmndetailcode(Map<String, Object> commandMap) throws Exception;
	
	// 사업실적(통계) 기준
	List<StatisticSectorVO> selectStatisticSectorList(StatisticSectorVO ssVO) throws Exception;
	void insertStatisticSector(Map<String, Object> commandMap) throws Exception;
	void updateStatisticSector(Map<String, Object> commandMap) throws Exception;
	void deleteStatisticSector(Map<String, Object> commandMap) throws Exception;
	void updateStatisticSectorOrd(Map<String, Object> commandMap) throws Exception;
	
	// 외부 접속 로그 확인 처리
	void updataOuterNetLoginLog(MemberVO user) throws Exception;

}
