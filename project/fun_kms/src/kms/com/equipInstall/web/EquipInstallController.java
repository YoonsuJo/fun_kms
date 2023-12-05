package kms.com.equipInstall.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.exception.IdMixInputException;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.equipInstall.service.EquipInstallService;
import kms.com.equipInstall.service.EquipInstallVO;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EquipInstallController {

	@Resource(name = "EquipInstallService")
	private EquipInstallService eiService;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	/**
	 * 솔루션 장비 납품 설치 요청 리스트
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 * @throws IdMixInputException
	 */
	@RequestMapping("/equipInstall/equipInstallL.do")
	public String equipInstallList(@ModelAttribute("eiVO") EquipInstallVO eiVO,
			HttpServletRequest request, ModelMap model)
			throws IdMixInputException {
		MemberVO user = SessionUtil.getMember(request);
		eiVO.setUserId(user.getUserId());
		eiVO.setAdminYn(user.getIsAdmin());

		// 페이징 시작
		eiVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		eiVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(eiVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(eiVO.getPageUnit());
		paginationInfo.setPageSize(eiVO.getPageSize());

		eiVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		eiVO.setLastIndex(paginationInfo.getLastRecordIndex());
		eiVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		// 페이징 끝

		// 검색조건 유저아이디
		// eiVO.setSearchUserId(CommonUtil.parseIdFromMix(eiVO.getSearchUserNm()));
		// 체크박스
		if (eiVO.getSearchGubun() != null && !eiVO.getSearchGubun().equals("")) {
			eiVO.setArrGubun(eiVO.getSearchGubun().replaceAll(" ", "").split(
					"/"));
		}

		List list = eiService.getEquipInstallList(eiVO);
		int count = eiService.getEquipInstallListCount(eiVO);

		paginationInfo.setTotalRecordCount(count);

		model.addAttribute("installList", list);
		model.addAttribute("paginationInfo", paginationInfo);

		return "equipInstall/equipInstallL";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 등록
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipInstallW.do")
	public String equipInstallWrite(
			@ModelAttribute("eiVO") EquipInstallVO eiVO, ModelMap model) {
		List list = eiService.getEquipSolution();

		model.addAttribute("sList", list);
		model.addAttribute("searchVO", eiVO);
		return "equipInstall/equipInstallW";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 등록처리
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipInstallWP.do")
	public String equipInstallWriteProcess(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			MultipartHttpServletRequest multiRequest, ModelMap model)
			throws Exception {
		MemberVO user = SessionUtil.getMember(multiRequest);
		eiVO.setUserId(user.getUserId());

		// 줄바꿈 처리
		eiVO.setContent(eiVO.getContent().replaceAll("\r\n", "<br>"));
		eiVO.setContent(eiVO.getContent().replaceAll("\u0020", "&nbsp;"));

		List<FileVO> result = null;
		String atchFileId = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "EI_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
			eiVO.setAtchFileId(atchFileId);
		}

		int installId = eiService.insertEquipInstall(eiVO);

		//model.addAttribute("message", "요청이 등록 되었습니다");
		model.addAttribute("redirectUrl",
				"/equipInstall/equipInstallV.do?installNo=" + installId);

		return "error/messageRedirect";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 상세보기
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipInstallV.do")
	public String equipInstallView(@ModelAttribute("eiVO") EquipInstallVO eiVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
		MemberVO user = SessionUtil.getMember(request);
		eiVO.setUserId(user.getUserId());

		model.addAttribute("searchVO", eiVO);

		List list = eiService.getDetailList(eiVO);
		eiService.updateReadOk(eiVO);
		EquipInstallVO eiVO2 = eiService.getDetailView(eiVO);

		model.addAttribute("eiVO", eiVO2);
		model.addAttribute("detailList", list);
		model.addAttribute("sessionId", user.getUserId());
		model.addAttribute("isAdmin", user.getIsAdmin());

		return "equipInstall/equipInstallV";
	}

	/**
	 * 솔루션 장비 등록 팝업
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipmentAdd.do")
	public String popEquipmentAdd(@ModelAttribute("eiVO") EquipInstallVO eiVO,
			ModelMap model) {
		// 페이징 시작
		eiVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		eiVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(eiVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(eiVO.getPageUnit());
		paginationInfo.setPageSize(eiVO.getPageSize());

		eiVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		eiVO.setLastIndex(paginationInfo.getLastRecordIndex());
		eiVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		// 페이징 끝

		List list = eiService.getEquipSolutionPaging(eiVO);
		int cnt = eiService.getEquipSolutionCount();

		paginationInfo.setTotalRecordCount(cnt);

		model.addAttribute("sList", list);
		model.addAttribute("paginationInfo", paginationInfo);

		return "equipInstall/pop_equipment_add";
	}

	/**
	 * 솔루션 장비 등록 처리
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipmentAddWP.do")
	public String popEquipmentAddWP(
			@ModelAttribute("eiVO") EquipInstallVO eiVO, ModelMap model,
			HttpServletResponse response) {
		String result = eiService.insertEquipSolution(eiVO);

		List list = eiService.getEquipSolution();

		model.addAttribute("result", result);
		model.addAttribute("sList", list);

		// Ajax 처리 시작
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
		// Ajax처리 끝

		return null;
		//return "equipInstall/equipment_addW";
	}

	/**
	 * 솔루션 장비 등록 처리
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipmentAddDP.do")
	public String popEquipmentAddDP(
			@ModelAttribute("eiVO") EquipInstallVO eiVO, ModelMap model,
			HttpServletResponse response) {
		String result = eiService.deleteEquipSolution(eiVO);

		List list = eiService.getEquipSolution();

		model.addAttribute("result", result);
		model.addAttribute("sList", list);

		// Ajax 처리 시작
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
		// Ajax처리 끝

		return null;
	}

	/**
	 * 솔루션 장비 수정 처리
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipmentAddMP.do")
	public String popEquipmentAddMP(
			@ModelAttribute("eiVO") EquipInstallVO eiVO, ModelMap model,
			HttpServletResponse response) {
		String result = eiService.updateEquipSolution(eiVO);

		List list = eiService.getEquipSolution();

		model.addAttribute("result", result);
		model.addAttribute("sList", list);

		// Ajax 처리 시작
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
		// Ajax처리 끝

		return null;
	}

	/**
	 * 솔루션 장비 납품 설치 요청 수정
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipInstallM.do")
	public String equipInstallModify(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
		MemberVO user = SessionUtil.getMember(request);
		eiVO.setUserId(user.getUserId());

		eiService.updateReadOk(eiVO);
		eiVO = eiService.getDetailView(eiVO);
		List list = eiService.getEquipSolution();

		// 줄바꿈 처리
		eiVO.setContent(eiVO.getContent().replaceAll("<br>", "\r\n"));
		eiVO.setContent(eiVO.getContent().replaceAll("&nbsp;", "\u0020"));

		// List list = eiService.getEquipInstallFileName(eiVO);

		model.addAttribute("sList", list);
		model.addAttribute("eiVO", eiVO);

		return "equipInstall/equipInstallM";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 수정처리
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/equipInstall/equipInstallMP.do")
	public String equipInstallModifyProcess(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			MultipartHttpServletRequest multiRequest, ModelMap model)
			throws Exception {
		MemberVO user = SessionUtil.getMember(multiRequest);
		eiVO.setUserId(user.getUserId());

		// 줄바꿈 처리
		eiVO.setContent(eiVO.getContent().replaceAll("\r\n", "<br>"));
		eiVO.setContent(eiVO.getContent().replaceAll("\u0020", "&nbsp;"));

		int installNo = eiVO.getInstallNo();
		String atchFileId = eiVO.getAtchFileId();

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
				List<FileVO> result = fileUtil.parseFileInf(files, "EI_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				eiVO.setAtchFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "EI_", cnt,
						atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}

		String resultP = eiService.modifyEquipInstall(eiVO);

		if (resultP == "Y" || resultP.equals("Y")) {
			//model.addAttribute("message", "요청이 수정 되었습니다");
			model.addAttribute("redirectUrl",
					"/equipInstall/equipInstallV.do?installNo=" + installNo);
		} else {
			model.addAttribute("message", "요청 수정을 실패 하였습니다.");
			model.addAttribute("redirectUrl",
					"/equipInstall/equipInstallM.do?installNo=" + installNo);
		}

		return "error/messageRedirect";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 접수내역 변동내역보기
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipInstallVD.do")
	public String equipInstallView_Detail(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
		
		MemberVO user = SessionUtil.getMember(request);
		eiVO.setUserId(user.getUserId());

		// 페이징 시작
		eiVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		eiVO.setPageSize(propertyService.getInt("pageSize"));
		eiVO.setPageUnit(5);
		eiVO.setPageSize(5);

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(eiVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(eiVO.getPageUnit());
		paginationInfo.setPageSize(eiVO.getPageSize());

		eiVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		eiVO.setLastIndex(paginationInfo.getLastRecordIndex());
		eiVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		// 페이징 끝
		
		EquipInstallVO eiVO2 = eiService.getDetailView(eiVO);
		List list = eiService.getChgInstallHistory(eiVO);
		int count = eiService.getChgInstallHistoryCount(eiVO);

		paginationInfo.setTotalRecordCount(count);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("eiVO2", eiVO2);
		model.addAttribute("historyList", list);
				
		return "equipInstall/equipInstallV_Detail";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 삭제
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipInstallD.do")
	public String equipInstallDelete(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
		MemberVO user = SessionUtil.getMember(request);
		eiVO.setUserId(user.getUserId());

		String result = eiService.deleteEquipInstall(eiVO);

		if (result.equals("Y")) {
			//model.addAttribute("message", "삭제 처리 되었습니다.");
			model.addAttribute("redirectUrl", "/equipInstall/equipInstallL.do");
		} else {
			model.addAttribute("message", "삭제를 실패 하였습니다.");
			model.addAttribute("redirectUrl",
					"/equipInstall/equipInstallV.do?installNo="
							+ eiVO.getInstallNo());
		}

		return "/error/messageRedirect";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 접수
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 * @throws Exception
	 * @throws Exception
	 */
	@RequestMapping("/equipInstall/equipmentRP.do")
	public String equipInstallViewReceive(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			MultipartHttpServletRequest multiRequest,
			// HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(multiRequest);
		eiVO.setUserId(user.getUserId());

		// 줄바꿈 처리
		eiVO.setContent(eiVO.getContent().replaceAll("\r\n", "<br>"));
		eiVO.setContent(eiVO.getContent().replaceAll("\u0020", "&nbsp;"));
		// 입력된 이름을 Id로 바꿔준다.
		if (eiVO.getMngNm() != null && !eiVO.getMngNm().equals("")) {
			try {
				eiVO.setMngId(CommonUtil.parseIdFromMix(eiVO.getMngNm()));
			} catch (IdMixInputException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			eiVO.setMngId(eiVO.getUserId());
		}

		// MemberVO user = SessionUtil.getMember(request);
		// eiVO.setUserId(user.getUserId());

		// 파일 업로드 시작(Ajax로 파일 업로드 기능을 구현하기 위해선 jquery.form.js 기능을 이용해야함
		List<FileVO> result = null;
		String atchFileId = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "EID_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
			eiVO.setAtchFileId(atchFileId); // 업로드 파일명을 저장
		}
		// 파일 업로드 끝

		// 설치작업 입력
		String resultP = eiService.updateEquipInstallReceive(eiVO);
		// model.addAttribute("result", resultP); //입력 결과값 Y, N

		// 입력후 바뀐 요청 데이터
		// EquipInstallVO eiVO2 = eiService.getDetailView(eiVO);
		// model.addAttribute("returnEiVO2", eiVO2);

		// 설치작업 데이터
		// List list = eiService.getDetailList(eiVO);
		// model.addAttribute("returnDetailList", list);

		/*
		 * //Ajax 처리 시작
		 * response.setContentType("application/json;charset=utf-8"); Gson gson
		 * = new Gson(); PrintWriter writer; try { writer =
		 * response.getWriter(); writer.write(gson.toJson(model));
		 * writer.close(); } catch (IOException e) { e.printStackTrace(); }
		 * //Ajax처리 끝
		 */

		// return null;
		if (resultP == "Y" || resultP.equals("Y")) {
			//model.addAttribute("message", "작업 내용이 입력 되었습니다");
		} else {
			model.addAttribute("message", "작업내용 입력을 실패 하였습니다.");
		}
		model.addAttribute("redirectUrl",
				"/equipInstall/equipInstallV.do?installNo="
						+ eiVO.getInstallNo());

		return "error/messageRedirect";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 접수내역 수정
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipInstallVM.do")
	public String equipInstallView_DetailModify(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
		MemberVO user = SessionUtil.getMember(request);
		eiVO.setUserId(user.getUserId());

		EquipInstallVO data = eiService.getModifyDetailData(eiVO);

		// 줄바꿈 처리
		data.setContent(data.getContent().replaceAll("<br>", "\r\n"));
		data.setContent(data.getContent().replaceAll("&nbsp;", "\u0020"));

		model.addAttribute("element", data);

		return "equipInstall/equipInstallVM";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 접수내역 수정 처리
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/equipInstall/equipInstallVMP.do")
	public String equipInstallView_DMP(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			MultipartHttpServletRequest multiRequest,
			HttpServletResponse response, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(multiRequest);
		eiVO.setUserId(user.getUserId());

		// 줄바꿈 처리
		eiVO.setContent(eiVO.getContent().replaceAll("\r\n", "<br>"));
		eiVO.setContent(eiVO.getContent().replaceAll("\u0020", "&nbsp;"));

		// 입력된 이름을 Id로 바꿔준다.
		if (eiVO.getMngNm() != null && !eiVO.getMngNm().equals("")) {
			try {
				eiVO.setMngId(CommonUtil.parseIdFromMix(eiVO.getMngNm()));
			} catch (IdMixInputException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			eiVO.setMngId(eiVO.getUserId());
		}

		String atchFileId = eiVO.getAtchFileId();

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
				List<FileVO> result = fileUtil.parseFileInf(files, "EID_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				eiVO.setAtchFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "EID_",
						cnt, atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}
		String result = eiService.updateEquipInstallDetailMP(eiVO);

		if (result.equals("Y")) {
			//model.addAttribute("msg", "작업내용이 수정 되었습니다.");
		} else {
			model.addAttribute("msg", "작업내용 수정을 실패 하였습니다.");
		}

		return "/equipInstall/closePage";

	}

	/**
	 * 솔루션 장비 납품 설치 접수내역 삭제
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipmentDetailDP.do")
	public String equipInstallDetailDelete(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
		MemberVO user = SessionUtil.getMember(request);
		eiVO.setUserId(user.getUserId());

		String result = eiService.deleteEquipInstallDetail(eiVO);

		if (result.equals("Y")) {
			//model.addAttribute("message", "삭제 처리 되었습니다.");
			model.addAttribute("redirectUrl",
					"/equipInstall/equipInstallV.do?installNo="
							+ eiVO.getInstallNo());
		} else {
			model.addAttribute("message", "삭제를 실패 하였습니다.");
			model.addAttribute("redirectUrl",
					"/equipInstall/equipInstallV.do?installNo="
							+ eiVO.getInstallNo());
		}

		return "/error/messageRedirect";
	}

	/**
	 * 솔루션 장비 납품 설치 요청 접수내역 변동내역
	 * 
	 * @param eiVO
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping("/equipInstall/equipInstallVD2.do")
	public String equipInstallView_DetailView(
			@ModelAttribute("eiVO") EquipInstallVO eiVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
		MemberVO user = SessionUtil.getMember(request);
		eiVO.setUserId(user.getUserId());

		EquipInstallVO data = eiService.getModifyDetailData(eiVO);

		List list = eiService.getDetailHistory(eiVO);

		model.addAttribute("element", data);
		model.addAttribute("history", list);

		return "equipInstall/equipInstallV_Detail2";
	} 
}