package kms.com.member.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.admin.organ.service.Organ;
import kms.com.community.service.MvucVO;
import kms.com.member.service.MemberVO;
import kms.com.member.service.MobileDeviceVO;
import kms.com.member.service.Msn;
import kms.com.member.service.PositionHistoryVO;
import kms.com.member.vo.UserVO;

import org.json.simple.JSONObject;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("KmsMemberDAO")
public class MemberDAO extends EgovAbstractDAO {

	public List<MemberVO> selectMemberListMain(MemberVO memberVO) {
		return list("MemberDAO.selectMemberListMain", memberVO);
	}
	
	public List<MemberVO> selectMemberList(MemberVO memberVO) {
		return list("MemberDAO.selectMemberList", memberVO);
	}
	
	public List<MemberVO> selectBirthdayMemberList(MemberVO memberVO) {
		return list("MemberDAO.selectBirthdayMemberList", memberVO);
	}	

	public int selectMemberListTotCnt(MemberVO memberVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MemberDAO.selectMemberListTotCnt", memberVO);
	}

	public String getWorkOutsideYn(MemberVO memberVO) {
		return (String)getSqlMapClientTemplate().queryForObject("MemberDAO.getWorkOutsideYn", memberVO);
	}

	public String versionConfirm(String userId) {
		return (String)getSqlMapClientTemplate().queryForObject("MemberDAO.versionConfirm", userId);
	}

	public MobileDeviceVO getDeviceInfo(String sabun) {
		return (MobileDeviceVO)getSqlMapClientTemplate().queryForObject("MemberDAO.getDeviceInfo", sabun);
	}

	public MvucVO selectMvucView() {
		return (MvucVO)getSqlMapClientTemplate().queryForObject("MemberDAO.selectMvucView");
	}

	public List<EgovMap> selectRankList() {
		return list("MemberDAO.selectRankList", null);
	}

	public MemberVO selectMember(MemberVO memberVO) {
		return (MemberVO)selectByPk("MemberDAO.selectMember", memberVO);
	}
	
	public MemberVO selectMemberByIdNew(MemberVO memberVO) {
		return (MemberVO)selectByPk("MemberDAO.selectMemberByIdNew", memberVO);
	}	
	
	public MemberVO mobileSelectMember(MemberVO memberVO) {
		return (MemberVO)selectByPk("MemberDAO.mobileSelectMember", memberVO);
	}

	public List<EgovMap> selectMemberInsa(MemberVO memberVO) {
		return list("MemberDAO.selectMemberInsa", memberVO);
	}

	public List<Msn> selectMemberMsn(MemberVO memberVO) {
		return list("MemberDAO.selectMemberMsn", memberVO);
	}

	public void deleteMemberMsn(Msn msn) {
		delete("MemberDAO.deleteMemberMsn", msn);
	}

	public void versionUpdate(MemberVO memberVO) {
		delete("MemberDAO.versionUpdate", memberVO);
	}

	public void mvucUpdate(MvucVO mvuc) {
		delete("MemberDAO.mvucUpdate", mvuc);
	}

	public void insertMemberMsn(Msn msn) {
		insert("MemberDAO.insertMemberMsn", msn);
	}

	//기본정보 초기화 가능
	public void updtMember(MemberVO memberVO) {
		update("MemberDAO.updtMember", memberVO);
	}

	/* 2013.07.25 김대현 웹메일 주소 */
	//상단 메뉴에서 회사 웹메일 링크 주소를 변경
	public void updtMemberEmailLink(MemberVO memberVO) {
		update("MemberDAO.updtMemberEmailLink", memberVO);
	}
	
	
	//입력된 정보만 업데이트. 공백정보무시
	public void updtMember2(MemberVO memberVO) {
		update("MemberDAO.updtMember2", memberVO);
	}
	
	public void updtMemberUiSetting(MemberVO memberVO) {
		update("MemberDAO.updtMemberUiSetting", memberVO);
	}
	
	/* 2013.08.19 김대현  TOKEN_INFO 중복 제거*/
	public void deleteDeviceInfo(MemberVO memberVO) {
		update("MemberDAO.deleteDeviceInfo", memberVO);
	}
	
	
	public void updateDeviceInfo(MemberVO memberVO) {
		update("MemberDAO.updateDeviceInfo", memberVO);
	}

	public List<PositionHistoryVO> selectPositionHistoryList(MemberVO memberVO) {
		return list("MemberDAO.selectPositionHistoryList", memberVO);
	}

	public PositionHistoryVO selectPositionHistory(MemberVO memberVO) {
		return (PositionHistoryVO)selectByPk("MemberDAO.selectPositionHistory", memberVO);
	}

	public PositionHistoryVO selectPositionHistoryByCode(Map<String, Object> param) {
		return (PositionHistoryVO)selectByPk("MemberDAO.selectPositionHistoryByCode", param);
	}

	public void insertPositionHistory(PositionHistoryVO commandMap) {
		insert("MemberDAO.insertPositionHistory", commandMap);
	}

