package kms.com.member.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.common.utils.CalendarUtil;
import kms.com.member.service.MemberVO;
import kms.com.member.service.OvertimeService;

@Service("KmsOvertimeService")
public class OvertimeServiceImpl implements OvertimeService {

	@Resource(name="KmsOvertimeDAO")
	private OvertimeDAO overtimeDAO;
	
	@Override
	public void insertOvertime(Map<String, Object> commandMap) throws Exception {
		overtimeDAO.insertOvertime(commandMap);
	}

	@Override
	public List<EgovMap> selectOvertimeList(Map<String, Object> commandMap, MemberVO user) throws Exception {

		String searchCondition = (String) commandMap.get("searchCondition");
		String searchKeyword = (String) commandMap.get("searchKeyword");
		String searchYear = (String) commandMap.get("searchYear");
		
		if (searchKeyword == null || searchKeyword.equals("")) {
			commandMap.put("userId", user.getUserId());
		}
		if (searchYear == null || searchYear.equals("")) {
			commandMap.put("searchYear", CalendarUtil.getToday().substring(0,4));
		}
		
		return overtimeDAO.selectOvertimeList(commandMap);
	}

}
