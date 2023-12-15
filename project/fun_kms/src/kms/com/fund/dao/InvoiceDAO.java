package kms.com.fund.dao;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.fund.vo.*;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("KmsInvoiceDAO")

public class InvoiceDAO extends EgovAbstractDAO{
	Logger logT = Logger.getLogger("TENY");

////////////////    SELECT    ////////////////////
	/* TENY_170206  계산서 목록을 조회하는 DAO메소드 */
	public List<InvoiceVO> selectInvoiceList(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		logT.debug("searchStatus : " + invoiceVO.getSearchStatus() );
		return (List<InvoiceVO>) list("KmsInvoiceDAO.selectInvoiceList", invoiceVO);
	}

	/* TENY_170206  한개의 계산서를 조회하는 DAO메소드 */
	public InvoiceVO selectInvoiceView(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (InvoiceVO) selectByPk("KmsInvoiceDAO.selectInvoiceView", param);
	}

	/* TENY_170206  한개의 계산서에 딸려있는 적요 목록을 조회하는 DAO메소드 */
	public List<InvoiceContentsVO> selectInvoiceContentsList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (List<InvoiceContentsVO>) list("KmsInvoiceDAO.selectInvoiceContentsList", param);
	}
	
	/* TENY_170206  한개의 계산서에 딸려있는 프로젝트 목록을 조회하는 DAO메소드 */
	public List<InvoiceProjectVO> selectInvoiceProjectList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (List<InvoiceProjectVO>) list("KmsInvoiceDAO.selectInvoiceProjectList", param);
	}
	
	/* TENY_170206  한개의 계산서에 딸려있는 수금 목록을 조회하는 DAO메소드 */
	public List<InvoiceCollectVO> selectInvoiceCollectList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (List<InvoiceCollectVO>) list("KmsInvoiceDAO.selectInvoiceCollectList", param);
	}

	public int selectInvoiceListCount(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsInvoiceDAO.selectInvoiceListCount", invoiceVO);
	}

	/* TENY_170209 세금계산서 작성시 기작성된 세금계산서에서 회사정보를 가져와 정보를 채우기 위해 정보목록을 조회하는 DAO메소드 */
	public List<InvoiceVO> selectInvoiceCustInfoList(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		return (List<InvoiceVO>) list("KmsInvoiceDAO.selectInvoiceCustInfoList", invoiceVO);
	}

	public String selectMaxInvoiceId() throws Exception {
		return (String) getSqlMapClientTemplate().queryForObject("KmsInvoiceDAO.selectMaxInvoiceId");
	}
 
	public List<InvcStatVO> selectInvcStatByOrg(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (List<InvcStatVO>) list("KmsInvoiceDAO.selectInvcStatByOrg", param);
	}
	
	public List<InvcStatVO> selectInvcStatByPrj(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (List<InvcStatVO>) list("KmsInvoiceDAO.selectInvcStatByPrj", param);
	}

	public int selectInvcStatByPrjCount(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsInvoiceDAO.selectInvcStatByPrjCount", param);
	}

	public List<InvcStatVO> selectBondOrgnztList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (List<InvcStatVO>) list("KmsInvoiceDAO.selectBondOrgnztList", param);
	}

	public List<InvcStatVO> selectCheckOrgSalesList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (List<InvcStatVO>) list("KmsInvoiceDAO.selectCheckOrgSalesList", param);
	}
	
	public List<BondCheckVO> selectProjectBondCheckList(Map<String, Object> param) throws Exception{
		logT.debug("START");
		return (List<BondCheckVO>) list("KmsInvoiceDAO.selectProjectBondCheckList", param);
	}
	
	public List<CollectListVO> selectProjectBondCheckList2(Map<String, Object> param) throws Exception{
		logT.debug("START");
		return (List<CollectListVO>) list("KmsInvoiceDAO.selectCollectList", param);
	}
	
	public int selectCheckProjectSalesCount(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsInvoiceDAO.selectCheckProjectSalesCount", param);
	}
	
	public List<InvcStatVO> selectProjectSalesCheckList(Map<String, Object> param) throws Exception{
		logT.debug("START");
		return (List<InvcStatVO>) list("KmsInvoiceDAO.selectProjectSalesCheckList", param);
	}

	public List<InvcStatVO> selectInvcCheckSalesOrgList(Map<String, Object> param) throws Exception {
		logT.debug("START");
		return (List<InvcStatVO>) list("KmsInvoiceDAO.selectInvcSalesOrgList", param);
	}

	public List<InvcStatVO> selectCheckTotSalesList(Map<String, Object> param) throws Exception{
		logT.debug("START");
		return (List<InvcStatVO>) list("KmsInvoiceDAO.selectTotSalesListOfPrj", param);
	}
	
	public List<InvcStatVO> selectCheckGenSalesList(Map<String, Object> param) throws Exception{
		logT.debug("START");
		return (List<InvcStatVO>) list("KmsInvoiceDAO.selectGenSalesListOfPrj", param);
	}

	/* TENY_170313 특정 프로젝트와 관련되어 발행된 계산서 목록을 읽하기 위한 Method */
	public List<InvoiceProjectVO> selectInvoiceListOfProject(Map<String, Object> param) throws Exception{
		logT.debug("START");
		return (List<InvoiceProjectVO>) list("KmsInvoiceDAO.selectInvoiceListOfProject", param);
	}
	
	public List<ProjectCollectVO> selectProjectCollectList(String prjId) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prjId", prjId);
		return (List<ProjectCollectVO>) list("KmsInvoiceDAO.selectProjectCollectList", map);
	}

	////////////////    INSERT    ////////////////////
	/* TENY_170213 세금계산서 정보를 DB에 저장하는 DAO메소드 */
	public void insertInvoice(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		/* 새로 입력되는 세금계산서의 id값을 세팅함 */
		int tmpIntId = Integer.parseInt(selectMaxInvoiceId().substring(5)) + 1;
		invoiceVO.setInvoiceId(String.format( "INVC_%015d", tmpIntId) );
		
		insert("KmsInvoiceDAO.insertInvoice", invoiceVO);
	}

	/* 세금계산서에 들어가는 세부내역을 저장하는 DAO함수 */
	public void insertInvoiceContents(JSONObject ob) throws Exception {
		insert("KmsInvoiceDAO.insertInvoiceContents", ob);
	}
	
	/* 세금계산서와 관련있는 프로젝트를 저장하는 DAO함수 */
	public void insertInvoiceProject(JSONObject ob) throws Exception {
		insert("KmsInvoiceDAO.insertInvoiceProject", ob);
	}

	/* 세금계산서와 관련있는 수금정보를 저장하는 DAO함수 */
	public void insertInvoiceCollect(Map<String, Object> map) throws Exception {
		insert("KmsInvoiceDAO.insertInvoiceCollect", map);
/*	추후 더 연구해보기로 한다.	return (Integer) getSqlMapClientTemplate().queryForObject("KmsInvoiceDAO.insertInvoiceCollect", map); */
	}

	/* 세금계산서와 관련있는 수금정보를 저장하는 DAO함수 */
	public void insertInvoiceCollectJson(JSONObject ob) throws Exception {
		insert("KmsInvoiceDAO.insertInvoiceCollect", ob);
/*	추후 더 연구해보기로 한다.	return (Integer) getSqlMapClientTemplate().queryForObject("KmsInvoiceDAO.insertInvoiceCollect", map); */
	}

	/* TENY_170323  세금계산서의 수금정보를 저장할때 자금일보에 자동등록하는 DAO함수 */
	public void insertFund(Map<String, Object> map) throws Exception {
		insert("KmsInvoiceDAO.insertFund", map);
	}

