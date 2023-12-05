package kms.com.request.service;

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
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.request.fm.*;
import kms.com.request.vo.*;
import kms.com.request.dao.RequestDAO;


@Service("KmsRequestService")
public class RequestService {
	Logger logT = Logger.getLogger("TENY");
	
	@Resource(name="KmsRequestDAO")
	private RequestDAO requestDAO;

	// TENY_170409 
	public List <RequestVO> selectRequestList()  throws Exception {
		
		List <RequestVO> rVOList = new ArrayList();
		return rVOList;
	}

	

}