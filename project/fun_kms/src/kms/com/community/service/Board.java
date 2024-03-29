package kms.com.community.service;

import java.io.Serializable;

import kms.com.common.utils.CalendarUtil;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name  : Board.java
 * @Description : 게시물에 대한 데이터 처리 모델
 * @Modification Information
 * 
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.03.06       이삼섭                  최초 생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see 
 * 
 */
@SuppressWarnings("serial")
public class Board implements Serializable {

	
	
	/**
	 * 게시물 종류
	 */
	private String bbsTyCode = "";

	/**
	 * 게시물 첨부파일 아이디
	 */
	private String atchFileId = "";
	/**
	 * 게시판 아이디
	 */
	private String bbsId = "";
	/**
	 * 게시판 이름
	 */
	private String bbsNm = "";
	/**
	 * 최초등록자 아이디
	 */
	private String frstRegisterId = "";
	/**
	 * 최초등록시점
	 */
	private String frstRegisterPnttm = "";
	/**
	 * 최종수정자 아이디
	 */
	private String lastUpdusrId = "";
	/**
	 * 최종수정시점
	 */
	private String lastUpdusrPnttm = "";
	/**
	 * 게시시작일
	 */
	private String ntceBgnde = "";
	/**
	 * 게시종료일
	 */
	private String ntceEndde = "";
	/**
	 * 게시자 아이디
	 */
	private String ntcrId = "";
	/**
	 * 게시자명
	 */
	private String ntcrNm = "";
	/**
	 * 게시물 내용
	 */
	private String nttCn = "";
	/**
	 * 게시물 아이디
	 */
	private long nttId = 0L;
	private String nttIdArray = "";
	/**
	 * 게시물 번호
	 */
	private long nttNo = 0L;
	/**
	 * 게시물 제목
	 */
	private String nttSj = "";
	/**
	 * 부모글번호
	 */
	private String parnts = "0";
	/**
	 * 패스워드
	 */
	private String password = "";
	/**
	 * 조회수
	 */
	private int inqireCo = 0;
	/**
	 * 답장여부
	 */
	private String replyAt = "";
	/**
	 * 답장위치
	 */
	private String replyLc = "0";
	/**
	 * 정렬순서
	 */
	private long sortOrdr = 0L;
	/**
	 * 사용여부
	 */
	private String useAt = "";
	/**
	 * 게시 종료일
	 */
	private String ntceEnddeView = ""; 
	/**
	 * 게시 시작일
	 */
	private String ntceBgndeView = "";
	/**
	 * 토론게시판 진행/종료 여부
	 */
	private String exChk = "";
	/**
	 * 토론게시판 종료설정 시간
	 */
	private String exChkTm = "";
	/**
	 * 경조사게시판 날짜
	 */
	private String exDt = ""; 
	/**
	 * 경조사게시판 시간
	 */
	private String exHm = "";
	/**
	 * 부서 게시판
	 */
	private String orgnztId = ""; 
	private String orgnztNm = ""; 
	/**
	 * 프로젝트
	 */
	private String prjId = "";
	private String prjCd = "";
	private String prjNm = "";
	/**
	 * 게시자 소속부서
	 */
	private String ntcrOrgnztId = "";
	private String ntcrOrgnztNm = "";

	/**
	 * atchFileId attribute를 리턴한다.
	 * @return the atchFileId
	 */
	public String getAtchFileId() {
		return atchFileId;
	}

	/**
	 * atchFileId attribute 값을 설정한다.
	 * @param atchFileId the atchFileId to set
	 */
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	/**
	 * bbsId attribute를 리턴한다.
	 * @return the bbsId
	 */
	public String getBbsId() {
		return bbsId;
	}

