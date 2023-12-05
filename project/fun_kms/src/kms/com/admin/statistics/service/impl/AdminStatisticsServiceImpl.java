package kms.com.admin.statistics.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.admin.statistics.service.AdminStatisticsService;
import kms.com.management.service.InputResultProject;
import kms.com.management.service.InputResultProjectVO;
import kms.com.member.service.ComplexProjectStatistic;
import kms.com.member.service.HolidayWorkStatisticDetail;
import kms.com.member.service.HolidayWorkStatisticDetailVO;
import kms.com.member.service.UserHolidayWorkStatistic;

@Service("KmsAdminStatisticsService")
public class AdminStatisticsServiceImpl implements AdminStatisticsService {

	@Resource(name = "KmsAdminStatisticsDAO")
	private AdminStatisticsDAO adminStatisticsDAO;

	@Override
	public List<EgovMap> selectDayReportExcel1(Map<String, Object> param) throws Exception {
		List<EgovMap> resultList = adminStatisticsDAO.selectDayReportExcel1(param);
		return resultList;
	}

	@Override
	public List<EgovMap> selectExpenseExcel1(Map<String, Object> param) throws Exception {
		List<EgovMap> resultList = adminStatisticsDAO.selectExpenseExcel1(param);
		return resultList;
	}

	@Override
	public List<HolidayWorkStatisticDetail> selectHolidayWorkExcel1(Map<String, Object> param) throws Exception {
		List<HolidayWorkStatisticDetail> resultList = adminStatisticsDAO.selectHolidayWorkExcel1(param);
		return resultList;
	}
	
	@Override
	public HolidayWorkStatisticDetailVO selectHolidayWorkExcel2(Map<String, Object> param) throws Exception {
		HolidayWorkStatisticDetailVO result = new HolidayWorkStatisticDetailVO();

		List<HolidayWorkStatisticDetail> hwsdList = adminStatisticsDAO.selectHolidayWorkExcel1(param);
		
		for (int i = 0; i < hwsdList.size(); i++) {
			HolidayWorkStatisticDetail hwsd = hwsdList.get(i);
			
			if ("total".equals(hwsd.getRowType())) {
				result.setTotal(hwsd);
			}
			else if ("subtotal".equals(hwsd.getRowType()) || "item".equals(hwsd.getRowType())){
				List<UserHolidayWorkStatistic> uhwsList = result.getUserHolWorkList();
				
				boolean complete = false;
				for (int j = 0; j < uhwsList.size(); j++) {
					if (hwsd.getUserNo().equals(uhwsList.get(j).getUserNo())) {
						if ("subtotal".equals(hwsd.getRowType())) {
							uhwsList.get(j).setSubTotal(hwsd);
						}
						else { // "item".equals(hwsd.getRowType())
							uhwsList.get(j).addHolidayWorkStatisticDetail(hwsd);
						}
						complete = true;
						break;
					}
				}
				
				if (!complete) {
					UserHolidayWorkStatistic uhws = new UserHolidayWorkStatistic();
					uhws.setUserNo(hwsd.getUserNo());
					if ("subtotal".equals(hwsd.getRowType())) {
						uhws.setSubTotal(hwsd);
					}
					else { // "item".equals(hwsd.getRowType())
						uhws.addHolidayWorkStatisticDetail(hwsd);
					}
					result.addUserHolWorkList(uhws);
				}
			}
		}
		
		return result;
	}

	@Override
	public List<EgovMap> selectCarReservationExcel1(Map<String, Object> param) throws Exception {
		List<EgovMap> resultList = adminStatisticsDAO.selectCarReservationExcel1(param);
		return resultList;
	}

	@Override
	public List<ComplexProjectStatistic> selectComplexProjectReportExcel1(Map<String, Object> param) throws Exception {
		List<ComplexProjectStatistic> resultList = adminStatisticsDAO.selectComplexProjectReportExcel1(param);
		return resultList;
	}
}
