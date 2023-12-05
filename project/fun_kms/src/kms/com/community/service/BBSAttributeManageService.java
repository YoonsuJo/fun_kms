package kms.com.community.service;

import java.util.List;
import java.util.Map;


/**
 * 게시판 속성관리를 위한 서비스 인터페이스 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2009.3.12  이삼섭          최초 생성
 *
 */
public interface BBSAttributeManageService {

    /**
     * 게시판 속성정보 한 건을 상세조회한다.
     * 
     * @param BoardMasterVO
     */
    public BoardMasterVO selectBBSMasterInf(BoardMaster searchVO) throws Exception;

	public List<BoardMasterVO> selectBoardMasterList(BoardMasterVO searchVO) throws Exception;;

}
