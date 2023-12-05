package kms.com.cooperation.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface DayReportService {
	Map<String, Object> selectDayReportBrief(Map<String, Object> param) throws Exception;
	List<DayReportDetail> selectDayReportDetail(Map<String, Object> param) throws Exception;
	
	//나의 업무 S
	List<DayReport> selectDayReportMyList(Map<String, Object> param) throws Exception;
	int selectDayReportMyListTotCnt(Map<String, Object> param) throws Exception;
	int selectDayReportMyListCompleteTotCnt(Map<String, Object> param) throws Exception;
	
	List<DayReport> selectDayReportOrderList(DayReportVO param) throws Exception;
	int selectDayReportOrderListTotCnt(DayReportVO param) throws Exception;

	
	
	

	List<TaskVO> selectDayReportMyDList(DayReportVO param) throws Exception;
	//List<DayReportVO> selectDayReportMyDList(DayReportVO param) throws Exception;
	int selectDayReportMyTListTotCnt(DayReportVO dayReportVO) throws Exception;
	
	

	//나의 업무 E
	
	List<DayReportDetail> selectDayReportDetailUser(Map<String, Object> param) throws Exception;	
	TaskVO selectTaskInfo(Map<String, Object> param) throws Exception;
	
	List<Task> selectTaskHistoryList(Map<String, Object> param) throws Exception;
	
	
	List<TaskVO> selectTaskList(Map<String, Object> param) throws Exception;
	
	List<DayReport> selectDayReportList(Map<String, Object> param) throws Exception;
	List<EgovMap> selectDayReportUserList(DayReportVO param) throws Exception;
	//////////////////////////
	List<EgovMap> selectDayReportUserList1(DayReportVO param) throws Exception;
	List<EgovMap> selectDayReportUserList2(DayReportVO param) throws Exception;
	/////////////////////////
	
	String insertTask(Task task) throws Exception;
	void updateTask(Task task) throws Exception;
	
	void updateTaskState(Task task) throws Exception;
	String insertTaskStateHistory(Task task) throws Exception;
	
	void deleteTask(Task task) throws Exception;

	DayReport selectDayReport(Map<String, Object> param) throws Exception;
	void insertDayReport(List<DayReport> dayReportList) throws Exception;
	void insertDayReport(DayReport dayReport) throws Exception;
	void updateDayReport(DayReport dayReport) throws Exception;
	void updateDayReportTotalTm(DayReport dayReport) throws Exception;
	void deleteDayReport(DayReport dayReport) throws Exception;
	
	void insertTaskContent(TaskContent taskContent) throws Exception;
	void updateTaskContent(TaskContent taskContent) throws Exception;
	void deleteTaskContent(TaskContent taskContent) throws Exception;
	
	List<DayReportVO> searchDayReportList(DayReportVO dayReportVO) throws Exception;
	int searchDayReportListTotCnt(DayReportVO dayReportVO) throws Exception;
	
	List<Task> selectTaskListByPrjId(Map<String, Object> param) throws Exception;
	int selectTaskListByPrjIdTotCnt(Map<String, Object> param) throws Exception;

	List<Task> selectPostTaskList(Map<String, Object> param) throws Exception;
	
	List<EgovMap> selectDayReportTmSum(Map<String, Object> param) throws Exception;

	/**
	 * 팀장별 나의 업무 미작성 인력 목록 추출
	 */
	List<EgovMap> selectNoInputList(Map<String, Object> param) throws Exception;

}
