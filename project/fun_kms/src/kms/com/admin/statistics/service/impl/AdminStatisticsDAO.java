package kms.com.admin.statistics.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.member.service.ComplexProjectStatistic;
import kms.com.member.service.HolidayWorkStatisticDetail;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("KmsAdminStatisticsDAO")
public class AdminStatisticsDAO extends EgovAbstractDAO {

	public List<EgovMap> selectDayReportExcel1(Map<String, Object> param) {
		return list("AdminStatisticsDAO.selectDayReportExcel1", param);
	}

	public List<EgovMap> selectExpenseExcel1(Map<String, Object> param) {
		return list("AdminStatisticsDAO.selectExpenseExcel1", param);
	}

	public List<HolidayWorkStatisticDetail> selectHolidayWorkExcel1(Map<String, Object> param) {
		return list("AdminStatisticsDAO.selectHolidayWorkExcel1", param);
	}

	public List<EgovMap> selectCarReservationExcel1(Map<String, Object> param) {
		return list("AdminStatisticsDAO.selectCarReservationExcel1", param);
	}
	
	public List<ComplexProjectStatistic> selectComplexProjectReportExcel1(Map<String, Object> param) {
		return list("AdminStatisticsDAO.selectComplexProjectReportExcel1", param);
	}
}
