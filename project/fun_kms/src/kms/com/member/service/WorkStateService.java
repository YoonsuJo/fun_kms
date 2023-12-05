package kms.com.member.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface WorkStateService {

	Map<String, Object> selectAbsenceState(WorkStateVO absenceVO) throws Exception;

	Map<String, Object> selectAbsenceStateAll(WorkStateVO absenceVO) throws Exception;
	
	List<WorkStateVO>  selectAbsenceStateMember(WorkStateVO absenceVO) throws Exception;

	void insertWorkState(WorkState absence) throws Exception;
	
	int checkExistAbsentData(WorkState absence) throws Exception;
	
	String selectExistAbsentDataWsId(WorkState absence) throws Exception;
	
	WorkStateVO selectWorkState(WorkStateVO absenceVO) throws Exception;
	
	WorkStateVO selectWorkStateByDocId(WorkStateVO absenceVO) throws Exception;
	
	void updateWorkState(WorkState absence) throws Exception;

	void deleteWorkState(WorkStateVO absenceVO) throws Exception;
	
	void deleteWorkStateByDocId(WorkStateVO absenceVO) throws Exception;
	
	void deleteWorkStateUpdatePastAttendCheck(WorkStateVO absenceVO) throws Exception;
	
	List<EgovMap> selectOvertimeList(WorkStateVO searchVO) throws Exception;

	EgovMap selectOvertime(WorkStateVO searchVO) throws Exception;
	
	List<WorkStateVO> selectOvertimeDetailList(WorkStateVO searchVO) throws Exception;

	EgovMap selectOvertimeListSum(WorkStateVO searchVO) throws Exception;

	WorkStateStatistic selectDailyWorkStateStatistic(WorkStateStatistic searchVO) throws Exception;

	List<WorkStateDetail> selectDailyWorkStateDetail(WorkStateDetail wsDetail) throws Exception;
	
	List<WorkStateDetail> selectAbsenceStateDatail(WorkStateDetail wsDetail) throws Exception;

	List<WorkStateStatistic> selectWorkStateStatistic(WorkStateStatistic searchVO) throws Exception;

	List<WorkStateDetail> selectWorkStateDetail(WorkStateStatistic searchVO) throws Exception;


}
