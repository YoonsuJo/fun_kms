package kms.com.menu.service;

import kms.com.menu.dao.MenuDAO;
import kms.com.menu.vo.MenuVO;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;


@Service("KmsMenuService")
public class MenuService {
	Logger logT = Logger.getLogger("TENY");
	
	@Resource(name="KmsMenuDAO")
	private MenuDAO menuDAO;

	// TENY_170409 
	public List <MenuVO> selectMenuList()  throws Exception {
		
		List <MenuVO> rVOList = new ArrayList();
		return rVOList;
	}
	

}