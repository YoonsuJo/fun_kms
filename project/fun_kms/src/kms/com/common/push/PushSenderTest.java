package kms.com.common.push;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import kms.com.common.utils.CommonUtil;
import kms.com.member.service.MemberVO;

import org.json.simple.JSONObject;
import org.junit.Before;
import org.junit.Test;

public class PushSenderTest {
	
	private String msg;
	private List<String> rPhoneList;
	private String auth_token;
	private String pushURI;
	private String pushAPI;
	private String type;
	MemberVO senderVO;
	private PushVO pushVO;
	
	//@Before
	public void setUp() throws Exception {
		
		//this.msg = "This is test message.";
		this.msg = "<div>테스트테스트~~~ 한마음시스템 개선사항 화면설계입니다.</div><div>&nbsp;</div><div>아래 내용을 참조하여 개발추진 부탁드립니다.</div><div><br></div><div><br></div><div><b><font color=\"rgb(112,48,160)\" size=\"3\">○ 한마음시스템 개선사항 개발관련</font></b></div><div><b></b>&nbsp;</div><div>1. 개발 순서</div><div>&nbsp;&nbsp; - PPT문서 순서대로 진행하셔도 되고, </div><div>&nbsp; &nbsp;&nbsp; 김동우 대리가 판단하여&nbsp;개발기간이 적게 들어가는 기능부터 먼저&nbsp;진행해도 됩니다. (이왕이면 순서대로)</div><div><br></div><div>2. 개발진행 방식</div><div>&nbsp; 1) 개발자 로컬 개발환경 코딩 완료</div><div>&nbsp; 2) 테스트 서버&nbsp;적용 및 본 업무연락에 덧글로 코딩 완료된 기능 내역 알림</div><div>&nbsp; 3) 테스트 서버 기능 테스트 (김태연 차장)</div><div>&nbsp; 4) 기능이 이상 없을 경우 덧글로 실서버&nbsp;적용 지시</div><div>&nbsp; 5) 실서버 적용 및 테스트</div><div>&nbsp;</div><div>※ 진행 간 대표이사 지시사항이나 한마음시스템 장애가 발생할 경우 해당사항부터 먼저 개발합니다.</div><div>&nbsp;</div><div>※ 추가 개선사항 발생 시 첨부파일에 화면설계 추가&nbsp;업데이트 하여 재 업로드 하도록 하겠습니다.</div><div>&nbsp;</div><div>&nbsp;</div><div><div><b><font color=\"rgb(112,48,160)\" size=\"3\">○&nbsp;개발목록</font></b>&nbsp;</div><div>&nbsp;</div><div>1. 겸직 기능 외 3건&nbsp; =&gt;&nbsp; 1,2,3번 개발완료 / 4번만 개발하면 됨<br>2. [나의업무] 관련 개선1<br>3. [나의업무] 관련 개선2<br>4. 프로젝트 상세정보<br>5. 일반매출 보고 시 사용자 편의성 강화<br>6. 종합매출 보고 시 사용자 편의성 강화<br>7. 쪽지 전달기능 사용 시 태그 수정<br>8. 한마음게임 오류 및 통합검색 페이징 오류<br>9. 페이징 화면 검색 오류<br>10. 첨부파일 삭제 시 오류<br>11. 프로젝트별 실적 화면 개선<br>12. 판관비 운용 실적 화면 개선<br>13. 프로젝트별 예산 화면 개선<br>14. 주간업무보고 화면 수정<br>15. 수정기안 중 저장 시 알림창 전시<br>16. 상품관리 – 검토결과 이미지 등록 에러<br>[상품관리 요구사항] 17. 메인화면 관련자 부재현황&nbsp; =&gt;&nbsp; 추가검토 필요<br>18. 종합매출보고 취소 시 상품매입 지결서 정보 쪽지 발송</div></div>";
		msg = CommonUtil.deleteAllTag(msg);	// 태그 제거
		//this.toPhoneNum = new String[] {"01029706293","01030270070"};
		this.rPhoneList = new ArrayList<String>();
		rPhoneList.add("01029706293");
		
		/*
		 *  msg 절삭(알림톡 전송가능한 최대 바이트는 4096이다.)
		 *  한글을 utf-8로 인코딩 했을 때 바이트수가 비약적으로 늘어나는데,
		 *  테스트 결과 512자로 절삭했을 때 기타정보 등 최종적으로 약 4100byte로 안정적으로 전송가능.
		 */
		
		this.pushURI = "121.78.149.162:17000";
		this.pushAPI = "req_at_msg_send_2_6";
		this.auth_token	= "5F3650E4459303E0CD6B09CAE1BF58C4EB644DBA48881A2CE33A4C189CA27542";
		
		this.senderVO = new MemberVO();
		this.senderVO.setMoblphonNo("010-2970-6293");
		this.senderVO.setUserNm("김동우");
		this.senderVO.setRankNm("대리");
		this.senderVO.setOrgnztNm("개발7팀");
		
		this.type = "note";
		
		pushVO = new PushVO();
		pushVO.setSenderVO(senderVO);
		pushVO.setrPhoneList(rPhoneList);
		pushVO.setMsg(msg);
	}
	
	@Test
	public void pushSenderTest() throws Exception {
		setUp();
		PushSender pushSender = new PushSender();
		
		//pushSender.sendMessageByPhoneNo(info, msg, toPhoneNum, isParent, auth_token, device_type, pushURI, pushAPI, toUserNm, type, title, senderVO);
		pushSender.sendMessageTest(auth_token, pushURI, pushAPI, type, pushVO);
	}
	
}

