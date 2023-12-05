package kms.com.management.service;

import java.util.ArrayList;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class ProjectInputPlanDailyVO extends ProjectInputPlanDaily {
	private Integer userNo;
	private String userNm;
	private String userId;
	private String orgnztRow = "";
	private String orgnztId = "";
	private String orgnztNm = "";
	private List<Integer> inputPercentList = new ArrayList<Integer>();
	private Integer average = 0;
	/**
	 * @return the userNo
	 */
	public Integer getUserNo() {
		return userNo;
	}
	/**
	 * @param userNo the userNo to set
	 */
	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}
	/**
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getOrgnztRow() {
		return orgnztRow;
	}
	public void setOrgnztRow(String orgnztRow) {
		this.orgnztRow = orgnztRow;
	}
	public String getOrgnztId() {
		return orgnztId;
	}
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	public String getOrgnztNm() {
		return orgnztNm;
	}
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	/**
	 * @return the inputPercentList
	 */
	public List<Integer> getInputPercentList() {
		return inputPercentList;
	}
	/**
	 * @param inputPercentList the inputPercentList to set
	 */
	public void setInputPercentList(List<Integer> inputPercentList) {
		this.inputPercentList = inputPercentList;
	}
	public void addInputPercentList(List<Integer> inputPercentList) {
		this.inputPercentList.addAll(inputPercentList);
	}
	public void addInputPercentList(Integer inputPercent) {
		this.inputPercentList.add(inputPercent);
	}
	/**
	 * @return the average
	 */
	public Integer getAverage() {
		setAverage();
		return average;
	}
	/**
	 * @param average the average to set
	 */
	public void setAverage(Integer average) {
		this.average = average;
	}
	public void setAverage() {
		Integer sum = 0;
	
		for(int i=0; i<inputPercentList.size(); i++) {
			sum += inputPercentList.get(i);
		}
		
		this.average = sum/inputPercentList.size();
	}
	
	
}
