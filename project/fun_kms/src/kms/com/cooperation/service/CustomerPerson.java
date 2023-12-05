package kms.com.cooperation.service;

import org.apache.commons.lang.builder.ToStringBuilder;

public class CustomerPerson {
	private Integer no;
	private String custId;
	private String personNm;
	private String personEmail;
	private String personHpno;
	private String personTelno;
	private String personNote;
	
	private boolean isDeleted = false;
	
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
	 * @return the custId
	 */
	public String getCustId() {
		return custId;
	}
	/**
	 * @param custId the custId to set
	 */
	public void setCustId(String custId) {
		this.custId = custId;
	}

	/**
	 * @return the personNm
	 */
	public String getPersonNm() {
		return personNm;
	}
	/**
	 * @param personNm the personNm to set
	 */
	public void setPersonNm(String personNm) {
		this.personNm = personNm;
	}
	/**
	 * @return the personEmail
	 */
	public String getPersonEmail() {
		return personEmail;
	}
	/**
	 * @param personEmail the personEmail to set
	 */
	public void setPersonEmail(String personEmail) {
		this.personEmail = personEmail;
	}
	/**
	 * @return the personHpno
	 */
	public String getPersonHpno() {
		return personHpno;
	}
	/**
	 * @param personHpno the personHpno to set
	 */
	public void setPersonHpno(String personHpno) {
		this.personHpno = personHpno;
	}
	/**
	 * @return the personTelno
	 */
	public String getPersonTelno() {
		return personTelno;
	}
	/**
	 * @param personTelno the personTelno to set
	 */
	public void setPersonTelno(String personTelno) {
		this.personTelno = personTelno;
	}
	/**
	 * @return the personNote
	 */
	public String getPersonNote() {
		return personNote;
	}
	/**
	 * @param personNote the personNote to set
	 */
	public void setPersonNote(String personNote) {
		this.personNote = personNote;
	}
	/**
	 * @return the isDeleted
	 */
	public boolean isDeleted() {
		return isDeleted;
	}
	/**
	 * @param isDeleted the isDeleted to set
	 */
	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
	
	
}
