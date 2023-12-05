package kms.com.member.service;

import java.util.ArrayList;
import java.util.List;


public class UserHolidayWorkStatistic {
	private List<HolidayWorkStatisticDetail> detailList = new ArrayList<HolidayWorkStatisticDetail>();
	private HolidayWorkStatisticDetail subTotal;
	private Integer userNo;
	
	/**
	 * @return the detailList
	 */
	public List<HolidayWorkStatisticDetail> getDetailList() {
		return detailList;
	}
	/**
	 * @param detailList the detailList to set
	 */
	public void setDetailList(List<HolidayWorkStatisticDetail> detailList) {
		this.detailList = detailList;
	}
	public void addHolidayWorkStatisticDetail(
			HolidayWorkStatisticDetail holidayWorkStatisticDetail) {
		this.detailList.add(holidayWorkStatisticDetail);
	}
	/**
	 * @return the subTotal
	 */
	public HolidayWorkStatisticDetail getSubTotal() {
		return subTotal;
	}
	/**
	 * @param subTotal the subTotal to set
	 */
	public void setSubTotal(HolidayWorkStatisticDetail subTotal) {
		this.subTotal = subTotal;
	}
	/**
	 * @return the userNo
	 */
	public Integer getUserNo() {
		return userNo;
	}
	/**
	 * @param userNo the userNo to set
	 */
	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}
}
