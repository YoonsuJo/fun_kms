package kms.com.common.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.common.service.BusinessSectorVO;
import kms.com.common.service.CommonService;
import kms.com.common.service.Expansion;
import kms.com.common.service.ExpansionVO;
import kms.com.common.service.StatisticSectorVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.community.service.ScheduleVO;
import kms.com.community.service.impl.ScheduleDAO;
import kms.com.member.service.MemberVO;

@Service("KmsCommonService")
public class CommonServiceImpl implements CommonService {

	@Resource(name = "KmsCommonDAO")
	private CommonDAO commonDAO;

    @Resource(name="KmsScheduleDAO")
    private ScheduleDAO scheduleDAO;
    
	@Override
	public EgovMap getCheckList(MemberVO user) throws Exception {
		List<EgovMap> list = commonDAO.getCheckList(user);
		EgovMap result = new EgovMap();
		
		for (int i=0; i<list.size(); i++) {
			EgovMap t = list.get(i);
			result.put(t.get("id"), t.get("cnt"));
		}
		return result;
	}
	
	@Override
	public EgovMap getReferenceList(MemberVO user) throws Exception {
		List<EgovMap> list = commonDAO.getReferenceList(user);
		EgovMap result = new EgovMap();
		
		for (int i=0; i<list.size(); i++) {
			EgovMap t = list.get(i);
			result.put(t.get("id"), t.get("cnt"));
		}
		return result;
	}

	@Override
	public EgovMap getCommunityUnreadCnt(MemberVO user) throws Exception {
		List<EgovMap> list = commonDAO.getCommunityUnreadCnt(user);
		EgovMap result = new EgovMap();
		
		for (int i=0; i<list.size(); i++) {
			EgovMap t = list.get(i);
			result.put(t.get("id"), t.get("cnt"));
		}
		return result;
	}

	@Override
	public List<EgovMap> getTaxCheckList(Map<String, Object> param) throws Exception {
		return commonDAO.getTaxCheckList(param);
	}
	
	
	@Override
	public List<ExpansionVO> getExpansionList(MemberVO user) throws Exception {
		return commonDAO.getExpansionList(user);
	}

	@Override
	public List<ExpansionVO> getUnuseExpansionList(MemberVO user) throws Exception {
		return commonDAO.getUnuseExpansionList(user);
	}

	@Override
	public void updateExpansionOrder(Map<String, Object> map) throws Exception {
		commonDAO.updateExpansionOrder(map);
	}

	@Override
	public void deleteExpansionUse(Map<String, Object> commandMap)
			throws Exception {
		commonDAO.deleteExpansionUse(commandMap);
	}

	@Override
	public void insertExpansionUse(Map<String, Object> commandMap)
			throws Exception {
		commonDAO.insertExpansionUse(commandMap);
	}
	
	

	@Override
	public List<EgovMap> getMyMenuList(MemberVO user) throws Exception {
		return commonDAO.getMyMenuList(user);
	}

	@Override
	public EgovMap getCalendar(Map<String, Object> commandMap, MemberVO user) throws Exception {
		
		EgovMap result = new EgovMap();
		
		String today = CalendarUtil.getToday();

    	String date = (String)commandMap.get("date");
    	String calYear = (String)commandMap.get("calYear");
    	String calMonth = (String)commandMap.get("calMonth");
    	
    	if (date == null || date.equals("")) date = today;
    	if (calYear == null || calYear.equals("")) calYear = today.substring(0,4);
    	if (calMonth == null || calMonth.equals("")) calMonth = today.substring(4,6);

    	int firstDay = CalendarUtil.getFirstDayOfMonth(calYear, calMonth);
    	int lastDate = CalendarUtil.getLastDateOfMonth(calYear, calMonth);
    	
    	List<Map<String, Object>> calList = new ArrayList<Map<String, Object>>();
    	for (int i=1; i<=lastDate; i++) {
    		String dd = String.valueOf(i);
    		if (dd.length() == 1) dd = "0" + dd;
    		String yyyymmdd = calYear + calMonth + dd;
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("date", yyyymmdd);
    		map.put("dd", i);
    		map.put("day", CalendarUtil.getDay(yyyymmdd));
    		
    		calList.add(map);
    	}
    	
    	result.put("calList", calList);
    	result.put("calYear", calYear);
    	result.put("calMonth", calMonth);
    	result.put("date", date);
    	result.put("firstDay", firstDay);
    	result.put("lastDate", lastDate);
    	
    	return result;
	}

	@Override
	public EgovMap getSchedule(Map<String, Object> commandMap, MemberVO user) throws Exception {

		EgovMap result = new EgovMap();

		String today = CalendarUtil.getToday();

    	String date = (String)commandMap.get("date");
    	
    	if (date == null || date.equals("")) date = today;
    	
		ScheduleVO vo = new ScheduleVO();
		vo.setUserNo(user.getNo());
		vo.setOrgnztId(user.getOrgnztId());
		vo.setScheYear(date.substring(0,4));
		vo.setScheMonth(date.substring(4,6));
		vo.setScheDate(date.substring(6,8));
		
		List<ScheduleVO> scheList = scheduleDAO.selectScheduleList(vo);
		
		String showDate = date.substring(0,4) + "." + date.substring(4,6) + "." + date.substring(6,8) + " (" + CalendarUtil.getDay(date,"KOR") + ")";
		
		result.put("scheList", scheList);
		result.put("date", showDate);
		
		return result;
	}

	@Override
	public void insertMymenu(Map<String, Object> commandMap) throws Exception {
		commonDAO.insertMymenu(commandMap);
	}

	@Override
	public EgovMap getMyMenu(Map<String, Object> commandMap) throws Exception {
		return commonDAO.getMyMynu(commandMap);
	}

