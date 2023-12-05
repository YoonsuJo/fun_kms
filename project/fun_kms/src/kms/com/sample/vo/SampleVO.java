package kms.com.sample.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 서장열 
 * @date : 2017-04-04
 */
public class SampleVO {

	@Getter @Setter private String prjId = "";					// 프로젝트ID
	@Getter @Setter private String prjName = "";				// 프로젝트명
	@Getter @Setter private String bondYn = "";				// 프로젝트의 채권관리 상태
	@Getter @Setter private String stat = "";					// 프로젝트의 상태 즉, 진행중 : P, 중단 : S, 종료 : E
	@Getter @Setter private long totalPrjSum = 0;			// 프로젝트의 계산서 발행총액
	@Getter @Setter private long totalPrjCollect = 0;			// 프로젝트의 수금총액
	@Getter @Setter private long monthPrjSum = 0;			// 프로젝트의 해당월 계산서 발행총액
	@Getter @Setter private long monthPrjCollect = 0;		// 프로젝트의 해당월 수금총액
	
}
