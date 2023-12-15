package kms.com.app.service.impl;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import kms.com.app.service.KmsSelfdevService;
import kms.com.app.service.SelfdevVO;
import kms.com.common.exception.IdMixInputException;
import kms.com.common.utils.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  
 *  </pre>
 */
/**
 * @author blind
 *
 */
/**
 * @author blind
 *
 */
@Service("KmsSelfdevService")
public class KmsSelfdevServiceImpl extends AbstractServiceImpl implements
	KmsSelfdevService {

    @Resource(name="selfdevDAO")
    private SelfdevDAO selfdevDAO;

	@Override
	public void deleteSelfdev(SelfdevVO selfDevVO) {
		selfdevDAO.deleteSelfdev(selfDevVO);
	}

	@Override
	public void insertSelfdev(SelfdevVO selfDevVO) {
		selfdevDAO.insertSelfdev(selfDevVO);
		
	}

	@Override
	public List selectSelfdevCmmList(SelfdevVO searchVO) throws Exception {
		return selfdevDAO.selectSelfdevCmmList(searchVO);
	}


	@Override
	public List selectSelfdevUsrList(SelfdevVO searchVO) throws Exception {
		return selfdevDAO.selectSelfdevUsrList(searchVO);
	}
 
	@Override
	public SelfdevVO selectSelfdevUsrInfo(SelfdevVO searchVO) throws Exception {
		return selfdevDAO.selectSelfdevUsrInfo(searchVO);
	}

	@Override
	public void updateSelfdev(SelfdevVO selfDevVO) {
		selfdevDAO.updateSelfdev(selfDevVO);
	}

	
	@Override
	public void updateSelfdevCmm(SelfdevVO selfdevCmmVO) throws Exception {
		for(int i=0; i< selfdevCmmVO.getSelfdevFullList().length;i++)
		{
			 SelfdevVO vo =new SelfdevVO();
			 vo.setYear(selfdevCmmVO.getYear());
			 vo.setMonth(i+1);
			 vo.setFull(selfdevCmmVO.getSelfdevFullList()[i]);
			 vo.setHalf(selfdevCmmVO.getSelfdevHalfList()[i]);
			 
			 int Cnt = selfdevDAO.selectSelfdevCmmCnt(vo);
			 if(Cnt > 0){
				 selfdevDAO.updateSelfdevCmm(vo);
			 }else{
				 selfdevDAO.insertSelfdevCmm(vo);
			 }		
		}
		
	}

	@Override
	public SelfdevVO selectSelfdevUsrView(SelfdevVO searchVO) {
		return selfdevDAO.selectSelfdevUsrView(searchVO);
	}

	@Override
	public void insertSelfdevUsr(SelfdevVO selfdevVO) throws IdMixInputException {
		selfdevVO.setUserId(CommonUtil.parseIdFromMixs(selfdevVO.getUserMix())[0]);
		selfdevDAO.insertSelfdevUsr(selfdevVO);
		
	}

	@Override
	public void updateSelfdevUsr(SelfdevVO selfdevVO) {
		selfdevDAO.updateSelfdevUsr(selfdevVO);
		
	}

	@Override
	public void deleteSelfdevUsr(SelfdevVO searchVO) {
		selfdevDAO.deleteSelfdevUsr(searchVO);
	}



        
}
