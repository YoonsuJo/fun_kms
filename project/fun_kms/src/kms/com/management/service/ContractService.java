package kms.com.management.service;

import java.util.List;
import java.util.Map;

public interface ContractService {

	List selectContractList(Map<String, Object> param) throws Exception;
	int selectContractListCnt(Map<String, Object> param) throws Exception;
	
	Map<String, Object> selectContract(Map<String, Object> param) throws Exception;
	
	void insertContract(Map<String, Object> param) throws Exception;
	
	void updateContract(Map<String, Object> param) throws Exception;
	
	void deleteContract(Map<String, Object> param) throws Exception;
	
	List selectAuthList(Map<String, Object> param) throws Exception;
	
	void insertAuthList(Map<String, Object> param) throws Exception;
	
	void updateAuthList(Map<String, Object> param) throws Exception;
}
