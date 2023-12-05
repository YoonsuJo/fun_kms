package kms.com.common.customTag;

import java.beans.Encoder;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import kms.com.common.utils.CommonUtil;

public class EncodeKorean  extends SimpleTagSupport{
	private String korean; // 
	public void doTag() {
		JspWriter out = getJspContext().getOut();
		try {
			out.print(URLEncoder.encode(korean, "UTF-8"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void setKorean(String korean) {
		this.korean = korean;
	}


	public String getKorean() {
		return korean;
	}


}
