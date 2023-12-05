package kms.com.member.service;

import org.apache.commons.lang.builder.ToStringBuilder;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

public class WorkStateDetail {
	private Integer userNo;
	private String userNm = "";
	private String userId;
	private String orgnztId;
	private String orgnztNm = "";
	private String orgnztNmFull;
	private String attendCd;
	private String attendDt;
	private String attendTm;
	private String attendIp;
	private String wsPlace;
	private String wsPurpose;
	private String wsId;
	private String wsBgnTm;
	private String wsEndTm;
	private String wsBgnDe;
	private String wsEndDe;
	private String wsTyp;	
	private String rankNm = "";
	
	private String searchDate = CalendarUtil.getToday();
	private String searchDateFrom = CalendarUtil.getToday().substring(0,4) + "0101";
	private String searchDateTo = CalendarUtil.getToday();
	private String searchAttendCd = "";
	private String[] searchAttendCdList;
	private String searchOrgId = "";
	private String searchOrgNm = "";
	private String[] searchOrgIdList;
	private String searchUserMix = "";
	
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
	 * @return the attendCd
	 */
	public String getAttendCd() {
		return attendCd;
	}
	public String getAttendCdPrint() {
		if (attendCd == null) return "미로그인";
		
		if (attendCd.equalsIgnoreCase("AT")) return "출근";
		else if (attendCd.equalsIgnoreCase("EA")) return "조기출근";
		else if (attendCd.equalsIgnoreCase("NT")) return "야근";
		else if (attendCd.equalsIgnoreCase("OT")) return "외근";
		else if (attendCd.equalsIgnoreCase("TR")) return "출장";
		else if (attendCd.equalsIgnoreCase("SD")) return "파견";
		else if (attendCd.equalsIgnoreCase("EN")) return "입사";
		else if (attendCd.equalsIgnoreCase("LT")) return "지각";
		else if (attendCd.equalsIgnoreCase("VC")) return "휴가";
		else if (attendCd.equalsIgnoreCase("ET")) return "면제";
		else if (attendCd.equalsIgnoreCase("HD")) return "주말근무";
		return attendCd;
	}
	/**
	 * @param attendCd the attendCd to set
	 */
	public void setAttendCd(String attendCd) {
		this.attendCd = attendCd;
	}
	/**
	 * @return the attendDt
	 */
	public String getAttendDt() {
		return attendDt;
	}
	public String getAttendDtPrint() {
		return CommonUtil.getDateType(attendDt);
	}
	/**
	 * @param attendDt the attendDt to set
	 */
	public void setAttendDt(String attendDt) {
		this.attendDt = attendDt;
	}
	/**
	 * @return the attendTm
	 */
	public String getAttendTm() {
		return attendTm;
	}
	/**
	 * @param attendTm the attendTm to set
	 */
	public void setAttendTm(String attendTm) {
		this.attendTm = attendTm;
	}
	/**
	 * @return the attendIp
	 */
	public String getAttendIp() {
		return attendIp;
	}
	/**
	 * @param attendIp the attendIp to set
	 */
	public void setAttendIp(String attendIp) {
		this.attendIp = attendIp;
	}
	/**
	 * @return the wsPlace
	 */
	public String getWsPlace() {
		return wsPlace;
	}
	/**
	 * @param wsPlace the wsPlace to set
	 */
	public void setWsPlace(String wsPlace) {
		this.wsPlace = wsPlace;
	}
	/**
	 * @return the wsPurpose
	 */
	public String getWsPurpose() {
		return wsPurpose;
	}
	/**
	 * @param wsPurpose the wsPurpose to set
	 */
	public void setWsPurpose(String wsPurpose) {
		this.wsPurpose = wsPurpose;
	}
	public String getAttendNote() {
		if (attendCd == null) return "미로그인";
		
		if (attendCd.equalsIgnoreCase("VC")) return wsPurpose;
		else if (attendCd.equalsIgnoreCase("OT")) return wsPlace;
		else if (attendCd.equalsIgnoreCase("TR")) return wsPlace;
		else if (attendCd.equalsIgnoreCase("SD")) return wsPlace;
		else if (attendCd.equalsIgnoreCase("NT")) return wsPurpose + " (" + wsBgnTm + "시)";
		else if (attendCd.equalsIgnoreCase("AT")) 
			if(("N").equals(wsTyp)) return "전일야근: " + wsPurpose + " (" + wsBgnTm + "시)";
			else return " ";
		else if (attendCd.equalsIgnoreCase("LT")) 
			if(("N").equals(wsTyp)) return "전일야근: " + wsPurpose + " (" + wsBgnTm + "시)";
			else return " ";
		else if (attendCd.equalsIgnoreCase("ET")) return wsPurpose;
		
		return "";
	}
	public String getAttendNotePrint() {
		if (getAttendNote() == null) return "";
		else return getAttendNote().replace("\r\n", "<br/>");
	}
	public String getAttendNoteDetail() {
		if (attendCd == null) return "미로그인";
		
		String rs = "";
		rs += orgnztNm + " " + userNm + " " + rankNm + "\r\n";
		
		if (attendCd.equalsIgnoreCase("VC")) 
			rs += "휴가기간 : " + wsBgnDe + getBgnTmVac() + " ~ " + wsEndDe + getEndTmVac() + "\r\n휴가사유 :" + wsPurpose + "\r\n행선지 :" + wsPlace;
		else if (attendCd.equalsIgnoreCase("OT")) 
			rs += "외근시간 : " + wsBgnTm + " ~ " + wsEndTm + "시\r\n목적 :" + wsPurpose + "\r\n장소 :" + wsPlace;
		else if (attendCd.equalsIgnoreCase("TR")) 
			rs += "출장기간 : " + wsBgnDe + " ~ " + wsEndDe + "\r\n목적 :" + wsPurpose + "\r\n장소 :" + wsPlace;
		else if (attendCd.equalsIgnoreCase("SD")) 
			rs += "파견기간 : " + wsBgnDe + " ~ " + wsEndDe + "\r\n목적 :" + wsPurpose + "\r\n장소 :" + wsPlace;
		else if (attendCd.equalsIgnoreCase("NT")) 
			rs += "야근시간 : " + wsBgnTm + "시\r\n야근사유 :" + wsPurpose;
		else if (attendCd.equalsIgnoreCase("AT")) 
			if(("N").equals(wsTyp)) 
				rs += "전일야근: " + wsPurpose + " (" + wsBgnTm + "시)";
			else rs += " ";
		else if (attendCd.equalsIgnoreCase("LT")) 
			if(("N").equals(wsTyp)) 
				rs += "전일야근: " + wsPurpose + " (" + wsBgnTm + "시)";
			else rs += " ";
		else if (attendCd.equalsIgnoreCase("ET")) 
			rs += wsPurpose;
		
		return rs;
	}
	//Detail 붙이고 추가
	public String getAttendNotePrintDetail() {
		if (getAttendNoteDetail() == null) return "";
		else return getAttendNoteDetail().replace("\r\n", "<br/>");
	}
	public String getBgnTmVac() {
		if(wsBgnTm != null && !"".equals(wsBgnTm)){  //김대현 시간을 입력하지 않아 일일근태기록에 오류로 추가
			if(Integer.parseInt(wsBgnTm) < 11 ){
				return " 오전";
			}
			if(Integer.parseInt(wsBgnTm) > 11 ){
				return " 오후";
			}
		}
		return "";
	}
	public String getEndTmVac() {
		if(wsEndTm != null && !"".equals(wsEndTm)){  //김대현 시간을 입력하지 않아 일일근태기록에 오류로 추가
			if(Integer.parseInt(wsEndTm) < 13 ){
				return " 오전";
			}
			if(Integer.parseInt(wsEndTm) > 13 ){
				return " 오후";
			}
		}
		return "";
	}
	
