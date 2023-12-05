package kms.com.common.customTag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import kms.com.common.config.PathConfig;
import kms.com.common.utils.CommonUtil;

public class PrintProjectFnm  extends SimpleTagSupport{
	private String prjNm = ""; // 
	private String prjCd = ""; //
	private String prjId = ""; //
	private int length = 9999; //
	
	private boolean link = true; //
	private boolean newWnd = false;
	private boolean bracket = false;

	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public void setLength(String length) {
		this.length = Integer.parseInt(length);
	}
	public void setLink(String link) {
		if("N".equals(link))
			this.link = false;
	}
	public void setNewWnd(String newWnd) {
		if("Y".equals(newWnd))
			this.newWnd = true;
	}
	public void setBracket(String bracket) {
		if("Y".equals(bracket))
			this.bracket = true;
	}
	
	public void doTag() {
		JspWriter out = getJspContext().getOut();
		try {
			String value = CommonUtil.printPrjFnm(prjCd, prjNm, bracket);
			String openA = "";
			String closeA = "";
			String targetAttr = "";
			
			if (value.length() > length) {
				String full = value;
				String hide = value.substring(0,length-3) + "...";
				
				value = "<span onmouseover=\"showPrjFullNm('" + full + "', this)\" onmouseout=\"hidePrjFullNm(this);\">" + hide + "</span>";
			}
			
			if (newWnd) {
				targetAttr = " target=\"_PRJ_BLANK_\"";
			}
			
			if (link) {
/*				openA = "<a href=\"" + PathConfig.rootPath + "/cooperation/selectProjectV.do?prjId=" + this.prjId + "\"" + targetAttr + "target=\"_blank\">";
*/				openA = "<a href=\"javascript:viewProject('" + this.prjId + "');\">";
				closeA = "</a>";
			}
			
			String result = openA + value + closeA;

			out.print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	


}
