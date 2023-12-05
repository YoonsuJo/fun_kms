package kms.com.support.service;

import java.util.List;

public interface BPManualService {
	int insertManual(BPManualVO bpmvo);
	
	List selectManualList(BPManualVO bpmvo);
	
	int getCountManualList(BPManualVO bpmvo);
	
	void deleteManual(BPManualVO bpmvo);
	
	void updateManual(BPManualVO bpmvo);
	
	BPManualVO getDetailView(BPManualVO bpmvo);
	
	void insertComment(BPManualVO bpmvo);
	
	void deleteComment(BPManualVO bpmvo);
	
	void modifyComment(BPManualVO bpmvo);
	
	List getDetailViewComment(BPManualVO bpmvo);
	
	List getDetailViewSuggest(BPManualVO bpmvo);
	
	BPManualVO getModifyComment(BPManualVO bpmvo);
	
	void insertSuggestAsk(BPManualVO bpmvo);
	
	void SuggestComplete(BPManualVO bpmvo);
	
	void SuggestDelete(BPManualVO bpmvo);
	
	BPManualVO getModifySuggest(BPManualVO bpmvo);
	
	void updateSuggest(BPManualVO bpmvo);
	
	List selectBPManualGubunList();
	
	String insertBPManualGubun(BPManualVO bpmvo);
	
	String updateBPManualGubun(BPManualVO bpmvo);
	
	String deleteBPManualGubun(BPManualVO bpmvo);
	
	int countBPManualGubunList(BPManualVO bpmvo);
	
	void ManualShowOrHidden(BPManualVO bpmvo);
}