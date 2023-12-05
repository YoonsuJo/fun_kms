package kms.com.project.fm;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

import kms.com.request.vo.RequestVO;

public class ProjectFm {
	private static final long serialVersionUID = 1L;

	@Getter @Setter private String searchUseYn = "";					/** 검색사용여부 */


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
	@Getter @Setter private int searchStatus = 0;			// 찾고자 하는 요청의 처리상태

	@Getter @Setter private int priority1 = 0;					// 우선순위 : 긴급
	@Getter @Setter private int priority2 = 0;					// 우선순위 : 중요
	@Getter @Setter private int priority3 = 0;					// 우선순위 : 보통
	@Getter @Setter private int priority4 = 0;					// 우선순위 : 여유
	@Getter @Setter private int searchPriority = 0;			// 찾고자 하는 요청의 우선순위상태

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
	@Getter @Setter private String searchFinishDateFrom = "";			// 완료일 검색조건 (부터)
	@Getter @Setter private String searchFinishDateTo= "";				// 완료일 검색조건 (까지)
	@Getter @Setter private String searchPrjNm = "";					// 프로젝트 명
	@Getter @Setter private String searchPrjId = "";						// 프로젝트 ID
}
