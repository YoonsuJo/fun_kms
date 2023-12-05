package kms.com.cooperation.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

public class TaskVO extends Task {
	List<DayReport> dayReportList = new ArrayList<DayReport>();
	List<TaskContent> taskContentList = new ArrayList<TaskContent>();
	/**
	 * @return the dayReportList
	 */
	public List<DayReport> getDayReportList() {
		return dayReportList;
	}
	/**
	 * @param dayReportList the dayReportList to set
	 */
	public void setDayReportList(List<DayReport> dayReportList) {
		this.dayReportList = dayReportList;
	}
	public void addDayReportList(DayReport dayReport) {
		this.dayReportList.add(dayReport);
	}
	public void addDayReportList(List<DayReport> dayReportList) {
		this.dayReportList.addAll(dayReportList);
	}
	/**
	 * @return the taskContentList
	 */
	public List<TaskContent> getTaskContentList() {
		return taskContentList;
	}
	/**
	 * @param taskContentList the taskContentList to set
	 */
	public void setTaskContentList(List<TaskContent> taskContentList) {
		this.taskContentList = taskContentList;
	}
	public void addTaskContentList(TaskContent taskContent) {
		this.taskContentList.add(taskContent);
	}
	public void addTaskContentList(List<TaskContent> taskContentList) {
		this.taskContentList.addAll(taskContentList);
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
