package kms.com.support.service.impl;

import java.util.List;

import kms.com.support.service.BPManualVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsBPManualDAO")
public class BPManualDAO extends EgovAbstractDAO  {
	
	/**
	 * @param BPManualVO
	 * @return int
	 * @내용 : 업무절차 입력
	 */
	public int insertManual(BPManualVO bpmvo){
		int count = 0;
		count = (Integer) insert("BPManualDAO.insertManual", bpmvo);
		
		return count;
	}
	
	
	public List selectManualList(BPManualVO bpmvo){
		return list("BPManualDAO.selectManualList", bpmvo);
	}
	
	public int getCountManualList(BPManualVO bpmvo){
		return (Integer) selectByPk("BPManualDAO.getCountManualList", bpmvo);
	}
	
	public void insertReadContent(BPManualVO bpmvo){
		insert("BPManualDAO.insertReadContent", bpmvo);
	}
	
	public BPManualVO getDetailView(BPManualVO bpmvo){
		int count = 0;
		
		count = (Integer) selectByPk("BPManualDAO.checkReadThisData", bpmvo);	//읽엇던 글인지 체크
		if(count == 0){
			count = (Integer) insert("BPManualDAO.insertReadContent", bpmvo);
			update("BPManualDAO.updateReadcountContent", bpmvo);	//카운트 증가
		}
		
		return (BPManualVO) selectByPk("BPManualDAO.getDetailView", bpmvo);
	}
	
	//업무절차 삭제
	public void deleteManual(BPManualVO bpmvo){
		//update("BPManualDAO.deleteManual", bpmvo);
		delete("BPManualDAO.deleteManual", bpmvo);
		delete("BPManualDAO.deleteManualRead", bpmvo);
		delete("BPManualDAO.deleteManualsComment", bpmvo);
		delete("BPManualDAO.deleteManualsSuggest", bpmvo);
	}
	//업무절차 수정
	public void updateManual(BPManualVO bpmvo){
		update("BPManualDAO.updateManual", bpmvo);
		delete("BPManualDAO.deleteManualRead", bpmvo);
	}
	
	
	
	//댓글 제어 시작
	public List getDetailViewComment(BPManualVO bpmvo){
		return list("BPManualDAO.getDetailViewComment", bpmvo);
	}
	public void insertComment(BPManualVO bpmvo){
		insert("BPManualDAO.insertComment", bpmvo);
		delete("BPManualDAO.deleteManualRead", bpmvo);
	}
	public void modifyComment(BPManualVO bpmvo){
		update("BPManualDAO.modifyComment", bpmvo);
	}
	public void deleteComment(BPManualVO bpmvo){
		delete("BPManualDAO.deleteComment", bpmvo);
	}
	public BPManualVO getModifyComment(BPManualVO bpmvo){
		return (BPManualVO) selectByPk("BPManualDAO.getmodifyComment", bpmvo);
	}
	//댓글 제어 끝
	
	
	
	//건의사항 제어 시작
	public List getDetailViewSuggest(BPManualVO bpmvo){
		return list("BPManualDAO.selectSuggestList", bpmvo);
	}
	public void insertSuggestAsk(BPManualVO bpmvo){
		insert("BPManualDAO.insertSuggestAsk", bpmvo);
		if(bpmvo.getSuggestStatus().equals("Y")){
			update("BPManualDAO.updateSuggestAsk", bpmvo);
		}
	}
	public void SuggestComplete(BPManualVO bpmvo){
		update("BPManualDAO.updateSuggestComplete", bpmvo);
	}
	public void SuggestDelete(BPManualVO bpmvo){
		int count = 0;
		delete("BPManualDAO.deleteSuggest", bpmvo);
		
		//건의중인데 누군가 마지막 건의가 사용자에 의해 삭제가 되면 DB값을 바꿔준다.(건의중인게 아니므로)
		count = (Integer) selectByPk("BPManualDAO.countSuggest", bpmvo);
		if(count == 0){
			update("BPManualDAO.updateSuggestComplete", bpmvo);
		}
	}
	public BPManualVO getModifySuggest(BPManualVO bpmvo){
		return (BPManualVO) selectByPk("BPManualDAO.getModifySuggest", bpmvo);
	}
	public void updateSuggest(BPManualVO bpmvo){
		update("BPManualDAO.updateSuggest", bpmvo);
	}
	//건의사항 제어 끝
	
	
	
	//업무구분 시작
	public List selectBPManualGubunList(){
		return list("BPManualDAO.selectBPManualGubunList", "");
	}
	public int countBPManualGubunList(BPManualVO bpmvo){
		return (Integer) selectByPk("BPManualDAO.countBPManualGubunList", bpmvo);
	}
	public String insertBPManualGubun(BPManualVO bpmvo){
		String result = "Y";
		int count = 0;
		count = (Integer) selectByPk("BPManualDAO.checkBPManualGubunListBeforeInsert", bpmvo);
		if(count > 0){
			result = "N";
		}else{
			insert("BPManualDAO.insertBPManualGubun", bpmvo);
		}
		return result;
	}
	public String updateBPManualGubun(BPManualVO bpmvo){
		String result = "Y";
		int count = 0;
		count = (Integer) selectByPk("BPManualDAO.checkBPManualGubunListBeforeInsert", bpmvo);
		if(count > 0){
			result = "N";
		}else{
			update("BPManualDAO.updateBPManualGubun", bpmvo);
		}
		return result;
	}
	public String deleteBPManualGubun(BPManualVO bpmvo){
		String result = "Y";
		int count = 0;
		count = (Integer) selectByPk("BPManualDAO.checkBPManualGubunUsed", bpmvo);
		if(count > 0){
			result = "U";
		}else{
			delete("BPManualDAO.deleteBPManualGubun", bpmvo);
		}
		return result;
	}
	//업무구분 끝
	
	
	public void ManualShowOrHidden(BPManualVO bpmvo){
		update("BPManualDAO.updateShowOrHiddenContent", bpmvo);
	}
}