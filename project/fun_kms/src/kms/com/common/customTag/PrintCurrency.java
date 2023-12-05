package kms.com.common.customTag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import kms.com.common.utils.CommonUtil;

public class PrintCurrency  extends SimpleTagSupport{
	private long cost; // jsp 단의 태그에서 넘겨 받은 text 값이 들어 있습니다.
	private int divideBy;
	private String printCipher;
	public void setCost(long cost) {
		this.cost = cost;
	}
	public void setDivideBy(int divideBy) {
		this.divideBy = divideBy;
	}
	public void doTag() {
		JspWriter out = getJspContext().getOut();
		try {
			if(divideBy !=0)
			{
				if("true".equals(printCipher))
					out.print(CommonUtil.insertCommaDivideBy(cost, divideBy,true));
				else
					out.print(CommonUtil.insertCommaDivideBy(cost, divideBy,false));
			}
				
			else
				out.print(CommonUtil.insertComma(cost));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void setPrintCipher(String printCipher) {
		this.printCipher = printCipher;
	}
	public String getPrintCipher() {
		return printCipher;
	}

	

}
