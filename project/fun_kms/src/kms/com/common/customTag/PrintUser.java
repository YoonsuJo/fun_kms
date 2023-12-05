package kms.com.common.customTag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import kms.com.common.utils.CommonUtil;

public class PrintUser  extends SimpleTagSupport{
	private String userNm; // 
	private String userId; //
	private String userNo; //
	private boolean printId = false;
	public void doTag() {
		JspWriter out = getJspContext().getOut();
		try {
			if(printId)	{
				if(userNm == null || "".equals(userNm) || userId == null || "".equals(userId))
					out.print("");
				else
					out.print( "<span class=\"cursorPointer\" onclick=\"openUsrLayer(" + userNo + ",this);\">"+
						CommonUtil.printUserMix(userNm, userId) + "</span>");
			} else {
				if(userNm == null||"".equals(userNm) || userNo == null || "".equals(userNo))
					out.print("");
				else
				out.print(
						"<span class=\"cursorPointer\" onclick=\"openUsrLayer(" + userNo + ",this);\">"+
						userNm +
						"</span>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}


	public String getUserNm() {
		return userNm;
	}


	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}


	public String getUserNo() {
		return userNo;
	}
	
	public void setPrintId(String bool)
	{
		if("true".equals(bool))
		{
			this.printId = true;
		}
		else
			this.printId = false;
	}
}
