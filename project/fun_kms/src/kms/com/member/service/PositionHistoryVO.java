package kms.com.member.service;

import kms.com.common.utils.CommonUtil;

public class PositionHistoryVO {
	
	private Integer no = 0;
	private Integer userNo = 0;
	private String chngCode = "";
	private String bfrRankId = "";
	private String bfrCompId = "";
	private String bfrOrgnztId = "";
	private String bfrPosition = "";
	private String aftRankId = "";
	private String aftCompId = "";
	private String aftOrgnztId = "";
	private String aftPosition = "";
	private String chngDt = "";
	private String note = "";
	private Integer adminNo = 0;
	
	private String bfrRankNm = "";
	private String bfrCompNm = "";
	private String bfrOrgnztNm = "";
	private String aftRankNm = "";
	private String aftCompNm = "";
	private String aftOrgnztNm = "";
	private String aftPositionNm = "";
	private String headNm = "";
	private String subheadNm = "";
	private String adminNm = "";
	
	private String userNm = "";
	private String userId = "";
	
	private String lastYn = "";
	
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
	 * @return the chngCode
	 */
	public String getChngCode() {
		return chngCode;
	}
	public String getChngCodePrint() {
		if (chngCode == null) return "";
		
		if (chngCode.equals("EN")) return "입사";
		else if (chngCode.equals("RT")) return "퇴직";
		else if (chngCode.equals("RE")) return "재입사";
		else if (chngCode.equals("LV")) return "휴직";
		else if (chngCode.equals("BK")) return "복귀";
		else if (chngCode.equals("CH"))  return "변경";
		
		return chngCode;
	}
	public String getWorkSt() {
		if (chngCode.equals("EN")) return "W";
		else if (chngCode.equals("RT")) return "R";
		else if (chngCode.equals("RE")) return "W";
		else if (chngCode.equals("LV")) return "L";
		else if (chngCode.equals("BK")) return "W";
		else if (chngCode.equals("CH")) return "W";
		
		else return "";
	}
	/**
	 * @param chngCode the chngCode to set
	 */
	public void setChngCode(String chngCode) {
		this.chngCode = chngCode;
	}
	/**
	 * @return the bfrRankId
	 */
	public String getBfrRankId() {
		return bfrRankId;
	}
	/**
	 * @param bfrRankId the bfrRankId to set
	 */
	public void setBfrRankId(String bfrRankId) {
		this.bfrRankId = bfrRankId;
	}
	/**
	 * @return the bfrOrgnztId
	 */
	public String getBfrOrgnztId() {
		return bfrOrgnztId;
	}
	/**
	 * @param bfrOrgnztId the bfrOrgnztId to set
	 */
	public void setBfrOrgnztId(String bfrOrgnztId) {
		this.bfrOrgnztId = bfrOrgnztId;
	}
	/**
	 * @return the bfrPosition
	 */
	public String getBfrPosition() {
		return bfrPosition;
	}
	/**
	 * @param bfrPosition the bfrPosition to set
	 */
	public void setBfrPosition(String bfrPosition) {
		this.bfrPosition = bfrPosition;
	}
	/**
	 * @return the aftRankId
	 */
	public String getAftRankId() {
		return aftRankId;
	}
	/**
	 * @param aftRankId the aftRankId to set
	 */
	public void setAftRankId(String aftRankId) {
		this.aftRankId = aftRankId;
	}
	/**
	 * @return the aftOrgnztId
	 */
	public String getAftOrgnztId() {
		return aftOrgnztId;
	}
	/**
	 * @param aftOrgnztId the aftOrgnztId to set
	 */
	public void setAftOrgnztId(String aftOrgnztId) {
		this.aftOrgnztId = aftOrgnztId;
	}
	/**
	 * @return the aftPosition
	 */
	public String getAftPosition() {
		return aftPosition;
	}
	public String getAftPositionPrint() {
		
		if (aftPosition == null) {
			return "-";
		} else if (aftPosition.equals("H")) {
			return headNm;
		} else if (aftPosition.equals("S")) {
			return subheadNm;
		} else if (aftPosition.equals("N")) {
			return "-";
		} else if (aftPosition.equals("D")) {
			return "대표";
		} else {
			return aftPosition;
		}
	}
	/**
	 * @param aftPosition the aftPosition to set
	 */
	public void setAftPosition(String aftPosition) {
		this.aftPosition = aftPosition;
	}
	/**
	 * @return the chngDt
	 */
	public String getChngDt() {
		return chngDt;
	}
	public String getChngDtPrint() {
		return CommonUtil.getDateType(chngDt);
	}
	/**
	 * @param chngDt the chngDt to set
	 */
	public void setChngDt(String chngDt) {
		this.chngDt = chngDt;
	}
	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}
	/**
	 * @return the adminNo
	 */
	public Integer getAdminNo() {
		return adminNo;
	}
	/**
	 * @param adminNo the adminNo to set
	 */
	public void setAdminNo(Integer adminNo) {
		this.adminNo = adminNo;
	}

	/**
	 * @return the bfrRankNm
	 */
	public String getBfrRankNm() {
		return bfrRankNm;
	}
	/**
	 * @param bfrRankNm the bfrRankNm to set
	 */
	public void setBfrRankNm(String bfrRankNm) {
		this.bfrRankNm = bfrRankNm;
	}
	/**
	 * @return the bfrOrgnztNm
	 */
	public String getBfrOrgnztNm() {
		return bfrOrgnztNm;
	}
	/**
	 * @param bfrOrgnztNm the bfrOrgnztNm to set
	 */
	public void setBfrOrgnztNm(String bfrOrgnztNm) {
		this.bfrOrgnztNm = bfrOrgnztNm;
	}
	/**
	 * @return the aftRankNm
	 */
	public String getAftRankNm() {
		return aftRankNm;
	}
	/**
	 * @param aftRankNm the aftRankNm to set
	 */
	public void setAftRankNm(String aftRankNm) {
		this.aftRankNm = aftRankNm;
	}
	/**
	 * @return the aftOrgnztNm
	 */
	public String getAftOrgnztNm() {
		return aftOrgnztNm;
	}
	/**
	 * @param aftOrgnztNm the aftOrgnztNm to set
	 */
	public void setAftOrgnztNm(String aftOrgnztNm) {
		this.aftOrgnztNm = aftOrgnztNm;
	}
	/**
	 * @return the aftPositionNm
	 */
	public String getAftPositionNm() {
		return aftPositionNm;
	}
	/**
	 * @param aftPositionNm the aftPositionNm to set
	 */
	public void setAftPositionNm(String aftPositionNm) {
		this.aftPositionNm = aftPositionNm;
	}
	/**
	 * @return the headNm
	 */
	public String getHeadNm() {
		return headNm;
	}
	/**
	 * @param headNm the headNm to set
	 */
	public void setHeadNm(String headNm) {
		this.headNm = headNm;
	}
	/**
	 * @return the subheadNm
	 */
	public String getSubheadNm() {
		return subheadNm;
	}
	/**
	 * @param subheadNm the subheadNm to set
	 */
	public void setSubheadNm(String subheadNm) {
		this.subheadNm = subheadNm;
	}
	/**
	 * @return the adminNm
	 */
	public String getAdminNm() {
		return adminNm;
	}
	/**
	 * @param adminNm the adminNm to set
	 */
	public void setAdminNm(String adminNm) {
		this.adminNm = adminNm;
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
	 * @return the lastYn
	 */
	public String getLastYn() {
		return lastYn;
	}
	/**
	 * @param lastYn the lastYn to set
	 */
	public void setLastYn(String lastYn) {
		this.lastYn = lastYn;
	}
	/**
	 * @return the bfrCompId
	 */
	public String getBfrCompId() {
		return bfrCompId;
	}
	/**
	 * @param bfrCompId the bfrCompId to set
	 */
	public void setBfrCompId(String bfrCompId) {
		this.bfrCompId = bfrCompId;
	}
	/**
	 * @return the aftCompId
	 */
	public String getAftCompId() {
		return aftCompId;
	}
	/**
	 * @param aftCompId the aftCompId to set
	 */
	public void setAftCompId(String aftCompId) {
		this.aftCompId = aftCompId;
	}
	/**
	 * @return the bfrCompNm
	 */
	public String getBfrCompNm() {
		return bfrCompNm;
	}
	/**
	 * @param bfrCompNm the bfrCompNm to set
	 */
	public void setBfrCompNm(String bfrCompNm) {
		this.bfrCompNm = bfrCompNm;
	}
	/**
	 * @return the aftCompNm
	 */
	public String getAftCompNm() {
		return aftCompNm;
	}
	/**
	 * @param aftCompNm the aftCompNm to set
	 */
	public void setAftCompNm(String aftCompNm) {
		this.aftCompNm = aftCompNm;
	}


}
