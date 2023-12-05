package kms.com.app.service;

import java.io.Serializable;

import kms.com.common.utils.CommonUtil;

/**
 * @Class Name : TblSelfdevVO.java
 * @Description : TblSelfdev VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.10.21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class SelfdevVO implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** SELFDEV_NO */
    private int selfdevNo;
    
    private int month;
    private int half;
    private int full;
    private int spendSum;
    private int userNo;
    private String userNm;
    private String userId;
    private String sabun;
    private String userMix;
    
    private int selfdevUsrNo;
    private String year; 
    private String description; 
    private String percent;
    
    private String extraCharge; //할증금액
    
    
    
    private int[] selfdevFullList;
    private int[] selfdevHalfList;
    
    //검색 관련
    private int isSumOfBeforeApproved ;
    private String searchDocId;
	public int getSelfdevNo() {
		return selfdevNo;
	}
	public void setSelfdevNo(int selfdevNo) {
		this.selfdevNo = selfdevNo;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getHalf() {
		return half;
	}
	
	public String getHalfPrint() {
		return CommonUtil.insertComma((int)(half/1000));
	}
	public void setHalf(int half) {
		this.half = half;
	}
	public int getFull() {
		return full;
	}
	public String getFullPrint() {
		return CommonUtil.insertComma((int)(full/1000));
	}
	public void setFull(int full) {
		this.full = full;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public void setSpendSum(int spendSum) {
		this.spendSum = spendSum;
	}
	public int getSpendSum() {
		return spendSum;
	} 
    
	public int getHalfSpend(){
		if( this.full - this.spendSum  >0)
			return 0;
		else if(this.full + this.half - this.spendSum>0)
			return this.spendSum -this.full  ;
		else 
			return this.half;
	}
	
	public int getFullSpend(){
		if(  this.full - this.spendSum >0 )
				return this.spendSum;
		else 
			return this.full;
	}
	
	public int getHalfLeft(){
		return this.half - getHalfSpend();  
	}
	
	public int getFullLeft(){
		return this.full - getFullSpend();
	}
	public void setIsSumOfBeforeApproved(int isSumOfBeforeApproved) {
		this.isSumOfBeforeApproved = isSumOfBeforeApproved;
	}
	public int getIsSumOfBeforeApproved() {
		return isSumOfBeforeApproved;
	}
	public void setSelfdevFullList(int[] selfdevFullList) {
		this.selfdevFullList = selfdevFullList;
	}
	public int[] getSelfdevFullList() {
		return selfdevFullList;
	}
	public void setSelfdevHalfList(int[] selfdevHalfList) {
		this.selfdevHalfList = selfdevHalfList;
	}
	public int[] getSelfdevHalfList() {
		return selfdevHalfList;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getYear() {
		return year;
	}
	public void setSelfdevUsrNo(int selfdevUsrNo) {
		this.selfdevUsrNo = selfdevUsrNo;
	}
	public int getSelfdevUsrNo() {
		return selfdevUsrNo;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDescription() {
		return description;
	}
	public void setPercent(String percent) {
		this.percent = percent;
	}
	public String getPercent() {
		return percent;
	}
	public void setUserMix(String userMix) {
		this.userMix = userMix;
	}
	public String getUserMix() {
		return userMix;
	}
	public void setSearchDocId(String searchDocId) {
		this.searchDocId = searchDocId;
	}
	public String getSearchDocId() {
		return searchDocId;
	}
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}
	public String getSabun() {
		return sabun;
	}
	/**
	 * @return the extraCharge
	 */
	public String getExtraCharge() {
		return extraCharge;
	}
	/**
	 * @param extraCharge the extraCharge to set
	 */
	public void setExtraCharge(String extraCharge) {
		this.extraCharge = extraCharge;
	}
}
