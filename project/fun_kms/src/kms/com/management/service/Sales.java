package kms.com.management.service;

import com.ibm.icu.text.DecimalFormat;

import kms.com.common.utils.CommonUtil;

public class Sales {
	private String docId;
	private String writerNo;
	private String salesCt;
	private String prjId;
	private String prjNm;
	private String prjCd;
	private String prjSn;
	private String salesDt;
	private String decideYn;
	private long salesSum;
	private long sales;
	private long purchaseIn;
	private long purchaseOut;
	
	// 20140709, 합계 정렬하기위한 부서명등 추가
	private String orgnztNm;	// 부서명
	private String orgTreeOrd;	// 정렬순서
	private String orgnztUpNm;	// 상위부서명
	
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getPrjCd() {
		return prjCd;
	}
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}
	
	public void setPurchaseOut(long purchaseOut) {
		this.purchaseOut = purchaseOut;
	}
	public long getPurchaseOut() {
		return purchaseOut;
	}
	public void setPurchaseIn(long purchaseIn) {
		this.purchaseIn = purchaseIn;
	}
	public long getPurchaseIn() {
		return purchaseIn;
	}
	public void setSales(long sales) {
		this.sales = sales;
	}
	public long getSales() {
		return sales;
	}
	
	
	public void setSalesSum(long salesSum) {
		this.salesSum = salesSum;
	}
	public long getSalesSum() {
		return salesSum;
	}
	public void setPrjSn(String prjSn) {
		this.prjSn = prjSn;
	}
	public String getPrjSn() {
		return prjSn;
	}
	public void setSalesCt(String salesCt) {
		this.salesCt = salesCt;
	}
	public String getSalesCt() {
		return salesCt;
	}
	public void setSalesDt(String salesDt) {
		this.salesDt = salesDt;
	}
	public String getSalesDt() {
		return salesDt;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public String getDocId() {
		return docId;
	}
	public void setDecideYn(String decideYn) {
		this.decideYn = decideYn;
	}
	public String getDecideYn() {
		return decideYn;
	}
	public long getSalesProfit() {
		return sales - purchaseOut - purchaseIn;
	}
	public double getSalesProfitPercent() {
		if(sales == 0)
			sales = 1;
		//Java 소수점 반올림 Math.round , DecimalFormat 방식 예제
		double mRound = (double)Math.round((double)getSalesProfit() * 10000 / sales) / 100;
		double dformat = Double.parseDouble(new DecimalFormat(".##").format((double)getSalesProfit() * 100 / sales) );
		if(mRound < -999.99) //열배 이상 손실은 -999로 표시. 예) 2백만 손실에 가매출 1원 등록시 2억% 발생하여 -1.999999E8 이렇게 나오기 때문
			return 0;
		return mRound;
	}
	public void setWriterNo(String writerNo) {
		this.writerNo = writerNo;
	}
	public String getWriterNo() {
		return writerNo;
	}
	public String getOrgnztNm() {
		return orgnztNm;
	}
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	public String getOrgTreeOrd() {
		return orgTreeOrd;
	}
	public void setOrgTreeOrd(String orgTreeOrd) {
		this.orgTreeOrd = orgTreeOrd;
	}
	public String getOrgnztUpNm() {
		return orgnztUpNm;
	}
	public void setOrgnztUpNm(String orgnztUpNm) {
		this.orgnztUpNm = orgnztUpNm;
	}
	
}
