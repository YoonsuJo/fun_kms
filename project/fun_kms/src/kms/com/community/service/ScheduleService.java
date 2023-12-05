package kms.com.community.service;

import java.util.List;
import java.util.Map;

public interface ScheduleService {
	List<CalendarVO> getCalendar(ScheduleVO vo) throws Exception;

	Map<String, Object> selectScheduleList(ScheduleVO searchVO) throws Exception;

	void addSchedule(Schedule schedule) throws Exception;

	ScheduleVO selectSchedule(ScheduleVO searchVO) throws Exception;

	void deleteSchedule(ScheduleVO searchVO) throws Exception;

	void updateSchedule(Schedule schedule) throws Exception;

	List<ScheduleVO> selectHolidayList(ScheduleVO searchVO) throws Exception;

	List<ScheduleVO> selectScheduleListStatusBoard(ScheduleVO scVO) throws Exception;

}
