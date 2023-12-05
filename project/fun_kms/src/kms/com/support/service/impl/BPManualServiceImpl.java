package kms.com.support.service.impl;

import java.util.List;

import javax.annotation.Resource;

import kms.com.support.service.BPManualService;
import kms.com.support.service.BPManualVO;

import org.springframework.stereotype.Service;

@Service("KmsBPManualService")
public class BPManualServiceImpl implements BPManualService {
	@Resource(name="KmsBPManualDAO")
	private BPManualDAO bpManualDAO;
	
	@Override
	public int insertManual(BPManualVO bpmvo){
		return bpManualDAO.insertManual(bpmvo);
	}
	
	@Override
	public List selectManualList(BPManualVO bpmvo){
		return bpManualDAO.selectManualList(bpmvo);
	}
	
	@Override
	public int getCountManualList(BPManualVO bpmvo){
		return bpManualDAO.getCountManualList(bpmvo);
	}
	
	@Override
	public BPManualVO getDetailView(BPManualVO bpmvo){
		return bpManualDAO.getDetailView(bpmvo);
	}
	
	@Override
	public void deleteManual(BPManualVO bpmvo){
		bpManualDAO.deleteManual(bpmvo);
	}
	
	@Override
	public void updateManual(BPManualVO bpmvo){
		bpManualDAO.updateManual(bpmvo);
	}
	
	//코멘트 목록
	@Override
	public List getDetailViewComment(BPManualVO bpmvo){
		return bpManualDAO.getDetailViewComment(bpmvo);
	}
	//코멘트 입력
	@Override
	public void insertComment(BPManualVO bpmvo){
		bpManualDAO.insertComment(bpmvo);
	}
	//코멘트 삭제
	@Override
	public void deleteComment(BPManualVO bpmvo){
		bpManualDAO.deleteComment(bpmvo);
	}
	//코멘트 수정
	@Override
	public void modifyComment(BPManualVO bpmvo){
		bpManualDAO.modifyComment(bpmvo);
	}
	//코멘트 내용 가져오기
	@Override
	public BPManualVO getModifyComment(BPManualVO bpmvo){
		return bpManualDAO.getModifyComment(bpmvo);
	}
	
	//건의사항 목록
	@Override
	public List getDetailViewSuggest(BPManualVO bpmvo){
		return bpManualDAO.getDetailViewSuggest(bpmvo);
	}
	//건의사항 입력
	@Override
	public void insertSuggestAsk(BPManualVO bpmvo){
		bpManualDAO.insertSuggestAsk(bpmvo);
	}
	//건의 처리완료
	@Override
	public void SuggestComplete(BPManualVO bpmvo){
		bpManualDAO.SuggestComplete(bpmvo);
	}
	//건의 삭제
	@Override
	public void SuggestDelete(BPManualVO bpmvo){
		bpManualDAO.SuggestDelete(bpmvo);
	}
	//건의 수정 데이터
	@Override
	public BPManualVO getModifySuggest(BPManualVO bpmvo){
		return bpManualDAO.getModifySuggest(bpmvo);
	}
	//건의사항 수정
	@Override
	public void updateSuggest(BPManualVO bpmvo){
		bpManualDAO.updateSuggest(bpmvo);
	}
	
	//업무구분 리스트
	@Override
	public List selectBPManualGubunList(){
		return bpManualDAO.selectBPManualGubunList();
	}
	//업무구분 갯수
	@Override
	public int countBPManualGubunList(BPManualVO bpmvo){
		return bpManualDAO.countBPManualGubunList(bpmvo);
	}
	//업무구분 입력
	@Override
	public String insertBPManualGubun(BPManualVO bpmvo){
		return bpManualDAO.insertBPManualGubun(bpmvo);
	}
	//업무구분 수정
	@Override
	public String updateBPManualGubun(BPManualVO bpmvo){
		return bpManualDAO.updateBPManualGubun(bpmvo);
	}
	//업무구분 삭제
	@Override
	public String deleteBPManualGubun(BPManualVO bpmvo){
		return bpManualDAO.deleteBPManualGubun(bpmvo);
	}
	
	//글 보이기 또는 숨기기
	@Override
	public void ManualShowOrHidden(BPManualVO bpmvo){
		bpManualDAO.ManualShowOrHidden(bpmvo);
	}
}