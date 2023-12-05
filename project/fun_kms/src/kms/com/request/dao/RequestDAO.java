package kms.com.request.dao;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.common.utils.CalendarUtil;
import kms.com.request.vo.*;
import kms.com.common.utils.CommonUtil;
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.member.service.MemberVO;
import kms.com.request.fm.*;

@Repository("KmsRequestDAO")
public class RequestDAO extends EgovAbstractDAO {
	Logger logT = Logger.getLogger("TENY");

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 요구사항관리 관련 함수들
	// 업무계획 목록을 가져온다 (조건 : 특정작성자, 기간 )
	
	public List<RequestVO> selectRequestList(RequestFm fm) throws Exception {
		logT.debug("START");
		fm.setSearchWriterMixesList(CommonUtil.makeValidIdList(fm.getSearchWriterMixes()));
		fm.setSearchManagerMixesList(CommonUtil.makeValidIdList(fm.getSearchManagerMixes()));
		return list("KmsRequestDAO.selectRequestList", fm);
	}

	public String selectRequestReqId() throws Exception {
		return (String) getSqlMapClientTemplate().queryForObject("KmsRequestDAO.selectRequestReqId");
	}	
	
	// 요구사항을 추가한다.
	public void insertRequest(RequestVO vo) throws Exception {
		insert("KmsRequestDAO.insertRequest", vo);
	}
	
	// LYS_20180712_요구사항 담당자를 추가한다.
	public void insertRequestReceive(RequestReceiveVO vo) throws Exception {
		insert("KmsRequestDAO.insertRequestReceive", vo);
	}
	
	// 요구사항 담당자를 삭제한다.
	public void deleteRequestReceive(RequestReceiveVO vo) throws Exception {
		delete("KmsRequestDAO.deleteRequestReceive", vo);
	}

	// 요구사항을 수정한다.
	public void updateRequest(RequestVO vo) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", vo.getNo());
		map.put("title", vo.getTitle());
		map.put("prjId", vo.getPrjId());
		map.put("contents", vo.getContents());
		map.put("reqType", vo.getReqType());
		map.put("status", vo.getStatus());
		map.put("priority", vo.getPriority());
		map.put("dueDate", vo.getDueDate());
		map.put("endDate", vo.getEndDate());
		map.put("startDate", vo.getStartDate());
		map.put("atchFileId", vo.getAtchFileId());
		map.put("regDatetime", vo.getRegDatetime());
		map.put("modifyerNo", vo.getModifyerNo());
		map.put("modifyerName", vo.getModifyerName());
		if((vo.getWriterMixes() != null) && (vo.getWriterMixes().length() > 0) ){
			map.put("writerMixes", vo.getWriterMixes());
		}
		if((vo.getManagerMixes() != null) && (vo.getManagerMixes().length() > 0) ){
			map.put("managerMixes", vo.getManagerMixes());
		}
		if((vo.getManagerMixesMain() != null) && (vo.getManagerMixesMain().length() > 0) ){
			map.put("managerMixesMain", vo.getManagerMixesMain());
		}		

