package kms.com.management.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

public class MonthResultVO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Getter @Setter private String 	prjId 			= "";
	@Getter @Setter private String 	prjCode 		= "";
	@Getter @Setter private String 	prjName 		= "";
	@Getter @Setter private int		writerNo 		= 0;
	@Getter @Setter private String 	writerName 	= "";
	@Getter @Setter private long 	amount		= 0;

	@Getter @Setter private String 	docId 			= "";
	@Getter @Setter private String 	subject 		= "";
	@Getter @Setter private int 		workHour 	= 0;
	@Getter @Setter private int 		workRate 	= 0;
}
