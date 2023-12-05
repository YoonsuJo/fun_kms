package kms.com.common.timer;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;

import javax.annotation.Resource;

import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.service.LoginService;
import kms.com.common.utils.CalendarUtil;
import kms.com.community.service.NoteService;
import kms.com.management.service.InputResultPerson;
import kms.com.management.service.InputResultService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.impl.MemberDAO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Component;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Component("smsTimer")
public class SmsTimerScheduler extends TimerTask {
	
	private final String smsSenderUrl = "http://www.winc7788.co.kr/MSG/send/web_admin_send.htm";
	private final String userid = "dosanet";
	private final String passwd = "dosa0111";
	private final String sender = "028510002";
	private final String lateMessage = "KMS에서 지각 처리되었습니다.";
	private final String noInputMessage = "이번 달 나의업무현황에 등록된 실적이 0시간입니다. 실적을 등록해주세요.";
	private final String end_alert = "0";
	private String resultStr = "";

	@Resource(name = "KmsMemberService")
		private MemberService memberService;
	
	@Resource(name="KmsInputResultService")
	InputResultService irService;
	
	@Resource(name = "KmsLoginService")
		private LoginService loginService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;

	@Resource(name = "propertiesService")
		protected EgovPropertyService propertiesService;
	
	@Resource(name = "KmsMemberDAO")
    private MemberDAO memberDAO;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;
	
