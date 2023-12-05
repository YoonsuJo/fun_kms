package kms.com.member.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kms.com.common.exception.IdMixInputException;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.MvucVO;
import kms.com.cooperation.service.DayReport;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.MobileDeviceVO;
import kms.com.member.service.Msn;
import kms.com.member.service.PositionHistoryVO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("KmsMemberService")
public class MemberServiceImpl implements MemberService {

    @Resource(name="KmsMemberDAO")
    private MemberDAO memberDAO;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
    @Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    @Override
    public List<MemberVO> selectMemberListMain(MemberVO memberVO) throws Exception {
    	return memberDAO.selectMemberListMain(memberVO);
    }
    
	@Override
	public List<MemberVO> selectMemberList(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberList(memberVO);
	}
	
	@Override
	public List<MemberVO> selectBirthdayMemberList(MemberVO memberVO) throws Exception {
		return memberDAO.selectBirthdayMemberList(memberVO);
	}	

	@Override
	public int selectMemberListTotCnt(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberListTotCnt(memberVO);
	}

	@Override
	public String getWorkOutsideYn(MemberVO memberVO) throws Exception {
		return memberDAO.getWorkOutsideYn(memberVO);
	}

	@Override
	public String versionConfirm(String userId) throws Exception {
		return memberDAO.versionConfirm(userId);
	}

	@Override
	public MobileDeviceVO getDeviceInfo(String sabun) throws Exception {
		return memberDAO.getDeviceInfo(sabun);
	}

	@Override
	public MvucVO selectMvucView() throws Exception {
		return memberDAO.selectMvucView();
	}

	@Override
	public List<EgovMap> selectRankList() throws Exception {
		return memberDAO.selectRankList();
	}

	@Override
	public Map<String, Object> selectMember(MemberVO memberVO) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO member = memberDAO.selectMember(memberVO);
		List<EgovMap> insaFileList = memberDAO.selectMemberInsa(memberVO);
		List<Msn> msnList = memberDAO.selectMemberMsn(memberVO);
		
		map.put("member", member);
		map.put("insaFileList", insaFileList);
		map.put("msnList", msnList);
		