	public void deletePositionHistory(PositionHistoryVO commandMap) {
		delete("MemberDAO.deletePositionHistory", commandMap);
	}

	public void uploadPhoto(Map<String, Object> map) {
		update("MemberDAO.uploadPhoto", map);
	}

	public void updateMemberPosition(MemberVO memberVO) {
		update("MemberDAO.updateMemberPosition", memberVO);
	}

	public void uploadInsa(Map<String, Object> map) {
		insert("MemberDAO.insertMemberInsa", map);
	}

	public void deleteInsa(Map<String, Object> map) {
		delete("MemberDAO.deleteMemberInsa", map);
	}

	public int memberIdChk(MemberVO memberVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MemberDAO.memberIdChk", memberVO);
	}

	public void insertMember(MemberVO memberVO) {
		insert("MemberDAO.insertMember", memberVO);
	}

	public List<MemberVO> selectSimpleMemberList(MemberVO memberVO) {
		return list("MemberDAO.selectSimpleMemberList",memberVO);
	}

	public List<PositionHistoryVO> selectPositionHistorySearch(MemberVO memberVO) {
		return list("MemberDAO.selectPositionHistorySearch", memberVO);
	}

	public List selectUserTreeList(MemberVO memberVO) {
		return list("MemberDAO.selectUserTreeList", memberVO);
	}
	

	
	
	public List selectUserTreeTeamList(MemberVO memberVO) {
		return list("MemberDAO.selectUserTreeTeamList", memberVO);
	}
	
	
	public List selectUserTreeTeamList_Admin(MemberVO memberVO) {
		return list("MemberDAO.selectUserTreeTeamList_Admin", memberVO);
	}