////////////////    UPDATE    ////////////////////
	/* TENY_170213 세금계산서 정보를 UPDATE하는 DAO메소드 */
	/* TENY_170213 세금계산서의 상태를 UPDATE하는 DAO메소드 미발행에서 발행이나 취소시 사용*/
	public void updateInvoiceVO(InvoiceVO invoiceVO) throws Exception {
		logT.debug("START");
		update("KmsInvoiceDAO.updateInvoice", invoiceVO);
	}
	/* TENY_170324 세금계산서 정보를 UPDATE하는 DAO메소드 입력 파라미터를 Map으로 받는다  추후 이것을 주로 쓸 예정임 */ 
	public void updateInvoice(Map<String, Object> map) throws Exception {
		logT.debug("START");
		update("KmsInvoiceDAO.updateInvoice2", map);
	}
	
	/* TENY_170324 세금계산서의 프로젝트 정보를 UPDATE하는 DAO메소드 
	 * 발행처리나 취소, 수금시 사용. 하나로 합침 */
	public void updateInvoiceProject(Map<String, Object> map) throws Exception {
		logT.debug("START");
		update("KmsInvoiceDAO.updateInvoiceProject", map);
	}
	public void updateInvoiceProjectJson(JSONObject jo) throws Exception {
		logT.debug("START");
		update("KmsInvoiceDAO.updateInvoiceProject", jo);
	}
	
	/* TENY_170313 종합 매출등록된 매출건중 수금단계까지 다 끝난 매출에 대해 더이상 채권관리가 필요없다는 표시를 하는 SQL문 */
	public void updateTotSalesBondMngStatus(InvcStatVO invcStatVO) throws Exception {
		logT.debug("START");
		update("KmsInvoiceDAO.updateTotSalesBondMngStatus", invcStatVO);
	}

	/* TENY_170313 일반 매출등록된 매출건중 수금단계까지 다 끝난 매출에 대해 더이상 채권관리가 필요없다는 표시를 하는 SQL문 */
	public void updateGenSalesBondMngStatus(InvcStatVO invcStatVO) throws Exception {
		logT.debug("START");
		update("KmsInvoiceDAO.updateGenSalesBondMngStatus", invcStatVO);
	}

	/* TENY_170313 발행된 세금계산서 중 수금단계까지 다 끝난 계산서에 대해 더이상 채권관리가 필요없다는 표시를 하는 SQL문 */
	// 이를 위해 프로젝트별로 나눈 부분에 대하여 채권관리종료표시를 한다.
	public void updateInvPrjBondMngStatus(InvcStatVO invcStatVO) throws Exception {
		logT.debug("START");
		update("KmsInvoiceDAO.updateInvPrjBondMngStatus", invcStatVO);
	}

	
