package kms.com.daily.fm;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

public class DailyPlanFm implements Serializable{
	private static final long serialVersionUID = 1L;

	@Getter @Setter private String searchUseYn = "";					/** 검색사용여부 */

	@Getter @Setter private int no = 0;
	@Getter @Setter private int writerNo = 0;
	@Getter @Setter private String writerName ="";
	@Getter @Setter private String writeDate = "";
	@Getter @Setter private String contents = "";
	@Getter @Setter private String writerOrgnztId = "";
	@Getter @Setter private String writerOrgnztName = "";

	@Getter @Setter private String atDate = "";
	@Getter @Setter private int dateMove = 0;
	
	/* TENY_170427 fom migration */
	@Getter @Setter private String fromDate = "";
	@Getter @Setter private String toDate = "";
}
