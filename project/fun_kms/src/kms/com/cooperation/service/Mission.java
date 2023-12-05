package kms.com.cooperation.service;

import java.util.Calendar;



/**
 * @Class Name : Mission.java
 * @Description : Mission class
 * @Modification Information
 *
 * @author 김대현
 * @since 2013.08.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */


public class Mission {
	
	private String typeTree = ""; //마스터 미션 - M 서브 미션 - S
	
	private String missionId = ""; //미션 아이디
	private String prjId = "";      //프로젝트 아이디
	private String prjNm = "";  //프로젝트 이름
	private String prjCd = "";  //프로젝트 코드	
	private String missionNm = ""; //미션명
	private String missionCn = ""; //미션 내용
	private String prntMissionId = "";//상위 미션 아이디
	private String prntMissionNm = "";//상위 미션 이름
	private String prntDueDt = "";//상위 미션 완료 예정일
	private String subUseAt = "";//하위 미션의 사용 여부
	
	
	
	private int missionLv;    //미션 단계
	private String missionTree = ""; //미션 트리
	private Integer leaderNo;   //담당자 사번
	private String leaderNm = ""; //담당자 이름
	private String leaderId = ""; //담당자 ID
	private String regDt = "";      //작성일
	private String modDt = "";      //수정일
	private String dueDt = "";      //완료 예정일
	private String endDt = "";      //완료일
	private String attachFileId = ""; //첨부파일 아이디
	private Integer writerNo;     //작성자 사번
	private String writerNm = ""; //작성자 이름
	private String writerId = ""; //작성자 ID
	private String missionStat = ""; //미션 상태
	private String historyCn = ""; //미션 상태
	private String useAt = ""; //미션 사용YN
	private String chdMissionDt = ""; //하위 미션 완료 예정일
	
	

	
	public String getChdMissionDt() {
		return chdMissionDt;
	}
	public void setChdMissionDt(String chdMissionDt) {
		this.chdMissionDt = chdMissionDt;
	}
	public String getMissionId() {
		return missionId;
	}
	public void setMissionId(String missionId) {
		this.missionId = missionId;
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
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
	public String getMissionNm() {
		return missionNm;
	}
	public void setMissionNm(String missionNm) {
		this.missionNm = missionNm;
	}
	public String getMissionCn() {
		return missionCn;
	}
	public void setMissionCn(String missionCn) {
		this.missionCn = missionCn;
	}
	public String getPrntMissionId() {
		return prntMissionId;
	}
	public void setPrntMissionId(String prntMissionId) {
		this.prntMissionId = prntMissionId;
	}
	public String getPrntMissionNm() {
		return prntMissionNm;
	}
	public void setPrntMissionNm(String prntMissionNm) {
		this.prntMissionNm = prntMissionNm;
	}
	public int getMissionLv() {
		return missionLv;
	}
	public void setMissionLv(int missionLv) {
		this.missionLv = missionLv;
	}
	public String getMissionTree() {
		return missionTree;
	}
	public void setMissionTree(String missionTree) {
		this.missionTree = missionTree;
	}
	public Integer getLeaderNo() {
		return leaderNo;
	}
	public void setLeaderNo(Integer leaderNo) {
		this.leaderNo = leaderNo;
	}
	public String getLeaderNm() {
		return leaderNm;
	}
	public void setLeaderNm(String leaderNm) {
		this.leaderNm = leaderNm;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getModDt() {
		return modDt;
	}
	public void setModDt(String modDt) {
		this.modDt = modDt;
	}
	public String getDueDt() {
		return dueDt;
	}
	public void setDueDt(String dueDt) {
		this.dueDt = dueDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getAttachFileId() {
		return attachFileId;
	}
	public void setAttachFileId(String attachFileId) {
		this.attachFileId = attachFileId;
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

	/**
	 * @param leaderId the leaderId to set
	 */
	public void setLeaderId(String leaderId) {
		this.leaderId = leaderId;
	}
	/**
	 * @return the leaderId
	 */
	public String getLeaderId() {
		return leaderId;
	}
	/**
	 * @param writerId the writerId to set
	 */
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	/**
	 * @return the writerId
	 */
	public String getWriterId() {
		return writerId;
	}
	/**
	 * @param missionStat the missionStat to set
	 */
	public void setMissionStat(String missionStat) {
		this.missionStat = missionStat;
	}
	/**
	 * @return the missionStat
	 */
	public String getMissionStat() {
		return missionStat;
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
	 * @param prntDueDt the prntDueDt to set
	 */
	public void setPrntDueDt(String prntDueDt) {
		this.prntDueDt = prntDueDt;
	}
	/**
	 * @return the prntDueDt
	 */
	public String getPrntDueDt() {
		return prntDueDt;
	}
	/**
	 * @param useAt the useAt to set
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	/**
	 * @return the useAt
	 */
	public String getUseAt() {
		return useAt;
	}
	/**
	 * @param subUseAt the subUseAt to set
	 */
	public void setSubUseAt(String subUseAt) {
		this.subUseAt = subUseAt;
	}
	/**
	 * @return the subUseAt
	 */
	public String getSubUseAt() {
		return subUseAt;
	}
	/**
	 * @param typeTree the typeTree to set
	 */
	public void setTypeTree(String typeTree) {
		this.typeTree = typeTree;
	}
	/**
	 * @return the typeTree
	 */
	public String getTypeTree() {
		return typeTree;
	}


	
	
}
