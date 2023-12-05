package kms.com.request.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

public class RequestReceiveVO implements Serializable{
	private static final long serialVersionUID = 1L;

	@Getter @Setter private int no = 0;
	@Getter @Setter private String reqId = "";							// 요구사항 ID ( 연도 2자리 + '-' + 그해 생성된 수. 예) 17-1 )
	@Getter @Setter private Integer writerNo = 0;					// 작성자 No
	@Getter @Setter private String userId ="";						// 작성자 ID
	@Getter @Setter private String userNm ="";					// 작성자 이름
	@Getter @Setter private String userNo = "";					// 작성자 이름, ID가 섞여있는 형태
	@Getter @Setter private String[] reqUserIdList;					// 복수 담당자
	@Getter @Setter private String completeInfo = "";				// 완료 및 미완료 한 담당자 정보
	@Getter @Setter private int completeStatus = 0;				// 완료 및 미완료 값(완료 : 1 , 미완료 : 0)
	@Getter @Setter private String completeDateTime = "";				// 완료 시간	
}
