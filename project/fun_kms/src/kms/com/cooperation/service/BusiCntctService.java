package kms.com.cooperation.service;

import java.util.List;

public interface BusiCntctService {
	List<BusinessContactVO> selectBusinessContactList(BusinessContactVO businessContactVO) throws Exception;
	int selectBusinessContactListTotCnt(BusinessContactVO businessContactVO) throws Exception;
	
	BusinessContactVO selectBusinessContact(BusinessContactVO businessContactVO) throws Exception;
	List<BusinessContactRecieve> selectBusinessContactRecieve(BusinessContactVO businessContactVO) throws Exception;
	
	String insertBusinessContact(BusinessContact businessContact, BusinessContactRecieve businessContactRecieve) throws Exception;
	void updateBusinessContact(BusinessContact businessContact) throws Exception;
	void updateBusinessContact(BusinessContact businessContact, BusinessContactRecieve businessContactRecieve) throws Exception;

	
	void insertBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) throws Exception;
	void updateBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) throws Exception;
	void deleteBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) throws Exception;
	void changeBusinessContactRecieve(BusinessContactRecieve businessContactRecieve) throws Exception;

	//2013.08.13 업무연락 알람 ON/OFF
	void updateBusinessContactAlarm(BusinessContactRecieve businessContactRecieve) throws Exception;

	
	List<BusinessContactComment> selectBusinessContactCommentList(BusinessContactComment businessContactComment) throws Exception;
	int selectBusinessContactCommentListCnt(BusinessContactComment businessContactComment) throws Exception;
	BusinessContactComment selectBusinessContactComment(BusinessContactComment businessContactComment) throws Exception;
	void insertBusinessContactComment(BusinessContactComment businessContactComment) throws Exception;
	void updateBusinessContactComment(BusinessContactComment businessContactComment) throws Exception;
	void updateBusinessContactCommentWithoutDeleteReadTime(BusinessContactComment businessContactComment) throws Exception;
		
	List<BusinessContactVO> selectBusinessContactListHeadSearch(BusinessContactVO bcVO) throws Exception;
	int selectBusinessContactListTotCntHeadSearch(BusinessContactVO bcVO) throws Exception;
}
