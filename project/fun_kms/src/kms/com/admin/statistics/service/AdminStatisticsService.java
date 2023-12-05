package kms.com.admin.statistics.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.member.service.ComplexProjectStatistic;
import kms.com.member.service.HolidayWorkStatisticDetail;
import kms.com.member.service.HolidayWorkStatisticDetailVO;

public interface AdminStatisticsService {
	List<EgovMap> selectDayReportExcel1(Map<String, Object> param) throws Exception;
	List<EgovMap> selectExpenseExcel1(Map<String, Object> param) throws Exception;
	List<HolidayWorkStatisticDetail> selectHolidayWorkExcel1(Map<String, Object> param) throws Exception;
	HolidayWorkStatisticDetailVO selectHolidayWorkExcel2(Map<String, Object> param) throws Exception;
	List<EgovMap> selectCarReservationExcel1(Map<String, Object> param) throws Exception;
	List<ComplexProjectStatistic> selectComplexProjectReportExcel1(Map<String, Object> param) throws Exception;
}
