package kms.com.common.push;

import kms.com.member.service.MemberVO;

import java.util.List;

public class PushVO {
	private MemberVO senderVO;
	private List<String> rPhoneList;
	private String msg;
	private String addMsg = "";	// 데이터 절삭 후, 추가할 메세지
	private String title;
	
	public MemberVO getSenderVO() {
		return senderVO;
	}
	public void setSenderVO(MemberVO senderVO) {
		this.senderVO = senderVO;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getTitle() {
		if (title==null) title="";
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public List<String> getrPhoneList() {
		return rPhoneList;
	}
	public void setrPhoneList(List<String> rPhoneList) {
		this.rPhoneList = rPhoneList;
	}
	public String getAddMsg() {
		return addMsg;
	}
	public void setAddMsg(String addMsg) {
		this.addMsg = addMsg;
	}
}
