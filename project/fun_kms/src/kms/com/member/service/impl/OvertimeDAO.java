package kms.com.member.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("KmsOvertimeDAO")
public class OvertimeDAO extends EgovAbstractDAO {

	public void insertOvertime(Map<String, Object> commandMap) {
		insert("overtimeDAO.insertOvertime", commandMap);
	}

	public List<EgovMap> selectOvertimeList(Map<String, Object> commandMap) {
		// TODO Auto-generated method stub
		return null;
	}

}
