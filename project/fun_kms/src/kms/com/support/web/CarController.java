package kms.com.support.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.config.PathConfig;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.Msn;
import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarReservationVO;
import kms.com.support.service.CarVO;
import kms.com.support.service.ResourceService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class CarController {

	@Resource(name = "KmsResourceService")
	private ResourceService resourceService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;

    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
    
	
	
	@RequestMapping("/support/selectCarList.do")
	public String selectCarList(ModelMap model) throws Exception{
		
		List<CarVO> resultList = resourceService.selectCarList(null);
		
		model.addAttribute("resultList", resultList);
		
		return "support/sprt_carL";
	}
	
	@RequestMapping("/support/selectCarInfo.do")
	public String selectCarInfo(CarVO carVO, ModelMap model) throws Exception{
		
		CarVO result = resourceService.selectCarInfo(carVO);
		
		model.addAttribute("result", result);
		
		return "support/sprt_carV";
	}
	
	@RequestMapping("/support/insertCarInfoView.do")
	public String insertCarInfoView(ModelMap model) throws Exception{
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List compList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("compList", compList);
		
		return "support/sprt_carW";
	}
	
	@RequestMapping("/support/insertCarInfo.do")
	public String insertCarInfo(final MultipartHttpServletRequest multiRequest, CarVO carVO, ModelMap model) throws Exception{
		
		if (CommonUtil.isMixedId(carVO.getUserNm())) {
			carVO.setUserId(CommonUtil.parseIdFromMixs(carVO.getUserNm())[0]);
		} else {
			carVO.setUserNo(0);
		}
		
		List<FileVO> result = null;
		String imgFileId = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "CAR_", 0, "", "");
			imgFileId = fileMngService.insertFileInfs(result);
		}
		
		carVO.setImgFileId(imgFileId);
		
		resourceService.insertCarInfo(carVO);
		
		return "redirect:/support/selectCarList.do";
	}
	
	@RequestMapping("/support/updateCarInfoView.do")
	public String updateCarInfoView(CarVO carVO, ModelMap model) throws Exception{

		CarVO result = resourceService.selectCarInfo(carVO);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List compList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("result", result);
		model.addAttribute("compList", compList);
		
		return "support/sprt_carM";
	}
	
	@RequestMapping("/support/updateCarInfo.do")
	public String updateCarInfo(final MultipartHttpServletRequest multiRequest, CarVO carVO, ModelMap model) throws Exception{
		
		if (CommonUtil.isMixedId(carVO.getUserNm())) {
			carVO.setUserId(CommonUtil.parseIdFromMixs(carVO.getUserNm())[0]);
		} else {
			carVO.setUserNo(0);
		}
		
		String imgFileId = carVO.getImgFileId();
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			if ("".equals(imgFileId)) {
			    List<FileVO> result = fileUtil.parseFileInf(files, "CAR_", 0, imgFileId, "");
			    imgFileId = fileMngService.insertFileInfs(result);
			    carVO.setImgFileId(imgFileId);
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(imgFileId);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "CAR_", cnt, imgFileId, "");
			    fileMngService.updateFileInfs(_result);
			}
	    }

		resourceService.updateCarInfo(carVO);
		
		return "forward:/support/selectCarInfo.do";
	}
	
	@RequestMapping("/support/deleteCarInfo.do")
	public String deleteCarInfo(CarVO carVO, ModelMap model) throws Exception{

		resourceService.deleteCarInfo(carVO);
		
		return "redirect:/support/selectCarList.do";
	}
	

	
	
	
	@RequestMapping("/support/selectCarFixList.do")
	public String selectCarFixList(CarFixVO carFixVO, ModelMap model) throws Exception{
		
		List<CarFixVO> resultList = resourceService.selectCarFixList(carFixVO);
		
		model.addAttribute("resultList", resultList);
		
		return "support/sprt_carFixL";
	}
	
	@RequestMapping("/support/insertCarFixInfoView.do")
	public String insertCarFixInfoView(Map<String,Object> commandMap, ModelMap model) throws Exception{

		List<CarVO> carList = resourceService.selectCarList(null);
		
		model.addAttribute("carList", carList);
		model.addAttribute("carId", commandMap.get("carId"));
		
		return "support/sprt_carFixW";
	}
	
	@RequestMapping("/support/insertCarFixInfo.do")
	public String insertCarFixInfo(CarFixVO carFixVO, ModelMap model) throws Exception{
		
		if (CommonUtil.isMixedId(carFixVO.getUserNm())) {
			carFixVO.setUserId(CommonUtil.parseIdFromMixs(carFixVO.getUserNm())[0]);
		}
		
		resourceService.insertCarFixInfo(carFixVO);
		
		return "forward:/support/selectCarInfo.do";
	}
	
	@RequestMapping("/support/updateCarFixInfoView.do")
	public String updateCarFixInfoView(CarFixVO carFixVO, ModelMap model) throws Exception{

		List<CarVO> carList = resourceService.selectCarList(null);
		CarFixVO result = resourceService.selectCarFixInfo(carFixVO);

		model.addAttribute("result", result);
		model.addAttribute("carList", carList);
		
		return "support/sprt_carFixM";
	}
	
	@RequestMapping("/support/updateCarFixInfo.do")
	public String updateCarFixInfo(CarFixVO carFixVO, ModelMap model) throws Exception{
		
		if (CommonUtil.isMixedId(carFixVO.getUserNm())) {
			carFixVO.setUserId(CommonUtil.parseIdFromMixs(carFixVO.getUserNm())[0]);
		}
		
		resourceService.updateCarFixInfo(carFixVO);

		return "forward:/support/selectCarInfo.do";
	}
	
	@RequestMapping("/support/deleteCarFixInfo.do")
	public String deleteCarFixInfo(CarFixVO carFixVO, ModelMap model) throws Exception{

		resourceService.deleteCarFixInfo(carFixVO);

		return "forward:/support/selectCarInfo.do";
	}
	
	
	@RequestMapping("/support/selectCarRsvCalendar.do")
	public String selectCarRsvCalendar(@ModelAttribute("searchVO") CarReservation carRsv, Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userTyp", "C");
		List<CarVO> carList = resourceService.selectCarList(param);

		String moveMonth = (String)commandMap.get("moveMonth");
		if (moveMonth != null && moveMonth.equals("") == false) {
			carRsv.setSearchDate(CalendarUtil.getDate(carRsv.getSearchDate(), "MONTH", Integer.parseInt(moveMonth)));
		}
		List<CarReservationVO> resultList = resourceService.selectCarReservationCalendar(carRsv);
		
		model.addAttribute("carList", carList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("today", CalendarUtil.getToday());
		
		return "support/sprt_carRsvL";
	}
	
	@RequestMapping("/support/selectCarRsvInfoList.do")
	public String selectCarRsvInfoList(@ModelAttribute("searchVO") CarReservation carRsv, Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		String moveDate = (String)commandMap.get("moveDate");
		
		if (moveDate != null && moveDate.equals("") == false) {
			carRsv.setSearchDate(CalendarUtil.getDate(carRsv.getSearchDate(), Integer.parseInt(moveDate)));
		}
		
		List<CarReservation> result = resourceService.selectCarReservationInfoList(carRsv);
		
		model.addAttribute("resultList", result);
		
		return "support/sprt_carRsvV";
	}
	
	@RequestMapping("/support/insertCarRsvView.do")
	public String insertCarRsvView(CarReservation carRsv, ModelMap model) throws Exception {

		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userTyp", "C");
		
		List<CarVO> carList = resourceService.selectCarList(param);

		model.addAttribute("carList", carList);
		
		return "support/sprt_carRsvW";
	}
	
	@RequestMapping("/support/insertCarRsv.do")
	public String insertCarRsv(CarReservation carRsv, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		carRsv.setWriterNo(user.getNo());

		if (CommonUtil.isMixedId(carRsv.getUserNm())) {
			carRsv.setUserId(CommonUtil.parseIdFromMixs(carRsv.getUserNm())[0]);
		}
		
		resourceService.insertCarReservation(carRsv);
		
		return "redirect:/support/selectCarRsvCalendar.do";
	}
	
	@RequestMapping("/support/updateCarRsvView.do")
	public String updateCarRsvView(HttpServletRequest req, CarReservation carRsv, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userTyp", "C");
		
		List<CarVO> carList = resourceService.selectCarList(param);
		CarReservation result = resourceService.selectCarReservationInfo(carRsv);
		if(user.getUserNo().equals(result.getWriterNo()) || user.getUserNo().equals(result.getUserNo()) || user.isAdmin()){
			;
		}
		else
		{
			return "error/authError";
		}
		model.addAttribute("carList", carList);
		model.addAttribute("result", result);
		
		return "support/sprt_carRsvM";
	}
	
	@RequestMapping("/support/updateCarRsv.do")
	public String updateCarRsv(CarReservation carRsv, HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		carRsv.setWriterNo(user.getNo());

		if (CommonUtil.isMixedId(carRsv.getUserNm())) {
			carRsv.setUserId(CommonUtil.parseIdFromMixs(carRsv.getUserNm())[0]);
		}
		
		resourceService.updateCarReservation(carRsv);

		return "redirect:/support/selectCarRsvCalendar.do";
	}
	
	@RequestMapping("/support/deleteCarRsv.do")
	public String deleteCarRsv(HttpServletRequest req, CarReservation carRsv, ModelMap model) throws Exception {
		
		/*
		MemberVO user = SessionUtil.getMember(req);
		
		CarReservation result = resourceService.selectCarReservationInfo(carRsv);
		if(user.getUserNo() != result.getWriterNo() && user.getUserNo() != result.getUserNo() && !user.isAdmin()){
			return "error/authError";
		}
		*/
		
		resourceService.deleteCarReservation(carRsv);
		
		return "redirect:/support/selectCarRsvCalendar.do";
	}
	

	@RequestMapping("/ajax/selectCarRsvInfoListCnt.do")
	public void selectCarRsvInfoListCnt(HttpServletRequest req, HttpServletResponse res, CarReservation carRsv, ModelMap model) throws Exception {
		
		int cnt = resourceService.selectCarReservationInfoListTotCnt(carRsv);

		res.setContentType("text/xml;charset=UTF-8");
		String out = "";
		out += "<cnt>" + cnt + "</cnt>";
		
		res.getWriter().println( CommonUtil.getXMLStr(out) );
	}
	@RequestMapping("/ajax/selectCarRsvInfo.do")
	public String selectCarRsvInfo(HttpServletRequest req, HttpServletResponse res, CarReservation carRsv, ModelMap model) throws Exception {
		
		CarReservation result = resourceService.selectCarReservationInfo(carRsv);
		
		model.addAttribute("result", result);
		
		return "support/sprt_carRsvD";
	}
	@RequestMapping("/ajax/getCarInfo.do")
	public void getCarInfo(HttpServletRequest req, HttpServletResponse res, CarVO carVO, ModelMap model) throws Exception {
		
		CarVO info = resourceService.selectCarInfo(carVO);
		
		res.setContentType("text/xml;charset=UTF-8");
		String out = "";
		out += "<age>" + info.getInsAge() + "</age>";
		out += "<carLicTyp>" + info.getInsLicTyp() + "</carLicTyp>";
		out += "<carLicTypPrint>" + info.getInsLicTypPrint() + "</carLicTypPrint>";
		
		res.getWriter().println( CommonUtil.getXMLStr(out) );
	}
	@RequestMapping("/ajax/getMemberInfo.do")
	public void getMemberInfo(HttpServletRequest req, HttpServletResponse res, MemberVO memberVO, ModelMap model) throws Exception {
		
		memberVO.setUserId(CommonUtil.parseIdFromMixs(memberVO.getUserNm())[0]);
		
		EgovMap info = memberService.selectMemberById(memberVO);
		
		memberVO.setCarLicTyp((String)info.get("carLicTyp"));
		
		res.setContentType("text/xml;charset=UTF-8");
		String out = "";
		out += "<age>" + info.get("age") + "</age>";
		out += "<carLicTyp>" + info.get("carLicTyp") + "</carLicTyp>";
		out += "<carLicTypPrint>" + memberVO.getCarLicTypPrint() + "</carLicTypPrint>";
		
		res.getWriter().println( CommonUtil.getXMLStr(out) );
	}
}
