package kms.com.fund.fm;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 서장열 
 * @date : 2017-03-25
 */
public class CollectFm {
	
	// for hm_invoice_collect table
	@Getter @Setter private int no = 0;							// 자동생성되는 테이블의 PK
	@Getter @Setter private String invoiceId = "";					// 수금정보가 매칭되는 세금계산서 ID
	@Getter @Setter private int collectUserNo = 0;			// 수금등록을 하는 사람의 user no 
	@Getter @Setter private String collectDate = "";				// 수금등록한 날 (yyyymmdd)
	@Getter @Setter private long collect = 0;						// 근번 수금액
	@Getter @Setter private long collectOld = 0;					//  지난번까지의 수금액
	@Getter @Setter private int type = 0;							// 수금의 형태 : 1: 현금, 2 : 어음, 3 : 기타
	@Getter @Setter private String note = "";						// 수금시 특이사항
	@Getter @Setter private int InvPrjNo = 0;						// 계산서에 연결된 프로젝트 분할 금액 링크
	@Getter @Setter private String useAt = "Y";					// 삭제여부
	
	// for hm_invoice
	@Getter @Setter private String status = "";					// 계산서의 상태. 수금등록후 상태를 수금중, 수금완료, 초과수금으로 변겨해주어야함. TENY_170325 향후 숫자로 수정해야지...
	@Getter @Setter private long totalSum = 0;					// 계산서 발행금액(부가세 포함)
	@Getter @Setter private long totalCollect = 0;				// 계산서 근번 수금액(이번 등록건)
	@Getter @Setter private long totalCollectOld = 0;			// 계산서 지난번까지의 수금액(이번 등록건 제외)


	// for hm_invoice_project
	@Getter @Setter private String jsonProjectString = "";

	
	// for fund
	@Getter @Setter private String autoInsertFund = "";	 // 자동으로 자금일보에 등록할것인지를 체크
	@Getter @Setter private String collectionDate = "";
	@Getter @Setter private String funcType = "";
	@Getter @Setter private String bankBook = "";
	@Getter @Setter private String account = "";
	@Getter @Setter private String companyCd = "";
	@Getter @Setter private String title = "";
	@Getter @Setter private String custCompanyName = "";
	
	// collect, 


}
