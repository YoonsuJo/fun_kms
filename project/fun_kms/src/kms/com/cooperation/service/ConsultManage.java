package kms.com.cooperation.service;

import java.util.ArrayList;
import java.util.List;

public class ConsultManage extends ConsultManageRecieve{
	
	private String cust_no;
	private String cust_manager;
	private String cust_telno;
	private String cust_email;
	private String typ;
	private String service_typ;
	private String error_typ;
	private String detail_typ;
	private String q_cn;
	private String a_cn;
	private String atch_file_id;
	private String sms_yn;
	private int writer_no;
	private String consult_no;
	private String cust_nm;
	private String reg_dt;
	private String state;
	private String complete_date;
	private String complete_tm;
	private String satisfaction;
	private String jira_yn;
	private String jira_code;
	private String issue_yn;
	private String end_date;
	private String s_cn;
	private String user_nm;
	private String todayChk;
	private String request_id;
	private String receive_typ;
	private String contact_dt;
	private String compny_id;
	private String comp_cn;
	private String comp_file_id;
	private int comp_duration;
	
	public String getCust_no() {
		return cust_no;
	}
	public void setCust_no(String cust_no) {
		this.cust_no = cust_no;
	}
	public String getCust_manager() {
		return cust_manager;
	}
	public void setCust_manager(String cust_manager) {
		this.cust_manager = cust_manager;
	}
	public String getCust_telno() {
		return cust_telno;
	}
	public void setCust_telno(String cust_telno) {
		this.cust_telno = cust_telno;
	}
	public String getCust_email() {
		return cust_email;
	}
	public void setCust_email(String cust_email) {
		this.cust_email = cust_email;
	}
	public String getTyp() {
		return typ;
	}
	public void setTyp(String typ) {
		this.typ = typ;
	}
	public String getService_typ() {
		return service_typ;
	}
	public void setService_typ(String service_typ) {
		this.service_typ = service_typ;
	}
	public String getError_typ() {
		return error_typ;
	}
	public void setError_typ(String error_typ) {
		this.error_typ = error_typ;
	}
	public String getDetail_typ() {
		return detail_typ;
	}
	public void setDetail_typ(String detail_typ) {
		this.detail_typ = detail_typ;
	}
	public String getQ_cn() {
		return q_cn;
	}
	public void setQ_cn(String q_cn) {
		this.q_cn = q_cn;
	}
	public String getA_cn() {
		return a_cn;
	}
	public void setA_cn(String a_cn) {
		this.a_cn = a_cn;
	}
	public String getAtch_file_id() {
		return atch_file_id;
	}
	public void setAtch_file_id(String atch_file_id) {
		this.atch_file_id = atch_file_id;
	}
	public String getSms_yn() {
		return sms_yn;
	}
	public void setSms_yn(String sms_yn) {
		this.sms_yn = sms_yn;
	}
	public int getWriter_no() {
		return writer_no;
	}
	public void setWriter_no(int writer_no) {
		this.writer_no = writer_no;
	}
	public String getConsult_no() {
		return consult_no;
	}
	public void setConsult_no(String consult_no) {
		this.consult_no = consult_no;
	}
	public String getCust_nm() {
		return cust_nm;
	}
	public void setCust_nm(String cust_nm) {
		this.cust_nm = cust_nm;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getComplete_date() {
		return complete_date;
	}
	public void setComplete_date(String complete_date) {
		this.complete_date = complete_date;
	}
	public String getComplete_tm() {
		return complete_tm;
	}
	public void setComplete_tm(String complete_tm) {
		this.complete_tm = complete_tm;
	}
	public String getSatisfaction() {
		return satisfaction;
	}
	public void setSatisfaction(String satisfaction) {
		this.satisfaction = satisfaction;
	}
	public String getJira_yn() {
		return jira_yn;
	}
	public void setJira_yn(String jira_yn) {
		this.jira_yn = jira_yn;
	}
	public String getJira_code() {
		return jira_code;
	}
	public void setJira_code(String jira_code) {
		this.jira_code = jira_code;
	}
	public String getIssue_yn() {
		return issue_yn;
	}
	public void setIssue_yn(String issue_yn) {
		this.issue_yn = issue_yn;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getS_cn() {
		return s_cn;
	}
	public void setS_cn(String s_cn) {
		this.s_cn = s_cn;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getComp_cn() {
		return comp_cn;
	}
	public void setComp_cn(String comp_cn) {
		this.comp_cn = comp_cn;
	}
	public String getComp_file_id() {
		return comp_file_id;
	}
	public void setComp_file_id(String comp_file_id) {
		this.comp_file_id = comp_file_id;
	}
	public int getComp_duration() {
		return comp_duration;
	}
	public void setComp_duration(int comp_duration) {
		this.comp_duration = comp_duration;
	}

	private List<ConsultManageRecieve> chargedList = new ArrayList<ConsultManageRecieve>();
    private List<ConsultManageRecieve> addList = new ArrayList<ConsultManageRecieve>();
    private List<ConsultManageRecieve> compList = new ArrayList<ConsultManageRecieve>();
	
    public void addChargedList(ConsultManageRecieve recieve) {
		this.chargedList.add(recieve);
	}
    
    public void addAddList(ConsultManageRecieve recieve) {
		this.addList.add(recieve);
	}
    
    public void addCompList(ConsultManageRecieve recieve) {
		this.compList.add(recieve);
	}
    
	public List<ConsultManageRecieve> getChargedList() {
		return chargedList;
	}
	public void setChargedList(List<ConsultManageRecieve> chargedList) {
		this.chargedList = chargedList;
	}
	public List<ConsultManageRecieve> getAddList() {
		return addList;
	}
	public void setAddList(List<ConsultManageRecieve> addList) {
		this.addList = addList;
	}
	public List<ConsultManageRecieve> getCompList() {
		return compList;
	}
	public void setCompList(List<ConsultManageRecieve> compList) {
		this.compList = compList;
	}
	public String getTodayChk() {
		return todayChk;
	}
	public void setTodayChk(String todayChk) {
		this.todayChk = todayChk;
	}
	public String getRequest_id() {
		return request_id;
	}
	public void setRequest_id(String request_id) {
		this.request_id = request_id;
	}
	public String getReceive_typ() {
		return receive_typ;
	}
	public void setReceive_typ(String receive_typ) {
		this.receive_typ = receive_typ;
	}
	public String getContact_dt() {
		return contact_dt;
	}
	public void setContact_dt(String contact_dt) {
		this.contact_dt = contact_dt;
	}
	public String getCompny_id() {
		return compny_id;
	}
	public void setCompny_id(String compny_id) {
		this.compny_id = compny_id;
	}
}
