package kms.com.supervisor.service;

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
import kms.com.daily.fm.*;
import kms.com.daily.vo.*;
import kms.com.fund.dao.InvoiceDAO;
import kms.com.daily.dao.DailyDAO;


@Service("KmsStatService")
public class StatService {
	Logger logT = Logger.getLogger("TENY");
	
	@Resource(name="KmsDailyDAO")
	private DailyDAO dailyDAO;

	// TENY_170409 
	
}
