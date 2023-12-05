package kms.com.cooperation.service;

import org.apache.commons.lang.builder.ToStringBuilder;

public class MeetingRoomComment {
	private Integer no;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String mtId;
	private String mtCommentCn;
	private String attachFileId;
	private String regDt;
	private String udtDt;
	private String useAt;
	
	private String type;
    private boolean isModified = false;
    
    public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
    
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
	 * @return the bcCommentCn
	 */
	public String getMtCommentCn() {
		return mtCommentCn;
	}
	public String getMtCommentCnPrint() {
		return mtCommentCn.replace("\r\n", "<br/>");
	}
	/**
	 * @param bcCommentCn the bcCommentCn to set
	 */
	public void setMtCommentCn(String mtCommentCn) {
		this.mtCommentCn = mtCommentCn;
	}
	/**
	 * @return the attachFileId
	 */
	public String getAttachFileId() {
		return attachFileId;
	}
	/**
	 * @param attachFileId the attachFileId to set
	 */
	public void setAttachFileId(String attachFileId) {
		this.attachFileId = attachFileId;
	}
	/**
	 * @return the regDt
	 */
	public String getRegDt() {
		return regDt;
	}
	/**
	 * @param regDt the regDt to set
	 */
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getUdtDt() {
		if (udtDt == null || udtDt.equals(""))
			return getRegDt();
		return udtDt;
	}

	public void setUdtDt(String udtDt) {
		this.udtDt = udtDt;
	}

	/**
	 * @return the useAt
	 */
	public String getUseAt() {
		return useAt;
	}
	/**
	 * @param useAt the useAt to set
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return the isModified
	 */
	public boolean isModified() {
		return isModified;
	}
	/**
	 * @param isModified the isModified to set
	 */
	public void setModified(boolean isModified) {
		this.isModified = isModified;
	}
	
	
	
}
