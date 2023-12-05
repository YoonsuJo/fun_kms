package kms.com.fund.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 서장열 
 * @date : 2017-03-27
 * 본 클래스는 사업부에서 수금목록조회시 사용되는 화면의 내용을 DB에서 받아올떄 사용하는 VO클래스이다.
 * 
 */
public class CollectListVO {
	
	@Getter @Setter private int no = 0;							// collect의 PK
	@Getter @Setter private String prjId = "";						// 수금한 프로젝트 ID
	@Getter @Setter private String prjName = "";					// 수금한 프로젝트 이름
	@Getter @Setter private long prjUncollect = 0;				// 수금한 프로젝트의 미수금 잔액 
	@Getter @Setter private String invoiceId = "";					// 수금한 계산서 ID
	@Getter @Setter private String collectUserName = "";		// 수금을 등록한 담당자 이름
	@Getter @Setter private String collectDate = "";				// 수금등록일
	@Getter @Setter private long collect = 0;						// 수금액
	@Getter @Setter private int noteLength = 0;					// 비고내용의 길이, 비고내용이 있는경우 세부내역을 살펴본다.

}
