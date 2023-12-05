package kms.com.cooperation.web;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.MissionHistoryVO;
import kms.com.cooperation.service.MissionService;
import kms.com.cooperation.service.MissionVO;
import kms.com.cooperation.service.impl.MissionDAO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : MissionController.java
 * @Description : MissionController class
 * @Modification Information
 *
 * @author 김대현
 * @since 2013.08.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class MissionController {

	@Resource(name = "KmsMissionService")
	protected MissionService missionService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "kmsMissionIdGnrService")
	private EgovIdGnrService idGnrService;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;

	@Resource(name = "KmsMemberService")
	private MemberService memberService;

	@Resource(name = "KmsMissionDAO")
	private MissionDAO missionDAO;


	
	
	@RequestMapping("/cooperation/insertMissionView.do")
		public String insertMissionView(@ModelAttribute("searchVO") MissionVO missionVO,
				Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		String userInfo = user.getUserNm() + "(" + user.getUserId() + ")";
		
		Date date = new Date();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
		String today = simpleDate.format(date);
		
		model.addAttribute("today", today);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("searchVO", missionVO);
		
		return "cooperation/coop_missionW";
	}
	

	@RequestMapping("/cooperation/insertMissionSubView.do")
	public String insertMissionSubView(@ModelAttribute("searchVO") MissionVO missionVO,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		MissionVO mission = missionService.selectMission(missionVO);
		
		model.addAttribute("searchVO", missionVO);
		model.addAttribute("user", user);			
		model.addAttribute("mission", mission);	
		
	return "cooperation/coop_missionSubW";
}
	

	@RequestMapping("/cooperation/insertMission.do")
	public String insertMission(
			MultipartHttpServletRequest multiRequest, 
			@ModelAttribute("missionVO") MissionVO missionVO,
			@ModelAttribute("missionVO2") MissionVO missionVO2,
			ModelMap model
			) throws Exception {
		MemberVO user = SessionUtil.getMember(multiRequest);

		List<String> userMixList = CommonUtil.makeValidIdListArray(missionVO.getLeaderMixes());
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userMixList", userMixList);
    	param.put("alarmUserList", 0);
		List<MemberVO> memberList = memberService.selectMemberListById(param);
		List<FileVO> result = null;
		
		
		for(int i = 0; i < memberList.size(); i++){
			String atchFileId = "";
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "MISSION_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}
			
			missionVO.setWriterNo(user.getNo());
			missionVO.setLeaderNo(memberList.get(i).getUserNo());
			missionVO.setAttachFileId(atchFileId);
			
			String missionId = idGnrService.getNextStringId();
			missionVO.setMissionId(missionId);
			
			if(missionVO.getMissionLv() == 0){
				missionVO.setPrntMissionId(missionId);
				missionVO.setMissionTree(missionId);
			}
			
			missionService.insertMission(missionVO);
			
			if(missionVO.getMissionLv() > 0){
				missionService.updateMissionTree(missionVO);
			}

			MissionHistoryVO missionHistoryVO = new MissionHistoryVO();
			missionHistoryVO.setMissionId(missionVO.getMissionId());
			missionHistoryVO.setHistoryStat("W");
			missionHistoryVO.setWriterNo(user.getNo());
			missionService.insertMissionHistory(missionHistoryVO);
			
		}
		
		//model.addAttribute("message", "등록하였습니다.");
		//model.addAttribute("message2", "");
		model.addAttribute("redirectUrl", missionVO.getRedirectUrl());
		return "/error/messageRedirect";
		//return "redirect:/cooperation/selectMissionSearchList.do";
	}

	
	
	
	@RequestMapping("/cooperation/selectMission.do")
	public String selectMission(@ModelAttribute("searchVO") MissionVO missionVO,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
	
		
		List<MissionHistoryVO> missionHistoryList = missionService.selectMissionHistoryList(missionVO);		
		
		
		MissionVO mission = missionService.selectMission(missionVO);		
	
		//missionVO.setType(req.getParameter("type"));
		if("stat".equals(missionVO.getType())){
			if("".equals(missionVO.getSearchLeaderMixes()) || missionVO.getSearchLeaderMixes() == null){
				missionVO.setSearchLeaderMixes(req.getParameter("searchLeaderMixes"));
			}
			if("".equals(missionVO.getSearchDate()) || missionVO.getSearchDate() == null){
				missionVO.setSearchDate(req.getParameter("searchDate"));
			}
		}

		if("search".equals(missionVO.getType())){
			if("".equals(missionVO.getSearchPrjId()) || missionVO.getSearchPrjId() == null){
				missionVO.setSearchPrjId(req.getParameter("searchPrjId"));
			}
			if("".equals(missionVO.getSearchPrjNm()) || missionVO.getSearchPrjNm() == null){
				missionVO.setSearchPrjNm(req.getParameter("searchPrjNm"));
			}
			if("".equals(missionVO.getSearchDateS()) || missionVO.getSearchDateS() == null){
				missionVO.setSearchDateS(req.getParameter("searchDateS"));
			}
			if("".equals(missionVO.getSearchDateE()) || missionVO.getSearchDateE() == null){
				missionVO.setSearchDateE(req.getParameter("searchDateE"));
			}
			if("".equals(missionVO.getSearchWriterNm()) || missionVO.getSearchWriterNm() == null){
				missionVO.setSearchWriterNm(req.getParameter("searchWriterNm"));
			}
			if("".equals(missionVO.getIncludeICMission()) || missionVO.getIncludeICMission() == null){
				missionVO.setIncludeICMission(req.getParameter("includeICMission"));
			}
			if("".equals(missionVO.getIncludeCMission()) || missionVO.getIncludeCMission() == null){
				missionVO.setIncludeCMission(req.getParameter("includeCMission"));
			}
			if("".equals(missionVO.getSearchLeaderMixes()) || missionVO.getSearchLeaderMixes() == null){
				missionVO.setSearchLeaderMixes(req.getParameter("searchLeaderMixes"));
			}
			if("".equals(missionVO.getSearchKeyword()) || missionVO.getSearchKeyword() == null){
				missionVO.setSearchKeyword(req.getParameter("searchKeyword"));
			}			
		}

		missionVO.setIncludeEndMission(req.getParameter("includeEndMission"));
		missionVO.setMissionTree(req.getParameter("missionTree"));
		
		/*List missionLinkList = missionService.missionTree(missionVO);
		String curmissionLv = "";
		
		for (int i = 0; i < missionLinkList.size(); i++) {
			if (missionLinkList.get(i).toString().split("missionId=")[1].split(",")[0].equals(missionVO.getMissionId())) {
				System.out.println("같다===============================================");
				curmissionLv = missionLinkList.get(i).toString().split("missionLv=")[1].split(",")[0];
			}
			System.out.println("missionVO.getMissionId() ============> " + missionVO.getMissionId());
			System.out.println("missionId ================> " + missionLinkList.get(i).toString().split("missionId=")[1].split(",")[0]);
			System.out.println("missionLv ===============> " + missionLinkList.get(i).toString().split("missionLv=")[1].split(",")[0]);
		}
		System.out.println("curmissionLv ======================> " + curmissionLv);*/
		model.addAttribute("searchVO", missionVO);
		model.addAttribute("user", user);			
		model.addAttribute("mission", mission);
		model.addAttribute("missionHistoryList", missionHistoryList);		
		model.addAttribute("missionLinkList", missionService.missionTree(missionVO));
		model.addAttribute("missionId", missionVO.getMissionId());
		return "cooperation/coop_missionV";
	}
	
	
	
	@RequestMapping(value={"/cooperation/selectMissionSearchList.do"})
	public String selectMissionList(@ModelAttribute("searchVO") MissionVO missionVO,
			Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		missionVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		missionVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(missionVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(missionVO.getPageUnit());
		paginationInfo.setPageSize(missionVO.getPageSize()); 
	
		missionVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		missionVO.setLastIndex(paginationInfo.getLastRecordIndex());
		missionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		missionVO.setUserNo(user.getUserNo());
	    missionVO.setType(req.getParameter("type"));
		
		if("".equals(missionVO.getIncludeEndMission()) || missionVO.getIncludeEndMission() == null){
			missionVO.setIncludeEndMission("Y");
		}
		
		if("".equals(missionVO.getIncludeICMission()) || missionVO.getIncludeICMission() == null){
			missionVO.setIncludeICMission("Y");
		}
		
		if("".equals(missionVO.getIncludeCMission()) || missionVO.getIncludeCMission() == null){
			missionVO.setIncludeCMission("N");
		}
		
		String returnPage = "";
		if("search".equals(missionVO.getType())){
		    //missionVO.setSearchPrjId(req.getParameter("searchPrjId"));
			returnPage =  "cooperation/coop_missionSearchL";	
		}else if("prj".equals(missionVO.getType())){		
			if("".equals(missionVO.getSearchPrjId()) || missionVO.getSearchPrjId() == null){
				missionVO.setSearchPrjId("null"); //선택한 프로젝트가 없으면  'null' 값을 집어넣었음
			}
			returnPage = "cooperation/coop_missionPrjL";			
		}else{
			returnPage = "cooperation/coop_missionSearchL";				
		}
		
		missionVO.setUserList(CommonUtil.makeValidIdList(missionVO.getSearchLeaderMixes()));
		List<MissionVO> missionList = missionService.selectMissionList(missionVO);
		int totCnt = missionService.selectMissionListTotCnt(missionVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", missionVO);
		model.addAttribute("missionList", missionList);

		
		return returnPage;				
	}
	
	
	@RequestMapping(value={"/cooperation/selectMissionMyList.do"})
	public String selectMissionMyList(@ModelAttribute("searchVO") MissionVO missionVO,
			Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);		
		missionVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		missionVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(missionVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(missionVO.getPageUnit());
		paginationInfo.setPageSize(missionVO.getPageSize());
	
		missionVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		missionVO.setLastIndex(paginationInfo.getLastRecordIndex());
		missionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		missionVO.setUserNo(user.getUserNo());	
		
		String type = missionVO.getType();
	
		if("".equals(missionVO.getType()) || missionVO.getType() == null){
			missionVO.setType("today");
			type = missionVO.getType();
		}
		
		if("".equals(missionVO.getIncludeEndMission()) || missionVO.getIncludeEndMission() == null){
			missionVO.setIncludeEndMission("Y");
		}
		
		List<MissionVO> missionList = missionService.selectMissionList(missionVO);
		int totCnt = missionService.selectMissionListTotCnt(missionVO);
		paginationInfo.setTotalRecordCount(totCnt);		

		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", missionVO);
		model.addAttribute("missionList", missionList);

		
		missionVO.setType("today");
		int todayAllCnt = missionService.selectMissionListTotCnt(missionVO);
		int todayIcCnt =missionService.selectMissionInCompleteTotCnt(missionVO);
		
		missionVO.setType("seven");
		int sevenAllCnt = missionService.selectMissionListTotCnt(missionVO);
		int sevenIcCnt = missionService.selectMissionInCompleteTotCnt(missionVO);
		
		missionVO.setType("thirty");
		int thirtyAllCnt = missionService.selectMissionListTotCnt(missionVO);
		int thirtyIcCnt = missionService.selectMissionInCompleteTotCnt(missionVO);
		
		missionVO.setType("next");
		int nextAllCnt = missionService.selectMissionListTotCnt(missionVO);
		int nextIcCnt = missionService.selectMissionInCompleteTotCnt(missionVO);		
		
		missionVO.setType(type);//오늘, 7일내, 30일이내, 향후 Cnt를 구한후 다시 원래의 type으로 셋팅
		
		model.addAttribute("todayAllCnt", todayAllCnt);
		model.addAttribute("todayIcCnt", todayIcCnt);
		model.addAttribute("sevenAllCnt", sevenAllCnt);
		model.addAttribute("sevenIcCnt", sevenIcCnt);
		model.addAttribute("thirtyAllCnt", thirtyAllCnt);
		model.addAttribute("thirtyIcCnt", thirtyIcCnt);
		model.addAttribute("nextAllCnt", nextAllCnt);
		model.addAttribute("nextIcCnt", nextIcCnt);
		
		return "cooperation/coop_missionMyL";

	}
	
	
	
	@RequestMapping(value={"/cooperation/selectMissionStatList.do"})
	public String selectMissionStatList(@ModelAttribute("searchVO") MissionVO missionVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);		
		
		List<MemberVO> teamMemberList = null;
		if(!"H".equals(user.getPosition())){
			user.setSearchCondition("teamMember");
			teamMemberList = memberService.selectMemberList(user);
		}else{
			user.setSearchCondition("teamLeader");
			teamMemberList = memberService.selectMemberList(user);
			if(teamMemberList.size() == 1){
				user.setSearchCondition("teamMember");
				teamMemberList = memberService.selectMemberList(user);
			}
		}
		
		String teamMember = "";
		for(int i= 0; i < teamMemberList.size(); i++){
			teamMember += teamMemberList.get(i).getUserNm() + "(" + teamMemberList.get(i).getUserId() + ")"+ ",";
		}

		missionVO.setTeamMember(teamMember);

		
		String searchDate = missionVO.getSearchDate();
		//String leaderMixes = missionVO.getLeaderMixes();
		String dateMove = missionVO.getDateMove();
		
		if (searchDate == null || searchDate.equals("")) {
			searchDate = CalendarUtil.getToday();
			missionVO.setSearchLeaderMixes(teamMember);
		}
		if (dateMove != null && dateMove.equals("") == false) {
			searchDate = CalendarUtil.getDate(searchDate, Integer.parseInt(dateMove));
		}
//		if (missionVO.getSearchLeaderMixes() == null || missionVO.getSearchLeaderMixes().equals("")) {
//			missionVO.setSearchLeaderMixes(teamMember);
//		}
		missionVO.setToday(CalendarUtil.getToday());
		missionVO.setSearchDate(searchDate);
		
		missionVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		missionVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(missionVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(missionVO.getPageUnit());
		paginationInfo.setPageSize(missionVO.getPageSize());
	
		missionVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		missionVO.setLastIndex(paginationInfo.getLastRecordIndex());
		missionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		missionVO.setUserNo(user.getUserNo());
		missionVO.setSearchDate(searchDate);	
		
		if("".equals(missionVO.getType()) || missionVO.getType() == null){
			missionVO.setType("stat");
		}
		
		if("".equals(missionVO.getIncludeEndMission()) || missionVO.getIncludeEndMission() == null){
			missionVO.setIncludeEndMission("Y");
		}


		missionVO.setUserList(CommonUtil.makeValidIdList(missionVO.getSearchLeaderMixes()));

		List<MissionVO> missionList = missionService.selectMissionList(missionVO);

		List<String> userMixList = CommonUtil.makeValidIdListArray(missionVO.getSearchLeaderMixes());
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userMixList", userMixList);
    	param.put("alarmUserList", 0);
		List<MemberVO> memberList = memberService.selectMemberListById(param);
		
		int totCnt = missionService.selectMissionListTotCnt(missionVO);
		paginationInfo.setTotalRecordCount(totCnt);		

		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", missionVO);
		model.addAttribute("missionList", missionList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("teamMemberList", teamMemberList);
		model.addAttribute("user", user);		
		return "cooperation/coop_missionStatL";
		
	}
	
	
	
	@RequestMapping(value = "/ajax/missionTree.do")
	public String missionTree(
			@ModelAttribute("searchVO") MissionVO missionVO,
			HttpServletRequest request, HttpServletResponse response,HttpServletRequest req,
			ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		missionVO.setUserNo(user.getUserNo());
		missionVO.setType(req.getParameter("type"));
		missionVO.setIncludeEndMission(req.getParameter("includeEndMission"));
		missionVO.setSearchPrjId(req.getParameter("searchPrjId"));
		missionVO.setSearchKeyword(URLDecoder.decode(missionVO.getSearchKeyword(),"UTF-8"));
		missionVO.setPrjNm(req.getParameter("prjId"));
		System.out.println("req.getParameter(prjId) =================> " + req.getParameter("prjId"));
		if ("P".equals(missionVO.getType())) { //프로젝트 미션 추가
			System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			model.addAttribute("resultListTree", missionService.missionTreeP(missionVO));
		}else{
			model.addAttribute("resultListTree", missionService.missionTree(missionVO));
		}
	
		if("A".equals(missionVO.getType())){
			return "/ajax/missionTree";	
		}else{
			return "/ajax/missionTreeUserIncluded";	
		}
	}
	
	
	
	@RequestMapping("/cooperation/updateMissionView.do")
	public String updateMissionView(@ModelAttribute("searchVO") MissionVO missionVO,
			HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		
		missionVO.setUserNo(user.getNo());
		MissionVO mission = missionService.selectMission(missionVO);
		
		model.addAttribute("user", user);			
		model.addAttribute("searchVO", missionVO);
		model.addAttribute("mission", mission);
		
		return "cooperation/coop_missionM";
	}
	
	@RequestMapping("/cooperation/updateMission.do")
	public String updateMission(
			MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") MissionVO missionVO, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(multiRequest);
    	
		List<String> userMixList = CommonUtil.makeValidIdListArray(missionVO.getLeaderMixes());
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userMixList", userMixList);
    	param.put("alarmUserList", 0);
		List<MemberVO> memberList = memberService.selectMemberListById(param);
		
		//for(int i = 0; i < memberList.size(); i++){
			missionVO.setLeaderNo(memberList.get(0).getUserNo());
			missionVO.setLeaderNm(memberList.get(0).getUserNm());
			missionVO.setLeaderId(memberList.get(0).getUserId());
		//}
		
		
		
		String atchFileId = missionVO.getAttachFileId();
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
			    List<FileVO> result = fileUtil.parseFileInf(files, "MISSION_", 0, atchFileId, "");
			    atchFileId = fileMngService.insertFileInfs(result);
			    missionVO.setAttachFileId(atchFileId);
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(atchFileId);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "MISSION_", cnt, atchFileId, "");
			    fileMngService.updateFileInfs(_result);
			}
	    }

	    
	    
	    //MISSION_HISTORY 작성
	    
	    MissionVO missionVo2 = new MissionVO();
		missionVo2 = missionService.selectMission(missionVO);

	
		MissionHistoryVO missionHistoryVO = new MissionHistoryVO();
		missionHistoryVO.setMissionId(missionVO.getMissionId());
		missionHistoryVO.setHistoryStat("U");
		missionHistoryVO.setWriterNo(user.getNo());
		missionService.insertMissionHistory(missionHistoryVO);
		
		
		/*담당자 변경 - CL 
		예정일 변경 - CD 
		미완료 - IC
		완료처리 - C 
		등록 - W 
		수정 - U
		삭제 - D
		*/
		if(!missionVo2.getLeaderNo().equals(missionVO.getLeaderNo())){
			missionHistoryVO = new MissionHistoryVO();
			missionHistoryVO.setMissionId(missionVO.getMissionId());
			missionHistoryVO.setHistoryStat("CL");
			missionHistoryVO.setWriterNo(user.getNo());
			missionHistoryVO.setHistoryCn(missionVo2.getLeaderNm()+"("+missionVo2.getLeaderId()+")"+" -> "+missionVO.getLeaderNm()+"("+missionVO.getLeaderId()+")");
			missionService.insertMissionHistory(missionHistoryVO);
		}
		
		if(!missionVo2.getDueDt().equals(missionVO.getDueDt())){
			missionHistoryVO = new MissionHistoryVO();
			missionHistoryVO.setMissionId(missionVO.getMissionId());
			missionHistoryVO.setHistoryStat("CD");
			missionHistoryVO.setWriterNo(user.getNo());
			missionHistoryVO.setHistoryCn(missionVo2.getDueDt()+" -> "+missionVO.getDueDt());
			missionService.insertMissionHistory(missionHistoryVO);
		}
		
		
		
	    missionService.updateMission(missionVO);
	    missionService.updateMissionPrj(missionVO);
	    
		//missionService.updateMissionTree(missionVO); //업데이트시 상위 미션 수정이 없기에 미션트리는 수정 안함

		
		//String redirectUrl = "/cooperation/selectMission.do?missionId="+missionVO.getMissionId()+"&type="+missionVO.getType();
		//model.addAttribute("redirectUrl", redirectUrl);

		model.addAttribute("searchVO", missionVO);
	  //redirect 메세지 변수 초기화
		//model.addAttribute("message", "수정하였습니다.");
		//model.addAttribute("message2", "");						
		model.addAttribute("redirectUrl", missionVO.getRedirectUrl());
		return "/error/messageRedirect";
		//return "redirect:/cooperation/selectMissionSearchList.do";
	}
	
	
	@RequestMapping("/cooperation/updateMissionStat.do")
	public String updateMissionStat(
			HttpServletRequest req, @ModelAttribute("searchVO") MissionVO missionVO, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
    	
		System.out.println("missionVO.getLeaderMixes() : " + missionVO.getLeaderMixes());
		if(!"".equals(missionVO.getLeaderMixes())){
			List<String> userMixList = CommonUtil.makeValidIdListArray(missionVO.getLeaderMixes());
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
	    	param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService.selectMemberListById(param);
			
			//for(int i = 0; i < memberList.size(); i++){
				missionVO.setLeaderNo(memberList.get(0).getUserNo());
				missionVO.setLeaderNm(memberList.get(0).getUserNm());
				missionVO.setLeaderId(memberList.get(0).getUserId());
			//}
		}
			
			    
	    //MISSION_HISTORY 작성
	    
	    MissionVO missionVo2 = new MissionVO();
		missionVo2 = missionService.selectMission(missionVO);
		
		missionVO.setMissionLv(missionVo2.getMissionLv());
		
		System.out.println("missionVO.getLeaderNo() : " + missionVO.getLeaderNo());
		if("".equals(missionVO.getLeaderNo()) || missionVO.getLeaderNo() == null){
			missionVO.setLeaderNo(missionVo2.getLeaderNo());
		}
		if("".equals(missionVO.getDueDt()) || missionVO.getDueDt() == null){
			missionVO.setDueDt(missionVo2.getDueDt());
		}
		if("".equals(missionVO.getMissionStat()) || missionVO.getMissionStat() == null){
			missionVO.setMissionStat(missionVo2.getMissionStat());
		}
		
		
		
		
		
		
		
		/*담당자 변경 - CL 
		예정일 변경 - CD 
		미완료 - IC
		완료처리 - C 
		등록 - W 
		수정 - U
		삭제 - D
		*/
		MissionHistoryVO missionHistoryVO = new MissionHistoryVO();
		
		System.out.println("missionVO.getLeaderMixes() : " + missionVO.getLeaderMixes());
		if(!"".equals(missionVO.getLeaderMixes())){
			if(!missionVo2.getLeaderNo().equals(missionVO.getLeaderNo())){
				missionHistoryVO = new MissionHistoryVO();
				missionHistoryVO.setMissionId(missionVO.getMissionId());
				missionHistoryVO.setHistoryStat("CL");
				missionHistoryVO.setWriterNo(user.getNo());
				missionHistoryVO.setHistoryCn(missionVo2.getLeaderNm()+"("+missionVo2.getLeaderId()+")"+" -> "+missionVO.getLeaderNm()+"("+missionVO.getLeaderId()+")");
				missionService.insertMissionHistory(missionHistoryVO);
			}
		}
		System.out.println("missionVo2.getDueDt() : " + missionVo2.getDueDt()); // 바꾸기전 완료 예정일
		System.out.println("missionVO.getDueDt() : " + missionVO.getDueDt()); // 바꾼후 완료 예정일
		if(!missionVo2.getDueDt().equals(missionVO.getDueDt())){
			missionHistoryVO = new MissionHistoryVO();
			missionHistoryVO.setMissionId(missionVO.getMissionId());
			missionHistoryVO.setHistoryStat("CD");
			missionHistoryVO.setWriterNo(user.getNo());
			missionHistoryVO.setHistoryCn(missionVo2.getDueDt()+" -> "+missionVO.getDueDt());
			missionService.insertMissionHistory(missionHistoryVO);
		}
		System.out.println("missionVo2.getMissionStat() : " + missionVo2.getMissionStat());
		System.out.println("missionVO.getMissionStat() : " + missionVO.getMissionStat());
		System.out.println("missionVO.getHistoryCn() : " + missionVO.getHistoryCn());
		if(!missionVo2.getMissionStat().equals(missionVO.getMissionStat()) && !"".equals(missionVO.getHistoryCn())){
			missionHistoryVO = new MissionHistoryVO();
			missionHistoryVO.setMissionId(missionVO.getMissionId());
			missionHistoryVO.setHistoryStat(missionVO.getMissionStat());
			missionHistoryVO.setWriterNo(user.getNo());
			missionHistoryVO.setHistoryCn(missionVO.getHistoryCn());
			missionService.insertMissionHistory(missionHistoryVO);			
		}
		
		
		missionService.updateMission(missionVO);
		
		System.out.println("missionVO.getMissionStat() : " + missionVO.getMissionStat());
		if (!"C".equals(missionVO.getMissionStat())) {
			missionService.updateMissionTop(missionVO);
		}
		//missionService.updateMissionTree(missionVO); //업데이트시 상위 미션 수정이 없기에 미션트리는 수정 안함

		//redirect 메세지 변수 초기화
		//model.addAttribute("message", "수정하였습니다.");
		//model.addAttribute("message2", "");						
		model.addAttribute("searchVO", missionVO);
		
		//String type = missionVO.getType();
		//String redirectUrl = "/cooperation/selectMission.do?missionId="+missionVO.getMissionId()+"&type="+missionVO.getType();
		
		model.addAttribute("redirectUrl", missionVO.getRedirectUrl());
		

		return "/error/messageRedirect";
		//return "redirect:/cooperation/selectMissionSearchList.do";
	}
	

	
	@RequestMapping("/cooperation/deleteMission.do")
	public String deleteBusinessContact(@ModelAttribute("searchVO") MissionVO missionVO,
			HttpServletRequest req,
			 ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		MissionHistoryVO missionHistoryVO = new MissionHistoryVO();
		missionHistoryVO.setMissionId(missionVO.getMissionId());
		missionHistoryVO.setHistoryStat("D");
		missionHistoryVO.setWriterNo(user.getNo());
		missionHistoryVO.setHistoryCn("");
		missionService.insertMissionHistory(missionHistoryVO);
		
		missionService.updateMission(missionVO);
		//model.addAttribute("message", "삭제하였습니다.");
		//model.addAttribute("message2", "");		
		model.addAttribute("redirectUrl", missionVO.getRedirectUrl());
			return "/error/messageRedirect";
		//return "forward:/cooperation/selectBusinessContactList.do";
	//	return "forward:"+missionVO.getRedirectUrl();
	}
	
}