		update("KmsRequestDAO.updateRequest", map);
	}
	
	// 요구사항을 수정한다.
	public void updateRequestModifyer(RequestVO vo) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", vo.getNo());
		map.put("modifyerNo", vo.getModifyerNo());
		map.put("modifyerName", vo.getModifyerName());
		
		update("KmsRequestDAO.updateRequestModifyer", map);
	}
	
	// 요구사항 요구 사항을 수정한다.
	public void updateRequestStatus(String reqId, int status) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reqId", reqId);
		map.put("status", status);
		update("KmsRequestDAO.updateRequestStatus", map);
	}	
	// 요구사항담당자 완료를 수정한다.
	public void updateRequestReceiveComplete(RequestReceiveVO vo) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", vo.getNo());
		map.put("completeStatus", vo.getCompleteStatus());
		map.put("completeDateTime", vo.getCompleteDateTime());
		update("KmsRequestDAO.updateRequestReceiveComplete", map);
	}		
	// 요구사항담당자 전체를 완료로 수정한다.
	public void updateRequestReceiveCompleteAll(RequestReceiveVO vo) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reqId", vo.getReqId());
		map.put("completeDateTime", vo.getCompleteDateTime());
		update("KmsRequestDAO.updateRequestReceiveCompleteAll", map);
	}		
	
	// 복수 담당자를 조회한다
	public List<RequestReceiveVO> getRequestReceive(RequestReceiveVO receiveVo) throws Exception {
		return list("KmsRequestDAO.getRequestReceive", receiveVo);
	}	
	
	// 복수 담당자 완료 카운트 조회
	public int getRequestReceiveComplete(RequestReceiveVO receiveVo) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsRequestDAO.getRequestReceiveComplete", receiveVo);
	}	
	
	// 한개의 요구사항 내용을 조회한다.
	public RequestVO getRequest(int no) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);

		return (RequestVO)selectByPk("KmsRequestDAO.getRequest", map);
	}

	public int selectRequestListTotCnt(RequestFm fm) throws Exception {
		logT.debug("START");
		fm.setSearchWriterMixesList(CommonUtil.makeValidIdList(fm.getSearchWriterMixes()));
		fm.setSearchManagerMixesList(CommonUtil.makeValidIdList(fm.getSearchManagerMixes()));
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsRequestDAO.selectRequestListTotCnt", fm);
	}
	
	public List<RequestVO> selectRequestStat(RequestFm fm) throws Exception {
		logT.debug("START");
		fm.setSearchManagerMixesList(CommonUtil.makeValidIdList(fm.getSearchManagerMixes()));
		return list("KmsRequestDAO.selectRequestStat", fm);
	}

	public EgovMap selectRequestProcessStat(String today,RequestFm fm) throws Exception {
		logT.debug("START");
		fm.setSearchManagerMixesList(CommonUtil.makeValidIdList(fm.getSearchManagerMixes()));
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("weekStart", fm.getSearchDateFrom());
//		map.put("weekEnd", fm.getSearchDateTo());
//		map.put("searchManagerMixesList", fm.getSearchManagerMixesList());
//		map.put("year", today.substring(0, 4));
		return (EgovMap)selectByPk("KmsRequestDAO.selectRequestProcessStat", fm);
	}
	
	public EgovMap selectRequestProcessPlan(String today, MemberVO user, int weekChk) throws Exception {
		logT.debug("START");
		CalendarUtil cu = new CalendarUtil();
		String weekStart = cu.getFirstDateOfThisWeek2(today);
		String weekEnd = cu.getLastDateOfThisWeek2(today);
		String nextOneMonth = cu.getDate(today, "MONTH", 1);
		String nextTwoMonth = cu.getDate(today, "MONTH", 2);

		
		logT.debug("weekStart : " + weekStart);
		logT.debug("weekEnd : " + weekEnd);
		logT.debug("nextOneMonth : " + nextOneMonth);
		logT.debug("nextTwoMonth : " + nextTwoMonth);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("today", today);
		map.put("weekStart", weekStart);
		map.put("weekEnd", weekEnd);
		map.put("thisMonth", today.substring(0, 6));
		map.put("nextMonth", nextOneMonth.substring(0, 6));

		map.put("userNo", user.getUserNo());
		map.put("weekChk", weekChk);
		return (EgovMap)selectByPk("KmsRequestDAO.selectRequestProcessPlan", map);
	}
	
	///////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////
	// 작업 관련 메소드
	// 작업을 추가한다.
	public void insertReqTask(ReqTaskVO vo) throws Exception {
		insert("KmsRequestDAO.insertReqTask", vo);
	}

	// 한개의 요구사항 작업 내용을 조회한다.
	public ReqTaskVO getReqTask(Integer no) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);

		return (ReqTaskVO)selectByPk("KmsRequestDAO.getReqTask", map);
	}

	// 요구사항 작업을 수정한다.
	public void updateReqTask(ReqTaskVO vo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", vo.getNo());
		map.put("title", vo.getTitle());
		map.put("contents", vo.getContents());
		map.put("status", vo.getStatus());
		map.put("taskType", vo.getTaskType());
		map.put("priority", vo.getPriority());

		if((vo.getWorkerMixes() != null) && (vo.getWorkerMixes().length() > 0) ){
			map.put("workerMixes", vo.getWorkerMixes());
		}
		update("KmsRequestDAO.updateReqTask", map);
	}
	
	// 요구사항 작업을 수정한다.
	public void updateReqTaskStatus(ReqTaskVO vo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", vo.getNo());
		map.put("status", vo.getStatus());

		update("KmsRequestDAO.updateReqTaskStatus", map);
	}
	
	// 요구사항 작업 목록을 조회한다.
	public List<ReqTaskVO> selectReqTaskList(int reqNo) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchReqNo", reqNo);
		map.put("searchTaskType", 		0);
		map.put("searchStatus", 			0);
		map.put("searchPriority", 			0);

		return list("KmsRequestDAO.selectReqTaskList", map);
	}
	public List<ReqTaskVO> selectReqTaskList(ReqTaskFm fm) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		if(fm.getSearchReqNo() > 0) {
			map.put("searchReqNo", 			fm.getSearchReqNo());
		}
		map.put("searchTitle", 					fm.getSearchTitle());
		map.put("searchTaskType", 			fm.getSearchTaskType());
		map.put("searchStatus", 				fm.getSearchStatus());
		map.put("searchPriority", 				fm.getSearchPriority());
		map.put("searchWriterMixes", 		fm.getSearchWriterMixes());
		map.put("searchWorkerMixes", 		fm.getSearchWorkerMixes());
		map.put("searchDateFrom", 			fm.getSearchDateFrom());
		map.put("searchDateTo", 				fm.getSearchDateTo());
		map.put("searchFinishDateFrom",		fm.getSearchFinishDateFrom());
		map.put("searchFinishDateTo", 		fm.getSearchFinishDateTo());
		if((fm.getSearchWorkerMixes() != null) && (fm.getSearchWorkerMixes().length() > 0) ){
			map.put("searchWorkerMixesList", 	CommonUtil.makeValidIdList(fm.getSearchWorkerMixes()));
		}
		if((fm.getSearchWriterMixes() != null) && (fm.getSearchWriterMixes().length() > 0) ){
			map.put("searchWorkerMixesList", 	CommonUtil.makeValidIdList(fm.getSearchWriterMixes()));
		}
		map.put("recordCountPerPage", 		fm.getRecordCountPerPage());
		map.put("firstIndex", 					fm.getFirstIndex());

		return list("KmsRequestDAO.selectReqTaskList", map);
	}

	public int selectReqTaskListTotCnt(ReqTaskFm fm) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		if(fm.getSearchReqNo() > 0) {
			map.put("searchReqNo", 			fm.getSearchReqNo());
		}
		map.put("searchTitle", 					fm.getSearchTitle());
		map.put("searchTaskType", 			fm.getSearchTaskType());
		map.put("searchStatus", 				fm.getSearchStatus());
		map.put("searchPriority", 				fm.getSearchPriority());
		map.put("searchWriterMixes", 		fm.getSearchWriterMixes());
		map.put("searchWorkerMixes", 		fm.getSearchWorkerMixes());
		map.put("searchDateFrom", 			fm.getSearchDateFrom());
		map.put("searchDateTo", 				fm.getSearchDateTo());
		map.put("searchFinishDateFrom",		fm.getSearchFinishDateFrom());
		map.put("searchFinishDateTo", 		fm.getSearchFinishDateTo());
		if((fm.getSearchWorkerMixes() != null) && (fm.getSearchWorkerMixes().length() > 0) ){
			map.put("searchWorkerMixesList", 	CommonUtil.makeValidIdList(fm.getSearchWorkerMixes()));
		}
		if((fm.getSearchWriterMixes() != null) && (fm.getSearchWriterMixes().length() > 0) ){
			map.put("searchWorkerMixesList", 	CommonUtil.makeValidIdList(fm.getSearchWriterMixes()));
		}

		return (Integer)getSqlMapClientTemplate().queryForObject("KmsRequestDAO.selectReqTaskListTotCnt", map);
	}

	// 내가 처리해야하는 요구사항 작업 목록을 조회한다.
	public List<ReqTaskVO> selectMyReqTaskList(int workerNo) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("workerNo", workerNo);

		return list("KmsRequestDAO.selectMyReqTaskList", map);
	}

	public List<ReqTaskVO> selectReqTaskStat(ReqTaskFm fm) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchDateFrom", 			fm.getSearchDateFrom());
		map.put("searchDateTo", 				fm.getSearchDateTo());
		if((fm.getSearchWorkerMixes() != null) && (fm.getSearchWorkerMixes().length() > 0) ){
			map.put("searchWorkerMixesList", 	CommonUtil.makeValidIdList(fm.getSearchWorkerMixes()));
		}

		return list("KmsRequestDAO.selectReqTaskStat", map);
	}
	///////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////
	// 요구사항 검토 관련 메소드
	// 요구사항 검토내용을 추가한다.
	public void insertReview(ReviewVO vo) throws Exception {
		insert("KmsRequestDAO.insertReview", vo);
	}

	// 한개의 요구사항 검토내용 내용을 조회한다.
	public ReviewVO getReview(Integer no) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);

		return (ReviewVO)selectByPk("KmsRequestDAO.getReview", map);
	}

	// 요구사항 검토내용을 수정한다.
	public void updateReview(ReviewVO vo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", vo.getNo());
		map.put("contents", vo.getContents());
		update("KmsRequestDAO.updateReview", map);
	}
	
	// 요구사항 검토내용 목록을 조회한다.
	public List<ReviewVO> selectReviewList(int reqNo) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchReqNo", reqNo);

		return list("KmsRequestDAO.selectReviewList", map);
	}

	// 요구사항 검토내용을 삭제한다.
	public void deleteReview(int no) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);

		delete("KmsRequestDAO.deleteReview", map);
	}
	
	// 내가 처리해야하는 요구사항 작업 목록을 조회한다.
	public List<RequestDailyVO> selectMyReqDailyList(int workerNo) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("workerNo", workerNo);

		return list("KmsRequestDAO.selectMyDailyTaskList", map);
	}	
}
