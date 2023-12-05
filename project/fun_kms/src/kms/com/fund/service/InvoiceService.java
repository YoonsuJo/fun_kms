package kms.com.fund.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Service;

import kms.com.common.utils.CommonUtil;
import kms.com.fund.service.InvoiceService;
import kms.com.fund.vo.InvcStatVO;
import kms.com.fund.vo.ProjectCollectVO;
import kms.com.fund.vo.InvoiceCollectVO;
import kms.com.fund.vo.InvoiceContentsVO;
import kms.com.fund.vo.InvoiceProjectVO;
import kms.com.fund.vo.InvoiceVO;
import kms.com.fund.dao.InvoiceDAO;
import kms.com.fund.fm.CollectFm;

/**
 * @author 서장열 
 * @date : 2017-02-28
 */
@Service("KmsInvoiceService")
public class InvoiceService {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name="KmsInvoiceDAO")
	private InvoiceDAO invoiceDAO;


////////////////    SELECT    ////////////////////
	/* TENY_170206  계산서 목록을 조회하는 service 메소드 */
	public List<InvoiceVO> selectInvoiceList( InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectInvoiceList(invoiceVO);
	}

	/* TENY_170206  계산서 목록의 페이지처리를 위하여 총갯수를 조회하는 service 메소드 */
	public int selectInvoiceListCount(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectInvoiceListCount(invoiceVO);
	}

	/* TENY_170206  한개의 계산서를 조회하는 service 메소드 */
	public InvoiceVO selectInvoiceView(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (InvoiceVO) invoiceDAO.selectInvoiceView(param);
	}

	/* TENY_170206  한개의 계산서에 딸려있는 적요 목록을 조회하는 service 메소드 */
	public List<InvoiceContentsVO> selectInvoiceContentsList(Map<String, Object> param) throws Exception{
		logT.debug("START");
		return invoiceDAO.selectInvoiceContentsList(param);
	}

	/* TENY_170206  한개의 계산서에 딸려있는 프로젝트 목록을 조회하는 service 메소드 */
	public List<InvoiceProjectVO> selectInvoiceProjectList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectInvoiceProjectList(param);
	}

	/* TENY_170206  한개의 계산서에 딸려있는 수금 목록을 조회하는 service 메소드 */
	public List<InvoiceCollectVO> selectInvoiceCollectList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectInvoiceCollectList(param);
	}

	/* TENY_170511 해당 프로젝트의 계산서 발행, 수금, 잔금 현황을 일자별로 보는 기능 */
	public List<ProjectCollectVO> selectProjectCollectList(String prjId) throws Exception {
		logT.debug("START");
		List<ProjectCollectVO> pcVOList =  invoiceDAO.selectProjectCollectList(prjId);
		long remain = 0;
		if(pcVOList.size() > 0) {
			for(ProjectCollectVO vo : pcVOList) {
				if(vo.getType().equals("I")) {
					vo.setRemain(remain + vo.getProjectSum() );
				} else {
					vo.setRemain(remain - vo.getCollectSum() );
				}
				remain = vo.getRemain();
			}
			// 리스트를 뒤집어서 보내준다
			List<ProjectCollectVO> pcVOListR = new ArrayList <ProjectCollectVO>();
			int idx = pcVOList.size() - 1;
			while(idx >= 0) {
				pcVOListR.add(pcVOList.get(idx));
				idx--;
			}
			return pcVOListR;
		}
		return pcVOList;
	}

	/* TENY_170209 세금계산서 작성시 기작성된 세금계산서 정보에서 회사정보를 가져와 정보를 채우기 위해 정보목록을 조회하는 메소드 */
	public List<InvoiceVO> selectInvoiceCustInfoList(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectInvoiceCustInfoList(invoiceVO);
	}

	public List<InvcStatVO> selectInvcStatByOrg(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectInvcStatByOrg(param);
	}

	public List<InvcStatVO> selectInvcStatByPrj(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectInvcStatByPrj(param);
	}

	/* TENY_170206  채권관리에서 채권관리할 프로젝트 목록의 총갯수를 조회하는 service 메소드 */
	public int selectInvcStatByPrjCount(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectInvcStatByPrjCount(param);
	}

	public List<InvcStatVO> selectBondOrgnztList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectBondOrgnztList(param);
	}
	
	public List<InvcStatVO> selectCheckOrgSalesList(Map<String, Object> param)throws Exception {
		logT.debug("START");
		return invoiceDAO.selectCheckOrgSalesList(param);
	}
	
	public List<InvcStatVO> selectProjectSalesCheckList(Map<String, Object> param) throws Exception{
		logT.debug("START");
		return invoiceDAO.selectProjectSalesCheckList(param);
	}
	
	public int selectCheckProjectSalesCount(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectCheckProjectSalesCount(param);
	}
	
	public List<InvcStatVO> selectInvcCheckSalesOrgList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectInvcCheckSalesOrgList(param);
	}


	public List<InvcStatVO> selectCheckTotSalesList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectCheckTotSalesList(param);
	}

	public List<InvcStatVO> selectCheckGenSalesList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return invoiceDAO.selectCheckGenSalesList(param);
	}
	

