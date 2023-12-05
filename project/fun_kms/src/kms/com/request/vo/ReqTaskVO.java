package kms.com.request.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

public class ReqTaskVO implements Serializable{
	private static final long serialVersionUID = 1L;

	@Getter @Setter private int reqNo = 0;							// 작업이 관련된 요구사항의 no
	@Getter @Setter private String reqId = "";							// 요구사항 ID ( 연도 2자리 + '-' + 그해 생성된 수. 예) 17-1 )
	@Getter @Setter private String reqTitle ="";						// 요구사항 제목

	@Getter @Setter private int no = 0;
	@Getter @Setter private String taskId = "";						// 요구사항 처리작업 ID ( 요구사항ID + '-' + 그해 생성된 수. 예) 17-1-1 )
	@Getter @Setter private String title ="";							// 처리작업 제목
	@Getter @Setter private Integer writerNo = 0;					// 작성자 No
	@Getter @Setter private String writerId ="";						// 작성자 ID
	@Getter @Setter private String writerName ="";					// 작성자 이름
	@Getter @Setter private String writerMixes ="";					// 작성자 이름 + ID
	@Getter @Setter private String regDatetime ="";					// 등록일시
	@Getter @Setter private String startDatetime ="";					// 시작일시
	@Getter @Setter private String finishDatetime ="";				// 완료일시
	@Getter @Setter private String modDatetime ="";				// 수정일시
	@Getter @Setter private String contents ="";						// 요청 내용
	@Getter @Setter private Integer taskType = 0;					// 작업의 종류 : 1: 분석,  2: 설계,  4: 구현 8: 시험 16: 오류처리  32: 연구 64: 기타
	@Getter @Setter private Integer status = 0;						// 상태 : 1: 생성,  2: 처리중,  4: 처리완료 
	@Getter @Setter private Integer priority = 0;						// 작업의 우선순위 : 1: 긴급,  2: 중요,  4: 보통 8: 여유 
	
	@Getter @Setter private Integer workerNo = 0;					// 담당자 No
	@Getter @Setter private String workerId = "";					// 담당자 ID
	@Getter @Setter private String workerName = "";				// 담당자 이름
	@Getter @Setter private String workerMixes = "";				// 담당자 이름, ID가 섞여있는 형태

	@Getter @Setter private int newTask = 0;							// 신규 작업 건수
	@Getter @Setter private int finishTask = 0;						// 처리 작업 건수
	@Getter @Setter private int remainTask = 0;						// 잔여 작업 건수

	public String getTaskTypeStr() {
		switch(taskType) {
			case 1 :
				return "분석";
			case 2 :
				return "설계";
			case 4 :
				return "구현";
			case 8 :
				return "시험";
			case 16 :
				return "오류처리";
			case 32 :
				return "연구";
			case 64 :
				return "기타";
		}
		return "이상값";
	}

	public String getStatusStr() {
		switch(status) {
			case 0 :
				return "선택";
			case 1 :
				return "생성";
			case 2 :
				return "처리중";
			case 4 :
				return "처리완료";
		}
		return "이상값";
	}

	public String getPriorityStr() {
		switch(priority) {
			case 0 :
				return "선택";
			case 1 :
				return "긴급";
			case 2 :
				return "중요";
			case 4 :
				return "보통";
			case 8 :
				return "여유";
		}
		return "이상값";
	}

}
