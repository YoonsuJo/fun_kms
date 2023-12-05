package kms.com.product.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

import kms.com.common.utils.CalendarUtil;
import kms.com.product.service.ProductOutputVO;


public class PartVO {

	@Getter @Setter private String sortNoType = "";
	@Getter @Setter private String outputId = "";
	@Getter @Setter private String param_returnUrl = "";
	
	@Getter @Setter private int no = 0;					// 구성품 No PK
	@Getter @Setter private String partNm = "";			// 구성품 이름
	@Getter @Setter private String partCn = "";			// 구성품 설명	
	@Getter @Setter private String nickName = "";		// 구성품의 이름
	@Getter @Setter private String type = "";				// 구성품의 종류  P : part, M: module 

	@Getter @Setter private String useAt = "";			//사용여부 YN
	@Getter @Setter private Integer sortNo = 0;			//정열 순서
	@Getter @Setter private Date regDt;					//등록일
	@Getter @Setter private Date modDt;					//수정일
	@Getter @Setter private String versionNo = "";		// part 의 버젼 No
	@Getter @Setter private String version = "";			// part 의 버젼
	

	@Getter @Setter private Integer writerNo = 0;		//등록자
	@Getter @Setter private String writerId = "";			//등록자
	@Getter @Setter private String writerNm = "";		//등록자
	
	
	@Getter @Setter private Integer adminNo = 0;					/** part 관리담당자 NO  */
	@Getter @Setter private String adminId = "";					/** part 관리담당자 ID */
	@Getter @Setter private String adminNm = "";				/** part 관리담당자 이름 */	
	@Getter @Setter private String adminMixes = "";	//관리자 이름(아이디)
	
	public String getTypeStr() {
		if ("P".equals(type)) {
			return "구성품";
		} else if ("M".equals(type) ) {
			return "모듈";
		} 
		return "기타";
	}
	

}
