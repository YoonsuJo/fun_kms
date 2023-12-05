package kms.com.product.fm;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

import kms.com.common.utils.CalendarUtil;
import kms.com.product.service.ProductOutputVO;


public class PartFm {

	@Getter @Setter private String searchIsFirst = "Y";

	@Getter @Setter private int searchNo = 0;					// 검색하고자 하는 No PK
	@Getter @Setter private int searchVersionNo = 0;			// 검색하고자 하는 구성품의 버전 No PK

	@Getter @Setter private String searchName = "";			// 제품 이름
	@Getter @Setter private String searchNickName = "";		// part 의 이름 
	@Getter @Setter private String searchType = "";				// part 의 종류  
	@Getter @Setter private String searchTypeP = "";			// part 의 종류  
	@Getter @Setter private String searchTypeM = "";			// part 의 종류  
	@Getter @Setter private String searchUseAt = "Y";			//사용여부 YN
	@Getter @Setter private String searchIncludeDel = "N";			//사용여부 YN
	
	@Getter @Setter private int searchAdminNo = 0;			// 관리담당자 NO
	@Getter @Setter private String searchAdminId = "";			// 관리담당자 ID
	@Getter @Setter private String searchAdminNm = "";		// 관리담당자 이름	
	@Getter @Setter private String searchAdminMixes = "";		// 관리자 이름(아이디)

	@Getter @Setter private String partNoList = "";	
	@Getter @Setter private int verNo = 0;						// 하부모듈의 버전을 연결할때 사용
}
