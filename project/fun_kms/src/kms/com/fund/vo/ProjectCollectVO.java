package kms.com.fund.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 서장열 
 * @date : 2017-05-11
 * 본 클래스는 세금계산서 발행정보, 수금정보, 잔금정보를 일자별로 정리하는 VO임
 * 
 */
public class ProjectCollectVO {
	
	@Getter @Setter private String date = "";					// 날자
	@Getter @Setter private String type = "";					// 세금계산서 발행 : 'I', 수금 : 'C'
	@Getter @Setter private String invoiceId = "";				// 세금계산서 ID
	@Getter @Setter private String title = "";					// 세금계산서 명 
	@Getter @Setter private long invoiceSum = 0;			// 세금계산서 발행금액
	@Getter @Setter private long projectSum = 0;			// 해당 프로젝트 금액
	@Getter @Setter private long collectSum = 0;				// 해당 프로젝트 수금액 금액
	@Getter @Setter private long remain = 0;					// 해당 프로젝트 잔액
	@Getter @Setter private int userNo = 0;					// 세금계산서발행요청/수금처리 담당자 NO
	@Getter @Setter private String userName = "";			// 세금계산서발행요청/수금처리 담당자이름
}