////////////////    DELETE    ////////////////////
	/* TENY_170213 세금계산서 정보를 삭제하는 DAO메소드 */
// deleteUserNo를 InvoiceVO에 만들지 않고 구현하기 위해서 입력파라미터를 Map으로 이용한다.
// 누가 삭제했는지 알려주기 위해서
	public void deleteInvoice(Map<String, Object> param) throws Exception {
		update("KmsInvoiceDAO.deleteInvoice", param);
	}
	public void deleteInvoiceList(InvoiceVO invoiceVO) throws Exception {
		update("KmsInvoiceDAO.deleteInvoiceList", invoiceVO);
	}
	
	/* 세금계산서에 들어가는 세부내역을 삭제하는 DAO함수 */
	//	void deleteInvoiceContents(JSONObject ob) {
	public void deleteInvoiceContents(InvoiceVO invoiceVO) throws Exception {
		delete("KmsInvoiceDAO.deleteInvoiceContents", invoiceVO);
	}
	/* 세금계산서와 관련있는 프로젝트를 삭제하는 DAO함수 */
	public void deleteInvoiceProject(InvoiceVO invoiceVO) throws Exception {
		delete("KmsInvoiceDAO.deleteInvoiceProject", invoiceVO);
	}
	/* 세금계산서와 관련있는 수금정보를 삭제하는 DAO함수 */
	public void deleteInvoiceCollect(Map<String, Object>map) throws Exception {
		delete("KmsInvoiceDAO.deleteInvoiceCollect", map);
	}
}
