package kms.com.app.service;

public class ApprovalVacVO {

	
	//문서번호
	private String docId;	

    /** HOL_TYP */
    private int vacTyp = 1;
    
    /** ST_DT */
    private java.lang.String stDt;
    
    /** ED_DT */
    private java.lang.String edDt;
    
    /** ST_AMPM */
    private int stAmpm = 1;
    
    /** ED_AMPM */
    private int edAmpm = 2;
    
    /** SUM_DATE */
    private java.lang.String sumDate;
    
    /** System Input indicator **/
    private String system;    
    private String wsPlace; 
    private String writerNo; //EAPP_DOC WRITER_NO 값을  그대로 입력
    //일괄휴가처리를 위해
    private String recieverList;
    private String[] recieverIdList;
       

    public java.lang.String getStDt() {
        return this.stDt;
    }
    
    public void setStDt(java.lang.String stDt) {
        this.stDt = stDt;
    }
    
    public java.lang.String getEdDt() {
        return this.edDt;
    }
    
    public void setEdDt(java.lang.String edDt) {
        this.edDt = edDt;
    }
    

    
    public java.lang.String getSumDate() {
        return this.sumDate;
    }
    
    public void setSumDate(java.lang.String sumDate) {
        this.sumDate = sumDate;
    }

	public void setVacTyp(int vacTyp) {
		this.vacTyp = vacTyp;
	}

	public int getVacTyp() {
		return vacTyp;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}

	public String getDocId() {
		return docId;
	}

	public void setStAmpm(int stAmpm) {
		this.stAmpm = stAmpm;
	}

	public int getStAmpm() {
		return stAmpm;
	}

	public void setEdAmpm(int edAmpm) {
		this.edAmpm = edAmpm;
	}

	public int getEdAmpm() {
		return edAmpm;
	}
	
	public String getVacDayInform()
	{
		String a;
		String b;
		if(stAmpm==1)
			a = "오전";
		else
			a = "오후";
		
		if(edAmpm==1)
			b = "오전";
		else
			b = "오후";
		String result = this.stDt.substring(0,4) + "." + this.stDt.substring(4,6) + "." + this.stDt.substring(6,8) + " " + a + "부터  " +
		this.edDt.substring(0,4) + "." + this.edDt.substring(4,6) + "." + this.edDt.substring(6,8) + " " + b + "까지 "; 
		
		return result;
	}

	public void setSystem(String system) {
		this.system = system;
	}

	public String getSystem() {
		return system;
	}

	public void setRecieverList(String recieverList) {
		this.recieverList = recieverList;
	}

	public String getRecieverList() {
		return recieverList;
	}

	public void setRecieverIdList(String[] recieverIdList) {
		this.recieverIdList = recieverIdList;
	}

	public String[] getRecieverIdList() {
		return recieverIdList;
	}

	public void setWsPlace(String wsPlace) {
		this.wsPlace = wsPlace;
	}

	public String getWsPlace() {
		return wsPlace;
	}

	public void setWriterNo(String writerNo) {
		this.writerNo = writerNo;
	}

	public String getWriterNo() {
		return writerNo;
	}

	
	
}
