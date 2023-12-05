package kms.com.common.customTag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import kms.com.common.config.PathConfig;
import kms.com.common.utils.CommonUtil;

public class PrintStrShort  extends SimpleTagSupport{
	private int length = 15; // 15자 초과는 12자+... 으료 표시
	private String layerOn = "N";
	private String str="";
	public void setLength(String length) {
		this.length = Integer.parseInt(length);
	}
		
	public void setLayerOn(String layerOn) {
		this.layerOn = layerOn;
	}
	
	public void setStr(String str) {
		this.str = str;
	}

	public void doTag() {
		JspWriter out = getJspContext().getOut();
		String result = "";
		try {
			str = CommonUtil.htmlTagRemove(str);
			result = str;
			if (str.length() > length) {
				result = str.substring(0,length-3) + "...";
			}
			out.print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}



	
	

	


}
