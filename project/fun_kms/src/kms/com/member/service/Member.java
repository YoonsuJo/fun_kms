package kms.com.member.service;

import java.util.List;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.LunarHandler;

/**
 * @Class Name : MemberVO.java
 * @Description : Member VO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2011.08.27    이병주          최초 생성
 *
 *  @author 웹개발팀 이병주
 *  @since 2011.08.27
 *  @version 1.0
 *  @see
 *  
 */
public class Member {
	private Integer no;
	private Integer[] noList;
	private String userId;
	private String userNm;
	private String userEnm;
	private String password;
	private String sabun;
	private String ihidNum;
	private String sexDstnCode;
	private String brth;
	private String greLun;
	private String homeAdres;
	private String moblphonNo;
	private String homeTelno;
	private String offmId;
	private String offmNm;
	private String offmAdres;
	private String offmTelno;
	private String offmTelnoInner;
	private String emailAdres;
	private String emailAdres2;
	private String emailLink;
	private String expCompId;
	private String expCompNm;
	private String compnyId;
	private String compnyNm;
	private String compnyNmShort;
	private String orgnztId;
	private String orgnztNm;
	private String orgnztNmFull;
	private String rankId;
	private String rankNm;
	private String position;
	private String compinDt;
	private String acceptCompinDt; //인정입사일
	private String compotDt;
	private String workSt;
	private String carId;
	private String carLicTyp;
	private String abutMe;
	private String picFileId;
	private String picFileId2;
	private String adminNote;
	private String headNm;
	private String subHeadNm;
	private String orgnztIdSec;		// 겸직부서 ID
	private String orgnztNmSec;		// 겸직부서명
	
	private String isAdmin; //시스템 관리자
	private String isDocAdmin; //전자결재문서관리
	private String isBoard; //게시판관리
	private String isLeader; //임원
	private String isTaxAdmin; //세금계산서 담당
	private String isProjectadmin; //프로젝트 관리
	private String isPrjtransferadmin; //프로젝트 이관 권한
	private String isConferenceadmin; //화상회의관리
	private String isSalaryadmin; //연봉관리
	private String isAuthadmin; //권한관리
	private String isLoginauth; //로그인 오버라이드
	private String isInputresult; //프로젝트별 인력투입 상세내역
	private String isEapp20; //종합매출보고서
	private String isEapp24; //예산승인요청서
	private String isEapp25; //사내매출보고서
	private String isEapp28; //매출이관보고서
	private String isHmdev; //한마음 개발자
	private String isNegoYn; //연봉협상 기간여부
	private String isDephead; //Department Head 부서장
	private String isDayreportuserlist; //업무일지 작성현황
	private String isEappadmin; //전자결재 관리자, 현재는 관리자 반려기능만
	private String isBpmboard;	//업무절차 게시판 관리
	private String isConsultadmin;	//상담관리 담당자
	private String isProductadmin;	//상품관리 담당자
	private String isFundAdmin;  // 주간 자금 담당자
	
	private String attendCd;
	private String attendTm;
	private Integer workMonth;
	private Integer ghost;
	private String showRight;
	private String dayReportTyp;
	private String wsTyp;
	private String macAddr;
	private String deviceType;
	private String tokenInfo;
	private String version;
	private String mode;
	
	private String isInnerNetwork;
	private String userIp;
	private String initial;
	private String carOwn;
	private String recommender;
	private String degree;
	private String promotionYear;
	private String careerMonth;
	private String age;
	private String ageKor;
	
	private String birthNo; //생일자 번호
	private String birthNm; //생일자 이름
	
	private List<EgovMap> outerNetLoginLogList;
	
