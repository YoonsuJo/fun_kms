package kms.com.member.service;

import java.text.DecimalFormat;
import java.text.Format;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class WorkStateStatistic {
	private Integer userNo;
	private String userNm;
	private String userId;
	private String orgnztId;
	private String orgnztNm;
	private Integer userCnt = 0;
	private Integer dateCnt = 0;
	private Integer vac = 0;
	private Integer bizTrip = 0;
	private Integer send = 0;
	private Integer workOut = 0;
	private Integer earlyAtnd = 0;
	private Integer atnd = 0;
	private Integer night = 0;
	private Integer etc = 0;
	private Integer late = 0;
	
	private String searchDate = CalendarUtil.getToday();
	private String searchDateFrom = CalendarUtil.getToday().substring(0,4) + "0101";
	private String searchDateTo = CalendarUtil.getToday();
	private String searchCondition = "0";
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String[] searchOrgIdList;
	private String searchUserMix = "";
	private Integer searchUserNo = 0;
	
	private String excludeLeader;
	private String exceptionUsers; //제외할 사용자 번호
    private String[] exceptionUsersList; //제외할 사용자 번호 리스트
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
	 * @return the userCnt
	 */
	public Integer getUserCnt() {
		return userCnt;
	}
	/**
	 * @param userCnt the userCnt to set
	 */
	public void setUserCnt(Integer userCnt) {
		this.userCnt = userCnt;
	}
	/**
	 * @return the dateCnt
	 */
	public Integer getDateCnt() {
		return dateCnt;
	}
	/**
	 * @param dateCnt the dateCnt to set
	 */
	public void setDateCnt(Integer dateCnt) {
		this.dateCnt = dateCnt;
	}
	/**
	 * @return the vac
	 */
	public Integer getVac() {
		return vac;
	}
	/**
	 * @param vac the vac to set
	 */
	public void setVac(Integer vac) {
		this.vac = vac;
	}
	/**
	 * @return the bizTrip
	 */
	public Integer getBizTrip() {
		return bizTrip;
	}
	/**
	 * @param bizTrip the bizTrip to set
	 */
	public void setBizTrip(Integer bizTrip) {
		this.bizTrip = bizTrip;
	}
	/**
	 * @return the send
	 */
	public Integer getSend() {
		return send;
	}
	/**
	 * @param send the send to set
	 */
	public void setSend(Integer send) {
		this.send = send;
	}
	/**
	 * @return the workOut
	 */
	public Integer getWorkOut() {
		return workOut;
	}
	/**
	 * @param workOut the workOut to set
	 */
	public void setWorkOut(Integer workOut) {
		this.workOut = workOut;
	}
	/**
	 * @return the earlyAtnd
	 */
	public Integer getEarlyAtnd() {
		return earlyAtnd;
	}
	/**
	 * @param earlyAtnd the earlyAtnd to set
	 */
	public void setEarlyAtnd(Integer earlyAtnd) {
		this.earlyAtnd = earlyAtnd;
	}
	/**
	 * @return the atnd
	 */
	public Integer getAtnd() {
		return atnd;
	}
	/**
	 * @param atnd the atnd to set
	 */
	public void setAtnd(Integer atnd) {
		this.atnd = atnd;
	}
	/**
	 * @return the night
	 */
	public Integer getNight() {
		return night;
	}
	/**
	 * @param night the night to set
	 */
	public void setNight(Integer night) {
		this.night = night;
	}
	/**
	 * @return the etc
	 */
	public Integer getEtc() {
		return etc;
	}
	/**
	 * @param etc the etc to set
	 */
	public void setEtc(Integer etc) {
		this.etc = etc;
	}
	/**
	 * @return the late
	 */
	public Integer getLate() {
		return late;
	}
	/**
	 * @param late the late to set
	 */
	public void setLate(Integer late) {
		this.late = late;
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
	 * @return the searchDateFrom
	 */
	public String getSearchDateFrom() {
		return searchDateFrom;
	}
	/**
	 * @param searchDateFrom the searchDateFrom to set
	 */
	public void setSearchDateFrom(String searchDateFrom) {
		this.searchDateFrom = searchDateFrom;
	}
	/**
	 * @return the searchDateTo
	 */
	public String getSearchDateTo() {
		return searchDateTo;
	}
	/**
	 * @param searchDateTo the searchDateTo to set
	 */
	public void setSearchDateTo(String searchDateTo) {
		this.searchDateTo = searchDateTo;
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
	 * @return the searchUserNo
	 */
	public Integer getSearchUserNo() {
		return searchUserNo;
	}
	/**
	 * @param searchUserNo the searchUserNo to set
	 */
	public void setSearchUserNo(Integer searchUserNo) {
		this.searchUserNo = searchUserNo;
	}
	
	public Integer getAbs() {
		return (vac!=null?vac:0) + (bizTrip!=null?bizTrip:0) + (send!=null?send:0) + (workOut!=null?workOut:0);
	}
	public Integer getAttend() {
		return earlyAtnd + atnd;
	}
	public Integer getException() {
		return night + etc;
	}
	public Integer getValid() {
		return earlyAtnd + atnd + late;
	}
	public String getLatePercent() {
		return CommonUtil.getPercent(getLate(), getValid());
	}

	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setExcludeLeader(String excludeLeader) {
		this.excludeLeader = excludeLeader;
	}
	public String getExcludeLeader() {
		return excludeLeader;
	}
	public void setExceptionUsers(String exceptionUsers) {
		this.exceptionUsers = exceptionUsers;
	}
	public String getExceptionUsers() {
		return exceptionUsers;
	}
	public void setExceptionUsersList(String[] exceptionUsersList) {
		this.exceptionUsersList = exceptionUsersList;
	}
	public String[] getExceptionUsersList() {
		return exceptionUsersList;
	}
}
