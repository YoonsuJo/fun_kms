package kms.com.cooperation.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.cooperation.service.DayReport;
import kms.com.cooperation.service.DayReportVO;
import kms.com.cooperation.service.Task;
import kms.com.cooperation.service.TaskContent;
import kms.com.cooperation.service.TaskVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("NkmsDayReportDAO")
public class NkmsDayReportDAO extends EgovAbstractDAO {

	public void insertNkmsDayReport(DayReport dayReport) {
		insert("NkmsDayReportDAO.insertDayReport", dayReport);		
	}
	
	public void insertProjectInput(DayReport dayReport) {
		insert("NkmsDayReportDAO.insertProjectInput", dayReport);		
	}

}
