package kms.com.fund.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 서장열 
 * @date : 2017-02-22
 */
public class InvoiceProjectVO {
	private static final long serialVersionUID = 1L;

	@Getter @Setter private int no = 0; 
	@Getter @Setter private String invoiceId = ""; 
	@Getter @Setter private String title = ""; 
	@Getter @Setter private String prjId = ""; 
	@Getter @Setter private String prjName = ""; 
	@Getter @Setter private String publishDatetime = ""; 
	@Getter @Setter private long   price = 0;
	@Getter @Setter private long   sum = 0;
	@Getter @Setter private long   collect = 0;
	@Getter @Setter private String bondManageYn = ""; 
	@Getter @Setter private String status = ""; 
	@Getter @Setter private String useAt = ""; 

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
}
