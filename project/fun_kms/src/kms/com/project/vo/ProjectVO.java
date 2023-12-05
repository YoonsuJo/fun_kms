package kms.com.project.vo;

import java.io.Serializable;
import lombok.Getter;
import lombok.Setter;

import kms.com.common.utils.CommonUtil;


@SuppressWarnings("serial")
public class ProjectVO implements Serializable{

	@Getter @Setter private String type;
	/** PRJ_ID */
	@Getter @Setter private String prjId;
	
	/** PRJ_NM */
	@Getter @Setter private String prjNm;
	
	/** PRJ_CD */
	@Getter @Setter private String prjCd;
	@Getter @Setter private String prjCn;
	
	/** PRNT_PRJ_ID */
	@Getter @Setter private String prntPrjId;
	@Getter @Setter private String prntPrjNm;
	@Getter @Setter private String prntPrjCd;
	
	/** TRANSFER_PRJ_ID */
	@Getter @Setter private String transferPrjId;
	@Getter @Setter private String transferPrjNm;
	@Getter @Setter private String transferPrjCd;
	
	/** ORD(정렬번호) */
	@Getter @Setter private Integer ord;
	/** PRJ_LV */
	@Getter @Setter private int prjLv = 0;
	
	/** ORGNZT_ID */
	@Getter @Setter private String orgnztId;
	@Getter @Setter private String orgnztNm;
	
	/** LEADER_NO */
	@Getter @Setter private int leaderNo;
	@Getter @Setter private String leaderNm;
	@Getter @Setter private String leaderId;
	@Getter @Setter private String leaderMix;
	
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
	@Getter @Setter private String purchasePrjId;
	@Getter @Setter private String purchasePrjNm;
	@Getter @Setter private String purchasePrjCd;
	
	/** REG_DT */
	@Getter @Setter private String regDt	= "";
	@Getter @Setter private String stDt	= "";
	@Getter @Setter private String compDt	= "";
	@Getter @Setter private String compDueDt	 = "";
	
	/** WRITER_NO */
	@Getter @Setter private int writerNo;
	
	@Getter @Setter private String sn;    
	@Getter @Setter private Long busi_prof = (long)0;
	@Getter @Setter private Long busi_prof_acc = (long)0;    
	@Getter @Setter private int prjInterest = -1;    
	@Getter @Setter private String prjType	= "";
	@Getter @Setter private String userNo;    
	@Getter @Setter private String displayTd = "N";	
	@Getter @Setter private int rowspanCnt = 1;
	@Getter @Setter private String initFlag = "N"; //검색조건 초기화 세팅을 위한 플래그
	
	@Getter @Setter private String custId = "";		// 고객사 ID
	@Getter @Setter private String custNm = "";		// 고객사 이름
	@Getter @Setter private String planSales = "";		// 예상 매출
	@Getter @Setter private String planProfit = "";		// 예상 이익
	@Getter @Setter private String planDate = "";		// 예상 영업시기
	@Getter @Setter private int lastReportNo = 0;		// 마지막 등록된 실적번호
	
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
