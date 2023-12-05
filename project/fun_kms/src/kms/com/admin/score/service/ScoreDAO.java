package kms.com.admin.score.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : TblScoreDAO.java
 * @Description : TblScore DAO Class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("ScoreDAO")
public class ScoreDAO extends EgovAbstractDAO {

	public List selectScorePolicyList() throws Exception  {
		return list("scoreDAO.selectSocePolicyList", null);
		
	}
	
	public void updateScorePolicy(Map<String,Object> param) throws Exception  {
		update("scoreDAO.updateScorePolicy", param);
	}

	public List selectRankList(Map<String, Object> param) {
		return list("scoreDAO.selectRankList", param);
	}

}
