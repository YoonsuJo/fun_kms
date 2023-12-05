package kms.com.product.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.NoteService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.product.service.ProductService;
import kms.com.product.dao.ProductDAO;
import kms.com.product.vo.ProductVO;
import kms.com.product.vo.RelationVO;
import kms.com.product.vo.PartVO;
import kms.com.product.vo.VersionVO;
import kms.com.support.service.BPManualVO;
import kms.com.product.fm.PartFm;

@Controller
public class ProductController {
	Logger logT = Logger.getLogger("TENY");
	
	@Resource(name = "KmsProductService")
	protected ProductService productService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	@Resource(name = "KmsProductDAO")
	private ProductDAO productDAO;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 제품 관련 기능
	// TENY_170529 제품을 작성한다.
	@RequestMapping("/product/writeProductPop.do")
	public String ProductW(@ModelAttribute("fm") ProductVO fm,
			HttpServletRequest req,
			ModelMap model) throws Exception {
		logT.debug("START");
//		model.addAttribute("fm", fm);
		return "/product/ProductWMPop";
	}

	// TENY_170529 제품을 수정한다.
	@RequestMapping("/product/modifyProductPop.do")
	public String ProductM(@ModelAttribute("fm") ProductVO fm,
			HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		
		ProductVO pVO = productDAO.selectProduct(fm.getNo());
		
		model.addAttribute("pVO", pVO);		
		
		return "product/ProductWMPop";
	}
	
	// TENY_170529 제품목록을 등록한다.
	@RequestMapping("/product/saveProduct.do")
	public String saveProduct(@ModelAttribute("fm") ProductVO fm,
			HttpServletRequest req,
			ModelMap model) throws Exception {
		logT.debug("START");

		// 새로 작성된 글은 작성자를 접속사용자로 한다.
		MemberVO user = SessionUtil.getMember(req);
		if(fm.getNo() == 0){ // 새로 등록되는 글
			logT.debug("insert");
			fm.setWriterNo(user.getNo());
			productDAO.insertProduct(fm);
		} 
		else {
			logT.debug("update");
			productDAO.updateProduct(fm);
		}
		logT.debug("END");
		return "/common/returnPage/windowReloadNClose";
	}
	
	// TENY_17029 제품의 정보 및 제품에 속한 구성품 목록을 조회한다.
	@RequestMapping("/product/viewProduct.do")
	public String ProductV(@ModelAttribute("fm") ProductVO fm,
			Map<String, Object> commandMap,
			HttpServletRequest req,
			ModelMap model) throws Exception {
		logT.debug("START");

		MemberVO user = SessionUtil.getMember(req);

		ProductVO pVO = productDAO.selectProduct(fm.getNo());

		// 구성품 목록을 조회한다.
		List<PartVO> ppVOList =  productDAO.selectPartListOfProduct(fm.getNo());
		
		model.addAttribute("pVO", pVO);	
		model.addAttribute("ppVOList", ppVOList);	

		logT.debug("END");
		return "product/ProductV";
	}

