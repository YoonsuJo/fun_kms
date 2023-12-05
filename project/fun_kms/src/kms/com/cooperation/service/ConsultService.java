package kms.com.cooperation.service;

import java.util.List;
import java.util.Map;

import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ConsultService {

	List selectConsultCustomerList(Map<String, Object> param) throws Exception;
	int selectConsultCustomerListCnt(Map<String, Object> param) throws Exception;
	Map<String, Object> selectConsultCustomer(Map<String, Object> param) throws Exception;
	void insertConsultCustomer(Map<String, Object> param) throws Exception;
	void updateConsultCustomer(Map<String, Object> param) throws Exception;
	void deleteConsultCustomer(Map<String, Object> param) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 List 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 List 상담관리 return
	 * @참조 : 
	 */
	List selectConsultManageList(Map<String, Object> param) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 List 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 List 상담관리 return
	 * @참조 : 
	 */
	List selectConsultManageListForExcel(Map<String, Object> param) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 건수 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 건수 상담관리 return
	 * @참조 : 
	 */
	int selectConsultManageListCnt(Map<String, Object> param) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 상세 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 상세 상담관리 return
	 * @참조 : 
	 */	
	ConsultManage selectConsultManage(ConsultManage consultManage) throws Exception;
	
	/**
	 * @param 
	 * @return TBL_CONSULT_RECIEVE table 상담관리 담당자/참조자 return
	 * @throws Exception
	 * @내용 : TBL_CONSULT_RECIEVE table 상담관리 담당자/참조자 return
	 * @참조 : 
	 */	
	List<ConsultManageRecieve> selectConsultManageRecieve(ConsultManage consultManage) throws Exception;
	
	
	/**
	 * @param 
	 * @return tbl_consult table 인서트 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 인서트 상담관리 return
	 * @참조 : 
	 */
	String insertConsultManage(ConsultManage consultManage, ConsultManageRecieve consultManageRecieve) throws Exception;
	
	/**
	 * @param 
	 * @return TBL_CONSULT_RECIEVE table 인서트 상담관리 담당자/참조자 return
	 * @throws Exception
	 * @내용 : TBL_CONSULT_RECIEVE table 인서트 상담관리 담당자/참조자 return
	 * @참조 : 
	 */		
	void insertConsultManageReceive(ConsultManageRecieve consultManageRecieve) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 수정 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 수정 상담관리 return
	 * @참조 : 
	 */
	void updateConsultManage(ConsultManage consultManage) throws Exception;
	void updateConsultManage(ConsultManage consultManage,ConsultManageRecieve consultManageRecieve) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 삭제 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 삭제 상담관리 return
	 * @참조 : 
	 */
	void deleteConsultManage(Map<String, Object> param) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult_customer table 검색 결과 List 셀렉트박스 return
	 * @throws Exception
	 * @내용 : tbl_consult_customer table 검색 결과 List  return
	 * @참조 : 
	 */
	List selectCustList(Map<String, Object> param) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 인서트 상담관리덧글 return
	 * @throws Exception
	 * @내용 : tbl_consult table 인서트 상담관리덧글 return
	 * @참조 : 
	 */
	void insertConsultManageComment(Map<String, Object> param) throws Exception;
	
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 List return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글 List return
	 * @참조 : 
	 */
	public List<ConsultCommentVO> selectConsultCommentList(ConsultCommentVO consultCommentVO) throws Exception;
	
	ConsultCommentVO selectConsultComment(ConsultCommentVO consultCommentVO) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 인서트 return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글  return
	 * @참조 : 
	 */
	void insertConsultComment(ConsultCommentVO consultCommentVO) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 업데이트 return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글  return
	 * @참조 : 
	 */
	void updateConsultComment(ConsultCommentVO consultCommentVO) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 삭제 return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글  return
	 * @참조 : 
	 */
	void deleteConsultComment(ConsultCommentVO consultCommentVO) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 상태 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 상태  return
	 * @참조 : 
	 */
	ConsultManage selectConsultState(ConsultManage consultManage) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 상태변경 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 상태변경  return
	 * @참조 : 
	 */
	void updateConsultState(ConsultManage consultManage) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 지라 상태 return
	 * @throws Exception
	 * @내용 : tbl_consult table 지라 상태  return
	 * @참조 : 
	 */
	ConsultManage selectConsultJira(ConsultManage consultManage) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 지라 상태변경 return
	 * @throws Exception
	 * @내용 : tbl_consult table 지라 상태변경  return
	 * @참조 : 
	 */
	void updateConsultJira(ConsultManage consultManage) throws Exception;
	
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 통계 검색기간이전 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 통계 검색기간이전 return
	 * @참조 : 
	 */
	List selectConsultManageList2(Map<String, Object> param) throws Exception;
	
	List selectConsultManageList3(Map<String, Object> param) throws Exception;
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 통계 검색기간이전 카운트 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 통계 검색기간이전 카운트 return
	 * @참조 : 
	 */
	int selectConsultManageList2Cnt(Map<String, Object> param) throws Exception;
	
	/**
	 * 상담관리 통계
	 */
	List selectConsultStatisticsList(Map<String, Object> param) throws Exception;
	/**
	 * 상담관리 통계 - 테이블 형태로 변경
	 */
	List selectConsultStatisticsList(Map<String, Object> param, String type) throws Exception;
	
	void changeConsultRecieve(ConsultManageRecieve consultManageRecieve) throws Exception;
	void updateIssue(ConsultManage consultManage) throws Exception;
	
	List makeStatisticList(List<EgovMap> result, List<CmmnDetailCode> codeResult1, List<CmmnDetailCode> codeResult2,
			String groupTyp1, String groupTyp2, boolean rowSumFlag) throws Exception;
	
	/**
	 * 상담결과 : checkbox에 바인딩된 내용, javascript에서 쓸수있도록 String형 전환
	 *  [1, 2] -> "1,2"
	 */
	String convertSearchData(String[] strArr) throws Exception;
	
	/**
	 * 상품관리번호 삭제
	 */
	void deleteRequestId(String consultNo) throws Exception;
	List selectConsultStatList(Map<String, Object> param) throws Exception;
}