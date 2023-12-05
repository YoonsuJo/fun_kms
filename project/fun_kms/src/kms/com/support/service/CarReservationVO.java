package kms.com.support.service;

import java.util.ArrayList;
import java.util.List;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class CarReservationVO {

	private int year;
	private int month;
	private int date;
	private int day;
	private String dateString;
	private List<CarReservation> carRsvList = new ArrayList<CarReservation>();
	private boolean isFirstDate = false;
	private boolean isLastDate = false;
	
	public CarReservationVO(String year, String month, String date) {
		this.year = Integer.parseInt(year);
		this.month = Integer.parseInt(month);
		this.date = Integer.parseInt(date);
		this.dateString = year + month + date;
		this.day = CalendarUtil.getDay(year + month + date);
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
	 * @return the dateString
	 */
	public String getDateString() {
		return dateString;
	}
	/**
	 * @param dateString the dateString to set
	 */
	public void setDateString(String dateString) {
		this.dateString = dateString;
	}
	/**
	 * @return the carRsvList
	 */
	public List<CarReservation> getCarRsvList() {
		return carRsvList;
	}
	/**
	 * @param carRsvList the carRsvList to set
	 */
	public void setCarRsvList(List<CarReservation> carRsvList) {
		this.carRsvList = carRsvList;
	}
	public void addCarRsvList(List<CarReservation> carRsvList) {
		this.carRsvList.addAll(carRsvList);
	}
	public void addCarRsvList(CarReservation carRsv) {
		this.carRsvList.add(carRsv);
	}
	/**
	 * @return the isFirstDate
	 */
	public boolean isFirstDate() {
		return isFirstDate;
	}
	/**
	 * @param isFirstDate the isFirstDate to set
	 */
	public void setFirstDate(boolean isFirstDate) {
		this.isFirstDate = isFirstDate;
	}
	/**
	 * @return the isLastDate
	 */
	public boolean isLastDate() {
		return isLastDate;
	}
	/**
	 * @param isLastDate the isLastDate to set
	 */
	public void setLastDate(boolean isLastDate) {
		this.isLastDate = isLastDate;
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
