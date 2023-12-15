package kms.com.app.service;

import kms.com.app.web.KmsApprovalController;

import java.io.Serializable;

/**
 * @Class Name : KmsEappCommentVO.java
 * @Description : KmsEappComment VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ApprovalComment implements Serializable {
    private static final long serialVersionUID = 1L;
    
    /** NO */
    private int no;
    
    /** DOC_ID */
    private java.lang.String docId;
    
    /** WRITER_NO */
    private int writerNo;
    
    /** EAPP_CT */
    private java.lang.String eappCt;
    
    /** WT_DT */
    private java.lang.String wtDt;
    
    /** FK_EAPP_READER */
    private int fkEappReader = -1;
    
    //결재자 타입
	private String appTyp;
	//결재 정보
	private Integer stat;
	//결재자이름
	private String writerId;
	private String writerNm;
	private String mode;
	
    
    public int getNo() {
        return this.no;
    }
    
    public void setNo(int no) {
        this.no = no;
    }
    
    public java.lang.String getDocId() {
        return this.docId;
    }
    
    public void setDocId(java.lang.String docId) {
        this.docId = docId;
    }
    
    public int getWriterNo() {
        return this.writerNo;
    }
    
    public void setWriterNo(int writerNo) {
        this.writerNo = writerNo;
    }
    
    public java.lang.String getEappCt() {
        return this.eappCt;
    }
    
    public void setEappCt(java.lang.String eappCt) {
        this.eappCt = eappCt;
    }
    
    public java.lang.String getWtDt() {
        return this.wtDt;
    }
    
    public void setWtDt(java.lang.String wtDt) {
        this.wtDt = wtDt;
    }
    
    public int getFkEappReader() {
        return this.fkEappReader;
    }
    
    public void setFkEappReader(int fkEappReader) {
        this.fkEappReader = fkEappReader;
    }
 
    public String getAppTyp() {
		return appTyp;
	}

	public void setAppTyp(String appTyp) {
		this.appTyp = appTyp;
	}

	public Integer getStat() {
		return stat;
	}

	public void setStat(Integer stat) {
		this.stat = stat;
	}

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}

	public String getWriterNm() {
		return writerNm;
	}

	public void setWriterNm(String writerNm) {
		this.writerNm = writerNm;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getMode() {
		return mode;
	}

	public String getAppTypNm() {
		if(KmsApprovalController.writerC.equals(appTyp)){
			return "기안자";
		}
		else if(KmsApprovalController.cooperatorC.equals(appTyp)){
			return "협조자";
		}
		else if(KmsApprovalController.reviewerC.equals(appTyp)){
			return "검토자";
		}
		else if(KmsApprovalController.deciderC.equals(appTyp)){
			return "전결자";
		}
		else if(KmsApprovalController.referencerC.equals(appTyp)){
			return "참조자";
		}
		else if(KmsApprovalController.rejectConfirmerC.equals(appTyp)){
			return "반려확인자";
		}
		else if(KmsApprovalController.handlerC.equals(appTyp)){
			return "처리담당자";
		}
		else
			return "";
	}
	
	public String getStatPrint(){
		String statPrint ;
		if(stat==null)
			stat = -1;
		if(KmsApprovalController.rejectConfirmerC.equals(appTyp))
			switch (stat) {
			case 1:
				statPrint = "<span class=\"txtS_blue\">반려확인</span>";
				break;
			default:
				statPrint = "<span class=\"txtS_yellow\">의견첨부</span>";
			}
		else if(KmsApprovalController.handlerC.equals(appTyp))
			switch (stat) {
			case 1:
				statPrint = "<span class=\"txtS_blue\">처리완료</span>";
				break;
			case 2:
				statPrint = "<span class=\"txtS_red\">처리취소</span>";
				break;
			default:
				statPrint = "<span class=\"txtS_yellow\">의견첨부</span>";
			}
		else if(KmsApprovalController.referencerC.equals(appTyp)){
			switch (stat) {
			case 1:
				statPrint = "<span class=\"txtS_blue\">참조</span>";
				break;
			default:
				statPrint = "<span class=\"txtS_yellow\">의견첨부</span>";
			}
		}
		else if(KmsApprovalController.writerC.equals(appTyp)){
			switch (stat) {
			case 1:
				statPrint = "<span class=\"txtS_blue\">기안</span>";
				break;
			case 2:
				statPrint =	 "<span class=\"txtS_red\">반려</span>";
				break;
			default:
				statPrint = "<span class=\"txtS_yellow\">의견첨부</span>";
			}
			
		}
		else{
			switch (stat) {
			case 1:
				statPrint =	 "<span class=\"txtS_blue\">승인</span>";
				break;
			case 2:
				statPrint =	 "<span class=\"txtS_red\">반려</span>";
				break;
			default:
				statPrint = "<span class=\"txtS_yellow\">의견첨부</span>";
			}
		}
	return statPrint;
	}

}
