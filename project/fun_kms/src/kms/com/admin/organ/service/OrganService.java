package kms.com.admin.organ.service;

import java.util.List;

/**
 * @Class Name : OrganService.java
 * @Description : Organ Business class
 * @Modification Information 
 * 
 * 조직관리에 관한 서비스 인터페이스 클래스를 정의한다
 * @author 민형식
 * @since 20110907
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface OrganService {
	    
	/**
	 * 조직코드를 삭제한다.
	 * @param organ
	 * @throws Exception
	 */
	void deleteOrgan(Organ organ) throws Exception;

	/**
	 * 조직코드를 등록한다.
	 * @param organ
	 * @throws Exception
	 */
	void insertOrgan(Organ organ) throws Exception;
	
	/**
	 * 조직코드 이력을 등록한다.
	 * @param organ
	 * @throws Exception
	 */
	void insertOrganHis(Organ organ) throws Exception;	

	/**
	 * 조직코드 상세항목을 조회한다.
	 * @param organ
	 * @return Organ(조직코드)
	 * @throws Exception
	 */
	 Organ selectOrganDetail(Organ organ) throws Exception;
	
	/**
	 * 조직코드 목록을 조회한다.
	 * @param searchVO
	 * @return List(조직코드 목록)
	 * @throws Exception
	 */
	List selectOrganList(OrganVO organ) throws Exception;
	
	/**
	 * 조직코드 트리목록을 조회한다.
	 * @param searchVO
	 * @return List(조직코드 목록)
	 * @throws Exception
	 */
	List selectOrganTreeList(OrganVO organ) throws Exception;	
	
	/**
	 * 조직코드 이력 목록을 조회한다.
	 * @param searchVO
	 * @return List(조직코드 목록)
	 * @throws Exception
	 */
	List selectOrganListHis(Organ organ) throws Exception;	

    /**
	 * 조직코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(조직코드 총 갯수)
     */
    int selectOrganListTotCnt(OrganVO searchVO) throws Exception;
	
	/**
	 * 조직코드를 수정한다.
	 * @param organ
	 * @throws Exception
	 */
	void updateOrgan(Organ organ) throws Exception;

	void updateOrganTree(Organ organ);

}
