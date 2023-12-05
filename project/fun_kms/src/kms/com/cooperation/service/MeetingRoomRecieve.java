package kms.com.cooperation.service;

import org.apache.commons.lang.builder.ToStringBuilder;

public class MeetingRoomRecieve {
	private Integer no;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String mtId;
	private String recieveTyp;
	private String readtime;
	private String interestYn;
	
	private String wrtUser;
	private String recUserMixes;
	private String refUserMixes;
	private String[] recUserIdList;
	private String[] refUserIdList;
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
	 * @return the bcId
	 */
	public String getMtId() {
		return mtId;
	}
	/**
	 * @param bcId the bcId to set
	 */
	public void setMtId(String mtId) {
		this.mtId = mtId;
	}
	/**
	 * @return the recieveTyp
	 */
	public String getRecieveTyp() {
		return recieveTyp;
	}
	public String getRecieveTypPrint() {
		if (recieveTyp == null || recieveTyp.equals("")) return "";
		
		if (recieveTyp.equals("WR")) return "작성자";
		else if (recieveTyp.equals("RE")) return "수신자";
		else if (recieveTyp.equals("RF")) return "참조자";
		else return recieveTyp;
	}
	/**
	 * @param recieveTyp the recieveTyp to set
	 */
	public void setRecieveTyp(String recieveTyp) {
		this.recieveTyp = recieveTyp;
	}
	/**
	 * @return the readtime
	 */
	public String getReadtime() {
		return readtime;
	}
	/**
	 * @param readtime the readtime to set
	 */
	public void setReadtime(String readtime) {
		this.readtime = readtime;
	}
	/**
	 * @return the interestYn
	 */
	public String getInterestYn() {
		return interestYn;
	}
	/**
	 * @param interestYn the interestYn to set
	 */
	public void setInterestYn(String interestYn) {
		this.interestYn = interestYn;
	}
	/**
	 * @return the recUserMixes
	 */
	public String getRecUserMixes() {
		return recUserMixes;
	}
	/**
	 * @param recUserMixes the recUserMixes to set
	 */
	public void setRecUserMixes(String recUserMixes) {
		this.recUserMixes = recUserMixes;
	}
	/**
	 * @return the refUserMixes
	 */
	public String getRefUserMixes() {
		return refUserMixes;
	}
	/**
	 * @param refUserMixes the refUserMixes to set
	 */
	public void setRefUserMixes(String refUserMixes) {
		this.refUserMixes = refUserMixes;
	}
	/**
	 * @return the recUserIdList
	 */
	public String[] getRecUserIdList() {
		return recUserIdList;
	}
	/**
	 * @param recUserIdList the recUserIdList to set
	 */
	public void setRecUserIdList(String[] recUserIdList) {
		this.recUserIdList = recUserIdList;
	}
	/**
	 * @return the refUserIdList
	 */
	public String[] getRefUserIdList() {
		return refUserIdList;
	}
	/**
	 * @param refUserIdList the refUserIdList to set
	 */
	public void setRefUserIdList(String[] refUserIdList) {
		this.refUserIdList = refUserIdList;
	}
	
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setWrtUser(String wrtUser) {
		this.wrtUser = wrtUser;
	}
	public String getWrtUser() {
		return wrtUser;
	}
}
