package kms.com.common.timer;

import com.ibm.icu.util.Calendar;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

public class DayReportTest {
	
	Map<String, Object> testDate = new HashMap<String, Object>();
	
	@Before
	public void setUp() throws Exception {
		testDate.put("20150309", 0);
		testDate.put("20150310", 0);
		testDate.put("20150311", 0);
		testDate.put("20150312", 0);
		testDate.put("20150313", 1);
		
		testDate.put("20150216", 0);
		testDate.put("20150217", 0);
		testDate.put("20150218", 1);
		testDate.put("20150219", 1);
		testDate.put("20150220", 1);
	}
	
	@Test
	public void test() throws Exception {
		// 오늘이 금요일인 경우에만 실행
		Calendar oCalendar = Calendar.getInstance();
		//oCalendar.add(Calendar.DATE, 1);	// 2015년 3월 13일
		//oCalendar.add(Calendar.DATE, -20);	// 2015년 2월 20일
		oCalendar.add(Calendar.DATE, -23);	// 2015년 2월 17일
		if (isLastWorkDayInaWeek(oCalendar)) {
			System.out.println("오늘은 이번주 마지막날");
		} else {
			System.out.println("오늘은 이번주 마지막날 아님");
		}
	}
	
	/**
	 * 검색 날짜가 해당 주간의 마지막 Workday(일하는날) 인지 판별
	 * @param cal
	 * @return
	 */
	private boolean isLastWorkDayInaWeek(Calendar cal) {
		
		int today = cal.get(Calendar.DAY_OF_WEEK);
		String month = String.valueOf(cal.get(Calendar.MONTH)+1);
		String day = String.valueOf(cal.get(Calendar.DATE));
		String todayStr = String.valueOf(cal.get(Calendar.YEAR))
				+ ((month.length()==1) ? "0"+month: month)
				+ ((day.length()==1) ? "0"+day: day);
		
		// 금요일 날짜로 셋팅
		Calendar compCal = (Calendar)cal.clone();
		compCal.add(Calendar.DATE, 6 - cal.get(Calendar.DAY_OF_WEEK));
		String searchDate = "";
		
		// 금요일부터 차례로 탐색
		for (int i=0; i < 5; i++) {
			compCal.add(Calendar.DATE, -i);
			month = String.valueOf(compCal.get(Calendar.MONTH)+1);
			day = String.valueOf(compCal.get(Calendar.DATE));
			searchDate = String.valueOf(compCal.get(Calendar.YEAR))
					+ ((month.length()==1) ? "0"+month: month)
					+ ((day.length()==1) ? "0"+day: day);
			
			// 판별 휴일 여부 판별(휴일인 경우)
			if ((Integer)testDate.get(searchDate)==0) break;
		}
		
		if (todayStr.equals(searchDate))
			return true;
		else
			return false;
	}
	
	/*
		System.out.println(cal.get(Calendar.YEAR));
		System.out.println(cal.get(Calendar.MONTH)+1);
		System.out.println(cal.get(Calendar.DATE));
		System.out.println(cal.get(Calendar.DAY_OF_WEEK));
		cal.add(Calendar.DATE, -3);
	 */
}
