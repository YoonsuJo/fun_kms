package kms.com.community.service;

import java.util.ArrayList;
import java.util.List;

import kms.com.common.utils.CalendarUtil;

public class CalendarVO {
	private int year;
	private int month;
	private int date;
	private int day;	//요일 1일 2월 3화 4수 5목 6금 7토
	private boolean holiday;
	
	private List<ScheduleVO> scheduleList;

	public CalendarVO(String year, String month, String date) {
		this.year = Integer.parseInt(year);
		this.month = Integer.parseInt(month);
		this.date = Integer.parseInt(date);
		this.day = CalendarUtil.getDay(year + month + date);
		this.scheduleList = new ArrayList<ScheduleVO>();;
	}
	
	
	/**
	 * @return the year
	 */
	public int getYear() {
		return year;
	}

	/**
	 * @param year the year to set
	 */
	public void setYear(int year) {
		this.year = year;
	}

	/**
	 * @return the month
	 */
	public int getMonth() {
		return month;
	}

	/**
	 * @param month the month to set
	 */
	public void setMonth(int month) {
		this.month = month;
	}

	/**
	 * @return the date
	 */
	public int getDate() {
		return date;
	}

	/**
	 * @param date the date to set
	 */
	public void setDate(int date) {
		this.date = date;
	}

	/**
	 * @return the day
	 */
	public int getDay() {
		return day;
	}

	/**
	 * @param day the day to set
	 */
	public void setDay(int day) {
		this.day = day;
	}

	/**
	 * @return the holiday
	 */
	public boolean isHoliday() {
		return holiday;
	}


	/**
	 * @param holiday the holiday to set
	 */
	public void setHoliday(boolean holiday) {
		this.holiday = holiday;
	}


	/**
	 * @return the scheduleList
	 */
	public List<ScheduleVO> getScheduleList() {
		return scheduleList;
	}

	/**
	 * @param scheduleList the scheduleList to set
	 */
	public void setScheduleList(List<ScheduleVO> scheduleList) {
		this.scheduleList = scheduleList;
	}
	
	/**
	 * @param scheduleList the scheduleList to set
	 */
	public void addScheduleList(ScheduleVO scheduleVO) {
		this.scheduleList.add(scheduleVO);
	}

	
}
