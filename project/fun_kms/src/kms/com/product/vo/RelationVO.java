package kms.com.product.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

public class RelationVO {

	
	@Getter @Setter private int no = 0;
	@Getter @Setter private int ownerNo = 0;		// 상위 노드
	@Getter @Setter private int subNo = 0;			// 하위 노드
	@Getter @Setter private int sortNo = 0;			// 정렬순서
	@Getter @Setter private String type = "";			// part 의 종류  P : part, M: module, V: 버전*/

}
