package kms.com.common.timer;

import com.ibm.icu.util.Calendar;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.service.LoginService;
import kms.com.community.service.NoteService;
import kms.com.cooperation.service.DayReportService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.impl.MemberDAO;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Component("dayReportTimer")
public class DayReportScheduler extends TimerTask {
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;

	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	@Resource(name = "KmsDayReportService")
	private DayReportService dayReportService;
	
	@Resource(name = "KmsMemberDAO")
    private MemberDAO memberDAO;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;
	
	// loginService의 isHoliday 메서드를 사용하기 위해 선언
	@Resource(name = "KmsLoginService")
	private LoginService loginService;
	
	@Override
	public void run() {
		// 일주일에 한번 금요일 저녁 8시에 수행 // context-common.xml 에 타이머 bean 설정 
		// 개발컴은 문자 안보내게 설정 // context-properties.xml 키 값 smsSendHour		
/*		boolean isHmServer = propertiesService.getBoolean("isHmServer");
		if(isHmServer){
			// 오늘이 마지막 일하는 날인 경우에만 실행
			Calendar oCalendar = Calendar.getInstance();
			try {
				if (isLastWorkDayInaWeek(oCalendar)) {
					// 업무일지 미작성 명단 PUSH 발송
					sendNoInputPush();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
*/	}
	
	public void sendNoInputPush() {
		
		// 이번주 근로일(working day) 계산
		// 매주 금요일 실행되기에, 5일전인 월요일부터 금요일까지로 fix
		Date today = new Date();
		Date startDate = new Date();
		
		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
		
		startDate.setTime(today.getTime()-5*(1000*60*60*24));
		
		String stDt = simple.format(startDate);
		String enDt = simple.format(today);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("stDt", stDt);
		param.put("enDt", enDt);
		
		try {
			// 각 팀,소장별 업무일지 미작성 인원 추출
			List<EgovMap> resultList = dayReportService.selectNoInputList(param);
			
			for(EgovMap tmpMap : resultList) {
				sendNoInputMessage(tmpMap, stDt, enDt);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
    
    private void sendNoInputMessage(EgovMap tmpMap, String stDt, String enDt) throws Exception {
		
		String headerNo = tmpMap.get("headerNo").toString();	// no
		String headerId = (String)tmpMap.get("headerId");		// user_id
		String noInputList = (String)tmpMap.get("noInputList");	// no
		
		String msg = "";
		String msgPush = "";
		String urlMsg = "";
		
		// message 가공
		msg = "[주간 업무일지 미작성자 현황]\n\n";
		msg += "- 기간 : " + stDt.substring(2,4) + "." + stDt.substring(4,6) + "." + stDt.substring(6,8) + " ~ " 
				 + enDt.substring(2,4) + "." + enDt.substring(4,6) + "." + enDt.substring(6,8) + "\n";
		
		if (noInputList == null || noInputList.equals("")) {
			msg += "- 미작성자 : 없음\n";
			msg += "- URL : 해당사항 없음";
		} else {
			
			String searchOrgId = "";
			String strNoInputList = "";
			String[] arrNoInputList = noInputList.split(",");
			
			for(String noInput: arrNoInputList) {
				MemberVO memberVO = new MemberVO();
				memberVO.setNo(Integer.parseInt(noInput));
				EgovMap memberEgov = memberDAO.selectSimpleMember(memberVO);
				
				strNoInputList += (String)memberEgov.get("userNm") + "(" + (String)memberEgov.get("orgnztNm") + "), ";
				if (searchOrgId.indexOf((String)memberEgov.get("orgnztId")) < 0)	// 중복된 부서는 입력치 않도록
					searchOrgId += (String)memberEgov.get("orgnztId") + ",";
			}
			strNoInputList = strNoInputList.substring(0, strNoInputList.length() - 2);	// 끝 콤마 제거
			msg += "- 미작성자 : " + strNoInputList + "\n";
			urlMsg = "- URL : http://hm.hanmam.kr/cooperation/selectDayReportUserList.do"
					+ "?searchDateFrom=" + stDt
					+ "&searchDateTo=" + enDt
					+ "&searchCondition=1"
					+ "&searchOrgId=" + searchOrgId;
			
			msgPush = msg;
			
			msg += urlMsg;		// 쪽지 메세지
		}

		// 쪽지 보내기
    	String[] receiverList = {headerId};
    	noteService.sendNote(Integer.parseInt(headerNo), receiverList, msg);
    	//noteService.sendNote(Integer.parseInt("404"), new String[] {"dwkim"}, msg);		// Test
		
		// 푸쉬 메세지 보내기
    	MemberVO header = new MemberVO();
    	header.setNo(Integer.parseInt(headerNo));
    	//header.setNo(Integer.parseInt("404"));	// Test
    	header = memberDAO.selectMember(header);
    	
		String toPhoneNo = header.getMoblphonNo().replace("-", "");
		
		List<String> rPhoneList = new ArrayList<String>();
		rPhoneList.add(toPhoneNo);
		
		// 푸쉬 발송 전 파라미터 가공
		MemberVO senderVO = memberDAO.selectMember(header);
		
		PushVO pushVO = new PushVO();
		pushVO.setSenderVO(senderVO);
		pushVO.setrPhoneList(rPhoneList);
		pushVO.setMsg(msgPush);
		pushVO.setAddMsg(urlMsg);
		
		// 푸쉬 발송
		String type = "dayReport";
		String pushResult = pushSender.sendMessage(type, pushVO);
	}
    
    /**
	 * 검색 날짜가 해당 주간의 마지막 Workday(일하는날) 인지 판별
	 * @param cal
	 * @return
     * @throws Exception 
	 */
	private boolean isLastWorkDayInaWeek(Calendar cal) throws Exception {
		// 기준 날짜 셋팅
		String month = String.valueOf(cal.get(Calendar.MONTH)+1);
		String day = String.valueOf(cal.get(Calendar.DATE));
		String todayStr = String.valueOf(cal.get(Calendar.YEAR))
				+ ((month.length()==1) ? "0"+month: month)
				+ ((day.length()==1) ? "0"+day: day);
		
		// 검색날짜 셋팅 - 최초 금요일 날짜로..
		Calendar compCal = (Calendar)cal.clone();
		String searchDate = "";
		Map<String, Object> param = new HashMap<String, Object>();
		
		compCal.add(Calendar.DATE, 6 - cal.get(Calendar.DAY_OF_WEEK));
		
		// 금요일부터 차례로 탐색
		for (int i=0; i < 5; i++) {
			compCal.add(Calendar.DATE, -i);
			month = String.valueOf(compCal.get(Calendar.MONTH)+1);
			day = String.valueOf(compCal.get(Calendar.DATE));
			searchDate = String.valueOf(compCal.get(Calendar.YEAR))
					+ ((month.length()==1) ? "0"+month: month)
					+ ((day.length()==1) ? "0"+day: day);
			
			// 휴일 여부 판별(마지막 평일인 경우 break)
			param.put("attendDt", searchDate);
			if (!loginService.isHoliday(param)) break;
		}
		
		if (todayStr.equals(searchDate))
			return true;
		else
			return false;
	}
}
