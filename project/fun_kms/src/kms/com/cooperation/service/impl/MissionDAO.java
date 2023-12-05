package kms.com.cooperation.service.impl;

import java.util.List;

import kms.com.cooperation.service.Mission;
import kms.com.cooperation.service.MissionHistoryVO;
import kms.com.cooperation.service.MissionVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

// 2013.08.20 김대현 미션클리어

@Repository("KmsMissionDAO")
public class MissionDAO extends EgovAbstractDAO {


	public void insertMission(Mission mission) {
		insert("MissionDAO.insertMission", mission);
	}

	public MissionVO selectMission(MissionVO missionVO) {
		// TODO Auto-generated method stub
		return (MissionVO)selectByPk("MissionDAO.selectMission", missionVO);
	}
	
	public List<MissionHistoryVO> selectMissionHistoryList(MissionVO missionVO) {
		// TODO Auto-generated method stub
		return list("MissionDAO.selectMissionHistoryList", missionVO);
	}
	
	public List<MissionVO> selectMissionList(MissionVO missionVO) {
		return list("MissionDAO.selectMissionList", missionVO);
	}
	
	public int selectMissionListTotCnt(MissionVO missionVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MissionDAO.selectMissionListTotCnt", missionVO);
	}
	
	
	public int selectMissionInCompleteTotCnt(MissionVO missionVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MissionDAO.selectMissionInCompleteTotCnt", missionVO);
	}
	
	public void updateMissionTree(MissionVO missionVO) {
		update("MissionDAO.updateMissionTree",missionVO);
		
	}

	public List missionTree(MissionVO missionVO) {
		return list("MissionDAO.missionTree", missionVO);		
	}
	
	public List missionTreeP(MissionVO missionVO) {
		return list("MissionDAO.missionTreeP", missionVO);		
	}
	
	public void updateMission(MissionVO missionVO) {
		update("MissionDAO.updateMission", missionVO);
	}
	
	public void updateMissionPrj(MissionVO missionVO) {
		update("MissionDAO.updateMissionPrj", missionVO);
	}
	
	public void updateMissionTop(MissionVO missionVO) {
		update("MissionDAO.updateMissionTop", missionVO);
	}
	
	public void insertMissionHistory(MissionHistoryVO missionHistoryVO) {
		insert("MissionDAO.insertMissionHistory", missionHistoryVO);
	}
}
