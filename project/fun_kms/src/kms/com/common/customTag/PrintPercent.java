package kms.com.common.customTag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import kms.com.common.utils.CommonUtil;

public class PrintPercent  extends SimpleTagSupport{
	private Double value; // 
	private Integer roundDigits = 0;
	private boolean printSign = false;

	public void doTag() {
		JspWriter out = getJspContext().getOut();
		try {
			
			String roundedStr = "";
			double rounded = (double) (Math.round((double) (value * 100 * Math.pow(10, roundDigits))) / Math.pow(10, roundDigits));
			roundedStr = String.valueOf(rounded);

			String printStr = roundedStr;
			if (roundDigits <= 0) {
				printStr = roundedStr.substring(0, roundedStr.indexOf("."));
			}
			
			if (printSign)
				printStr += "%";
			
			out.print(printStr);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	public void setValue(String value) {
		this.value = Double.parseDouble(value);
	}
	public void setValue(Double value) {
		this.value = value;
	}

	public void setRoundDigits(String roundDigits) {
		this.roundDigits = Integer.parseInt(roundDigits);
	}
	public void setRoundDigits(Integer roundDigits) {
		this.roundDigits = roundDigits;
	}
	
	public void setPrintSignYn(String printSignYn) {
		if("Y".equals(printSignYn))
			this.printSign = true;
	}
}
