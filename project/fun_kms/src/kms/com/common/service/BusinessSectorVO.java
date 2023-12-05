package kms.com.common.service;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class BusinessSectorVO {
	private Integer no;
	private String busiSectorNm;
	private String busiSectorVal;
	private String busiSectorValNm;
	private Integer busiSectorYear;
	private Integer busiSectorOrd;
	private String useAt;
	
	private Integer searchYear = Integer.parseInt(CalendarUtil.getToday().substring(0,4));
	
	
	/**
	 * @return the no
	 */
	public Integer getNo() {
		return no;
	}
	/**
	 * @param no the no to set
	 */
	public void setNo(Integer no) {
		this.no = no;
	}
	/**
	 * @return the busiSectorNm
	 */
	public String getBusiSectorNm() {
		return busiSectorNm;
	}
	public String getNm() {
		return busiSectorNm;
	}
	/**
	 * @param busiSectorNm the busiSectorNm to set
	 */
	public void setBusiSectorNm(String busiSectorNm) {
		this.busiSectorNm = busiSectorNm;
	}
	/**
	 * @return the busiSectorVal
	 */
	public String getBusiSectorVal() {
		return busiSectorVal;
	}
	public String getId() {
		return busiSectorVal;
	}
	/**
	 * @param busiSectorVal the busiSectorVal to set
	 */
	public void setBusiSectorVal(String busiSectorVal) {
		this.busiSectorVal = busiSectorVal;
	}
	/**
	 * @return the busiSectorValNm
	 */
	public String getBusiSectorValNm() {
		return busiSectorValNm;
	}
	/**
	 * @param busiSectorValNm the busiSectorValNm to set
	 */
	public void setBusiSectorValNm(String busiSectorValNm) {
		this.busiSectorValNm = busiSectorValNm;
	}
	public void addBusiSectorValNm(String busiSectorValNm) {
		this.busiSectorValNm += "," + busiSectorValNm;
	}
	/**
	 * @return the busiSectorYear
	 */
	public Integer getBusiSectorYear() {
		return busiSectorYear;
	}
	/**
	 * @param busiSectorYear the busiSectorYear to set
	 */
	public void setBusiSectorYear(Integer busiSectorYear) {
		this.busiSectorYear = busiSectorYear;
	}
	/**
	 * @return the busiSectorOrd
	 */
	public Integer getBusiSectorOrd() {
		return busiSectorOrd;
	}
	/**
	 * @param busiSectorOrd the busiSectorOrd to set
	 */
	public void setBusiSectorOrd(Integer busiSectorOrd) {
		this.busiSectorOrd = busiSectorOrd;
	}
	/**
	 * @return the useAt
	 */
	public String getUseAt() {
		return useAt;
	}
	/**
	 * @param useAt the useAt to set
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	/**
	 * @return the searchYear
	 */
	public Integer getSearchYear() {
		return searchYear;
	}
	/**
	 * @param searchYear the searchYear to set
	 */
	public void setSearchYear(Integer searchYear) {
		this.searchYear = searchYear;
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
