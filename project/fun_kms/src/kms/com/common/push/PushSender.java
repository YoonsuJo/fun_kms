package kms.com.common.push;

import egovframework.rte.fdl.property.EgovPropertyService;
import kms.com.community.service.NoteService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component("pushSender")
public class PushSender {
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	private EgovPropertyService propertiesService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	@Resource(name="KmsMemberService")
    private MemberService memberService;
	
	/**
	 * Demo 단말기 테스트 메세지 SA 전송
	 * 
	 * @param auth_uri               (Required) 알림톡 메시지 수신 OpenAPI (http://180.182.51.98:17000/req_normal_msg_sending)
	 * @param registration_id        (Required) 대상 어플리케이션의 식별코드 / 최대 200자
	 * @param collapse_key           (Optional) 단말이 오프라인 상태에서 온라인 상태로 전환시 과도한 메시지 전송 방지를 위한 임의의 문자열
	 * @param data_url               (Required) 고객사 URL
	 * @param data_badge             (Required) 단말에서 읽지 않은 메시지 수 / 테스트 수행시 1값으로 설정
	 * @param data_alert             (Required) 메세지 데이타 (메시지 제목|*|메시지 내용) / data_url + data_badge + data_alert 최대 1024
	 * @param delay_while_idle       (Optional) 미지원
	 * @param auth                   (Required) APP 인증키
	 * @param report_url             (Optional) 메시지 전송에 대한 APP 수신여부를 응답박기 위한 URL / 최대50자
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String sendMessageOld(String info, String msg, String regi_id, boolean isParent, String auth_token, String device_type, String  pushURI, String  pushAPI, String toUserNm, String type) throws UnsupportedEncodingException{
		
		String param = "";
		String result = "";
		String targetURL = pushURI + "/" +pushAPI;
		
		List<String> regi_id_list = new ArrayList<String>();
		
		regi_id_list.add(regi_id);
		
		JSONObject json = new JSONObject();
		toUserNm = URLEncoder.encode(toUserNm, "UTF-8");
		//json.put("s_phone", toUserNm);
		json.put("s_phone", "00000000");
		//json.put("registration_ids", regi_id_list);
		json.put("r_phone", regi_id_list);
		json.put("user_id", "hanmam");
		json.put("message_type", 1);
		
		
		if("note".equals(type)){
			type = "[쪽지]";
		}else if("work".equals(type)){
			type = "[업무연락]";
		}else if("conf".equals(type)){
			type = "[회의알림]";
		}else if("mail".equals(type)){
			type = "[사내메일]";
		}else{
			type = "";
		}
				
		//type = URLEncoder.encode(type, "UTF-8");
		json.put("title", type);
		
		
		
		Map<String, Object> msgMap = new HashMap<String, Object>();
		msgMap.put("alert", msg);
		msgMap.put("info", info);
		json.put("data", msgMap);
		
		String jsonData = json.toJSONString();

		result = sendMsgCts(targetURL, auth_token, jsonData);
		
		return result;
	}

	public String sendMessageByPhoneNo(String info, String msg, String toPhoneNum, boolean isParent, String auth_token, String device_type, String  pushURI, String  pushAPI, String toUserNm, String type, String title, MemberVO senderVO) {
		
		String param = "";
		String result = "";
		String targetURL = pushURI + "/" +pushAPI;
		
		List<String> phone_no_list = new ArrayList<String>();
		
		phone_no_list.add(toPhoneNum);
		
		JSONObject json = new JSONObject();
		//toUserNm = URLEncoder.encode(toUserNm, "UTF-8");
		
		//json.put("s_phone", toUserNm);
		json.put("s_phone", senderVO.getMoblphonNo().replace("-", ""));
		//json.put("registration_ids", regi_id_list);
		json.put("r_phone", phone_no_list);
		json.put("user_id", "hanmam");
		json.put("message_type", 1);
		
		json.put("use_sms", 1);			// 추가 : 수신앱 미설치 시 SMS 발송
		json.put("lifespan", 600);		// 추가 : 서버에서 메시지를 보관하는 기간 (초 단위), 시간은 적절히 조정
		json.put("retry_by_sms", 1);		// 추가 : lifespan 만료 시 SMS 발송
		json.put("extra_lifespan_for_public_noti", 3600);		// 추가 : iOS 단말에는 "기존 600초 + 지정한 시간" 이후에 SMS를 보내도록 하는 기능입니다.
		
		/*
		 *  sms_msg 절삭(sms_msg의 최대 길이는 1024byte이며, 길이 초과 시 메시지 접수가 되지 않습니다.)
		 *  ※ 한글 포함 시 utf8 기준으로 길이 계산 (1글자당 3byte)
		 */
		String sms_msg = msg;
		int smsMsgMaxLength = 256;		// 256자로 계산
		if (sms_msg.length() > smsMsgMaxLength) sms_msg = sms_msg.substring(0, smsMsgMaxLength);
		
