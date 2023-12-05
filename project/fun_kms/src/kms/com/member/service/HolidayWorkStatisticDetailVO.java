package kms.com.member.service;

import java.util.ArrayList;
import java.util.List;


public class HolidayWorkStatisticDetailVO {
	private List<UserHolidayWorkStatistic> userHolWorkList = new ArrayList<UserHolidayWorkStatistic>();
	private HolidayWorkStatisticDetail total;
	/**
	 * @return the userHolWorkList
	 */
	public List<UserHolidayWorkStatistic> getUserHolWorkList() {
		return userHolWorkList;
	}
	/**
	 * @param userHolWorkList the userHolWorkList to set
	 */
	public void setUserHolWorkList(List<UserHolidayWorkStatistic> userHolWorkList) {
		this.userHolWorkList = userHolWorkList;
	}
	public void addUserHolWorkList(
			UserHolidayWorkStatistic userHolidayWorkStatistic) {
		this.userHolWorkList.add(userHolidayWorkStatistic);
	}
	/**
	 * @return the total
	 */
	public HolidayWorkStatisticDetail getTotal() {
		return total;
	}
	/**
	 * @param total the total to set
	 */
	public void setTotal(HolidayWorkStatisticDetail total) {
		this.total = total;
	}
}