	@Override
	public void updateMymenu(Map<String, Object> commandMap) throws Exception {
		commonDAO.updateMymenu(commandMap);
	}

	@Override
	public void deleteMymenu(Map<String, Object> commandMap) throws Exception {
		commonDAO.deleteMymenu(commandMap);
	}


	
	@Override
	public List<EgovMap> selectBusiIdList(int searchYear) throws Exception {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("searchYear", searchYear);
		
		return commonDAO.selectBusiIdList(param);
	}

	@Override
	public List<EgovMap> selectOrgList(String searchOrgId) throws Exception {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("searchOrgId", searchOrgId);
		
		return commonDAO.selectOrgList(param);
	}

	@Override
	public List<EgovMap> selectUnderOrgList(String[] searchBusiIdList) throws Exception {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("searchBusiIdList", searchBusiIdList);
		
		return commonDAO.selectUnderOrgList(param);
	}

	@Override
	public List<BusinessSectorVO> selectBusinessSectorList(Map<String, Object> param) throws Exception {
		
		List<BusinessSectorVO> resultList = new ArrayList<BusinessSectorVO>();
		List<BusinessSectorVO> list = commonDAO.selectBusinessSectorList(param);
		
		int no = 0;
		for (int i=0; i<list.size(); i++) {
			BusinessSectorVO tmp = list.get(i);			
			if (i == 0 || no != tmp.getNo()) {
				resultList.add(tmp);				
				no = tmp.getNo();
			} else {
				resultList.get(resultList.size() - 1).addBusiSectorValNm(tmp.getBusiSectorValNm());
			}
		}
		return resultList;
	}
	
	@Override
	public List<BusinessSectorVO> selectBusinessSectorList(int searchYear) throws Exception {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("searchYear", searchYear);
		
		return selectBusinessSectorList(param);
	}
	
	@Override
	public List<EgovMap> selectBusinessSectorListSelBox(Map<String, Object> param) throws Exception {
		
		List<EgovMap> resultList = commonDAO.selectBusinessSectorListSelBox(param);
		
		return resultList;
	}
	
	@Override
	public List<EgovMap> selectBusinessSectorListSelBox(int searchYear) throws Exception {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("searchYear", searchYear);
		
		return selectBusinessSectorListSelBox(param);
	}
	
	@Override
	public void insertBusinessSector(Map<String, Object> commandMap)
			throws Exception {
		commonDAO.insertBusinessSector(commandMap);
	}

	@Override
	public void updateBusinessSector(Map<String, Object> commandMap)
			throws Exception {
		commonDAO.updateBusinessSector(commandMap);
	}
	
	@Override
	public void updateBusinessSectorOrd(Map<String, Object> commandMap)
	throws Exception {
		commonDAO.updateBusinessSectorOrd(commandMap);
	}

	@Override
	public List<EgovMap> selectCurrentUserList()
			throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.selectCurrentUserList();
	}

	@Override
	public void updateCurrentUser(Map<String, Object> commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		int currentUserChk = (int) commonDAO.selectCurrentUserCntChek(commandMap);
		if (currentUserChk == 0) {
			commonDAO.insertCurrentUser(commandMap);
		} else {
			commonDAO.updateCurrentUser(commandMap);
		}
	}

	@Override
	public List<EgovMap> getScrapList(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.getScrapList(commandMap);
	}
	
	@Override
	public int getScrapListCnt(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.getScrapListCnt(commandMap);
	}

	@Override
	public void insertScrap(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		commonDAO.insertScrap(commandMap);
	}

	@Override
	public void deleteScrap(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		commonDAO.deleteScrap(commandMap);
	}
	
	@Override
	public List<EgovMap> getMyArticleList(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.getMyArticleList(commandMap);
	}
	
	@Override
	public int getMyArticleListCnt(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.getMyArticleListCnt(commandMap);
	}

	@Override
	public List selectComtccmmndetailcode(Map<String, Object> commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.selectComtccmmndetailcode(commandMap);
	}
	
	@Override
	public List<StatisticSectorVO> selectStatisticSectorList(StatisticSectorVO ssVO) throws Exception {
		
		List<StatisticSectorVO> resultList = new ArrayList<StatisticSectorVO>();
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("searchYear", ssVO.getSearchYear());
		searchMap.put("sectorTyp", ssVO.getSectorTyp());
		
		List<StatisticSectorVO> list = commonDAO.selectStatisticSectorList(searchMap);
		
		int no = 0;
		for (int i=0; i<list.size(); i++) {
			StatisticSectorVO tmp = list.get(i);			
			if (i == 0 || no != tmp.getNo()) {
				resultList.add(tmp);				
				no = tmp.getNo();
			} else {
				resultList.get(resultList.size() - 1).addStatisticSectorValNm(tmp.getStatisticSectorValNm());
			}
		}
		return resultList;
	}

	@Override
	public void insertStatisticSector(Map<String, Object> commandMap)
			throws Exception {
		commonDAO.insertStatisticSector(commandMap);
	}

	@Override
	public void updateStatisticSector(Map<String, Object> commandMap)
			throws Exception {
		commonDAO.updateStatisticSector(commandMap);
	}
	
	@Override
	public void deleteStatisticSector(Map<String, Object> commandMap)
			throws Exception {
		commonDAO.deleteStatisticSector(commandMap);
	}

	@Override
	public void updateStatisticSectorOrd(Map<String, Object> commandMap)
			throws Exception {
		commonDAO.updateStatisticSectorOrd(commandMap);
	}
	
	// �ܺ� ���� �α� Ȯ�� ó��
	public void updataOuterNetLoginLog(MemberVO user) throws Exception {
		commonDAO.updataOuterNetLoginLog(user);
	}
}
