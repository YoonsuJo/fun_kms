package kms.com.message.service;

import java.io.Serializable;
import org.apache.log4j.Logger;
import org.apache.commons.lang.builder.ToStringBuilder;

public class MessageVO implements Serializable {
	private static final long serialVersionUID = 1L;

	Logger logT = Logger.getLogger("TENY");

	/* 페이징 처리를 위한 변수 */
	private int pageIndex = 1;						/** 현재페이지 */
	private int firstIndex = 1;							/** firstIndex */
	private int recordCountPerPage = 30;			/** 페이지당 줄의 갯수 */
	
	private String searchCondition = "N";			/** 검색조건  최초에 검색조건이 없이 시작할때 N로 시작함*/

	private String searchKeyword = "";				/** 검색Keyword */
	private String searchUseYn = "";					/** 검색사용여부 */
	
	private String searchStatusN = "";
	private String searchStatusY = "";
	private String searchStatusC = "";
	private String searchPublishCoAcronym = "";
	private String searchTitle = "";
	private String searchWriteUserName = "";
	private String searchCompanyName = "";
	private String searchPrjName = "";
	private String searchPrjId = "";
	private String searchUntilToday = "";

	private String searchUntilDate = "";

	/* message를 위한 변수 */
	private long 	no = 0 ;
	private String 	title = "" ;
	private String 	contents = "" ;
	private String 	link = "" ;
	private int 	sendUserNo = 0 ;
	private String 	sendDatetime = "" ;
	private int 	recvUserNo = 0 ;
	private int 	read = 0 ;
	private String 	readDatetime = "" ;
	private int 	del = 0 ;
	private String 	delDatetime = "" ;
	private int 	status = 0 ;
	private int 	folderNo = 0 ;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

/*************************************************************************************/
/* 페이징 처리를 위한 함수 */
/*************************************************************************************/
	public int getPageIndex(){
		return this.pageIndex;
	}
	public void setPageIndex(int param){
		this.pageIndex = param;
	}

	public int getFirstIndex(){
		return this.firstIndex;
	}
	public void setFirstIndex(int param){
		this.firstIndex = param;
	}

	public int getRecordCountPerPage(){
		return this.recordCountPerPage;
	}
	public void setRecordCountPerPage(int param){
		this.recordCountPerPage = param;
	}

	public String getSearchCondition(){
		return this.searchCondition;
	}
	public void setSearchCondition(String param){
		this.searchCondition = param;
	}

	public String getSearchKeyword(){
		return this.searchKeyword;
	}
	public void setSearchKeyword(String param){
		this.searchKeyword = param;
	}

	public String getSearchUseYn(){
		return this.searchUseYn;
	}
	public void setSearchUseYn(String param){
		this.searchUseYn = param;
	}

	public String getSearchStatusN(){
		return this.searchStatusN;
	}
	public void setSearchStatusN(String param){
		this.searchStatusN = param;
	}

	public String getSearchStatusY(){
		return this.searchStatusY;
	}
	public void setSearchStatusY(String param){
		this.searchStatusY = param;
	}

	public String getSearchStatusC(){
		return this.searchStatusC;
	}
	public void setSearchStatusC(String param){
		this.searchStatusC = param;
	}

	public String getSearchPublishCoAcronym(){
		return this.searchPublishCoAcronym;
	}
	public void setSearchPublishCoAcronym(String param){
		this.searchPublishCoAcronym = param;
	}

	public String getSearchTitle(){
		return this.searchTitle;
	}
	public void setSearchTitle(String param){
		this.searchTitle = param;
	}

	public String getSearchWriteUserName(){
		return this.searchWriteUserName;
	}
	public void setSearchWriteUserName(String param){
		this.searchWriteUserName = param;
	}

	public String getSearchCompanyName(){
		return this.searchCompanyName;
	}
	public void setSearchCompanyName(String param){
		this.searchCompanyName = param;
	}

	public String getSearchPrjName(){
		return this.searchPrjName;
	}
	public void setSearchPrjName(String param){
		this.searchPrjName = param;
	}

	public String getSearchPrjId(){
		return this.searchPrjId;
	}
	public void setSearchPrjId(String param){
		this.searchPrjId = param;
	}

	public String getSearchUntilToday(){
		return this.searchUntilToday;
	}
	public void setSearchUntilToday(String param){
		this.searchUntilToday = param;
	}

	public String getSearchUntilDate(){
		return this.searchUntilDate;
	}
	public void setSearchUntilDate(String param){
		this.searchUntilDate = param;
	}


/*************************************************************************************/
/* 변수값 입출력을 위한 변수 */
/*************************************************************************************/
	
	public long getNo(){
		return this.no;
	}
	public void setNo(long param){
		this.no = param;
	}
	
	// title의  기본 템플릿
	public String getTitle(){
		return this.title;
	}
	public void setTitle(String param){
		this.title = param;
	}

	// contents  기본 템플릿
	public String getContents(){
		return this.contents;
	}
	public void setContents(String param){
		this.contents = param;
	}

	// link  기본 템플릿
	public String getLink(){
		return this.link;
	}
	public void setLink(String param){
		this.link = param;
	}

	// sendUserNo  기본 템플릿
	public int getSendUserNo(){
		return this.sendUserNo;
	}
	public void setSendUserNo(int param){
		this.sendUserNo = param;
	}

	// sendDatetime  기본 템플릿
	public String getSendDatetime(){
		return this.sendDatetime;
	}
	public void setSendDatetime(String param){
		this.sendDatetime = param;
	}

	// recvUserNo  기본 템플릿
	public int getRecvUserNo(){
		return this.recvUserNo;
	}
	public void setRecvUserNo(int param){
		this.recvUserNo = param;
	}

	// recvUserNo  기본 템플릿
	public int getRead(){
		return this.read;
	}
	public void setRead(int param){
		this.read = param;
	}

	// readDatetime  기본 템플릿
	public String getReadDatetime(){
		return this.readDatetime;
	}
	public void setReadDatetime(String param){
		this.readDatetime = param;
	}

	// status  기본 템플릿
	public int getStatus(){
		return this.status;
	}
	public void setStatus(int param){
		this.status = param;
	}

	// folder  기본 템플릿
	public int getFolderNo(){
		return this.folderNo;
	}
	public void setFolderNo(int param){
		this.folderNo = param;
	}
}
