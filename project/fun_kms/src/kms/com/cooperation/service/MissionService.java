package kms.com.cooperation.service;

import java.util.List; 

/**
 * @Class Name : MissionService.java
 * @Description : MissionService class
 * @Modification Information
 *
 * @author 김대현
 * @since 2013.08.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MissionService {
	void insertMission(MissionVO missionVO) throws Exception;
	void updateMissionTree(MissionVO missionVO);
	MissionVO selectMission(MissionVO missionVO) throws Exception;
	List<MissionHistoryVO> selectMissionHistoryList(MissionVO missionVO) throws Exception;
	List<MissionVO> selectMissionList(MissionVO missionVO) throws Exception;
	int selectMissionListTotCnt(MissionVO missionVO) throws Exception;
	int selectMissionInCompleteTotCnt(MissionVO missionVO) throws Exception;
	List missionTree(MissionVO missionVO);
	List missionTreeP(MissionVO missionVO);
	void updateMission(MissionVO missionVO) throws Exception;
	void updateMissionPrj(MissionVO missionVO) throws Exception;
	void updateMissionTop(MissionVO missionVO) throws Exception;
	void insertMissionHistory(MissionHistoryVO missionHistoryVO) throws Exception;
}