		json.put("sms_msg", sms_msg);	// sms 발송시 보낼 메세지.
		
		
		if("note".equals(type)){
			type = "[쪽지] ";
		}else if("work".equals(type)){
			type = "[업무연락] " + title;
		}else if("conf".equals(type)){
			type = "[회의알림] " + title;
		}else if("mail".equals(type)){
			type = "[사내메일] " + title;
		}else if("consult".equals(type)){
			type = "[상담관리] ";
		}else if("dayReport".equals(type)){
			type = "[업무일지 스케쥴러] ";
		}else if("late".equals(type)){
			type = "[일일근태 스케쥴러] ";
		}else if("product".equals(type)){
			type = "[상품관리] " + title;
		}else{
			type = "";
		}
		
		//type = URLEncoder.encode(type, "UTF-8");
		json.put("title", type);
		
		
		
		Map<String, Object> msgMap = new HashMap<String, Object>();
		msgMap.put("alert", msg);
		msgMap.put("info", info);
		//msgMap.put("phonenum", fromPhoneNum);
		msgMap.put("name", senderVO.getUserNm());
		msgMap.put("position", senderVO.getRankNm());
		msgMap.put("department", senderVO.getOrgnztNm());
		json.put("data", msgMap);
		
		String jsonData = json.toJSONString();

		result = sendMsgCts(targetURL, auth_token, jsonData);
		
