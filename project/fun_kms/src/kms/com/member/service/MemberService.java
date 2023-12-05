package kms.com.member.service;

import java.util.List;
import java.util.Map;

import kms.com.common.exception.IdMixInputException;
import kms.com.community.service.MvucVO;

import org.json.simple.JSONObject;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface MemberService {
	
	List<MemberVO> selectMemberListMain(MemberVO memberVO) throws Exception;
	
	List<MemberVO> selectMemberList(MemberVO memberVO) throws Exception;
	
	List<MemberVO> selectBirthdayMemberList(MemberVO memberVO) throws Exception;
	
	int selectMemberListTotCnt(MemberVO memberVO) throws Exception;

	List<EgovMap> selectRankList() throws Exception;

	Map<String, Object> selectMember(MemberVO memberVO) throws Exception;
	
	Map<String, Object> mobileSelectMember(MemberVO memberVO) throws Exception;
	
	// 이력관리 S
	List<EgovMap> selectMemberCareerList(MemberVO memberVO) throws Exception; //이력관리 리스트
	EgovMap selectMemberCareerMain(MemberVO memberVO) throws Exception; //이력관리 상세정보 메인
	List<EgovMap> selectMemberCareerEdu(MemberVO memberVO) throws Exception;	//이력관리 상세정보 학력
	List<EgovMap> selectMemberCareerTrain(MemberVO memberVO) throws Exception;	//이력관리 상세정보 교육
	List<EgovMap> selectMemberCareerLicense(MemberVO memberVO) throws Exception;	//이력관리 상세정보 자격증
	List<EgovMap> selectMemberCareerWork(MemberVO memberVO) throws Exception;	//이력관리 상세정보 근무처 경력
	List<EgovMap> selectMemberCareerSkill(MemberVO memberVO) throws Exception; //이력관리 상세정보 기술경력
		
	int selectCareerChk(MemberVO memberVO) throws Exception;
	
	void insertCareerMain(MemberVO memberVO) throws Exception;	
	void insertCareerEdu(MemberVO memberVO) throws Exception;
	void insertCareerTrain(MemberVO memberVO) throws Exception;
	void insertCareerLicense(MemberVO memberVO) throws Exception;
	void insertCareerWork(MemberVO memberVO) throws Exception;
	void insertCareerSkill(MemberVO memberVO) throws Exception;
		
	void updtMemberCareerMain(MemberVO memberVO) throws Exception; //이력관리 상세정보 메인 수정
	void updtMemberCareerAll(MemberVO memberVO) throws Exception; //이력관리 전체수정
	
	void deleteMemberCareer(MemberVO memberVO) throws Exception;//플래그 변경
	void undeleteMemberCareer(MemberVO memberVO) throws Exception;//플래그 변경	
	void deleteCareerMain(MemberVO memberVO) throws Exception;	
	void deleteCareerEdu(MemberVO memberVO) throws Exception;	
	void deleteCareerTrain(MemberVO memberVO) throws Exception;
	void deleteCareerLicense(MemberVO memberVO) throws Exception;
	void deleteCareerWork(MemberVO memberVO) throws Exception;
	void deleteCareerSkill(MemberVO memberVO) throws Exception;
	// 이력관리 E
	
	void updtMember(MemberVO memberVO) throws Exception; //선택정보는 공백가능. 미입력시 공백으로 업데이트 되버림	
	
	/* 2013.07.25 김대현 웹메일 주소 */
	//상단 메뉴에서 회사 웹메일 링크 주소를 변경
	void updtMemberEmailLink(MemberVO memberVO) throws Exception; 
	
	void updtMember2(MemberVO memberVO) throws Exception; //입력받은 값만 수정하는 기능
	void updtMemberUiSetting(MemberVO memberVO) throws Exception;
	
	/* 2013.08.19 김대현  TOKEN_INFO 중복 제거*/
	void deleteDeviceInfo(MemberVO memberVO) throws Exception;
	
	void updateDeviceInfo(MemberVO memberVO) throws Exception;
	
	void uploadPhoto(Map<String, Object> map) throws Exception;
	
	void updateMemberPosition(MemberVO memberVO) throws Exception;
	
	void uploadInsa(Map<String, Object> map) throws Exception;
	
	void deleteInsa(Map<String, Object> map) throws Exception;

	void insertMember(MemberVO memberVO) throws Exception;

	//void insertLog(MemberVO memberVO) throws Exception;
	
	int memberIdChk(MemberVO memberVO) throws Exception;

	MemberVO selectMemberBasic(MemberVO memberVO) throws Exception;
	
	MemberVO selectMemberByIdNew(MemberVO memberVO) throws Exception;
	
	String getWorkOutsideYn(MemberVO memberVO) throws Exception;

	String versionConfirm(String userId) throws Exception;

	void versionUpdate(MemberVO memberVO) throws Exception;

	List<MemberVO> selectSimpleMemberList(MemberVO memberVO) throws Exception;
	
	MobileDeviceVO getDeviceInfo(String sabun) throws Exception;
	
	MvucVO selectMvucView() throws Exception;
	
	void mvucUpdate(MvucVO mvuc) throws Exception;
	
	
	
	// 메신저 관련  ---- S
	void deleteMemberMsn(Msn msn) throws Exception;
	void insertMemberMsn(Msn msn) throws Exception;
	List<Msn> getMemberMsnList(MemberVO memberVO) throws Exception;
	// 메신저 관련  ---- E
	
	//연봉협상 기간 변수 세팅
	public void setMemberNegoYn(MemberVO memberVO) throws Exception;
	
	// 인사발령 관련  ---- S
	List<PositionHistoryVO> selectPositionHistoryList(MemberVO memberVO) throws Exception;
	PositionHistoryVO selectPositionHistory(MemberVO memberVO) throws Exception;
	void insertPositionHistory(PositionHistoryVO phVO, MemberVO memberVO) throws Exception;
	void deletePositionHistory(PositionHistoryVO phVO) throws Exception;
	void revertMemberPosition(PositionHistoryVO phVO) throws Exception;
	List<PositionHistoryVO> selectPositionHistorySearch(MemberVO memberVO) throws Exception;
	// 인사발령 관련  ---- E


	/**
	 * user tree list 생성
	 * @param memberVO
	 * @return
	 */
	List selectUserTreeList(MemberVO memberVO) throws Exception;
	
	List selectUserTreeTeamList(MemberVO memberVO) throws Exception;
	List selectUserTreeTeamList_Admin(MemberVO memberVO) throws Exception;

	JSONObject checkValidUserMixs(String userMixs) throws IdMixInputException;
	JSONObject checkValidUserMixsAuth(Map<String, Object> commandMap) throws IdMixInputException;
	
	JSONObject checkValidLaborUserMixs(Map<String, Object> commandMap) throws IdMixInputException;
	
	
	/**
	 * 법인차량 사용 예약 사용자 조회용
	 * @param memberVO
	 * @return
	 */
	EgovMap selectMemberById(MemberVO memberVO) throws Exception;

	List<MemberVO> selectMemberListById(Map<String, Object> param) throws Exception;

	List<Integer> selectUserNoList(Map<String, Object> param) throws Exception;
	
	Integer selectUserNo(Map<String, Object> param) throws Exception;

	List<MemberVO> selectMemberListHeadSearch(Map<String, Object> commandMap) throws Exception;

	EgovMap selectMemberState(MemberVO memberVO) throws Exception;

	List<EgovMap> selectMemberStateStatusBoard(Map<String, Object> param) throws Exception;

	List<MemberVO> selectSearchLayerMemberList(MemberVO memberVO) throws Exception;

	void updateAttendCheckTable() throws Exception;
	
	List<MemberVO> selectLateMemberList() throws Exception;

	
	//아침인사 체크
	EgovMap selectGoodMorningState(MemberVO memberVO) throws Exception;
	
	/**
	 * 팀장별 하위 임직원 지각자 목록 추출
	 */
	List<EgovMap> selectLateArrivalList(Map<String, Object> param) throws Exception;
	
	/**
	 * 겸직부서 업데이트
	 */
	void updateSecondOrg(Map<String, Object> param) throws Exception;		//
	
	/**
	 * 휴대전화번호 일치하는 재직자수 반환
	 */
	int selectMemberByMoblNoCnt(MemberVO memberVO) throws Exception;
	
	/** 유저 ID 리스트로 유저 NO 리스트 생성 */
	String[] convertToUserNoFromUserId(String[] userIdList) throws Exception;
	
	/** 소속 팀원 리스트(장일 경우, 하위 부서 장 목록 추출) */
	List<EgovMap> selectTeamList(Map<String, Object> param) throws Exception;
	String selectTeamListToString(List<EgovMap> param) throws Exception;
	
	/** 부서장,상위부서장 목록 추출 */
	List<EgovMap> selectHeaderList(Map<String, Object> param) throws Exception;
}
