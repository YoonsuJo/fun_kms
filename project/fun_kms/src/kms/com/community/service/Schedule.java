package kms.com.community.service;

import java.io.Serializable;

import kms.com.common.utils.CalendarUtil;

/**
 * @Class Name : TblNotesendVO.java
 * @Description : TblNotesend VO class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@SuppressWarnings("serial")
public class Schedule implements Serializable{
	private String scheId;
	
	private String userId;
	
	private String userNm;
	
	private int userNo;
	
	private String scheTyp;
	
	private String scheOrgnztId;
	
	private String scheOrgnztNm;
	
	private String scheYear = CalendarUtil.getToday().substring(0,4);
	
	private String scheMonth = CalendarUtil.getToday().substring(4,6);
	
	private String scheDate = CalendarUtil.getToday().substring(6,8);
	
	private String scheTmTyp;
	
	private String scheTmFrom;
	
	private String scheTmTo;
	
	private String scheSj;
	
	private String scheCn;
	
	private String date;
	
	private String scheSharedOrgnztId;
	
	private String scheSharedOrgnztNm;
	
	
	/**
	 * @return the scheId
	 */
	public String getScheId() {
		return scheId;
	}
	/**
	 * @param scheId the scheId to set
	 */
	public void setScheId(String scheId) {
		this.scheId = scheId;
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
	 * @return the userNo
	 */
	public int getUserNo() {
		return userNo;
	}
	/**
	 * @param userNo the userNo to set
	 */
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	/**
	 * @return the scheTyp
	 */
	public String getScheTyp() {
		return scheTyp;
	}
	public String getScheTypPrint() {
		if (scheTyp == null || scheTyp.equals(""))
			return scheTyp;
		else if (scheTyp.equals("H")) {
			return "법정공휴일";
		} else if (scheTyp.equals("I")) {
			return "임시공휴일";
		} else if (scheTyp.equals("J")) {
			return "회사공휴일";
		} else {
			return scheTyp;
		}
	}
	/**
	 * @param scheTyp the scheTyp to set
	 */
	public void setScheTyp(String scheTyp) {
		this.scheTyp = scheTyp;
	}
	/**
	 * @return the scheOrgnztId
	 */
	public String getScheOrgnztId() {
		return scheOrgnztId;
	}
	/**
	 * @param scheOrgnztId the scheOrgnztId to set
	 */
	public void setScheOrgnztId(String scheOrgnztId) {
		this.scheOrgnztId = scheOrgnztId;
	}
	/**
	 * @return the scheOrgnztNm
	 */
	public String getScheOrgnztNm() {
		return scheOrgnztNm;
	}
	/**
	 * @param scheOrgnztNm the scheOrgnztNm to set
	 */
	public void setScheOrgnztNm(String scheOrgnztNm) {
		this.scheOrgnztNm = scheOrgnztNm;
	}
	/**
	 * @return the scheYear
	 */
	public String getScheYear() {
		return scheYear;
	}
	/**
	 * @param scheYear the scheYear to set
	 */
	public void setScheYear(String scheYear) {
		this.scheYear = scheYear;
	}
	/**
	 * @return the scheMonth
	 */
	public String getScheMonth() {
		return scheMonth;
	}
	/**
	 * @param scheMonth the scheMonth to set
	 */
	public void setScheMonth(String scheMonth) {
		while (scheMonth != null && scheMonth.length() < 2) scheMonth = "0" + scheMonth;
		this.scheMonth = scheMonth;
	}
	/**
	 * @return the scheDate
	 */
	public String getScheDate() {
		return scheDate;
	}
	/**
	 * @param scheDate the scheDate to set
	 */
	public void setScheDate(String scheDate) {
		while (scheDate != null && scheDate.length() < 2) scheDate = "0" + scheDate;
		this.scheDate = scheDate;
	}
	/**
	 * @return the scheTmTyp
	 */
	public String getScheTmTyp() {
		return scheTmTyp;
	}
	/**
	 * @param scheTmTyp the scheTmTyp to set
	 */
	public void setScheTmTyp(String scheTmTyp) {
		this.scheTmTyp = scheTmTyp;
	}
	/**
	 * @return the scheTmFrom
	 */
	public String getScheTmFrom() {
		return scheTmFrom;
	}
	/**
	 * @param scheTmFrom the scheTmFrom to set
	 */
	public void setScheTmFrom(String scheTmFrom) {
		this.scheTmFrom = scheTmFrom;
	}
	/**
	 * @return the scheTmTo
	 */
	public String getScheTmTo() {
		return scheTmTo;
	}
	/**
	 * @param scheTmTo the scheTmTo to set
	 */
	public void setScheTmTo(String scheTmTo) {
		this.scheTmTo = scheTmTo;
	}
	/**
	 * @return the scheSj
	 */
	public String getScheSj() {
		return scheSj;
	}
	public String getScheSjShort() {
		if(scheSj.length() > 10) {
			return scheSj.substring(0,8) + "...";
		}
		else {
			return scheSj;
		}
	}
	/**
	 * @param scheSj the scheSj to set
	 */
	public void setScheSj(String scheSj) {
		this.scheSj = scheSj;
	}
	/**
	 * @return the scheCn
	 */
	public String getScheCn() {
		return scheCn.replace("\r\n", "<br/>").replace("\n", "<br/>");
	}
	public String getScheCnShort() {
		if(scheCn.length() > 30) {
			return (scheCn.substring(0,28) + "...").replace("\r\n", "<br/>").replace("\n", "<br/>");
		}
		else {
			return scheCn;
		}
	}
	/**
	 * @param scheCn the scheCn to set
	 */
	public void setScheCn(String scheCn) {
		this.scheCn = scheCn;
	}
	/**
	 * @return the date
	 */
	public String getDate() {
		return date;
	}
	/**
	 * @param date the date to set
	 */
	public void setDate(String date) {
		this.date = date;
	}
	
	public String getScheDateStateBoard() {
		String tm = "";
		if (scheTmTyp.equals("0")) tm = "하루종일";
		else tm = scheTmFrom + "~" + scheTmTo;
		
		String dt = "";
		String scheDt = scheYear + scheMonth + scheDate;
		if (CalendarUtil.getToday().equals(scheDt)) dt = "오늘";
		else if (CalendarUtil.getToday().equals(CalendarUtil.getDate(scheDt, 1))) dt = "내일";
		else dt = scheMonth + "/" + scheDate;
		return dt + "(" + tm + ")";
	}
	
	public boolean isToday() {
		return CalendarUtil.getToday().equals(scheYear + scheMonth + scheDate);
	}
	public boolean isTomorrow() {
		return CalendarUtil.getToday().equals(CalendarUtil.getDate(scheYear + scheMonth + scheDate, 1));
	}
	
	public String getDateForm() {
		return scheYear + scheMonth + scheDate;
	}
	public String getScheSharedOrgnztId() {
		return scheSharedOrgnztId;
	}
	public void setScheSharedOrgnztId(String scheSharedOrgnztId) {
		this.scheSharedOrgnztId = scheSharedOrgnztId;
	}
	public String getScheSharedOrgnztNm() {
		return scheSharedOrgnztNm;
	}
	public void setScheSharedOrgnztNm(String scheSharedOrgnztNm) {
		this.scheSharedOrgnztNm = scheSharedOrgnztNm;
	}
}
