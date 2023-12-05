package kms.com.common.customTag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import kms.com.common.utils.CommonUtil;

public class PrintDate  extends SimpleTagSupport{
	private String date; // jsp 단의 태그에서 넘겨 받은 text 값이 들어 있습니다.
	private String printMin;
	private String printType;
	public void setDate(String date) {
		this.date = date;
	}
	public void doTag() {
		JspWriter out = getJspContext().getOut();
		try {
			if("Y".equals(printMin))
				out.print(CommonUtil.getDateType(date,"M"));
			else if("S".equals(printType)) {
				String tmp = CommonUtil.getDateType(date);
				out.print(tmp.substring(2));
			} else if("M".equals(printType)) {
				String tmp = CommonUtil.getDateType(date);
				out.print(tmp.substring(5));
			} else if("HHMM".equals(printType)) {	// HH:MM	
				String tmp = CommonUtil.getDateType(date,"M");
				out.print(tmp.substring(11,16));
			} else if("MMDDHHMM".equals(printType)) {	// MM.DD HH:MM	
				String tmp = CommonUtil.getDateType(date,"M");
				out.print(tmp.substring(5,16));
			} else if("yyMMDDHHMM".equals(printType)) {	// MM.DD HH:MM	
				String tmp = CommonUtil.getDateType(date,"M");
				out.print(tmp.substring(2,16));
			}
			else
				out.print(CommonUtil.getDateType(date));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void setPrintMin(String printMin) {
		this.printMin = printMin;
	}
	public String getPrintMin() {
		return printMin;
	}
	public String getPrintType() {
		return printType;
	}
	public void setPrintType(String printType) {
		this.printType = printType;
	}

}
