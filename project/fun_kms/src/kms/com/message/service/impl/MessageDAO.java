package kms.com.message.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.message.service.MessageVO;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsMessageDAO")
public class MessageDAO extends EgovAbstractDAO{
	Logger logT = Logger.getLogger("TENY");

////////////////    SELECT    ////////////////////
	/* TENY_170206  계산서 목록을 조회하는 DAO메소드 */
	public List<MessageVO> selectMessageList(MessageVO messageVO) throws Exception {
		logT.debug("START");
		return (List<MessageVO>) list("KmsMessageDAO.selectMessageList", messageVO);
	}

}