	public int checkValidUserMix(String userMix) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MemberDAO.checkValidUserMix", userMix);
	}

	public int checkValidUserMixTeam(MemberVO memberVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MemberDAO.checkValidUserMixTeam", memberVO);
	}
	
	public EgovMap selectMemberById(MemberVO memberVO) {
		return (EgovMap)selectByPk("MemberDAO.selectMemberById", memberVO);
	}

	public List<MemberVO> selectMemberListById(Map<String, Object> param) {
		return list("MemberDAO.selectMemberListById", param);
	}

	public List<Integer> selectUserNoList(Map<String, Object> param) {
		return list("MemberDAO.selectUserNoList", param);
	}
	
	public int selectUserNo(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MemberDAO.selectUserNo", param);
	}

	public List<MemberVO> selectMemberListHeadSearch(Map<String, Object> commandMap) {
		return list("MemberDAO.selectMemberListHeadSearch", commandMap);
	}

	public EgovMap selectMemberState(MemberVO memberVO) {
		return (EgovMap)selectByPk("MemberDAO.selectMemberState", memberVO);
	}

	public List<EgovMap> selectMemberStateStatusBoard(Map<String, Object> param) {
		return list("MemberDAO.selectMemberStateStatusBoard", param);
	}

	public List<MemberVO> selectMemberPositionChk(MemberVO memberVO) {
		return list("MemberDAO.selectMemberPositionChk", memberVO);
	}

	public void insertPositionHistoryOrgUpdate(Organ organ) {
		insert("MemberDAO.insertPositionHistoryOrgUpdate", organ);
	}

	public List<MemberVO> selectSearchLayerMemberList(MemberVO memberVO) {
		return list("MemberDAO.selectSearchLayerMemberList", memberVO);
	}
	
	public void updateAttendCheckTable() {
		update("MemberDAO.updateAttendCheckTable", null);
	}

	public List<MemberVO> selectLateMemberList() {
		return list("MemberDAO.selectLateMemberList", null);
	}
		
	/* 이력관리 S */
	//이력관리 조회
	public List<EgovMap> selectMemberCareerList(MemberVO memberVO) {
		return list("MemberDAO.selectMemberCareerList", memberVO);
	}
	public EgovMap selectMemberCareerMain(MemberVO memberVO) {
		return (EgovMap)selectByPk("MemberDAO.selectMemberCareerMain", memberVO);
	}
	public List<EgovMap> selectMemberCareerEdu(MemberVO memberVO) {
		return list ("MemberDAO.selectMemberCareerEdu", memberVO);
	}
	public List<EgovMap> selectMemberCareerTrain(MemberVO memberVO) {
		return list ("MemberDAO.selectMemberCareerTrain", memberVO);
	}
	public List<EgovMap> selectMemberCareerLicense(MemberVO memberVO) {
		return list ("MemberDAO.selectMemberCareerLicense", memberVO);
	}
	public List<EgovMap> selectMemberCareerWork(MemberVO memberVO){
		return list("MemberDAO.selectMemberCareerWork",memberVO);
	}
	public List<EgovMap> selectMemberCareerSkill(MemberVO memberVO) {
		return list ("MemberDAO.selectMemberCareerSkill", memberVO);
	}
	public int selectCareerChk(MemberVO memberVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MemberDAO.selectCareerChk", memberVO);
	}
	
	//이력관리 입력
	//MemberVO 입력
	public void insertCareerMain(MemberVO memberVO) {
		insert("MemberDAO.insertCareerMain", memberVO);
	}	
	public void insertCareerEdu(MemberVO memberVO) {
		insert("MemberDAO.insertEduLevel", memberVO);
	}
	public void insertCareerTrain(MemberVO memberVO) {
		insert("MemberDAO.insertCareer", memberVO);
	}
	public void insertCareerLicense(MemberVO memberVO) {
		insert("MemberDAO.insertCareer", memberVO);
	}
	public void insertCareerWork(MemberVO memberVO) {
		insert("MemberDAO.insertCareer", memberVO);
	}
	public void insertCareerSkill(MemberVO memberVO) {
		insert("MemberDAO.insertCareer", memberVO);
	}
	//JSONObject 입력
	public void insertCareerEdu(JSONObject memberVO) {
		insert("MemberDAO.insertCareerEdu", memberVO);
	}
	public void insertCareerTrain(JSONObject memberVO) {
		insert("MemberDAO.insertCareerTrain", memberVO);
	}
	public void insertCareerLicense(JSONObject memberVO) {
		insert("MemberDAO.insertCareerLicense", memberVO);
	}
	public void insertCareerWork(JSONObject memberVO) {
		insert("MemberDAO.insertCareerWork", memberVO);
	}
	public void insertCareerSkill(JSONObject memberVO) {
		insert("MemberDAO.insertCareerSkill", memberVO);
	}	
	//이력관리 수정
	public void updtCareerMain(MemberVO memberVO) {
		update("MemberDAO.updtCareerMain", memberVO); //쿼리 없음 미사용
	}
	public void updtMemberCareerDeleteYn(MemberVO memberVO) {
		update("MemberDAO.updtMemberCareerDeleteYn", memberVO);
	}	
	//이력관리 삭제	
	public void deleteCareerMain(MemberVO memberVO) {
		delete("MemberDAO.deleteCareerMain", memberVO);
	}
	public void deleteCareerEdu(MemberVO memberVO) {
		delete("MemberDAO.deleteCareerEdu", memberVO);
	}
	public void deleteCareerTrain(MemberVO memberVO) {
		delete("MemberDAO.deleteCareerTrain", memberVO);
	}
	public void deleteCareerLicense(MemberVO memberVO) {
		delete("MemberDAO.deleteCareerLicense", memberVO);
	}
	public void deleteCareerWork(MemberVO memberVO) {
		delete("MemberDAO.deleteCareerWork", memberVO);
	}
	public void deleteCareerSkill(MemberVO memberVO) {
		delete("MemberDAO.deleteCareerSkill", memberVO);
	}
	/* 이력관리 E */

	
	
	public List<EgovMap> selectOrgTreeListForLaborUser(Map<String, Object> param) {
		return list("MemberDAO.selectOrgTreeListForLaborUser", param);
	}
	
	
	public List<EgovMap> selectLeaderListForLaborUser(Map<String, Object> param) {
		return list("MemberDAO.selectLeaderListForLaborUser", param);
	}
	
	
	//아침인사 체크
	public EgovMap selectGoodMorningState(MemberVO memberVO) {
		return (EgovMap)selectByPk("MemberDAO.selectGoodMorningState", memberVO);
	}
	
	/**
	 * 팀장별 하위 임직원 지각자 목록 추출
	 */
	public List<EgovMap> selectLateArrivalList(Map<String, Object> param) {
		return list("MemberDAO.selectLateArrivalList", param);
	}
	
	/**
	 * 사원정보 간단한 정보만 조회(사원명, 조직명 등)
	 */
	public EgovMap selectSimpleMember(MemberVO memberVO) {
		return (EgovMap)selectByPk("MemberDAO.selectSimpleMember", memberVO);
	}
	
	/**
	 * 겸직부서 업데이트
	 */
	public void updateSecondOrg(Map<String, Object> param) {
		update("MemberDAO.updateSecondOrg", param);
	}
	
	/**
	 * 휴대전화번호 일치하는 재직자수 반환
	 */
	public int selectMemberByMoblNoCnt(MemberVO memberVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MemberDAO.selectMemberByMoblNoCnt", memberVO);
	}
	
	public List<EgovMap> convertToUserNoFromUserId(Map<String, Object> param) {
		return list("MemberDAO.convertToUserNoFromUserId", param);
	}
	
	public List<EgovMap> selectTeamList(Map<String, Object> param) {
		return list("MemberDAO.selectTeamList", param);
	}
	
	public List<EgovMap> selectHeaderList(Map<String, Object> param) {
		return list("MemberDAO.selectHeaderList", param);
	}

	// TENY_170403 		새롭게 만들어봄.
	public List<UserVO> selectUserList(Map<String, Object> param) {
		return list("MemberDAO.selectUserList", param);
	}
}
