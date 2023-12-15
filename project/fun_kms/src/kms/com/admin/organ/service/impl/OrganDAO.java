package kms.com.admin.organ.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.admin.organ.service.Organ;
import kms.com.admin.organ.service.OrganVO;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * 조직코드에 대한 데이터 접근 클래스를 정의한다
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
@Repository("OrganDAO")
public class OrganDAO extends EgovAbstractDAO {
	Logger logT = Logger.getLogger("TENY");

	/**
	 * 조직코드를 삭제한다.
	 * @param Organ
	 * @throws Exception
	 */
	public void deleteOrgan(Organ organ) throws Exception {
		delete("OrganDAO.deleteOrgan", organ);
	}

	/**
	 * 조직코드를 등록한다.
	 * @param Organ
	 * @throws Exception
	 */
	public void insertOrgan(Organ Organ) throws Exception {
        insert("OrganDAO.insertOrgan", Organ);
	}

	/**
	 * 조직코드 이력을 등록한다.
	 * @param Organ
	 * @throws Exception
	 */
	public void insertOrganHis(Organ Organ) throws Exception {
        insert("OrganDAO.insertOrganHis", Organ);
	}	

	/**
	 * 조직코드 상세항목을 조회한다.
	 * @param Organ
	 * @return Organ(조직코드)
	 */
	public Organ selectOrganDetail(Organ organ) throws Exception {
		return (Organ)selectByPk("OrganDAO.selectOrganDetail", organ);
	}

    /**
	 * 조직코드 목록을 조회한다.
     * @param searchVO
     * @return List(조직코드 목록)
     * @throws Exception
     */
    public List selectOrganList(OrganVO searchVO) throws Exception {
        return list("OrganDAO.selectOrganList", searchVO);
    }

    /**
	 * 조직코드 목록을 조회한다.
     * @param searchVO
     * @return List(조직코드 목록)
     * @throws Exception
     */
    public List selectOrganTreeList(OrganVO searchVO) throws Exception {
        return list("OrganDAO.selectOrganTreeList", searchVO);
    }

    /**
	 * 조직코드 이력 목록을 조회한다.
     * @param searchVO
     * @return List(조직코드 목록)
     * @throws Exception
     */
    public List selectOrganListHis(Organ organ) throws Exception {
        return list("OrganDAO.selectOrganListHis", organ);
    }

    
    /**
	 * 조직코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(조직코드 총 갯수)
     */
    public int selectOrganListTotCnt(OrganVO searchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("OrganDAO.selectOrganListTotCnt", searchVO);
    }

	/**
	 * 조직코드를 수정한다.
	 * @param Organ
	 * @throws Exception
	 */
	public void updateOrgan(Organ organ) throws Exception {
		update("OrganDAO.updateOrgan", organ);
	}

	public void updatePrjCdBatch(Organ organ) {
		update("OrganDAO.updatePrjCdBatch", organ);
		
	}

	public void updateOrganTree(Organ organ) {
		update("OrganDAO.updateOrganTree", organ);
	}

    public List<Organ> selectSubOrganList(String orgnztId) throws Exception {
		logT.debug("START orgnztId : " + orgnztId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgnztId", orgnztId);
        return list("OrganDAO.selectSubOrganList", map);
    }
}
