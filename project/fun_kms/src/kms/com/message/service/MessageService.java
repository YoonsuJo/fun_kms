package kms.com.message.service;

import java.util.List;
import java.util.Map;

public interface MessageService {

	List<MessageVO> selectMessageList(MessageVO messageVO) throws Exception;
}
