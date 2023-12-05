package kms.com.salary.service;

import java.io.Serializable;

import kms.com.common.utils.CommonUtil;

/**
 * @Class Name : TblRankSalaryVO.java
 * @Description : TblRankSalary VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class Salary implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** RANK_CODE */
    private String rankCode;
    private String rankNm;
    private String rankId;
    private String positionCode;
    private String positionNm;
    
    /** YEAR */
    private String year;
    private String month;
        
    private long salary;
    private int holSalary;
    private int salary1;
    private int salary2;
    private int salary3;
    private String userNo;
    private String userNm;
    private String userId;
    private String[] userIdList;
    private String orgnztNm;
    private String orgnztId;
    
    private String workSt;
    private String useAt;
    private long salaryReal; //실제연봉
    private long salaryHope; //희망연봉
    private long salarySuggest; //제안연봉
    private String accept = "N"; //사원 동의
    private String ceoConfirm = "N"; //대표이사 승인
    private String status; //상태
    private String note; //특약사항
    private String noteYn; //특약사항 여부

    private String hopeNote; //사장님께 하고싶은 말
    private String hopeNoteYn; //사장님께 하고싶은 말 여부
    private String adminNote; //관리자 메모

    
    private long raiseRate; //인상율에서 등급별 공차로 용도변경
    private int carCost; //차량유지비
    private int mealCost; //식대    
    private int babyCost; //보육수당    
    private int communicationCost; //통신비    

	private long yearDiff; //년차별 연봉 공차
    private long gradeDiff; //등급별 연봉 공차
    private String exceptionUsers; //제외할 사용자 번호
    private String[] exceptionUsersList; //제외할 사용자 번호 리스트
    
    private String sabun;
    private String isRegistered;
    private String compinDt;
    private String acceptCompinDt; //인정입사일
    private String compotDt;
    
    //평가 eva와 조인할 때의 총계, 평균 변수 
    private int age;
    private int ageKor;
    private float ageAvg;
    private float ageKorAvg;
    private double salaryRealAvg;
    private double salaryHopeAvg;
    private double salarySuggestAvg;
    private float increaseRateAvg;
    private float increaseRate;    
    private float score1Avg;
    private float score2Avg;
    private float score3Avg;
    private float gradeAvg;
    private int score1;
    private int score2;
    private int score3;    
    private int grade;    
    private int workYear;
    private int workMonth;
    private int workYearIn;
    private int workMonthIn;
    
    
    
    
    public int getSalary1() {
		return salary1;
	}
    public String getSalary1Print() {
    	return CommonUtil.insertComma( salary1);
    }

	public void setSalary1(int salary1) {
		this.salary1 = salary1;
	}

	public int getSalary2() {
		return salary2;
	}
	public String getSalary2Print() {
    	return CommonUtil.insertComma( salary2);
    }

	public void setSalary2(int salary2) {
		this.salary2 = salary2;
	}

	public int getSalary3() {
		return salary3;
	}

	public String getSalary3Print() {
    	return CommonUtil.insertComma( salary3);
    }
	
	public void setSalary3(int salary3) {
		this.salary3 = salary3;
	}
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}	
    
    
    public String getRankCode() {
        return this.rankCode;
    }
    
    public void setRankCode(String rankCode) {
        this.rankCode = rankCode;
    }
    
	public void setSalary(long salary) {
		this.salary = salary;
	}

	public long getSalary() {
		return salary;
	}
	
	public String getSalaryPrint() {
    	return CommonUtil.insertComma( salary);
    }

	public void setYear(String year) {
		this.year = year;
	}

	public String getYear() {
		return year;
	}	
	public String getNextYear() {
		if(year == null || year.equals(""))
			return year;
		return Integer.toString(Integer.parseInt(year) + 1);
	}
	
	public void setMonth(String month) {
		this.month = month;
	}

	public String getMonth() {
		return month;
	}


	/**
	 * @return the workSt
	 */
	public String getWorkSt() {
		if (workSt == null || workSt.equals("")) return "W";
		else return workSt;
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



	public void setPositionCode(String positionCode) {
		this.positionCode = positionCode;
	}

	public String getPositionCode() {
		return positionCode;
	}

	public void setHolSalary(int holSalary) {
		this.holSalary = holSalary;
	}

	public int getHolSalary() {
		return holSalary;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setRankNm(String rankNm) {
		this.rankNm = rankNm;
	}

	public String getRankNm() {
		return rankNm;
	}

	public void setPositionNm(String positionNm) {
		this.positionNm = positionNm;
	}

	public String getPositionNm() {
		return positionNm;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getUseAt() {
		return useAt;
	}
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	public String getOrgnztNm() {
		return orgnztNm;
	}
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	public String getOrgnztId() {
		return orgnztId;
	}
	public void setUserIdList(String[] userIdList) {
		this.userIdList = userIdList;
	}
	public String[] getUserIdList() {
		return userIdList;
	}
	public void setSalaryReal(long salaryReal) {
		this.salaryReal = salaryReal;
	}
	public long getSalaryReal() {
		return salaryReal;
	}
	public void setSalaryHope(long salaryHope) {
		this.salaryHope = salaryHope;
	}
	public long getSalaryHope() {
		return salaryHope;
	}
	public void setRaiseRate(long raiseRate) {
		this.raiseRate = raiseRate;
	}
	public long getRaiseRate() {
		return raiseRate;
	}
	public void setSalarySuggest(long salarySuggest) {
		this.salarySuggest = salarySuggest;
	}
	public long getSalarySuggest() {
		return salarySuggest;
	}
	public void setAccept(String accept) {
		this.accept = accept;
	}
	public String getAccept() {
		return accept;
	}
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}
	public String getSabun() {
		return sabun;
	}
	public void setIsRegistered(String isRegistered) {
		this.isRegistered = isRegistered;
	}
	public String getIsRegistered() {
		return isRegistered;
	}
	public void setCeoConfirm(String ceoConfirm) {
		this.ceoConfirm = ceoConfirm;
	}
	public String getCeoConfirm() {
		return ceoConfirm;
	}
	public void setRankId(String rankId) {
		this.rankId = rankId;
	}
	public String getRankId() {
		return rankId;
	}
	public void setCarCost(int carCost) {
		this.carCost = carCost;
	}
	public int getCarCost() {
		return carCost;
	}
	public void setMealCost(int mealCost) {
		this.mealCost = mealCost;
	}
	public int getMealCost() {
		return mealCost;
	}
    public int getBabyCost() {
		return babyCost;
	}
	public void setBabyCost(int babyCost) {
		this.babyCost = babyCost;
	}
	public int getCommunicationCost() {
		return communicationCost;
	}
	public void setCommunicationCost(int communicationCost) {
		this.communicationCost = communicationCost;
	}
	public void setYearDiff(long yearDiff) {
		this.yearDiff = yearDiff;
	}
	public long getYearDiff() {
		return yearDiff;
	}
	public void setGradeDiff(long gradeDiff) {
		this.gradeDiff = gradeDiff;
	}
	public long getGradeDiff() {
		return gradeDiff;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatus() {
		if(status == null){
			return "";
		}
		return status;
	}
	public void setCompinDt(String compinDt) {
		this.compinDt = compinDt;
	}
	public String getCompinDt() {
		return compinDt;
	}
	public String getCompinDtPrint() {
		String cd = compinDt;
		if (cd == null || cd.length() < 8) return compinDt;
		cd = cd.substring(0,4) + ". " + cd.substring(4,6) + ". " + cd.substring(6,8);  
		return cd;
	}
	public String getCompinDtPrintLong() {
		String cd = compinDt;
		if (cd == null || cd.length() < 8) return compinDt;
		cd = cd.substring(0,4) + " 년 " + cd.substring(4,6) + " 월 " + cd.substring(6,8) + " 일 ";  
		return cd;
	}
	public String getCompinDtYear() {
		String cd = compinDt;
		if (cd == null || cd.length() < 4) return compinDt;
		return cd.substring(0,4);
	}
	public void setCompotDt(String compotDt) {
		this.compotDt = compotDt;
	}
	public String getCompotDt() {
		return compotDt;
	}
	public String getCompotDtPrint() {
		String cd = compotDt;
		if (cd == null || cd.length() < 8) return compotDt;
		cd = cd.substring(0,4) + ". " + cd.substring(4,6) + ". " + cd.substring(6,8);
		return cd;
	}
	public void setExceptionUsers(String exceptionUsers) {
		this.exceptionUsers = exceptionUsers;
	}
	public String getExceptionUsers() {
		return exceptionUsers;
	}
	public void setExceptionUsersList(String[] exceptionUsersList) {
		this.exceptionUsersList = exceptionUsersList;
	}
	public String[] getExceptionUsersList() {
		return exceptionUsersList;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getNote() {
		return note;
	}
	public void setNoteYn(String noteYn) {
		this.noteYn = noteYn;
	}
	public String getNoteYn() {
		return noteYn;
	}
	public void setAgeAvg(float ageAvg) {
		this.ageAvg = ageAvg;
	}
	public float getAgeAvg() {
		return ageAvg;
	}
	public void setAgeKorAvg(float ageKorAvg) {
		this.ageKorAvg = ageKorAvg;
	}
	public float getAgeKorAvg() {
		return ageKorAvg;
	}
	public void setSalaryRealAvg(double salaryRealAvg) {
		this.salaryRealAvg = salaryRealAvg;
	}
	public double getSalaryRealAvg() {
		return salaryRealAvg;
	}
	public void setSalaryHopeAvg(double salaryHopeAvg) {
		this.salaryHopeAvg = salaryHopeAvg;
	}
	public double getSalaryHopeAvg() {
		return salaryHopeAvg;
	}
	public void setSalarySuggestAvg(double salarySuggestAvg) {
		this.salarySuggestAvg = salarySuggestAvg;
	}
	public double getSalarySuggestAvg() {
		return salarySuggestAvg;
	}
	public void setIncreaseRateAvg(float increaseRateAvg) {
		this.increaseRateAvg = increaseRateAvg;
	}
	public float getIncreaseRateAvg() {
		return increaseRateAvg;
	}
	public void setScore1Avg(float score1Avg) {
		this.score1Avg = score1Avg;
	}
	public float getScore1Avg() {
		return score1Avg;
	}
	public void setScore2Avg(float score2Avg) {
		this.score2Avg = score2Avg;
	}
	public float getScore2Avg() {
		return score2Avg;
	}
	public void setScore3Avg(float score3Avg) {
		this.score3Avg = score3Avg;
	}
	public float getScore3Avg() {
		return score3Avg;
	}
	public void setGradeAvg(float gradeAvg) {
		this.gradeAvg = gradeAvg;
	}
	public float getGradeAvg() {
		return gradeAvg;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getAge() {
		return age;
	}
	public void setAgeKor(int ageKor) {
		this.ageKor = ageKor;
	}
	public int getAgeKor() {
		return ageKor;
	}
	public void setWorkYear(int workYear) {
		this.workYear = workYear;
	}
	public int getWorkYear() {
		return workYear;
	}
	public void setWorkMonth(int workMonth) {
		this.workMonth = workMonth;
	}
	public int getWorkMonth() {
		return workMonth;
	}
	public void setWorkYearIn(int workYearIn) {
		this.workYearIn = workYearIn;
	}
	public int getWorkYearIn() {
		return workYearIn;
	}
	public void setWorkMonthIn(int workMonthIn) {
		this.workMonthIn = workMonthIn;
	}
	public int getWorkMonthIn() {
		return workMonthIn;
	}
	public void setIncreaseRate(float increaseRate) {
		this.increaseRate = increaseRate;
	}
	public float getIncreaseRate() {
		return increaseRate;
	}
	public void setScore1(int score1) {
		this.score1 = score1;
	}
	public int getScore1() {
		return score1;
	}
	public void setScore2(int score2) {
		this.score2 = score2;
	}
	public int getScore2() {
		return score2;
	}
	public void setScore3(int score3) {
		this.score3 = score3;
	}
	public int getScore3() {
		return score3;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getGrade() {
		return grade;
	}
	/**
	 * @param hopeNote the hopeNote to set
	 */
	public void setHopeNote(String hopeNote) {
		this.hopeNote = hopeNote;
	}
	/**
	 * @return the hopeNote
	 */
	public String getHopeNote() {
		return hopeNote;
	}
	/**
	 * @param hopeNoteYn the hopeNoteYn to set
	 */
	public void setHopeNoteYn(String hopeNoteYn) {
		this.hopeNoteYn = hopeNoteYn;
	}
	/**
	 * @return the hopeNoteYn
	 */
	public String getHopeNoteYn() {
		return hopeNoteYn;
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
		String cd = acceptCompinDt;
		if (cd == null || cd.length() < 8) return acceptCompinDt;
		cd = cd.substring(0,4) + ". " + cd.substring(4,6) + ". " + cd.substring(6,8);  
		return cd;
	}
	public String getAcceptCompinDtPrintLong() {
		String cd = acceptCompinDt;
		if (cd == null || cd.length() < 8) return acceptCompinDt;
		cd = cd.substring(0,4) + " 년 " + cd.substring(4,6) + " 월 " + cd.substring(6,8) + " 일 ";  
		return cd;
	}
	public String getAcceptCompinDtYear() {
		String cd = acceptCompinDt;
		if (cd == null || cd.length() < 4) return acceptCompinDt;
		return cd.substring(0,4);
	}
	public String getAdminNote() {
		return adminNote;
	}
	public void setAdminNote(String adminNote) {
		this.adminNote = adminNote;
	}
	
}
