package kms.com.daily.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.json.simple.JSONObject;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.common.utils.CalendarUtil;
import kms.com.daily.vo.*;

@Repository("KmsDailyDAO")
public class DailyDAO extends EgovAbstractDAO {
	Logger logT = Logger.getLogger("TENY");

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 업무계획 관련 함수들
	// 업무계획 목록을 가져온다 (조건 : 특정작성자, 기간 )
	public List<DailyPlanVO> selectDailyPlanList(int writerNo, String fromDate, String toDate) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("writerNo", writerNo);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);

		return list("KmsDailyDAO.selectDailyPlanList", map);
	}
	// 업무계획 목록을 가져온다. (조건 : 특정부서, 특정일) 
	public List<DailyPlanVO> selectDailyPlanListOrg(String orgnztId, String atDate) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgnztId", orgnztId);
		map.put("atDate", atDate);

		List<DailyPlanVO> list = list("KmsDailyDAO.selectDailyPlanListOrg", map);
		logT.debug("result count = " + list.size());
		return list;
	}

	// 업무계획을 추가한다.
	public void insertDailyPlan(DailyPlanVO vo) throws Exception {
		insert("KmsDailyDAO.insertDailyPlan", vo);
	}

	// 업무계획을 수정한다.
	public void updateDailyPlan(Map<String, Object> map) throws Exception {
		update("KmsDailyDAO.updateDailyPlan", map);
	}

	/* TENY_170406  한개의 업무계획을 조회하는 DAO메소드 */
	public DailyPlanVO getDailyPlan(int writerNo, String writeDate) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("writerNo", writerNo);
		map.put("writeDate", writeDate);
		logT.debug("writerNo" + writerNo);
		logT.debug("writeDate" + writeDate);

		DailyPlanVO vo = (DailyPlanVO)selectByPk("KmsDailyDAO.getDailyPlan", map);
		if(vo == null){
			logT.debug("fail to find row");
		}
		return vo;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 업무실적 관련 함수들
	// 업무실적 목록을 가져온다 (조건 : 특정작성자, 기간 )
	public List<DailyResultVO> selectDailyResultList(int writerNo, String fromDate, String toDate) throws Exception {
		logT.debug("START ");
		logT.debug("writerNo : " + writerNo);
		logT.debug("fromDate : " + fromDate);
		logT.debug("toDate : " + toDate);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("writerNo", writerNo);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);

		return list("KmsDailyDAO.selectDailyResultList", map);
	}
	// 업무실적 목록을 가져온다. (조건 : 특정부서, 특정일) 
	public List<DailyResultVO> selectDailyResultListOrg(String orgnztId, String atDate) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgnztId", orgnztId);
		map.put("atDate", atDate);

		return list("KmsDailyDAO.selectDailyResultListOrg", map);
	}

	// 실적등록내용을 가져온다. (조건 : 특정사람, 특정일)
	public List<DailyResultVO> selectDailyResultList(Map<String, Object> map) throws Exception {
		return list("KmsDailyDAO.selectDailyResultList", map);
	}

	public List<DailyResultVO> selectResultListByPrjId(String prjId, String searchYear, int recordCountPerPage, int firstIndex) throws Exception {
		logT.debug("START ");
		logT.debug("prjId : " + prjId);
		logT.debug("searchYear : " + searchYear);
		logT.debug("recordCountPerPage : " + recordCountPerPage);
		logT.debug("firstIndex : " + firstIndex);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prjId", prjId);
/*		if((searchYear != null) && (searchYear.length() > 0)) {
			map.put("searchYear", searchYear);
		}
		
*/		map.put("recordCountPerPage", recordCountPerPage);
		map.put("firstIndex", firstIndex);

		return list("KmsDailyDAO.selectResultListByPrjId", map);
	}
	
	public int selectResultListByPrjIdTotCnt(String prjId, String searchYear) {
		logT.debug("START ");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prjId", prjId);
/*		if((searchYear != null) && (searchYear.length() > 0)) {
			map.put("searchYear", searchYear);
		}
*/		return (Integer)getSqlMapClientTemplate().queryForObject("KmsDailyDAO.selectResultListByPrjIdTotCnt", map);
	}

	// 업무실적을 추가한다. (수행자, 작성기준일, 프로젝트, 투입시간, 업무내용) 
	public void insertDailyResult(DailyResultVO vo) throws Exception {
		insert("KmsDailyDAO.insertDailyResult", vo);
	}

	public void insertDailyResultJO(JSONObject jo) throws Exception {
		insert("KmsDailyDAO.insertDailyResult", jo);
	}

	// 일일업무관련 실적등록을 삭제한다. 이때 기준은 일일업무계획의 번호(no) 
	public void deleteDailyResult(int writerNo, String writeDate) throws Exception {
		logT.debug("START");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("writerNo", writerNo);
		map.put("writeDate", writeDate);

		int ret = this.delete("KmsDailyDAO.deleteDailyResult", map);
	}
	
	public List<DailyPlanVO> selectDailyTaskList(int userNo, String atDate) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", userNo);
		map.put("atDate", atDate);

		return list("KmsDailyDAO.selectDailyTaskList", map);
	}
}
