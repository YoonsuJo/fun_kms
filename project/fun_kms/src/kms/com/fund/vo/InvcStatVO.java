package kms.com.fund.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 서장열 
 * @date : 2017-02-28
 */
public class InvcStatVO {
	private static final long serialVersionUID = 1L;

	/* 페이징 처리를 위한 변수 */
	@Getter @Setter private int pageIndex = 1;						/** 현재페이지 */
	@Getter @Setter private int firstIndex = 1;						/** firstIndex */
	@Getter @Setter private int recordCountPerPage = 30;			/** 페이지당 줄의 갯수 */
	
	@Getter @Setter private String searchCondition = "N";			/** 검색조건  최초에 검색조건이 없이 시작할때 N로 시작함*/

	@Getter @Setter private String searchKeyword = "";				/** 검색Keyword */
	@Getter @Setter private String searchUseYn = "";				/** 검색사용여부 */
	
	@Getter @Setter private String searchStartDate = "";
	@Getter @Setter private String searchEndDate = "";
	@Getter @Setter private String searchPrjStatus = "Y";			// 종료되지 않은 프로젝트

	@Getter @Setter private String bondYn = "";
	@Getter @Setter private String stat = "";
	@Getter @Setter private String prjType = "";

	@Getter @Setter private String salesType = "";						// T : 종합매출,   G : 일반매출
	
	/* invoice를 위한 변수 */
	@Getter @Setter private String orgnztId = "";						// 부서ID
	@Getter @Setter private String orgnztName = "";				// 부서명
	@Getter @Setter private String prjId = "";						// 프로젝트ID
	@Getter @Setter private String prjName = "";				// 프로젝트명
	@Getter @Setter private long totalSales = 0;			// 계산서 발행총액
	@Getter @Setter private long totalInvoice = 0;		// 계산서 미발행 총액
	@Getter @Setter private long totalCollect = 0;		// 수금액 총액

	@Getter @Setter private long siWholeSales = 0;		// 종합매출 계약총액(부가세 별도)
	@Getter @Setter private long siSales = 0;				// 종합매출 수행매출(부가세 별도)
	@Getter @Setter private long siMaintSales = 0;		// 종합매출 유지보수(부가세 별도)
	@Getter @Setter private long solSales = 0;			// 단순매출 발행총액(부가세 별도)
	@Getter @Setter private long invoiceSum = 0;		// 계산서 발행총액
	@Getter @Setter private long collect = 0;				// 수금액 총액

	
	@Getter @Setter private long toDate = 0;				// 월별매출을 증가적으로 더한 날
	@Getter @Setter private long contractSales = 0;			// 계약매출총액(부가세 별도)
	@Getter @Setter private long progressiveSales = 0;		// 월별매출을 증가적으로 더한 매출총액(부가세 별도)
	@Getter @Setter private long invPrjPrice = 0;				// 프로젝트별 세금계산서 공급가액 
	@Getter @Setter private long invPrjSum = 0;				// 프로젝트별 세금계산서 부가세포함가액
	@Getter @Setter private long invPrjCollect = 0;			// 프로젝트별 세금계산서 수금액 총액
	
	
	
	@Getter @Setter private String salesDocId = "";	
	@Getter @Setter private String salesSubject = "";	
	@Getter @Setter private String salesDocDate = "";	
	@Getter @Setter private String salesDocStat = "";	
	@Getter @Setter private String salesNewAt = "";	
	@Getter @Setter private String salesStatus = "";	
	@Getter @Setter private String salesBondYn = "";	
	@Getter @Setter private String salesDeciedYn = "";	
	@Getter @Setter private long salesWholeSales = 0;	
	@Getter @Setter private long salesSales = 0;	
	@Getter @Setter private long salesMaintSales = 0;	

	
	
	@Getter @Setter private String salesDocIds = "";		// 매출보고건들을 수금관리종료처리할때 사용하는 매출보고ID 리스트를 담는 스트링
	@Getter @Setter private String[] salesDocIdList;		// 위의값을 SQL문에 넘기기 위해 필요한 리스트 배열형태의 변수
	@Getter @Setter private String invPrjNos = "";		// 계산서(프로젝트별, 매출,수금)건들을 수금관리종료처리할때 사용하는 ID 리스트를 담는 스트링
	@Getter @Setter private String[] invPrjNoList;			// 위의값을 SQL문에 넘기기 위해 필요한 리스트 배열형태의 변수

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

}
