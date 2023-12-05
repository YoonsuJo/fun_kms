package kms.com.management.service;

import java.util.ArrayList;
import java.util.List;


public class InputResultDeptByPrj {
	private List<InputResultDept> inputResultDeptList = new ArrayList<InputResultDept>();
	private Integer drTm = 0;
	private Integer itemCnt = 0;
	private String prjId;
	private String prjCd;
	private String prjNm;

	/**
	 * @return the inputResultDeptList
	 */
	public List<InputResultDept> getInputResultDeptList() {
		return inputResultDeptList;
	}
	/**
	 * @param inputResultDeptList the inputResultDeptList to set
	 */
	public void setInputResultDeptList(List<InputResultDept> inputResultDeptList) {
		this.inputResultDeptList = inputResultDeptList;
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

	public void addInputResultDept(InputResultDept inputResultDept) {
		this.drTm += inputResultDept.getDrTm();
		this.itemCnt++;
		
		if (this.inputResultDeptList.size() == 0) {
			this.prjId = inputResultDept.getPrjId();
			this.prjCd = inputResultDept.getPrjCd();
			this.prjNm = inputResultDept.getPrjNm();
		}

		this.inputResultDeptList.add(inputResultDept);
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
