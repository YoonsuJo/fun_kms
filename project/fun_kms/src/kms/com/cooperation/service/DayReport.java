package kms.com.cooperation.service;

import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class DayReport {
	private Integer no;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String taskId;
	private String dayReportDt;
	private Integer dayReportTm;
	private Integer dayReportTodayTm;
	
	private String dayReportCn;
	
	//나의 업무 S
	private String prjNm;
	private String prjCd;
	private String prjId;
	
	private String taskSj;
	private String taskCn;
	private String taskRegdate;
	private String taskStartdate;
	private String taskStarttime;
	private String taskDuedate;
	private String taskDuetime;
	private String taskEnddate;
	private String taskState;
	private Integer writerNo;
	private String writerNm;
	private String writerId;
	
	private Integer dayReportCnt;
	private Integer dayReportTodayCnt;
	
	private String attachFileId;	// [2015.04.01, dwkim] 사장님 지시로 추가
	
	//나의 업무 E
	
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
	 * @return the dayReportDt
	 */
	public String getDayReportDt() {
		return dayReportDt;
	}
	public String getDayReportDtPrint() {
		return CommonUtil.getDateType(dayReportDt);
	}
	/**
	 * @param dayReportDt the dayReportDt to set
	 */
	public void setDayReportDt(String dayReportDt) {
		this.dayReportDt = dayReportDt;
	}
	/**
	 * @return the dayReportTm
	 */
	public Integer getDayReportTm() {
		return dayReportTm;
	}
	/**
	 * @param dayReportTm the dayReportTm to set
	 */
	public void setDayReportTm(Integer dayReportTm) {
		this.dayReportTm = dayReportTm;
	}
	public void setDayReportTm(String dayReportTm) {
		this.dayReportTm = Integer.parseInt(dayReportTm);
	}
	/**
	 * @return the dayReportCn
	 */
	public String getDayReportCn() {
		return dayReportCn.replace("&apos;", "'");
	}
	public String getDayReportCnPrint() {
		return dayReportCn.replace("\r\n", "<br/>").replace(" ", "&nbsp;").replace("&apos;", "'");
	}
	/**
	 * @param dayReportCn the dayReportCn to set
	 */
	public void setDayReportCn(String dayReportCn) {
		this.dayReportCn = dayReportCn;
	}
	
	
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getPrjCd() {
		return prjCd;
	}
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public String getTaskSj() {
		return taskSj;
	}
	public void setTaskSj(String taskSj) {
		this.taskSj = taskSj;
	}
	public String getTaskSjPrint() {
		return taskSj.replace("&apos;", "'");
	}	
	public String getTaskCn() {
		return taskCn;
	}
	public void setTaskCn(String taskCn) {
		this.taskCn = taskCn;
	}
	public String getTaskCnPrint() {
		return taskCn.replace("\r\n", "<br/>").replace(" ", "&nbsp;").replace("&apos;", "'");
	}
	
	public String getTaskRegdate() {
		return taskRegdate;
	}
	public void setTaskRegdate(String taskRegdate) {
		this.taskRegdate = taskRegdate;
	}
	public String getTaskStartdate() {
		return taskStartdate;
	}
	public String getTaskStartdatePrint() {
		if (taskStartdate == null || taskStartdate.equals("")) return "미지정";
		else return CommonUtil.getDateType(taskStartdate);
	}
	public void setTaskStartdate(String taskStartdate) {
		this.taskStartdate = taskStartdate;
	}
	
	public String getTaskStarttime() {
		return taskStarttime;
	}
	public String getTaskStarttimePrint() {
		if (taskStarttime == null || taskStarttime.equals("")) return "";
		else return taskStarttime + ":00";
	}
	
	public void setTaskStarttime(String taskStarttime) {
		this.taskStarttime = taskStarttime;
	}
	
	public String getTaskDuedate() {
		return taskDuedate;
	}
	public void setTaskDuedate(String taskDuedate) {
		this.taskDuedate = taskDuedate;
	}
	public String getTaskDuedatePrint() {
		if (taskDuedate == null || taskDuedate.equals("")) return "미지정";
		else return CommonUtil.getDateType(taskDuedate);
	}
	public String getTaskDuetime() {
		return taskDuetime;
	}
	public String getTaskDuetimePrint() {
		if (taskDuetime == null || taskDuetime.equals("")) return "";
		else return taskDuetime + ":00";
	}
	public void setTaskDuetime(String taskDuetime) {
		this.taskDuetime = taskDuetime;
	}
	public String getTaskEnddate() {
		return taskEnddate;
	}
	public void setTaskEnddate(String taskEnddate) {
		this.taskEnddate = taskEnddate;
	}
	public String getTaskEnddatePrint() {
		if (taskEnddate == null || taskEnddate.equals("")) return "미지정";
		else return CommonUtil.getDateType(taskEnddate);
	}
	public String getTaskState() {
		return taskState;
	}
	public void setTaskState(String taskState) {
		this.taskState = taskState;
	}
	public Integer getWriterNo() {
		return writerNo;
	}
	public void setWriterNo(Integer writerNo) {
		this.writerNo = writerNo;
	}
	public String getWriterNm() {
		return writerNm;
	}
	public void setWriterNm(String writerNm) {
		this.writerNm = writerNm;
	}
	public String getWriterId() {
		return writerId;
	}
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	/**
	 * @param dayReportCnt the dayReportCnt to set
	 */
	public void setDayReportCnt(Integer dayReportCnt) {
		this.dayReportCnt = dayReportCnt;
	}
	/**
	 * @return the dayReportCnt
	 */
	public Integer getDayReportCnt() {
		return dayReportCnt;
	}
	/**
	 * @param dayReportTodayCnt the dayReportTodayCnt to set
	 */
	public void setDayReportTodayCnt(Integer dayReportTodayCnt) {
		this.dayReportTodayCnt = dayReportTodayCnt;
	}
	/**
	 * @return the dayReportTodayCnt
	 */
	public Integer getDayReportTodayCnt() {
		return dayReportTodayCnt;
	}
	/**
	 * @param dayReportTodayTm the dayReportTodayTm to set
	 */
	public void setDayReportTodayTm(Integer dayReportTodayTm) {
		this.dayReportTodayTm = dayReportTodayTm;
	}
	/**
	 * @return the dayReportTodayTm
	 */
	public Integer getDayReportTodayTm() {
		return dayReportTodayTm;
	}
	public String getAttachFileId() {
		return attachFileId;
	}
	public void setAttachFileId(String attachFileId) {
		this.attachFileId = attachFileId;
	}
}
