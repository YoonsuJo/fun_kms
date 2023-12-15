package kms.com.menu.dao;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.menu.vo.MenuVO;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("KmsMenuDAO")
public class MenuDAO extends EgovAbstractDAO {
	Logger logT = Logger.getLogger("TENY");

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// TENY_170525 팀 메뉴 관련 기능
	// TENY_170525 팀 메뉴 목록보기 기능
	
	public void insertMenu(MenuVO mVO) throws Exception {
		logT.debug("START");
		insert("KmsMenuDAO.insertMenu", mVO);
	}

	public MenuVO getMenu(int no) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		return (MenuVO)selectByPk("KmsMenuDAO.getMenu", map);
	}
	
	public void updateMenu(Map<String, Object> map) throws Exception {
		logT.debug("START");
		update("KmsMenuDAO.updateMenu", map);
	}
	
	public void deleteMenu(int no) throws Exception {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		delete("KmsMenuDAO.deleteMenu", map);
	}

	public List<MenuVO> selectMenuList(MenuVO mVO) throws Exception {
		logT.debug("START");
		return list("KmsMenuDAO.selectMenuList", mVO);
	}
}
