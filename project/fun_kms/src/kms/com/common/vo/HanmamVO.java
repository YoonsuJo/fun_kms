package kms.com.common.vo;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HanmamVO  implements Serializable{

	private static final long serialVersionUID = 1L;

	public HanmamVO() {
		today = new Date();
	};
	

	public Date today;
	
	public static String GetDateString(Date date) {
		// "yyyy-MM-dd HH:mm:ss"

		return GetDateString(date, 0);
	}

	public static String GetDateString(Date date, int nType) {
		// "yyyy-MM-dd HH:mm:ss"
		if(date == null) {
			return "";
		}
		SimpleDateFormat transFormat;
		switch(nType) {
		case 1 : 		// yyyy.mm.dd
			transFormat = new SimpleDateFormat("yyyy.MM.dd");
		
		default :	// yy.mm.dd
			transFormat = new SimpleDateFormat("yy.MM.dd");
		}
		return transFormat.format(date);
	}

	public boolean IsOldDate(Date date) {
		if(date == null)
			return false;
		
		if(today.before(date)) {
			return false;
		}
		else {
			return true;
		}
	}
}
