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
import kms.com.management.service.PlanCostVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.Msn;
import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarReservationVO;
import kms.com.support.service.CarVO;
import kms.com.support.service.CardService;
import kms.com.support.service.Card;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.CardVO;
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
public class CardController {

	@Resource(name = "KmsCardService")
	private CardService cardService;

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
		
		
	@RequestMapping("/support/selectCardList.do")
	public String selectCardList(@ModelAttribute("searchVO") CardVO searchVO,
			ModelMap model) throws Exception{
		
		List<EgovMap> resultList = cardService.selectCardList(searchVO);
		
		model.addAttribute("resultList", resultList);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList= cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		vo.setCodeId("KMS017");
		List cardStatList= cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("cardStatList", cardStatList);
		return "support/sprt_cardL";
	}
	@RequestMapping("/support/selectCardView.do")
	public String selectCardView(@ModelAttribute("searchVO") CardVO searchVO,
			@ModelAttribute("cardVO") CardVO cardVO,
			ModelMap model) throws Exception{
		
		cardVO = cardService.selectCardView(searchVO);
		List cardHistoryVOList = cardService.selectCardHistoryList(searchVO);
		
		model.addAttribute("cardVO", cardVO);
		model.addAttribute("cardHistoryVOList", cardHistoryVOList);
		
		return "support/sprt_cardV";
	}
	@RequestMapping("/support/writeCard.do")
	public String writeCard(@ModelAttribute("searchVO") Card searchVO,
			ModelMap model) throws Exception{
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList= cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		vo.setCodeId("KMS017");
		List cardStatList= cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("cardStatList", cardStatList);
		model.addAttribute("cardVO", new CardVO());
		model.addAttribute("mode", "W");
		return "support/sprt_cardW";
	}
	@RequestMapping("/support/modifyCard.do")
	public String selectCarList(@ModelAttribute("searchVO") CardVO searchVO,
			@ModelAttribute("cardVO") CardVO cardVO,
			ModelMap model) throws Exception{
		
		cardVO = cardService.selectCardView(searchVO);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList= cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		vo.setCodeId("KMS017");
		List cardStatList= cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("cardStatList", cardStatList);
		model.addAttribute("cardVO", cardVO);
		model.addAttribute("mode", "M");
		return "support/sprt_cardW";
	}
	@RequestMapping("/support/insertCard.do")
	public String insertCard(@ModelAttribute("searchVO") CardVO searchVO,
			@ModelAttribute("cardVO") CardVO cardVO,
			ModelMap model) throws Exception{
		
		if (cardService.selectCardCnt(cardVO) > 0) {
			model.addAttribute("message", "중복된 카드번호입니다.");
			return "error/messageError";
		}
		
		cardService.insertCard(cardVO);
		
		return "redirect:/support/selectCardView.do?cardId=" + cardVO.getCardId();
	}
	
	
	@RequestMapping("/support/updateCard.do")
	public String updateCard(@ModelAttribute("searchVO") Card searchVO,
			@ModelAttribute("cardVO") CardVO cardVO,
			ModelMap model) throws Exception{
		
		if (!cardVO.getCardId().equals(cardVO.getBeforeCardId()) && cardService.selectCardCnt(cardVO) > 0) {
			model.addAttribute("message", "중복된 카드번호입니다.");
			return "error/messageError";
		}
		
		cardService.updateCard(cardVO);
		cardService.updateCardHistory(cardVO);
		
		return "redirect:/support/selectCardView.do?cardId=" + cardVO.getCardId();
	}
	
	@RequestMapping("/support/writeCardHistory.do")
	public String WriteCardHistory(@ModelAttribute("searchVO") Card searchVO,
			@ModelAttribute("cardHistoryVO") CardVO cardHistoryVO,
			ModelMap model) throws Exception{		
		
		return "/support/sprt_cardHistoryW";
	}
	
	@RequestMapping("/support/insertCardHistory.do")
	public String insertCardHistory(@ModelAttribute("searchVO") CardVO searchVO,
			@ModelAttribute("cardHistoryVO") CardVO cardHistoryVO,
			ModelMap model) throws Exception{
		if(cardHistoryVO.getUserMix()!=null)
			cardHistoryVO.setUserId(CommonUtil.parseIdFromMixs(cardHistoryVO.getUserMix())[0]);
		cardService.insertCardHistory(cardHistoryVO);
		
		return "redirect:/support/selectCardView.do?cardId=" + cardHistoryVO.getCardId();
	}
	
	@RequestMapping(value={"/ajax/support/selectCardSpendList.do","/ajax/support/selectCardSpendListTbody.do"})
	public String selectAccountListAjax(@ModelAttribute("searchVO") CardSpendVO searchVO, 
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model)
					throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		//전자결재 법인카드 내역 조회 초기값
		if("/ajax/support/selectCardSpendList.do".equals(request.getRequestURI())){
			searchVO.setSearchMonth("0");
			searchVO.setSearchUserNm(user.getUserNm());
		}
		
		model.addAttribute("resultList", cardService.selectCardSpendList(searchVO));
		model.addAttribute("resultSum", cardService.selectCardSpendSum(searchVO));
		model.addAttribute("searchMonth", Integer.parseInt(searchVO.getSearchMonth()));
		if("/ajax/support/selectCardSpendList.do".equals(request.getRequestURI()))
			return "/support/include/cardSpendL";
		else
			return "/support/include/cardSpendTbody";
	}
	
	@RequestMapping(value={"/approval/selectCardSpendList.do"})
	public String selectAccountList(@ModelAttribute("searchVO") CardSpendVO searchVO, 
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model)
					throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		searchVO.setSearchYear("0");
		searchVO.setSearchMonth("0");
		if(searchVO.getSearchUserNm() == null)
			searchVO.setSearchUserNm(user.getUserNm());
		
		// 20150410, 타 부서의 카드를 검색 및 문서 상신이 빈번하여 권한 체크 해제.
		searchVO.setMyOrgId(""); //비워둬야 전체검색  : LIKE CONCAT('%', #myOrgId#, '%')
		model.addAttribute("orgnztId", "");	//조직트리 전체검색
		
		if (!user.isAdmin())
			searchVO.setSearchAdminAuth("N");
		/*
		if(user.isAdmin()){
			searchVO.setMyOrgId(""); //비워둬야 전체검색  : LIKE CONCAT('%', #myOrgId#, '%')
			model.addAttribute("orgnztId", "");	//조직트리 전체검색
		} else {
			searchVO.setMyOrgId(user.getOrgnztId()); //예하부서만 검색제한
			model.addAttribute("orgnztId", user.getOrgnztId()); //조직트리 예하부서검색
		}
		*/
		
		model.addAttribute("resultList", cardService.selectCardSpendList(searchVO));
		model.addAttribute("resultSum", cardService.selectCardSpendSum(searchVO));
		model.addAttribute("searchMonth", Integer.parseInt(searchVO.getSearchMonth()));
		return "approval/appr_cardSpendL";
	}
}
