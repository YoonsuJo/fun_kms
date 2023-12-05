package kms.com.common.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

@SuppressWarnings("serial")
public class Expansion implements Serializable {
	private String expId;
	private String expSj;
	private String expCn;
	private String expFileId;
	private String popYn;
	private String useAt;
	private Integer sort;
	private String linkUrl;
	private String access;
	private String accessUserNo;
	private String userNo;
	private String popWidth;
	private String popHeight;
	
	private String accessUser;
	private String[] accessUserList;
	/**
	 * @return the expId
	 */
	public String getExpId() {
		return expId;
	}
	/**
	 * @param expId the expId to set
	 */
	public void setExpId(String expId) {
		this.expId = expId;
	}
	/**
	 * @return the expSj
	 */
	public String getExpSj() {
		return expSj;
	}
	/**
	 * @param expSj the expSj to set
	 */
	public void setExpSj(String expSj) {
		this.expSj = expSj;
	}
	/**
	 * @return the expCn
	 */
	public String getExpCn() {
		if (expCn == null) return "";
		else return expCn;
	}
	public String getExpCnShort() {
		if (getExpCn().length() < 40) return getExpCn();
		else return getExpCn().substring(0,38) + "...";
	}
	/**
	 * @param expCn the expCn to set
	 */
	public void setExpCn(String expCn) {
		this.expCn = expCn;
	}
	/**
	 * @return the expFileId
	 */
	public String getExpFileId() {
		return expFileId;
	}
	/**
	 * @param expFileId the expFileId to set
	 */
	public void setExpFileId(String expFileId) {
		this.expFileId = expFileId;
	}
	/**
	 * @return the popYn
	 */
	public String getPopYn() {
		return popYn;
	}
	public boolean isPop() {
		return "Y".equals(popYn);
	}
	/**
	 * @param popYn the popYn to set
	 */
	public void setPopYn(String popYn) {
		this.popYn = popYn;
	}
	/**
	 * @return the linkUrl
	 */
	public String getLinkUrl() {
		return linkUrl;
	}
	/**
	 * @param linkUrl the linkUrl to set
	 */
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	/**
	 * @return the useAt
	 */
	public String getUseAt() {
		return useAt;
	}
	public String getUseAtPrint() {
		if (useAt == null || useAt.equals("")) return "사용";
		else if (useAt.equals("N")) return "사용안함";
		else return "사용";
	}
	/**
	 * @param useAt the useAt to set
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	/**
	 * @return the sort
	 */
	public Integer getSort() {
		return sort;
	}
	/**
	 * @param sort the sort to set
	 */
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	/**
	 * @return the access
	 */
	public String getAccess() {
		if (access == null || access.equals("")) {
			return "L";
		}
		else return access;
	}
	public boolean isAllAccess() {
		if (getAccess().equals("A")) {
			return true;
		} else return false;
	}
	/**
	 * @param access the access to set
	 */
	public void setAccess(String access) {
		this.access = access;
	}
	/**
	 * @return the accessUserNo
	 */
	public String getAccessUserNo() {
		return accessUserNo;
	}
	/**
	 * @param accessUserNo the accessUserNo to set
	 */
	public void setAccessUserNo(String accessUserNo) {
		this.accessUserNo = accessUserNo;
	}
	/**
	 * @return the userNo
	 */
	public String getUserNo() {
		return userNo;
	}
	/**
	 * @param userNo the userNo to set
	 */
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	
	/**
	 * @return the accessUser
	 */
	public String getAccessUser() {
		return accessUser;
	}
	/**
	 * @param accessUser the accessUser to set
	 */
	public void setAccessUser(String accessUser) {
		this.accessUser = accessUser;
	}
	/**
	 * @return the accessUserList
	 */
	public String[] getAccessUserList() {
		return accessUserList;
	}
	/**
	 * @param accessUserList the accessUserList to set
	 */
	public void setAccessUserList(String[] accessUserList) {
		this.accessUserList = accessUserList;
	}
	
	
	public boolean isAccessibleUserNo() {
		if (isAllAccess()) {
			return true;
		}
		else if (userNo == null || userNo.equals("")) {
			return false;
		}
		else {
			String[] tmp = getAccessUserNo().split(",");
			
			for (int i=0; i<tmp.length; i++) {
				if (tmp[i].equals(getUserNo())) 
					return true;
			}
		}
		return false;
	}
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	/**
	 * @return the popWidth
	 */
	public String getPopWidth() {
		return popWidth;
	}
	/**
	 * @param popWidth the popWidth to set
	 */
	public void setPopWidth(String popWidth) {
		this.popWidth = popWidth;
	}
	/**
	 * @return the popHeight
	 */
	public String getPopHeight() {
		return popHeight;
	}
	/**
	 * @param popHeight the popHeight to set
	 */
	public void setPopHeight(String popHeight) {
		this.popHeight = popHeight;
	}
}
