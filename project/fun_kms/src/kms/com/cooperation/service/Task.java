package kms.com.cooperation.service;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Task {
	private String taskId;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String[] userMixList;
	private String prjId;
	private String prjCd;
	private String prjNm;
	private String taskSj;
	private String taskCn = "";
	private String taskRegdate;
	private String taskStartdate;
	private String taskStarttime;
	private String taskDuedate;
	private String taskDuetime;
	private String taskEnddate;
	private Integer writerNo;
	private String writerNm;
	private String writerId;
	private String taskState;
	private String leaderNo;
	private int tmSum = 0;
	
	private String historyNo;
	private String historyStat;
	private String historyCn;
	private String regDt;
	
	private String alwaysViewYn;
	
	private String attachFileId;
	
	
	public String getHistoryNo() {
		return historyNo;
	}
	public void setHistoryNo(String historyNo) {
		this.historyNo = historyNo;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	private String rootUrl;
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
	 * @return the userMixList
	 */
	public String[] getUserMixList() {
		return userMixList;
	}
	/**
	 * @param userMixList the userMixList to set
	 */
	public void setUserMixList(String[] userMixList) {
		this.userMixList = userMixList;
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
	 * @return the taskSj
	 */
	public String getTaskSj() {
		return taskSj;
	}
	public String getTaskSjPrint() {
		return taskSj.replace("&apos;", "'");
	}
	public String getTaskSjShort() {
		if (taskSj == null) return "";
		
		else if (taskSj.length() > 15) {
			return taskSj.substring(0,12) + "...";
		}
		else {
			return taskSj; 
		}
	}

	/**
	 * @param taskSj the taskSj to set
	 */
	public void setTaskSj(String taskSj) {
		this.taskSj = taskSj;
	}
	/**
	 * @return the taskCn
	 */
	public String getTaskCn() {
		return taskCn.replace("&apos;", "'");
	}
	public String getTaskCnPrint() {
		return taskCn.replace("\r\n", "<br/>").replace(" ", "&nbsp;").replace("&apos;", "'");
	}
	/**
	 * @param taskCn the taskCn to set
	 */
	public void setTaskCn(String taskCn) {
		this.taskCn = taskCn;
	}
	/**
	 * @return the taskRegdate
	 */
	public String getTaskRegdate() {
		return taskRegdate;
	}
	/**
	 * @param taskRegdate the taskRegdate to set
	 */
	public void setTaskRegdate(String taskRegdate) {
		this.taskRegdate = taskRegdate;
	}
	/**
	 * @return the taskStartdate
	 */
	public String getTaskStartdate() {
		return taskStartdate;
	}
	public String getTaskStartdatePrint() {
		if (taskStartdate == null || taskStartdate.equals("")) return "미지정";
		else return CommonUtil.getDateType(taskStartdate);
	}
	public String getTaskStartdatePrint2() {
		if (taskStartdate == null || taskStartdate.equals("")) return "미지정";
		else return CommonUtil.getDateType(taskStartdate) + " (" + CalendarUtil.getDay(taskStartdate, "KOR") + ")";
	}
	/**
	 * @param taskStartdate the taskStartdate to set
	 */
	public void setTaskStartdate(String taskStartdate) {
		this.taskStartdate = taskStartdate;
	}
	/**
	 * @return the taskDuedate
	 */
	public String getTaskDuedate() {
		return taskDuedate;
	}
	public String getTaskDuedatePrint() {
		if (taskDuedate == null || taskDuedate.equals("")) return "미지정";
		else return CommonUtil.getDateType(taskDuedate);
	}
	public String getTaskDuedatePrint2() {
		if (taskDuedate == null || taskDuedate.equals("")) return "미지정";
		else return CommonUtil.getDateType(taskDuedate) + " (" + CalendarUtil.getDay(taskDuedate, "KOR") + ")";
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
	
	/**
	 * @param taskDuedate the taskDuedate to set
	 */
	public void setTaskDuedate(String taskDuedate) {
		this.taskDuedate = taskDuedate;
	}
	/**
	 * @return the taskDuetime
	 */
	public String getTaskDuetime() {
		return taskDuetime;
	}
	public String getTaskDuetimePrint() {
		if (taskDuetime == null || taskDuetime.equals("")) return "";
		else return taskDuetime + ":00";
	}
	/**
	 * @param taskDuetime the taskDuetime to set
	 */
	public void setTaskDuetime(String taskDuetime) {
		this.taskDuetime = taskDuetime;
	}
	/**
	 * @return the taskEnddate
	 */
	public String getTaskEnddate() {
		return taskEnddate;
	}
	/**
	 * @param taskEnddate the taskEnddate to set
	 */
	public void setTaskEnddate(String taskEnddate) {
		this.taskEnddate = taskEnddate;
	}
	public String getTaskEnddatePrint() {
		if (taskEnddate == null || taskEnddate.equals("")) return "미지정";
		else return CommonUtil.getDateType(taskEnddate);
	}
	public String getTaskEnddatePrint2() {
		if (taskEnddate == null || taskEnddate.equals("")) return "미지정";
		else return CommonUtil.getDateType(taskEnddate) + " (" + CalendarUtil.getDay(taskEnddate, "KOR") + ")";
	}
	/**
	 * @return the writerNo
	 */
	public Integer getWriterNo() {
		return writerNo;
	}
	/**
	 * @param writerNo the writerNo to set
	 */
	public void setWriterNo(Integer writerNo) {
		this.writerNo = writerNo;
	}
	/**
	 * @return the writerNm
	 */
	public String getWriterNm() {
		return writerNm;
	}
	/**
	 * @param writerNm the writerNm to set
	 */
	public void setWriterNm(String writerNm) {
		this.writerNm = writerNm;
	}
	/**
	 * @return the writerId
	 */
	public String getWriterId() {
		return writerId;
	}
	/**
	 * @param writerId the writerId to set
	 */
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	/**
	 * @return the taskState
	 */
	public String getTaskState() {
		return taskState;
	}
	public String getTaskStatePrint() {
		if (isProcess()) return "진행중";
		else if (isComplete()) return "완료";
		else return taskState;
	}
	public boolean isProcess() {
		return (taskState != null && taskState.equals("P"));
	}
	public boolean isComplete() {
		return (taskState != null && taskState.equals("C"));
	}
	/**
	 * @param taskState the taskState to set
	 */
	public void setTaskState(String taskState) {
		this.taskState = taskState;
	}
	
	public int getTmSum() {
		return tmSum;
	}
	public void setTmSum(int tmSum) {
		this.tmSum = tmSum;
	}
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
	public void setLeaderNo(String leaderNo) {
		this.leaderNo = leaderNo;
	}
	public String getLeaderNo() {
		return leaderNo;
	}
	/**
	 * @param historyCn the historyCn to set
	 */
	public void setHistoryCn(String historyCn) {
		this.historyCn = historyCn;
	}
	/**
	 * @return the historyCn
	 */
	public String getHistoryCn() {
		return historyCn;
	}
	/**
	 * @param historyStat the historyStat to set
	 */
	public void setHistoryStat(String historyStat) {
		this.historyStat = historyStat;
	}
	/**
	 * @return the historyStat
	 */
	public String getHistoryStat() {
		return historyStat;
	}
	/**
	 * @param rootUrl the rootUrl to set
	 */
	public void setRootUrl(String rootUrl) {
		this.rootUrl = rootUrl;
	}
	/**
	 * @return the rootUrl
	 */
	public String getRootUrl() {
		return rootUrl;
	}

	public void setAlwaysViewYn(String alwaysViewYn) {
		this.alwaysViewYn = alwaysViewYn;
	}

	public String getAlwaysViewYn() {
		return alwaysViewYn;
	}
	public String getAttachFileId() {
		return attachFileId;
	}
	public void setAttachFileId(String attachFileId) {
		this.attachFileId = attachFileId;
	}
}
