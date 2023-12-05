package kms.com.common.timer;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;

import javax.annotation.Resource;

import kms.com.common.push.PushSender;
import kms.com.community.service.NoteService;
import kms.com.member.service.MemberService;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Component;

import egovframework.rte.fdl.property.EgovPropertyService;

@Component("messageTimer")
public class MessageTimerScheduler extends TimerTask {
	
	@Resource(name = "KmsNoteService")
    private NoteService noteService;
	
	@Resource(name = "KmsMemberService")
    private MemberService memberService;
	
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
	@Override
	public void run() {
		try {
			List list = noteService.selectFailPushLogList();
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> param = (Map<String, Object>) list.get(i);
				
				JSONObject json = new JSONObject();
				//json.put("replyUrl", "http://hm.hanmam.kr/mobile/pushMsgSendView.do?sabun=" + param.get("userNo"));
		   	  	//json.put("viewUrl", "");
				json.put("sender", param.get("userNm"));
				//json.put("sendTime", (Hour < 10 ? "0" + Hour : Hour) + ":" + (minute < 10 ? "0" + minute : minute)+ ":" +(second < 10 ? "0" + second : second));
				json.put("sendTime", System.currentTimeMillis());
				//String message = param.get("message").toString();
				//json.put("message", message);
				String fromUserId = param.get("fromUserId").toString();
				json.put("fromUserId", fromUserId);
				String toUserId = param.get("toUserId").toString();
				json.put("toUserId", toUserId);
				json.put("noteNo", param.get("noteNo"));
				json.put("messageNo", param.get("messageNo"));
		   	  	json.put("type", "");
				json.toJSONString();
					       	  	
				String userAgent = noteService.deviceType(toUserId);
				String tokenInfo = noteService.tokenInfo(toUserId);
				String toUserNm = noteService.userNm(toUserId);
				
				String info = URLEncoder.encode(json.toJSONString(), "UTF-8");
				String msg = URLEncoder.encode(param.get("message").toString(), "UTF-8");
				
				PushSender pushSender = new PushSender();				
				
				String pushURI = propertiesService.getString("pushURI");
				String pushAPI = propertiesService.getString("pushAPI");				
							
				String pushAuth_Android	= propertiesService.getString("pushAuth_Android");				
				String pushAuth_iOS = propertiesService.getString("pushAuth_iOS");
				
				if(userAgent.indexOf("iPhone") > -1 || userAgent.indexOf("iPod") > -1 || userAgent.indexOf("iPad") > -1){
					//Push.alert(message, "E:\\Websource\\KMS\\mkms_apns.p12", "saeha1111", true, tokenInfo);
					//IOS 푸시
					//String result = pushSender.sendMessage(info, msg, tokenInfo, false,pushAuth_iOS,"iOS",pushURI,pushAPI,toUserNm,(String) json.get("type"));
				} else {
				
					//String result = pushSender.sendMessage(info,msg, tokenInfo, false,pushAuth_Android,"Android",pushURI,pushAPI,toUserNm,(String) json.get("type"));
	
				//	AndroidProvider provider = new AndroidProvider();
				//	provider.sendMessage(tokenInfo, json.toJSONString());
				
				}
				
				noteService.updateTmPushLog(param);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	/* parameter field */
		
	/* method field */
}
