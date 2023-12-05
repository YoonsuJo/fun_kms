package kms.com.member.service;

public class WorkState {
	private String wsId;
	private Integer userNo;
	private String userId;
	private String userNm;
	private Integer writerNo;
	private String writerId;
	private String writerNm;
	private String orgnztId;
	private String orgnztNm;
	private String offmAdres;
	private String wsTyp;
	private String wsBgnDe;
	private String wsEndDe;
	private String wsBgnTm;
	private String wsEndTm;
	private Integer wsHrCnt;
	private String userTelno;
	private String userMoblphonNo;
	private String wsPlace;
	private String wsPurpose;
	private String regDt;
	private String isInnerNetwork;
	private String userIp;
	private String isRegBefore;
	private String isRegBeforeTen;
	private String attendTm;
	private String docId;
	
	/** vac 휴가 사용 ST_AMPM */
    private int stAmpm = 1;    
    /** ED_AMPM */
    private int edAmpm = 2;
	
	private String excludeLeader;
	private String exceptionUsers; //제외할 사용자 번호
    private String[] exceptionUsersList; //제외할 사용자 번호 리스트
    
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
	 * @return the writerNo
	 */
	public Integer getWriterNo() {
		return writerNo;
	}
	/**
	 * @param writerNo the writerNo to set
	 */
	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
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
	public String getOffmAdres() {
		return offmAdres;
	}
	public void setOffmAdres(String offmAdres) {
		this.offmAdres = offmAdres;
	}
	/**
	 * @param writerNo the writerNo to set
	 */
	public void setWriterNo(Integer writerNo) {
		this.writerNo = writerNo;
	}
	/**
	 * @return the wsTyp
	 */
	public String getWsTyp() {
		return wsTyp;
	}
	public String getWsTypLowerCase() {
		return wsTyp.toLowerCase();
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
	/**
	 * @param wsTyp the wsTyp to set
	 */
	public void setWsTyp(String wsTyp) {
		this.wsTyp = wsTyp;
	}
	/**
	 * @return the wsBgnDe
	 */
	public String getWsBgnDe() {
		return wsBgnDe;
	}
	/**
	 * @param wsBgnDe the wsBgnDe to set
	 */
	public void setWsBgnDe(String wsBgnDe) {
		this.wsBgnDe = wsBgnDe;
	}
	/**
	 * @return the wsEndDe
	 */
	public String getWsEndDe() {
		return wsEndDe;
	}
	/**
	 * @param wsEndDe the wsEndDe to set
	 */
	public void setWsEndDe(String wsEndDe) {
		this.wsEndDe = wsEndDe;
	}
	/**
	 * @return the wsBgnTm
	 */
	public String getWsBgnTm() {
		return wsBgnTm;
	}
	public int getWsBgnTmInteger() {
		if ("".equals(wsBgnTm) || wsBgnTm == null) return 0;
		
		return Integer.parseInt(wsBgnTm);
	}
	/**
	 * @param wsBgnTm the wsBgnTm to set
	 */
	public void setWsBgnTm(String wsBgnTm) {
		this.wsBgnTm = wsBgnTm;
	}
	/**
	 * @return the wsEndTm
	 */
	public String getWsEndTm() {
		return wsEndTm;
	}
	public int getWsEndTmInteger() {
		if ("".equals(wsEndTm) || wsEndTm == null) return 0;
		
		return Integer.parseInt(wsEndTm);
	}
	/**
	 * @param wsEndTm the wsEndTm to set
	 */
	public void setWsEndTm(String wsEndTm) {
		this.wsEndTm = wsEndTm;
	}
	/**
	 * @return the wsHrCnt
	 */
	public Integer getWsHrCnt() {
		return wsHrCnt;
	}
	/**
	 * @param wsHrCnt the wsHrCnt to set
	 */
	public void setWsHrCnt(Integer wsHrCnt) {
		this.wsHrCnt = wsHrCnt;
	}
	/**
	 * @return the userTelno
	 */
	public String getUserTelno() {
		return userTelno;
	}
	/**
	 * @param userTelno the userTelno to set
	 */
	public void setUserTelno(String userTelno) {
		this.userTelno = userTelno;
	}
	/**
	 * @return the userMoblphonNo
	 */
	public String getUserMoblphonNo() {
		return userMoblphonNo;
	}
	/**
	 * @param userMoblphonNo the userMoblphonNo to set
	 */
	public void setUserMoblphonNo(String userMoblphonNo) {
		this.userMoblphonNo = userMoblphonNo;
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
	public void setIsInnerNetwork(String isInnerNetwork) {
		this.isInnerNetwork = isInnerNetwork;
	}
	public String getIsInnerNetwork() {
		return isInnerNetwork;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getRegDt() {
		if(regDt != null)
			return regDt.substring(0, regDt.length()-5);
		return regDt;
	}
	public String getRegDtLong() {
		if(regDt != null)
			return regDt;
		return regDt;
	}
	public void setIsRegBefore(String isRegBefore) {
		this.isRegBefore = isRegBefore;
	}
	public String getIsRegBefore() {
		return isRegBefore;
	}
	public void setIsRegBeforeTen(String isRegBeforeTen) {
		this.isRegBeforeTen = isRegBeforeTen;
	}
	public String getIsRegBeforeTen() {
		return isRegBeforeTen;
	}
	public void setAttendTm(String attendTm) {
		this.attendTm = attendTm;
	}
	public String getAttendTm() {
		return attendTm;
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
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public String getDocId() {
		return docId;
	}
	public void setStAmpm(int stAmpm) {
		this.stAmpm = stAmpm;
	}
	public int getStAmpm() {
		return stAmpm;
	}
	public void setEdAmpm(int edAmpm) {
		this.edAmpm = edAmpm;
	}
	public int getEdAmpm() {
		return edAmpm;
	}

}
