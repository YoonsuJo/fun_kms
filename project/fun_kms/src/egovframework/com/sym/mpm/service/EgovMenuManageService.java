package  egovframework.com.sym.mpm.service;

import java.util.List;
import java.util.Map;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;
import egovframework.com.cmm.ComDefaultVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/** 
 * 메뉴관리에 관한 서비스 인터페이스 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *
 * </pre>
 */

public interface EgovMenuManageService {

	/**
	 * 메뉴 상세정보를 조회
	 * @param vo ComDefaultVO
	 * @return MenuManageVO
	 * @exception Exception
	 */
	MenuManageVO selectMenuManage(ComDefaultVO vo) throws Exception;

	/**
	 * 메뉴 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	List selectMenuManageList(ComDefaultVO vo) throws Exception;

	/**
	 * 메뉴목록 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
	int selectMenuManageListTotCnt(ComDefaultVO vo) throws Exception;

	/**
	 * 메뉴번호 존재 여부를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
	int selectMenuNoByPk(MenuManageVO vo) throws Exception;
	
	/**
	 * 메뉴 정보를 등록
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	void insertMenuManage(MenuManageVO vo) throws Exception;

	/**
	 * 메뉴 정보를 수정
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	void updateMenuManage(MenuManageVO vo) throws Exception;

	/**
	 * 메뉴 정보를 삭제
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	void deleteMenuManage(MenuManageVO vo) throws Exception;

	/**
	 * 화면에 조회된 메뉴 목록 정보를 데이터베이스에서 삭제
	 * @param checkedMenuNoForDel String
	 * @exception Exception
	 */
	void deleteMenuManageList(String checkedMenuNoForDel) throws Exception;


	/*  메뉴 생성 관리  */
	
	/**
	 * 메뉴 목록을 조회
	 * @return List
	 * @exception Exception
	 */
	List selectMenuList() throws Exception;

	/**
	 * 메뉴생성 내역을 조회
	 * @param  vo MenuCreatVO
	 * @return List
	 * @exception Exception
	 */
	List selectMenuCreatList(MenuCreatVO vo) throws Exception;
	
	/**
	 * 화면에 조회된 메뉴정보로 메뉴생성내역 데이터베이스에서 입력
	 * @param checkedScrtyForInsert String
	 * @param checkedMenuNoForInsert String
	 * @exception Exception
	 */
	void insertMenuCreatList(String checkedScrtyForInsert, String checkedMenuNoForInsert) throws Exception;

	/**
	 * 메뉴생성관리 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	List selectMenuCreatManagList(ComDefaultVO vo) throws Exception;

	/**
	 * ID에 대한 권한코드를 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	MenuCreatVO selectAuthorByUsr(ComDefaultVO vo) throws Exception;	

	/**
	 * ID 존재여부를 조회
	 * @param vo ComDefaultVO
	 * @return int 
	 * @exception Exception
	 */
	int selectUsrByPk(ComDefaultVO vo) throws Exception;

	/**
	 * 메뉴생성관리 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int 
	 * @exception Exception
	 */
	int selectMenuCreatManagTotCnt(ComDefaultVO vo) throws Exception;

	/**
	 * 메뉴생성 사이트맵 내용 조회
	 * @param vo MenuSiteMapVO
	 * @return List
	 * @exception Exception
	 */
	List selectMenuCreatSiteMapList(MenuSiteMapVO vo) throws Exception;

	/**
	 * 사용자 권한별 사이트맵 내용 조회
	 * @param vo MenuSiteMapVO
	 * @return List
	 * @exception Exception
	 */
	 List selectSiteMapByUser(MenuSiteMapVO vo) throws Exception;
	
	/**
	 * 사이트맵 등록
	 * @param vo MenuSiteMapVO
	 * @param vHtmlValue String
	 * @return boolean
	 * @exception Exception
	 */
	boolean creatSiteMap(MenuSiteMapVO vo, String vHtmlValue) throws Exception;

	/*### 메뉴관련 프로세스 ###*/
	/**
	 * MainMenu Head Menu 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	List selectMainMenuHead(MenuManageVO vo) throws Exception;

	/**
	 * MainMenu Head Left 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	List selectMainMenuLeft(MenuManageVO vo) throws Exception;

	/**
	 * MainMenu Head MenuURL 조회
	 * @param iMenuNo int
	 * @param sUniqId String
	 * @return String
	 * @exception Exception
	 */
	String selectLastMenuURL(int iMenuNo, String sUniqId) throws Exception;
	
	/* 일괄처리 프로세스   */

	/**
	 * 메뉴일괄초기화 프로세스 메뉴목록테이블, 프로그램 목록테이블 전체 삭제
	 * @return boolean
	 */
	boolean menuBndeAllDelete() throws Exception;
	
	/**
	 * 메뉴일괄등록 프로세스
	 * @param  vo MenuManageVO  
	 * @param  inputStream InputStream 
	 * @exception Exception
	 */
	String menuBndeRegist(MenuManageVO vo, InputStream inputStream) throws Exception;


}