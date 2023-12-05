package kms.com.community.service.impl;

import java.util.List;

import kms.com.community.service.Schedule;
import kms.com.community.service.ScheduleVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsScheduleDAO")
public class ScheduleDAO extends EgovAbstractDAO {

	public List<ScheduleVO> selectScheduleList(ScheduleVO vo) {
		return list("scheduleDAO.selectScheduleList", vo);
	}

	public void addSchedule(Schedule schedule) {
		insert("scheduleDAO.addSchedule", schedule);
	}

	public ScheduleVO selectSchedule(ScheduleVO searchVO) {
		return (ScheduleVO)selectByPk("scheduleDAO.selectSchedule", searchVO);
	}

	public void deleteSchedule(ScheduleVO searchVO) {
		update("scheduleDAO.deleteSchedule", searchVO);
	}

	public void updateSchedule(Schedule schedule) {
		update("scheduleDAO.updateSchedule", schedule);
	}

	public List<ScheduleVO> selectHolidayList(ScheduleVO searchVO) {
		return list("scheduleDAO.selectHolidayList", searchVO);
	}

	public List<ScheduleVO> selectScheduleListStatusBoard(ScheduleVO scVO) {
		return list("scheduleDAO.selectScheduleListStatusBoard", scVO);
	}

}
