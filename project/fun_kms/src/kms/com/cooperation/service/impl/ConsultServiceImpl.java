package kms.com.cooperation.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kms.com.common.utils.CommonUtil;
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.cooperation.service.ConsultCommentVO;
import kms.com.cooperation.service.ConsultManage;
import kms.com.cooperation.service.ConsultManageRecieve;
import kms.com.cooperation.service.ConsultService;

import org.springframework.stereotype.Service;

import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("KmsConsultService")
public class ConsultServiceImpl implements ConsultService {

	@Resource(name="KmsConsultDAO")
	private ConsultDAO consultDAO;
	
	@Resource(name = "kmsBusinessContactIdGnrService")
	private EgovIdGnrService idGnrService;
	
	@Override
	public List selectConsultCustomerList(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return consultDAO.selectCustomerList(param);
	}

	@Override
	public int selectConsultCustomerListCnt(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return consultDAO.selectCustomerListCnt(param);
	}

	@Override
	public Map<String, Object> selectConsultCustomer(Map<String, Object> param)
	throws Exception {
		// TODO Auto-generated method stub
		return consultDAO.selectCustomer(param);
	}
	
	@Override
	public void insertConsultCustomer(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		consultDAO.insertCustomer(param);
	}
	
	@Override
	public void updateConsultCustomer(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		consultDAO.updateCustomer(param);
	}
	
