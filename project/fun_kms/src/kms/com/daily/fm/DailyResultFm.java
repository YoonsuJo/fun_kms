package kms.com.daily.fm;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class DailyResultFm implements Serializable{
	private static final long serialVersionUID = 1L;

	@Getter @Setter private String searchUseYn = "";					/** 검색사용여부 */

	@Getter @Setter private int no = 0;

	@Getter @Setter private int writerNo = 0;
	@Getter @Setter private String writeDate = "";

	@Getter @Setter private String prjId = "";
	@Getter @Setter private String prjNm = "";
	@Getter @Setter private int workHour = 0;
	@Getter @Setter private String contents = "";
	@Getter @Setter private String fileId = "";
	
	
	@Getter @Setter private String jsonResultInputs = ""; 
	@Getter @Setter private int reqNo = 0; 

}
