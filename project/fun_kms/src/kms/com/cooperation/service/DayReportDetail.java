package kms.com.cooperation.service;

import java.util.ArrayList;
import java.util.List;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class DayReportDetail {
	private String date;
	private String day;
	private List<TaskVO> taskList = new ArrayList<TaskVO>();
	
	/**
	 * @return the date
	 */
	public String getDate() {
		return date;
	}
	/**
	 * @param date the date to set
	 */
	public void setDate(String date) {
		this.date = date;
		this.day = CalendarUtil.getDay(date, "KOR");
	}
	/**
	 * @return the day
	 */
	public String getDay() {
		return day;
	}
	/**
	 * @param day the day to set
	 */
	public void setDay(String day) {
		this.day = day;
	}
	/**
	 * @return the taskList
	 */
	public List<TaskVO> getTaskList() {
		return taskList;
	}
	/**
	 * @param taskList the taskList to set
	 */
	public void setTaskList(List<TaskVO> taskList) {
		this.taskList = taskList;
	}
	public void addTaskList(TaskVO taskVO) {
		this.taskList.add(taskVO);
	}
	public void addTaskList(List<TaskVO> taskList) {
		this.taskList.addAll(taskList);
	}
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