		return map;
	}
		
	@Override
	public Map<String, Object> mobileSelectMember(MemberVO memberVO) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO member = memberDAO.mobileSelectMember(memberVO);
		map.put("member", member);
		return map;
	}
	
	@Override
	public MemberVO selectMemberBasic(MemberVO memberVO) throws Exception {		
		return memberDAO.selectMember(memberVO);
	}
	
	@Override
	public MemberVO selectMemberByIdNew(MemberVO memberVO) throws Exception {		
		return memberDAO.selectMemberByIdNew(memberVO);
	}	

	@Override
	public void updtMember(MemberVO memberVO) throws Exception {
		memberDAO.updtMember(memberVO);
	}

	
	/* 2013.07.25 김대현 웹메일 주소 */
	//상단 메뉴에서 회사 웹메일 링크 주소를 변경
	@Override
	public void updtMemberEmailLink(MemberVO memberVO) throws Exception {
		memberDAO.updtMemberEmailLink(memberVO);
	}
	
	@Override
	public void updtMember2(MemberVO memberVO) throws Exception {
		memberDAO.updtMember2(memberVO);
	}
	
	@Override
	public void mvucUpdate(MvucVO mvuc) throws Exception {
		memberDAO.mvucUpdate(mvuc);
	}
	
	@Override
	public void updtMemberUiSetting(MemberVO memberVO) throws Exception {
		memberDAO.updtMemberUiSetting(memberVO);
	}

	/* 2013.08.19 김대현  TOKEN_INFO 중복 제거*/
	@Override
	public void deleteDeviceInfo(MemberVO memberVO) throws Exception {
		memberDAO.deleteDeviceInfo(memberVO);
	}
	
	
	@Override
	public void updateDeviceInfo(MemberVO memberVO) throws Exception {
		memberDAO.updateDeviceInfo(memberVO);
	}

	@Override
	public void uploadPhoto(Map<String, Object> map) throws Exception {
		memberDAO.uploadPhoto(map);
	}

	@Override
	public void updateMemberPosition(MemberVO memberVO) throws Exception {
		memberDAO.updateMemberPosition(memberVO);
	}

	@Override
	public void uploadInsa(Map<String, Object> map) throws Exception {
		memberDAO.uploadInsa(map);
	}

	@Override
	public void deleteInsa(Map<String, Object> map) throws Exception {
		memberDAO.deleteInsa(map);
	}

	@Override
	public void insertMember(MemberVO memberVO) throws Exception {
		memberDAO.insertMember(memberVO);
	}

	@Override
	public void versionUpdate(MemberVO memberVO) throws Exception {
		memberDAO.versionUpdate(memberVO);
	}

	@Override
	public int memberIdChk(MemberVO memberVO) throws Exception {
		return memberDAO.memberIdChk(memberVO);
	}
	
	@Override
	public List<MemberVO> selectSimpleMemberList(MemberVO memberVO) throws Exception {
		return memberDAO.selectSimpleMemberList(memberVO);
	}
	
	
	
	// 메신저 관련 ----- S
	@Override
	public void deleteMemberMsn(Msn msn) throws Exception {
		memberDAO.deleteMemberMsn(msn);
	}
	@Override
	public List<Msn> getMemberMsnList(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberMsn(memberVO);
	}
	@Override
	public void insertMemberMsn(Msn msn) throws Exception {
		memberDAO.insertMemberMsn(msn);
	}
	// 메신저 관련 ----- E

	public void setMemberNegoYn(MemberVO memberVO) throws Exception {
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS035");
		List<CmmnDetailCode> negoPeriod = cmmUseService.selectCmmCodeDetail(codeVO);
		if(negoPeriod.size()==3){
	    	int negoStart = Integer.parseInt(negoPeriod.get(0).getCodeDc() );
	    	int negoEnd =   Integer.parseInt(negoPeriod.get(1).getCodeDc() );    	
	    	int today2 = Integer.parseInt(CalendarUtil.getToday().substring(4,8) );
	    	boolean isInNego =  negoPeriod.get(2).getCodeDc().equals("Y");
	    	boolean negoYn = memberVO.isSalaryadmin() || ( isInNego && (negoStart < negoEnd ? 
	    				(negoStart <= today2) && (today2 <= negoEnd) : (negoStart <= today2) || (today2 <= negoEnd) )
	    				);	    
	    	memberVO.setIsNegoYn(negoYn ? "Y" : "N");
		}
	}
	
	//인사발령 기능	
	@Override
	public void insertPositionHistory(PositionHistoryVO phVO, MemberVO memberVO) throws Exception {
		
		String aftRankId = phVO.getAftRankId();
    	if(phVO.getBfrRankId().equals(aftRankId) == false ){
    		memberVO.setPromotionYear(Integer.toString(CalendarUtil.getYear()) );
        	updtMember2(memberVO);
    	}		
		
		if ("H".equals(phVO.getAftPosition()) || "S".equals(phVO.getAftPosition())) {

			List<MemberVO> list = memberDAO.selectMemberPositionChk(memberVO);
			for (int i=0; i<list.size(); i++) {
				MemberVO member = list.get(i);
				
				if (member.getNo() != memberVO.getNo()) {
					PositionHistoryVO ph = new PositionHistoryVO();
					
					ph.setUserNo(member.getNo());
					ph.setChngCode("CH");
					ph.setAdminNo(phVO.getAdminNo());
					ph.setChngDt(CalendarUtil.getToday());
					ph.setNote(memberVO.getUserNm() + " 의 " + phVO.getChngDtPrint() + " 보직변경에 의한 자동 인사발령");
					
					ph.setBfrOrgnztId(member.getOrgnztId());
					ph.setBfrRankId(member.getRankId());
					ph.setBfrCompId(member.getCompnyId());
					ph.setBfrPosition(member.getPosition());
					
					ph.setAftOrgnztId(member.getOrgnztId());
					ph.setAftRankId(member.getRankId());
					ph.setAftCompId(member.getCompnyId());
					ph.setAftPosition("N");
					
					member.setPosition("N");
	
					memberDAO.updateMemberPosition(member);
					memberDAO.insertPositionHistory(ph);
				}
			}
		}
    	
    	memberVO.setOrgnztId(phVO.getAftOrgnztId());
    	memberVO.setRankId(phVO.getAftRankId());
    	memberVO.setCompnyId(phVO.getAftCompId());
    	memberVO.setPosition(phVO.getAftPosition());
    	memberVO.setWorkSt(phVO.getWorkSt());
    	
    	if ("EN".equals(phVO.getChngCode())) {
    		memberVO.setCompinDt(phVO.getChngDt());
    	} else if ("RT".equals(phVO.getChngCode())) {
    		memberVO.setOrgnztId(propertyService.getString("retireOrgId"));
    		memberVO.setCompotDt(phVO.getChngDt());
    		phVO.setAftOrgnztId(propertyService.getString("retireOrgId"));
    	} else if ("RE".equals(phVO.getChngCode())) {
    		//재입사시 입사날짜 안바꿈 2012-11-16 Arvin
    		//memberVO.setCompinDt(phVO.getChngDt());
    		memberVO.setCompinDt(null);
    		memberVO.setCompotDt("");
    	}
    	
		memberDAO.updateMemberPosition(memberVO);
		memberDAO.insertPositionHistory(phVO);		
	}

	@Override
	public void revertMemberPosition(PositionHistoryVO phVO) throws Exception {
    	MemberVO memberVO = new MemberVO();
    	memberVO.setNo(phVO.getUserNo());
    	memberVO = memberDAO.selectMember(memberVO);
    	
    	// 부서,직급 복원
		memberVO.setOrgnztId(phVO.getBfrOrgnztId());
		memberVO.setRankId(phVO.getBfrRankId());
		memberVO.setCompnyId(phVO.getBfrCompId());
		boolean positionRestored = false;
		
    	if ("EN".equals(phVO.getChngCode())) { // 입사
			memberVO.setWorkSt("W");
			memberVO.setCompinDt("");
    		memberVO.setOrgnztId("");
    		memberVO.setRankId("");
    		memberVO.setCompnyId("");
    	}
    	else if ("RE".equals(phVO.getChngCode())) { // 재입사
    		memberVO.setWorkSt("R");
    		
    		// 퇴사일을 기존 퇴사일로 변경
    		Map<String, Object> param1 = new HashMap<String, Object>();
    		param1.put("userNo", phVO.getUserNo());
    		param1.put("chngCode", "RT");
    		PositionHistoryVO lastRT = memberDAO.selectPositionHistoryByCode(param1);
    		if (lastRT != null) memberVO.setCompotDt(lastRT.getChngDt());

    		// 입사일을 기존 입사일로 변경
    		Map<String, Object> param2 = new HashMap<String, Object>();
    		param2.put("userNo", phVO.getUserNo());
    		param2.put("chngCode", "EN");
    		PositionHistoryVO lastEN = memberDAO.selectPositionHistoryByCode(param2);
    		if (lastEN != null) memberVO.setCompinDt(lastEN.getChngDt());

    		memberVO.setOrgnztId(propertyService.getString("retireOrgId"));
    		memberVO.setRankId("");
    	}
    	else if ("RT".equals(phVO.getChngCode())) { // 퇴직
    		String workState = "W";

    		// 퇴직 이전에 근무상태였는지 휴직상태였는지 판단
    		Map<String, Object> param1 = new HashMap<String, Object>();
    		param1.put("userNo", phVO.getUserNo());
    		param1.put("chngCode", "LV");
    		PositionHistoryVO lastLV = memberDAO.selectPositionHistoryByCode(param1);
    		
    		if (lastLV != null) {
        		Map<String, Object> param2 = new HashMap<String, Object>();
        		param2.put("userNo", phVO.getUserNo());
        		param2.put("chngCode", "BK");
        		PositionHistoryVO lastBK = memberDAO.selectPositionHistoryByCode(param2);

        		if (lastBK == null
        				|| (lastLV.getChngDt().equals(lastBK.getChngDt()) && lastLV.getNo() > lastBK.getNo())
        				|| lastLV.getChngDt().compareTo(lastBK.getChngDt()) > 0) {
        			workState = "L";
        		}
    		}

    		memberVO.setWorkSt(workState);
			memberVO.setCompotDt("");
    	}
    	else if ("LV".equals(phVO.getChngCode())) { // 휴직
			memberVO.setWorkSt("W");
    	}
    	else if ("BK".equals(phVO.getChngCode())) { // 복귀
			memberVO.setWorkSt("L");
    	}
    	else if ("CH".equals(phVO.getChngCode())) { // 변경
    		// 부서원에서 부서장으로는 되돌릴 수 없음 (이미 다른 부서장이 발령되었을 가능성이 있으므로)
    		if ("N".equals(phVO.getAftPosition())
    				&& ("H".equals(phVO.getBfrPosition()) || "S".equals(phVO.getBfrPosition()))) {
    			memberVO.setPosition("N");
    			positionRestored = true;
    		}
    		
    		// 기존 부서로 돌아갈 때는 보직을 해제함 (이미 해당 부서에 다른 부서장이 발령되었을 가능성이 있으므로)
    		if (phVO.getBfrOrgnztId() != null
    				&& !phVO.getBfrOrgnztId().equals(phVO.getAftOrgnztId())
    				&& ("H".equals(phVO.getBfrPosition()) || "S".equals(phVO.getBfrPosition()))) {
    			memberVO.setPosition("N");
    			positionRestored = true;
    		}
    	}
		
    	// 보직 복원
		if (positionRestored == false) memberVO.setPosition(phVO.getBfrPosition());

		memberDAO.updateMemberPosition(memberVO);
	}

	@Override
	public void deletePositionHistory(PositionHistoryVO phVO) throws Exception {
		memberDAO.deletePositionHistory(phVO);
	}
	
	@Override
	public PositionHistoryVO selectPositionHistory(MemberVO memberVO) throws Exception {
		return memberDAO.selectPositionHistory(memberVO);
	}

	@Override
	public List<PositionHistoryVO> selectPositionHistoryList(MemberVO memberVO) throws Exception {
		return memberDAO.selectPositionHistoryList(memberVO);
	}

	@Override
	public List<PositionHistoryVO> selectPositionHistorySearch(MemberVO memberVO) throws Exception {
		return memberDAO.selectPositionHistorySearch(memberVO);
	}

	@Override
	public List selectUserTreeList(MemberVO memberVO) throws Exception {
		return memberDAO.selectUserTreeList(memberVO);
	}
	
	@Override
	public List selectUserTreeTeamList(MemberVO memberVO) throws Exception {
		return memberDAO.selectUserTreeTeamList(memberVO);
	}
	
	@Override
	public List selectUserTreeTeamList_Admin(MemberVO memberVO) throws Exception {
		return memberDAO.selectUserTreeTeamList_Admin(memberVO);
	}

	
	@Override
	public JSONObject checkValidUserMixs(String userMixs) throws IdMixInputException {
		JSONObject js = new JSONObject();

		JSONArray errorInform = new JSONArray();
		userMixs = userMixs.replaceAll(";", ",").replaceAll("&lt;", "(").replace("&gt;", ")").replaceAll(" ", "");
		String[] userMixsArray = userMixs.split(",");
		boolean isValid = true;
		for(int i=0; i< userMixsArray.length ; i++)
		{
			int cnt = memberDAO.checkValidUserMix(userMixsArray[i]);
			if(cnt==0)//유저에 없음.
			{
				//역순으로 정렬이되도록.
				errorInform.add(0, i);
				isValid = false;
			}
			else
				;
		}
		if(isValid)
		{
			js.put("errorCode", 1);
		}
		else
		{
			js.put("errorCode", 3);
			js.put("errorInform",errorInform);
		}	
		return js;
		
		
	}
	
	@Override
	public JSONObject checkValidUserMixsAuth(Map<String, Object> commandMap) throws IdMixInputException {
		JSONObject js = new JSONObject();
		
		String userMixs = (String)commandMap.get("userMixs");
		String orgnztId = (String)commandMap.get("orgnztId");
		String orgnztIdSec = (String)commandMap.get("orgnztIdSec");
		String isAdmin = (String)commandMap.get("isAdmin");
		
		MemberVO memberVO = new MemberVO();
		JSONArray errorInform = new JSONArray();
		userMixs = userMixs.replaceAll(";", ",").replaceAll("&lt;", "(").replace("&gt;", ")").replaceAll(" ", "");
		String[] userMixsArray = userMixs.split(",");
		boolean isValid = true;
		boolean isValid2 = true;
		
		for(int i=0; i< userMixsArray.length ; i++)
		{
			
			int cnt = memberDAO.checkValidUserMix(userMixsArray[i]);
		
			memberVO = new MemberVO();
			memberVO.setUserNm(userMixsArray[i]);
			memberVO.setOrgnztId(orgnztId);
			memberVO.setOrgnztIdSec(orgnztIdSec);
			memberVO.setIsAdmin(isAdmin);
			int cnt2  = memberDAO.checkValidUserMixTeam(memberVO);

			if(cnt==0)//유저에 없음.
			{
				//역순으로 정렬이되도록.
				errorInform.add(0, i);
				isValid = false;
			}
			
			if(cnt2==0)//팀에 없음.
			{
				//역순으로 정렬이되도록.
				errorInform.add(0, i);
				isValid2 = false;
			}
			
			else;
		}
		if(isValid)
		{
			if(isValid2)
			{
				js.put("errorCode", 1);
			}
			else
			{
				js.put("errorCode", 4);
				js.put("errorInform",errorInform);
			}
			
		}
		else
		{
				js.put("errorCode", 3);
				js.put("errorInform",errorInform);
			
		}	
		return js;
		
		
	}



	
	@Override
	public JSONObject checkValidLaborUserMixs(Map<String, Object> param) throws IdMixInputException {
		JSONObject js = new JSONObject();
		
		String reviewerMixs = (String)param.get("reviewerMixs");
		String laborUserMixs = (String)param.get("laborUserMixs");
		String writerMix = (String)param.get("writerMix");
	

		JSONArray errorInform = new JSONArray();
				
		
	    List<String> userMixList = CommonUtil.makeValidIdListArray(laborUserMixs);
		param.put("userMixList", userMixList);
		List<EgovMap> orgTreeList = memberDAO.selectOrgTreeListForLaborUser(param);
		
		String orgTreeListArray = "";
		for(int i=0; i< orgTreeList.size() ; i++){
			orgTreeListArray += orgTreeList.get(i).get("orgTree")+"/";
		}
		orgTreeListArray = orgTreeListArray.replace("/", ",");
		
		List<String> orgnztList = CommonUtil.makeValidIdListArray(orgTreeListArray);
		
		param.put("orgnztList", orgnztList);
		List<EgovMap> leaderList = memberDAO.selectLeaderListForLaborUser(param);
		
		String leaderMixs = "";
		for(int i=0; i< leaderList.size() ; i++){
			leaderMixs += leaderList.get(i).get("userMix") +",";
		}
		
		// [2014/06/23, 김동우] 검토자에 작성자가 포함될 경우 강제로 제거(매출이관보고서, 종합매출보고서 적용)
		leaderMixs = leaderMixs.replace(writerMix, "");

		List<String> reviewerMixsList = CommonUtil.makeValidIdListArray(reviewerMixs);
		List<String> leaderMixsList = CommonUtil.makeValidIdListArray(leaderMixs);
		
		for(int i=0; i< reviewerMixsList.size() ; i++){	
			for (int y = 0 ; y < leaderMixsList.size()  ; y++){
				if(reviewerMixsList.get(i).equals(leaderMixsList.get(y))){
					leaderMixsList.remove(y);
						y--;
				}				
			}			
		}

			
		String msg = "";
		
		boolean isValid = true;

		int cnt = leaderMixsList.size();
		if(cnt > 0){
			for(int i=0; i< leaderMixsList.size() ; i++){	
				if(i == leaderMixsList.size()-1){
					msg += leaderMixsList.get(i).substring(0, leaderMixsList.get(i).indexOf("("));
				}else{
					msg += leaderMixsList.get(i).substring(0, leaderMixsList.get(i).indexOf("(")) + ", ";	
				}
				
			
			}
			isValid = false;	
		}

		
		if(isValid){			
			js.put("errorCode", 1);
		}else{
			js.put("errorCode", 4);
			js.put("msg",msg);			
		}
		
		return js;
		
		
	}

	

	@Override
	public EgovMap selectMemberById(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberById(memberVO);
	}

	@Override
	public List<MemberVO> selectMemberListById(Map<String, Object> param) throws Exception {
		return memberDAO.selectMemberListById(param);
	}

	@Override
	public List<Integer> selectUserNoList(Map<String, Object> param) throws Exception {
		return memberDAO.selectUserNoList(param);
	}
	
	@Override
	public Integer selectUserNo(Map<String, Object> param) throws Exception {
		return memberDAO.selectUserNo(param);
	}

	@Override
	public List<MemberVO> selectMemberListHeadSearch(Map<String, Object> commandMap) throws Exception {
		return memberDAO.selectMemberListHeadSearch(commandMap);
	}

	@Override
	public EgovMap selectMemberState(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberState(memberVO);
	}

	@Override
	public List<EgovMap> selectMemberStateStatusBoard(Map<String, Object> param) throws Exception {
		return memberDAO.selectMemberStateStatusBoard(param);
	}

	@Override
	public List<MemberVO> selectSearchLayerMemberList(MemberVO memberVO) throws Exception {
		return memberDAO.selectSearchLayerMemberList(memberVO);
	}
	
	@Override
	public void updateAttendCheckTable() throws Exception {
		memberDAO.updateAttendCheckTable();
	}

	@Override
	public List<MemberVO> selectLateMemberList() throws Exception {
		return memberDAO.selectLateMemberList();
	}
	
	// 이력관리  S	
	@Override
	public List<EgovMap> selectMemberCareerList(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberCareerList(memberVO);
	}
	@Override
	public EgovMap selectMemberCareerMain(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberCareerMain(memberVO);
	}
	@Override
	public List<EgovMap> selectMemberCareerEdu(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberCareerEdu(memberVO);
	}
	@Override
	public List<EgovMap> selectMemberCareerTrain(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberCareerTrain(memberVO);
	}
	@Override
	public List<EgovMap> selectMemberCareerLicense(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberCareerLicense(memberVO);
	}
	@Override
	public List<EgovMap> selectMemberCareerWork(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberCareerWork(memberVO);
	}
	@Override
	public List<EgovMap> selectMemberCareerSkill(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberCareerSkill(memberVO);
	}
	@Override
	public int selectCareerChk(MemberVO memberVO) throws Exception {
		return memberDAO.selectCareerChk(memberVO);
	}

	//이력관리 입력
	@Override
	public void insertCareerMain(MemberVO memberVO) throws Exception {
		memberDAO.insertCareerMain(memberVO);
	}	
	@Override
	public void insertCareerEdu(MemberVO memberVO) throws Exception {
		memberDAO.insertCareerEdu(memberVO);
	}
	@Override
	public void insertCareerTrain(MemberVO memberVO) throws Exception {
		memberDAO.insertCareerTrain(memberVO);
	}
	@Override
	public void insertCareerLicense(MemberVO memberVO) throws Exception {
		memberDAO.insertCareerLicense(memberVO);
	}
	@Override
	public void insertCareerWork(MemberVO memberVO) throws Exception {
		memberDAO.insertCareerWork(memberVO);
	}
	@Override
	public void insertCareerSkill(MemberVO memberVO) throws Exception {
		memberDAO.insertCareerSkill(memberVO);
	}
	//이력관리 수정
	@Override
	public void updtMemberCareerMain(MemberVO memberVO) throws Exception {
		memberDAO.updtCareerMain(memberVO);
	}
	//이력관리 전체수정
	@Override
	public void updtMemberCareerAll(MemberVO memberVO) throws Exception {
		
		String jsonEducationString = memberVO.getJsonEducationString();
		String jsonTrainString = memberVO.getJsonTrainString();
		String jsonLicenseString = memberVO.getJsonLicenseString();
		String jsonWorkString = memberVO.getJsonWorkString();
		String jsonSkillString = memberVO.getJsonSkillString();
		
		deleteCareerMain(memberVO);
		deleteCareerEdu(memberVO);
		deleteCareerLicense(memberVO);
		deleteCareerSkill(memberVO);
		deleteCareerTrain(memberVO);
		deleteCareerWork(memberVO);
		
		memberDAO.insertCareerMain(memberVO);
		
        if(jsonEducationString.equals("undefined")==false) {
    		String educationArray = CommonUtil.unescape(jsonEducationString);
            JSONArray educationArrayJ =  (JSONArray)JSONValue.parseWithException(educationArray);
            Iterator it = educationArrayJ.iterator();
            while(it.hasNext()) {
            	JSONObject ob = (JSONObject)it.next();            	            	
            	//jsonObject 자체가 맵이므로 그대로 사용해서 insert 가능.
            	memberDAO.insertCareerEdu(ob);
            }
        }
        if(jsonTrainString.equals("undefined")==false) {    
        	String trainArray = CommonUtil.unescape(jsonTrainString);
        	JSONArray trainArrayJ =  (JSONArray)JSONValue.parseWithException(trainArray);
        	Iterator it = trainArrayJ.iterator();
            while(it.hasNext()) {
            	JSONObject ob = (JSONObject)it.next();
            	memberDAO.insertCareerTrain(ob);
            }
        }
        if(jsonLicenseString.equals("undefined")==false) {
        	String licenseArray = CommonUtil.unescape(jsonLicenseString);
            JSONArray licenseArrayJ =  (JSONArray)JSONValue.parseWithException(licenseArray);
            Iterator it = licenseArrayJ.iterator();
            while(it.hasNext()) {
            	JSONObject ob = (JSONObject)it.next();
            	memberDAO.insertCareerLicense(ob);
            }
        }
        if(jsonWorkString.equals("undefined")==false) {  
        	String workArray = CommonUtil.unescape(jsonWorkString);
            JSONArray workArrayJ =  (JSONArray)JSONValue.parseWithException(workArray);
            Iterator it = workArrayJ.iterator();
            while(it.hasNext()) {
            	JSONObject ob = (JSONObject)it.next();
            	memberDAO.insertCareerWork(ob);
            }
        }
        if(jsonSkillString.equals("undefined")==false) { 
        	String skillArray = CommonUtil.unescape(jsonSkillString);
            JSONArray skillArrayJ =  (JSONArray)JSONValue.parseWithException(skillArray);
            Iterator it = skillArrayJ.iterator();
            while(it.hasNext()) {
            	JSONObject ob = (JSONObject)it.next();
            	memberDAO.insertCareerSkill(ob);
            }
        }
	}	
	//이력관리 삭제처리	
	@Override
	public void deleteMemberCareer(MemberVO memberVO) throws Exception {
		memberVO.setDeleteYn("Y");
		memberDAO.updtMemberCareerDeleteYn(memberVO);
	}
	//이력관리 삭제복구처리	
	@Override
	public void undeleteMemberCareer(MemberVO memberVO) throws Exception {
		memberVO.setDeleteYn("N");
		memberDAO.updtMemberCareerDeleteYn(memberVO);
	}
	//이력관리 삭제
	@Override
	public void deleteCareerMain(MemberVO memberVO) throws Exception {
		memberDAO.deleteCareerMain(memberVO);
	}
	@Override
	public void deleteCareerEdu(MemberVO memberVO) throws Exception {
		memberDAO.deleteCareerEdu(memberVO);
	}
	@Override
	public void deleteCareerTrain(MemberVO memberVO) throws Exception {
		memberDAO.deleteCareerTrain(memberVO);
	}
	@Override
	public void deleteCareerLicense(MemberVO memberVO) throws Exception {
		memberDAO.deleteCareerLicense(memberVO);
	}
	@Override
	public void deleteCareerWork(MemberVO memberVO) throws Exception {
		memberDAO.deleteCareerWork(memberVO);
	}
	@Override
	public void deleteCareerSkill(MemberVO memberVO) throws Exception {
		memberDAO.deleteCareerSkill(memberVO);
	}	
	//이력관리 E	
	

	//아침인사 체크
	@Override
	public EgovMap selectGoodMorningState(MemberVO memberVO) throws Exception {
		return memberDAO.selectGoodMorningState(memberVO);
	}
	
	/**
	 * 팀장별 하위 임직원 지각자 목록 추출
	 */
	@Override
	public List<EgovMap> selectLateArrivalList(Map<String, Object> param) throws Exception {
		return memberDAO.selectLateArrivalList(param);
	}

	/**
	 * 겸직부서 업데이트
	 */
	@Override
	public void updateSecondOrg(Map<String, Object> param) throws Exception {
		memberDAO.updateSecondOrg(param);
	}

	@Override
	public int selectMemberByMoblNoCnt(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberByMoblNoCnt(memberVO);
	}

	@Override
	public String[] convertToUserNoFromUserId(String[] userIdList)
			throws Exception {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("userIdList", userIdList);

		List<EgovMap> userNoList = memberDAO.convertToUserNoFromUserId(searchMap);
		String[] returnArr = new String[userNoList.size()];
		for(int i=0; i < userNoList.size(); i++) {
			returnArr[i] = userNoList.get(i).get("no").toString();
		}
		return returnArr;
	}

	@Override
	public List<EgovMap> selectTeamList(Map<String, Object> param) throws Exception {
		return memberDAO.selectTeamList(param);
	}

	@Override
	public String selectTeamListToString(List<EgovMap> param) throws Exception {
		String result = "";
		for (EgovMap tmp: param) {
			result += tmp.get("userNm") + "(" + tmp.get("userId") + "), ";
		}
		return result;
	}
	
	@Override
	public List<EgovMap> selectHeaderList(Map<String, Object> param) throws Exception {
		return memberDAO.selectHeaderList(param);
	}
}
