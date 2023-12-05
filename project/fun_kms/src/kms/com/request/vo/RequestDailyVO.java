package kms.com.request.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

public class RequestDailyVO implements Serializable{
	private static final long serialVersionUID = 1L;

	@Getter @Setter private int no;
	@Getter @Setter private String reqId;						
	@Getter @Setter private String title;							// 요구사항 요청 제목
	@Getter @Setter private String contents;						// 요구사항 요청 내용
	@Getter @Setter private int status;						// 상태 : 0: 부결, 1: 요청,	2: 검토중, 3: 검토완료, 4: 개발시작, 5: 개발완료 6:테스트시작, 7:테스트완료, 8: 종료 
	@Getter @Setter private String prjId;							// 관련 프로젝트 ID
	@Getter @Setter private String prjNm;						// 관련 프로젝트명
	
	@Getter @Setter private int reqNo = 0;				// 작업 내용

}
