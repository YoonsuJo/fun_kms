package kms.com.common.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

@SuppressWarnings("serial")
public class Dining implements Serializable {

	private Integer no;
	
	private String dinYear;
	
	private Integer dinMoney;
	
	private Integer dinDate;
	
	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public String getDinYear() {
		return dinYear;
	}

	public void setDinYear(String dinYear) {
		this.dinYear = dinYear;
	}

	public Integer getDinMoney() {
		return dinMoney;
	}

	public void setDinMoney(Integer dinMoney) {
		this.dinMoney = dinMoney;
	}

	public Integer getDinDate() {
		return dinDate;
	}

	public void setDinDate(Integer dinDate) {
		this.dinDate = dinDate;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}

}