	/**
	 * @return the wsId
	 */
	public String getWsId() {
		return wsId;
	}
	/**
	 * @param wsId the wsId to set
	 */
	public void setWsId(String wsId) {
		this.wsId = wsId;
	}
	public String getWsBgnTm() {
		return wsBgnTm;
	}
	public void setWsBgnTm(String wsBgnTm) {
		this.wsBgnTm = wsBgnTm;
	}
	public String getWsTyp() {
		return wsTyp;
	}
	public String getWsTypPrint() {
		String wsTyp = getWsTyp();
		if (wsTyp == null) return "";
		
		if (wsTyp.equalsIgnoreCase("O")) return "외근";
		else if (wsTyp.equalsIgnoreCase("S")) return "파견";
		else if (wsTyp.equalsIgnoreCase("T")) return "출장";
		else if (wsTyp.equalsIgnoreCase("V")) return "휴가";
		else if (wsTyp.equalsIgnoreCase("N")) return "야근";		
		return wsTyp;
	}
	public void setWsTyp(String wsTyp) {
		this.wsTyp = wsTyp;
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
	 * @return the searchAttendCd
	 */
	public String getSearchAttendCd() {
		return searchAttendCd;
	}
	/**
	 * @param searchAttendCd the searchAttendCd to set
	 */
	public void setSearchAttendCd(String searchAttendCd) {
		this.searchAttendCd = searchAttendCd;
		this.searchAttendCdList = searchAttendCd.split(",");
	}
	/**
	 * @return the searchAttendCdList
	 */
	public String[] getSearchAttendCdList() {
		return searchAttendCdList;
	}
	/**
	 * @param searchAttendCdList the searchAttendCdList to set
	 */
	public void setSearchAttendCdList(String[] searchAttendCdList) {
		this.searchAttendCdList = searchAttendCdList;
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
	public void setOrgnztNmFull(String orgnztNmFull) {
		this.orgnztNmFull = orgnztNmFull;
	}
	public String getOrgnztNmFull() {
		return orgnztNmFull;
	}
	public String getOrgnztNmFullLong() {
		String s = orgnztNmFull.substring(0, orgnztNmFull.length()-1).replace(" ", " > ");
		return s;
	}
	public void setWsEndTm(String wsEndTm) {
		this.wsEndTm = wsEndTm;
	}
	public String getWsEndTm() {
		return wsEndTm;
	}
	public void setWsBgnDe(String wsBgnDe) {
		this.wsBgnDe = wsBgnDe;
	}
	public String getWsBgnDe() {
		return wsBgnDe;
	}
	public void setWsEndDe(String wsEndDe) {
		this.wsEndDe = wsEndDe;
	}
	public String getWsEndDe() {
		return wsEndDe;
	}
	public void setRankNm(String rankNm) {
		this.rankNm = rankNm;
	}
	public String getRankNm() {
		return rankNm;
	}
}
