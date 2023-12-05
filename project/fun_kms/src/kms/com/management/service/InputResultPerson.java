package kms.com.management.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

/**
 * @author pyo
 *
 */
public class InputResultPerson {
	private Integer userNo;
	private String userNm;
	private String userId;
	private String orgnztId;
	private String orgnztNm;
	private String prjId;
	private String prjCd;
	private String prjNm;
	private Integer tm = 0;
	private float pn;
	private InputResultPersonVO parentVO;
	
	private String laborDt;
	private String stDt;
	private String edDt;
	private String inputPercent;
	private String docId;
		
	private String searchDate = CalendarUtil.getToday();
	private String searchArea = "all";
	private String searchCondition = "0";	
	private String searchUserMix = "";
	private String[] searchUserMixList;
	private String searchOrgId = "";
	private String[] searchOrgIdList;
	private String searchOrgNm = "";
	private String searchUnder100 = "N"; //계획 MM 100% 미만 검색조건
	private String searchAllInputPrj = "N"; // 투입 프로젝트 전체보기
	
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
	/**
	 * @return the tm
	 */
	public Integer getTm() {
		return tm;
	}
	public String getTmPercent() {
		String tmPercent = CommonUtil.getPercent(tm, this.parentVO.getSumTm());
		if ("-".equals(tmPercent))
			tmPercent = "0.0";
		return tmPercent;
	}
	/**
	 * @param tm the tm to set
	 */
	public void setTm(Integer tm) {
		this.tm = tm;
	}
	/**
	 * @return the parentVO
	 */
	public InputResultPersonVO getParentVO() {
		return parentVO;
	}
	/**
	 * @param parentVO the parentVO to set
	 */
	public void setParentVO(InputResultPersonVO parentVO) {
		this.parentVO = parentVO;
	}
	
	/**
	 * @return the searchDate
	 */
	public String getSearchDate() {
		return searchDate;
	}
	public String getSearchDatePrint() {
		return searchDate.substring(0,4) + "년" + searchDate.substring(4,6) + "월";
	}
	/**
	 * @param searchDate the searchDate to set
	 */
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	/**
	 * @return the searchArea
	 */
	public String getSearchArea() {
		return searchArea;
	}
	/**
	 * @param searchArea the searchArea to set
	 */
	public void setSearchArea(String searchArea) {
		this.searchArea = searchArea;
	}
	/**
	 * @return the searchCondition
	 */
	public String getSearchCondition() {
		return searchCondition;
	}
	/**
	 * @param searchCondition the searchCondition to set
	 */
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	/**
	 * @return the searchUserMix
	 */
	public String getSearchUserMix() {
		return searchUserMix;
	}
	/**
	 * @param searchUserMix the searchUserMix to set
	 */
	public void setSearchUserMix(String searchUserMix) {
		this.searchUserMix = searchUserMix;
	}
	/**
	 * @return the searchUserMixList
	 */
	public String[] getSearchUserMixList() {
		return searchUserMixList;
	}
	/**
	 * @param searchUserMixList the searchUserMixList to set
	 */
	public void setSearchUserMixList(String[] searchUserMixList) {
		this.searchUserMixList = searchUserMixList;
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

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setPn(float pn) {
		this.pn = pn;
	}
	public float getPn() {
		return pn;
	}
	public void setLaborDt(String laborDt) {
		this.laborDt = laborDt;
	}
	public String getLaborDt() {
		return laborDt;
	}
	public void setStDt(String stDt) {
		this.stDt = stDt;
	}
	public String getStDt() {
		return stDt;
	}
	public String getStDtPrint() {
		if(stDt.length()<8)
			return stDt;
		String result = Integer.toString(Integer.parseInt(stDt.substring(0,4))) + "." 
			+ Integer.toString(Integer.parseInt(stDt.substring(4,6))) + "." 
			+ Integer.toString(Integer.parseInt(stDt.substring(6,8))) + "";
		return result;
	}
	public void setEdDt(String edDt) {
		this.edDt = edDt;
	}
	public String getEdDt() {
		return edDt;
	}
	public String getEdDtPrint() {
		if(edDt.length()<8)
			return edDt;
		String result = Integer.toString(Integer.parseInt(edDt.substring(0,4))) + "." 
			+ Integer.toString(Integer.parseInt(edDt.substring(4,6))) + "." 
			+ Integer.toString(Integer.parseInt(edDt.substring(6,8))) + "";
		return result;
	}
	public void setInputPercent(String inputPercent) {
		this.inputPercent = inputPercent;
	}
	public String getInputPercent() {
		return inputPercent;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public String getDocId() {
		return docId;
	}
	public void setSearchUnder100(String searchUnder100) {
		this.searchUnder100 = searchUnder100;
	}
	public String getSearchUnder100() {
		return searchUnder100;
	}
	/**
	 * @return the searchAllInputPrj
	 */
	public String getSearchAllInputPrj() {
		return searchAllInputPrj;
	}
	/**
	 * @param searchAllInputPrj the searchAllInputPrj to set
	 */
	public void setSearchAllInputPrj(String searchAllInputPrj) {
		this.searchAllInputPrj = searchAllInputPrj;
	}

	
	
}
