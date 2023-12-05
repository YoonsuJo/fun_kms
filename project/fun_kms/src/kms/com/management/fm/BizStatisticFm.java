package kms.com.management.fm;

import java.io.Serializable;
import java.util.List;

import kms.com.common.service.BusinessSectorVO;
import kms.com.management.vo.MonthResultVO;

import lombok.Getter;
import lombok.Setter;

public class BizStatisticFm implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Getter @Setter private String searchConditionYn = "N";					//	검색조건유무
	@Getter @Setter private int searchYear = 0;									// 검색년
	@Getter @Setter private int searchMonth = 0;								//	검색월
	@Getter @Setter private int searchSectorNo = 0;							// 검색하고자 하는 Sector 번호

	// MonthResultList를 조회할때 사용
	@Getter @Setter private String searchOrgId = "";
	@Getter @Setter private String searchOrgNm = "";
	@Getter @Setter private int searchResultType = 0;						//	MonthSalesOut 등 
	@Getter @Setter private long amountSum = 0;
	@Getter @Setter private String searchPrjId = "";
	@Getter @Setter private String searchPrjNm = "";
	
	public String findOrgnztId(List<BusinessSectorVO> busiSectorList, int sectorNo) throws Exception {
		for(BusinessSectorVO vo: busiSectorList) {
			if(vo.getNo() == sectorNo)
				return vo.getBusiSectorVal(); 
		}
		return "";
	}
	
	public String getSearchYM() throws Exception{
		return String.format("%04d%02d", searchYear, searchMonth);
	}
	
	public long addAmount(List <MonthResultVO> mrVOList) throws Exception{
		long amountSum = 0;
		if((mrVOList != null) && (mrVOList.size() > 0)) {
			for(MonthResultVO vo : mrVOList) {
				amountSum += vo.getAmount();
			}
		}
		return amountSum;
	}
}
