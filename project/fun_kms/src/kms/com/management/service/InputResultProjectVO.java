package kms.com.management.service;

import java.util.ArrayList;
import java.util.List;

import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class InputResultProjectVO {
	private String orgnztId;
	private String orgnztNm;
	private List<InputResultProject> inputResultProjectList = new ArrayList<InputResultProject>();
	
	private Integer drTmSum = 0;
	private Integer drSalarySum = 0;
	private Double holTmSum = 0.0;
	private Integer holSalarySum = 0;
	private Integer salarySum = 0;
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
	 * @return the inputResultProjectList
	 */
	public List<InputResultProject> getInputResultProjectList() {
		return inputResultProjectList;
	}
	/**
	 * @param inputResultProjectList the inputResultProjectList to set
	 */
	public void setInputResultProjectList(
			List<InputResultProject> inputResultProjectList) {
		Integer drTm = 0;
		Integer drSalary = 0;
		Double holTm = 0.0;
		Integer holSalary = 0;

		for (int i=0; i<inputResultProjectList.size(); i++) {
			InputResultProject tmp = inputResultProjectList.get(i);
			
			drTm += tmp.getDrTm();
			drSalary += tmp.getDrSalary();
			holTm += tmp.getHolTm();
			holSalary += tmp.getHolSalary();
		}
		
		setDrTmSum(drTm);
		setDrSalarySum(drSalary);
		setHolTmSum(holTm);
		setHolSalarySum(holSalary);
		setSalarySum();
		
		this.inputResultProjectList = inputResultProjectList;
	}
	public void addInputResultProjectList(
			List<InputResultProject> inputResultProjectList) {
		for (int i=0; i<inputResultProjectList.size(); i++) {
			InputResultProject tmp = inputResultProjectList.get(i);
			
			addDrTmSum(tmp.getDrTm());
			addDrSalarySum(tmp.getDrSalary());
			addHolTmSum(tmp.getHolTm());
			addHolSalarySum(tmp.getHolSalary());
		}
		setSalarySum();
		
		this.inputResultProjectList.addAll(inputResultProjectList);
	}
	public void addInputResultProjectList(
			InputResultProject inputResultProject) {
		addDrTmSum(inputResultProject.getDrTm());
		addDrSalarySum(inputResultProject.getDrSalary());
		addHolTmSum(inputResultProject.getHolTm());
		addHolSalarySum(inputResultProject.getHolSalary());
		setSalarySum();
		
		this.inputResultProjectList.add(inputResultProject);
	}
	/**
	 * @return the drTmSum
	 */
	public Integer getDrTmSum() {
		return drTmSum;
	}
	/**
	 * @param drTmSum the drTmSum to set
	 */
	private void setDrTmSum(Integer drTmSum) {
		this.drTmSum = drTmSum;
	}
	private void addDrTmSum(Integer drTmSum) {
		this.drTmSum += drTmSum;
	}
	/**
	 * @return the drSalarySum
	 */
	public Integer getDrSalarySum() {
		return drSalarySum;
	}
	public String getDrSalarySumPrint() {
		return CommonUtil.insertComma(drSalarySum);
	}
	/**
	 * @param drSalarySum the drSalarySum to set
	 */
	private void setDrSalarySum(Integer drSalarySum) {
		this.drSalarySum = drSalarySum;
	}
	private void addDrSalarySum(Integer drSalarySum) {
		this.drSalarySum += drSalarySum;
	}
	/**
	 * @return the holTmSum
	 */
	public Double getHolTmSum() {
		return holTmSum;
	}
	/**
	 * @param holTmSum the holTmSum to set
	 */
	private void setHolTmSum(Double holTmSum) {
		this.holTmSum = holTmSum;
	}
	private void addHolTmSum(Double holTmSum) {
		this.holTmSum += holTmSum;
	}
	/**
	 * @return the holSalarySum
	 */
	public Integer getHolSalarySum() {
		return holSalarySum;
	}
	public String getHolSalarySumPrint() {
		return CommonUtil.insertComma(holSalarySum);
	}
	/**
	 * @param holSalarySum the holSalarySum to set
	 */
	private void setHolSalarySum(Integer holSalarySum) {
		this.holSalarySum = holSalarySum;
	}
	private void addHolSalarySum(Integer holSalarySum) {
		this.holSalarySum += holSalarySum;
	}
	/**
	 * @return the salarySum
	 */
	public Integer getSalarySum() {
		return salarySum;
	}
	public String getSalarySumPrint() {
		return CommonUtil.insertComma(salarySum);
	}
	/**
	 * @param salarySum the salarySum to set
	 */
	private void setSalarySum(Integer salarySum) {
		this.salarySum = salarySum;
	}
	private void addSalarySum(Integer salarySum) {
		this.salarySum += salarySum;
	}
	private void setSalarySum() {
		this.salarySum = getHolSalarySum() + getDrSalarySum();
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
