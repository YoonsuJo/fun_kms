package kms.com.member.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface OvertimeService {

	void insertOvertime(Map<String, Object> commandMap) throws Exception;

	List<EgovMap> selectOvertimeList(Map<String, Object> commandMap, MemberVO user) throws Exception;

}
