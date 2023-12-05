package kms.com.member.service;

public class Msn {
	private int no;
	private int userNo;
	private String msnTyp;
	private String msnAdres;
	private String command;
	/**
	 * @return the no
	 */
	public int getNo() {
		return no;
	}
	public String getStringNo() {
		return String.valueOf(no);
	}
	/**
	 * @param no the no to set
	 */
	public void setNo(int no) {
		this.no = no;
	}
	/**
	 * @return the userNo
	 */
	public int getUserNo() {
		return userNo;
	}
	public String getStringUserNo() {
		return String.valueOf(userNo);
	}
	/**
	 * @param userNo the userNo to set
	 */
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	/**
	 * @return the msnTyp
	 */
	public String getMsnTyp() {
		return msnTyp;
	}
	/**
	 * @param msnTyp the msnTyp to set
	 */
	public void setMsnTyp(String msnTyp) {
		this.msnTyp = msnTyp;
	}
	/**
	 * @return the msnAdres
	 */
	public String getMsnAdres() {
		return msnAdres;
	}
	/**
	 * @param msnAdres the msnAdres to set
	 */
	public void setMsnAdres(String msnAdres) {
		this.msnAdres = msnAdres;
	}
	/**
	 * @return the command
	 */
	public String getCommand() {
		return command;
	}
	/**
	 * @param command the command to set
	 */
	public void setCommand(String command) {
		this.command = command;
	}
	
	
}
