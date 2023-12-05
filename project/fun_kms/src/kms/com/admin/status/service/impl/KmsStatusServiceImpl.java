package kms.com.admin.status.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.admin.organ.service.OrganService;
import kms.com.admin.organ.service.Organ;
import kms.com.admin.organ.service.OrganVO;
import kms.com.admin.organ.service.impl.OrganDAO;
import kms.com.admin.score.service.ScoreDAO;
import kms.com.admin.score.service.ScoreDetailVO;
import kms.com.admin.score.service.ScoreService;
import kms.com.admin.score.service.ScoreVO;
import kms.com.admin.status.service.KmsStatusDAO;
import kms.com.admin.status.service.KmsStatusService;



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
@Service("StatusService")
public class KmsStatusServiceImpl extends AbstractServiceImpl implements KmsStatusService {

	@Resource(name="KmsStatusDAO")
    private KmsStatusDAO statusDAO;
	
	
	@Resource(name = "kmsScoreIdGnrService")
	private EgovIdGnrService idgenService;


	@Override
	public List selectLoginStatus(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return statusDAO.selectLoginStatus(param);
	}


	@Override
	public List selectLoginStatusList(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return statusDAO.selectLoginStatusList(param);
	}
	
	@Override
	public List<EgovMap> selectLoginStatusExcel(Map<String, Object> param) throws Exception {
		List<EgovMap> resultList = statusDAO.selectLoginStatusExcel(param);
		return resultList;
	}
	
}
