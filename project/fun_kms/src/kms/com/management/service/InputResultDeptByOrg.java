package kms.com.management.service;

import java.util.ArrayList;
import java.util.List;


public class InputResultDeptByOrg {
	private List<InputResultDeptByPrj> inputResultDeptByPrjList = new ArrayList<InputResultDeptByPrj>();
	private Integer drTm = 0;
	private Integer itemCnt = 0;
	private String orgId;
	private String orgFnm;

	/**
	 * @return the inputResultDeptByPrjList
	 */
	public List<InputResultDeptByPrj> getInputResultDeptByPrjList() {
		return inputResultDeptByPrjList;
	}
	/**
	 * @param inputResultDeptByPrjList the inputResultDeptByPrjList to set
	 */
	public void setInputResultDeptByPrjList(
			List<InputResultDeptByPrj> inputResultDeptByPrjList) {
		this.inputResultDeptByPrjList = inputResultDeptByPrjList;
	}
	/**
	 * @return the drTm
	 */
	public Integer getDrTm() {
		return drTm;
	}
	/**
	 * @param drTm the drTm to set
	 */
	public void setDrTm(Integer drTm) {
		this.drTm = drTm;
	}
	/**
	 * @return the orgId
	 */
	public String getOrgId() {
		return orgId;
	}
	/**
	 * @param orgId the orgId to set
	 */
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	/**
	 * @return the orgFnm
	 */
	public String getOrgFnm() {
		return orgFnm;
	}
	/**
	 * @param orgFnm the orgFnm to set
	 */
	public void setOrgFnm(String orgFnm) {
		this.orgFnm = orgFnm;
	}

	public void addInputResultDept(InputResultDept inputResultDept) {
		this.drTm += inputResultDept.getDrTm();
		this.itemCnt++;
		
		if (this.inputResultDeptByPrjList.size() == 0) {
			this.orgId = inputResultDept.getPrjOrgId();
			this.orgFnm = inputResultDept.getPrjOrgFnm();
		}

		for (int i = 0; i < this.inputResultDeptByPrjList.size(); i++) {
			InputResultDeptByPrj existingIrdbp = this.inputResultDeptByPrjList.get(i);
			if (existingIrdbp.getPrjId() != null && existingIrdbp.getPrjId().equals(inputResultDept.getPrjId())) {
				existingIrdbp.addInputResultDept(inputResultDept);
				return;
			}
		}

		InputResultDeptByPrj newIrdbp = new InputResultDeptByPrj();
		newIrdbp.addInputResultDept(inputResultDept);
		this.inputResultDeptByPrjList.add(newIrdbp);
	}
	/**
	 * @return the itemCnt
	 */
	public Integer getItemCnt() {
		return itemCnt;
	}
	/**
	 * @param itemCnt the itemCnt to set
	 */
	public void setItemCnt(Integer itemCnt) {
		this.itemCnt = itemCnt;
	}
}
