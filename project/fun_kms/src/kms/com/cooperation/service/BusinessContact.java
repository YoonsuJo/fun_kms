package kms.com.cooperation.service;

import kms.com.common.utils.CommonUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

public class BusinessContact {
	
	private String bcId;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String prjId;
	private String prjNm;
	private String prjCd;
	private String bcSj;
	private String bcCn;
	private String attachFileId;
	private String regDt;
	private String modDt;
	private String smsYn;
	
	//2013.08.20 김대현 PUSH 적용
	private String pushYn;
	
	private String interestYn;
	private String commentYn;
	private String useAt;
	private Integer leaderNo;
	private String[] receiveTyp; //recieve 아니고 receive 임. DB랑 코드랑 온데만데 RECIEVE_TYP 이라고 적어놔서 고칠수도 없음..
	
	//2013.08.13 업무연락 알람 ON/OFF
	private String alarmYn;
	
		
	/**
	 * @return the bcId
	 */
	public String getBcId() {
		return bcId;
	}
	/**
	 * @param bcId the bcId to set
	 */
	public void setBcId(String bcId) {
		this.bcId = bcId;
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
	 * @return the bcSj
	 */
	public String getBcSj() {
		return bcSj;
	}
	/**
	 * @param bcSj the bcSj to set
	 */
	public void setBcSj(String bcSj) {
		this.bcSj = bcSj;
	}
	/**
	 * @return the bcCn
	 */
	public String getBcCn() {
		return bcCn;
	}
	/**
	 * @param bcCn the bcCn to set
	 */
	public void setBcCn(String bcCn) {
		this.bcCn = bcCn;
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
	public String getRegDtShort() {
		return CommonUtil.getDateType(regDt);
	}
	/**
	 * @param regDt the regDt to set
	 */
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	/**
	 * @return the modDt
	 */
	public String getModDt() {
		return modDt;
	}
	public String getModDtShort() {
		return CommonUtil.getDateType(modDt);
	}
	/**
	 * @param modDt the modDt to set
	 */
	public void setModDt(String modDt) {
		this.modDt = modDt;
	}
	/**
	 * @return the smsYn
	 */
	public String getSmsYn() {
		return smsYn;
	}
	/**
	 * @param smsYn the smsYn to set
	 */
	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
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
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public void setLeaderNo(Integer leaderNo) {
		this.leaderNo = leaderNo;
	}
	public Integer getLeaderNo() {
		return leaderNo;
	}
	public void setCommentYn(String commentYn) {
		this.commentYn = commentYn;
	}
	public String getCommentYn() {
		return commentYn;
	}
	public void setReceiveTyp(String[] receiveTyp) {
		this.receiveTyp = receiveTyp;
	}
	public String[] getReceiveTyp() {
		return receiveTyp;
	}
	public boolean isWrite() {
		if(receiveTyp==null)
			return false;
		for (int i=0; i<receiveTyp.length; i++) {
			if (receiveTyp[i].equals("WR"))
				return true;
		}
		return false;
	}
	public boolean isReceive() {
		if(receiveTyp==null)
			return false;
		for (int i=0; i<receiveTyp.length; i++) {
			if (receiveTyp[i].equals("RE"))
				return true;
		}
		return false;
	}
	public boolean isReference() {
		if(receiveTyp==null)
			return false;
		for (int i=0; i<receiveTyp.length; i++) {
			if (receiveTyp[i].equals("RF"))
				return true;
		}
		return false;
	}
	public void setAlarmYn(String alarmYn) {
		this.alarmYn = alarmYn;
	}
	public String getAlarmYn() {
		return alarmYn;
	}
	public void setPushYn(String pushYn) {
		this.pushYn = pushYn;
	}
	public String getPushYn() {
		return pushYn;
	}
}
