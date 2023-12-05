package kms.com.fund.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 서장열 
 * @date : 2017-02-23
 */
public class InvoiceCollectVO {
	@Getter @Setter private int no = 0;
	@Getter @Setter private String invoiceId = "";
	@Getter @Setter private int collectUserNo = 0;
	@Getter @Setter private String collectUserName = "";
	@Getter @Setter private String collectDate = "";
	@Getter @Setter private long collect = 0;			// 수금액
	@Getter @Setter private int type = 1;  			// 1: 현금, 2: 어음 3: 기타
	@Getter @Setter private String note = "";
}
