package kms.com.member.service.impl;

import java.util.List;

import kms.com.member.service.WorkState;
import kms.com.member.service.WorkStateDetail;
import kms.com.member.service.WorkStateStatistic;
import kms.com.member.service.WorkStateVO;

import org.springframework.stereotype.Repository;

import com.sun.star.uno.Exception;

import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("KmsWorkStateDAO")
public class WorkStateDAO extends EgovAbstractDAO {

	public List<WorkStateVO> selectAbsenceList(WorkStateVO absenceVO) {
		return list("WorkStateDAO.selectAbsenceList", absenceVO);
	}

	public List<EgovMap> selectAbsenceState(WorkStateVO absenceVO) {
		return list("WorkStateDAO.selectAbsenceState", absenceVO);
	}
	
	public List<WorkStateVO> selectAbsenceListAll(WorkStateVO absenceVO) {
		return list("WorkStateDAO.selectAbsenceListAll", absenceVO);
	}

	public List<EgovMap> selectAbsenceStateAll(WorkStateVO absenceVO) {
		return list("WorkStateDAO.selectAbsenceStateAll", absenceVO);
	}

	public void insertWorkState(WorkState absence) {
		insert("WorkStateDAO.insertWorkState", absence);
	}
	
	public void insertWorkStateTypeN(WorkState absence) {
		insert("WorkStateDAO.insertWorkStateTypeN", absence);
	}

	public void updateWorkState(WorkState absence) {
		update("WorkStateDAO.updateWorkState", absence);
	}
	
	public int checkExistAbsentData(WorkState absenceVO) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("WorkStateDAO.checkExistAbsentData", absenceVO);
    }
	
	public String selectExistAbsentDataWsId(WorkState absenceVO) throws Exception {
		return (String)getSqlMapClientTemplate().queryForObject("WorkStateDAO.selectExistAbsentDataWsId", absenceVO);
    }

	public WorkStateVO selectWorkState(WorkStateVO absenceVO) {
		return (WorkStateVO)selectByPk("WorkStateDAO.selectWorkState", absenceVO);
	}
	
	public WorkStateVO selectWorkStateByDocId(WorkStateVO absenceVO) {
		return (WorkStateVO)selectByPk("WorkStateDAO.selectWorkStateByDocId", absenceVO);
	}

	public void deleteWorkState(WorkStateVO absenceVO) {
		update("WorkStateDAO.deleteWorkState", absenceVO);
	}
	
	public void deleteWorkStateByDocId(WorkStateVO absenceVO) {
		update("WorkStateDAO.deleteWorkStateByDocId", absenceVO); //xml 미구현상태
	}	

	public List<EgovMap> selectOvertimeList(WorkStateVO searchVO) {
		return list("WorkStateDAO.selectOvertimeList", searchVO);
	}

	public EgovMap selectOvertime(WorkStateVO searchVO) {
		return (EgovMap)selectByPk("WorkStateDAO.selectOvertime", searchVO);
	}
	
	public List<WorkStateVO> selectOvertimeDetailList(WorkStateVO searchVO) {
		return list("WorkStateDAO.selectOvertimeDetailList", searchVO);
	}

	public EgovMap selectOvertimeListSum(WorkStateVO searchVO) {
		return (EgovMap)selectByPk("WorkStateDAO.selectOvertimeListSum", searchVO);
	}

	public WorkStateStatistic selectDailyWorkStateStatistic(WorkStateStatistic searchVO) {
		return (WorkStateStatistic)selectByPk("WorkStateDAO.selectDailyWorkStateStatistic", searchVO);
	}

	public List<WorkStateDetail> selectDailyWorkStateDetail(WorkStateDetail wsDetail) {
		return list("WorkStateDAO.selectDailyWorkStateDetail", wsDetail);
	}
	
	public List<WorkStateDetail> selectAbsenceStateDatail(WorkStateDetail wsDetail) {
		return list("WorkStateDAO.selectAbsenceStateDatail", wsDetail);
	}
	
	public List<WorkStateStatistic> selectWorkStateStatistic(WorkStateStatistic searchVO) {
		return list("WorkStateDAO.selectWorkStateStatistic", searchVO);
	}
	
	public List<WorkStateDetail> selectWorkStateDetail(WorkStateStatistic searchVO) {
		return list("WorkStateDAO.selectWorkStateDetail", searchVO);
	}
	

}
