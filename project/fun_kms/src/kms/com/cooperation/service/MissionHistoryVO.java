package kms.com.cooperation.service;

/**
 * @Class Name : MissionVO.java
 * @Description : MissionController class
 * @Modification Information
 *
 * @author 김대현
 * @since 2013.08.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class MissionHistoryVO{
	private Integer historyNo;
	private String missionId;
    private Integer writerNo;	
	private String writerNm;
	private String writerId;
	
    private Integer leaderNo;	
    private String regDt = "";
    private String historyStat = ""; //담당자 변경 - CL 예정일 변경 - CD  미완료 - P  완료처리 - E 등록 - W  수정 - U
    private String historyCn = ""; 
    
    
	public Integer getHistoryNo() {
		return historyNo;
	}
	public String getMissionId() {
		return missionId;
	}
	public void setMissionId(String missionId) {
		this.missionId = missionId;
	}
	public void setHistoryNo(Integer historyNo) {
		this.historyNo = historyNo;
	}
	public Integer getWriterNo() {
		return writerNo;
	}
	public void setWriterNo(Integer writerNo) {
		this.writerNo = writerNo;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getHistoryStat() {
		return historyStat;
	}
	public void setHistoryStat(String historyStat) {
		this.historyStat = historyStat;
	}
	public String getHistoryCn() {
		return historyCn;
	}
	public void setHistoryCn(String historyCn) {
		this.historyCn = historyCn;
	}
	/**
	 * @param leaderNo the leaderNo to set
	 */
	public void setLeaderNo(Integer leaderNo) {
		this.leaderNo = leaderNo;
	}
	/**
	 * @return the leaderNo
	 */
	public Integer getLeaderNo() {
		return leaderNo;
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

    
	
}
