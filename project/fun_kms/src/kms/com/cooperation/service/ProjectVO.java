package kms.com.cooperation.service;

import java.io.Serializable;
import lombok.Getter;
import lombok.Setter;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;

/**
 * @author blind
 * 작성일 : 2011.08.26
 * 전자결재 관련 VO
 *
 */
@SuppressWarnings("serial")
public class ProjectVO implements Serializable{

	@Getter @Setter private String type = "";
	/** PRJ_ID */
	@Getter @Setter private String prjId = "";
	
	/** PRJ_NM */
	@Getter @Setter private String prjNm = "";
	
	/** PRJ_CD */
	@Getter @Setter private String prjCd = "";
	@Getter @Setter private String prjCn = "";
	
	/** PRNT_PRJ_ID */
	@Getter @Setter private String prntPrjId = "";
	@Getter @Setter private String prntPrjNm = "";
	@Getter @Setter private String prntPrjCd = "";
	
	/** TRANSFER_PRJ_ID */
	@Getter @Setter private String transferPrjId = "";
	@Getter @Setter private String transferPrjNm = "";
	@Getter @Setter private String transferPrjCd = "";
	
	/** ORD(정렬번호) */
	@Getter @Setter private Integer ord = 0;
	/** PRJ_LV */
	@Getter @Setter private int prjLv = 0;
	
	/** ORGNZT_ID */
	@Getter @Setter private String orgnztId = "";
	@Getter @Setter private String orgnztNm = "";
	
	/** LEADER_NO */
	@Getter @Setter private int leaderNo = 0;
	@Getter @Setter private String leaderNm = "";
	@Getter @Setter private String leaderId = "";
	@Getter @Setter private String leaderMix = "";
	
	/** STAT */
	@Getter @Setter private String stat ="P";
	
	/** DAY_REPORT_RULE */
	@Getter @Setter private String dayReportRule ="Y";
	
	/** EXPENSE_RULE */
	@Getter @Setter private String manageCostRule ="Y";
	@Getter @Setter private String budgetExceedRule ="Y";
	@Getter @Setter private String insertPrntPrjInput ="N";
	/** 채권관리속성 */  
	@Getter @Setter private String bondYn = "Y";
	/** 제안서속성 */  
	@Getter @Setter private String proposal = "N";    
	
	/** PURCHASE_PRJ_ID */
	@Getter @Setter private String purchasePrjId = "";
	@Getter @Setter private String purchasePrjNm = "";
	@Getter @Setter private String purchasePrjCd = "";
	
	/** REG_DT */
	@Getter @Setter private String regDt	= "";
	@Getter @Setter private String stDt	= "";
	@Getter @Setter private String compDt	= "";
	@Getter @Setter private String compDueDt	 = "";
	
	/** WRITER_NO */
	@Getter @Setter private int writerNo = 0;
	
	@Getter @Setter private String sn = "";    
	@Getter @Setter private Long busi_prof = (long)0;
	@Getter @Setter private Long busi_prof_acc = (long)0;    
	@Getter @Setter private int prjInterest = -1;    
	@Getter @Setter private String prjType	= "";
	@Getter @Setter private String userNo = "";    
	@Getter @Setter private String displayTd = "N";	
	@Getter @Setter private int rowspanCnt = 1;
	@Getter @Setter private String initFlag = "N"; //검색조건 초기화 세팅을 위한 플래그
	
	@Getter @Setter private String custId = "";		// 고객사 ID
	@Getter @Setter private String custNm = "";		// 고객사 이름
	@Getter @Setter private String planSales = "";		// 예상 매출
	@Getter @Setter private String planProfit = "";		// 예상 이익
	@Getter @Setter private String planDate = "";		// 예상 영업시기
	@Getter @Setter private int lastReportNo = 0;		// 마지막 등록된 실적번호

	
	
	/** 검색시작일 */

	/** 검색사용여부 */
	@Getter @Setter private String searchUseYn = "";
	/** 현재페이지 */
	@Getter @Setter private int pageIndex = 1;
	/** 페이지갯수 */
	@Getter @Setter private int pageUnit = 15;
	/** 페이지사이즈 */
	@Getter @Setter private int pageSize = 10;
	/** 첫페이지 인덱스 */
	@Getter @Setter private int firstIndex = 1;
	/** 마지막페이지 인덱스 */
	@Getter @Setter private int lastIndex = 1;
	/** 페이지당 레코드 개수 */
	@Getter @Setter private int recordCountPerPage = 10;
	/** 레코드 번호 */
	@Getter @Setter private int rowNo = 0;
	@Getter @Setter private int posblAtchFileNumber = 5;
	@Getter @Setter private String searchPrntPrjId = "";
	@Getter @Setter private String[] searchStatL;
	@Getter @Setter private String[] searchMSPrntStatL;
	@Getter @Setter private String[] searchOrgnztIdList;
	@Getter @Setter private String searchOrgnztNm = "";
	@Getter @Setter private String searchOrgnztId = "";
	@Getter @Setter private String searchLeaderMix = "";
	@Getter @Setter private String searchLeaderId = "";
	@Getter @Setter private String searchLeaderNo = "";
	@Getter @Setter private String searchLeaderNm = "";
	@Getter @Setter private String searchPrjNm = "";
	@Getter @Setter private String searchPrjType = "";
	@Getter @Setter private String searchPrjInputMix = "";
	@Getter @Setter private String searchUserInputMix = "";
	@Getter @Setter private String searchUserInputId = "";
	@Getter @Setter private String searchUserInputNm = "";
	@Getter @Setter private int searchUserInputNo = 0;
	
	// 관리자페이지 -> 프로젝트검색
	@Getter @Setter private String searchRegStDt = "";
	@Getter @Setter private String searchRegEnDt = "";
	
	//prjCd값 교체를 위한 변수들
	@Getter @Setter private String beforePrjCd = ""; 
	@Getter @Setter private String curPrjCd = "" ;
	
	//prj tree쪽을 위한 검색어
	
	@Getter @Setter private String includeUnderPrj = "";
	@Getter @Setter private String includeEndPrj = "";
	@Getter @Setter private String searchYear = CalendarUtil.getToday().substring(0,4);
	@Getter @Setter private String searchMonth = CalendarUtil.getToday().substring(4,6);
	@Getter @Setter private String searchDate = "";
	@Getter @Setter private int dateMove = 0;
	
	@Getter @Setter private String includeUnderProject = "N";
	
	@Getter @Setter private Integer searchUserNo = 0;
	@Getter @Setter private String searchKeyword = "";
	
	@Getter @Setter private String[] prjInputNoL;
	
	@Getter @Setter private String searchTyp = "0";
	@Getter @Setter private String searchIncEndPrj = "0";
	
	@Getter @Setter private String searchTypAll = "N";
	@Getter @Setter private String searchCustNm = "";
	@Getter @Setter private String searchUserMixes = "";
	@Getter @Setter private String[] searchArrPrjNm;
	@Getter @Setter private String[] searchArrUserNo;
	@Getter @Setter private String[] searchArrUserId;
	@Getter @Setter private String searchOrgnztIdSec = "";
	
	public String getPrjIdPrint(){
		String prjId = this.prjId;
		if(prjId == null)
			return "";
		prjId = prjId.substring(0,3) + prjId.substring(prjId.length()-5, prjId.length());
		return prjId;
	}

	public String getBusiProfPrint() {
		return CommonUtil.insertCommaDivideBy(busi_prof, 1000000, true);
	}
	
	public String getBusiProfAccPrint() {
		return CommonUtil.insertCommaDivideBy(busi_prof_acc, 1000000, true);
	}
}
