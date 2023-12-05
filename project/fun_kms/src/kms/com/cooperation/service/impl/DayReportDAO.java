package kms.com.cooperation.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.cooperation.service.DayReport;
import kms.com.cooperation.service.DayReportDetail;
import kms.com.cooperation.service.DayReportVO;
import kms.com.cooperation.service.Task;
import kms.com.cooperation.service.TaskContent;
import kms.com.cooperation.service.TaskVO;

@Repository("KmsDayReportDAO")
public class DayReportDAO extends EgovAbstractDAO {

	public List<TaskVO> selectTaskList(Map<String, Object> param) {
		return list("DayReportDAO.selectTaskList", param);
	}

	public List<DayReport> selectDayReportList(Map<String, Object> param) {
		return list("DayReportDAO.selectDayReportList", param);
	}

	//나의 업무 S
	public List<DayReport> selectDayReportMyList(Map<String, Object> param) {
		return list("DayReportDAO.selectDayReportMyList", param);
	}
	
	public int selectDayReportMyListTotCnt(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("DayReportDAO.selectDayReportMyListTotCnt", param);
	}

	public int selectDayReportMyListCompleteTotCnt(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("DayReportDAO.selectDayReportMyListCompleteTotCnt", param);
	}
	
	public List<DayReport> selectDayReportOrderList(DayReportVO param) {
		return list("DayReportDAO.selectDayReportOrderList", param);
	}
	
	public int selectDayReportOrderListTotCnt(DayReportVO param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("DayReportDAO.selectDayReportOrderListTotCnt", param);
	}
	
	public List<TaskVO> selectDayReportMyTList(DayReportVO param) {
		return list("DayReportDAO.selectDayReportMyTList", param);
	}
	
	public List<DayReportVO> selectDayReportMyDList(DayReportVO param) {
		return list("DayReportDAO.selectDayReportMyDList", param);
	}
	
	public int selectDayReportMyTListTotCnt(DayReportVO dayReportVO) {
		// TODO Auto-generated method stub
		return (Integer)getSqlMapClientTemplate().queryForObject("DayReportDAO.selectDayReportMyTListTotCnt", dayReportVO);
	}
	//나의 업무 E
	
	public List<EgovMap> selectDayReportUserList(DayReportVO param) {
		return list("DayReportDAO.selectDayReportUserList", param);
	}
	//////////////////////////////////////////
	public List<EgovMap> selectDayReportUserList1(DayReportVO param) {
		return list("DayReportDAO.selectDayReportUserList1", param);
	}
	public List<EgovMap> selectDayReportUserList2(DayReportVO param) {
		return list("DayReportDAO.selectDayReportUserList2", param);
	}
	//////////////////////////////////////////
	
	public TaskVO selectTask(Map<String, Object> param) {
		return (TaskVO)selectByPk("DayReportDAO.selectTask", param);
	}

	public List<Task> selectTaskHistoryList(Map<String, Object> param) {
		return list("DayReportDAO.selectTaskHistoryList", param);
	}
	
	public List<TaskContent> selectTaskContentList(Map<String, Object> param) {
		return list("DayReportDAO.selectTaskContentList", param);
	}

	public void insertTask(Task task) {
		insert("DayReportDAO.insertTask", task);
	}

	public void updateTask(Task task) {
		update("DayReportDAO.updateTask", task);
	}

	public void updateTaskState(Task task) {
		update("DayReportDAO.updateTaskState", task);
	}

	public void insertTaskStateHistory(Task task) {
		insert("DayReportDAO.insertTaskStateHistory", task);
	}

	
	
	public void deleteTask(Task task) {
		delete("DayReportDAO.deleteTask", task);
	}

	public DayReport selectDayReport(Map<String, Object> param) {
		return (DayReport)selectByPk("DayReportDAO.selectDayReport", param);
	}
	
	public int insertDayReport(DayReport dayReport) {
		insert("DayReportDAO.insertDayReport", dayReport);
		return dayReport.getNo();
	}

	public void updateDayReport(DayReport dayReport) {
		update("DayReportDAO.updateDayReport", dayReport);
	}
	
	public void updateDayReportTotalTm(DayReport dayReport) {
		update("DayReportDAO.updateDayReportTotalTm", dayReport);
	}

	public void deleteDayReport(DayReport dayReport) {
		delete("DayReportDAO.deleteDayReport", dayReport);
	}
	
	public void insertTaskContent(TaskContent taskContent) {
		insert("DayReportDAO.insertTaskContent", taskContent);		
	}
	
	public void updateTaskContent(TaskContent taskContent) {
		update("DayReportDAO.updateTaskContent", taskContent);
	}
	
	public void deleteTaskContent(TaskContent taskContent) {
		delete("DayReportDAO.deleteTaskContent", taskContent);
	}

	public List<DayReportVO> searchDayReportList(DayReportVO dayReportVO) {
		return list("DayReportDAO.searchDayReportList", dayReportVO);
	}

	public int searchDayReportListTotCnt(DayReportVO dayReportVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("DayReportDAO.searchDayReportListTotCnt", dayReportVO);
	}

	public List<Integer> selectLeftTime(Map<String, Object> param) {
		return list("DayReportDAO.selectLeftTime", param);
	}

	public List<Task> selectTaskListByPrjId(Map<String, Object> param) {
		return list("DayReportDAO.selectTaskListByPrjId", param);
	}

	public int selectTaskListByPrjIdTotCnt(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("DayReportDAO.selectTaskListByPrjIdTotCnt", param);
	}
	
	public List<Task> selectPostTaskList(Map<String, Object> param) {
		return list("DayReportDAO.selectPostTaskList", param);
	}

	public List<EgovMap> selectDayReportTmSum(Map<String, Object> param) {
		return list("DayReportDAO.selectDayReportTmSum", param);
	}
	
	/**
	 * 팀장별 나의 업무 미작성 인력 목록 추출
	 */
	public List<EgovMap> selectNoInputList(Map<String, Object> param) {
		return list("DayReportDAO.selectNoInputList", param);
	}


}