////////////////    INSERT    ////////////////////
	/* TENY_170213 세금계산서 작성시 DB에 저장하는 메소드 */
	public void insertInvoice(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");

		if (!invoiceVO.getRepeat().equals("Y")) { // 한건의 계산서만을 발행해야하는 경우
			insertAInvoice(invoiceVO);
		}
		else { // 계산서 발행이 여러건인 경우   
				// 시작 연월일중 연월까지만을 인식한다. 즉 20170328일 시작일인경우 20170301부터 발행 시작으로 인식한다
				// 여러건 발행인 경우 매월 발행일은 1일 부터 28일 사이의 값이 입력된다. 즉 매월 29, 30, 31은 발행일로 정하지 않는다.
				// 시작일은 종료일보다 작지 않다.
			
			String tmpDate = invoiceVO.getPublishReqDate();
			String tmpTitle =  invoiceVO.getTitle();
			while ( tmpDate.compareTo(invoiceVO.getPublishToDate()) <= 0) {
				int year = Integer.parseInt(tmpDate.substring(0, 4));
				int month = Integer.parseInt(tmpDate.substring(4, 6));
				String tmpPublishReqDate = String.format("%4d%02d%02d", year, month, invoiceVO.getPublishAtDate()) ; // 발행하려고 하는 날

				invoiceVO.setPublishReqDate(tmpPublishReqDate);
				invoiceVO.setTitle(String.format("%s [%d년 %d월 발행]", tmpTitle, year, month));
				insertAInvoice(invoiceVO);
				
				month++;
				if (month == 13) {
					month = 1;
					year = year + 1;
				}
				tmpDate = String.format("%4d%02d%02d", year, month, invoiceVO.getPublishAtDate()) ;
			} 	/* for (String tmpDate = from; tmpDate... */
		} /* if if (taxPublishVO.getRepeat() != null.. */
	}

	/* TENY_170215 세금계산서 작성시 한장의 세금 계산서를 DB에 저장하는 메소드 */
	public void insertAInvoice(InvoiceVO invoiceVO) throws Exception {

		logT.debug("START");

		// hm_invoice 테이블에 추가한다
		invoiceDAO.insertInvoice(invoiceVO);
		
		// hm_invoice_contents 테이블에 추가한다
/*
 * 		List<InvoiceContentsVO> contentsList = invoiceVO.getInvoiceContentsVOList();
		for(InvoiceContentsVO invoiceContentsVO : contentsList)
		{
			invoiceContentsVO.setInvoiceId(invoiceVO.getInvoiceId());
			invoiceDAO.insertInvoiceContents(invoiceContentsVO);
		}
 */
		String contentsArray = CommonUtil.unescape(invoiceVO.getJsonContentsString());
		JSONArray contentsArrayJ = (JSONArray)JSONValue.parseWithException(contentsArray);
		Iterator cIt = contentsArrayJ.iterator();
		while(cIt.hasNext())
		{
			JSONObject ob = (JSONObject)cIt.next();
			ob.put("invoiceId", invoiceVO.getInvoiceId());
			invoiceDAO.insertInvoiceContents(ob);
		}
		
		// hm_invoice_project 테이블에 추가한다
/*
 * 		List<InvoiceProjectVO> projectList = invoiceVO.getInvoiceProjectVOList();
		for(InvoiceProjectVO invoiceProjectVO : projectList)
		{
			invoiceProjectVO.setInvoiceId(invoiceVO.getInvoiceId());
			invoiceDAO.insertInvoiceProject(invoiceProjectVO);
		}
 */
		String projectArray = CommonUtil.unescape(invoiceVO.getJsonProjectString());
		JSONArray projectArrayJ = (JSONArray)JSONValue.parseWithException(projectArray);
		Iterator pIt = projectArrayJ.iterator();
		while(pIt.hasNext())
		{
			JSONObject ob = (JSONObject)pIt.next();
			ob.put("invoiceId", invoiceVO.getInvoiceId());
			invoiceDAO.insertInvoiceProject(ob);
		}
	}