	// TENY_170529 제품목록을 조회한다.
	@RequestMapping("/product/listProduct.do")
	public String ProductL(@ModelAttribute("fm") ProductVO fm,
			Map<String,Object> commandMap,
			HttpServletRequest req,
			ModelMap model) throws Exception {
		logT.debug("START");
		
		List<ProductVO> pVOList =  productDAO.selectProductList(fm);

		model.addAttribute("fm", fm);
		model.addAttribute("pVOList", pVOList);
		
		logT.debug("END");
		return "product/ProductL";
	}
	//순서 UP DN
	@RequestMapping("/product/updateProductSortNo.do")
	public String updateProductSortNo(@ModelAttribute("fm") ProductVO pVO,
			HttpServletRequest req,  ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		if("UP".equals(pVO.getSortNoType())){
			productDAO.updateProductSortNoUp(pVO);
		}else{
			productDAO.updateProductSortNoDn(pVO);
			
		}
		
		model.addAttribute("pVO", pVO);
		
		//return "/product/productRedirect";		
		return "forward:/product/listProduct.do";
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 구성품 관련 기능
	// TENY_17029 구성품 정보를 작성한다.
	// TENY_17029 제품의 정보 및 제품에 속한 구성품 목록을 조회한다.
	@RequestMapping("/product/listPart.do")
	public String listPart(@ModelAttribute("fm") PartFm fm,
			Map<String, Object> commandMap,
			HttpServletRequest req,
			ModelMap model) throws Exception {
		logT.debug("START");

		if("Y".equals(fm.getSearchIsFirst())) {
			fm.setSearchTypeP("Y");
			fm.setSearchTypeM("Y");
			fm.setSearchUseAt("Y");
			MemberVO user = SessionUtil.getMember(req);
			if(!"dosateny".equals(user.getUserId())) {
				fm.setSearchAdminMixes(user.getUserNm() + "(" + user.getUserId() + ")");
			}
		}
		
		if("Y".equals(fm.getSearchTypeP())) {
			if(!"Y".equals(fm.getSearchTypeM())) {
				fm.setSearchType("P");
			}
		} else if ("Y".equals(fm.getSearchTypeM())) {
			fm.setSearchType("M");
		}

		if("Y".equals(fm.getSearchIncludeDel())) {
			fm.setSearchUseAt("");
		} else {
			fm.setSearchUseAt("Y");
		}

		// 구성품 목록을 조회한다.
		List<PartVO> ppVOList =  productDAO.selectPartList(fm);
		
		model.addAttribute("ppVOList", ppVOList);	

		logT.debug("END");
		return "product/PartL";
	}

	@RequestMapping("/product/writePartPop.do")
	public String writePartPop(@ModelAttribute("fm") PartVO fm, 
			HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");
		
//		ProductVO pVO = productDAO.selectProduct(fm.getProductNo());
		
		model.addAttribute("ppVO", fm);	
		
		return "product/PartWMPop";
	}

	@RequestMapping("/product/modifyPartPop.do")
	public String modifyPartPop(@ModelAttribute("fm") PartVO fm, 
			HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");

		PartVO ppVO = productDAO.selectPart(fm.getNo());
		
		model.addAttribute("ppVO", ppVO);	
		
		return "product/PartWMPop";
	}

	// TENY_170529 구성품 정보를 저장한다.
	@RequestMapping("/product/savePart.do")
	public String savePart(@ModelAttribute("fm") PartVO fm, 
			HttpServletRequest req, ModelMap model) throws Exception {
		
		// 새로 작성된 글은 작성자를 접속사용자로 한다.
		MemberVO user = SessionUtil.getMember(req);
		if(fm.getNo() == 0){ // 새로 등록되는 글
			logT.debug("insert");
			fm.setWriterNo(user.getNo());
			productDAO.insertPart(fm);
		} 
		else {
			logT.debug("update");
			productDAO.updatePart(fm);
		}
		logT.debug("END");
		return "/common/returnPage/windowReloadNClose";
	}

	// TENY_170629 
	// 구성품의 버전과 상관없는 기본정보 및 구성품의 버전 목록과 구성품이 사용하는 하부 구성품 목록을 조회한다.
	@RequestMapping("/product/viewPart.do")
	public String viewPart(@ModelAttribute("fm") PartFm fm,
			Map<String, Object> commandMap, 
			HttpServletRequest req, 
			ModelMap model) throws Exception {
		logT.debug("START");

		PartVO partVO = productDAO.selectPart(fm.getSearchNo());

		// 버전 목록을 조회한다.
		List<VersionVO> pvVOList =  productDAO.selectVersionList(fm.getSearchNo());
		
		// 관련 모듈 목록을 조회한다.
		List<PartVO> subPartVOList =  productDAO.selectSubPartList(fm);
		
		model.addAttribute("partVO", partVO);
		model.addAttribute("pvVOList", pvVOList);
		model.addAttribute("subPartVOList", subPartVOList);

		return "product/PartV";
	}

	// TENY_170705 
	// 구성품 특정 버전의 정보 및 구성품의 버전을 조회한다.
	@RequestMapping("/product/viewPartVersion.do")
	public String viewPartVersion(@ModelAttribute("fm") PartFm fm,
			Map<String, Object> commandMap, 
			HttpServletRequest req, 
			ModelMap model) throws Exception {
		logT.debug("START");

		// 구성품 정보를 조회한다.
		PartVO partVO = productDAO.selectPart(fm.getSearchNo());
		// 버전 정보를 조회한다.
		VersionVO verVO = productDAO.selectVersion(fm.getSearchVersionNo());
		
		// 관련 모듈 해당 버젼 목록을 조회한다.
		List<PartVO> subPartVOList =  productDAO.selectSubPartList(fm);
		
		model.addAttribute("partVO", partVO);
		model.addAttribute("verVO", verVO);
		model.addAttribute("subPartVOList", subPartVOList);

		return "product/PartVersionV";
	}

	
	// TENY_170529 구성품 정보를 저장한다.
	@RequestMapping("/product/updatePartStatus.do")
	public String updatePartStatus(@ModelAttribute("fm") PartVO fm,
			HttpServletRequest req,  ModelMap model) throws Exception {
		logT.debug("START");

		MemberVO user = SessionUtil.getMember(req);
		fm.setWriterNo(user.getUserNo());
		productDAO.updatePart(fm);
		
		// redirect 메세지 변수 초기화
		model.addAttribute("user", user);
		model.addAttribute("fm", fm);
		
		//메뉴 정보
		ProductVO productVO = new ProductVO();
		List<ProductVO> productList =  productDAO.selectProductList(productVO);
		model.addAttribute("productList", productList);
		
		return "/product/productRedirect";
	}

	// 순서 아래로
	@RequestMapping("/product/movePartDownAjax.do")
	public String movePartDownAjax(@ModelAttribute("fm") PartVO fm,
			Map<String, Object> commandMap,
			HttpServletResponse res) throws Exception {
	
		logT.debug("START");
		
		PartVO partVO = new PartVO();
		partVO.setNo(Integer.parseInt((String)commandMap.get("partNo")));
		partVO.setSortNo(Integer.parseInt((String)commandMap.get("nextSortNo")));
		
		productDAO.updatePartSortNo(partVO);
		
		partVO.setNo(Integer.parseInt((String)commandMap.get("nextPartNo")));
		partVO.setSortNo(Integer.parseInt((String)commandMap.get("sortNo")));
		
		productDAO.updatePartSortNo(partVO);

		JSONObject result = new JSONObject();
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		result.put("RETURN", "OK");
		out.write(result.toString().getBytes("UTF-8"));

		out.flush();
		out.close();
		return "";
	}
	
	// 순서 아래로
	@RequestMapping("/product/deletePartAjax.do")
	public String deletePartAjax(@ModelAttribute("fm") PartVO fm,
			Map<String, Object> commandMap,
			HttpServletResponse res) throws Exception {
	
		logT.debug("START");

		productDAO.deletePart(fm);
		
		JSONObject result = new JSONObject();
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		result.put("RETURN", "OK");
		out.write(result.toString().getBytes("UTF-8"));

		out.flush();
		out.close();
		return "";
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 모듈관의 관계 관리 관련 기능
	// TENY_170704 하나의 구성품이 사용하는 하부 구성품을 선택하기 위하여 구성품 목록창을 띄울때 사용한다.
	// 자신과 이미 가지고 있는 구성품을 제외하고 나머지 구성품을 목록을 도시한다.
	@RequestMapping("/product/selectSubPartPop.do")
	public String selectSubPartPop(@ModelAttribute("fm") PartFm fm, 
			HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");

		if("Y".equals(fm.getSearchIsFirst())){
			
		}
		List<PartVO> ppVOList = productDAO.selectPartListForChoice(fm);
		
		model.addAttribute("ppVOList", ppVOList);
		
		return "product/SubPartListPop";
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// TENY_170704 
	// 특정 모듈의 버전을 리스트한다.
	// 하나의 구성품 버전이 사용한 하부 구성품의 버전을 선택하기 위하여 사용한다.
	@RequestMapping("/product/listPartVersionPop.do")
	public String listPartVersionPop(@ModelAttribute("fm") PartFm fm, 
			HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");

		// 구성품 정보를 조회한다.
		PartVO partVO = productDAO.selectPart(fm.getSearchNo());
		model.addAttribute("partVO", partVO);

		// 관련 모듈 해당 버젼 목록을 조회한다.
		List<VersionVO> verVOList =  productDAO.selectVersionList(fm.getSearchNo());
		model.addAttribute("verVOList", verVOList);

		return "product/VersionListPop";
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 버전관리 관련 기능
	// TENY_170529 모듈의 버전 정보를 작성한다.
	@RequestMapping("/product/writeVersionPop.do")
	public String insertVersionView(@ModelAttribute("fm") VersionVO fm, 
			HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");
		
		model.addAttribute("pvVO", fm);
		return "product/VersionWMPop";
	}
	
	// TENY_170529 버전 정보를 수정한다.
	@RequestMapping("/product/modifyVersionPop.do")
	public String VersionM(@ModelAttribute("fm") VersionVO fm,
			HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {
		logT.debug("START");

		MemberVO user = SessionUtil.getMember(req);
		
		VersionVO pvVO = productDAO.selectVersion(fm.getNo());
		
		model.addAttribute("pvVO", pvVO);
		
		return "product/VersionWMPop";
	}

	// TENY_170529 버전 정보를 등록한다.
	@RequestMapping("/product/saveVersion.do")
	public String insertVersion(@ModelAttribute("fm") VersionVO fm, 
			HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");
		
		MemberVO user = SessionUtil.getMember(req);
		fm.setWriterNo(user.getUserNo());
		if(!"Y".equals(fm.getInterfaceChange())){
			fm.setInterfaceChange("N");
		}
		if(fm.getNo() == 0) { // 새로 등록되는 글
			logT.debug("insert");
			fm.setWriterNo(user.getNo());
			productDAO.insertVersion(fm);
		} 
		else {
			logT.debug("update");
			productDAO.updateVersion(fm);
		}
		logT.debug("END");
		return "/common/returnPage/windowReloadNClose";
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 관계 관리 관련 기능
	// TENY_170704 관계 정보를 추가한다.
	// 본 함수는 선택된 구성품 목록을 상위 구성품과 연결관계를 저장하는 기능을 한다.
	@RequestMapping("/product/saveSubPartList.do")
	public String saveSubPartList(@ModelAttribute("fm") PartFm fm, 
			HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");

		String[] relationNoIist;
		relationNoIist = fm.getPartNoList().split(",");
		RelationVO vo = new RelationVO();
		vo.setOwnerNo(fm.getSearchNo());
		vo.setType("M");
		for(String noStr : relationNoIist)
		{
			vo.setSubNo( Integer.parseInt(noStr));
			productDAO.insertRelation( vo);
		}
		
		return "/common/returnPage/windowReloadNClose";
	}

	// 본 함수는 연결관계를 삭제하는 기능을 한다.
	// Ajax 방식으로 한다.
	@RequestMapping("/product/deleteRelationAjax.do")
	public String deleteRelationAjax(	@ModelAttribute("fm") RelationVO fm,
			HttpServletResponse res,
			ModelMap model) throws Exception {
		logT.debug("START");

		JSONObject result = new JSONObject();
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		productDAO.deleteRelation(fm);
		
		result.put("RETURN", "OK");
		out.write(result.toString().getBytes("UTF-8"));

/*
				result.put("RETURN", "NG");
				out.write(result.toString().getBytes("UTF-8"));
*/
		out.flush();
		out.close();
		return "";
	}

	// 본 함수는 선택된 구성품 목록을 상위 구성품과 연결관계를 저장하는 기능을 한다.
	@RequestMapping("/product/saveVersionRelation.do")
	public String saveVersionRelation(@ModelAttribute("fm") PartFm fm, 
			HttpServletRequest req, ModelMap model) throws Exception {
		logT.debug("START");

		RelationVO vo = new RelationVO();
		vo.setOwnerNo(fm.getSearchVersionNo());
		vo.setSubNo(fm.getVerNo());
		vo.setSortNo(1);
		vo.setType("V");
		productDAO.insertRelation( vo);
		
		return "/common/returnPage/windowReloadNClose";
	}

}
