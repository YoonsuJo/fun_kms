package kms.com.request.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import kms.com.common.vo.HanmamVO;
import lombok.Getter;
import lombok.Setter;

public class RequestVO  extends HanmamVO {
	private static final long serialVersionUID = 1L;
	
	public final static int RT_ASSIGNMENT = 1;
	public final static int RT_REQUEST = 2;
	public final static int RT_ERROR = 4;

	public final static int ST_REQUEST = 1;
	public final static int ST_REVIEW = 2;
	public final static int ST_PROCESS = 4;
	public final static int ST_TEST = 8;
	public final static int ST_COMPLETE = 16;
	public final static int ST_DEFER = 32;
	public final static int ST_DELETE = 64;
	public final static int ST_ALL = 127;

	public final static int PR_URGENT = 1;							// 우선순위 : 긴급
	public final static int RT_IMPORTANT = 2;					// 우선순위 : 중요
	public final static int RT_COMMON = 4;						// 우선순위 : 보통
	public final static int RT_LATER = 8;							// 우선순위 : 여유

	@Getter @Setter private int no = 0;
	@Getter @Setter private String reqId = "";						// 요청번호  연도 2자리 + '-' + 그해 생성된 수. 예) 17-1
	@Getter @Setter private int reqType =0;						// 요청 유형
	@Getter @Setter private String title ="";							// 요청 제목
	@Getter @Setter private int writerNo = 0;					// 작성자 No
	@Getter @Setter private String writerId ="";						// 작성자 ID
	@Getter @Setter private String writerName ="";					// 작성자 이름
	@Getter @Setter private String writerMixes ="";					// 작성자 이름 + ID
	@Getter @Setter private String regDatetime ="";					// 등록일시
	@Getter @Setter private String modDatetime ="";				// 수정일시
	@Getter @Setter private String finishDatetime ="";				// 완료일시
	@Getter @Setter private String dueDate ="";						// 완료요청일
	@Getter @Setter private String startDate;						// 작업시작예정일
	@Getter @Setter private String endDate;						// 작업종료예정일
	@Getter @Setter private String contents ="";						// 요청 내용
	@Getter @Setter private int status = 0;						// 상태 : 0: 부결, 1: 요청,	2: 검토중, 3: 검토완료, 4: 개발시작, 5: 개발완료 6:테스트시작, 7:테스트완료, 8: 종료 
	@Getter @Setter private int priority = 0;						// 우선순위: 1:긴급, 2:중요, 4:보통 8: 여유
	@Getter @Setter private String prjId = "";							// 관련 프로젝트 ID
	@Getter @Setter private String prjNm = "";						// 관련 프로젝트명
	@Getter @Setter private String productId = "";					// 관련 제품 ID
	
	@Getter @Setter private int managerNo = 0;				// 담당자 No
	@Getter @Setter private String managerId = "";					// 담당자 ID
	@Getter @Setter private String managerName = "";				// 담당자 이름
	@Getter @Setter private String managerMixes = "";				// 담당자 이름 + ID
	
	@Getter @Setter private String atchFileId = "";					// 첨부파일 ID

	@Getter @Setter private int newRequest = 0;						// 신규 요구사항 건수
	@Getter @Setter private int finishRequest = 0;					// 처리 요구사항 건수
	@Getter @Setter private int remainRequest = 0;					// 잔여 요구사항 건수
	@Getter @Setter private String managerNameList = "";				// 담당자 이름 리스트
	@Getter @Setter private String managerMixesMain = "";				// 주 담당자 이름 + ID
	@Getter @Setter private int mainManagerNo = 0;
	@Getter @Setter private int dayCheck = 0;				// 날짜 체크 (0 : 색상없음, 1 : 약간 진한 목록 색상 , 2:진한 목록 색상) 
	@Getter @Setter private int dueDayCheck = 0;				// 날짜 체크 (0 : 색상없음, 2: 완료예정 색 지정(붉은계열) 
	@Getter @Setter private int modifyerNo = 0;				// 수정중인 사용자 No
	@Getter @Setter private String modifyerName = "";				// 수정중인 사용자 Name

	
public String getStatusStr() {
		switch(status) {
			case ST_REQUEST :
				return "대기중";
			case ST_REVIEW :
				return "설계중";
			case ST_PROCESS :
				return "구현중";
			case ST_TEST :
				return "검증중";
			case ST_COMPLETE :
				return "완료";
			case ST_DEFER :
				return "보류";
			case ST_DELETE :
				return "삭제";
		}
		return "이상값";
	}

	public String getReqTypeStr() {
		switch(reqType) {
			case RT_ASSIGNMENT :
				return "과제";
			case RT_REQUEST :
				return "요구";
			case RT_ERROR :
				return "오류";
		}
		return "이상값";
	}

	public String getPriorityStr() {
		switch(priority) {
			case PR_URGENT :
				return "긴급";
			case RT_IMPORTANT :
				return "중요";
			case RT_COMMON :
				return "보통";
			case RT_LATER :
				return "여유";
		}
		return "이상값";
	}
	
	public String getStartDateStr() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd");
		if(startDate != null) {
			return GetDateString(sdf.parse(startDate));
		}
		else {
			return "";
		}
	}

	public String getEndDateStr() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd");
		if(endDate != null) {
			return GetDateString(sdf.parse(endDate));
		}else {
			return "";
		}
	}
	
	public boolean getIsOldDateStartDate() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd");
		if(startDate != null) {
			return IsOldDate(sdf.parse(startDate));
		}else {
			return false;
		}
	}
	public boolean getIsOldDateEndDate() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd");
		if(endDate != null) {
			return IsOldDate(sdf.parse(endDate));
		}else {
			return false;
		}
	}
	

}
