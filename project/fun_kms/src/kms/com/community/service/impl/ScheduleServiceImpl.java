package kms.com.community.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import kms.com.common.utils.CalendarUtil;
import kms.com.community.service.CalendarVO;
import kms.com.community.service.Schedule;
import kms.com.community.service.ScheduleService;
import kms.com.community.service.ScheduleVO;

@Service("KmsScheduleService")
public class ScheduleServiceImpl implements ScheduleService {

    /** ID Generation */
    @Resource(name="kmsScheduleIdGnrService")    
    private EgovIdGnrService idGnrService;
    
    @Resource(name="KmsScheduleDAO")
    private ScheduleDAO scheduleDAO;
    
    
	@Override
	public List<CalendarVO> getCalendar(ScheduleVO vo) throws Exception {
		int lastDate = CalendarUtil.getLastDateOfMonth(vo.getScheYear(), vo.getScheMonth());
		
		List<CalendarVO> result = new ArrayList<CalendarVO>();
		
		List<ScheduleVO> scheduleList = scheduleDAO.selectScheduleList(vo);

		for (int i=1; i<=lastDate; i++) {
			String dd = (i<10) ? "0" + i : String.valueOf(i);
			
			CalendarVO calendarVO = new CalendarVO(vo.getScheYear(), vo.getScheMonth(), dd);

			for (int j=0; j<scheduleList.size(); j++) {
				ScheduleVO schedule = scheduleList.get(j);
				
				if(schedule.getScheDate().equals(dd)) {
					calendarVO.addScheduleList(schedule);
					
					if (schedule.getScheTyp().equalsIgnoreCase("H") || schedule.getScheTyp().equalsIgnoreCase("I") || schedule.getScheTyp().equalsIgnoreCase("J")) {
						calendarVO.setHoliday(true);
					}
					
					scheduleList.remove(j);
					j--;
				}
			}
			result.add(calendarVO);
		}
		
		
		return result;
	}

	@Override
	public Map<String, Object> selectScheduleList(ScheduleVO searchVO) {
		List<ScheduleVO> list = scheduleDAO.selectScheduleList(searchVO);
		
		List<ScheduleVO> companySchedule = new ArrayList<ScheduleVO>();
		List<ScheduleVO> teamSchedule = new ArrayList<ScheduleVO>();
		List<ScheduleVO> privateSchedule = new ArrayList<ScheduleVO>();
		List<ScheduleVO> holiday = new ArrayList<ScheduleVO>();
		
		for (int i=0; i<list.size(); i++) {
			ScheduleVO tmp = list.get(i);
			
			if (tmp.getScheTyp().equals("C")) {
				companySchedule.add(tmp);
			} else if (tmp.getScheTyp().equals("T")) {
				teamSchedule.add(tmp);
			} else if (tmp.getScheTyp().equals("P")) {
				privateSchedule.add(tmp);
			} else {
				holiday.add(tmp);
			}
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
    	map.put("companySchedule", companySchedule);
    	map.put("teamSchedule", teamSchedule);
    	map.put("privateSchedule", privateSchedule);
    	map.put("holiday", holiday);
		
		return map;
	}

	@Override
	public void addSchedule(Schedule schedule) throws Exception {
		String scheId = idGnrService.getNextStringId();
		schedule.setScheId(scheId);
		
		scheduleDAO.addSchedule(schedule);
	}

	@Override
	public ScheduleVO selectSchedule(ScheduleVO searchVO) throws Exception {
		return scheduleDAO.selectSchedule(searchVO);
	}

	@Override
	public void deleteSchedule(ScheduleVO searchVO) throws Exception {
		scheduleDAO.deleteSchedule(searchVO);
	}

	@Override
	public void updateSchedule(Schedule schedule) throws Exception {
		scheduleDAO.updateSchedule(schedule);
	}

	@Override
	public List<ScheduleVO> selectHolidayList(ScheduleVO searchVO) throws Exception {
		return scheduleDAO.selectHolidayList(searchVO);
	}

	@Override
	public List<ScheduleVO> selectScheduleListStatusBoard(ScheduleVO scVO) throws Exception {
		return scheduleDAO.selectScheduleListStatusBoard(scVO);
	}
}
