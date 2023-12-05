package kms.com.cooperation.service;

import java.util.ArrayList;
import java.util.List;

import kms.com.member.service.MemberVO;

import org.apache.commons.lang.builder.ToStringBuilder;

public class DayReportWeek {
	private Task task;
	private List<DayReportDate> dayReportDateList = new ArrayList<DayReportDate>();
	private List<TaskContent> taskContentList = new ArrayList<TaskContent>();
	private int sum = 0;
	private List<Integer> sumList = new ArrayList<Integer>();
	
	/**
	 * @return the task
	 */
	public Task getTask() {
		return task;
	}
	/**
	 * @param task the task to set
	 */
	public void setTask(Task task) {
		this.task = task;
	}
	/**
	 * @return the dayReportList
	 */
	public List<DayReportDate> getDayReportDateList() {
		return dayReportDateList;
	}
	/**
	 * @param dayReportList the dayReportList to set
	 */
	public void setDayReportDateList(List<DayReportDate> dayReportDateList) {
		this.dayReportDateList = dayReportDateList;
		setSum();
	}
	public void addDayReportDateList(DayReportDate dayReportDate) {
		this.dayReportDateList.add(dayReportDate);
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
	/**
	 * @return the sum
	 */
	public int getSum() {
		return sum;
	}
	/**
	 * @param sum the sum to set
	 */
	public void setSum(int sum) {
		this.sum = sum;
	}
	public void setSum() {
		this.sum = 0;
		for (int i=0; i<this.dayReportDateList.size(); i++) {
			this.sumList.add(this.dayReportDateList.get(i).getSum());
			this.sum += this.dayReportDateList.get(i).getSum();
		}
	}
	/**
	 * @return the sumList
	 */
	public List<Integer> getSumList() {
		return sumList;
	}
	/**
	 * @param sumList the sumList to set
	 */
	public void setSumList(List<Integer> sumList) {
		this.sumList = sumList;
	}
	
	
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
