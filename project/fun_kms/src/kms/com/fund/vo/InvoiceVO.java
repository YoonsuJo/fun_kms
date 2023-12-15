package kms.com.fund.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class InvoiceVO implements Serializable {

	/* STATUS 값 */
	 public final static int CANCEL = 1;
	 public final static int REQUEST = 2;
	 public final static int PUBLISH = 4;
	 public final static int COLLECTLESS = 8;
	 public final static int COLLECTEQUAL = 16;
	 public final static int COLLECTMORE = 32;
	 public final static int COLLECT = 56;
	 public final static int ALL = 63;
	
	private static final long serialVersionUID = 1L;

	/* 페이징 처리를 위한 변수 */
	@Getter @Setter private int pageIndex = 1;						/** 현재페이지 */
	@Getter @Setter private int firstIndex = 1;							/** firstIndex */
	@Getter @Setter private int recordCountPerPage = 30;			/** 페이지당 줄의 갯수 */
	
	@Getter @Setter private String searchCondition = "N";			// 검색조건  최초에 검색조건이 없이 시작할때 N로 시작함
	@Getter @Setter private int searchMode = 1;				
	// 3 : 요청자(세금계산서 발행을 요청하는 사람들 예: 사업부사람들)  
	// ==> 기본검색조건이 처리상태와 상관없이 내가 요청한 계산서 목록만을 보여준다.
	// 1 : 발행자 (세금계산서를 발행하는 사람으로 발행요청이 들어온것들을 처리하기위해 본 페이지를 사용
	// ==> 기본검색조건이 미발행상태의 계산서들중 발행요청일이 오늘이후의 계산서를 제외하고 요청일이 최근인것부터 보여준다. 
	// 2 : 입금처리자 : 계산서가 발행된후 입금처리를 위해 발행된 세금계산서 목록을 보고자 할때 본 페이지를 사용 
	// ==> 기본검색조건이 발행완료상태의 수금이 완료되지 않은 계산서들만을 보여준다. 

	@Getter @Setter private String searchKeyword = "";				// 검색Keyword */
	@Getter @Setter private String searchUseYn = "";					/** 검색사용여부 */
	@Getter @Setter private String openPop = "";					// 화면을 PopUp으로 띄울것인가? "Y" 이면 popup				
	
	@Getter @Setter private int searchStatus = 0;
	@Getter @Setter private String searchStatusY = "";
	@Getter @Setter private String searchStatusC = "";
	@Getter @Setter private String searchStatusP = "";
	@Getter @Setter private String searchPublishCoAcronym = "";
	@Getter @Setter private String searchTitle = "";
	
	@Getter @Setter private int searchWriterNo = 0;
	@Getter @Setter private String searchWriterId = "";
	@Getter @Setter private String searchWriterName = "";
	@Getter @Setter private String searchWriterMixes = "";

	@Getter @Setter private String searchDateFrom = "";
	@Getter @Setter private String searchDateTo = "";

	@Getter @Setter private String searchCompanyName = "";
	@Getter @Setter private String searchPrjName = "";
	@Getter @Setter private String searchPrjId = "";

	/* invoice를 위한 변수 */
	@Getter @Setter private String[] invoiceIdList;
	@Getter @Setter private String invoiceId = "";
	@Getter @Setter private String title = "";
	@Getter @Setter private String custCompanyName = "";
	@Getter @Setter private String custCeoName = "";
	@Getter @Setter private String custBusiNo = "";
	@Getter @Setter private String custBusiType = "";
	@Getter @Setter private String custBusiKind = "";
	@Getter @Setter private String custAddress = "";
	@Getter @Setter private String custEmail1 = "";
	@Getter @Setter private String custEmail2 = "";
	@Getter @Setter private String custEmail3 = "";
	@Getter @Setter private String custEmail4 = "";
	@Getter @Setter private String custEmail5 = "";
	@Getter @Setter private String custName1 = "";
	@Getter @Setter private String custName2 = "";
	@Getter @Setter private String custName3 = "";
	@Getter @Setter private String custName4 = "";
	@Getter @Setter private String custName5 = "";
	@Getter @Setter private String custTelNo1 = "";
	@Getter @Setter private String custTelNo2 = "";
	@Getter @Setter private String custTelNo3 = "";
	@Getter @Setter private String custTelNo4 = "";
	@Getter @Setter private String custTelNo5 = "";
	@Getter @Setter private String taxZero = "";
	@Getter @Setter private long totalPrice = 0;
	@Getter @Setter private long totalVat = 0;
	@Getter @Setter private long totalSum = 0;
	@Getter @Setter private long totalCollect = 0;
	@Getter @Setter private String publishType = "";
	@Getter @Setter private String publishCoAcronym = "";
	@Getter @Setter private String publishCoName = "";
	@Getter @Setter private String publishReqDate = "";
	@Getter @Setter private int writeUserNo = 0;
	@Getter @Setter private String writeUserName = "";
	@Getter @Setter private String writeDatetime = "";
	@Getter @Setter private int publishUserNo = 0;
	@Getter @Setter private String publishUserName = "";
	@Getter @Setter private String publishDatetime = "";
	@Getter @Setter private int status = 0;	/* 1 : 취소, 	2 : 작성,  4 : 발행,  8 : 일부수금,  16 : 완전수금,  32 : 초과수금 */
	@Getter @Setter private String statusStr = "";	/* 1 : 취소, 	2 : 작성,  4 : 발행,  8 : 일부수금,  16 : 완전수금,  32 : 초과수금 */
	
	@Getter @Setter private String useAt = "";
	@Getter @Setter private String attachFileId = "";
	@Getter @Setter private String comment = "";
	@Getter @Setter private String collectExpectDate = "";
	
	@Getter @Setter private String publishToDate = "";
	@Getter @Setter private String repeat = "";
	@Getter @Setter private int publishAtDate = 1;

	@Getter @Setter private String jsonContentsString = ""; 
	@Getter @Setter private String jsonProjectString = ""; 

//	@Getter @Setter private static List<InvoiceContentsVO> invoiceContentsVOList =  new ArrayList<InvoiceContentsVO>();
//	@Getter @Setter private static List<InvoiceProjectVO> invoiceProjectVOList  =  new ArrayList<InvoiceProjectVO>();
//	@Getter @Setter private static List<InvoiceCollectVO> invoiceCollectVOList  =  new ArrayList<InvoiceCollectVO>();
//	private List<InvoiceContentsVO> invoiceContentsVOList = ListUtils.lazyList(new ArrayList<InvoiceContentsVO>(), FactoryUtils.instantiateFactory(InvoiceContentsVO.class));
	
	public void MakeStatusString()
	{
		switch(status) {
		case CANCEL :
			statusStr = "취소";
			break;
		case REQUEST :
			statusStr = "요청";
			break;
		case PUBLISH :
			statusStr = "발행";
			break;
		case COLLECTLESS :
			statusStr = "일부수금";
			break;
		case COLLECTEQUAL :
			statusStr = "수금완료";
			break;
		case COLLECTMORE :
			statusStr = "과수금";
			break;
		default :
			statusStr = "상태";
		}
		return ;
	}
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

}
