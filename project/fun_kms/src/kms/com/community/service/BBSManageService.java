package kms.com.community.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.member.service.MemberVO;
import kms.com.support.service.Suggest;
import kms.com.support.service.SuggestVO;


/**
 * 게시물 관리를 위한 서비스 인터페이스  클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *
 * </pre>
 */
public interface BBSManageService {

    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void deleteBoardArticle(Board Board) throws Exception;

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public long insertBoardArticle(Board Board) throws Exception;

    /**
     * 게시물 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception;

    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoardArticles(BoardVO boardVO, String attrbFlag) throws Exception;
	public Map<String, Object> selectUnreadBoardArticles(BoardVO boardVO, String attrbFlag) throws Exception;

    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void updateBoardArticle(Board Board) throws Exception;


	public Map<String, Object> selectAllBoardArticles(MemberVO user) throws Exception;

	public void setDiscussState(BoardVO boardVO) throws Exception;

	public EgovMap selectSuggestSummary(BoardVO boardVO) throws Exception;

	public List<SuggestVO> selectSuggestHistory(SuggestVO suggestVO) throws Exception;

	public void insertSuggestHistory(Suggest suggest) throws Exception;

	public void updateBbsId(Map<String, Object> commandMap) throws Exception;
	
	public void updateBbsIdComment(Map<String, Object> commandMap) throws Exception;

	public Map<String, Object> selectPrjBoardMain(BoardVO boardVO) throws Exception;
	public Map<String, Object> selectOrgBoardMain(BoardVO boardVO) throws Exception;

	public void deleteReadHistory(BoardVO boardVO) throws Exception;

	public Map<String, Object> selectBoardListHeadSearch(BoardVO boardVO) throws Exception;


}
