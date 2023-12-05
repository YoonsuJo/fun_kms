package kms.com.management.service;

import java.util.ArrayList;
import java.util.List;

import kms.com.common.utils.CommonUtil;

public class InputResultProjectDetailVO {
	private String prjId;
	private String prjNm;
	private String prjCd;
	
	private List<InputResultProjectDetail> inputResultProjectDetailList = new ArrayList<InputResultProjectDetail>();
	
	private Integer drTmSum = 0;
	private Integer drSalarySum = 0;
	private Double holTmSum = 0.0;
	private Integer holSalarySum = 0;
	/**
	 * @return the prjId
	 */
	public String getPrjId() {
		return prjId;
	}
	/**
	 * @param prjId the prjId to set
	 */
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	/**
	 * @return the prjNm
	 */
	public String getPrjNm() {
		return prjNm;
	}
	/**
	 * @param prjNm the prjNm to set
	 */
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	/**
	 * @return the prjCd
	 */
	public String getPrjCd() {
		return prjCd;
	}
	/**
	 * @param prjCd the prjCd to set
	 */
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	/**
	 * @return the inputResultProjectDetailList
	 */
	public List<InputResultProjectDetail> getInputResultProjectDetailList() {
		return inputResultProjectDetailList;
	}
	/**
	 * @param inputResultProjectDetailList the inputResultProjectDetailList to set
	 */
	public void setInputResultProjectDetailList(List<InputResultProjectDetail> inputResultProjectDetailList) {
		Integer drTmSum = 0;
		Integer drSalarySum = 0;
		Double holTmSum = 0.0;
		Integer holSalarySum = 0;
		
		for (int i=0; i<inputResultProjectDetailList.size(); i++) {
			InputResultProjectDetail tmp = inputResultProjectDetailList.get(i);
			
			drTmSum += tmp.getDrTm();
			drSalarySum += tmp.getDrSalary();
			holTmSum += tmp.getHolTm();
			holSalarySum += tmp.getHolSalary();
			
			tmp.setParentVO(this);
		}
		
		setDrTmSum(drTmSum);
		setDrSalarySum(drSalarySum);
		setHolTmSum(holTmSum);
		setHolSalarySum(holSalarySum);
		
		this.inputResultProjectDetailList = inputResultProjectDetailList;
	}
	public void addInputResultProjectDetailList(List<InputResultProjectDetail> inputResultProjectDetailList) {
		for (int i=0; i<inputResultProjectDetailList.size(); i++) {
			InputResultProjectDetail tmp = inputResultProjectDetailList.get(i);

			addDrTmSum(tmp.getDrTm());
			addDrSalarySum(tmp.getDrSalary());
			addHolTmSum(tmp.getHolTm());
			addHolSalarySum(tmp.getHolSalary());

			tmp.setParentVO(this);
		}
		
		this.inputResultProjectDetailList.addAll(inputResultProjectDetailList);
	}
	public void addInputResultProjectDetailList(InputResultProjectDetail inputResultProjectDetail) {
		addDrTmSum(inputResultProjectDetail.getDrTm());
		addDrSalarySum(inputResultProjectDetail.getDrSalary());
		addHolTmSum(inputResultProjectDetail.getHolTm());
		addHolSalarySum(inputResultProjectDetail.getHolSalary());

		inputResultProjectDetail.setParentVO(this);
		
		this.inputResultProjectDetailList.add(inputResultProjectDetail);
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
	
	
}
