package kms.com.management.service;

import java.util.ArrayList;
import java.util.List;

import kms.com.common.utils.CalendarUtil;

public class InputResultDeptVO {
	private List<InputResultDeptByOrg> inputResultDeptByOrgList = new ArrayList<InputResultDeptByOrg>();
	private Integer drTm = 0;
	private Integer itemCnt = 0;

	private String searchDate = CalendarUtil.getToday();
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String[] searchOrgIdList;

	/**
	 * @return the inputResultDeptByOrgList
	 */
	public List<InputResultDeptByOrg> getInputResultDeptByOrgList() {
		return inputResultDeptByOrgList;
	}
	/**
	 * @param inputResultDeptByOrgList the inputResultDeptByOrgList to set
	 */
	public void setInputResultDeptByOrgList(
			List<InputResultDeptByOrg> inputResultDeptByOrgList) {
		this.inputResultDeptByOrgList = inputResultDeptByOrgList;
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
	 * @return the searchDate
	 */
	public String getSearchDate() {
		return searchDate;
	}
	/**
	 * @param searchDate the searchDate to set
	 */
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	/**
	 * @return the searchOrgId
	 */
	public String getSearchOrgId() {
		return searchOrgId;
	}
	/**
	 * @param searchOrgId the searchOrgId to set
	 */
	public void setSearchOrgId(String searchOrgId) {
		this.searchOrgId = searchOrgId;
	}
	/**
	 * @return the searchOrgNm
	 */
	public String getSearchOrgNm() {
		return searchOrgNm;
	}
	/**
	 * @param searchOrgNm the searchOrgNm to set
	 */
	public void setSearchOrgNm(String searchOrgNm) {
		this.searchOrgNm = searchOrgNm;
	}
	/**
	 * @return the searchOrgIdList
	 */
	public String[] getSearchOrgIdList() {
		return searchOrgIdList;
	}
	/**
	 * @param searchOrgIdList the searchOrgIdList to set
	 */
	public void setSearchOrgIdList(String[] searchOrgIdList) {
		this.searchOrgIdList = searchOrgIdList;
	}
	
	public void addInputResultDept(InputResultDept inputResultDept) {
		this.drTm += inputResultDept.getDrTm();
		this.itemCnt++;

		for (int i = 0; i < this.inputResultDeptByOrgList.size(); i++) {
			InputResultDeptByOrg existingIrdbo = this.inputResultDeptByOrgList.get(i);
			if (existingIrdbo.getOrgId() != null && existingIrdbo.getOrgId().equals(inputResultDept.getPrjOrgId())) {
				existingIrdbo.addInputResultDept(inputResultDept);
				return;
			}
		}

		InputResultDeptByOrg newIrdbo = new InputResultDeptByOrg();
		newIrdbo.addInputResultDept(inputResultDept);
		this.inputResultDeptByOrgList.add(newIrdbo);
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
