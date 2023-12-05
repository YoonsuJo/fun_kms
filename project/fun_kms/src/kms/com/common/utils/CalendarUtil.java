package kms.com.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

public class CalendarUtil {

	static Logger logT = Logger.getLogger("TENY");

	public static String getThisTime() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("yyyy.MM.dd HH:mm:ss");
		return formatter.format(new java.util.Date());
	}
	public static String getThisTimehh() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("yyyy.MM.dd hh:mm:ss");
		return formatter.format(new java.util.Date());
	}
	public static String getToday() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("yyyyMMdd");
		return formatter.format(new java.util.Date());
	}
	public static String getTomorrow() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("yyyyMMdd");
		return getDate(formatter.format(new java.util.Date()), 1);
	}
	public static String getYesterday() {		
		Calendar cal = Calendar.getInstance();
		cal.add(java.util.Calendar.DATE, -1); // 전날
		String yesterday = Integer.toString(cal.get(cal.YEAR) * 10000 + (cal.get(cal.MONTH) + 1) * 100 + cal.get(cal.DAY_OF_MONTH));
		return yesterday;
	}
	public static int getLastYear() {
		GregorianCalendar gc = new GregorianCalendar();
		gc.add(gc.YEAR, -1);
		return gc.get(Calendar.YEAR);
	}
	public static int getLastLastYear() {
		GregorianCalendar gc = new GregorianCalendar();
		gc.add(gc.YEAR, -2);
		return gc.get(Calendar.YEAR);
	}
	public static int getYear() {
		GregorianCalendar gc = new GregorianCalendar();
		return gc.get(Calendar.YEAR);
	}
	public static int getNextYear() {
		GregorianCalendar gc = new GregorianCalendar();
		gc.add(gc.YEAR, 1);
		return gc.get(Calendar.YEAR);
	}
	public static int getMonth() {
		GregorianCalendar gc = new GregorianCalendar();
		return gc.get(Calendar.MONTH)+1;
	}
	
	//일주일 전 날짜
	public static String getSevenDayAgo() {		
		Calendar cal = Calendar.getInstance();
		cal.add(java.util.Calendar.DATE, -7); // 전날
		String sevenDayAgo = Integer.toString(cal.get(cal.YEAR) * 10000 + (cal.get(cal.MONTH) + 1) * 100 + cal.get(cal.DAY_OF_MONTH));
		return sevenDayAgo;
	}
	
	//일주일 후 날짜
	public static String getSevenDayNext() {		
		Calendar cal = Calendar.getInstance();
		cal.add(java.util.Calendar.DATE, +7); // 7일후
		String sevenDayNext = Integer.toString(cal.get(cal.YEAR) * 10000 + (cal.get(cal.MONTH) + 1) * 100 + cal.get(cal.DAY_OF_MONTH));
		return sevenDayNext;
	}
	
	/**
	 * year년 month월의 첫날의 요일을 리턴
	 * @param year : 년
	 * @param month : 월
	 * @return 1일 2월 3화 4수 5목 6금 7토
	 */
	public static int getFirstDayOfMonth(String year, String month) {
		Calendar cal = Calendar.getInstance();
		
		cal.set(Integer.parseInt(year), Integer.parseInt(month)-1, 1); // 이달의 첫날 

		return cal.get(java.util.Calendar.DAY_OF_WEEK);
	}
	
	/**
	 * yyyymmdd 년월일의 요일을 리턴
	 * @param yyyymmdd : 년월일
	 * @return 1일 2월 3화 4수 5목 6금 7토
	 */
	public static int getDay(String yyyymmdd) {
		Calendar cal = Calendar.getInstance();
		if(yyyymmdd!=null){
			String dt = yyyymmdd;
			String y = dt.substring(0,4);
			String m = dt.substring(4,6); 
			if(m.indexOf("0")==0) 
				m = m.substring(1);
			String d = dt.substring(6,8);
			if(d.indexOf("0")==0) 
				d = d.substring(1);

			cal.set(Integer.parseInt(y), Integer.parseInt(m)-1, Integer.parseInt(d));
		}
		return cal.get(java.util.Calendar.DAY_OF_WEEK);
	}
	
	/**
	 * 
	 */
	public static int getLastDateOfMonth(String year, String month){
		Calendar cal = Calendar.getInstance();
		
		cal.set(Integer.parseInt(year), Integer.parseInt(month)-1, 1);
		cal.add(java.util.Calendar.MONTH, 1); // 다음달의 첫날
		cal.add(java.util.Calendar.DATE, -1); // 다음달의 첫날의 하루전 = 이번달의 마지막날

		return cal.get(java.util.Calendar.DATE);
	}
	public static int getLastDateOfMonth(int year, int month){
		Calendar cal = Calendar.getInstance();
		
		cal.set(year, month-1, 1);
		cal.add(java.util.Calendar.MONTH, 1); // 다음달의 첫날
		cal.add(java.util.Calendar.DATE, -1); // 다음달의 첫날의 하루전 = 이번달의 마지막날
		
		return cal.get(java.util.Calendar.DATE);
	}
	public static int getLastDateOfMonth(String yyyymmdd){
		Calendar cal = Calendar.getInstance();
		
		String year = yyyymmdd.substring(0,4);
		String month = yyyymmdd.substring(4,6);
		
		cal.set(Integer.parseInt(year), Integer.parseInt(month)-1, 1);
		cal.add(java.util.Calendar.MONTH, 1); // 다음달의 첫날
		cal.add(java.util.Calendar.DATE, -1); // 다음달의 첫날의 하루전 = 이번달의 마지막날
		
		return cal.get(java.util.Calendar.DATE);
	}

	
	//그 달의 1일 날짜 리턴
	public static String getFirstDayOfMonth(String yyyymmdd) {
		yyyymmdd = yyyymmdd.substring(0,6) + "01";
		return yyyymmdd;
		
	}

	public static String getLastDayOfMonth(String yyyymmdd) {
		Calendar cal = Calendar.getInstance();
		String year = yyyymmdd.substring(0,4);
		String month = yyyymmdd.substring(4,6);
		cal.set(Integer.parseInt(year), Integer.parseInt(month)-1, 1);
		cal.add(java.util.Calendar.MONTH, 1); // 다음달의 첫날
		cal.add(java.util.Calendar.DATE, -1); // 다음달의 첫날의 하루전 = 이번달의 마지막날
		
		String day = Integer.toString(cal.get(java.util.Calendar.DATE));
		 
		yyyymmdd = yyyymmdd.substring(0,6) + day;
		return yyyymmdd;
		
	}

		
	
	public static String getDay(String date, String lang) {
		//date = yyyymmdd;		
		Calendar cal = Calendar.getInstance();
		if(date != null && date.equals("") == false && date.length() == 8){
			cal = getCalendar(date);			
		}
		
		String[] list = {"일","월","화","수","목","금","토"};
		String[] listEng = {"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
		if(lang != null) {
			if(lang.equals("ENG")) {
				list = listEng;
			}
		}
		return list[cal.get(java.util.Calendar.DAY_OF_WEEK)-1];
	}
	
	public static String getFirstDateOfThisWeek(String today) {
		return getFirstDateOfThisWeek(today, 0);
	}
	public static String getFirstDateOfThisWeek2(String today) {
		return getFirstDateOfThisWeek2(today, 0);
	}
	public static String getLastDateOfThisWeek(String today) {
		return getLastDateOfThisWeek(today, 0);
	}
	public static String getLastDateOfThisWeek2(String today) {
		return getLastDateOfThisWeek2(today, 0);
	}
	//이번주 일요일 구하기 
	public static String getFirstDateOfThisWeek(String today, int weekMove) {
		if (today==null) {
			return "";
		}
		Calendar cal = getCalendar(today);
		cal.add(Calendar.DATE, weekMove * 7);
		
		int day = cal.get(java.util.Calendar.DAY_OF_WEEK);
		
		cal.add(Calendar.DATE, - day + 1);
		
		int yyyy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DATE);
		
		return yyyy + (mm < 10 ? "0" + mm : "" + mm) + (dd < 10 ? "0" + dd : "" + dd);
	}
	//이번주 월요일 구하기 
	public static String getFirstDateOfThisWeek2(String today, int weekMove) {
		if (today==null) {
			return "";
		}
		Calendar cal = getCalendar(today);
		cal.add(Calendar.DATE, weekMove * 7);
		//1-7 : 일-토
		int day = cal.get(java.util.Calendar.DAY_OF_WEEK);
		if(day == 1)
			day = 8;
		cal.add(Calendar.DATE, - day + 2);
		
		int yyyy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DATE);
		
		return yyyy + (mm < 10 ? "0" + mm : "" + mm) + (dd < 10 ? "0" + dd : "" + dd);
	}
	public static String getLastDateOfThisWeek(String today, int weekMove) {
		if (today==null) {
			return "";
		}
		Calendar cal = getCalendar(today);
		cal.add(Calendar.DATE, weekMove * 7);
		
		int day = cal.get(java.util.Calendar.DAY_OF_WEEK);
		
		cal.add(Calendar.DATE, - day + 7);
		
		int yyyy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DATE);
		
		return yyyy + (mm < 10 ? "0" + mm : "" + mm) + (dd < 10 ? "0" + dd : "" + dd);
	}
	
	public static String getLastDateOfThisWeek2(String today, int weekMove) {
		if (today==null) {
			return "";
		}
		Calendar cal = getCalendar(today);
		cal.add(Calendar.DATE, weekMove * 7);
		
		int day = cal.get(java.util.Calendar.DAY_OF_WEEK);
		
		logT.debug("day : " + day);
		if(day != 1) {
			cal.add(Calendar.DATE, - day + 8);
		}
		
		int yyyy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DATE);
		
		return yyyy + (mm < 10 ? "0" + mm : "" + mm) + (dd < 10 ? "0" + dd : "" + dd);
	}
	/**
	 * 이번주 토요일 구하기
	 * @param today
	 * @param weekMove
	 * @return
	 */
	public static String getSatDateOfThisWeek(String today, int weekMove) {
		if (today==null) {
			return "";
		}
		Calendar cal = getCalendar(today);
		cal.add(Calendar.DATE, weekMove * 7);
		
		int day = cal.get(java.util.Calendar.DAY_OF_WEEK);
		
		logT.debug("day : " + day);
		if(day != 1) {
			cal.add(Calendar.DATE, - day + 7);
		}
		
		int yyyy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DATE);
		
		return yyyy + (mm < 10 ? "0" + mm : "" + mm) + (dd < 10 ? "0" + dd : "" + dd);
	}	
	
	public static String print(String date, int type) {
		String rtn = "";
		if (type == 1 || type == 2) {
			rtn = date.substring(0,4) + "년 ";
		}
		if (type == 1 || type == 2 || type == 0) {
			rtn += date.substring(4,6) + "월 ";
		}
		if (type == 1 || type == 0) {
			rtn += date.substring(6,8) + "일";
		}
		
		return rtn;
	}
	
	
	public static String getTblCal(String today, int monthMove) {
		if (today==null) {
			return "";
		}
		Calendar cal = getCalendar(today);
		cal.add(Calendar.MONTH, monthMove);
		
		int yyyy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DATE);
		
		return yyyy + (mm < 10 ? "0" + mm : "" + mm) + (dd < 10 ? "0" + dd : "" + dd);
	}
	
	public static String getDate(String today, int dateMove) {
		if (today==null) {
			return "";
		}
		Calendar cal = getCalendar(today);
		cal.add(Calendar.DATE, dateMove);
		
		int yyyy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DATE);
		
		return yyyy + (mm < 10 ? "0" + mm : "" + mm) + (dd < 10 ? "0" + dd : "" + dd);
	}

	public static String getDate(String today, String moveType, int move) {
		
		if (today==null)
			return "";		
		
		Calendar cal = getCalendar(today);
				
		if (moveType.equalsIgnoreCase("MONTH"))
			cal.add(Calendar.MONTH, move);		
		else if (moveType.equalsIgnoreCase("DATE")) 
			cal.add(Calendar.DATE, move);
				
		int yyyy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DATE);
		
		return yyyy + (mm < 10 ? "0" + mm : "" + mm) + (dd < 10 ? "0" + dd : "" + dd);
	}

	public static Object getCurrentTime() {

		Calendar cal = Calendar.getInstance();
		int Hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		
		return Hour + ":" + (minute < 10 ? "0" + minute : minute);
	}
	public static List<Map<String, Object>> getDateList(String sDate) {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		for (int i=0; i<7; i++) {
			Map<String, Object> e = new HashMap<String, Object>();
			e.put("date", getDate(sDate, i));
			e.put("day", getDay(getDate(sDate, i), "KOR"));
			
			resultList.add(e);
		}
		
		return resultList;
	}
	//millisecond 단위 날짜 비교
	public static int getDateDiff(String eDt, String sDt) {
		Calendar cal = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		if(eDt!=null)
			cal = getCalendar(eDt);
		if(sDt!=null)
			cal2 = getCalendar(sDt);
		return cal.compareTo(cal2);
	}
	//여러기능에서 반복적으로 사용되는 Calendar 변수 세팅 루틴
	public static Calendar getCalendar(String date){
		Calendar cal = Calendar.getInstance();
		
		String y = date.substring(0,4);
		String m = date.substring(4,6); 
		if(m.indexOf("0")==0) m = m.substring(1);
		String d = date.substring(6,8);
		if(d.indexOf("0")==0) d = d.substring(1);
		
		cal.set(Integer.parseInt(y), Integer.parseInt(m)-1, Integer.parseInt(d));
		return cal;
	}
	
	public static int getRequestCalCheck(String date){
		SimpleDateFormat formatter = new SimpleDateFormat("yy.MM.dd");
		Date defaultDate = new Date();
		Date strDate = new Date();
		try {
			strDate = formatter.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(defaultDate); 
		Date start = cal.getTime();
		cal.add(Calendar.DATE,7);
		Date week = cal.getTime();
		
		cal.setTime(defaultDate);
		cal.add(Calendar.DATE,14);
		Date month = cal.getTime();
		if(strDate.before(start)) {
			return 3;
		}
		else if (strDate.after(start) && strDate.before(week)) {
			return 2;
		} else if(strDate.after(start) && strDate.before(month)){
			return 1;
		} else {
			return 0;
		}
	}
	
	public static int getRequestCalCheckNowDate(String date){
		SimpleDateFormat formatter = new SimpleDateFormat("yy.MM.dd");
		Date defaultDate = new Date();
		Date strDate = new Date();
		try {
			strDate = formatter.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(defaultDate); 
		cal.add(Calendar.DATE,-1);
		Date dayOne = cal.getTime();
		
		if (strDate.before(dayOne)) {
			return 1;
		} else {
			return 0;
		}
	}

}
