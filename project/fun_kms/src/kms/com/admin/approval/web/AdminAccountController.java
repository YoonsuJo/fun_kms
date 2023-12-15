package kms.com.admin.approval.web;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import kms.com.app.service.AccountVO;
import kms.com.app.service.KmsAccountService;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.List;

/**
 * @Class Name : KmsApprovalTypController.java
 * @Description : KmsApprovalTypController class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class AdminAccountController {

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "accountService")
    protected KmsAccountService accountService;
	
	@Resource(name = "kmsAccountIdGnrService")
	private EgovIdGnrService idGnrService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    /**
     * @param searchVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/admin/approval/selectAccountList.do")
    public String selectAccountList(@ModelAttribute("searchVO") AccountVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
		searchVO.setAccLv(2);
        List resultList = accountService.selectAccountList(searchVO);
        model.addAttribute("resultList", resultList);
        
        
        return "admin/approval/accountL";
    }
    
    @RequestMapping(value="/ajax/selectPrntAccountList.do")
    public String selectPrntAccountList(@ModelAttribute("searchVO") AccountVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
		searchVO.setAccLv(1);
        List resultList = accountService.selectAccountList(searchVO);
        model.addAttribute("resultList", resultList);
        
        
        return "admin/approval/include/prntAccountL";
    }
    
    
    @RequestMapping(value={"/admin/approval/writeAccount.do","/ajax/writePrntAccount.do"})
    public String writeAccount(@ModelAttribute("searchVO") AccountVO searchVO, 
    		@ModelAttribute("accountVO") AccountVO accountVO, 
    		ModelMap model)
    throws Exception {
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	if(searchVO.getAccLv()==2)
    	{
	    	AccountVO searchVO2 = new AccountVO();
	    	searchVO2.setAccLv(1);
	    	List accPrntList = accountService.selectAccountList(searchVO2);
	    	model.addAttribute("prntAccList", accPrntList);
	    	vo.setCodeId("KMS016");
			model.addAttribute("childTypList", cmmUseService.selectCmmCodeDetail(vo));
    	}
    	else
    	{
    		vo.setCodeId("KMS015");
			model.addAttribute("prntTypList", cmmUseService.selectCmmCodeDetail(vo));
    	}

		vo.setCodeId("COM038");
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("useAtList", codeResult);
		model.addAttribute("mode", "W");
		model.addAttribute("title", "계정과목 추가");
    	if(searchVO.getAccLv()==2)
    	{
    		model.addAttribute("title", "계정과목 추가");
    		return "admin/approval/accountW";
    	}
    	else
    	{
    		model.addAttribute("title", "상위계정 추가");
    		return "admin/approval/include/prntAccountW";
    	}
    } 	
    
    @RequestMapping(value={"/admin/approval/insertAccount.do","/ajax/insertPrntAccount.do"})
    public String inserAccount(@ModelAttribute("searchVO") AccountVO searchVO, 
    		@ModelAttribute("accountVO") AccountVO accountVO,
    		HttpServletRequest request, HttpServletResponse response,
    		ModelMap model)
    throws Exception {
    	String accId = idGnrService.getNextStringId();
    	accountVO.setAccId(accId);
    	if(accountVO.getAccLv()==1)
    		accountVO.setPrntAccId(accId);
    	accountService.insertAccount(accountVO);
    	if("/ajax/insertPrntAccount.do".equals(request.getRequestURI()))
    		return "success";
    	else
    		return "redirect:/admin/approval/selectAccountList.do";
    } 
    
    @RequestMapping(value={"/admin/approval/modifyAccount.do","/ajax/modifyPrntAccount.do"})
    public String modifyAccount(@ModelAttribute("searchVO") AccountVO searchVO, 
    		@ModelAttribute("accountVO") AccountVO accountVO,
    		ModelMap model)
    throws Exception {
    	model.addAttribute("accountVO",accountService.selectAccountView(accountVO));
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	if(searchVO.getAccLv()==2)
    	{
	    	AccountVO searchVO2 = new AccountVO();
	    	searchVO2.setAccLv(1);
	    	List accPrntList = accountService.selectAccountList(searchVO2);
	    	model.addAttribute("prntAccList", accPrntList);
	    	vo.setCodeId("KMS016");
			model.addAttribute("childTypList", cmmUseService.selectCmmCodeDetail(vo));
    	}
    	else
    	{
    		
    		//하위 계정이 1개라도 존재시 사용하지 않음을 선택할 수 없도록..
    		if(accountService.selectChildAccountCnt(searchVO)>0)
    			model.addAttribute("invalidUseAt",1);
    		vo.setCodeId("KMS015");
			model.addAttribute("prntTypList", cmmUseService.selectCmmCodeDetail(vo));
    	}
		vo.setCodeId("COM038");
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("useAtList", codeResult);
		model.addAttribute("mode", "M");
    	if(searchVO.getAccLv()==2)
    	{
    		model.addAttribute("title", "계정과목 수정");
    		return "admin/approval/accountW";
    	}
    	else
    	{
    		model.addAttribute("title", "상위계정 수정");
    		return "admin/approval/include/prntAccountW";
    	}
    	
    } 
    
    @RequestMapping(value={"/admin/approval/updateAccount.do","/ajax/updatePrntAccount.do"})
    public String updateAccount(@ModelAttribute("searchVO") AccountVO searchVO, 
    		@ModelAttribute("accountVO") AccountVO accountVO,
    		HttpServletRequest request, HttpServletResponse response,
    		ModelMap model)
    throws Exception {
    	//부모 acc의 typ 가 변할 경우 하위 acc의 typ 도 같이 바꾸어줌.
		//if 자식이 프리셋에 저장되어 있고, 그 자식의 typ가 변경되는 경우는  변경되지 않도록.
		if(accountVO.getAccLv()==1)
		{
			AccountVO bfAccountVO = accountService.selectAccountView(accountVO);
			
			if(!bfAccountVO.getPrntTyp().equals(accountVO.getPrntTyp()))
			{
				if(accountService.selectPresetChildAccCnt(accountVO)>0)
				{
					model.addAttribute("message", "하위 계정 과목이 프리셋에 등록되어 있어 계정분류를 변경할 수 없습니다.");
					return "fail";
				}
				accountService.updateBatchChildAccTyp(accountVO);
			}
		}
		//자식 계정 타입이 변경될 시, 해당 계정이 프리셋에 등록되 있을 시 변경되지 않도록.
		else{
			AccountVO bfAccountVO = accountService.selectAccountView(accountVO);
			if(!bfAccountVO.getChildTyp().equals(accountVO.getChildTyp()))
			{
				if(accountService.selectPresetAccCnt(accountVO)>0)
				{
					model.addAttribute("message", "하위 계정 과목이 프리셋에 등록되어 있어 계정분류를 변경할 수 없습니다.");
					return "error/messageError";
				}
			}
			
		}
    	accountService.updateAccount(accountVO);
    	if("/ajax/insertPrntAccount.do".equals(request.getRequestURI()))
    		return "success";
    	else
    		return "redirect:/admin/approval/selectAccountList.do";
    } 
    
    
    @RequestMapping("/ajax/updateAccountOrder.do")
    public void updateAccountOrder(
            @ModelAttribute("searchVO") AccountVO searchVO,
            String orderResult,
            HttpServletResponse response,
             Model model)
            throws Exception {
        
        
        String orderResultDecode = URLDecoder.decode(orderResult, "UTF-8");
        JSONObject orderResultJ=  (JSONObject)JSONValue.parseWithException(orderResultDecode);
        accountService.updateAccountOrder(orderResultJ);
      
    }
    
    
    
}
