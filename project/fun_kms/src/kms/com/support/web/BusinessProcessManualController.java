package kms.com.support.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.io.File;

import javapns.Push;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.push.AndroidProvider;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.Note;
import kms.com.community.service.NoteService;
import kms.com.equipInstall.service.EquipInstallVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.MobileDeviceVO;
import kms.com.support.service.BPManualService;
import kms.com.support.service.BPManualVO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BusinessProcessManualController {
	@Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;
	
	@Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;
	
	@Resource(name = "KmsBPManualService")
    private BPManualService bpmService;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
	@Resource(name = "KmsNoteService")
    private NoteService noteService;
	
	@Resource(name = "KmsMemberService")
    private MemberService memberService;
	
	@Resource(name = "egovFileIdGnrService")
    private EgovIdGnrService idgenService;
	
	/**
	 * 업무절차 리스트
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualList.do")
	public String selectManualList
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		MemberVO user = SessionUtil.getMember(request);
		bpmVO.setUserId(user.getUserId());
		
		//검색
		if(user.isBpmboard() == true){
			bpmVO.setAdminYn("Y");
		}
		//검색끝
		
		//페이징 시작
		bpmVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		bpmVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(bpmVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bpmVO.getPageUnit());
		paginationInfo.setPageSize(bpmVO.getPageSize());
	
		bpmVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bpmVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bpmVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		//페이징 끝
		
		paginationInfo.setTotalRecordCount(bpmService.getCountManualList(bpmVO));
		
		model.addAttribute("gubunList", bpmService.selectBPManualGubunList());
		model.addAttribute("list", bpmService.selectManualList(bpmVO));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "community/sprt_BPManualL";
	}
	
	@RequestMapping("/support/bpManualWrite.do")
	public String selectManualWrite(@ModelAttribute("bpmVO") BPManualVO bpmVO, ModelMap model) throws Exception{
		model.addAttribute("gubunList", bpmService.selectBPManualGubunList());
		
		return "community/sprt_BPManualW";
	}
	
	/**
	 * 업무절차 입력 프로세스
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualWriteP.do")
	public String selectManualWriteProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			MultipartHttpServletRequest multiRequest,
			ModelMap model
	) throws Exception{
		MemberVO user = SessionUtil.getMember(multiRequest);
		bpmVO.setUserId(user.getUserId());
		
		//줄바꿈 처리
		//bpmVO.setContent(bpmVO.getContent().replaceAll("\r\n", "<br>"));
		//bpmVO.setContent(bpmVO.getContent().replaceAll("\u0020", "&nbsp;"));
		
		//파일업로드 시작
	    String atchFileId = "";
	    String atchFileId2 = "";
	    String checkValue1 = "N";
	    String checkValue2 = "N";
	    int checkCount = 0;
	    
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    if (!files.isEmpty()) {
	    	int fileKey = 0;
	    	String KeyStr = "BPM_";
	    	String storePathString = "";
	    	String atchFileIdString1 = "";
	    	String atchFileIdString2 = "";

    	    storePathString = propertyService.getString("Globals.fileStorePath");

    	    atchFileIdString1 = idgenService.getNextStringId();
    	    atchFileIdString2 = idgenService.getNextStringId();

	    	File saveFolder = new File(storePathString);	    	
	    	if (!saveFolder.exists() || saveFolder.isFile()) {
	    	    saveFolder.mkdirs();
	    	}
	    	
	    	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    	MultipartFile file;
	    	String filePath = "";
	    	List<FileVO> result1  = new ArrayList<FileVO>();
	    	List<FileVO> result2  = new ArrayList<FileVO>();
	    	FileVO fvo;
	    	
	    	while (itr.hasNext()) {
	    	    Entry<String, MultipartFile> entry = itr.next();

	    	    file = entry.getValue();
	    	    String orginFileName = file.getOriginalFilename();
System.out.println("000000000000000000000000000000000000 : "+file.getName());	    	    
	    	    //--------------------------------------
	    	    // 원 파일명이 없는 경우 처리
	    	    // (첨부가 되지 않은 input file type)
	    	    //--------------------------------------
	    	    if ("".equals(orginFileName)) {
	    		continue;
	    	    }
	    	    ////------------------------------------

	    	    int index = orginFileName.lastIndexOf(".");
	    	    //String fileName = orginFileName.substring(0, index);
	    	    String fileExt = orginFileName.substring(index + 1);
	    	    String newName = KeyStr + EgovStringUtil.getTimeStamp() + fileKey;
	    	    long _size = file.getSize();

	    	    if (!"".equals(orginFileName)) {
	    		filePath = storePathString + File.separator + newName;
	    		file.transferTo(new File(filePath));
	    	    }
	    	    fvo = new FileVO();
	    	    fvo.setFileExtsn(fileExt);
	    	    fvo.setFileStreCours(storePathString);
	    	    fvo.setFileMg(Long.toString(_size));
	    	    fvo.setOrignlFileNm(orginFileName);
	    	    fvo.setStreFileNm(newName);
	    	    
	    	    if(bpmVO.getCntFile1()+bpmVO.getCntFile2() > 0){
		    	    if(bpmVO.getCntFile2() > 0 && checkCount < bpmVO.getCntFile2()){
		    	    	if(checkCount < bpmVO.getCntFile2()){
		    	    		System.out.println("111111111111111111111111111111111111 : "+bpmVO.getCntFile1()+", 2 : "+bpmVO.getCntFile2());
		    	    		fvo.setAtchFileId(atchFileIdString2);
			    	    	result1.add(fvo);
		    	    	}
		    	    }else{
		    	    	if(bpmVO.getCntFile1() != 0){
		    	    		System.out.println("22222222222222222222222222222222222222 : "+bpmVO.getCntFile1()+", 2 : "+bpmVO.getCntFile2());
		    	    		fvo.setAtchFileId(atchFileIdString1);
			    	    	result2.add(fvo);
		    	    	}
		    	    }
	    	    }
	    	    
	    	    fvo.setFileSn(String.valueOf(fileKey));
	    	    fvo.setKey(entry.getKey());
	    	    	    	    
	    	    fileKey++;
	    	    checkCount++;
	    	}    	
	    	//result = fileUtil.parseFileInf(files, "BPM_", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(result1);
	    	atchFileId2 = fileMngService.insertFileInfs(result2);
	    	bpmVO.setAtchFileId(atchFileId);
	    	bpmVO.setAtchFileId2(atchFileId2);
	    }
	    //파일업로드 끝
	    
	    int count = 0;
	    count = bpmService.insertManual(bpmVO);
	    
	    if(count > 0){
	    	model.addAttribute("message", "업무절차가 등록 되었습니다.");
			model.addAttribute("redirectUrl", "/support/bpManualView.do?bpmNo="+bpmVO.getBpmNo());
	    }else{
	    	model.addAttribute("message", "업무절차 등록을 실패 하였습니다.");
			model.addAttribute("redirectUrl", "/support/bpManualWrite.do");
	    }
			
		return "error/messageRedirect";
	}
	
	/**
	 * 업무절차 수정
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualModify.do")
	public String selectManualModify
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			ModelMap model
	) throws Exception{
		BPManualVO bpmDetail = bpmService.getDetailView(bpmVO);
		model.addAttribute("result", bpmDetail);
		model.addAttribute("gubunList", bpmService.selectBPManualGubunList());
		
		return "community/sprt_BPManualM";
	}
	
	/**
	 * 업무절차 수정프로세스
	 * @param bpmVO
	 * @param multiRequest
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualModifyP.do")
	public String selectManualModifyProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			MultipartHttpServletRequest multiRequest,
			ModelMap model
	) throws Exception{	
		MemberVO user = SessionUtil.getMember(multiRequest);
		bpmVO.setUserId(user.getUserId());
		
		String atchFileId1 = bpmVO.getTempAtchFile1();
		String atchFileId2 = bpmVO.getTempAtchFile2();
	    int checkCount = 0;
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    
	    if (!files.isEmpty()) {
	    	int fileKey = 0;
	    	int cnt1 = 0;
	    	int cnt2 = 0;
    	    
	    	String KeyStr = "BPM_";	//파일구분
	    	String storePathString = propertyService.getString("Globals.fileStorePath");	//저장경로
	    	File saveFolder = new File(storePathString);	    	
	    	if (!saveFolder.exists() || saveFolder.isFile()) {
	    	    saveFolder.mkdirs();
	    	}
	    	//fileId가 없을경우 새로 생성함
			if ("".equals(atchFileId1) || atchFileId1 == null) {
				atchFileId1 = idgenService.getNextStringId();
			}else{
				FileVO fvo1 = new FileVO();
				fvo1.setAtchFileId(atchFileId1);
				cnt1 = fileMngService.getMaxFileSN(fvo1);
			}
			if ("".equals(atchFileId2) || atchFileId2 == null) {
				atchFileId2 = idgenService.getNextStringId();
			}else{
				FileVO fvo2 = new FileVO();
				fvo2.setAtchFileId(atchFileId2);
				cnt2 = fileMngService.getMaxFileSN(fvo2);
			}
		    	
	    	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    	MultipartFile file;
	    	String filePath = "";
	    	List<FileVO> result1  = new ArrayList<FileVO>();
	    	List<FileVO> result2  = new ArrayList<FileVO>();
	    	FileVO fvo;
	    	
	    	while (itr.hasNext()) {
	    	    Entry<String, MultipartFile> entry = itr.next();

	    	    file = entry.getValue();
	    	    String orginFileName = file.getOriginalFilename();
	    	    
	    	    //--------------------------------------
	    	    // 원 파일명이 없는 경우 처리
	    	    // (첨부가 되지 않은 input file type)
	    	    //--------------------------------------
	    	    if ("".equals(orginFileName)) {
	    		continue;
	    	    }
	    	    ////------------------------------------

	    	    int index = orginFileName.lastIndexOf(".");
	    	    //String fileName = orginFileName.substring(0, index);
	    	    String fileExt = orginFileName.substring(index + 1);
	    	    
	    	    //업무절차인지 양식인지 구분
	    	    String newName = "";
	    	    if(bpmVO.getCntFile1()+bpmVO.getCntFile2() > 0){
	    	    	if(bpmVO.getCntFile2() > 0 && checkCount < bpmVO.getCntFile2()){
		    	    	if(checkCount < bpmVO.getCntFile2()){
		    	    		newName = KeyStr + EgovStringUtil.getTimeStamp() + cnt1;
		    	    	}
		    	    }else{
		    	    	if(bpmVO.getCntFile1() != 0){
			    	    	newName = KeyStr + EgovStringUtil.getTimeStamp() + cnt2;
		    	    	}
		    	    }
	    	    }
	    	    
	    	    long _size = file.getSize();

	    	    if (!"".equals(orginFileName)) {
		    		filePath = storePathString + File.separator + newName;
		    		file.transferTo(new File(filePath));
	    	    }
	    	    fvo = new FileVO();
	    	    fvo.setFileExtsn(fileExt);
	    	    fvo.setFileStreCours(storePathString);
	    	    fvo.setFileMg(Long.toString(_size));
	    	    fvo.setOrignlFileNm(orginFileName);
	    	    fvo.setStreFileNm(newName);
	    	    
	    	    if(bpmVO.getCntFile1()+bpmVO.getCntFile2() > 0){
	    	    	if(bpmVO.getCntFile2() > 0 && checkCount < bpmVO.getCntFile2()){
		    	    	if(checkCount < bpmVO.getCntFile2()){
		    	    		fvo.setFileSn(String.valueOf(cnt1));
		    	    		cnt1++;
		    	    	}
		    	    }else{
		    	    	if(bpmVO.getCntFile1() != 0){
			    	    	fvo.setFileSn(String.valueOf(cnt2));
			    	    	cnt2++;
		    	    	}
		    	    }
	    	    }
	    	    fvo.setKey(entry.getKey());
	    	    
	    	    //업무절차 인지 양식인지 구분
	    	    if(bpmVO.getCntFile1()+bpmVO.getCntFile2() > 0){
	    	    	if(bpmVO.getCntFile2() > 0 && checkCount < bpmVO.getCntFile2()){
		    	    	if(checkCount < bpmVO.getCntFile2()){
		    	    		fvo.setAtchFileId(atchFileId1);
		    	    		result1.add(fvo);
		    	    	}
		    	    }else{
		    	    	if(bpmVO.getCntFile1() != 0){
			    	    	fvo.setAtchFileId(atchFileId2);
			    	    	result2.add(fvo);
		    	    	}
		    	    }
	    	    }
	    	    
	    	    fileKey++;
	    	    checkCount++;
	    	}
	    	
	    	//파일이 없었을경우 새로 파일을 넣어준다
			if ("".equals(bpmVO.getTempAtchFile1()) || bpmVO.getTempAtchFile1() == null) {
				atchFileId1 = fileMngService.insertFileInfs(result1);
				bpmVO.setAtchFileId(atchFileId1);
			}else{	//파일이 있었을 경우 업데이트를 해준다.
				bpmVO.setAtchFileId(atchFileId2);
			    fileMngService.updateFileInfs(result1);
			}
			//파일이 없었을경우 새로 파일을 넣어준다
			if ("".equals(bpmVO.getTempAtchFile2()) || bpmVO.getTempAtchFile2() == null) {
				atchFileId2 = fileMngService.insertFileInfs(result2);
				bpmVO.setAtchFileId2(atchFileId2);
			}else{	//파일이 있었을 경우 업데이트를 해준다.
				bpmVO.setAtchFileId2(atchFileId1);
			    fileMngService.updateFileInfs(result2);
			}
	    }
	    
	    bpmService.updateManual(bpmVO);
		return "redirect:/support/bpManualView.do?bpmNo="+bpmVO.getBpmNo();
	}
	
	/**
	 * 업무절차 삭제
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualDelete.do")
	public String selectManualDelete
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		MemberVO user = SessionUtil.getMember(request);
		bpmVO.setUserId(user.getUserId());
		
		bpmService.deleteManual(bpmVO);
		
		return "redirect:/support/bpManualList.do";
	}
	
	
	/**
	 * 상세내용 보기
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualView.do")
	public String selectManualView
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		MemberVO user = SessionUtil.getMember(request);
		bpmVO.setUserId(user.getUserId());
		
		bpmVO.setThisUrl(request.getRequestURL().toString());
		
		BPManualVO bpmDetail = bpmService.getDetailView(bpmVO);
		List commentList = bpmService.getDetailViewComment(bpmVO);
		List suggestList = bpmService.getDetailViewSuggest(bpmVO);
		
		model.addAttribute("detail", bpmDetail);
		model.addAttribute("commentList", commentList);
		model.addAttribute("suggestList", suggestList);
		System.out.println("==================================url :"+request.getRequestURL());
		return "community/sprt_BPManualV";
	}
	
	
	/**
	 * 코멘트 입력
	 * @param bpmVO
	 * @param multiRequest
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualCWP.do")
	public String ManualCommentWriteProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		MemberVO user = SessionUtil.getMember(request);
		bpmVO.setUserId(user.getUserId());
		
		//줄바꿈 처리
		bpmVO.setComment(bpmVO.getComment().replaceAll("\r\n", "<br>"));
		bpmVO.setComment(bpmVO.getComment().replaceAll("\u0020", "&nbsp;"));
		
	    bpmService.insertComment(bpmVO);
	    
	    
	    //쪽지 발송
	    List<String> userMixList = CommonUtil.makeValidIdListArray(bpmVO.getReceiverUsers());
		
	    Map<String,Object> param = new HashMap<String,Object>();
		param.put("userMixList", userMixList);
    	//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
    	param.put("alarmUserList", 0);
		List<MemberVO> recieverList = memberService.selectMemberListById(param);
		
	    String msg = "";
		
		for (int i=0; i<recieverList.size(); i++) {
			MemberVO reciever = recieverList.get(i);
			msg = "[업무절차 게시판]\r\n 제목 : "+bpmVO.getSubject()+"\r\n 건의 및 의견 작성자 : "+user.getUserNm()+"\r\n 건의 및 의견 내용 : "
			+bpmVO.getComment()+"\r\n\r\n 업무절차 게시글 URL\r\n"+bpmVO.getThisUrl();
			
			//쪽지 발송하기
			Note note = new Note();
	    	note.setSenderNo(user.getNo());
	    	note.setRecieverId(reciever.getUserId());
	    	note.setNoteCn(msg);
	    	noteService.sendNoteMobile(note);
	    	
	    	//모바일 정보 가져오기
//	    	MobileDeviceVO device = memberService.getDeviceInfo(reciever.getNo().toString());
//	    	
//	    	if(!device.getTokenInfo().equals("") && device.getTokenInfo() != null){
//	    	
//	    		JSONObject json = new JSONObject();
//	    		json.put("replyUrl", "http://hm.hanmam.kr/mobile/pushMsgSendView.do?sabun="+user.getNo());
//	    		json.put("sender", user.getUserNm());
//	    		json.put("sendTime", System.currentTimeMillis());
//	    		json.put("message", msg);
//	    		json.toJSONString();
//	    		
//	    		json.put("fromUserId", user.getUserId());
//	    		json.put("toUserId", reciever.getUserId());
//	    		json.put("noteNo", "");
//	    		json.put("messageNo", "");
//	    		
//	    		Map<String, Object> param2 = new HashMap<String, Object>();
//	       	  	param2.put("fromUserId", json.get("fromUserId"));
//	       	  	param2.put("toUserId", json.get("toUserId"));
//	       	  	param2.put("noteNo", json.get("noteNo"));
//	       	  	param2.put("message", json.get("message"));
//	       	  	param2.put("pushKey", json.get("fromUserId").toString() + json.get("sendTime").toString() + json.get("toUserId").toString());
//	    		
//		    	Push메세지 발송하기
//		    	if(device.getDeviceType().equals("iPhone")){
//		   	  		Push.alert(msg, request.getSession().getServletContext().getRealPath("/")+"mkms_apns.p12", "saeha1111", true, device.getTokenInfo());
//		   	  		param2.put("success", "Y");
//		    	}else if(device.getDeviceType().equals("Android")){
//		   	   	  	AndroidProvider provider = new AndroidProvider();
//		   	   		provider.sendMessage(device.getTokenInfo(), json.toJSONString());
//		    	}
//		    	
//		    	noteService.insertPushLog(param2);
//	    	}	
		}
		//쪽지 발송 끝
	    
		return "redirect:/support/bpManualView.do?bpmNo="+bpmVO.getBpmNo();
	}
	
	
	/**
	 * 코멘트 삭제 프로세스
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualCDP.do")
	public String ManualCommentDeleteProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
	    bpmService.deleteComment(bpmVO);
	    
		return "redirect:/support/bpManualView.do?bpmNo="+bpmVO.getBpmNo();
	}
	
	
	/**
	 * 코멘트 수정 내용 가져오기
	 * @param bpmVO
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualCM.do")
	public String ManualCommentModify
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletResponse response,
			ModelMap model
	) throws Exception{
		BPManualVO comment = bpmService.getModifyComment(bpmVO);
		
		//줄바꿈 처리
		comment.setComment(comment.getComment().replaceAll("<br>", "\r\n"));
		comment.setComment(comment.getComment().replaceAll("&nbsp;", "\u0020"));
		
		model.addAttribute("result",comment);
		//Ajax 처리 시작
	    response.setContentType("application/json;charset=utf-8");
	    Gson gson = new Gson();
	    PrintWriter writer;
	    try {
	    	writer = response.getWriter();
	    	writer.write(gson.toJson(model));
	    	writer.close();
	    } catch (IOException e) {
	    	e.printStackTrace();
	    }
	    //Ajax처리 끝
		return null;
	}
	
	
	/**
	 * 코멘트 수정 프로세스
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualCMP.do")
	public String ManualCommentModifyProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		MemberVO user = SessionUtil.getMember(request);
		bpmVO.setUserId(user.getUserId());
		
		//줄바꿈 처리
		bpmVO.setComment(bpmVO.getComment().replaceAll("\r\n", "<br>"));
		bpmVO.setComment(bpmVO.getComment().replaceAll("\u0020", "&nbsp;"));
		
	    bpmService.modifyComment(bpmVO);
	    
		return "redirect:/support/bpManualView.do?bpmNo="+bpmVO.getBpmNo();
	}
	
	/**
	 * 건의 작성 팝업
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualSW.do")
	public String ManualSuggestWrite
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		return "community/sprt_BPMSuggestW";
	}
	/**
	 * 건의 작성 프로세스
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualSWP.do")
	public String ManualSuggestWriteProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		MemberVO user = SessionUtil.getMember(request);
		bpmVO.setUserId(user.getUserId());
		
		//줄바꿈 처리
		bpmVO.setContent(bpmVO.getContent().replaceAll("\r\n", "<br>"));
		bpmVO.setContent(bpmVO.getContent().replaceAll("\u0020", "&nbsp;"));
		
	    bpmService.insertSuggestAsk(bpmVO);
	    
		return "community/sprt_closePage2";
	}
	/**
	 * 건의 수정
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualSM.do")
	public String ManualSuggestModify
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		BPManualVO modifyData = bpmService.getModifySuggest(bpmVO);
		
		//줄바꿈 처리
		modifyData.setContent(modifyData.getContent().replaceAll("<br>", "\r\n"));
		modifyData.setContent(modifyData.getContent().replaceAll("&nbsp;", "\u0020"));
		
		model.addAttribute("element", modifyData);
		
		return "community/sprt_BPMSuggestM";
	}
	/**
	 * 건의수정 프로세스
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualSMP.do")
	public String ManualSuggestModifyProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		MemberVO user = SessionUtil.getMember(request);
		bpmVO.setUserId(user.getUserId());
		
		//줄바꿈 처리
		bpmVO.setContent(bpmVO.getContent().replaceAll("\r\n", "<br>"));
		bpmVO.setContent(bpmVO.getContent().replaceAll("\u0020", "&nbsp;"));
		
	    bpmService.updateSuggest(bpmVO);
	    
		return "community/sprt_closePage2";
	}
	/**
	 * 건의처리완료 
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualComplete.do")
	public String ManualSuggestComplete
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
	    bpmService.SuggestComplete(bpmVO);
	    
		return "redirect:/support/bpManualView.do?bpmNo="+bpmVO.getBpmNo();
	}
	/**
	 * 건의 삭제
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualSuggestDelete.do")
	public String bpManualSuggestDelete
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
	    bpmService.SuggestDelete(bpmVO);
	    
		return "redirect:/support/bpManualView.do?bpmNo="+bpmVO.getBpmNo();
	}
	
	
	/**
	 * 업무절차 종류 리스트 and 입력폼
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualGubunList.do")
	public String selectManualGubunList
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		MemberVO user = SessionUtil.getMember(request);
		bpmVO.setUserId(user.getUserId());
				
		//페이징 시작
		bpmVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		bpmVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(bpmVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bpmVO.getPageUnit());
		paginationInfo.setPageSize(bpmVO.getPageSize());
	
		bpmVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bpmVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bpmVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		//페이징 끝
		
		paginationInfo.setTotalRecordCount(bpmService.countBPManualGubunList(bpmVO));
		
		model.addAttribute("gubunList", bpmService.selectBPManualGubunList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "community/sprt_BPManualGubunL";
	}
	
	@RequestMapping("/support/bpManualGubunWrite.do")
	public String selectManualGubunListWriteProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			ModelMap model,
			HttpServletResponse response
	)
	{
		String result = bpmService.insertBPManualGubun(bpmVO);
		
		model.addAttribute("result", result);
		model.addAttribute("gubunList", bpmService.selectBPManualGubunList());
		
		//Ajax 처리 시작
	    response.setContentType("application/json;charset=utf-8");
	    Gson gson = new Gson();
	    PrintWriter writer;
	    try {
	    	writer = response.getWriter();
	    	writer.write(gson.toJson(model));
	    	writer.close();
	    } catch (IOException e) {
	    	e.printStackTrace();
	    }
	    //Ajax처리 끝
		
		
		return "";
	}
	
	@RequestMapping("/support/bpManualGubunDelete.do")
	public String selectManualGubunListDeleteProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			ModelMap model,
			HttpServletResponse response
	)
	{
		String result = bpmService.deleteBPManualGubun(bpmVO);
		
		model.addAttribute("result", result);
		model.addAttribute("gubunList", bpmService.selectBPManualGubunList());
		
		//Ajax 처리 시작
	    response.setContentType("application/json;charset=utf-8");
	    Gson gson = new Gson();
	    PrintWriter writer;
	    try {
	    	writer = response.getWriter();
	    	writer.write(gson.toJson(model));
	    	writer.close();
	    } catch (IOException e) {
	    	e.printStackTrace();
	    }
	    //Ajax처리 끝
		
		
		return null;
	}
	
	@RequestMapping("/support/bpManualGubunModify.do")
	public String selectManualGubunListModifyProcess
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			ModelMap model,
			HttpServletResponse response
	)
	{
		String result = bpmService.updateBPManualGubun(bpmVO);
		
		model.addAttribute("result", result);
		model.addAttribute("gubunList", bpmService.selectBPManualGubunList());
		
		//Ajax 처리 시작
	    response.setContentType("application/json;charset=utf-8");
	    Gson gson = new Gson();
	    PrintWriter writer;
	    try {
	    	writer = response.getWriter();
	    	writer.write(gson.toJson(model));
	    	writer.close();
	    } catch (IOException e) {
	    	e.printStackTrace();
	    }
	    //Ajax처리 끝
		
		return null;
	}
	
	
	/**
	 * 글 보이기 또는 숨김처리
	 * @param bpmVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/support/bpManualShowOrHidden.do")
	public String ManualShowOrHidden
	(
			@ModelAttribute("bpmVO") BPManualVO bpmVO,
			HttpServletRequest request,
			ModelMap model
	) throws Exception{
		bpmService.ManualShowOrHidden(bpmVO);
		
		return "redirect:/support/bpManualView.do?bpmNo="+bpmVO.getBpmNo();
	}
}