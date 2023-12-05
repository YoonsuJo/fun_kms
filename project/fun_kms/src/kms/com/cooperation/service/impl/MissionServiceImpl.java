package kms.com.cooperation.service.impl;

import java.util.List;

import javax.annotation.Resource;

import kms.com.cooperation.service.MissionHistoryVO;
import kms.com.cooperation.service.MissionService;
import kms.com.cooperation.service.MissionVO;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;

//2013.08.20 김대현 미션클리어

@Service("KmsMissionService")
public class MissionServiceImpl implements MissionService {

	@Resource(name = "KmsMissionDAO")
	private MissionDAO missionDAO;
	
	@Resource(name = "kmsMissionIdGnrService")
	private EgovIdGnrService idGnrService;
	
	

	@Override
	public void insertMission(MissionVO missionVO) throws Exception {
		missionDAO.insertMission(missionVO);
	}


	@Override
	public MissionVO selectMission(MissionVO missionVO) throws Exception {
		MissionVO result = missionDAO.selectMission(missionVO);
			return result;
	}
	
	@Override
	public List<MissionHistoryVO> selectMissionHistoryList(MissionVO missionVO) throws Exception {
		return missionDAO.selectMissionHistoryList(missionVO);
		
	}
	
	@Override
	public List<MissionVO> selectMissionList(MissionVO missionVO) throws Exception {
		return missionDAO.selectMissionList(missionVO);
	}

	@Override
	public int selectMissionListTotCnt(MissionVO missionVO) throws Exception {
		return missionDAO.selectMissionListTotCnt(missionVO);
	}

	@Override
	public int selectMissionInCompleteTotCnt(MissionVO missionVO) throws Exception {
		return missionDAO.selectMissionInCompleteTotCnt(missionVO);
	}
	
		
	@Override
	public void updateMissionTree(MissionVO missionVO) {
		missionDAO.updateMissionTree(missionVO);
	}
	
	@Override
	public List missionTree(MissionVO missionVO) {
		return missionDAO.missionTree(missionVO);
	}
	
	@Override
	public List missionTreeP(MissionVO missionVO) {
		return missionDAO.missionTreeP(missionVO);
	}

	@Override
	public void updateMission(MissionVO missionVO) throws Exception {
		missionDAO.updateMission(missionVO);
	}
	
	@Override
	public void updateMissionPrj(MissionVO missionVO) throws Exception {
		missionDAO.updateMissionPrj(missionVO);
	}
	
	@Override
	public void updateMissionTop(MissionVO missionVO) throws Exception {
		missionDAO.updateMissionTop(missionVO);
	}
	
	@Override
	public void insertMissionHistory(MissionHistoryVO missionHistoryVO) throws Exception {
		missionDAO.insertMissionHistory(missionHistoryVO);
	}
}
