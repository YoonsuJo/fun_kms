package kms.com.admin.score.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import kms.com.admin.organ.service.OrganService;
import kms.com.admin.organ.service.Organ;
import kms.com.admin.organ.service.OrganVO;
import kms.com.admin.organ.service.impl.OrganDAO;
import kms.com.admin.score.service.ScoreDAO;
import kms.com.admin.score.service.ScoreDetailVO;
import kms.com.admin.score.service.ScoreService;
import kms.com.admin.score.service.ScoreVO;



/**
 * 
 * 점수관리에 대한 서비스 구현클래스를 정의한다
 * @author 양진환
 * @since 2011.09.15
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.09.15 양진환          작성
 *
 * </pre>
 */
@Service("ScoreService")
public class ScoreServiceImpl extends AbstractServiceImpl implements ScoreService {

	@Resource(name="ScoreDAO")
    private ScoreDAO scoreDAO;
	
	
	@Resource(name = "kmsScoreIdGnrService")
	private EgovIdGnrService idgenService;
	

	@Override
	public List selectScorePolicyList()
			throws Exception {
		// TODO Auto-generated method stub
		return scoreDAO.selectScorePolicyList();
	}
	
	@Override
	public void updateScorePolicy(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		scoreDAO.updateScorePolicy(param);
	}
	
	@Override
	public List selectRankList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		List resultList = scoreDAO.selectRankList(param);
		
		for (int i = 0, cnt = 0; i < resultList.size(); i++) {
			Map<String,Object> obj = (Map<String,Object>) resultList.get(i);
			
			if (obj.get("itsMe").toString().equals("1")) {
				obj.put("on", "1");
			} else if (cnt < 4) {
				obj.put("on", "1");
				cnt++;
			}
			/* 자신의 주변 순위를 표시
			if (obj.get("itsMe").toString().equals("1")) {
				int s = i - 2;
				while (s < 0)
					s++;
				while (s + 5 > resultList.size())
					s--;
				((Map<String,Object>) resultList.get(s + 0)).put("on", "1");
				((Map<String,Object>) resultList.get(s + 1)).put("on", "1");
				((Map<String,Object>) resultList.get(s + 2)).put("on", "1");
				((Map<String,Object>) resultList.get(s + 3)).put("on", "1");
				((Map<String,Object>) resultList.get(s + 4)).put("on", "1");
				break;
			}
			*/
		}
		
		return resultList;
	}

}