	@Override
	public void deleteConsultCustomer(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		consultDAO.deleteCustomer(param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 List 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 List 상담관리 return
	 * @참조 : 
	 */
	public List selectConsultManageList(Map<String, Object> param)
		throws Exception {
		return consultDAO.selectConsultManageList(param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 List 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 List 상담관리 return
	 * @참조 : 
	 */
	public List selectConsultManageListForExcel(Map<String, Object> param)
		throws Exception {
		
		// 상담 목록 가져오기
		List<EgovMap> consultList = selectConsultManageList(param);
		
		for (EgovMap tmpVO: consultList) {
			// 댓글 문자열 가공, "댓글작성자: 댓글내용 / " 반복되도록..
			
			ConsultCommentVO consultCommentVO = new ConsultCommentVO();
			consultCommentVO.setConsult_no((String)tmpVO.get("consultNo"));
			
			List<ConsultCommentVO> resultList = new ArrayList<ConsultCommentVO>();
			try {
				resultList = selectConsultCommentList(consultCommentVO);
				
				String commentsStr = "";
				for (ConsultCommentVO tmpCommentVO: resultList) {
					commentsStr += tmpCommentVO.getUserNm() + "(" + tmpCommentVO.getRegDt() + ") : " + tmpCommentVO.getCn() + "--------------------------------------------------------";
				}
				tmpVO.put("consultComment", commentsStr);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return consultList;
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 건수 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 건수 상담관리 return
	 * @참조 : 
	 */
	public int selectConsultManageListCnt(Map<String, Object> param)
		throws Exception {	
		return consultDAO.selectConsultManageListCnt(param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 검색 결과 상세 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 검색 결과 상세 상담관리 return
	 * @참조 : 
	 */
	public ConsultManage selectConsultManage(ConsultManage consultManage)
	throws Exception {
		// 열람시간 기록
		consultDAO.setReadtime(consultManage);
		
		ConsultManage result = (ConsultManage)consultDAO.selectConsultManage(consultManage);
		
		// 담당자 목록 불러오기
		List<ConsultManageRecieve> rList = selectConsultManageRecieve(consultManage);
		
		// 담당자가 조회시 상태값을 처리중으로 변경
		if (result.getState().equals("1")) {	// 접수 상태일 경우에만			
			for (ConsultManageRecieve tmp: rList) {
				if (tmp.getRecieveTyp().equals("RE")) {	// tmp.getUserNo 가 null인 경우 exception 발생하여 조건 분리.
					if ( tmp.getUserNo().equals(consultManage.getUserNo()) ) {
						consultManage.setState("2");
						result.setState("2");
						consultDAO.updateConsultState(consultManage);
					}
				}
			}
		}
		
		for (int i=0; i<rList.size(); i++) {
			ConsultManageRecieve r = rList.get(i);
			if (r.getRecieveTyp().equals("RE")) {
				result.addChargedList(r);
			}
			else if (r.getRecieveTyp().equals("RF")) {
				result.addAddList(r);
			}
			else if (r.getRecieveTyp().equals("CM")) {
				result.addCompList(r);
			}
		}
		
		return result;
	}
	
	@Override
	public List<ConsultManageRecieve> selectConsultManageRecieve(ConsultManage consultManage) throws Exception {
		return consultDAO.selectConsultManageRecieve(consultManage);
	}

	
	/**
	 * @param 
	 * @return tbl_consult table 인서트 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 인서트 상담관리 return
	 * @참조 : 
	public void insertConsultManage(Map<String, Object> param)
		throws Exception {
		consultDAO.insertConsultManage(param);
	}
	 */
	
	public String insertConsultManage(ConsultManage consultManage, ConsultManageRecieve consultManageRecieve) throws Exception {
		
		String consultNo = idGnrService.getNextStringId();
		
		consultManage.setConsult_no(consultNo);
		consultManageRecieve.setConsultNo(consultNo);
		
		
		consultDAO.insertConsultManage(consultManage);
		
		if (!consultManageRecieve.getCharged().isEmpty() || !consultManageRecieve.getAdd().isEmpty() || !consultManageRecieve.getComp().isEmpty()) {
			insertConsultManageReceive(consultManageRecieve);
		}
		return consultNo;
	}
	@Override
	public void insertConsultManageReceive(ConsultManageRecieve consultManageRecieve) throws Exception {
		if (CommonUtil.isMixedId(consultManageRecieve.getAdd())) {
			consultManageRecieve.setAddUserIdList(CommonUtil.parseIdFromMixs(consultManageRecieve.getAdd()));
		}
		if (CommonUtil.isMixedId(consultManageRecieve.getCharged())) {
			consultManageRecieve.setChargedUserIdList(CommonUtil.parseIdFromMixs(consultManageRecieve.getCharged()));
		}
		if(CommonUtil.isMixedId(consultManageRecieve.getComp())) {
			consultManageRecieve.setCompUserIdList(CommonUtil.parseIdFromMixs(consultManageRecieve.getComp()));
		}
		consultDAO.insertConsultManageReceive(consultManageRecieve);
	}
	
	
	/**
	 * @param 
	 * @return tbl_consult table 상세 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상세 상담관리 return
	 * @참조 : 
	 */
	public void updateConsultManage(ConsultManage consultManage)
		throws Exception {
		consultDAO.updateConsultManage(consultManage);
	}
	
	public void updateConsultManage(ConsultManage consultManage,ConsultManageRecieve consultManageRecieve)
	throws Exception {
		consultDAO.updateConsultManage(consultManage);
		
		List<Integer> userList = consultDAO.selectInterestUserNoList(consultManage);
		consultDAO.deleteConsultManageRecieve(consultManage);
	
		if (CommonUtil.isMixedId(consultManage.getAdd())) {
			consultManageRecieve.setAddUserIdList(CommonUtil.parseIdFromMixs(consultManage.getAdd()));
		}
		if (CommonUtil.isMixedId(consultManage.getCharged())) {
			consultManageRecieve.setChargedUserIdList(CommonUtil.parseIdFromMixs(consultManage.getCharged()));
		}
		if(CommonUtil.isMixedId(consultManage.getComp())) {
			consultManageRecieve.setCompUserIdList(CommonUtil.parseIdFromMixs(consultManage.getComp()));
		}
		
		if(consultManageRecieve.getChargedUserIdList() == null) {
			consultManageRecieve.setChargedUserIdList(CommonUtil.parseIdFromMixs(consultManage.getChargedUserIdMix()));
		}
		
		consultManageRecieve.setConsultNo(consultManage.getConsult_no());
		consultManageRecieve.setUserNo(consultManageRecieve.getUserNo());
		
		if (consultManageRecieve.getCharged() != null || consultManageRecieve.getAdd() != null || consultManageRecieve.getComp() != null) {
			consultDAO.insertConsultManageReceive(consultManageRecieve);
		}
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("consult_no", consultManage.getConsult_no());
		param.put("userList", userList);
		consultDAO.setInterestCon(param);
}
	
	/**
	 * @param 
	 * @return tbl_consult table 삭제 상담관리 return
	 * @throws Exception
	 * @내용 : tbl_consult table 삭제 상담관리 return
	 * @참조 : 
	 */
	public void deleteConsultManage(Map<String, Object> param)
		throws Exception {
		consultDAO.deleteConsultManage(param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult_customer table 검색 결과 List 셀렉트박스 return
	 * @throws Exception
	 * @내용 : tbl_consult_customer table 검색 결과 List  return
	 * @참조 : 
	 */
	public List selectCustList(Map<String, Object> param)
		throws Exception {
		return consultDAO.selectCustList(param);
	}	
	
	/**
	 * @param 
	 * @return tbl_consult table 인서트 상담관리덧글 return
	 * @throws Exception
	 * @내용 : tbl_consult table 인서트 상담관리덧글 return
	 * @참조 : 
	 */
	public void insertConsultManageComment(Map<String, Object> param)
		throws Exception {
		
		consultDAO.deleteReadtm(param);
		consultDAO.insertConsultManageComment(param);
		
	}
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 List return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글 List return
	 * @참조 : 
	 */
	public List<ConsultCommentVO> selectConsultCommentList(ConsultCommentVO consultCommentVO)
		throws Exception {
		return consultDAO.selectConsultCommentList(consultCommentVO);
	}	
	
	public ConsultCommentVO selectConsultComment(ConsultCommentVO consultCommentVO) throws Exception {
		List<ConsultCommentVO> list = selectConsultCommentList(consultCommentVO);
		
		if (list.size() == 1)
			return list.get(0);
		else
			return new ConsultCommentVO();
	}
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 인서트 return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글  return
	 * @참조 : 
	 */
	public void insertConsultComment(ConsultCommentVO consultCommentVO) throws Exception {
		consultDAO.insertConsultComment(consultCommentVO);
				
		ConsultManageRecieve consultManageRecieve = new ConsultManageRecieve();
		consultManageRecieve.setConsultNo(consultCommentVO.getConsult_no());
		consultDAO.updateConsultManageReceive(consultManageRecieve);
	}
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 업데이트 return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글  return
	 * @참조 : 
	 */
	public void updateConsultComment(ConsultCommentVO consultCommentVO) throws Exception {
		consultDAO.updateConsultComment(consultCommentVO);
		
		ConsultManageRecieve consultManageRecieve = new ConsultManageRecieve();
		consultManageRecieve.setConsultNo(consultCommentVO.getConsult_no());
		consultDAO.updateConsultManageReceive(consultManageRecieve);
	}
	
	/**
	 * @param 
	 * @return tbl_consult_comment table 덧글 삭제 return
	 * @throws Exception
	 * @내용 : tbl_consult_comment table 덧글  return
	 * @참조 : 
	 */
	public void deleteConsultComment(ConsultCommentVO consultCommentVO) throws Exception {
		consultDAO.deleteConsultComment(consultCommentVO);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 상태변경 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 상태변경  return
	 * @참조 : 
	 */
	public ConsultManage selectConsultState(ConsultManage consultManage) throws Exception {
		ConsultManage result = (ConsultManage)consultDAO.selectConsultState(consultManage);
		return result;
	}
	
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 상태변경 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 상태변경  return
	 * @참조 : 
	 */
	public void updateConsultState(ConsultManage consultManage) throws Exception {
		consultDAO.updateConsultState(consultManage);
	}

	/**
	 * @param 
	 * @return tbl_consult table 상담관리 지라 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 지라  return
	 * @참조 : 
	 */
	public ConsultManage selectConsultJira(ConsultManage consultManage) throws Exception {
		ConsultManage result = (ConsultManage)consultDAO.selectConsultJira(consultManage);
		return result;
	}
	
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 지라 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 지라  return
	 * @참조 : 
	 */
	public void updateConsultJira(ConsultManage consultManage) throws Exception {
		consultDAO.updateConsultJira(consultManage);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 통계 검색기간이전 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 통계 검색기간이전 return
	 * @참조 : 
	 */
	public List selectConsultManageList2(Map<String, Object> param)
		throws Exception {
		return consultDAO.selectConsultManageList2(param);
	}
	
	public List selectConsultManageList3(Map<String, Object> param)
		throws Exception {
		return consultDAO.selectConsultManageList3(param);
	}
	
	/**
	 * @param 
	 * @return tbl_consult table 상담관리 통계 검색기간이전 카운트 return
	 * @throws Exception
	 * @내용 : tbl_consult table 상담관리 통계 검색기간이전 카운트 return
	 * @참조 : 
	 */
	public int selectConsultManageList2Cnt(Map<String, Object> param)
		throws Exception {	
		return consultDAO.selectConsultManageList2Cnt(param);
	}
	
	public List selectConsultStatList(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return consultDAO.selectConsultStatList(param);
	}

	@Override
	public List selectConsultStatisticsList(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return consultDAO.selectConsultStatisticsList(param);
	}
	
	@Override
	public List selectConsultStatisticsList(Map<String, Object> param, String type)
			throws Exception {
		// TODO Auto-generated method stub
		return consultDAO.selectConsultStatisticsList(param, type);
	}
	
	@Override
	public void changeConsultRecieve(ConsultManageRecieve consultManageRecieve) throws Exception {
		/*
		 * 1. 담당자 변경 및 참조자 변경
		 */
		consultDAO.deleteConsultManageRecieve(consultManageRecieve);
		if (CommonUtil.isMixedId(consultManageRecieve.getChargedUserIdMix().toString())) {
			consultManageRecieve.setChargedUserIdList(CommonUtil.parseIdFromMixs(consultManageRecieve.getChargedUserIdMix().toString()));
		}
		
		// 참조자가 없을 경우 작업 X
		if (consultManageRecieve.getAddUserIdMix() != null && !consultManageRecieve.getAddUserIdMix().isEmpty()) {
			if (CommonUtil.isMixedId(consultManageRecieve.getAddUserIdMix().toString())) {
				consultManageRecieve.setAddUserIdList(CommonUtil.parseIdFromMixs(consultManageRecieve.getAddUserIdMix().toString()));
			}
		}
		consultManageRecieve.setConsultNo(consultManageRecieve.getConsult_no());
		consultDAO.insertConsultManageReceive(consultManageRecieve);
		
		
		/*
		 * 2. 담당자가 변경되었을 경우, 처리상태를 접수 상태로 변경한다.
		 */
		ConsultManage consultManage = new ConsultManage();
		consultManage.setConsult_no(consultManageRecieve.getConsult_no());
		consultManage.setState("1");	// 접수
		consultDAO.updateConsultState(consultManage);
	}

	@Override
	public void updateIssue(ConsultManage consultManage) throws Exception {
		consultDAO.updateIssue(consultManage);
	}

	/**
	 * 상담관리 통계 테이블, 각 영역의 데이터를 만들어내는 메서드
	 */
	@Override
	public List makeStatisticList(List<EgovMap> result, List<CmmnDetailCode> codeResult1, List<CmmnDetailCode> codeResult2,
									String groupTyp1, String groupTyp2, boolean rowSumFlag) throws Exception {
		
		Map<String, String> resultMap1 = new HashMap<String, String>();
		for (EgovMap tmpEgov: result) {
			resultMap1.put( "col"+ tmpEgov.get(groupTyp1) + "row" + tmpEgov.get(groupTyp2), String.valueOf(tmpEgov.get("cnt")) ); 
		}
		
		List resultList = new ArrayList();
		List<String> tmpSumList = new ArrayList<String>();
		
		// 합계(row) 초기화
		if (rowSumFlag)
			for (CmmnDetailCode tmpCode2: codeResult2)
				tmpSumList.add("0");
		
		
		for (CmmnDetailCode tmpCode: codeResult1) {
			List<String> tmpList = new ArrayList<String>();
			
			for (int i=0; i<codeResult2.size(); i++) {
				// 행,열의 매핑값을 체크후, 값이 있다면 가져오고 없으면 0값을 셋팅
				String resultCnt = resultMap1.get("col"+ tmpCode.getCode() + "row" + codeResult2.get(i).getCode());
				resultCnt = (resultCnt == null || "".equals(resultCnt)) ? "0" : resultCnt;
				
				if (rowSumFlag)
					tmpSumList.set(i, String.valueOf(Integer.parseInt(tmpSumList.get(i)) + Integer.parseInt(resultCnt)));
				
				tmpList.add(resultCnt);
			}
			
			resultList.add(tmpList);
		}
		
		if (rowSumFlag)
			resultList.add(tmpSumList);

		return resultList;
	}

	
	/**
	 * 상담결과 : checkbox에 바인딩된 내용, javascript에서 쓸수있도록 String형 전환
	 *  [1, 2] -> "1,2"
	 */
	@Override
	public String convertSearchData(String[] strArr) throws Exception {
		String str = "";
		
		for (int i=0; i<strArr.length; i++) {
			if (!"fakeValue".equals(strArr[i]))
				str += strArr[i] + ",";
		}
		
		if (str != "")
			str = str.substring(0, str.length()-1);
		
		return str;
	}
	
	/**
	 * 상품관리번호 삭제
	 */
	public void deleteRequestId(String consultNo) throws Exception {
		consultDAO.deleteRequestId(consultNo);
	}
}
