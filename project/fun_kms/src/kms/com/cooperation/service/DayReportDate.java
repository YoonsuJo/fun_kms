package kms.com.cooperation.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.builder.ToStringBuilder;

public class DayReportDate {
	private String date;
	private List<DayReport> dayReportList = new ArrayList<DayReport>();
	private int sum = 0;
	private int count = 0;
	
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
	}
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
		setSum();
	}
	public void addDayReportList(DayReport dayReport) {
		this.dayReportList.add(dayReport);
	}
	/**
	 * @return the sum
	 */
	public int getSum() {
		return sum;
	}
	public String getSumString() {
		if (sum == 0) return "-";
		else return String.valueOf(sum);
	}
	/**
	 * @param sum the sum to set
	 */
	public void setSum(int sum) {
		this.sum = sum;
	}
	public void setSum() {
		this.sum = 0;
		for (int i=0; i<dayReportList.size(); i++) {
			sum += dayReportList.get(i).getDayReportTm();
		}
	}
	
	public int getCount() {
		return dayReportList.size();
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}	
	
}
