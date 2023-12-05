package kms.com.fund.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 서장열 
 * @date : 2017-02-22
 */
public class InvoiceContentsVO {
	private static final long serialVersionUID = 1L;

	/* invoice에 딸린 contents(적요)를 위한 변수 */
	@Getter @Setter private int no = 0; 
	@Getter @Setter private String invoiceId = "";
	@Getter @Setter private String productName = "";
	@Getter @Setter private long   price = 0;
	@Getter @Setter private long   vat = 0;
	@Getter @Setter private long   sum = 0;
	@Getter @Setter private long   type = 1;
	@Getter @Setter private String  note = "";

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
}
