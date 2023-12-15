package kms.com.daily.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class DailyResultVO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	public DailyResultVO() {
		
	}

	@Getter @Setter private int no = 0;
	@Getter @Setter private int writerNo = 0;
	@Getter @Setter private String writerName = "";
	@Getter @Setter private String writeDate = "";
	
	@Getter @Setter private String prjId = "";
	@Getter @Setter private String prjCd = "";
	@Getter @Setter private String prjName = "";
	
	@Getter @Setter private int workHour = 0;
	@Getter @Setter private String contents = "";
	@Getter @Setter private String fileId = "";

	@Getter @Setter private String regDatetime = "";

	@Getter @Setter private String atDate = "";
	@Getter @Setter private int dateMove = 0;
	@Getter @Setter private int reqNo = 0;


}
