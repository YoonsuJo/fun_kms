package kms.com.common.service;

import kms.com.common.utils.CalendarUtil;

public class StatisticSectorVO {
	private Integer no;
	private Integer sectorTyp = 1;
	private String statisticSectorNm;
	private String statisticSectorVal;
	private String statisticSectorValNm;
	private Integer statisticSectorOrg;
	private String colorTyp;
	private String searchYear = CalendarUtil.getToday().substring(0,4);
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Integer getSectorTyp() {
		return sectorTyp;
	}
	public void setSectorTyp(Integer sectorTyp) {
		this.sectorTyp = sectorTyp;
	}
	public String getStatisticSectorNm() {
		return statisticSectorNm;
	}
	public void setStatisticSectorNm(String statisticSectorNm) {
		this.statisticSectorNm = statisticSectorNm;
	}
	public String getStatisticSectorVal() {
		return statisticSectorVal;
	}
	public void setStatisticSectorVal(String statisticSectorVal) {
		this.statisticSectorVal = statisticSectorVal;
	}
	public Integer getStatisticSectorOrg() {
		return statisticSectorOrg;
	}
	public void setStatisticSectorOrg(Integer statisticSectorOrg) {
		this.statisticSectorOrg = statisticSectorOrg;
	}
	public String getColorTyp() {
		return colorTyp;
	}
	public void setColorTyp(String colorTyp) {
		this.colorTyp = colorTyp;
	}
	public String getSearchYear() {
		return searchYear;
	}
	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}
	public String getStatisticSectorValNm() {
		return statisticSectorValNm;
	}
	public void setStatisticSectorValNm(String statisticSectorValNm) {
		this.statisticSectorValNm = statisticSectorValNm;
	}
	public void addStatisticSectorValNm(String statisticSectorValNm) {
		this.statisticSectorValNm += "," + statisticSectorValNm;
	}
}
