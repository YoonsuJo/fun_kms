package kms.com.common.customTag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import kms.com.common.utils.CommonUtil;

public class PrintTextArea  extends SimpleTagSupport{
	private String text; // jsp 단의 태그에서 넘겨 받은 text 값이 들어 있습니다. customTag

	public void doTag() {
		JspWriter out = getJspContext().getOut();
		try {
			text = text.replaceAll("\r\n", "<br/>");
			text = text.replaceAll("\n", "<br/>");
			text = text.replaceAll("\u0020", "&nbsp;");
			out.print(text);		
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getText() {
		return text;
	}

}
