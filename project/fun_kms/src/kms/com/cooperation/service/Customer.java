package kms.com.cooperation.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Customer {
	private String custId;
	private String custNm;
	private Integer userNoReg;
	private String userNmReg;
	private String userIdReg;
	private Integer userNoMod;
	private String userNmMod;
	private String userIdMod;
	private String regDt;
	private String modDt;
	private String custBusiNo;
	private String custRepNm;
	private String custAdres;
	private String custTelno;
	private String custFaxno;
	private String custBusiCond;
	private String custBusiTyp;
	private String note;
	
	private String bankNm;
	private String bankNo;
	private String bankUserNm;
	
	private String atchFileId;
	
	private String taxEmail1;
	private String taxUserNm1;
	private String taxTelno1;
	private String taxEmail2;
	private String taxUserNm2;
	private String taxTelno2;
	private String taxEmail3;
	private String taxUserNm3;
	private String taxTelno3;
	private String taxEmail4;
	private String taxUserNm4;
	private String taxTelno4;
	private String taxEmail5;
	private String taxUserNm5;
	private String taxTelno5;
	
	private List<Map<String, Object>> taxList = new ArrayList<Map<String, Object>>();
	
	private String useAt;
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
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
	 * @return the custNm
	 */
	public String getCustNm() {
		return custNm;
	}

	/**
	 * @param custNm the custNm to set
	 */
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	/**
	 * @return the userNoReg
	 */
	public Integer getUserNoReg() {
		return userNoReg;
	}
	/**
	 * @param userNoReg the userNoReg to set
	 */
	public void setUserNoReg(Integer userNoReg) {
		this.userNoReg = userNoReg;
	}
	/**
	 * @return the userNmReg
	 */
	public String getUserNmReg() {
		return userNmReg;
	}
	/**
	 * @param userNmReg the userNmReg to set
	 */
	public void setUserNmReg(String userNmReg) {
		this.userNmReg = userNmReg;
	}
	/**
	 * @return the userIdReg
	 */
	public String getUserIdReg() {
		return userIdReg;
	}
	/**
	 * @param userIdReg the userIdReg to set
	 */
	public void setUserIdReg(String userIdReg) {
		this.userIdReg = userIdReg;
	}
	/**
	 * @return the userNoMod
	 */
	public Integer getUserNoMod() {
		return userNoMod;
	}
	/**
	 * @param userNoMod the userNoMod to set
	 */
	public void setUserNoMod(Integer userNoMod) {
		this.userNoMod = userNoMod;
	}
	/**
	 * @return the userNmMod
	 */
	public String getUserNmMod() {
		return userNmMod;
	}
	/**
	 * @param userNmMod the userNmMod to set
	 */
	public void setUserNmMod(String userNmMod) {
		this.userNmMod = userNmMod;
	}
	/**
	 * @return the userIdMod
	 */
	public String getUserIdMod() {
		return userIdMod;
	}
	/**
	 * @param userIdMod the userIdMod to set
	 */
	public void setUserIdMod(String userIdMod) {
		this.userIdMod = userIdMod;
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
	 * @return the modDt
	 */
	public String getModDt() {
		return modDt;
	}
	/**
	 * @param modDt the modDt to set
	 */
	public void setModDt(String modDt) {
		this.modDt = modDt;
	}
	/**
	 * @return the custBusiNo
	 */
	public String getCustBusiNo() {
		return custBusiNo;
	}
	/**
	 * @param custBusiNo the custBusiNo to set
	 */
	public void setCustBusiNo(String custBusiNo) {
		this.custBusiNo = custBusiNo;
	}
	/**
	 * @return the custRepNm
	 */
	public String getCustRepNm() {
		return custRepNm;
	}
	/**
	 * @param custRepNm the repNm to set
	 */
	public void setCustRepNm(String custRepNm) {
		this.custRepNm = custRepNm;
	}
	/**
	 * @return the custAdres
	 */
	public String getCustAdres() {
		return custAdres;
	}
	/**
	 * @param custAdres the custAdres to set
	 */
	public void setCustAdres(String custAdres) {
		this.custAdres = custAdres;
	}
	/**
	 * @return the custTelno
	 */
	public String getCustTelno() {
		return custTelno;
	}
	/**
	 * @param custTelno the custTelno to set
	 */
	public void setCustTelno(String custTelno) {
		this.custTelno = custTelno;
	}
	/**
	 * @return the custFaxno
	 */
	public String getCustFaxno() {
		return custFaxno;
	}
	/**
	 * @param custFaxno the custFaxno to set
	 */
	public void setCustFaxno(String custFaxno) {
		this.custFaxno = custFaxno;
	}
	/**
	 * @return the custBusiCond
	 */
	public String getCustBusiCond() {
		return custBusiCond;
	}
	/**
	 * @param custBusiCond the custBusiCond to set
	 */
	public void setCustBusiCond(String custBusiCond) {
		this.custBusiCond = custBusiCond;
	}
	/**
	 * @return the custBusiTyp
	 */
	public String getCustBusiTyp() {
		return custBusiTyp;
	}
	/**
	 * @param custBusiTyp the custBusiTyp to set
	 */
	public void setCustBusiTyp(String custBusiTyp) {
		this.custBusiTyp = custBusiTyp;
	}
	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	public String getNotePrint() {
		if (note == null) return "";
		else return note.replace("\r\n", "<br/>");
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}
	/**
	 * @return the bankNm
	 */
	public String getBankNm() {
		return bankNm;
	}
	/**
	 * @param bankNm the bankNm to set
	 */
	public void setBankNm(String bankNm) {
		this.bankNm = bankNm;
	}
	/**
	 * @return the bankNo
	 */
	public String getBankNo() {
		return bankNo;
	}
	/**
	 * @param bankNo the bankNo to set
	 */
	public void setBankNo(String bankNo) {
		this.bankNo = bankNo;
	}
	/**
	 * @return the bankUserNm
	 */
	public String getBankUserNm() {
		return bankUserNm;
	}
	/**
	 * @param bankUserNm the bankUserNm to set
	 */
	public void setBankUserNm(String bankUserNm) {
		this.bankUserNm = bankUserNm;
	}
	/**
	 * @return the atchFileId
	 */
	public String getAtchFileId() {
		return atchFileId;
	}
	/**
	 * @param atchFileId the atchFileId to set
	 */
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	/**
	 * @return the taxEmail1
	 */
	public String getTaxEmail1() {
		return taxEmail1;
	}
	/**
	 * @param taxEmail1 the taxEmail1 to set
	 */
	public void setTaxEmail1(String taxEmail1) {
		this.taxEmail1 = taxEmail1;
	}
	/**
	 * @return the taxUserNm1
	 */
	public String getTaxUserNm1() {
		return taxUserNm1;
	}
	/**
	 * @param taxUserNm1 the taxUserNm1 to set
	 */
	public void setTaxUserNm1(String taxUserNm1) {
		this.taxUserNm1 = taxUserNm1;
	}
	/**
	 * @return the taxTelno1
	 */
	public String getTaxTelno1() {
		return taxTelno1;
	}
	/**
	 * @param taxTelno1 the taxTelno1 to set
	 */
	public void setTaxTelno1(String taxTelno1) {
		this.taxTelno1 = taxTelno1;
	}
	/**
	 * @return the taxEmail2
	 */
	public String getTaxEmail2() {
		return taxEmail2;
	}
	/**
	 * @param taxEmail2 the taxEmail2 to set
	 */
	public void setTaxEmail2(String taxEmail2) {
		this.taxEmail2 = taxEmail2;
	}
	/**
	 * @return the taxUserNm2
	 */
	public String getTaxUserNm2() {
		return taxUserNm2;
	}
	/**
	 * @param taxUserNm2 the taxUserNm2 to set
	 */
	public void setTaxUserNm2(String taxUserNm2) {
		this.taxUserNm2 = taxUserNm2;
	}
	/**
	 * @return the taxTelno2
	 */
	public String getTaxTelno2() {
		return taxTelno2;
	}
	/**
	 * @param taxTelno2 the taxTelno2 to set
	 */
	public void setTaxTelno2(String taxTelno2) {
		this.taxTelno2 = taxTelno2;
	}
	/**
	 * @return the taxEmail3
	 */
	public String getTaxEmail3() {
		return taxEmail3;
	}
	/**
	 * @param taxEmail3 the taxEmail3 to set
	 */
	public void setTaxEmail3(String taxEmail3) {
		this.taxEmail3 = taxEmail3;
	}
	/**
	 * @return the taxUserNm3
	 */
	public String getTaxUserNm3() {
		return taxUserNm3;
	}
	/**
	 * @param taxUserNm3 the taxUserNm3 to set
	 */
	public void setTaxUserNm3(String taxUserNm3) {
		this.taxUserNm3 = taxUserNm3;
	}
	/**
	 * @return the taxTelno3
	 */
	public String getTaxTelno3() {
		return taxTelno3;
	}
	/**
	 * @param taxTelno3 the taxTelno3 to set
	 */
	public void setTaxTelno3(String taxTelno3) {
		this.taxTelno3 = taxTelno3;
	}
	/**
	 * @return the taxEmail4
	 */
	public String getTaxEmail4() {
		return taxEmail4;
	}
	/**
	 * @param taxEmail4 the taxEmail4 to set
	 */
	public void setTaxEmail4(String taxEmail4) {
		this.taxEmail4 = taxEmail4;
	}
	/**
	 * @return the taxUserNm4
	 */
	public String getTaxUserNm4() {
		return taxUserNm4;
	}
	/**
	 * @param taxUserNm4 the taxUserNm4 to set
	 */
	public void setTaxUserNm4(String taxUserNm4) {
		this.taxUserNm4 = taxUserNm4;
	}
	/**
	 * @return the taxTelno4
	 */
	public String getTaxTelno4() {
		return taxTelno4;
	}
	/**
	 * @param taxTelno4 the taxTelno4 to set
	 */
	public void setTaxTelno4(String taxTelno4) {
		this.taxTelno4 = taxTelno4;
	}
	/**
	 * @return the taxEmail5
	 */
	public String getTaxEmail5() {
		return taxEmail5;
	}
	/**
	 * @param taxEmail5 the taxEmail5 to set
	 */
	public void setTaxEmail5(String taxEmail5) {
		this.taxEmail5 = taxEmail5;
	}
	/**
	 * @return the taxUserNm5
	 */
	public String getTaxUserNm5() {
		return taxUserNm5;
	}
	/**
	 * @param taxUserNm5 the taxUserNm5 to set
	 */
	public void setTaxUserNm5(String taxUserNm5) {
		this.taxUserNm5 = taxUserNm5;
	}
	/**
	 * @return the taxTelno5
	 */
	public String getTaxTelno5() {
		return taxTelno5;
	}
	/**
	 * @param taxTelno5 the taxTelno5 to set
	 */
	public void setTaxTelno5(String taxTelno5) {
		this.taxTelno5 = taxTelno5;
	}
	/**
	 * @return the taxList
	 */
	public List<Map<String, Object>> getTaxList() {
		if (this.taxList.equals(new ArrayList<Map<String, Object>>())) setTaxList();
		
		return taxList;
	}

	/**
	 * @param taxList the taxList to set
	 */
	public void setTaxList(List<Map<String, Object>> taxList) {
		this.taxList = taxList;
	}
	public void setTaxList() {
		
		if ("".equals(this.taxTelno1) == false || "".equals(this.taxEmail1) == false || "".equals(this.taxUserNm1) == false) {
			Map<String, Object> e = new HashMap<String, Object>();
			e.put("taxTelno", this.taxTelno1);
			e.put("taxEmail", this.taxEmail1);
			e.put("taxUserNm", this.taxUserNm1);
			
			this.taxList.add(e);
		}
		if ("".equals(this.taxTelno2) == false || "".equals(this.taxEmail2) == false || "".equals(this.taxUserNm2) == false) {
			Map<String, Object> e = new HashMap<String, Object>();
			e.put("taxTelno", this.taxTelno2);
			e.put("taxEmail", this.taxEmail2);
			e.put("taxUserNm", this.taxUserNm2);
			
			this.taxList.add(e);
		}
		if ("".equals(this.taxTelno3) == false || "".equals(this.taxEmail3) == false || "".equals(this.taxUserNm3) == false) {
			Map<String, Object> e = new HashMap<String, Object>();
			e.put("taxTelno", this.taxTelno3);
			e.put("taxEmail", this.taxEmail3);
			e.put("taxUserNm", this.taxUserNm3);
			
			this.taxList.add(e);
		}
		if ("".equals(this.taxTelno4) == false || "".equals(this.taxEmail4) == false || "".equals(this.taxUserNm4) == false) {
			Map<String, Object> e = new HashMap<String, Object>();
			e.put("taxTelno", this.taxTelno4);
			e.put("taxEmail", this.taxEmail4);
			e.put("taxUserNm", this.taxUserNm4);
			
			this.taxList.add(e);
		}
		if ("".equals(this.taxTelno5) == false || "".equals(this.taxEmail5) == false || "".equals(this.taxUserNm5) == false) {
			Map<String, Object> e = new HashMap<String, Object>();
			e.put("taxTelno", this.taxTelno5);
			e.put("taxEmail", this.taxEmail5);
			e.put("taxUserNm", this.taxUserNm5);
			
			this.taxList.add(e);
		}
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
	
}
