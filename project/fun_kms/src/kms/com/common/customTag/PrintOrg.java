package kms.com.common.customTag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import kms.com.common.utils.CommonUtil;

public class PrintOrg  extends SimpleTagSupport{
	private String orgnztNm;
	private String orgnztId;
	private String orgnztFnm;
	public void doTag() {
		JspWriter out = getJspContext().getOut();
		try {
			 out.print(orgnztNm);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	public String getOrgnztNm() {
		return orgnztNm;
	}
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	public String getOrgnztId() {
		return orgnztId;
	}
	public void setOrgnztFnm(String orgnztFnm) {
		this.orgnztFnm = orgnztFnm;
	}
	public String getOrgnztFnm() {
		return orgnztFnm;
	}


}
