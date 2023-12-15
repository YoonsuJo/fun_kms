package kms.com.menu.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class MenuVO implements Serializable{
	private static final long serialVersionUID = 1L;

	@Getter @Setter private int no = 0;

	@Getter @Setter private String title = "";					// 메뉴이름
	@Getter @Setter private String url = "";					// URL
	@Getter @Setter private Integer ownerNo = 0;			// 작성자 No
	@Getter @Setter private String orgnztId = "";				// 메뉴의 소유 팀ID
	@Getter @Setter private int order = 0;						// 메뉴 나열순서
	@Getter @Setter private int type = 1;						// 메뉴 분류 : 1 : 개인용, 2: 부서(팀)용

	@Getter @Setter private String ownerId = "";				// 작성자 ID
	@Getter @Setter private String ownerName = "";			// 작성자 이름
	@Getter @Setter private String ownerMixes = "";			// 작성자 이름, ID가 섞여있는 형태

}