////////////////    UPDATE    ////////////////////
	/* TENY_170213 세금계산서 정보수정시 사용하는 메소드 */
	public void updateInvoice(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");

		// 일단 기존에 있던 계산서 정보를 수정한다. 
		invoiceDAO.updateInvoiceVO(invoiceVO);

		// 일단 기존에 있던 계산서 세부항목을 지운다 
		invoiceDAO.deleteInvoiceContents(invoiceVO);

		// hm_invoice_contents 테이블에 추가한다
		String contentsArray = CommonUtil.unescape(invoiceVO.getJsonContentsString());
		JSONArray contentsArrayJ = (JSONArray)JSONValue.parseWithException(contentsArray);
		Iterator cIt = contentsArrayJ.iterator();
		while(cIt.hasNext())
		{
			JSONObject ob = (JSONObject)cIt.next();
			ob.put("invoiceId", invoiceVO.getInvoiceId());
			invoiceDAO.insertInvoiceContents(ob);
		}
		
		// 일단 기존에 있던 계산서 프로젝트별 매출정보를 지운다 
		invoiceDAO.deleteInvoiceProject(invoiceVO);
		// hm_invoice_project 테이블에 추가한다
		String projectArray = CommonUtil.unescape(invoiceVO.getJsonProjectString());
		JSONArray projectArrayJ = (JSONArray)JSONValue.parseWithException(projectArray);
		Iterator pIt = projectArrayJ.iterator();
		while(pIt.hasNext())
		{
			JSONObject ob = (JSONObject)pIt.next();
			ob.put("invoiceId", invoiceVO.getInvoiceId());
			invoiceDAO.insertInvoiceProject(ob);
		}
	}

	/* TENY_170313 종합 매출등록된 매출건중 수금단계까지 다 끝난 매출에 대해 더이상 채권관리가 필요없다는 표시를 하는 SQL문 */
	public void updateTotSalesBondMngStatus(InvcStatVO invcStatVO) throws Exception {
		invoiceDAO.updateTotSalesBondMngStatus(invcStatVO);
	}

	/* TENY_170313 일반 매출등록된 매출건중 수금단계까지 다 끝난 매출에 대해 더이상 채권관리가 필요없다는 표시를 하는 SQL문 */
	public void updateGenSalesBondMngStatus(InvcStatVO invcStatVO) throws Exception {
		invoiceDAO.updateGenSalesBondMngStatus(invcStatVO);
	}

	/* TENY_170313 발행된 세금계산서 중 수금단계까지 다 끝난 계산서에 대해 더이상 채권관리가 필요없다는 표시를 하는 SQL문 */
	// 이를 위해 프로젝트별로 나눈 부분에 대하여 채권관리종료표시를 한다.
	public void updateInvPrjBondMngStatus(InvcStatVO invcStatVO) throws Exception {
		invoiceDAO.updateInvPrjBondMngStatus(invcStatVO);
	}

	
////////////////     DELETE    ////////////////////
	/* TENY_170213 세금계산서 정보수정시 사용하는 메소드 */
	public void deleteInvoice(Map<String, Object> param) throws Exception {
		logT.debug("START");
		invoiceDAO.deleteInvoice(param);
	}
	public void deleteInvoiceList(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		invoiceDAO.deleteInvoiceList(invoiceVO);
	}

