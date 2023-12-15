package kms.com.daily.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class DailyPlanVO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Getter @Setter private int no = 0;
	@Getter @Setter private int writerNo = 0;
	@Getter @Setter private String writerName = "";
	@Getter @Setter private String writeDate = "";
	@Getter @Setter private String writeDay = "";
	@Getter @Setter private String regDatetime = "";
	@Getter @Setter private String contents = "";
	@Getter @Setter private String fileId = "";

	@Getter @Setter private String atDate = "";
	@Getter @Setter private int dateMove = 0;

	@Getter @Setter private String projectId = "";
	@Getter @Setter private String projectName = "";
	@Getter @Setter private String taskSubject = "";
	@Getter @Setter private String taskContents = "";

	@Getter @Setter private List <DailyResultVO> dailyResultVOList =  new ArrayList<DailyResultVO>();
	
}
