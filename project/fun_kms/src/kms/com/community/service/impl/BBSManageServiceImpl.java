package kms.com.community.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kms.com.admin.score.service.ScoreDetail;
import kms.com.admin.score.service.ScoreDetailVO;
import kms.com.admin.score.service.ScoreService;
import kms.com.admin.score.service.ScoreVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileVO;
import kms.com.community.service.Board;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BoardVO;
import kms.com.community.service.BBSManageService;
import kms.com.community.service.MailVO;
import kms.com.member.service.MemberVO;
import kms.com.support.service.Suggest;
import kms.com.support.service.SuggestVO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 게시물 관리를 위한 서비스 구현 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *
 * </pre>
 */
@Service("KmsBBSManageService")
public class BBSManageServiceImpl extends AbstractServiceImpl implements BBSManageService {

    @Resource(name = "KmsBBSManageDAO")
    private BBSManageDAO bbsMngDAO;

    @Resource(name = "KmsMailDAO")
    private MailDAO mailDAO;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    
    Logger log = Logger.getLogger(this.getClass());
	
    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @see egovframework.com.cop.bbs.BBSManageService.service.EgovBBSManageService#deleteBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
     */
    public void deleteBoardArticle(Board board) throws Exception {
		FileVO fvo = new FileVO();
		
		fvo.setAtchFileId(board.getAtchFileId());
	
		board.setNttSj("이 글은 작성자에 의해서 삭제되었습니다.");
	
		bbsMngDAO.deleteBoardArticle(board);
	
		if (!"".equals(fvo.getAtchFileId()) || fvo.getAtchFileId() != null) {
		    fileService.deleteAllFileInf(fvo);
		}
    }

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     * 
     * @see egovframework.com.cop.bbs.BBSManageService.service.EgovBBSManageService#insertBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
     */
    public long insertBoardArticle(Board board) throws Exception {
		// SORT_ORDR는 부모글의 소트 오더와 같게, NTT_NO는 순서대로 부여
	
		if ("Y".equals(board.getReplyAt())) {
		    // 답글인 경우 1. Parnts를 세팅, 2.Parnts의 sortOrdr을 현재글의 sortOrdr로 가져오도록, 3.nttNo는 현재 게시판의 순서대로
		    // replyLc는 부모글의 ReplyLc + 1
		    
		    //String tmpParnts = board.getParnts();
				
		    @SuppressWarnings("unused")
		    long tmpNttId = 0L; // 답글 게시물 ID			
				
		    return bbsMngDAO.replyBoardArticle(board);
	
		} else {
		    // 답글이 아닌경우 Parnts = 0, replyLc는 = 0, sortOrdr = nttNo(Query에서 처리)
		    board.setParnts("0");
		    board.setReplyLc("0");
		    board.setReplyAt("N");
		    
		    return bbsMngDAO.insertBoardArticle(board);
		}
    }

	/**
     * 게시물 대하여 상세 내용을 조회 한다.
     * 
     * @see egovframework.com.cop.bbs.BBSManageService.service.EgovBBSManageService#selectBoardArticle(egovframework.com.cop.bbs.brd.service.BoardVO)
     */
    public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
		if (boardVO.isPlusCount()) {
		    int iniqireCo = bbsMngDAO.selectMaxInqireCo(boardVO);
		    
		    boardVO.setInqireCo(iniqireCo);
		    bbsMngDAO.updateInqireCo(boardVO);
		}
		if ("Y".equals(boardVO.getReadBool()) == false && "Y".equals(bbsMngDAO.getBoardArticleRead(boardVO)) == false) {
			bbsMngDAO.setBoardArticleRead(boardVO);
		}
		BoardVO result =  bbsMngDAO.selectBoardArticle(boardVO);		
		
