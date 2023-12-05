package kms.com.admin.score.service;

import java.util.List;
import java.util.Map;


/**
 * @Class Name : ScoreService.java
 * @Description : Score Business class
 * @Modification Information 
 * 
 * 
 * @author 양진환
 * @since 20110915
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ScoreService {
    
	List selectScorePolicyList() throws Exception;
	
	void updateScorePolicy(Map<String,Object> param) throws Exception;
	
	List selectRankList(Map<String,Object> param);
}