	/**
	 * bbsId attribute 값을 설정한다.
	 * @param bbsId the bbsId to set
	 */
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}

	/**
	 * @return the bbsNm
	 */
	public String getBbsNm() {
		return bbsNm;
	}

	/**
	 * @param bbsNm the bbsNm to set
	 */
	public void setBbsNm(String bbsNm) {
		this.bbsNm = bbsNm;
	}

	/**
	 * frstRegisterId attribute를 리턴한다.
	 * @return the frstRegisterId
	 */
	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	/**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId the frstRegisterId to set
	 */
	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	/**
	 * frstRegisterPnttm attribute를 리턴한다.
	 * @return the frstRegisterPnttm
	 */
	public String getFrstRegisterPnttm() {
		return frstRegisterPnttm;
	}

	/**
	 * frstRegisterPnttm attribute 값을 설정한다.
	 * @param frstRegisterPnttm the frstRegisterPnttm to set
	 */
	public void setFrstRegisterPnttm(String frstRegisterPnttm) {
		this.frstRegisterPnttm = frstRegisterPnttm;
	}

	/**
	 * lastUpdusrId attribute를 리턴한다.
	 * @return the lastUpdusrId
	 */
	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	/**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId the lastUpdusrId to set
	 */
	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	/**
	 * lastUpdusrPnttm attribute를 리턴한다.
	 * @return the lastUpdusrPnttm
	 */
	public String getLastUpdusrPnttm() {
		return lastUpdusrPnttm;
	}

	/**
	 * lastUpdusrPnttm attribute 값을 설정한다.
	 * @param lastUpdusrPnttm the lastUpdusrPnttm to set
	 */
	public void setLastUpdusrPnttm(String lastUpdusrPnttm) {
		this.lastUpdusrPnttm = lastUpdusrPnttm;
	}

	/**
	 * ntceBgnde attribute를 리턴한다.
	 * @return the ntceBgnde
	 */
	public String getNtceBgnde() {
		return ntceBgnde;
	}

	/**
	 * ntceBgnde attribute 값을 설정한다.
	 * @param ntceBgnde the ntceBgnde to set
	 */
	public void setNtceBgnde(String ntceBgnde) {
		this.ntceBgnde = ntceBgnde;
	}

	/**
	 * ntceEndde attribute를 리턴한다.
	 * @return the ntceEndde
	 */
	public String getNtceEndde() {
		return ntceEndde;
	}

	/**
	 * ntceEndde attribute 값을 설정한다.
	 * @param ntceEndde the ntceEndde to set
	 */
	public void setNtceEndde(String ntceEndde) {
		this.ntceEndde = ntceEndde;
	}

	/**
	 * ntcrId attribute를 리턴한다.
	 * @return the ntcrId
	 */
	public String getNtcrId() {
		return ntcrId;
	}

	/**
	 * ntcrId attribute 값을 설정한다.
	 * @param ntcrId the ntcrId to set
	 */
	public void setNtcrId(String ntcrId) {
		this.ntcrId = ntcrId;
	}

	/**
	 * ntcrNm attribute를 리턴한다.
	 * @return the ntcrNm
	 */
	public String getNtcrNm() {
		return ntcrNm;
	}

	/**
	 * ntcrNm attribute 값을 설정한다.
	 * @param ntcrNm the ntcrNm to set
	 */
	public void setNtcrNm(String ntcrNm) {
		this.ntcrNm = ntcrNm;
	}

	/**
	 * nttCn attribute를 리턴한다.
	 * @return the nttCn
	 */
	public String getNttCn() {
		return nttCn;
	}

	/**
	 * nttCn attribute 값을 설정한다.
	 * @param nttCn the nttCn to set
	 */
	public void setNttCn(String nttCn) {
		this.nttCn = nttCn;
	}

	/**
	 * nttId attribute를 리턴한다.
	 * @return the nttId
	 */
	public long getNttId() {
		return nttId;
	}

	/**
	 * nttId attribute 값을 설정한다.
	 * @param nttId the nttId to set
	 */
	public void setNttId(long nttId) {
		this.nttId = nttId;
	}

	/**
	 * nttNo attribute를 리턴한다.
	 * @return the nttNo
	 */
	public long getNttNo() {
		return nttNo;
	}

	/**
	 * nttNo attribute 값을 설정한다.
	 * @param nttNo the nttNo to set
	 */
	public void setNttNo(long nttNo) {
		this.nttNo = nttNo;
	}

	/**
	 * nttSj attribute를 리턴한다.
	 * @return the nttSj
	 */
	public String getNttSj() {
		return nttSj;
	}
	public String getNttSjShort() {
		if (nttSj == null) return "";
		
		else if (nttSj.length() > 15) {
			return nttSj.substring(0,12) + "...";
		}
		else {
			return nttSj; 
		}
	}

	/**
	 * nttSj attribute 값을 설정한다.
	 * @param nttSj the nttSj to set
	 */
	public void setNttSj(String nttSj) {
		this.nttSj = nttSj;
	}

	/**
	 * parnts attribute를 리턴한다.
	 * @return the parnts
	 */
	public String getParnts() {
		return parnts;
	}

	/**
	 * parnts attribute 값을 설정한다.
	 * @param parnts the parnts to set
	 */
	public void setParnts(String parnts) {
		this.parnts = parnts;
	}

	/**
	 * password attribute를 리턴한다.
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * password attribute 값을 설정한다.
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * inqireCo attribute를 리턴한다.
	 * @return the inqireCo
	 */
	public int getInqireCo() {
		return inqireCo;
	}

	/**
	 * inqireCo attribute 값을 설정한다.
	 * @param inqireCo the inqireCo to set
	 */
	public void setInqireCo(int inqireCo) {
		this.inqireCo = inqireCo;
	}

	/**
	 * replyAt attribute를 리턴한다.
	 * @return the replyAt
	 */
	public String getReplyAt() {
		return replyAt;
	}

	/**
	 * replyAt attribute 값을 설정한다.
	 * @param replyAt the replyAt to set
	 */
	public void setReplyAt(String replyAt) {
		this.replyAt = replyAt;
	}

	/**
	 * replyLc attribute를 리턴한다.
	 * @return the replyLc
	 */
	public String getReplyLc() {
		return replyLc;
	}

	/**
	 * replyLc attribute 값을 설정한다.
	 * @param replyLc the replyLc to set
	 */
	public void setReplyLc(String replyLc) {
		this.replyLc = replyLc;
	}

	/**
	 * sortOrdr attribute를 리턴한다.
	 * @return the sortOrdr
	 */
	public long getSortOrdr() {
		return sortOrdr;
	}

	/**
	 * sortOrdr attribute 값을 설정한다.
	 * @param sortOrdr the sortOrdr to set
	 */
	public void setSortOrdr(long sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	/**
	 * useAt attribute를 리턴한다.
	 * @return the useAt
	 */
	public String getUseAt() {
		return useAt;
	}

	/**
	 * useAt attribute 값을 설정한다.
	 * @param useAt the useAt to set
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	/**
	 * ntceEnddeView attribute를 리턴한다.
	 * @return the ntceEnddeView
	 */
	public String getNtceEnddeView() {
		return ntceEnddeView;
	}

	/**
	 * ntceEnddeView attribute 값을 설정한다.
	 * @param ntceEnddeView the ntceEnddeView to set
	 */
	public void setNtceEnddeView(String ntceEnddeView) {
		this.ntceEnddeView = ntceEnddeView;
	}

	/**
	 * ntceBgndeView attribute를 리턴한다.
	 * @return the ntceBgndeView
	 */
	public String getNtceBgndeView() {
		return ntceBgndeView;
	}

	/**
	 * ntceBgndeView attribute 값을 설정한다.
	 * @param ntceBgndeView the ntceBgndeView to set
	 */
	public void setNtceBgndeView(String ntceBgndeView) {
		this.ntceBgndeView = ntceBgndeView;
	}

	/**
	 * exChk attribute를 리턴한다.
	 * @return the exChk
	 */
	public String getExChk() {
		return exChk;
	}
	public String getExChkPrint() {
		//건의/제안 상태: 검토중E 채택H 평가보류C 기각R 처리완료F
		if (exChk == null || exChk.equals("")) {
			return "검토중";
		}
		else if (exChk.equalsIgnoreCase("E")) {
			return "검토중";
		} else if (exChk.equalsIgnoreCase("H")) {
			return "보류";
		} else if (exChk.equalsIgnoreCase("C")) {
			return "채택";
		} else if (exChk.equalsIgnoreCase("R")) {
			return "기각";
		} else if (exChk.equalsIgnoreCase("F")) {
			return "처리완료";
		}
		else return exChk;
	}
	
	public String getKmsExChkPrint() {
		//건의/제안 상태: 작업예정E 작업중H 향후작업C 기각R 처리완료F
		if (exChk == null || exChk.equals("")) {
			return "접수";
		}
		else if (exChk.equalsIgnoreCase("E")) {
			return "접수";
		} else if (exChk.equalsIgnoreCase("H")) {
			return "향후작업";
		} else if (exChk.equalsIgnoreCase("C")) {
			return "작업중";
		} else if (exChk.equalsIgnoreCase("R")) {
			return "기각";
		} else if (exChk.equalsIgnoreCase("F")) {
			return "처리완료";
		}
		else return exChk;
	}
	
	/**
	 * exChk attribute 값을 설정한다.
	 * @param exChk the exChk to set
	 */
	public void setExChk(String exChk) {
		this.exChk = exChk;
	}
	
	/**
	 * exChkTm attribute를 리턴한다.
	 * @return the exChkTm
	 */
	public String getExChkTm() {
		return exChkTm;
	}
	
	/**
	 * exChkTm attribute 값을 설정한다.
	 * @param exChkTm the exChkTm to set
	 */
	public void setExChkTm(String exChkTm) {
		this.exChkTm = exChkTm;
	}
	
	/**
	 * exDt attribute를 리턴한다.
	 * @return the exDt
	 */
	public String getExDt() {
		return exDt;
	}
	public String getExDtPrint() {
		return exDt.substring(0,4) + "." + exDt.substring(4,6) + "." + exDt.substring(6,8) + "(" + CalendarUtil.getDay(exDt, "KOR") + ")";
	}
	
	/**
	 * exDt attribute 값을 설정한다.
	 * @param exDt the exDt to set
	 */
	public void setExDt(String exDt) {
		this.exDt = exDt;
	}
	
	/**
	 * exHm attribute를 리턴한다.
	 * @return the exHm
	 */
	public String getExHm() {
		return exHm;
	}
	
	/**
	 * exHm attribute 값을 설정한다.
	 * @param exHm the exHm to set
	 */
	public void setExHm(String exHm) {
		this.exHm = exHm;
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
	 * @return the prjId
	 */
	public String getPrjId() {
		return prjId;
	}

	/**
	 * @param prjId the prjId to set
	 */
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	/**
	 * @return the prjCd
	 */
	public String getPrjCd() {
		return prjCd;
	}

	/**
	 * @param prjCd the prjCd to set
	 */
	public void setPrjCd(String prjCd) {
		this.prjCd = prjCd;
	}

	/**
	 * @return the prjNm
	 */
	public String getPrjNm() {
		return prjNm;
	}

	/**
	 * @param prjNm the prjCn to set
	 */
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}

	/**
	 * @return the ntcrOrgnztId
	 */
	public String getNtcrOrgnztId() {
		return ntcrOrgnztId;
	}

	/**
	 * @param ntcrOrgnztId the ntcrOrgnztId to set
	 */
	public void setNtcrOrgnztId(String ntcrOrgnztId) {
		this.ntcrOrgnztId = ntcrOrgnztId;
	}

	/**
	 * @return the ntcrOrgnztNm
	 */
	public String getNtcrOrgnztNm() {
		return ntcrOrgnztNm;
	}

	/**
	 * @param ntcrOrgnztNm the ntcrOrgnztNm to set
	 */
	public void setNtcrOrgnztNm(String ntcrOrgnztNm) {
		this.ntcrOrgnztNm = ntcrOrgnztNm;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}

	/**
	 * @param nttIdArray the nttIdArray to set
	 */
	public void setNttIdArray(String nttIdArray) {
		this.nttIdArray = nttIdArray;
	}

	/**
	 * @return the nttIdArray
	 */
	public String getNttIdArray() {
		return nttIdArray;
	}

	/**
	 * @return the bbsTyCode
	 */
	public String getBbsTyCode() {
		return bbsTyCode;
	}

	/**
	 * @param bbsTyCode the bbsTyCode to set
	 */
	public void setBbsTyCode(String bbsTyCode) {
		this.bbsTyCode = bbsTyCode;
	}

}
