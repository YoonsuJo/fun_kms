package kms.com.request.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

public class ReviewVO implements Serializable{
	private static final long serialVersionUID = 1L;

	@Getter @Setter private int no = 0;
	@Getter @Setter private int reqNo = 0;							// 검토건의 no
	@Getter @Setter private String reqId = "";							// 요구사항 ID ( 연도 2자리 + '-' + 그해 생성된 수. 예) 17-1 )
	@Getter @Setter private Integer writerNo = 0;					// 작성자 No
	@Getter @Setter private String writerId ="";						// 작성자 ID
	@Getter @Setter private String writerName ="";					// 작성자 이름
	@Getter @Setter private String writerMixes = "";					// 작성자 이름, ID가 섞여있는 형태

	@Getter @Setter private String regDatetime ="";					// 등록일시
	@Getter @Setter private String contents ="";						// 검토내용
}
