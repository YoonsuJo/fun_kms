package kms.com.community.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileVO;
import kms.com.community.service.BBSCommentService;
import kms.com.community.service.BoardMaster;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BoardVO;
import kms.com.community.service.Comment;
import kms.com.community.service.CommentVO;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 댓글관리를 위한 서비스 구현 클래스
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.06.29
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.06.29  한성곤          최초 생성
 *
 * </pre>
 */
@Service("KmsBBSCommentService")
public class BBSCommentServiceImpl extends AbstractServiceImpl implements BBSCommentService {

    @Resource(name = "KmsBBSAddedOptionsDAO")
    private BBSAddedOptionsDAO addedOptionsDAO;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileService;
    
    @Resource(name = "KmsBBSCommentDAO")
    private BBSCommentDAO bbsCommentDAO;
    
    @Resource(name = "KmsBBSAttributeManageDAO")
    private BBSAttributeManageDAO attrbMngDAO;

    @Resource(name = "KmsBBSManageDAO")
    private BBSManageDAO bbsMngDAO;

    /**
     * 댓글 사용 가능 여부를 확인한다.
     */
    public boolean canUseComment(String bbsId) throws Exception {
	String flag = EgovProperties.getProperty("Globals.addedOptions");
	if (flag != null && flag.trim().equalsIgnoreCase("true")) {
	    BoardMaster vo = new BoardMaster();
	    
	    vo.setBbsId(bbsId);
	    
	    BoardMasterVO options = addedOptionsDAO.selectAddedOptionsInf(vo);
	    
	    if (options == null) {
		return false;
	    }
	    
	    if (options.getCommentAt().equals("Y")) {
		return true;
	    }
	}
	
	return false;
    }

    /**
     * 댓글에 대한 목록을 조회 한다.
     */
    public Map<String, Object> selectCommentList(CommentVO commentVO) throws Exception {
		List<CommentVO> result = bbsCommentDAO.selectCommentList(commentVO);
		int cnt = bbsCommentDAO.selectCommentListCnt(commentVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }
    
    /**
     * 댓글을 등록한다.
     */
    public void insertComment(Comment comment) throws Exception {
    	bbsCommentDAO.insertComment(comment);
    	
    	BoardMasterVO tmp = new BoardMasterVO();
    	tmp.setBbsId(comment.getBbsId());
    	
    	BoardMasterVO bbsMstr = attrbMngDAO.selectBBSMasterInf(tmp);
    	
    	if (bbsMstr.getBbsAttrbCode().equals("DISCUS")) {
    		BoardVO tmp2 = new BoardVO();
    		tmp2.setNttId(comment.getNttId());
    		bbsMngDAO.deleteReadHistory(tmp2);
    	}
    }
    
    /**
     * 댓글을 삭제한다.
     */
    public void deleteComment(CommentVO commentVO) throws Exception {
    	FileVO fvo = new FileVO();
		
		fvo.setAtchFileId(commentVO.getAtchFileId());
		
    	bbsCommentDAO.deleteComment(commentVO);
    	
    	if (!"".equals(fvo.getAtchFileId()) || fvo.getAtchFileId() != null) {
		    fileService.deleteAllFileInf(fvo);
		}
    }
    
    /**
     * 댓글에 대한 내용을 조회한다.
     */
    public Comment selectComment(CommentVO commentVO) throws Exception {
    	return bbsCommentDAO.selectComment(commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 수정한다.
     */
    public void updateComment(Comment comment) throws Exception {
    	bbsCommentDAO.updateComment(comment);
    }
    
    /**
     * 댓글 패스워드를 가져온다.
     */
    public String getCommentPassword(Comment comment) throws Exception {
    	return bbsCommentDAO.getCommentPassword(comment);
    }
}
