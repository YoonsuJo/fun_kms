package kms.com.menu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONValue;
import org.json.simple.JSONObject;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.menu.vo.*;
import kms.com.menu.dao.MenuDAO;


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