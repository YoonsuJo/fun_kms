package kms.com.message.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.app.service.ApprovalVO;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.message.service.MessageService;
import kms.com.message.service.MessageVO;
import kms.com.message.service.impl.MessageDAO;

@Service("KmsMessageService")
public class MessageServiceImpl implements MessageService {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name="KmsMessageDAO")
	private MessageDAO messageDAO;

////////////////    SELECT    ////////////////////
	/* TENY_170206  계산서 목록을 조회하는 service 메소드 */
	@Override
	public List<MessageVO> selectMessageList(MessageVO messageVO) throws Exception {
		logT.debug("START");
		return messageDAO.selectMessageList(messageVO);
	}
}
