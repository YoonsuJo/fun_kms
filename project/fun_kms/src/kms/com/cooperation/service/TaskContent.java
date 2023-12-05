package kms.com.cooperation.service;

import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class TaskContent {
	private Integer no;
	private String taskId;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String taskCntTyp;
	private String taskCntSj;
	private String linkUrl;
	private String taskCntRegDt;
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
	 * @return the taskId
	 */
	public String getTaskId() {
		return taskId;
	}
	/**
	 * @param taskId the taskId to set
	 */
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
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
	 * @return the taskCntTyp
	 */
	public String getTaskCntTyp() {
		return taskCntTyp;
	}
	public String getTaskCntTypPrint() {
		if (taskCntTyp == null || taskCntTyp.equals("")) return "";
		else if (taskCntTyp.equals("CO")) return "업무연락";
		else if (taskCntTyp.equals("AP")) return "전자결재";
		else if (taskCntTyp.equals("SB")) return "자료공유";
		else if (taskCntTyp.equals("TA")) return "관련작업";
		else return taskCntTyp;
	}
	/**
	 * @param taskCntTyp the taskCntTyp to set
	 */
	public void setTaskCntTyp(String taskCntTyp) {
		this.taskCntTyp = taskCntTyp;
	}
	/**
	 * @return the taskCntSj
	 */
	public String getTaskCntSj() {
		return taskCntSj;
	}
	/**
	 * @param taskCntSj the taskCntSj to set
	 */
	public void setTaskCntSj(String taskCntSj) {
		this.taskCntSj = taskCntSj;
	}
	/**
	 * @return the linkUrl
	 */
	public String getLinkUrl() {
		return linkUrl;
	}
	/**
	 * @param linkUrl the linkUrl to set
	 */
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	/**
	 * @return the taskCntRegDt
	 */
	public String getTaskCntRegDt() {
		return taskCntRegDt;
	}
	public String getTaskCntRegDtPrint() {
		return CommonUtil.getDateType(taskCntRegDt);
	}
	/**
	 * @param taskCntRegDt the taskCntRegDt to set
	 */
	public void setTaskCntRegDt(String taskCntRegDt) {
		this.taskCntRegDt = taskCntRegDt;
	}
	

	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