	@Override
	public void run() {
		// 하루에 한번 9시에 수행 // context-common.xml 에 타이머 bean 설정 
		// 개발컴은 문자 안보내게 설정 // context-properties.xml 키 값 smsSendHour		
		boolean isHmServer = propertiesService.getBoolean("isHmServer");		
		if(isHmServer){
			//지각자 문자 발송  //정책변경으로 사용안함
			//sendLateMessage(); 
			
			// 근태정보 업데이트
			updateAttendCheckTable();
			
			// 미투입인력 = 나의업무보고 미작성자
			sendNoInputMessage();
			
			// 생일자 안내
			selectBirthdayMember();
			
			// 각 팀/소장에게 예하부서 지각자 목록 쪽지 및 푸쉬 
			try {
				Map<String,Object> param = new HashMap<String,Object>();
				param.put("attendDt", CalendarUtil.getToday());
				if (!loginService.isHoliday(param))
					sendLateArrivalPush();
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		}
	}
	
	private void updateAttendCheckTable() {
		try {
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("attendDt", CalendarUtil.getToday());
			if (!loginService.isHoliday(param))
				memberService.updateAttendCheckTable();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	private void sendLateMessage() {
		try {
			/*
			 *check whether the login URL is test server or real server. 
			 *if it is test server, don's send sms
			 */
			memberService.updateAttendCheckTable();
			List<MemberVO> userList = memberService.selectLateMemberList();

			URL url = new URL(smsSenderUrl);
			String line = null;
			int result =0;
			URLConnection con = url.openConnection();
			
			con.setRequestProperty("Accept-Language",  "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
			con.setDoOutput(true);
			
			String receiver = "";
			String receiver_name = "";
			
			for (int i=0; i<userList.size(); i++) {
				MemberVO lateUser = userList.get(i);
				
				if (i != 0) {
					receiver += ",";
					receiver_name += ",";
				}
					
				receiver += lateUser.getMoblphonNo().replace("-", "");
				receiver_name += lateUser.getUserNm();
			}
			
			String parameter = URLEncoder.encode("userid", "euc-kr") + "="  + URLEncoder.encode(userid, "euc-kr");
			parameter += "&" + URLEncoder.encode("passwd", "euc-kr") + "="  + URLEncoder.encode(passwd, "euc-kr");
			parameter += "&" + URLEncoder.encode("sender", "euc-kr") + "="  + URLEncoder.encode(sender, "euc-kr");
			parameter += "&" + URLEncoder.encode("receiver", "euc-kr") + "="  + URLEncoder.encode(receiver, "euc-kr");
			parameter += "&" + URLEncoder.encode("message", "euc-kr") + "="  + URLEncoder.encode(lateMessage, "euc-kr");
			parameter += "&" + URLEncoder.encode("receiver_name", "euc-kr") + "=" + URLEncoder.encode(receiver_name, "euc-kr");
			parameter += "&" + URLEncoder.encode("end_alert", "euc-kr") + "=" + end_alert;
			
			OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
			wr.write(parameter);
			wr.flush();
		
			//응답 처리
			BufferedReader rd = null;

			rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "euc-kr"));
		
			/*
			 * 결과값에 따른 스트링 반환
			 * 참고 http://www.winc7788.co.kr/
			 */
			while ((line = rd.readLine()) != null) {
							
				result = Integer.parseInt(line.substring(0, 1));
				switch (result) {
					case 1  : this.resultStr = "필수 전달 값이 빠졌습니다.";
										break;
					case 2  : System.out.println("365 라는 정수입니다.");
										break;
					case 3  : System.out.println("1000 이라는 정수입니다.");
										break;			                   
					case 9  : this.resultStr = "지각문자가 성공적으로 전달되었습니다.";
										break;
				}
			}
			/*
			if(result == 9)
				return 1;
			else
				return 0;
			 */
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void sendNoInputMessage() {
		try {
			/*
			 *check whether the login URL is test server or real server. 
			 *if it is test server, don's send sms
			 */
			
			String today = CalendarUtil.getToday();
			int date = Integer.parseInt(today.substring(6));
			boolean checkNotInput = true;
			switch (date) {
			case 1 : // N월1일 때
				checkNotInput = false;	// pass
				break;
			case 2 : // N월2일 때
				if (CalendarUtil.getDay(today) == 2)
					checkNotInput = false;	// 그 주의 첫째날(월요일)일 때 pass
				if (CalendarUtil.getDay(today) == 1)
					checkNotInput = false;	// 그 주의 마지막날(일요일)일 때 pass
				break;
			case 3 :
				if (CalendarUtil.getDay(today) == 2)
					checkNotInput = false;	// 그 주의 첫째날(월요일)일 때 pass
				break;
			}
					
			if (checkNotInput) {
						
				URL url = new URL(smsSenderUrl);
				String line = null;
				int result =0;
				URLConnection con = url.openConnection();
				
				con.setRequestProperty("Accept-Language",  "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);
				
				String receiver = "";
				String receiver_name = "";
				
				InputResultPerson inputResultPerson = new InputResultPerson();
						
				List<MemberVO> notInputMemberList = irService.selectInputResultPersonNotInput(inputResultPerson);
							
				for (int i=0; i<notInputMemberList.size(); i++) {
					MemberVO noInputUser = notInputMemberList.get(i);
					if (i != 0) {
						receiver += ",";
						receiver_name += ",";
					}
					
					receiver += noInputUser.getMoblphonNo().replace("-", "");
					receiver_name += noInputUser.getUserNm();
				}
				
				String parameter = URLEncoder.encode("userid", "euc-kr") + "="  + URLEncoder.encode(userid, "euc-kr");
				parameter += "&" + URLEncoder.encode("passwd", "euc-kr") + "="  + URLEncoder.encode(passwd, "euc-kr");
				parameter += "&" + URLEncoder.encode("sender", "euc-kr") + "="  + URLEncoder.encode(sender, "euc-kr");
				parameter += "&" + URLEncoder.encode("receiver", "euc-kr") + "="  + URLEncoder.encode(receiver, "euc-kr");
				parameter += "&" + URLEncoder.encode("message", "euc-kr") + "="  + URLEncoder.encode(noInputMessage, "euc-kr");
				parameter += "&" + URLEncoder.encode("receiver_name", "euc-kr") + "=" + URLEncoder.encode(receiver_name, "euc-kr");
				parameter += "&" + URLEncoder.encode("end_alert", "euc-kr") + "=" + end_alert;
				
				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
				wr.write(parameter);
				wr.flush();
				
				//응답 처리
				BufferedReader rd = null;	
				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "euc-kr"));
			
				/*
				 * 결과값에 따른 스트링 반환
				 * 참고 http://www.winc7788.co.kr/
				 */
				while ((line = rd.readLine()) != null) {				
					
					result = Integer.parseInt(line.substring(0, 1));
					switch (result) {
						case 1  : this.resultStr = "필수 전달 값이 빠졌습니다.";
												 break;
						case 2  : System.out.println("365 라는 정수입니다.");
												 break;
						case 3  : System.out.println("1000 이라는 정수입니다.");
												 break;				                   
						case 9  : this.resultStr = "문자가 성공적으로 전달되었습니다.";
												 break;
					}
				}
			}
			/*
			if(result == 9)
				return 1;
			else
				return 0;
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void selectBirthdayMember() {
		//생일자 안내시스템으로 해당일, 금요일인 경우 주말에 생일인 사원의 부서와 바로 상위부서원들에게 쪽지 발송
		MemberVO memberVO = new MemberVO();
		List<MemberVO> result;
		try {
			result = memberService.selectBirthdayMemberList(memberVO);
			
				for(int i = 0; i < result.size(); i++){
					memberVO = result.get(i);
					String[] receiverList = memberVO.getReceiverList().split(",");
					
					//noteService.sendNote(178, new String[] {"arvin"}, 
					noteService.sendNote(memberVO.getNo(), receiverList, 
						"[생일자 알림 시스템 쪽지]\n"						
						+ "생일자명 : " + memberVO.getUserNm() + " " + memberVO.getRankNm() + "\n"
						+ "생년월일 : <b>" + memberVO.getBrthMainPrintLong() + "</b>\n"
						+ "소속부서 : " + memberVO.getOrgnztNm() + "\n"
						);    		
				}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void sendLateArrivalPush() {
		
		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
		String today = simple.format(new Date());
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("today", today);
		
		try {
			// 각 팀,소장별 소속 임직원 중 지각자 추출
			List<EgovMap> resultList = memberService.selectLateArrivalList(param);
			
			for(EgovMap tmpMap : resultList) {
				sendLateArrivalMessage(tmpMap, today);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void sendLateArrivalMessage(EgovMap tmpMap, String today) throws Exception {
		
		String headerNo = tmpMap.get("headerNo").toString();	// no
		String headerId = (String)tmpMap.get("headerId");		// user_id
		String lateArrivalList = (String)tmpMap.get("lateArrivalList");	// no
		
		String msg = "";
		
		// message 가공
		msg = "[일일 근태현황]\n\n";
		msg += "- 일자 : " + today.substring(2,4) + "." + today.substring(4,6) + "." + today.substring(6,8) + "\n";
		
		if (lateArrivalList == null || lateArrivalList.equals("")) {
			msg += "- 지각자 : 없음\n";
		} else {
			
			String strLateArrivalList = "";
			String[] arrLateArrivalList = lateArrivalList.split(",");
			
			for(String noInput: arrLateArrivalList) {
				MemberVO memberVO = new MemberVO();
				memberVO.setNo(Integer.parseInt(noInput));
				EgovMap memberEgov = memberDAO.selectSimpleMember(memberVO);
				
				strLateArrivalList += (String)memberEgov.get("userNm") + "(" + (String)memberEgov.get("orgnztNm") + "), ";
			}
			strLateArrivalList = strLateArrivalList.substring(0, strLateArrivalList.length() - 2);	// 끝 콤마 제거
			msg += "- 지각자 : " + strLateArrivalList + "\n";
		}

		// 쪽지 보내기
		String[] receiverList = {headerId};
		//noteService.sendNote(Integer.parseInt("404"), new String[] {"dwkim"}, msg);
		noteService.sendNote(Integer.parseInt(headerNo), receiverList, msg);
		
		// 푸쉬 메세지 보내기
		MemberVO header = new MemberVO();
		//header.setNo(Integer.parseInt("404"));
		header.setNo(Integer.parseInt(headerNo));
		header = memberDAO.selectMember(header);
    	
		String toPhoneNo = header.getMoblphonNo().replace("-", "");
		
		List<String> rPhoneList = new ArrayList<String>();
		rPhoneList.add(toPhoneNo);
		
		// 푸쉬 발송 전 파라미터 가공
		MemberVO senderVO = memberDAO.selectMember(header);
		
		PushVO pushVO = new PushVO();
		pushVO.setSenderVO(senderVO);
		pushVO.setrPhoneList(rPhoneList);
		pushVO.setMsg(msg);
		
		// 푸쉬 발송
		String type = "late";
		String pushResult = pushSender.sendMessage(type, pushVO);
	}
}
