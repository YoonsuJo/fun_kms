package kms.com.admin.organ.service.impl;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import kms.com.admin.organ.service.Organ;
import kms.com.admin.organ.service.OrganService;
import kms.com.admin.organ.service.OrganVO;
import kms.com.member.service.impl.MemberDAO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;



/**
 * 
 * 조직코드에 대한 서비스 구현클래스를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *
 * </pre>
 */
@Service("OrganService")
public class OrganServiceImpl extends AbstractServiceImpl implements OrganService {

    @Resource(name="OrganDAO")
    private OrganDAO organDAO;

    @Resource(name="KmsMemberDAO")
    private MemberDAO memberDAO;
    
	/**
	 * 조직코드를 삭제한다.
	 */
	public void deleteOrgan(Organ organ) throws Exception {
		organDAO.deleteOrgan(organ);
	}

	/**
	 * 조직코드를 등록한다.
	 */
	public void insertOrgan(Organ organ) throws Exception {
    	organDAO.insertOrgan(organ);    	
	}
	
	/**
	 * 조직코드의 이력을 등록한다.
	 */
	public void insertOrganHis(Organ organ) throws Exception {
    	organDAO.insertOrganHis(organ);    	
	}	

	/**
	 * 조직코드 상세항목을 조회한다.
	 */
	public Organ selectOrganDetail(Organ organ) throws Exception {
    	Organ ret = (Organ)organDAO.selectOrganDetail(organ);
    	return ret;
	}

	/**
	 * 조직코드 목록을 조회한다.
	 */
	public List selectOrganList(OrganVO searchVO) throws Exception {
        return organDAO.selectOrganList(searchVO);
	}
		

	/**
	 * 조직코드 목록을 조회한다.
	 */
	public List selectOrganTreeList(OrganVO searchVO) throws Exception {
        return organDAO.selectOrganTreeList(searchVO);
	}	
	
	/**
	 * 조직코드 이력목록을 조회한다.
	 */
	public List selectOrganListHis(Organ organ) throws Exception {
        return organDAO.selectOrganListHis(organ);
	}		

	/**
	 * 조직코드 총 갯수를 조회한다.
	 */
	public int selectOrganListTotCnt(OrganVO searchVO) throws Exception {
        return organDAO.selectOrganListTotCnt(searchVO);
	}

	/**
	 * 조직코드를 수정한다.
	 */
	public void updateOrgan(Organ organ) throws Exception {
		Organ organ2 = (Organ)organDAO.selectOrganDetail(organ);
		organDAO.updateOrgan(organ);
		
		//조직 약어 변경시 하위 프로젝트의 cd 값 변경 
		if(organ2.getOrgnztSnm().equals(organ.getOrgnztSnm()) == false ) {
			organ2.setCurOrgSnm(organ.getOrgnztSnm());
			organDAO.updatePrjCdBatch(organ2);
		}
		organ.setAftCompId(organ.getOrgUp());
		//memberDAO.insertPositionHistoryOrgUpdate(organ); //의미가 없어서 주석처리. 일괄발령이 필요하면 따로 기능을 만들어야함
	}

	@Override
	public void updateOrganTree(Organ organ) {
		organDAO.updateOrganTree(organ);
	}


}
