package kms.com.member.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.ListUtils;

import lombok.Getter;
import lombok.Setter;

public class UserVO  implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Getter @Setter private int pageIndex = 1;						/** 현재페이지 */
	@Getter @Setter private int firstIndex = 1;							/** firstIndex */
	@Getter @Setter private int recordCountPerPage = 30;			/** 페이지당 줄의 갯수 */

	@Getter @Setter private String searchKeyword = "";				// 검색Keyword 
	@Getter @Setter private String searchUseYn = "";				// 검색사용여부 
	@Getter @Setter private int searchLeaderNo = 0;				// 검색하고자 하는 PL의 NO 
	@Getter @Setter private int searchUserNo = 0;					// 검색하고자 하는 사용자의 NO 

	@Getter @Setter private int userNo = 0;						// 사용자 NO
	@Getter @Setter private String userId = "";				// 사용자 ID
	@Getter @Setter private String userName = "";			// 사용자 이름
	@Getter @Setter private String orgId = "";					// 부서 ID
	@Getter @Setter private String orgName = "";			// 부서 이름
	
}
