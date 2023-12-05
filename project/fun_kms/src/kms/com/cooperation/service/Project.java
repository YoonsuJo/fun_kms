package kms.com.cooperation.service;

import java.io.Serializable;

import kms.com.common.utils.CommonUtil;


/**
 * @author blind
 * 작성일 : 2011.08.26
 * 전자결재 관련 VO
 *
 */
@SuppressWarnings("serial")
public class Project implements Serializable{

	private String type;
	/** PRJ_ID */
	private String prjId;
	
	/** PRJ_NM */
	private String prjNm;
	
	/** PRJ_CD */
	private String prjCd;
	private String prjCn;
	
	/** PRNT_PRJ_ID */
	private String prntPrjId;
	private String prntPrjNm;
	private String prntPrjCd;
	
	/** TRANSFER_PRJ_ID */
	private String transferPrjId;
	private String transferPrjNm;
	private String transferPrjCd;
	
	/** ORD(정렬번호) */
	private Integer ord;
	/** PRJ_LV */
	private int prjLv = 0;
	
	/** ORGNZT_ID */
	private String orgnztId;
	private String orgnztNm;
	
	/** LEADER_NO */
	private int leaderNo;
	private String leaderNm;
	private String leaderId;
	private String leaderMix;
	
	/** STAT */
	private String stat ="P";
	
	/** DAY_REPORT_RULE */
	private String dayReportRule ="Y";
	
	/** EXPENSE_RULE */
	private String manageCostRule ="Y";
	private String budgetExceedRule ="Y";
	private String insertPrntPrjInput ="N";
	/** 채권관리속성 */  
	private String bondYn = "Y";
	/** 제안서속성 */  
	private String proposal = "N";    
	
	/** PURCHASE_PRJ_ID */
	private String purchasePrjId;
	private String purchasePrjNm;
	private String purchasePrjCd;
	
	/** REG_DT */
	private String regDt	= "";
	private String stDt	= "";
	private String compDt	= "";
	private String compDueDt	 = "";
	
	/** WRITER_NO */
	private int writerNo;
	
	private String sn;    
	private Long busi_prof = (long)0;
	private Long busi_prof_acc = (long)0;    
	private int prjInterest = -1;    
	private String prjType	= "";
	private String userNo;    
	private String displayTd = "N";	
	private int rowspanCnt = 1;
	private String initFlag = "N"; //검색조건 초기화 세팅을 위한 플래그
	
	private String custId;		// 고객사 ID
	private String custNm;		// 고객사 이름
	private String planSales;		// 예상 매출
	private String planProfit;		// 예상 이익
	private String planDate;		// 예상 영업시기
	private int lastReportNo;		// 마지막 등록된 실적번호
	
	public String getPrjId() {
		return this.prjId;
	}
	
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	
	public String getPrjIdPrint(){
		String prjId = this.prjId;
		if(prjId == null)
			return "";
		prjId = prjId.substring(0,3) + prjId.substring(prjId.length()-5, prjId.length());
		return prjId;
	}
	
	public String getPrjNm() {
		return this.prjNm;
	}
	
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	
	public String getPrjCd() {
		return this.prjCd;
	}
	
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
		
	public String getPrntPrjId() {
		return this.prntPrjId;
	}
	
	public void setPrntPrjId(String prntPrjId) {
		this.prntPrjId = prntPrjId;
	}
	
	public int getPrjLv() {
		return this.prjLv;
	}
	
	public void setPrjLv(int prjLv) {
		this.prjLv = prjLv;
	}
	
	public String getOrgnztId() {
		return this.orgnztId;
	}
	
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	
	public int getLeaderNo() {
		return this.leaderNo;
	}
	
	public void setLeaderNo(int leaderNo) {
		this.leaderNo = leaderNo;
	}
	
	public String getStat() {
		return this.stat;
	}
	
	public void setStat(String stat) {
		this.stat = stat;
	}
	
  
	
	public String getPurchasePrjId() {
		return this.purchasePrjId;
	}
	
	public void setPurchasePrjId(String purchasePrjId) {
		this.purchasePrjId = purchasePrjId;
	}
	
	public String getRegDt() {
		return this.regDt;
	}
	
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	
	public int getWriterNo() {
		return this.writerNo;
	}
	
	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getSn() {
		return sn;
	}

	public void setLeaderNm(String leaderNm) {
		this.leaderNm = leaderNm;
	}

	public String getLeaderNm() {
		return leaderNm;
	}

	public void setBudgetExceedRule(String budgetExceedRule) {
		this.budgetExceedRule = budgetExceedRule;
	}

	public String getBudgetExceedRule() {
		return budgetExceedRule;
	}

	public void setDayReportRule(String dayReportRule) {
		this.dayReportRule = dayReportRule;
	}

	public String getDayReportRule() {
		return dayReportRule;
	}

	public void setManageCostRule(String manageCostRule) {
		this.manageCostRule = manageCostRule;
	}

