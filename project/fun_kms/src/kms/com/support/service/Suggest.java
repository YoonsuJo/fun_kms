package kms.com.support.service;

public class Suggest {
	private Integer nttId;
	private String bbsId;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String sgstSt;
	private String regDt;
	private String note;
	/**
	 * @return the nttId
	 */
	public Integer getNttId() {
		return nttId;
	}
	/**
	 * @param nttId the nttId to set
	 */
	public void setNttId(Integer nttId) {
		this.nttId = nttId;
	}
	/**
	 * @return the bbsId
	 */
	public String getBbsId() {
		return bbsId;
	}
	/**
	 * @param bbsId the bbsId to set
	 */
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
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
	 * @return the sgstSt
	 */
	public String getSgstSt() {
		return sgstSt;
	}
	public String getSgstStPrint() {
		if (sgstSt == null || sgstSt.equals("")) {
			return "검토중";
		}
		else if (sgstSt.equalsIgnoreCase("E")) {
			return "검토중";
		} else if (sgstSt.equalsIgnoreCase("C")) {
			return "채택";
		} else if (sgstSt.equalsIgnoreCase("H")) {
			return "평가보류";
		} else if (sgstSt.equalsIgnoreCase("R")) {
			return "기각";
		} else if (sgstSt.equalsIgnoreCase("F")) {
			return "처리완료";
		}
		else return sgstSt;
	}
	
	/**
	 * @param sgstSt the sgstSt to set
	 */
	public void setSgstSt(String sgstSt) {
		this.sgstSt = sgstSt;
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
	
	
}
