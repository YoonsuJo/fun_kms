package kms.com.product.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

public class ProductVO {
	
	@Getter @Setter private String sortNoType;
	@Getter @Setter private String param_returnUrl;
	
	@Getter @Setter private int  no = 0;  				//제품 No PK
	@Getter @Setter private String productCode; 	//제품 코드
	@Getter @Setter private String productNm; 		//제품 이름
	@Getter @Setter private String productCn;		//제품 설명

	@Getter @Setter private String useAt;				//사용여부 YN
	@Getter @Setter private Integer sortNo;			//정열 순서
	@Getter @Setter private Date regDt;				//등록일
	@Getter @Setter private Date modDt;				//수정일
	
	@Getter @Setter private Integer writerNo;			//등록자 user no
	@Getter @Setter private String writerNm;			//등록자 user name
	@Getter @Setter private String writerId;			//등록자 user ID
	@Getter @Setter private Integer adminNo;		//관리자 user no
	@Getter @Setter private String adminNm;			//관리자 user name
	@Getter @Setter private String adminId;			//관리자 user ID
	@Getter @Setter private String adminMixes;		//관리자 이름(아이디)
}
