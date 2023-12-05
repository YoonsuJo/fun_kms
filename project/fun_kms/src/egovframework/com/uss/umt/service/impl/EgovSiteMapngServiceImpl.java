package egovframework.com.uss.umt.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import egovframework.com.uss.umt.service.EgovSiteMapngService;
import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.uss.umt.service.SiteMapngVO;

/** 
 * 사이트맵 조회를 처리하는 비즈니스 구현 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *
 * </pre>
 */
@Service("siteMapngService")
public class EgovSiteMapngServiceImpl extends AbstractServiceImpl implements EgovSiteMapngService{

	@Resource(name="siteMapngDAO")
    private SiteMapngDAO siteMapngDAO;

	/**
	 * 사이트맵 조회
	 * @param vo ComDefaultVO  
	 * @return SiteMapngVO
	 * @exception Exception
	 */

	public SiteMapngVO selectSiteMapng(ComDefaultVO vo) throws Exception{
		String sMapCreatID = null;

		SiteMapngVO sitemapngvo = new SiteMapngVO();
		sMapCreatID = siteMapngDAO.selectSiteMapngByMapCreatID(vo);
		vo.setSearchKeyword(sMapCreatID);
        return siteMapngDAO.selectSiteMapng(vo);
	}
}