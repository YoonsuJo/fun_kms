package kms.com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.common.utils.CommonUtil;
import kms.com.cooperation.service.ProjectVO;
import kms.com.project.vo.StepResultVO;


@Repository("KmsProjectDAO2")
public class ProjectDAO2 extends EgovAbstractDAO {
	Logger logT = Logger.getLogger("TENY");

	// TENY_170402  내가 참여하고 있는 프로젝트 목록 가져오기
	public List<ProjectVO> selectMyProjectList(Map<String, Object> map) throws Exception{
		logT.debug("START");
		return (List<ProjectVO>) list("KmsProjectDAO2.selectMyProjectList", map);
	}

	public List<StepResultVO> selectStepResultStatistic(kms.com.project.vo.StepResultVO brVO, boolean reCalc) {
		logT.debug("START");
		return list("KmsProjectDAO2.selectStepResultStatistic", brVO);
	}
	
	public Integer selectProjectBondCheckYCount(String prjId) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prjId", prjId);
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsProjectDAO2.selectProjectBondCheckYCount", map);
	}
	
}
