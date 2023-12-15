package kms.com.common.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class SearchVO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Getter @Setter private long salesOut = 0;
	@Getter @Setter private long salesIn = 0;
	@Getter @Setter private long purchaseOut = 0;
	@Getter @Setter private long purchaseIn = 0;
	@Getter @Setter private long labor = 0;
	@Getter @Setter private long expense = 0;
}

