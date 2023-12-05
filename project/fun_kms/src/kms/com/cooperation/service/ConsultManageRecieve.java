package kms.com.cooperation.service;

public class ConsultManageRecieve {
	
	private Integer no;
	private Integer userNo;
	private String userNm;
	private String userId;
	private String consultNo;
	private String recieveTyp;
	private String readtime;
	private String interestYn;
	private String chargedUserIdMix;
	private String addUserIdMix;
	private String compUserIdMix;
	
	private String consult_no;
	//cno = no : jsp viewer 에서 댓글 호출하는 no 변수와 이름 겹치는 문제 해결
	private String cno;
	
	private String charged;
	private String add;
	private String comp;
	private String[] chargedUserIdList;
	private String[] addUserIdList;
	private String[] compUserIdList;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Integer getUserNo() {
		return userNo;
	}
	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getConsultNo() {
		return consultNo;
	}
	public void setConsultNo(String consultNo) {
		this.consultNo = consultNo;
	}
	public String getRecieveTyp() {
		return recieveTyp;
	}
	public String getRecieveTypPrint() {
		if (recieveTyp == null || recieveTyp.equals("")) return "";
		
		if (recieveTyp.equals("WR")) return "작성자";
		else if (recieveTyp.equals("RE")) return "담당자";
		else if (recieveTyp.equals("RF")) return "참조자";
		else if (recieveTyp.equals("CM")) return "처리자";
		else return recieveTyp;
	}
	public void setRecieveTyp(String recieveTyp) {
		this.recieveTyp = recieveTyp;
	}
	
	public String getReadtime() {
		return readtime;
	}
	public void setReadtime(String readtime) {
		this.readtime = readtime;
	}
	public String getInterestYn() {
		return interestYn;
	}
	public void setInterestYn(String interestYn) {
		this.interestYn = interestYn;
	}
	public String getCharged() {
		return charged;
	}
	public void setCharged(String charged) {
		this.charged = charged;
	}
	public String getAdd() {
		return add;
	}
	public void setAdd(String add) {
		this.add = add;
	}
	public String getComp() {
		return comp;
	}
	public void setComp(String comp) {
		this.comp = comp;
	}
	public String[] getChargedUserIdList() {
		return chargedUserIdList;
	}
	public void setChargedUserIdList(String[] chargedUserIdList) {
		this.chargedUserIdList = chargedUserIdList;
	}
	public String[] getAddUserIdList() {
		return addUserIdList;
	}
	public void setAddUserIdList(String[] addUserIdList) {
		this.addUserIdList = addUserIdList;
	}
	public String[] getCompUserIdList() {
		return compUserIdList;
	}
	public void setCompUserIdList(String[] compUserIdList) {
		this.compUserIdList = compUserIdList;
	}
	public String getConsult_no() {
		return consult_no;
	}
	public void setConsult_no(String consult_no) {
		this.consult_no = consult_no;
	}
	public String getChargedUserIdMix() {
		return chargedUserIdMix;
	}
	public void setChargedUserIdMix(String chargedUserIdMix) {
		this.chargedUserIdMix = chargedUserIdMix;
	}
	public String getAddUserIdMix() {
		return addUserIdMix;
	}
	public void setAddUserIdMix(String addUserIdMix) {
		this.addUserIdMix = addUserIdMix;
	}
	public String getCompUserIdMix() {
		return compUserIdMix;
	}
	public void setCompUserIdMix(String compUserIdMix) {
		this.compUserIdMix = compUserIdMix;
	}
	public void setCno(String cno) {
		this.cno = cno;
	}
	public String getCno() {
		return cno;
	}
	
	
	
}