		return result;
    }

	/**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @see egovframework.com.cop.bbs.BBSManageService.service.EgovBBSManageService#selectBoardArticles(egovframework.com.cop.bbs.brd.service.BoardVO)
     */
    public Map<String, Object> selectBoardArticles(BoardVO boardVO, String attrbFlag) throws Exception {
		List<BoardVO> list = bbsMngDAO.selectBoardArticleList(boardVO);
		List<BoardVO> result = new ArrayList<BoardVO>();
	
	    result = list;
	
		int cnt = bbsMngDAO.selectBoardArticleListCnt(boardVO);
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

	@Override
	public Map<String, Object> selectUnreadBoardArticles(BoardVO boardVO, String attrbFlag) throws Exception{
		List<BoardVO> list = bbsMngDAO.selectUnreadBoardArticleList(boardVO);
		List<BoardVO> result = new ArrayList<BoardVO>();
	
	    result = list;
	
		int cnt = bbsMngDAO.selectUnreadBoardArticleListCnt(boardVO);
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
	}

    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @see egovframework.com.cop.bbs.BBSManageService.service.EgovBBSManageService#updateBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
     */
    public void updateBoardArticle(Board board) throws Exception {
    	bbsMngDAO.updateBoardArticle(board);
    	
    	// [20140917,김동우] 공지사항을 수정할 경우, 모두 읽지 않음으로 변경(읽은이 모두 삭제) 
    	if (board.getBbsId().equals("BBSMSTR_000000000031")) {
    		BoardVO boardVO = new BoardVO();
    		boardVO.setBbsId(board.getBbsId());
    		boardVO.setNttId(board.getNttId());
    		bbsMngDAO.deleteReadHistory(boardVO);
    	}
    }


	@Override
	public Map<String, Object> selectAllBoardArticles(MemberVO user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<BoardVO> freeList = bbsMngDAO.getNewFreeList(user);
		List<BoardVO> discussList = bbsMngDAO.getNewDiscussList(user);
		List<MailVO> mailList = mailDAO.getNewMailList(user);
		
		map.put("freeList", freeList);
		map.put("discussList", discussList);
		map.put("mailList", mailList);
		
		return map;
	}

	@Override
	public void setDiscussState(BoardVO boardVO) throws Exception {
		bbsMngDAO.setDiscussState(boardVO);
		if (boardVO.getExChk().equals("Y")) {
			bbsMngDAO.deleteReadHistory(boardVO);
		}
	}

	@Override
	public EgovMap selectSuggestSummary(BoardVO boardVO) throws Exception {
		List<EgovMap> list = bbsMngDAO.selectSuggestSummary(boardVO);
		EgovMap result = new EgovMap();
		
		Integer sum = 0;
		
		for (int i=0; i<list.size(); i++) {
			EgovMap tmp = list.get(i);
			result.put(tmp.get("exChk"), tmp.get("exChkCnt"));
			
			sum += Integer.parseInt(String.valueOf(tmp.get("exChkCnt")));
		}
		result.put("sum", sum);
		
		return result;
	}

	@Override
	public List<SuggestVO> selectSuggestHistory(SuggestVO suggestVO)
			throws Exception {
		return bbsMngDAO.selectSuggestHistory(suggestVO);
	}

	@Override
	public void insertSuggestHistory(Suggest suggest) throws Exception {
		bbsMngDAO.insertSuggestHistory(suggest);
		
		BoardVO boardVO = new BoardVO();
		boardVO.setBbsId(suggest.getBbsId());
		boardVO.setNttId(suggest.getNttId());
		boardVO.setExChk(suggest.getSgstSt());
		
		bbsMngDAO.setDiscussState(boardVO);
	}

	@Override
	public void updateBbsId(Map<String, Object> commandMap) throws Exception {
		bbsMngDAO.updateBbsId(commandMap);
	}
	
	@Override
	public void updateBbsIdComment(Map<String, Object> commandMap) throws Exception {
		bbsMngDAO.updateBbsIdComment(commandMap);
	}
	
	@Override
	public Map<String, Object> selectPrjBoardMain(BoardVO boardVO) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<EgovMap> allPrjList = bbsMngDAO.selectPrjBoardMain(boardVO);
		List<EgovMap> myPrjList = new ArrayList<EgovMap>();
		
		for (int i=0; i<allPrjList.size(); i++) {
			EgovMap e = allPrjList.get(i);
			if ("Y".equals(e.get("isMyPrj"))) {
				myPrjList.add(e);
			}
		}
		
		result.put("allPrjList", allPrjList);
		result.put("myPrjList", myPrjList);
		
		return result;
	}

	@Override
	public Map<String, Object> selectOrgBoardMain(BoardVO boardVO) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<EgovMap> allOrgList = bbsMngDAO.selectOrgBoardMain(boardVO);
		List<EgovMap> myOrgList = new ArrayList<EgovMap>();
		
		for (int i=0; i<allOrgList.size(); i++) {
			EgovMap e = allOrgList.get(i);
			if ("Y".equals(e.get("isMyOrg"))) {
				myOrgList.add(e);
			}
		}
		
		result.put("allOrgList", allOrgList);
		result.put("myOrgList", myOrgList);
		
		return result;
	}

	@Override
	public void deleteReadHistory(BoardVO boardVO) throws Exception{
		bbsMngDAO.deleteReadHistory(boardVO);		
	}

	@Override
	public Map<String, Object> selectBoardListHeadSearch(BoardVO boardVO) throws Exception {
		
		List<EgovMap> resultList = bbsMngDAO.selectBoardListHeadSearch(boardVO);
	
		int cnt = bbsMngDAO.selectBoardListHeadSearchTotCnt(boardVO);
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", resultList);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
	}
}
