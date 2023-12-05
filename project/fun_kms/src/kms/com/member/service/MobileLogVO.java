package kms.com.member.service;

public class MobileLogVO {
	private int id;
	private int user_no;
	private String connect_time;
	private String connect_ip;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getConnect_time() {
		return connect_time;
	}
	public void setConnect_time(String connect_time) {
		this.connect_time = connect_time;
	}
	public String getConnect_ip() {
		return connect_ip;
	}
	public void setConnect_ip(String connect_ip) {
		this.connect_ip = connect_ip;
	}
	
}
