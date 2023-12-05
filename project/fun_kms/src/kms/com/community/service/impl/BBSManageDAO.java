package kms.com.community.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import kms.com.community.service.Board;
import kms.com.community.service.BoardVO;
import kms.com.member.service.MemberVO;
import kms.com.support.service.Suggest;
import kms.com.support.service.SuggestVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 게시물 관리를 위한 데이터 접근 클래스
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
@Repository("KmsBBSManageDAO")
public class BBSManageDAO extends EgovAbstractDAO {

    /**
     * 게시판에 게시물을 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public long insertBoardArticle(Board board) throws Exception {
		long nttId = (Long)getSqlMapClientTemplate().queryForObject("KmsBBSManageDAO.selectMaxNttId");
		board.setNttId(nttId);
		
		insert("KmsBBSManageDAO.insertBoardArticle", board);
		
		return nttId;
    }

    /**
     * 게시판에 답변 게시물을 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public long replyBoardArticle(Board board) throws Exception {
		long nttId = (Long)getSqlMapClientTemplate().queryForObject("KmsBBSManageDAO.selectMaxNttId");
		board.setNttId(nttId);
		
		insert("KmsBBSManageDAO.replyBoardArticle", board);
	
		//----------------------------------------------------------
		// 현재 글 이후 게시물에 대한 NTT_NO를 증가 (정렬을 추가하기 위해)
		//----------------------------------------------------------
		//String parentId = board.getParnts();
		long nttNo = (Long)getSqlMapClientTemplate().queryForObject("KmsBBSManageDAO.getParentNttNo", board);
	
		board.setNttNo(nttNo);
		update("KmsBBSManageDAO.updateOtherNttNo", board);
	
		board.setNttNo(nttNo + 1);
		update("KmsBBSManageDAO.updateNttNo", board);
	
		return nttId;
    }
	
    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
    	return (BoardVO)selectByPk("KmsBBSManageDAO.selectBoardArticle", boardVO);
    }
    
    /**
     * 조회하는 게시판을 읽은 상태로 변경한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public String getBoardArticleRead(BoardVO boardVo) throws Exception {
    	return (String)selectByPk("KmsBBSManageDAO.getBoardArticleRead", boardVo);
    }

    /**
     * 조회하는 게시판을 읽은 상태로 변경한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public void setBoardArticleRead(BoardVO boardVo) throws Exception {
    	insert("KmsBBSManageDAO.setBoardArticleRead", boardVo);
    }

    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectBoardArticleList(BoardVO boardVO) throws Exception {
    	return list("KmsBBSManageDAO.selectBoardArticleList", boardVO);
    }
    
    @SuppressWarnings("unchecked")
	public List<BoardVO> selectUnreadBoardArticleList(BoardVO boardVO) {
    	return list("KmsBBSManageDAO.selectUnreadBoardArticleList", boardVO);
	}

    /**
     * 게시판의 정보를 조회한다.
     * @param boardVO
     * @return
     * @throws Exception
     */
    public BoardVO selectBoardInfo(BoardVO boardVO) throws Exception {
    	return (BoardVO)selectByPk("KmsBBSManageDAO.selectBoardInfo", boardVO);
    }
    
    /**
     * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectBoardArticleListCnt(BoardVO boardVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("KmsBBSManageDAO.selectBoardArticleListCnt", boardVO);
    }
    public int selectUnreadBoardArticleListCnt(BoardVO boardVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("KmsBBSManageDAO.selectUnreadBoardArticleListCnt", boardVO);
    }

    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticle(Board board) throws Exception {
    	update("KmsBBSManageDAO.updateBoardArticle", board);
    }

    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void deleteBoardArticle(Board board) throws Exception {
    	update("KmsBBSManageDAO.deleteBoardArticle", board);
    }

    /**
     * 게시물에 대한 조회 건수를 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateInqireCo(BoardVO boardVO) throws Exception {
    	update("KmsBBSManageDAO.updateInqireCo", boardVO);
    }

    /**
     * 게시물에 대한 현재 조회 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectMaxInqireCo(BoardVO boardVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("KmsBBSManageDAO.selectMaxInqireCo", boardVO);
    }


	public List<BoardVO> getNewFreeList(MemberVO user) {
		return list("KmsBBSManageDAO.selectNewFreeList", user);
	}

	public List<BoardVO> getNewDiscussList(MemberVO user) {
		return list("KmsBBSManageDAO.selectNewDiscussList", user);
	}

	public void deleteReadHistory(BoardVO boardVO) throws Exception {
		delete("KmsBBSManageDAO.deleteReadHistory", boardVO);
	}

	public void setDiscussState(BoardVO boardVO) {
		update("KmsBBSManageDAO.setDiscussState", boardVO);
	}

	public List<EgovMap> selectSuggestSummary(BoardVO boardVO) {
		return list("KmsBBSManageDAO.selectSuggestSummary", boardVO);
	}

	public List<SuggestVO> selectSuggestHistory(SuggestVO suggestVO) {
		return list("KmsBBSManageDAO.selectSuggestHistory", suggestVO);
	}

	public void insertSuggestHistory(Suggest suggest) {
		insert("KmsBBSManageDAO.insertSuggestHistory", suggest);
	}

	public void updateBbsId(Map<String, Object> commandMap) {
		update("KmsBBSManageDAO.updateBbsId", commandMap);
	}
	
	public void updateBbsIdComment(Map<String, Object> commandMap) {
		update("KmsBBSManageDAO.updateBbsIdComment", commandMap);
	}
	
	public List<EgovMap> selectPrjBoardMain(BoardVO boardVO) {
		return list("KmsBBSManageDAO.selectPrjBoardMain", boardVO);
	}

	public List<EgovMap> selectOrgBoardMain(BoardVO boardVO) {
		return list("KmsBBSManageDAO.selectOrgBoardMain", boardVO);
	}

	public List<EgovMap> selectBoardListHeadSearch(BoardVO boardVO) {
		return list("KmsBBSManageDAO.selectBoardListHeadSearch", boardVO);
	}

	public int selectBoardListHeadSearchTotCnt(BoardVO boardVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsBBSManageDAO.selectBoardListHeadSearchTotCnt", boardVO);
	}

}
