package kms.com.common.utils;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

public class LunarHandler {
	public LunarHandler() {
		setLunarList();
	}
	private List<Integer[]> lunarList;
	private void setLunarList() {
		lunarList = new ArrayList<Integer[]>();
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 2, 5, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 4, 1, 2, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 5, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 5, 1, 2, 1, 2, 1, 1, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 5, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 5, 2, 1, 2, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 5, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 6, 1, 2, 1, 2, 1, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 4, 1, 2, 1, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 1, 2, 1, 4, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 2, 4, 1, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 1, 2, 4, 1, 2, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 5, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 4, 2, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 4, 1, 1, 2, 1, 2, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 1, 1, 5, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 5, 2, 1, 1, 2, 1, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 2, 1, 5, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 2, 1, 5, 2, 1, 1, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 6, 1, 2, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 1, 2, 1, 1, 5, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 5, 2, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 5, 1, 2, 1, 2, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 5, 2, 1, 2, 1, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 2, 2, 1, 5, 2, 1, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 5, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 1, 5, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 1, 5, 1, 2, 1, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 6, 2, 1, 2, 1, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 2, 1, 2, 5, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 1, 2, 5, 2, 1, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 5, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 5, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 4, 1, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1, 1} );
		lunarList.add( new Integer[]{2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1} );
		lunarList.add( new Integer[]{2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2} );
		lunarList.add( new Integer[]{1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2} );
	}

	private static GregorianCalendar getGCalendar(String yyyymmdd) {
		String yyyy = yyyymmdd.substring(0, 4);
		String mm = yyyymmdd.substring(4, 6);
		String dd = "01";
		if(yyyymmdd.length()==8) dd = yyyymmdd.substring(6, 8);
		if(dd.substring(0, 1).equals("0")) dd = dd.substring(1);

		if(mm.substring(0,1).equals("0")) mm = mm.substring(1);

		GregorianCalendar gc = new GregorianCalendar();
		gc.set(Integer.parseInt(yyyy), Integer.parseInt(mm)-1, Integer.parseInt(dd));
		
		return gc;
	}

    /* 양력 <-> 음력 변환 함수
     * type : 1 - 양력 -> 음력
     *        2 - 음력 -> 양력
     * leapmonth : 0 - 평달
     *             1 - 윤달 (type = 2 일때만 유효)
    */
	public GregorianCalendar getLunarDate(String yyyymmdd, int type, int leapmonth) {
		GregorianCalendar gc = getGCalendar( yyyymmdd );
		int year = gc.get(Calendar.YEAR);
		int month = gc.get(Calendar.MONTH) + 1;
		int day = gc.get(Calendar.DATE);
		
		if(year < 1900 || year > 2040){
			return null;
		}

		GregorianCalendar lunarDate = new GregorianCalendar();
		 
        int solYear, solMonth, solDay;
        int lunYear, lunMonth, lunDay;
        int lunLeapMonth, lunMonthDay;
        int i, lunIndex;
		int[] solMonthDay = { 31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

        /* 속도 개선을 위해 기준 일자를 여러개로 한다 */
        if (year >= 2000)
        {
                     /* 기준일자 양력 2000년 1월 1일 (음력 1999년 11월 25일) */
                     solYear = 2000;
                     solMonth = 1;
                     solDay = 1;
                     lunYear = 1999;
                     lunMonth = 11;
                     lunDay = 25;
                     lunLeapMonth = 0;

                     solMonthDay[1] = 29;          /* 2000 년 2월 28일 */
                     lunMonthDay = 30;             /* 1999년 11월 */
        }
        else if (year >= 1970)
        {
                     /* 기준일자 양력 1970년 1월 1일 (음력 1969년 11월 24일) */
                     solYear = 1970;
                     solMonth = 1;
                     solDay = 1;
                     lunYear = 1969;
                     lunMonth = 11;
                     lunDay = 24;
                     lunLeapMonth = 0;

                     solMonthDay[1] = 28;          /* 1970 년 2월 28일 */
                     lunMonthDay = 30;             /* 1969년 11월 */
        }
        else if (year >= 1940)
        {
                     /* 기준일자 양력 1940년 1월 1일 (음력 1939년 11월 22일) */
                     solYear = 1940;
                     solMonth = 1;
                     solDay = 1;
                     lunYear = 1939;
                     lunMonth = 11;
                     lunDay = 22;
                     lunLeapMonth = 0;

                     solMonthDay[1] = 29;          /* 1940 년 2월 28일 */
                     lunMonthDay = 29;             /* 1939년 11월 */
        }
        else
        {
                     /* 기준일자 양력 1900년 1월 1일 (음력 1899년 12월 1일) */
                     solYear = 1900;
                     solMonth = 1;
                     solDay = 1;
                     lunYear = 1899;
                     lunMonth = 12;
                     lunDay = 1;
                     lunLeapMonth = 0;

                     solMonthDay[1] = 28;          /* 1900 년 2월 28일 */
                     lunMonthDay = 30;             /* 1899년 12월 */
        }
        
        lunIndex = lunYear - 1899;
        
        while (true)
        {
                     //                        document.write(solYear + "-" + solMonth + "-" + solDay + "<->");
                     //                        document.write(lunYear + "-" + lunMonth + "-" + lunDay + " " + lunLeapMonth + " " + lunMonthDay + "<br>");

                     if (type == 1 &&
                                  year == solYear &&
                                  month == solMonth &&
                                  day == solDay)
                     {
                                  lunarDate.set(lunYear, lunMonth-1, lunDay);
                                  return lunarDate;
                                  //return new myDate(lunYear, lunMonth, lunDay, lunLeapMonth);
                     }
                     else if (type == 2 &&
                                  year == lunYear &&
                                  month == lunMonth &&
                                  day == lunDay &&
                                  leapmonth == lunLeapMonth)
                     {
                                  lunarDate.set(solYear, solMonth-1, solDay);
                                  return lunarDate;
                                  //return new myDate(solYear, solMonth, solDay, 0);
                     }

                     /* add a day of solar calendar */
                     if (solMonth == 12 && solDay == 31)
                     {
                                  solYear++;
                                  solMonth = 1;
                                  solDay = 1;

                                  /* set monthDay of Feb */
                                  if (solYear % 400 == 0)
                                                solMonthDay[1] = 29;
                                  else if (solYear % 100 == 0)
                                                solMonthDay[1] = 28;
                                  else if (solYear % 4 == 0)
                                                solMonthDay[1] = 29;
                                  else
                                                solMonthDay[1] = 28;

                     }
                     else if (solMonthDay[solMonth - 1] == solDay)
                     {
                                  solMonth++;
                                  solDay = 1;

                     }
                     else{
                                  solDay++;
                     }

                     /* add a day of lunar calendar */
                     //lunarList.get(lunIndex)[lunMonth - 1];
                     if (lunMonth == 12 &&
                                  ( (lunarList.get(lunIndex)[lunMonth - 1] == 1 && lunDay == 29) ||
                                  (lunarList.get(lunIndex)[lunMonth - 1] == 2 && lunDay == 30)))
                     {
                                  lunYear++;
                                  lunMonth = 1;
                                  lunDay = 1;

                                  if (lunYear > 2043)
                                  {
                                                //alert("입력하신 달은 없습니다.");
                                                break;
                                  }

                                  lunIndex = lunYear - 1899;
                                  if (lunarList.get(lunIndex)[lunMonth - 1] == 1)
                                                lunMonthDay = 29;
                                  else if (lunarList.get(lunIndex)[lunMonth - 1] == 2)
                                                lunMonthDay = 30;
                     }
                     else if (lunDay == lunMonthDay)
                     {
                                  if (lunarList.get(lunIndex)[lunMonth - 1] >= 3
                                                && lunLeapMonth == 0)
                                  {
                                                lunDay = 1;
                                                lunLeapMonth = 1;
                                  }
                                  else
                                  {
                                                lunMonth++;
                                                lunDay = 1;
                                                lunLeapMonth = 0;
                                  }

                                  if (lunarList.get(lunIndex)[lunMonth - 1] == 1)
                                                lunMonthDay = 29;
                                  else if (lunarList.get(lunIndex)[lunMonth - 1] == 2)
                                                lunMonthDay = 30;
                                  else if (lunarList.get(lunIndex)[lunMonth - 1] == 3)
                                                lunMonthDay = 29;
                                  else if (lunarList.get(lunIndex)[lunMonth - 1] == 4 &&
                                                lunLeapMonth == 0)
                                                lunMonthDay = 29;
                                  else if (lunarList.get(lunIndex)[lunMonth - 1] == 4 &&
                                                lunLeapMonth == 1)
                                                lunMonthDay = 30;
                                  else if (lunarList.get(lunIndex)[lunMonth - 1] == 5 &&
                                                lunLeapMonth == 0)
                                                lunMonthDay = 30;
                                  else if (lunarList.get(lunIndex)[lunMonth - 1] == 5 && lunLeapMonth == 1)
                                                lunMonthDay = 29;
                                  else if (lunarList.get(lunIndex)[lunMonth - 1] == 6)
                                                lunMonthDay = 30;
                     }
                     else
                                  lunDay++;
        }
        
        return lunarDate;
	}

	
    /* 양력 <-> 음력 변환 함수
     * type : 1 - 양력 -> 음력
     *        2 - 음력 -> 양력
     * leapmonth : 0 - 평달
     *             1 - 윤달 (type = 2 일때만 유효)
    */
	//문자열 (yyyymmdd) 으로 return 하는 함수
	public String getLunarDateStr(String yyyymmdd, int type, int leapmonth) {
		GregorianCalendar gc = getLunarDate(yyyymmdd, type, leapmonth);		// 양력 <-> 음력 변환
		String lunarDate = "";

		lunarDate += Integer.toString(gc.get(Calendar.YEAR));
		if((gc.get(Calendar.MONTH) +1) < 10)
		{
			lunarDate += "0" + Integer.toString(gc.get(Calendar.MONTH) +1);
		}
		else
		{
			lunarDate += Integer.toString(gc.get(Calendar.MONTH) +1);
		}
		if(gc.get(Calendar.DATE) < 10)
		{
			lunarDate += "0" + Integer.toString(gc.get(Calendar.DATE));
		}
		else
		{
			lunarDate += Integer.toString(gc.get(Calendar.DATE));
		}
		
		
		return lunarDate;
	}
	
}
