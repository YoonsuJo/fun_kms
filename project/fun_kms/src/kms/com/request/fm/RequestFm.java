package kms.com.request.fm;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

import kms.com.request.vo.RequestVO;

public class RequestFm {
	/* 페이지처리 */
	@Getter @Setter private int pageUnit = 100;							/** 페이지갯수 */
	@Getter @Setter private int pageSize = 10;							/** 페이지사이즈 */
	@Getter @Setter private int pageIndex = 1;							/** 현재페이지 */
	@Getter @Setter private int firstIndex = 0;							/** firstIndex */
	@Getter @Setter private int lastIndex = 1;								/** lastIndex */
	@Getter @Setter private int recordCountPerPage = 100000;		/** recordCountPerPage */

	private static final long serialVersionUID = 1L;

	@Getter @Setter private String searchUseYn = "";					/** 검색사용여부 */

	@Getter @Setter private int searchProcessMode = 0;			//  찾고자 하는 요구사항 처리계획 유형 

	@Getter @Setter private int reqType1 = 0;				// 요구유형 : 오류수정
	@Getter @Setter private int reqType2 = 0;				// 요구유형 : 고객요구
	@Getter @Setter private int reqType3 = 0;				// 요구유형 : 기능개선
	@Getter @Setter private int reqType4 = 0;				// 요구유형 : 기능추가
	@Getter @Setter private int searchReqType = 0;			//  찾고자 하는 요구유형 

	@Getter @Setter private int status1 = 0;					// 처리상태 : 접수
	@Getter @Setter private int status2 = 0;					// 처리상태 : 검토중
	@Getter @Setter private int status3 = 0;					// 처리상태 : 개발중
	@Getter @Setter private int status4 = 0;					// 처리상태 : 시험중
	@Getter @Setter private int status5 = 0;					// 처리상태 : 완료
	@Getter @Setter private int status6 = 0;					// 처리상태 : 보류
	@Getter @Setter private int status7 = 0;					// 처리상태 : 삭제
	@Getter @Setter private int searchStatus = 0;			// 찾고자 하는 요청의 처리상태

	@Getter @Setter private int priority1 = 0;					// 우선순위 : 긴급
	@Getter @Setter private int priority2 = 0;					// 우선순위 : 중요
	@Getter @Setter private int priority3 = 0;					// 우선순위 : 보통
	@Getter @Setter private int priority4 = 0;					// 우선순위 : 여유
	@Getter @Setter private int searchPriority = 0;			// 찾고자 하는 요청의 우선순위상태

	@Getter @Setter private int managerType = 0;					// 찾고자 하는 담당자 형태
	@Getter @Setter private int managerType1 = 1;					// 개인
	@Getter @Setter private int managerType2 = 2;					// 팀
	@Getter @Setter private int managerType3 = 3;					// 전체
	
	@Getter @Setter private int searchManagerNo = 0;					// 찾고자 하는 담당자 NO
	@Getter @Setter private String searchManagerId = "";				// 담당자 ID
	@Getter @Setter private String searchManagerName = "";			// 담당자 이름
	@Getter @Setter private String searchManagerMixes = "";			// 담당자 이름 + ID
	@Getter @Setter private String[] searchManagerMixesList;				// 작성자 이름 + ID 목록
	
	@Getter @Setter private String searchTitle = "";						// 요구사항명
	@Getter @Setter private int searchWriterNo = 0;						// 찾고자 하는 작성자 NO
	@Getter @Setter private String searchWriterId = "";					// 작성자 ID
	@Getter @Setter private String searchWriterName = "";				// 작성자 이름
	@Getter @Setter private String searchWriterMixes = "";				// 작성자 이름 + ID
	@Getter @Setter private String[] searchWriterMixesList;				// 작성자 이름 + ID 목록

	@Getter @Setter private String searchDateFrom = "";				// 작성일 검색조건 (부터)
	@Getter @Setter private String searchDateTo = "";					// 작성일 검색조건 (까지)
	@Getter @Setter private String searchDueDateFrom = "";			// 완료요청일 검색조건 (부터)
	@Getter @Setter private String searchDueDateTo = "";				// 완료요청일 검색조건 (까지)
	@Getter @Setter private String searchFinishDateFrom = "";			// 완료일 검색조건 (부터)
	@Getter @Setter private String searchFinishDateTo= "";				// 완료일 검색조건 (까지)
	@Getter @Setter private String searchTreatedDateFrom = "";			// 처리일 검색조건 (부터)
	@Getter @Setter private String searchTreatedDateTo = "";			// 처리일 검색조건 (까지)
	@Getter @Setter private String searchPrjNm = "";					// 프로젝트 명
	@Getter @Setter private String searchPrjId = "";						// 프로젝트 ID
	@Getter @Setter private String isTreatedYn = "";					// 처리 건수 검색 여부

	@Getter @Setter private String searchDueNULL = "";			// 완료요청일이 없는 경우 
	@Getter @Setter private String param_returnUrl = "";			// 리턴 URL 
	@Getter @Setter private int firstOpen = 0;			// 요구사항 클릭 여부
	@Getter @Setter private int untreated  = 0;			// 미처리 여부
	@Getter @Setter private int lastCreate  = 0;			// 추후개발 여부
	@Getter @Setter private int weekChk  = 0;			// 금주잔여 왼쪽메뉴 숫자 클릭 여부
	@Getter @Setter private int monthChk  = 0;			// 금월잔여 왼쪽메뉴 숫자 클릭 여부
	@Getter @Setter private String today = "";			// 오늘일자 
	@Getter @Setter private String thisMonth = "";			// 오늘월
	@Getter @Setter private String nextMonth = "";			// 다음월 
	@Getter @Setter private String thisMonthStart = "";			// 오늘월 첫번째
	@Getter @Setter private String thisMonthEnd = "";			// 오늘월 마지막
	@Getter @Setter private String nextMonthEnd = "";			// 다음월 마지막
	@Getter @Setter private int modeChk = 0;			// 사용자 왼쪽 메뉴 숫자 눌러서 들어왔는지 확인
	@Getter @Setter private String atchFileId = "";					// 첨부파일 ID
	
	@Getter @Setter private String atDate = "";  //완료예정 날짜 검색 기준일
	@Getter @Setter private int dateMove = 0; //완료예정 날짜 검색 이동일
	@Getter @Setter private String dueDateAll = "Y";  //완료예정 기준일 과 전체 선택 기준 ( N : 기준일로 보기 ,Y: 전체로 보기)
	
}
