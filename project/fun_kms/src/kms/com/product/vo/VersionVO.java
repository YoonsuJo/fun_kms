package kms.com.product.vo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

public class VersionVO implements Serializable{
	private static final long serialVersionUID = 1L;

	@Getter @Setter private int no = 0;
	@Getter @Setter private int partNo = 0;							// 구성품 ID
	@Getter @Setter private String partNm = "";						// 구성품 ID
	@Getter @Setter private String version = "";						// 버젼
	@Getter @Setter private String versionName = "";				// 버젼명
	@Getter @Setter private String interfaceChange = "N";			// 인터페이스 변경여부  'Y' : 변경됨, 'N' : 변경안됨
	
	@Getter @Setter private int writerNo = 0;					// 작성자 No
	@Getter @Setter private String writerId ="";						// 작성자 ID
	@Getter @Setter private String writerName ="";					// 작성자 이름
	@Getter @Setter private String writerMixes = "";					// 작성자 이름, ID가 섞여있는 형태

	@Getter @Setter private String regDatetime ="";					// 등록일시
	@Getter @Setter private String publishDate ="";					// 출시일시

	@Getter @Setter private String upgradeNote ="";				// 개선 내용
	@Getter @Setter private String interfaceNote ="";				// 인터페이스 변경 사항
	@Getter @Setter private String sourceNote ="";					// 관련 소스 정보
	@Getter @Setter private String documentNote ="";				// 관련 문서 내용 정보
}
