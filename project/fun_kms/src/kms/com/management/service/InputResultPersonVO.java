package kms.com.management.service;

import java.util.ArrayList;
import java.util.List;

import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class InputResultPersonVO {
	private Integer userNo;
	private String userNm;
	private String userId;
	private String orgnztId;
	private String orgnztNm;
	private Integer sumTm = 0;
	private float pn;
	private String prjId;
	private String prjCd;
	private String prjNm;

	private List<InputResultPerson> inputResultPersonList = new ArrayList<InputResultPerson>();

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
	/**
	 * @return the orgnztId
	 */
	public String getOrgnztId() {
		return orgnztId;
	}
	/**
	 * @param orgnztId the orgnztId to set
	 */
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	/**
	 * @return the orgnztNm
	 */
	public String getOrgnztNm() {
		return orgnztNm;
	}
	/**
	 * @param orgnztNm the orgnztNm to set
	 */
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	/**
	 * @return the sumTm
	 */
	public Integer getSumTm() {
		return sumTm;
	}
	/**
	 * @param sumTm the sumTm to set
	 */
	public void setSumTm(Integer sumTm) {
		this.sumTm = sumTm;
	}
	public void addSumTm(Integer sumTm) {
		this.sumTm += sumTm;
	}
	/**
	 * @return the inputResultPersonList
	 */
	public List<InputResultPerson> getInputResultPersonList() {
		return inputResultPersonList;
	}
	/**
	 * @param inputResultPersonList the inputResultPersonList to set
	 */
	public void setInputResultPersonList(List<InputResultPerson> inputResultPersonList) {
		this.inputResultPersonList = inputResultPersonList;
		setSumTm(0);
		for (int i=0; i<inputResultPersonList.size(); i++) {
			addSumTm(inputResultPersonList.get(i).getTm());
		}
	}
	public void addInputResultPersonList(InputResultPerson inputResultPerson) {
		this.inputResultPersonList.add(inputResultPerson);
		addSumTm(inputResultPerson.getTm());
	}
	public void addInputResultPersonList(List<InputResultPerson> inputResultPersonList) {
		this.inputResultPersonList.addAll(inputResultPersonList);
		
		for (int i=0; i<inputResultPersonList.size(); i++) {
			addSumTm(inputResultPersonList.get(i).getTm());
		}
	}
	
	public Integer getTotalTm() {
		int totalTm = 0;
		
		for (int i=0; i<inputResultPersonList.size(); i++) {
			InputResultPerson irp = inputResultPersonList.get(i);
			
			totalTm += irp.getTm();
		}
		
		return totalTm;
	}
	public String getTotalTmPercent() {
		Double totalTmPercent = 0D;

		for (int i=0; i<inputResultPersonList.size(); i++) {
			InputResultPerson irp = inputResultPersonList.get(i);
			
			String tmPercent = irp.getTmPercent();
			if ("-".equals(tmPercent)) tmPercent = "0";
			
			totalTmPercent += Double.valueOf(tmPercent);
			
		}
		
		return String.valueOf(Math.round(totalTmPercent * 10) / 10D);
	}
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setPn(float pn) {
		this.pn = pn;
	}
	public float getPn() {
		return pn;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	public String getPrjCd() {
		return prjCd;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getPrjNm() {
		return prjNm;
	}

}
