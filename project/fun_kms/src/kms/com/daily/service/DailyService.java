package kms.com.daily.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONValue;
import org.json.simple.JSONObject;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.daily.fm.*;
import kms.com.daily.vo.*;
import kms.com.fund.dao.InvoiceDAO;
import kms.com.daily.dao.DailyDAO;


@Service("KmsDailyService")
public class DailyService {
	Logger logT = Logger.getLogger("TENY");
	
	@Resource(name="KmsDailyDAO")
	private DailyDAO dailyDAO;

	// TENY_170409 
	public List <DailyPlanVO> selectDailyWeekList(int writerNo, String atDate)  throws Exception {
		
		List <DailyPlanVO> dailyVOList = dailyDAO.selectDailyPlanList(writerNo, 
				CalendarUtil.getLastDateOfThisWeek2(atDate, -1), CalendarUtil.getSatDateOfThisWeek(atDate, 0));
		List <DailyResultVO> projectVOList = dailyDAO.selectDailyResultList(writerNo, 
				CalendarUtil.getLastDateOfThisWeek2(atDate, -1), CalendarUtil.getSatDateOfThisWeek(atDate, 0));
		
		//for-loop 통한 전체 조회 
		List <DailyPlanVO> weekPlanList = new ArrayList();
		String writeDate = CalendarUtil.getLastDateOfThisWeek2(atDate, -1);
		boolean find = false;
		for(int i = 0; i < 7; i++) {
			for(DailyPlanVO vo : dailyVOList) {
				if(vo.getWriteDate().equals(writeDate)) {
					vo.setWriteDay( CalendarUtil.getDay(vo.getWriteDate(), "") );
					for(DailyResultVO pvo : projectVOList) {
						if(vo.getWriteDate().equals(pvo.getWriteDate())) {
							vo.getDailyResultVOList().add(pvo);
						}
					}
					weekPlanList.add(vo);
					find = true;
					break;
				}
			}
			if(!find){
				DailyPlanVO tmpVO = new DailyPlanVO();
				tmpVO.setWriterNo(writerNo);
				tmpVO.setWriteDate(writeDate);
				tmpVO.setWriteDay( CalendarUtil.getDay(tmpVO.getWriteDate(), "") );
				for(DailyResultVO pvo : projectVOList) {
					if(tmpVO.getWriteDate().equals(pvo.getWriteDate())) {
						tmpVO.getDailyResultVOList().add(pvo);
					}
				}
				weekPlanList.add(tmpVO);
			}
			writeDate = CalendarUtil.getDate(writeDate, 1);
			find = false;
		}
		return weekPlanList;
	}
	
	// TENY_170419 
	public List <DailyPlanVO> selectDailyListOrg(String orgnztId, String atDate)  throws Exception {
		
		List <DailyPlanVO> dailyVOList = dailyDAO.selectDailyPlanListOrg(orgnztId, atDate);
		List <DailyResultVO> projectVOList = dailyDAO.selectDailyResultListOrg(orgnztId, atDate);
		
		// for-loop 통한 전체 조회 
		for(DailyPlanVO vo : dailyVOList) {
			for(DailyResultVO pvo : projectVOList) {
				if(vo.getWriterNo() == pvo.getWriterNo()) {
					vo.getDailyResultVOList().add(pvo);
				}
			}
		}
		return dailyVOList;
	}
	
	public boolean insertDailyResult(DailyResultFm fm) throws Exception {
		logT.debug("START");

		dailyDAO.deleteDailyResult(fm.getWriterNo(), fm.getWriteDate());  // 일단 다 지우고 저장한다. 비록 없더라도 ^^
		
		String projectInputs = CommonUtil.unescape(fm.getJsonResultInputs());
		JSONArray projectInputsJA = (JSONArray)JSONValue.parseWithException(projectInputs);
		Iterator it = projectInputsJA.iterator();
		while(it.hasNext()) {
			JSONObject jo = (JSONObject)it.next();
			jo.put("writerNo", fm.getWriterNo());
			jo.put("writeDate", fm.getWriteDate());
			dailyDAO.insertDailyResultJO(jo);
		}
		
		return true;
	}

	public boolean migrateDailyPlan(int writerNo, String fromDate, String toDate) throws Exception {
		logT.debug("START");

		int moveDate = 0;
		String curDate;
		while(moveDate < 1000) {
			curDate = CalendarUtil.getDate(fromDate, moveDate);
			if(curDate.compareTo(toDate) > 0) { 
				break;
			}
			if(CalendarUtil.getDay(curDate) == 1){ // 일요일은 업무계획을 만들지 않느다.
				moveDate++;
				continue;
			}
			if(CalendarUtil.getDay(curDate) == 7){ // 토요일은 업무계획을 만들지 않느다.
				moveDate = moveDate + 2;
				continue;
			}
			List <DailyPlanVO> dailyTaskVOList = dailyDAO.selectDailyTaskList(writerNo, curDate);
			if(dailyTaskVOList.size() > 0) {
				StringBuffer contents = new StringBuffer();
				for(DailyPlanVO vo : dailyTaskVOList) {
					contents.append("# ").append(vo.getProjectName()).append("\n  + ").append(vo.getTaskSubject()).append("\n");
					contents.append(vo.getTaskContents()).append("\n");
				}
				DailyPlanVO vo = new DailyPlanVO();
				vo.setWriterNo(writerNo);
				vo.setWriteDate(curDate);
				vo.setContents(contents.toString());
				
				dailyDAO.insertDailyPlan(vo);
				logT.warn("Good in dailyDAO.insertDailyPlan()");
			}
			moveDate++;
		}
		
		return true;
	}
}