		return result;
	}
	
	
	public String sendMessage(String type, PushVO pushVO) throws Exception {
		
		String result = "";
		
		String pushURI = propertiesService.getString("pushURI");
		String pushAPI = propertiesService.getString("pushAPI");
		String pushAuth	= propertiesService.getString("pushAuth");
		String targetURL = pushURI + "/" +pushAPI;
		
		JSONObject json = new JSONObject();
		json.put("s_phone", pushVO.getSenderVO().getMoblphonNo().replace("-", ""));
		json.put("r_phone", getrPhoneListExceptResigner(pushVO.getrPhoneList()));	// 재직자에게만 전송
		json.put("user_id", "hanmam");
		json.put("message_type", 1);
		
		json.put("use_sms", 1);			// 추가 : 수신앱 미설치 시 SMS 발송
		json.put("lifespan", 600);		// 추가 : 서버에서 메시지를 보관하는 기간 (초 단위), 시간은 적절히 조정
		json.put("retry_by_sms", 1);		// 추가 : lifespan 만료 시 SMS 발송
		json.put("extra_lifespan_for_public_noti", 3600);		// 추가 : iOS 단말에는 "기존 600초 + 지정한 시간" 이후에 SMS를 보내도록 하는 기능입니다.
		
		/*
		 *  msg 절삭(알림톡 전송가능한 최대 바이트는 4096이다.)
		 *  한글을 utf-8로 인코딩 했을 때 바이트수가 비약적으로 늘어나는데,
		 *  테스트 결과 512자로 절삭했을 때 기타정보 등 최종적으로 약 4100byte로 안정적으로 전송가능.
		 */
		String msg = pushVO.getMsg();
		int pushMsgMaxLength = Integer.parseInt(propertiesService.getString("pushMsgMaxLength"));
		if (msg.length() > pushMsgMaxLength) msg = msg.substring(0, pushMsgMaxLength);
		
		if (!"".equals(pushVO.getAddMsg())) {
			msg += pushVO.getAddMsg();
		}
		
		/*
		 *  sms_msg 절삭(sms_msg의 최대 길이는 1024byte이며, 길이 초과 시 메시지 접수가 되지 않습니다.)
		 *  ※ 한글 포함 시 utf8 기준으로 길이 계산 (1글자당 3byte)
		 */
		String sms_msg = msg;
		int smsMsgMaxLength = 256;		// 256자로 계산
		if (sms_msg.length() > smsMsgMaxLength) sms_msg = sms_msg.substring(0, smsMsgMaxLength);
		
		json.put("sms_msg", sms_msg);	// sms 발송시 보낼 메세지.
		
		String title = "";
		if("note".equals(type)){
			title = "[쪽지] ";
		}else if("work".equals(type)){
			title = "[업무연락] " + pushVO.getTitle();
		}else if("conf".equals(type)){
			title = "[회의알림] " + pushVO.getTitle();
		}else if("mail".equals(type)){
			title = "[사내메일] " + pushVO.getTitle();
		}else if("consult".equals(type)){
			title = "[상담관리] ";
		}else if("dayReport".equals(type)){
			title = "[업무일지 스케쥴러] ";
		}else if("late".equals(type)){
			title = "[일일근태 스케쥴러] ";
		}else if("product".equals(type)){
			title = "[상품관리] " + pushVO.getTitle();
		}else if("task".equals(type)){
			title = "[업무실적 보고] " + pushVO.getTitle();
		}else{
			title = "";
		}
		
		//type = URLEncoder.encode(type, "UTF-8");
		json.put("title", title);
		
		Map<String, Object> msgMap = new HashMap<String, Object>();
		msgMap.put("alert", msg);
		msgMap.put("name", pushVO.getSenderVO().getUserNm());
		msgMap.put("position", pushVO.getSenderVO().getRankNm());
		msgMap.put("department", pushVO.getSenderVO().getOrgnztNm());
		json.put("data", msgMap);
		
		String jsonData = json.toJSONString();

		result = sendMsgCts(targetURL, pushAuth, jsonData);
		
		noteService.insertPushLog(type, pushVO);
		
		return result;
	}
	
	// [2015/02/03, dwkim]재직자에게만 푸쉬 발송할 수 있도록, 받는이 목록 가공(안태규 부장님 요청)
	// memo : PushVO 클래스에  @Resource 어노테이션으로 빈을 주입시키려 했더니, 자꾸 주입시키지 못하고 null Exception을
	// 뱉어내드라.. 한 30여분 삽질했는데 결국 내려진 판단, PushVO객체는 PushSender처럼 빈으로 호출된 상태에서 진행하는 게 아니라 
	// pushVO를 매개변수로 받은 상태였다. (sendMessage()의 매개변수로).. 그래서 빈 주입이 안 되는 듯 싶다.
	public List<String> getrPhoneListExceptResigner(List<String> rPhoneList){
		List<String> resultList = new ArrayList<String>();
		
		for(String rPhoneNum: rPhoneList) {
			// 포맷 변경, 01012345678 -> 010-1234-5678
			String moblphonNo = rPhoneNum.substring(0,3) + "-" + rPhoneNum.substring(3,7)+ "-"  + rPhoneNum.substring(7);
			MemberVO searchVO = new MemberVO();
			searchVO.setMoblphonNo(moblphonNo);
			try {
				// work_st = 'W' 로 검색했을 때, 1건 이상 존재한다면 수신자 목록에 추가.
				if (memberService.selectMemberByMoblNoCnt(searchVO) > 0)
					resultList.add(rPhoneNum);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultList;
	}
	
	public String sendMessageTest(String pushAuth, String pushURI, String pushAPI, String type, PushVO pushVO) {
		
		String result = "";
		String targetURL = pushURI + "/" +pushAPI;
		
		JSONObject json = new JSONObject();
		json.put("s_phone", pushVO.getSenderVO().getMoblphonNo().replace("-", ""));
		json.put("r_phone", pushVO.getrPhoneList());
		json.put("user_id", "hanmam");
		json.put("message_type", 1);
		
		json.put("use_sms", 1);			// 추가 : 수신앱 미설치 시 SMS 발송
		json.put("lifespan", 600);		// 추가 : 서버에서 메시지를 보관하는 기간 (초 단위), 시간은 적절히 조정
		json.put("retry_by_sms", 1);		// 추가 : lifespan 만료 시 SMS 발송
		json.put("extra_lifespan_for_public_noti", 3600);		// 추가 : iOS 단말에는 "기존 600초 + 지정한 시간" 이후에 SMS를 보내도록 하는 기능입니다.
		
		/*
		 *  msg 절삭(알림톡 전송가능한 최대 바이트는 4096이다.)
		 *  한글을 utf-8로 인코딩 했을 때 바이트수가 비약적으로 늘어나는데,
		 *  테스트 결과 512자로 절삭했을 때 기타정보 등 최종적으로 약 4100byte로 안정적으로 전송가능.
		 */
		String msg = pushVO.getMsg();
		int pushMsgMaxLength = 512;
		if (msg.length() > pushMsgMaxLength) msg = msg.substring(0, pushMsgMaxLength);
		
		/*
		 *  sms_msg 절삭(sms_msg의 최대 길이는 1024byte이며, 길이 초과 시 메시지 접수가 되지 않습니다.)
		 *  ※ 한글 포함 시 utf8 기준으로 길이 계산 (1글자당 3byte)
		 */
		String sms_msg = msg;
		int smsMsgMaxLength = 256;		// 256자로 계산
		if (sms_msg.length() > smsMsgMaxLength) sms_msg = sms_msg.substring(0, smsMsgMaxLength);
		
		json.put("sms_msg", sms_msg);	// sms 발송시 보낼 메세지.
		
		String title = "";
		if("note".equals(type)){
			title = "[쪽지] ";
		}else if("work".equals(type)){
			title = "[업무연락] " + pushVO.getTitle();
		}else if("conf".equals(type)){
			title = "[회의알림] " + pushVO.getTitle();
		}else if("mail".equals(type)){
			title = "[사내메일] " + pushVO.getTitle();
		}else if("consult".equals(type)){
			title = "[상담관리] ";
		}else if("dayReport".equals(type)){
			title = "[업무일지 스케쥴러] ";
		}else if("late".equals(type)){
			title = "[일일근태 스케쥴러] ";
		}else if("product".equals(type)){
			title = "[상품관리] " + pushVO.getTitle();
		}else{
			title = "";
		}
		
		//type = URLEncoder.encode(type, "UTF-8");
		json.put("title", title);
		
		Map<String, Object> msgMap = new HashMap<String, Object>();
		msgMap.put("alert", msg);
		msgMap.put("name", pushVO.getSenderVO().getUserNm());
		msgMap.put("position", pushVO.getSenderVO().getRankNm());
		msgMap.put("department", pushVO.getSenderVO().getOrgnztNm());
		json.put("data", msgMap);
		
		String jsonData = json.toJSONString();

		result = sendMsgCts(targetURL, pushAuth, jsonData);
		
		return result;
	}
	
	public static void main(String[] args) {
		//CopyOfPushSender pushSender = new CopyOfPushSender();
		
		//String result = pushSender.sendMessage("테스트", "20~WJTfdpMRAA8GPH8RhtBPjLnThI", false, "3EEA64982077F040156B208A2272BEE15A2F65ACA99C03C4FD3A37EF2772DBDC","","22.112.235.161:17000");
		//System.out.println("결과1 : "+result);
		
		//String result2 = pushSender.sendMessage("[tes]test", "20o_KWeDZVqZ3ETIDfwz2eF8dgHPQ", false, "F2B640EEF636EE43BEC8AF4CFEA5A884C9429B5FFB570272C44AEA0618B065C6","iOS","22.112.235.161:17000");
		//System.out.println("결과2 : "+result2);				
	}
	

	
	public static String sendMsgCts(String targetURL, String auth_token, String jsonData) {
	
		System.out.println("########### send push START ###########");
		System.out.println("targetURL : "+targetURL);
		System.out.println("auth_token : "+auth_token);
		System.out.println("jsonData : "+jsonData);
		
		URL url;
		HttpURLConnection connection = null;
		
		//String auth = isParent ? P_AUTH_TOKEN : C_AUTH_TOKEN;
		//auth = "260FB4C22FA2B79DD9F604E7E255A674CD6EA238ED2C77D424E9C3C1637D56A3";
		try {
			// Create connection
			url = new URL("http://"+targetURL);
			connection = (HttpURLConnection)url.openConnection();
			
			connection.setRequestProperty("Content-Length", "" +Integer.toString(jsonData.getBytes().length));
			connection.setRequestProperty("Content-Language", "UTF-8");  
			
			connection = (HttpURLConnection)url.openConnection();
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Accept", "*/*");
			connection.setRequestProperty("Accept-Languge", "ko");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setRequestProperty("User-Agent", "ALLIMTALK.CP");  // 서비스 도메인
			connection.setRequestProperty("Authorization", "PNSLogin auth=" + auth_token); // 인증키
			
			// 요청 응답 타임아웃 설정
			connection.setConnectTimeout(2000);
			// 읽기 타임아웃 설정
			connection.setReadTimeout(2000);

			connection.setUseCaches (false);
			connection.setDoInput(true);
			connection.setDoOutput(true);

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			//wr.writeBytes(jsonData);
			wr.write(jsonData.getBytes("UTF-8"));
			wr.flush();
			wr.close();
			// Get Response		: 아래 구문이 없으면 push message 자체가 날아가지 않는다.
			InputStream is = connection.getInputStream();
			
			System.out.println(connection.getHeaderFields());
			
			BufferedReader rd = new BufferedReader(new InputStreamReader(is));
			
			String line;
			StringBuffer response = new StringBuffer();
			while ((line = rd.readLine()) != null) {
				response.append(line);
				//response.append('\r');
			}
			rd.close();
			
			System.out.println("@RESULT : "+response.toString());
			return response.toString();

			//return "@RESULT : ";
			

		} catch (Exception e) {

			e.printStackTrace();
			return null;

		} finally {

			if (connection != null) {
				connection.disconnect();
			}
		}	
	}
	

}