	public String getManageCostRule() {
		return manageCostRule;
	}

	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}

	public String getOrgnztNm() {
		return orgnztNm;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}

	public void setCompDt(String compDt) {
		this.compDt = compDt;
	}

	public String getCompDt() {
		return compDt;
	}

	public void setPrjCn(String prjCn) {
		this.prjCn = prjCn;
	}

	public String getPrjCn() {
		return prjCn;
	}

	public void setLeaderId(String leaderId) {
		this.leaderId = leaderId;
	}

	public String getLeaderId() {
		return leaderId;
	}

	public void setPrntPrjNm(String prntPrjNm) {
		this.prntPrjNm = prntPrjNm;
	}

	public String getPrntPrjNm() {
		return prntPrjNm;
	}

	public void setPrntPrjCd(String prntPrjCd) {
		this.prntPrjCd = prntPrjCd;
	}

	public String getPrntPrjCd() {
		return prntPrjCd;
	}

	public void setPurchasePrjNm(String purchasePrjNm) {
		this.purchasePrjNm = purchasePrjNm;
	}

	public String getPurchasePrjNm() {
		return purchasePrjNm;
	}

	public void setPurchasePrjCd(String purchasePrjCd) {
		this.purchasePrjCd = purchasePrjCd;
	}

	public String getPurchasePrjCd() {
		return purchasePrjCd;
	}

	public void setLeaderMix(String leaderMix) {
		this.leaderMix = leaderMix;
	}

	public String getLeaderMix() {
		return leaderMix;
	}

	public void setInsertPrntPrjInput(String insertPrntPrjInput) {
		this.insertPrntPrjInput = insertPrntPrjInput;
	}

	public String getInsertPrntPrjInput() {
		return insertPrntPrjInput;
	}

	public void setCompDueDt(String compDueDt) {
		this.compDueDt = compDueDt;
	}

	public String getCompDueDt() {
		return compDueDt;
	}

	public void setStDt(String stDt) {
		this.stDt = stDt;
	}

	public String getStDt() {
		return stDt;
	}

	public int getPrjInterest() {
		return prjInterest;
	}

	public void setPrjInterest(int prjInterest) {
		this.prjInterest = prjInterest;
	}

	public void setBusi_prof(Long busi_prof) {
		this.busi_prof = busi_prof;
	}

	public Long getBusi_prof() {
		return busi_prof;
	}

	public void setBusi_prof_acc(Long busi_prof_acc) {
		this.busi_prof_acc = busi_prof_acc;
	}

	public Long getBusi_prof_acc() {
		return busi_prof_acc;
	}

	public String getBusiProfPrint() {
		return CommonUtil.insertCommaDivideBy(busi_prof, 1000000, true);
	}
	
	public String getBusiProfAccPrint() {
		return CommonUtil.insertCommaDivideBy(busi_prof_acc, 1000000, true);
	}

	public void setPrjType(String prjType) {
		this.prjType = prjType;
	}

	public String getPrjType() {
		return prjType;
	}

	public String getDisplayTd() {
		return displayTd;
	}

	public void setDisplayTd(String displayTd) {
		this.displayTd = displayTd;
	}

	public int getRowspanCnt() {
		return rowspanCnt;
	}

	public void setRowspanCnt(int rowspanCnt) {
		this.rowspanCnt = rowspanCnt;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setOrd(Integer ord) {
		this.ord = ord;
	}

	public Integer getOrd() {
		return ord;
	}

	public void setBondYn(String bondYn) {
		this.bondYn = bondYn;
	}

	public String getBondYn() {
		return bondYn;
	}

	public void setProposal(String proposal) {
		this.proposal = proposal;
	}

	public String getProposal() {
		return proposal;
	}

	public String getTransferPrjId() {
		return transferPrjId;
	}

	public void setTransferPrjId(String transferPrjId) {
		this.transferPrjId = transferPrjId;
	}

	public String getTransferPrjNm() {
		return transferPrjNm;
	}

	public void setTransferPrjNm(String transferPrjNm) {
		this.transferPrjNm = transferPrjNm;
	}

	public String getTransferPrjCd() {
		return transferPrjCd;
	}

	public void setTransferPrjCd(String transferPrjCd) {
		this.transferPrjCd = transferPrjCd;
	}

	/**
	 * @return the initFlag
	 */
	public String getInitFlag() {
		return initFlag;
	}

	/**
	 * @param initFlag the initFlag to set
	 */
	public void setInitFlag(String initFlag) {
		this.initFlag = initFlag;
	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	public String getPlanSales() {
		return planSales;
	}

	public void setPlanSales(String planSales) {
		this.planSales = planSales;
	}

	public String getPlanProfit() {
		return planProfit;
	}

	public void setPlanProfit(String planProfit) {
		this.planProfit = planProfit;
	}

	public String getPlanDate() {
		return planDate;
	}

	public void setPlanDate(String planDate) {
		this.planDate = planDate;
	}

	public int getLastReportNo() {
		return lastReportNo;
	}

	public void setLastReportNo(int lastReportNo) {
		this.lastReportNo = lastReportNo;
	}
}
