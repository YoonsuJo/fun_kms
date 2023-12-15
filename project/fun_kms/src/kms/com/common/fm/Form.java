package kms.com.common.fm;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class Form implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Getter @Setter private String searchConditionYn = "N";			/* 검색조건유무 : */

}