////////////////////////////////////
// 각종 세금계산서 처리기능 함수
	//
	public boolean CreateAInvoice() throws Exception {
		return true;
	}
	
	// 세금계산서 발행처리
	public boolean PublishInvoice(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
/*
 			if(invoiceVO.getStatus() != invoiceVO.REQUEST) {
			logT.debug("invoice status is not Correct [발행처리시 세금계산서는 발행요청상태이어야 함]");
			return false;
		}
 */

		// 세금계산서 발행처리를 위해서는 계산서의 상태를 Y로 만들고
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("invoiceId", invoiceVO.getInvoiceId());
		param.put("status", invoiceVO.PUBLISH);
		param.put("publishUserNo", invoiceVO.getPublishUserNo());
		
		logT.debug("invoiceId : " + invoiceVO.getInvoiceId());
		logT.debug("status : " + invoiceVO.PUBLISH);
		logT.debug("publishUserNo : " + invoiceVO.getPublishUserNo());

		invoiceDAO.updateInvoice(param);

		// 세금계산서 프로젝트 정보를 채권관리하도록 상태값을 수정하여 준다
		param.clear();
		param.put("invoiceId", invoiceVO.getInvoiceId());
		param.put("bondManageYn", "Y");
		invoiceDAO.updateInvoiceProject(param);
		
		logT.debug("END");
		return true;
	}

	// 세금계산서 발행취소 처리
	public boolean CancelInvoice(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		/*
		if(invoiceVO.getStatus() != invoiceVO.CANCEL) {
		if(!invoiceVO.getStatus().equals("C")) {
			logT.debug("invoice status is not Correct. Need C");
			return false;
		}
		*/

		// 세금계산서 프로젝트 정보를 채권관리하지 않도록 상태값을 N으로 수정하여 준다
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("invoiceId", invoiceVO.getInvoiceId());
		param.put("status", invoiceVO.CANCEL);
		param.put("useAt", "N");
		invoiceDAO.updateInvoice(param);

		// 세금계산서 테이블에 상태값을 C로 수정하고 useAt을 N로 바꾼다
		param.clear();
		param.put("invoiceId", invoiceVO.getInvoiceId());
		param.put("bondManageYn", "N");
		
		invoiceDAO.updateInvoiceProject(param);
		
		return true;
	}
	
	/* TENY_170213 수금등록시 사용되는 메소드 */
	public boolean RegistCollect(CollectFm collectFm) throws Exception {
		logT.debug("START");

		// 세금계산서관련 프로젝트별 정보에 프로젝트별 수금액 정보(지금까지 누적액)를 수정한다
		// 수금정보를 hm_invoice_collect 테이블에 저장한다
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("invoiceId", collectFm.getInvoiceId());
		map.put("collectUserNo", collectFm.getCollectUserNo());
		map.put("collectDate", collectFm.getCollectDate());
		map.put("collect", collectFm.getCollect());
		map.put("type", collectFm.getType());
		map.put("note", collectFm.getNote());
		
//		int collectNo= 
		String projectArray = CommonUtil.unescape(collectFm.getJsonProjectString());
		JSONArray projectArrayJ = (JSONArray)JSONValue.parseWithException(projectArray);
		Iterator pIt = projectArrayJ.iterator();
		while(pIt.hasNext())
		{
			JSONObject ob = (JSONObject)pIt.next();
			invoiceDAO.updateInvoiceProjectJson(ob);

			ob.put("invoiceId", collectFm.getInvoiceId());
			ob.put("collectUserNo", collectFm.getCollectUserNo());
			ob.put("collectDate", collectFm.getCollectDate());
			ob.put("type", collectFm.getType());
			ob.put("note", collectFm.getNote());
			invoiceDAO.insertInvoiceCollectJson(ob);

			/* 자금보고건 자동 insert */
			if(collectFm.getAutoInsertFund().equals("Y")) {
				logT.debug("자금보고건 자동등록 합니다");

				logT.debug("date" + collectFm.getCollectDate());
				logT.debug("type" + "D");
				logT.debug("account" + "GD");
				logT.debug("bankBook" +  collectFm.getBankBook());
				logT.debug("expense" + ob.get("collect"));
				logT.debug("prjId" +  ob.get("prjId"));
				logT.debug("note" + collectFm.getTitle() + "[" + collectFm.getCustCompanyName() + "]");
				logT.debug("companyCd" + collectFm.getCompanyCd());

				
				map.clear();
				map.put("date", collectFm.getCollectDate());
				map.put("type", "D");
				map.put("account", "GD");
				map.put("bankBook",  collectFm.getBankBook());
				map.put("expense", ob.get("collect"));
				map.put("prjId",  ob.get("prjId"));
				map.put("note", collectFm.getTitle() + "[" + collectFm.getCustCompanyName() + "]");
				map.put("companyCd", collectFm.getCompanyCd());

				invoiceDAO.insertFund(map);
			}
		}

		// 세금계산서에 수금정보를 저장한다. hm_invoice 테이블에 총 수금액 정보를 수정한다
		map.clear();
		long totalCollectSum = collectFm.getTotalCollectOld() + collectFm.getTotalCollect();
		map.put("invoiceId", collectFm.getInvoiceId());
		map.put("totalCollect", totalCollectSum);
		if (collectFm.getTotalSum() == totalCollectSum) {
			map.put("status", 16);	// 수금완료
		}
		else if(collectFm.getTotalSum() > totalCollectSum) {
			map.put("status", 8);	// 수금중
		}
		else {
			map.put("status", 32);	// 초과수금
		}

		invoiceDAO.updateInvoice(map);


		//TBL_FUND랑 연결하려면 미리 no 생성해서 입력후 bond_collection에 컬럼 추가해서 연결해줘야함 
		return true;
	}
	
	/* TENY_170213 수금이 완료되지 않고 수금등록시 사용되는 메소드 */
	public boolean RegistCollectEnd(CollectFm collectFm) throws Exception {
		logT.debug("START");

		// 세금계산서관련 프로젝트별 정보에 프로젝트별 수금액 정보(지금까지 누적액)를 수정한다
		// 수금정보를 hm_invoice_collect 테이블에 저장한다
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("invoiceId", collectFm.getInvoiceId());
		map.put("collectUserNo", collectFm.getCollectUserNo());
		map.put("collectDate", collectFm.getCollectDate());
		map.put("collect", collectFm.getCollect());
		map.put("type", collectFm.getType());
		map.put("note", collectFm.getNote());
		
//		int collectNo= 
		String projectArray = CommonUtil.unescape(collectFm.getJsonProjectString());
		JSONArray projectArrayJ = (JSONArray)JSONValue.parseWithException(projectArray);
		Iterator pIt = projectArrayJ.iterator();
		while(pIt.hasNext())
		{
			JSONObject ob = (JSONObject)pIt.next();
			invoiceDAO.updateInvoiceProjectJson(ob);

			ob.put("invoiceId", collectFm.getInvoiceId());
			ob.put("collectUserNo", collectFm.getCollectUserNo());
			ob.put("collectDate", collectFm.getCollectDate());
			ob.put("type", collectFm.getType());
			ob.put("note", collectFm.getNote());
			invoiceDAO.insertInvoiceCollectJson(ob);

			/* 자금보고건 자동 insert */
			if(collectFm.getAutoInsertFund().equals("Y")) {
				logT.debug("자금보고건 자동등록 합니다");

				logT.debug("date" + collectFm.getCollectDate());
				logT.debug("type" + "D");
				logT.debug("account" + "GD");
				logT.debug("bankBook" +  collectFm.getBankBook());
				logT.debug("expense" + ob.get("collect"));
				logT.debug("prjId" +  ob.get("prjId"));
				logT.debug("note" + collectFm.getTitle() + "[" + collectFm.getCustCompanyName() + "]");
				logT.debug("companyCd" + collectFm.getCompanyCd());

				
				map.clear();
				map.put("date", collectFm.getCollectDate());
				map.put("type", "D");
				map.put("account", "GD");
				map.put("bankBook",  collectFm.getBankBook());
				map.put("expense", ob.get("collect"));
				map.put("prjId",  ob.get("prjId"));
				map.put("note", collectFm.getTitle() + "[" + collectFm.getCustCompanyName() + "]");
				map.put("companyCd", collectFm.getCompanyCd());

				invoiceDAO.insertFund(map);
			}
		}

		// 세금계산서에 수금정보를 저장한다. hm_invoice 테이블에 총 수금액 정보를 수정한다
		map.clear();
		long totalCollectSum = collectFm.getTotalCollectOld() + collectFm.getTotalCollect();
		map.put("invoiceId", collectFm.getInvoiceId());
		map.put("totalCollect", totalCollectSum);
		map.put("status", 16);	// 수금완료

		invoiceDAO.updateInvoice(map);


		//TBL_FUND랑 연결하려면 미리 no 생성해서 입력후 bond_collection에 컬럼 추가해서 연결해줘야함 
		return true;
	}
	
	public boolean deleteCollect(String invoiceId) throws Exception {
		logT.debug("START invoiceId = " + invoiceId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("invoiceId", invoiceId);
		map.put("totalCollect", 0);
		map.put("status", 8);
		invoiceDAO.updateInvoice(map); // invoice테이블에 있는 수금정보를 0로 만든다.
		
		map.clear();
		map.put("invoiceId", invoiceId);
		map.put("collect", 0);
		map.put("collectOld", 0);
		map.put("bondManageYn", "N");
		invoiceDAO.updateInvoiceProject(map);

		map.clear();
		map.put("invoiceId", invoiceId);
		invoiceDAO.deleteInvoiceCollect(map);

		logT.debug("END");
		return true;
	}
}


