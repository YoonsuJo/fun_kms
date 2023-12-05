package kms.com.request.fm;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

import kms.com.request.vo.RequestVO;

public class ReqTaskFm {
	@Getter @Setter private int pageUnit = 15;							/** 페이지갯수 */
	@Getter @Setter private int pageSize = 10;							/** 페이지사이즈 */
	@Getter @Setter private int pageIndex = 1;							/** 현재페이지 */
	@Getter @Setter private int firstIndex = 0;							/** firstIndex */
	@Getter @Setter private int lastIndex = 1;								/** lastIndex */
	@Getter @Setter private int recordCountPerPage = 100000;		/** recordCountPerPage */

	private static final long serialVersionUID = 1L;

	@Getter @Setter private String searchUseYn = "";					/** 검색사용여부 */

	// 작업의 종류 : 1: 분석,  2: 설계,  4: 구현 8: 시험 16: 오류처리  32: 연구 64: 기타
	@Getter @Setter private int taskType1 = 0;				// 작업유형 : 분석
	@Getter @Setter private int taskType2 = 0;				// 작업유형 : 설계
	@Getter @Setter private int taskType3 = 0;				// 작업유형 : 구현
	@Getter @Setter private int taskType4 = 0;				// 작업유형 : 시험
	@Getter @Setter private int taskType5 = 0;				// 작업유형 : 오류처리
	@Getter @Setter private int taskType6 = 0;				// 작업유형 : 연구
	@Getter @Setter private int taskType7 = 0;				// 작업유형 : 기타
	@Getter @Setter private int searchTaskType = 0;			//  찾고자 하는 작업유형 

	// 상태 : 1: 생성,  2: 처리중,  4: 처리완료 
	@Getter @Setter private int status1 = 0;					// 처리상태 : 생성
	@Getter @Setter private int status2 = 0;					// 처리상태 : 처리중
	@Getter @Setter private int status3 = 0;					// 처리상태 : 완료
	@Getter @Setter private int searchStatus = 0;			// 찾고자 하는 작업의 처리상태

	// 작업의 중요도 : 1: 긴급,  2: 중요,  4: 보통 8: 여유  
	@Getter @Setter private int priority1 = 0;					// 우선순위 : 긴급
	@Getter @Setter private int priority2 = 0;					// 우선순위 : 중요
	@Getter @Setter private int priority3 = 0;					// 우선순위 : 보통
	@Getter @Setter private int priority4 = 0;					// 우선순위 : 여유
	@Getter @Setter private int searchPriority = 0;			// 찾고자 하는 작업의 우선순위

	@Getter @Setter private int searchWorkerNo = 0;					// 찾고자 하는 담당자 NO
	@Getter @Setter private String searchWorkerId = "";				// 담당자 ID
	@Getter @Setter private String searchWorkerName = "";			// 담당자 이름
	@Getter @Setter private String searchWorkerMixes = "";			// 담당자 이름 + ID
	@Getter @Setter private String[] searchWorkerMixesList;			// 담당자 이름 + ID 목록
	
	@Getter @Setter private int searchReqNo = 0;						// 요구사항 NO
	@Getter @Setter private String searchTitle = "";						// 요구사항명
	@Getter @Setter private int searchWriterNo = 0;						// 찾고자 하는 작성자 NO
	@Getter @Setter private String searchWriterId = "";					// 작성자 ID
	@Getter @Setter private String searchWriterName = "";				// 작성자 이름
	@Getter @Setter private String searchWriterMixes = "";				// 작성자 이름 + ID

	@Getter @Setter private String searchDateFrom = "";				// 작성일 검색조건 (부터)
	@Getter @Setter private String searchDateTo = "";					// 작성일 검색조건 (까지)
	@Getter @Setter private String searchFinishDateFrom = "";			// 완료일 검색조건 (부터)
	@Getter @Setter private String searchFinishDateTo= "";				// 완료일 검색조건 (까지)
	@Getter @Setter private String searchPrjNm = "";					// 프로젝트 명
	@Getter @Setter private String searchPrjId = "";						// 프로젝트 ID

	@Getter @Setter private String searchReload = "Y";					// 저장후 parant window 갱신할지 말지.
}