	/**
	 * @return the no
	 */
	public Integer getNo() {
		return no;
	}
	public Integer getUserNo() {
		return no;
	}
	public String getStringNo() {
		return String.valueOf(no);
	}
	/**
	 * @param no the no to set
	 */
	public void setNo(Integer no) {
		this.no = no;
	}
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}
	
	public String getUserNmLong() {
		int size = userNm.length();
		String temp = "";
		for(int i=0; i<size; i++){
			if(userNm.substring(i, i+1).equals("A") == false){ //동명이인 구분 A 문자 제외
				temp += userNm.substring(i, i+1) + " ";
			}
		}
		return temp;
	}
	/**
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * @return the userEnm
	 */
	public String getUserEnm() {
		return userEnm;
	}
	/**
	 * @param userEnm the userEnm to set
	 */
	public void setUserEnm(String userEnm) {
		this.userEnm = userEnm;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the sabun
	 */
	public String getSabun() {
		return sabun;
	}
	/**
	 * @param sabun the sabun to set
	 */
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}
	/**
	 * @return the ihidNum
	 */
	public String getIhidNum() {
		return ihidNum;
	}
	public String getIhidNumFront() {
		if (ihidNum == null || ihidNum.length() < 13) {
			return "";
		}
		else return ihidNum.substring(0,6);
	}
	public String getIhidNumBack() {
		if (ihidNum == null || ihidNum.length() < 13) {
			return "";
		}
		else return ihidNum.substring(6,13);
	}
	public String getIhidNumPrint() {
		return getIhidNumFront() + "-*******";
	}
	/**
	 * @param ihidNum the ihidNum to set
	 */
	public void setIhidNum(String ihidNum) {
		this.ihidNum = ihidNum;
	}
	/**
	 * @return the sexDstnCode
	 */
	public String getSexDstnCode() {
		return sexDstnCode;
	}
	/**
	 * @param sexDstnCode the sexDstnCode to set
	 */
	public void setSexDstnCode(String sexDstnCode) {
		this.sexDstnCode = sexDstnCode;
	}
	/**
	 * @return the brth
	 */
	public String getBrthDb() {
		//if (getGreLun().equals("L")) {
		//	LunarHandler lunarHandler = new LunarHandler();
		//	String greBrth = lunarHandler.getLunarDateStr(brth, 2, 0);
		//	return greBrth;
		//} else {
			return brth;
		//}
	}
	public String getBrth() {
		if (brth == null || brth.length() < 8) {
			return "";
		}
		String birth = brth;
		//if (getGreLun().equals("L")) {
		//	LunarHandler lunarHandler = new LunarHandler();
		//	birth = lunarHandler.getLunarDateStr(brth, 1, 0);
		//}
		return birth;
	}
	public String getBrthPrint() {
		if (brth == null || brth.length() < 8) {
			return "";
		}
		String birth = brth;
		//if (getGreLun().equals("L")) {
		//	LunarHandler lunarHandler = new LunarHandler();
		//	birth = lunarHandler.getLunarDateStr(brth, 1, 0);
		//}
		return birth.substring(0,4) + "." + birth.substring(4,6) + "." + birth.substring(6,8);
	}
	public String getBrthMainPrint() {
		if (brth == null || brth.length() < 8) {
			return "";
		}
		String birth = brth;
		String gl = "양력";
		if (getGreLun().equals("L")) {
		//	LunarHandler lunarHandler = new LunarHandler();
			gl = "음력";
		//	birth = lunarHandler.getLunarDateStr(brth, 1, 0);
		}
		return birth.substring(4,6) + "월 " + birth.substring(6,8) + "일 (" + gl + ")";
	}
	public String getBrthMainPrintShort() {
		if (brth == null || brth.length() < 8) {
			return "";
		}
		String birth = brth;
		String lun = "";
		if (getGreLun().equals("L")) {
		//	LunarHandler lunarHandler = new LunarHandler();
			lun = "(음)";
		//	birth = lunarHandler.getLunarDateStr(brth, 1, 0);
		}
		return birth.substring(4,6) + "월" + birth.substring(6,8) + "일" + lun;
	}
	public String getBrthMainPrintLong() {
		if (brth == null || brth.length() < 8) {
			return "";
		}
		String birth = brth;
		String gl = "양력";
		if (getGreLun().equals("L")) {
		//	LunarHandler lunarHandler = new LunarHandler();
			gl = "음력";
		//	birth = lunarHandler.getLunarDateStr(brth, 1, 0);
		}
		return birth.substring(0,4) + "년 " + birth.substring(4,6) + "월 " + birth.substring(6,8) + "일 (" + gl + ")";
	}
	/**
	 * @param brth the brth to set
	 */
	public void setBrth(String brth) {
		this.brth = brth;
	}
	/**
	 * @return the greLun
	 */
	public String getGreLun() {
		if (greLun == null || greLun.equals("")) return "G";
		else return greLun;
	}
	public String getGreLunPrint() {
		if (getGreLun().equals("L")) {
			return "음력";
		}
		else { // greLun.equals("G")
			return "양력";
		}
	}
	/**
	 * @param greLun the greLun to set
	 */
	public void setGreLun(String greLun) {
		this.greLun = greLun;
	}
	/**
	 * @return the homeAdres
	 */
	public String getHomeAdres() {
		return homeAdres;
	}
	/**
	 * @param homeAdres the homeAdres to set
	 */
	public void setHomeAdres(String homeAdres) {
		this.homeAdres = homeAdres;
	}
	/**
	 * @return the moblphonNo
	 */
	public String getMoblphonNo() {
		return moblphonNo;
	}
	public String getMoblphonNoSmsTyp() {
		if (moblphonNo == null) return "";
		
		return moblphonNo.replace("-", "").replace(" ", "");
	}
	/**
	 * @param moblphonNo the moblphonNo to set
	 */
	public void setMoblphonNo(String moblphonNo) {
		this.moblphonNo = moblphonNo;
	}
	/**
	 * @return the homeTelno
	 */
	public String getHomeTelno() {
		return homeTelno;
	}
	/**
	 * @param homeTelno the homeTelno to set
	 */
	public void setHomeTelno(String homeTelno) {
		this.homeTelno = homeTelno;
	}
	/**
	 * @return the offmAdres
	 */
	public String getOffmId() {
		return offmId;
	}
	/**
	 * @param offmAdres the offmAdres to set
	 */
	public void setOffmId(String offmId) {
		this.offmId = offmId;
	}
	/**
	 * @return the offmNm
	 */
	public String getOffmNm() {
		return offmNm;
	}
	/**
	 * @param offmNm the offmNm to set
	 */
	public void setOffmNm(String offmNm) {
		this.offmNm = offmNm;
	}
	/**
	 * @return the offmAdres
	 */
	public String getOffmAdres() {
		return offmAdres;
	}
	/**
	 * @param offmAdres the offmAdres to set
	 */
	public void setOffmAdres(String offmAdres) {
		this.offmAdres = offmAdres;
	}
	/**
	 * @return the offmTelno
	 */
	public String getOffmTelno() {
		return offmTelno;
	}
	/**
	 * @param offmTelno the offmTelno to set
	 */
	public void setOffmTelno(String offmTelno) {
		this.offmTelno = offmTelno;
	}
	/**
	 * @return the offmTelnoInner
	 */
	public String getOffmTelnoInner() {
		return offmTelnoInner;
	}
	/**
	 * @param offmTelnoInner the offmTelnoInner to set
	 */
	public void setOffmTelnoInner(String offmTelnoInner) {
		this.offmTelnoInner = offmTelnoInner;
	}
	/**
	 * @return the emailAdres
	 */
	public String getEmailAdres() {
		return emailAdres;
	}
	/**
	 * @param emailAdres the emailAdres to set
	 */
	public void setEmailAdres(String emailAdres) {
		this.emailAdres = emailAdres;
	}
	/**
	 * @return the emailAdres2
	 */
	public String getEmailAdres2() {
		return emailAdres2;
	}
	/**
	 * @param emailAdres2 the emailAdres2 to set
	 */
	public void setEmailAdres2(String emailAdres2) {
		this.emailAdres2 = emailAdres2;
	}
	
	
	/* 2013.07.24 김대현 웹메일 주소 */
	/**
	 * @return the emailLink
	 */
	public String getEmailLink() {
		return emailLink;
	}
	/**
	 * @param emailLink the emailLink to set
	 */
	public void setEmailLink(String emailLink) {
		this.emailLink = emailLink;
	}
	
	/**
	 * @return the expCompId
	 */
	public String getExpCompId() {
		return expCompId;
	}
	/**
	 * @param expCompId the expCompId to set
	 */
	public void setExpCompId(String expCompId) {
		this.expCompId = expCompId;
	}
	/**
	 * @return the expCompNm
	 */
	public String getExpCompNm() {
		return expCompNm;
	}
	/**
	 * @param expCompNm the expCompNm to set
	 */
	public void setExpCompNm(String expCompNm) {
		this.expCompNm = expCompNm;
	}
	/**
	 * @return the compnyId
	 */
	public String getCompnyId() {
		return compnyId;
	}
	/**
	 * @param compnyId the compnyId to set
	 */
	public void setCompnyId(String compnyId) {
		this.compnyId = compnyId;
	}
	/**
	 * @return the compnyNm
	 */
	public String getCompnyNm() {
		return compnyNm;
	}
	/**
	 * @param compnyNm the compnyNm to set
	 */
	public void setCompnyNm(String compnyNm) {
		this.compnyNm = compnyNm;
	}
	/**
	 * @return the compnyNmShort
	 */
	public String getCompnyNmShort() {
		return compnyNmShort;
	}
	/**
	 * @param compnyNmShort the compnyNmShort to set
	 */
	public void setCompnyNmShort(String compnyNmShort) {
		this.compnyNmShort = compnyNmShort;
	}
	/**
	 * @return the orgnztId
	 */
	public String getOrgnztId() {
		return orgnztId;
	}
	/**
	 * @param orgnztId the orgnztId to set
	 */
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	/**
	 * @return the orgnztNm
	 */
	public String getOrgnztNm() {
		return orgnztNm;
	}
	/**
	 * @param orgnztNm the orgnztNm to set
	 */
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	/**
	 * @return the orgnztNmFull
	 */
	public String getOrgnztNmFull() {
		return orgnztNmFull;
	}
	public String getOrgnztNmFullLong() {
		String s = orgnztNmFull.substring(0, orgnztNmFull.length()-1).replace(" ", " > ");
		return s;
	}
	/**
	 * @param orgnztNmFull the orgnztNmFull to set
	 */
	public void setOrgnztNmFull(String orgnztNmFull) {
		this.orgnztNmFull = orgnztNmFull;
	}
	/**
	 * @return the rankId
	 */
	public String getRankId() {
		return rankId;
	}
	/**
	 * @param rankId the rankId to set
	 */
	public void setRankId(String rankId) {
		this.rankId = rankId;
	}
	/**
	 * @return the position
	 */
	public String getPosition() {
		if (position == null || position.equals("")) 
			return "N";
		else 
			return position;
	}
	public String getPositionPrint() {
		if (getPosition().equals("H")) {
			return headNm;
		} else if (getPosition().equals("S")) {
			return subHeadNm;
		} else if (getPosition().equals("D")) {
			return "대표";
		} else if (getPosition().equals("N")) {
			return "-";
		}
		else return position;
	}
	/**
	 * @param position the position to set
	 */
	public void setPosition(String position) {
		this.position = position;
	}
	/**
	 * @return the compinDt
	 */
	public String getCompinDt() {
		return compinDt;
	}
	public String getCompinDtPrint() {
		if (compinDt == null || compinDt.length() < 8) {
			return "";
		}
		return CommonUtil.getDateType(compinDt);
	}
	/**
	 * @param compinDt the compinDt to set
	 */
	public void setCompinDt(String compinDt) {
		this.compinDt = compinDt;
	}
	/**
	 * @return the compotDt
	 */
	public String getCompotDt() {
		return compotDt;
	}
	public String getCompotDtPrint() {
		if (compotDt == null || compotDt.length() < 8) {
			return "";
		}
		return CommonUtil.getDateType(compotDt);
	}
	/**
	 * @param compotDt the compotDt to set
	 */
	public void setCompotDt(String compotDt) {
		this.compotDt = compotDt;
	}
	/**
	 * @return the workSt
	 */
	public String getWorkSt() {
		return workSt;
	}
	public String[] getWorkStArray() {
		String tmp = workSt == null ? "W,L" : workSt;
		return tmp.split(",");
	}
	public String getWorkStPrint() {
		String ws = workSt;
		if (ws == null || ws.equals("")) ws = "W";
		
		if (ws.equals("L")) {
			return "휴직";
		}
		else if (ws.equals("R")) {
			return "퇴직";
		}
		else if (ws.equals("W")) {
			return "근무";
		}
		else return workSt;
	}
	/**
	 * @param workSt the workSt to set
	 */
	public void setWorkSt(String workSt) {
		this.workSt = workSt;
	}
	/**
	 * @return the carId
	 */
	public String getCarId() {
		return carId;
	}
	/**
	 * @param carId the carId to set
	 */
	public void setCarId(String carId) {
		this.carId = carId;
	}
	/**
	 * @return the carLicTyp
	 */
	public String getCarLicTyp() {
		return carLicTyp;
	}
	public String getCarLicTypPrint() {
		if (carLicTyp == null || carLicTyp.equals("")) 
			return "면허없음";
		
		if (carLicTyp.equals("A")) return "1종대형";
		else if (carLicTyp.equals("B")) return "1종보통";
		else if (carLicTyp.equals("C")) return "2종보통";
		else if (carLicTyp.equals("D")) return "2종소형";
		else if (carLicTyp.equals("E")) return "원동기장치";
		
		else return carLicTyp;
	}
	/**
	 * @param carLicTyp the carLicTyp to set
	 */
	public void setCarLicTyp(String carLicTyp) {
		this.carLicTyp = carLicTyp;
	}
	/**
	 * @return the abutMe
	 */
	public String getAbutMe() {
		if (abutMe == null) return "";
		else return abutMe;
	}
	public String getAbutMePrint() {
		return getAbutMe().replace("\r\n", "<br/>");
	}
	/**
	 * @param abutMe the abutMe to set
	 */
	public void setAbutMe(String abutMe) {
		this.abutMe = abutMe;
	}
	/**
	 * @return the picFileId
	 */
	public String getPicFileId() {
		return picFileId;
	}
	/**
	 * @param picFileId the picFileId to set
	 */
	public void setPicFileId(String picFileId) {
		this.picFileId = picFileId;
	}
	/**
	 * @return the picFileId2
	 */
	public String getPicFileId2() {
		return picFileId2;
	}
	/**
	 * @param picFileId2 the picFileId2 to set
	 */
	public void setPicFileId2(String picFileId2) {
		this.picFileId2 = picFileId2;
	}
	/**
	 * @return the adminNote
	 */
	public String getAdminNote() {
		return adminNote;
	}
	/**
	 * @param adminNote the adminNote to set
	 */
	public void setAdminNote(String adminNote) {
		this.adminNote = adminNote;
	}
	/**
	 * @return the rankNm
	 */
	public String getRankNm() {
		return rankNm;
	}
	/**
	 * @param rankNm the rankNm to set
	 */
	public void setRankNm(String rankNm) {
		this.rankNm = rankNm;
	}
	/**
	 * @return the headNm
	 */
	public String getHeadNm() {
		return headNm;
	}
	/**
	 * @param headNm the headNm to set
	 */
	public void setHeadNm(String headNm) {
		this.headNm = headNm;
	}
	/**
	 * @return the subHeadNm
	 */
	public String getSubHeadNm() {
		return subHeadNm;
	}
	/**
	 * @param subHeadNm the subHeadNm to set
	 */
	public void setSubHeadNm(String subHeadNm) {
		this.subHeadNm = subHeadNm;
	}
	/**
	 * @return the attendCd
	 */
	public String getAttendCd() {
		return attendCd;
	}
	public String getAttendCdPrint() {
		if (attendCd == null) return ""; // 미로그인
		
		if (attendCd.equalsIgnoreCase("AT")) return "(출근)";
		else if (attendCd.equalsIgnoreCase("EA")) return "(조출)";
		else if (attendCd.equalsIgnoreCase("NT")) return "(야근)";
		else if (attendCd.equalsIgnoreCase("OT")) return "(외근)";
		else if (attendCd.equalsIgnoreCase("TR")) return "(출장)";
		else if (attendCd.equalsIgnoreCase("SD")) return "(파견)";
		else if (attendCd.equalsIgnoreCase("EN")) return "(입사)"; // 신규입사
		else if (attendCd.equalsIgnoreCase("LT")) return "(지각)";
		else if (attendCd.equalsIgnoreCase("VC")) return "(휴가)";
		else if (attendCd.equalsIgnoreCase("ET")) return "(면제)"; // 면제
		else if (attendCd.equalsIgnoreCase("HD")) return "(특근)"; // 주말근무
		else if (attendCd.equalsIgnoreCase("LD")) return "(임원)"; // 임원부재코드
		else return ""; // (" + attendCd + ")
	}	
	
	public String getAttendCdPrintSimple() {
		if (attendCd == null) return ""; // 미로그인
		
		if (attendCd.equalsIgnoreCase("AT")) return "출근";
		else if (attendCd.equalsIgnoreCase("EA")) return "조출";
		else if (attendCd.equalsIgnoreCase("NT")) return "야근";
		else if (attendCd.equalsIgnoreCase("OT")) return "외근";
		else if (attendCd.equalsIgnoreCase("TR")) return "출장";
		else if (attendCd.equalsIgnoreCase("SD")) return "파견";
		else if (attendCd.equalsIgnoreCase("EN")) return "입사"; // 신규입사
		else if (attendCd.equalsIgnoreCase("LT")) return "지각";
		else if (attendCd.equalsIgnoreCase("VC")) return "휴가";
		else if (attendCd.equalsIgnoreCase("ET")) return "면제"; // 면제
		else if (attendCd.equalsIgnoreCase("HD")) return "특근"; // 주말근무
		else if (attendCd.equalsIgnoreCase("LD")) return "임원"; // 임원부재코드
		else return ""; // (" + attendCd + ")
	}
	
	public String getAttendCdPrintSlash() {
		if (attendCd == null) return ""; // 미로그인
		String sPrefix = "/";
		
		if (attendCd.equalsIgnoreCase("AT")) return sPrefix + "출근";
		else if (attendCd.equalsIgnoreCase("EA")) return sPrefix + "조출";
		else if (attendCd.equalsIgnoreCase("NT")) return sPrefix + "야근";
		else if (attendCd.equalsIgnoreCase("OT")) return sPrefix + "외근";
		else if (attendCd.equalsIgnoreCase("TR")) return sPrefix + "출장";
		else if (attendCd.equalsIgnoreCase("SD")) return sPrefix + "파견";
		else if (attendCd.equalsIgnoreCase("EN")) return sPrefix + "입사"; // 신규입사
		else if (attendCd.equalsIgnoreCase("LT")) return sPrefix + "지각";
		else if (attendCd.equalsIgnoreCase("VC")) return sPrefix + "휴가";
		else if (attendCd.equalsIgnoreCase("ET")) return sPrefix + "면제"; // 면제
		else if (attendCd.equalsIgnoreCase("HD")) return sPrefix + "특근"; // 주말근무
		else return ""; // (" + attendCd + ")
	}	
	
	public String getIsInnerNetworkPrint(){		
		if (isInnerNetwork == null) return "";
		
		if(isInnerNetwork.equals("Y")) return "본사";
		else if(isInnerNetwork.equals("N")) return "외부";
		else return "";		
	}
	
	public String getIsInnerNetworkPrint2(){		
		if (isInnerNetwork == null) return "";
		
		if(isInnerNetwork.equals("Y")) return "본사등록";
		else if(isInnerNetwork.equals("N")) return "외부등록";
		else return "";		
	}
	
	/**
	 * @param attendCd the attendCd to set
	 */
	public void setAttendCd(String attendCd) {
		this.attendCd = attendCd;
	}
	/**
	 * @return the attendTm
	 */
	public String getAttendTm() {
		return attendTm;
	}	
	public String getAttendTmShort() {
		if(attendTm != null)
			return attendTm.substring(0, 5);
		return attendTm;
	}
	/**
	 * @param attendTm the attendTm to set
	 */
	public void setAttendTm(String attendTm) {
		this.attendTm = attendTm;
	}
	/** 
	 * 재직기간(휴직~복귀, 퇴직~복귀 사이 부재기간 제외)
	 * @return the workMonth
	 */
	public Integer getWorkMonth() {
		if (workMonth == null) return 0;
		else return workMonth;
	}
	public String getWorkMonthPrint() {
		return (getWorkMonth() / 12) + "년 " + (getWorkMonth() % 12) + "개월";
	}
	// 입사시 이전 인정경력
	public void setCareerMonth(String careerMonth) {
		this.careerMonth = careerMonth;
	}
	public String getCareerMonth() {
		return careerMonth;
	}
	public int getCareerMonthInt() {
		if(careerMonth != null && careerMonth.equals("") == false)
			return Integer.parseInt(careerMonth);
		return 0;
	}
	public String getCareerMonthPrint() {
		int carrerMonth = getCareerMonthInt();
		return (carrerMonth / 12) + "년 " + (carrerMonth % 12) + "개월";
	}
	public String getCareerMonthPrintYear() {
		int carrerMonth = getCareerMonthInt();
		return (carrerMonth / 12) + "";
	}
	public String getCareerMonthPrintMonth() {
		int carrerMonth = getCareerMonthInt();
		return (carrerMonth % 12) + "";
	}
	public String getWorkPeriodPrint(){
		int workMonth = getWorkMonth() + getCareerMonthInt();		
		return (workMonth / 12) + "년 " + (workMonth % 12) + "개월";
	}
	
	public String getAgePrint(){
		int age = Integer.parseInt(getAge());
		int ageKor = Integer.parseInt(getAgeKor());
		String result = "만 " + age + "세 (" + ageKor + "세)";
		if(age>100 || ageKor>100 || age<4 || ageKor<4){
			result = "입력오류";
		}			
				
		return result; 
	}
	/**
	 * @param workMonth the workMonth to set
	 */
	public void setWorkMonth(Integer workMonth) {
		this.workMonth = workMonth;
	}
	/**
	 * @return the ghost
	 */
	public boolean isGhost() {
		return 1 == ghost.intValue();
	}
	/**
	 * @param ghost the ghost to set
	 */
	public void setGhost(Integer ghost) {
		this.ghost = ghost;
	}
	/**
	 * @return the showRight
	 */
	public String getShowRightValue() {
		return showRight;
	}
	public boolean isShowRight() {
		return "1".equals(showRight);
	}
	/**
	 * @param showRight the showRight to set
	 */
	public void setShowRight(String showRight) {
		this.showRight = showRight;
	}
	/**
	 * @return the dayReportTyp
	 */
	public String getDayReportTyp() {
		return dayReportTyp;
	}
	public boolean isBriefDayReportTyp() {
		return "B".equalsIgnoreCase(dayReportTyp);
	}
	public boolean isDetailDayReportTyp() {
		return "D".equalsIgnoreCase(dayReportTyp);
	}
	/**
	 * @param dayReportTyp the dayReportTyp to set
	 */
	public void setDayReportTyp(String dayReportTyp) {
		this.dayReportTyp = dayReportTyp;
	}
	

	/**
	 * @return the isAdmin
	 */
	public String getIsAdmin() {
		return isAdmin;
	}
	public boolean isAdmin() {
		return (getIsAdmin() != null && getIsAdmin().equals("Y"));
	}
	/**
	 * @param isAdmin the isAdmin to set
	 */
	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}
	
	/**
	 * @return the isDocAdmin
	 */
	public String getIsDocAdmin() {
		return isDocAdmin;
	}
	public boolean isDocAdmin() {
		return (getIsDocAdmin() != null && getIsDocAdmin().equals("Y"));
	}
	/**
	 * @param isAdmin the isAdmin to set
	 */
	public void setIsDocAdmin(String isDocAdmin) {
		this.isDocAdmin = isDocAdmin;
	}
		
	public String getIsTaxAdmin() {
		return isTaxAdmin;
	}
	public boolean isTaxAdmin() {
		return (getIsTaxAdmin() != null && getIsTaxAdmin().equals("Y"));
	}
	public void setIsTaxAdmin(String isTaxAdmin) {
		this.isTaxAdmin = isTaxAdmin;
	}
		
	/**
	 * @return the isBoard
	 */
	public String getIsBoard() {
		return isBoard;
	}
	public boolean isBoard() {
		return (getIsBoard() != null && getIsBoard().equals("Y"));
	}
	/**
	 * @param isBoard the isBoard to set
	 */
	public void setIsBoard(String isBoard) {
		this.isBoard = isBoard;
	}
	/**
	 * @return the isLeader
	 */
	public String getIsLeader() {
		return isLeader;
	}
	public boolean isLeader() {
		return (getIsLeader() != null && getIsLeader().equals("Y"));
	}
	/**
	 * @param isLeader the isLeader to set
	 */
	public void setIsLeader(String isLeader) {
		this.isLeader = isLeader;
	}
	public void setWsTyp(String wsTyp) {
		this.wsTyp = wsTyp;
	}
	public String getWsTyp() {
		return wsTyp;
	}
	public void setMacAddr(String macAddr) {
		this.macAddr = macAddr;
	}
	public String getMacAddr() {
		return macAddr;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
	public String getDeviceType() {
		return deviceType;
	}
	public void setTokenInfo(String tokenInfo) {
		this.tokenInfo = tokenInfo;
	}
	public String getTokenInfo() {
		return tokenInfo;
	}
	
	
	/*	이력관리 변수	*/
	private String schoolName; //이력관리 출신학교이름
	private String major; //이력관리 학교전공
	private String stDt; //이력관리 데이터 시작일
	private String edDt; //이력관리 데이터 종료일
	private String graduationYn; //이력관리 졸업여부
	private String licenseNm; //이력관리 자격증 종목 및 등급 이
	private String issuedOrg; //이력관리 자격증 발급기관
	private String licenseNo; //이력관리 자격등록번호
	private String passedDate; //이력관리 자격증합격년원일
	private String careerDt; //이력관리 경력시작일
	private String militaryService; //이력관리 병역 종류
	private String msStDt; //이력관리 병역시작일
	private String msEdDt; //이력관리 병역종료일
	private String msLevel; //이력관리 전역계급
	private String securityBasis; //이력관리 비밀취급인가근거
	private String securityNo; //이력관리 비밀취급번호
	private String swLevel; //이력관리 SW기술등급
	private String deleteYn; //이력관리 삭제여부
	private String upDt; //이력관리 UPDATE DATE
	private String atchFileId; //이력관리 첨부파일
	private String prjNm; //이력관리 참여사업 이름
	private String task; //이력관리 참여사업 담당업무
	private String clientNm; //이력관리 참여사업 발주처
	private String note; //이력관리 비고
	private String trainNm; //이력관리 교육 과정이름
	private String trainOrgNm; //이력관리 교육 기관이름
	private String trainNo; //이력관리 교육 수료번호
	private String companyNm; //이력관리 직장이름
	private String skillLang; //이력관리 기본정보 기술 - 개발언어
	private String skillDbms; //이력관리 기본정보 기술 - Dbms
	private String skillTool; //이력관리 기본정보 기술 - Tool
	private String skillOs; //이력관리 기본정보 기술 - Os
	private String jsonEducationString; //jsonString 입력 from JSP
	private String jsonTrainString;
	private String jsonLicenseString;
	private String jsonWorkString;
	private String jsonSkillString;
		
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getGraduationYn() {
		return graduationYn;
	}
	public void setGraduationYn(String graduationYn) {
		this.graduationYn = graduationYn;
	}
	public String getSwLevel() {
		return swLevel;
	}
	public void setSwLevel(String swLevel) {
		this.swLevel = swLevel;
	}	
	public String getUpdt() {
		return upDt;
	}
	public void setUpdt(String upDt) {
		this.upDt = upDt;
	}
	public String getMilitaryService() {
		return militaryService;
	}
	public void setMilitaryService(String militaryService) {
		this.militaryService = militaryService;
	}
	public String getMsStDt() {
		return msStDt;
	}
	public void setMsStDt(String msStDt) {
		this.msStDt = msStDt;
	}
	public String getMsEdDt() {
		return msEdDt;
	}
	public void setMsEdDt(String msEdDt) {
		this.msEdDt = msEdDt;
	}
	public String getMsLevel() {
		return msLevel;
	}
	public void setMsLevel(String msLevel) {
		this.msLevel = msLevel;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setStDt(String stDt) {
		this.stDt = stDt;
	}
	public String getStDt() {
		return stDt;
	}
	public void setEdDt(String edDt) {
		this.edDt = edDt;
	}
	public String getEdDt() {
		return edDt;
	}
	public void setLicenseNm(String licenseNm) {
		this.licenseNm = licenseNm;
	}
	public String getLicenseNm() {
		return licenseNm;
	}
	public void setIssuedOrg(String issuedOrg) {
		this.issuedOrg = issuedOrg;
	}
	public String getIssuedOrg() {
		return issuedOrg;
	}
	public void setLicenseNo(String licenseNo) {
		this.licenseNo = licenseNo;
	}
	public String getLicenseNo() {
		return licenseNo;
	}
	public void setPassedDate(String passedDate) {
		this.passedDate = passedDate;
	}
	public String getPassedDate() {
		return passedDate;
	}
	public void setCareerDt(String careerDt) {
		this.careerDt = careerDt;
	}
	public String getCareerDt() {
		return careerDt;
	}
	public void setSecurityBasis(String securityBasis) {
		this.securityBasis = securityBasis;
	}
	public String getSecurityBasis() {
		return securityBasis;
	}
	public void setSecurityNo(String securityNo) {
		this.securityNo = securityNo;
	}
	public String getSecurityNo() {
		return securityNo;
	}
	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}
	public String getDeleteYn() {
		return deleteYn;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setTask(String task) {
		this.task = task;
	}
	public String getTask() {
		return task;
	}
	public void setClientNm(String clientNm) {
		this.clientNm = clientNm;
	}
	public String getClientNm() {
		return clientNm;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getNote() {
		return note;
	}
	public void setTrainNm(String trainNm) {
		this.trainNm = trainNm;
	}
	public String getTrainNm() {
		return trainNm;
	}
	public void setTrainOrgNm(String trainOrgNm) {
		this.trainOrgNm = trainOrgNm;
	}
	public String getTrainOrgNm() {
		return trainOrgNm;
	}
	public void setTrainNo(String trainNo) {
		this.trainNo = trainNo;
	}
	public String getTrainNo() {
		return trainNo;
	}
	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}
	public String getCompanyNm() {
		return companyNm;
	}
	public void setSkillLang(String skillLang) {
		this.skillLang = skillLang;
	}
	public String getSkillLang() {
		return skillLang;
	}
	public void setSkillDbms(String skillDbms) {
		this.skillDbms = skillDbms;
	}
	public String getSkillDbms() {
		return skillDbms;
	}
	public void setSkillTool(String skillTool) {
		this.skillTool = skillTool;
	}
	public String getSkillTool() {
		return skillTool;
	}
	public void setSkillOs(String skillOs) {
		this.skillOs = skillOs;
	}
	public String getSkillOS() {
		return skillOs;
	}
	
	public void setIsProjectadmin(String isProjectadmin) {
		this.isProjectadmin = isProjectadmin;
	}
	public String getIsProjectadmin() {
		return isProjectadmin;
	}
	public boolean isProjectadmin() {
		return (getIsProjectadmin() != null && getIsProjectadmin().equals("Y"));
	}
	public void setIsConferenceadmin(String isConferenceadmin) {
		this.isConferenceadmin = isConferenceadmin;
	}
	public String getIsConferenceadmin() {
		return isConferenceadmin;
	}
	public boolean isConferenceadmin() {
		return (getIsConferenceadmin() != null && getIsConferenceadmin().equals("Y"));
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getVersion() {
		return version;
	}
	
	//박기현A 사원 작업
	public void setIsInnerNetwork(String isInnerNetwork) {
		this.isInnerNetwork = isInnerNetwork;
	}
	public String getIsInnerNetwork() {
		return isInnerNetwork;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setInitial(String initial) {
		this.initial = initial;
	}
	public String getInitial() {
		return initial;
	}
	public void setCarOwn(String carOwn) {
		this.carOwn = carOwn;
	}
	public String getCarOwn() {
		return carOwn;
	}
	public String getCarOwnPrint() {
		String co = carOwn;
		if (co == null || co.equals("")) 
			co = "";
		
		if (co.equals("N"))	return "비소유";
		else if (co.equals("Y")) return "소유";
		else return "미입력";
		//else return carOwn;
	}
	public void setRecommender(String recommender) {
		this.recommender = recommender;
	}
	public String getRecommender() {
		return recommender;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getDegree() {
		return degree;
	}
	public String getDegreePrint() {
		String dg = degree;
		if (dg == null || dg.equals("")) 
			dg = "00";
		
		if (dg.equals("01")) return "고졸";
		else if (dg.equals("02")) return "전문대재학";
		else if (dg.equals("03")) return "전문대졸업";
		else if (dg.equals("04")) return "전문대중퇴";
		else if (dg.equals("05")) return "대학재학";
		else if (dg.equals("06")) return "대학졸업";
		else if (dg.equals("07")) return "대학수료";
		else if (dg.equals("08")) return "대학중퇴";
		else if (dg.equals("09")) return "석사재학";
		else if (dg.equals("10")) return "석사졸업";
		else if (dg.equals("11")) return "석사수료";
		else if (dg.equals("12")) return "석사중퇴";
		else if (dg.equals("13")) return "박사재학";
		else if (dg.equals("14")) return "박사졸업";
		else if (dg.equals("15")) return "박사수료";
		else if (dg.equals("16")) return "박사중퇴";
		else return "잘못된코드";
	}

	public void setPromotionYear(String promotionYear) {
		this.promotionYear = promotionYear;
	}
	public String getPromotionYear() {
		return promotionYear;
	}
	public int getPromotionYearInt() {
		if(promotionYear != null && promotionYear.equals("") == false)
			return Integer.parseInt(promotionYear);
		return 0;
	}
	public String getPromotionPeriodPrint(){
		int year = CalendarUtil.getYear()- getPromotionYearInt() + 1;		
		return year + "년차";
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public void setAgeKor(String ageKor) {
		this.ageKor = ageKor;
	}
	public String getAgeKor() {
		return ageKor;
	}
	public void setIsNegoYn(String isNegoYn) {
		this.isNegoYn = isNegoYn;
	}
	public String getIsNegoYn() {
		return isNegoYn;
	}
		
	public void setIsSalaryadmin(String isSalaryadmin) {
		this.isSalaryadmin = isSalaryadmin;
	}
	public String getIsSalaryadmin() {
		return isSalaryadmin;
	}
	public boolean isSalaryadmin() {
		return (getIsSalaryadmin() != null && getIsSalaryadmin().equals("Y"));
	}
	public void setIsAuthadmin(String isAuthadmin) {
		this.isAuthadmin = isAuthadmin;
	}
	public String getIsAuthadmin() {
		return isAuthadmin;
	}
	public boolean isAuthadmin() {
		return (getIsAuthadmin() != null && getIsAuthadmin().equals("Y"));
	}
	public void setIsLoginauth(String isLoginauth) {
		this.isLoginauth = isLoginauth;
	}
	public String getIsLoginauth() {
		return isLoginauth;
	}
	public boolean isLoginauth() {
		return (getIsLoginauth() != null && getIsLoginauth().equals("Y"));
	}
	public void setIsInputresult(String isInputresult) {
		this.isInputresult = isInputresult;
	}
	public String getIsInputresult() {
		return isInputresult;
	}
	public boolean isInputresult() {
		return (getIsInputresult() != null && getIsInputresult().equals("Y"));
	}
	public void setIsEapp20(String isEapp20) {
		this.isEapp20 = isEapp20;
	}
	public String getIsEapp20() {
		return isEapp20;
	}
	public boolean isEapp20() {
		return (getIsEapp20() != null && getIsEapp20().equals("Y"));
	}
	public void setIsEapp24(String isEapp24) {
		this.isEapp24 = isEapp24;
	}
	public String getIsEapp24() {
		return isEapp24;
	}
	public boolean isEapp24() {
		return (getIsEapp24() != null && getIsEapp24().equals("Y"));
	}
	public void setIsEapp25(String isEapp25) {
		this.isEapp25 = isEapp25;
	}
	public String getIsEapp25() {
		return isEapp25;
	}
	public boolean isEapp25() {
		return (getIsEapp25() != null && getIsEapp25().equals("Y"));
	}
	public void setIsHmdev(String isHmdev) {
		this.isHmdev = isHmdev;
	}
	public String getIsHmdev() {
		return isHmdev;
	}
	public boolean isHmdev() {
		return (getIsHmdev() != null && getIsHmdev().equals("Y"));
	}
	public void setIsDephead(String isDephead) {
		this.isDephead = isDephead;
	}
	public String getIsDephead() { 
		return isDephead;
	}
	public boolean isDephead() {
		return (getIsDephead() != null && getIsDephead().equals("Y"));
	}
	public void setIsDayreportuserlist(String isDayreportuserlist) {
		this.isDayreportuserlist = isDayreportuserlist;
	}
	public String getIsDayreportuserlist() {
		return isDayreportuserlist;
	}
	public boolean isDayreportuserlist() {
		return (getIsDayreportuserlist() != null && getIsDayreportuserlist().equals("Y"));
	}
	public void setBirthNo(String birthNo) {
		this.birthNo = birthNo;
	}
	public String getBirthNo() {
		return birthNo;
	}
	public void setBirthNm(String birthNm) {
		this.birthNm = birthNm;
	}
	public String getBirthNm() {
		return birthNm;
	}
	public void setIsEappadmin(String isEappadmin) {
		this.isEappadmin = isEappadmin;
	}
	public String getIsEappadmin() {
		return isEappadmin;
	}
	public boolean isEappadmin() {
		return (getIsEappadmin() != null && getIsEappadmin().equals("Y"));
	}
	public String getIsBpmboard() {
		return isBpmboard;
	}
	public void setIsBpmboard(String isBpmboard) {
		this.isBpmboard = isBpmboard;
	}
	public boolean isBpmboard() {
		return (getIsBpmboard() != null && getIsBpmboard().equals("Y"));
	}
	public Integer getGhost() {
		return ghost;
	}
	public String getShowRight() {
		return showRight;
	}
	public void setJsonEducationString(String jsonEducationString) {
		this.jsonEducationString = jsonEducationString;
	}
	public String getJsonEducationString() {
		return jsonEducationString;
	}
	public void setJsonTrainString(String jsonTrainString) {
		this.jsonTrainString = jsonTrainString;
	}
	public String getJsonTrainString() {
		return jsonTrainString;
	}
	public void setJsonLicenseString(String jsonLicenseString) {
		this.jsonLicenseString = jsonLicenseString;
	}
	public String getJsonLicenseString() {
		return jsonLicenseString;
	}
	public void setJsonWorkString(String jsonWorkString) {
		this.jsonWorkString = jsonWorkString;
	}
	public String getJsonWorkString() {
		return jsonWorkString;
	}
	public void setJsonSkillString(String jsonSkillString) {
		this.jsonSkillString = jsonSkillString;
	}
	public String getJsonSkillString() {
		return jsonSkillString;
	}
	public void setNoList(Integer[] noList) {
		this.noList = noList;
	}
	public Integer[] getNoList() {
		return noList;
	}
	/**
	 * @return the acceptCompinDt
	 */
	public String getAcceptCompinDt() {
		return acceptCompinDt;
	}
	/**
	 * @param acceptCompinDt the acceptCompinDt to set
	 */
	public void setAcceptCompinDt(String acceptCompinDt) {
		this.acceptCompinDt = acceptCompinDt;
	}
	public String getAcceptCompinDtPrint() {
		if (acceptCompinDt == null || acceptCompinDt.length() < 8) {
			return "";
		}
		return CommonUtil.getDateType(acceptCompinDt);
	}
	/**
	 * @return the isPrjtransferadmin
	 */
	public String getIsPrjtransferadmin() {
		return isPrjtransferadmin;
	}
	/**
	 * @param isPrjtransferadmin the isPrjtransferadmin to set
	 */
	public void setIsPrjtransferadmin(String isPrjtransferadmin) {
		this.isPrjtransferadmin = isPrjtransferadmin;
	}
	public boolean isPrjtransferadmin() {
		return (getIsPrjtransferadmin() != null && getIsPrjtransferadmin().equals("Y"));
	}
	public String getIsConsultadmin() {
		return isConsultadmin;
	}
	public void setIsConsultadmin(String isConsultadmin) {
		this.isConsultadmin = isConsultadmin;
	}
	public String getIsProductadmin() {
		return isProductadmin;
	}
	public void setIsProductadmin(String isProductadmin) {
		this.isProductadmin = isProductadmin;
	}
	public String getIsFundAdmin() {
		return isFundAdmin;
	}
	public void setIsfundAdmin(String isFundAdmin) {
		this.isFundAdmin = isFundAdmin;
	}
	public boolean isFundAdmin() {
		return (getIsFundAdmin() != null && getIsFundAdmin().equals("Y"));
	}
	public String getIsEapp28() {
		return isEapp28;
	}
	public void setIsEapp28(String isEapp28) {
		this.isEapp28 = isEapp28;
	}
	public boolean isEapp28() {
		return (getIsEapp28() != null && getIsEapp28().equals("Y"));
	}
	public String getOrgnztIdSec() {
		return orgnztIdSec;
	}
	public void setOrgnztIdSec(String orgnztIdSec) {
		this.orgnztIdSec = orgnztIdSec;
	}
	public String getOrgnztNmSec() {
		return orgnztNmSec;
	}
	public void setOrgnztNmSec(String orgnztNmSec) {
		this.orgnztNmSec = orgnztNmSec;
	}
	public List<EgovMap> getOuterNetLoginLogList() {
		return outerNetLoginLogList;
	}
	public void setOuterNetLoginLogList(List<EgovMap> outerNetLoginLogList) {
		this.outerNetLoginLogList = outerNetLoginLogList;
	}
}
