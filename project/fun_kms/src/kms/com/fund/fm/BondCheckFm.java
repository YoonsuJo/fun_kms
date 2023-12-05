package kms.com.fund.fm;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 서장열 
 * @date : 2017-03-26
 */
public class BondCheckFm {
	private static final long serialVersionUID = 1L;
	
	
	@Getter @Setter private String searchCondition = "N";			/** 검색조건  최초에 검색조건이 없이 시작할때 N로 시작함*/
	@Getter @Setter private String orgnztId = "";				// 부서 ID
	@Getter @Setter private String inclBondZero = "N";		// 검색조건으로 미수금이 없는것을 포함할것인가 체크값
	@Getter @Setter private String fromDate = "";			// 월별 금액 시작기준
	@Getter @Setter private String toDate = "";				// 월별 금액 종료기준

}
