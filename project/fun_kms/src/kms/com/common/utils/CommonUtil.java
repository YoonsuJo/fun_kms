package kms.com.common.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.Format;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ibm.icu.text.SimpleDateFormat;

import kms.com.common.exception.IdMixInputException;
import kms.com.member.service.MemberVO;
public class CommonUtil {
	
	/**
	 * idMix된 string을 받아와, id만으로만 구성된 string array를 리턴
	 * @param beforeParsingId
	 * @return
	 * @throws IdMixInputException
	 */
	public static String[] parseIdFromMixs(String beforeParsingId) throws IdMixInputException {
		
		String tmp;
		if(beforeParsingId==null)
			return null;
		tmp = beforeParsingId.replaceAll(" ", "");
		if("".equals(beforeParsingId))
			return null;
		tmp = tmp.replaceAll(",", ";");
		tmp = tmp.replaceAll("&lt;", "(").replace("&gt;", ")");
		String [] beforeParsingIdArray = tmp.split(";");
		//String [] afterParsing = new String[beforeParsingIdArray.length];  
		for(int i = 0; i<beforeParsingIdArray.length;i++) {
		
			int beginIndex = beforeParsingIdArray[i].indexOf("(") + 1;
			int endIndex = beforeParsingIdArray[i].indexOf(")");
			if(beginIndex == 0 ||endIndex == -1) {
				IdMixInputException e = new IdMixInputException();
				e.printStackTrace();
				return null;
			}
			beforeParsingIdArray[i] = beforeParsingIdArray[i].substring(beginIndex, endIndex); 
		}
		return beforeParsingIdArray;
	}

	
	//List<String> 타입
	public static List<String> parseIdFromMixs2(String beforeParsingId) throws IdMixInputException {
		
		List<String> result = new ArrayList<String>(); 
		String tmp;
		if(beforeParsingId==null)
			return result;
		tmp = beforeParsingId.replaceAll(" ", "");
		tmp = tmp.replaceAll(",", ";");
		tmp = tmp.replaceAll("&lt;", "(").replace("&gt;", ")");
		if("".equals(beforeParsingId))
			return result;
		String [] beforeParsingIdArray = tmp.split(";");
		for(int i = 0; i<beforeParsingIdArray.length;i++) {
			
			int beginIndex = beforeParsingIdArray[i].indexOf("(") + 1;
			int endIndex = beforeParsingIdArray[i].indexOf(")");
			if(beginIndex == 0 ||endIndex == -1) {
				IdMixInputException e = new IdMixInputException();
				e.printStackTrace();
				return result;
			}
			result.add(beforeParsingIdArray[i].substring(beginIndex, endIndex)); 
		}
		return result;
	}
    
	// 단일 아이디 믹스에서 아이디 추출
	public static String parseIdFromMix(String beforeParsingId) throws IdMixInputException {
		
		String tmp;
		if(beforeParsingId==null)
			return null;
		tmp = beforeParsingId.replaceAll(" ", "");
		if("".equals(beforeParsingId))
			return null;
		tmp = tmp.replaceAll(",", ";");
		tmp = tmp.replaceAll("&lt;", "(").replace("&gt;", ")");
				
		int beginIndex = beforeParsingId.indexOf("(") + 1;
		int endIndex = beforeParsingId.indexOf(")");
		if(beginIndex == 0 ||endIndex == -1) {
			IdMixInputException e = new IdMixInputException();
			e.printStackTrace();
			return null;
		}
		beforeParsingId = beforeParsingId.substring(beginIndex, endIndex); 
	
		return beforeParsingId;
	}
	
	/**
	 * idMix된 string을 받아와, name만으로만 구성된 string array를 리턴
	 * @param beforeParsingId
	 * @return
	 * @throws IdMixInputException
	 */
	public static String[] parseNmFromMixs(String beforeParsingId) 
		throws IdMixInputException {
		String tmp;
		if(beforeParsingId==null)
			return null;
		tmp = beforeParsingId.replaceAll(" ", "");
		if("".equals(beforeParsingId))
			return null;
		tmp = tmp.replaceAll(",", ";");
		tmp = tmp.replaceAll("&lt;", "(").replace("&gt;", ")");
		String [] beforeParsingIdArray = tmp.split(";");
		//String [] afterParsing = new String[beforeParsingIdArray.length];  
		for(int i = 0; i<beforeParsingIdArray.length;i++){
			
			int beginIndex = 0;
			int endIndex = beforeParsingIdArray[i].indexOf("(") ;
			if(endIndex == -1){
				IdMixInputException e = new IdMixInputException();
				e.printStackTrace();
				return null;
			}
			beforeParsingIdArray[i] = beforeParsingIdArray[i].substring(beginIndex, endIndex); 
		}
		return beforeParsingIdArray;
	}
	
	
	public static boolean isMixedId(String beforeParsingId) 
		throws IdMixInputException {
		String tmp;
		if(beforeParsingId==null)
			return false;
		tmp = beforeParsingId.replaceAll(" ", "");
		if("".equals(beforeParsingId))
			return false;
		tmp = tmp.replaceAll(",", ";");
		tmp = tmp.replaceAll("&lt;", "(").replace("&gt;", ")");
		String [] beforeParsingIdArray = tmp.split(";");
		//String [] afterParsing = new String[beforeParsingIdArray.length];  
		for(int i = 0; i<beforeParsingIdArray.length;i++){
			
			int beginIndex = beforeParsingIdArray[i].indexOf("(") + 1;
			int endIndex = beforeParsingIdArray[i].indexOf(")");
			if(beginIndex == 0 ||endIndex == -1){
				return false;
			}
			beforeParsingIdArray[i] = beforeParsingIdArray[i].substring(beginIndex, endIndex); 
		}
		return true;
	}
		
	/**
	 * name과 id값을 받아, id mix된 값을 리턴
	 * @param userNm
	 * @param userId
	 * @return
	 * @throws IdMixInputException
	 */
	public static String makeIdMixs(String userNm, String userId) 
		throws IdMixInputException {
		return userNm + "(" + userId + ")"; 
	}
	
	
    /**
     * XSS 방지 처리.
     * 
     * @param data
     * @return
     */
    public static String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }
        
        String ret = data;
        
        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
        
        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
        
        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
        
        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        
        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        
        ret = ret.replaceAll("<", "&lt;");
        ret = ret.replaceAll(">", "&gt;");      
   
        
        return ret;
    }
        
    public static String getXMLStr(String str) {
		StringBuffer xml = new StringBuffer();
		xml.append("<?xml version='1.0' encoding='UTF-8'?>");
		xml.append("\n<root>\n");
		xml.append(str);
		xml.append("\n</root>\n");

		return xml.toString();
	}

	public static String getDateType(String date) {
		if (date == null || date.equals("")) return "";
		else {
			if(date.length()==6)
				return date.substring(0,4) + "." + date.substring(4,6);
			else {
				if(date.length()>=10)
					return date.substring(0,4) + "." +date.substring(5,7) + "." + date.substring(8,10);
				else
					return date.substring(0,4) + "." + date.substring(4,6) + "." + date.substring(6,8);
			}
		}
	}
	public static String getDateType(String date,String morePrint) {
		if (date == null || date.equals("")) return "";
		else {
			if(date.length()==6)
				return date.substring(0,4) + "." + date.substring(4,6);
			else {
				if("M".equals(morePrint) && date.length()>=10) {
					return date.substring(0,4) + "." +date.substring(5,7) + "." + date.substring(8,10)
					+ " " + date.substring(11,16);
				} else {
					if(date.length()>=10)
						return date.substring(0,4) + "." +date.substring(5,7) + "." + date.substring(8,10);
					else
						return date.substring(0,4) + "." + date.substring(4,6) + "." + date.substring(6,8);
				}
			}
		}
	}

    /**
	 * String UnEscape 처리
	 * 
	 * @param src
	 * @return
	 */
	public static String unescape(String src) {
		StringBuffer tmp = new StringBuffer();
		tmp.ensureCapacity(src.length());
		int lastPos = 0, pos = 0;
		char ch;
		while (lastPos < src.length()) {
			pos = src.indexOf("%", lastPos);
			if (pos == lastPos) {
				if (src.charAt(pos + 1) == 'u') {
					ch = (char) Integer.parseInt(src
							.substring(pos + 2, pos + 6), 16);
					tmp.append(ch);
					lastPos = pos + 6;
				} else {
					ch = (char) Integer.parseInt(src
							.substring(pos + 1, pos + 3), 16);
					tmp.append(ch);
					lastPos = pos + 3;
				}
			} else {
				if (pos == -1) {
					tmp.append(src.substring(lastPos));
					lastPos = src.length();
				} else {
					tmp.append(src.substring(lastPos, pos));
					lastPos = pos;
				}
			}
		}
		return tmp.toString();
	}

	/**
	 * String Escape 처리
	 * @param src
	 * @return
	 */
	public static String escape(String src) {
		int i;
		char j;
		StringBuffer tmp = new StringBuffer();
		tmp.ensureCapacity(src.length() * 6);
		for (i = 0; i < src.length(); i++) {
			j = src.charAt(i);
			if (Character.isDigit(j) || Character.isLowerCase(j)
					|| Character.isUpperCase(j))
				tmp.append(j);
			else if (j < 256) {
				tmp.append("%");
				if (j < 16)
					tmp.append("0");
				tmp.append(Integer.toString(j, 16));
			} else {
				tmp.append("%u");
				tmp.append(Integer.toString(j, 16));
			}
		}
		return tmp.toString();
	}
		
	public static String insertComma(int value) {
		return insertCommaDivideBy(value, 1);
	}
	
	public static String insertComma(long value) {
		return insertCommaDivideBy(value, 1);
	}
	
	public static String insertCommaDivideBy(Integer value, int divideBy) {
		if (value == null) value = 0;
		String sign = "";
		if (value < 0) {
			value = - value;
			sign = "-";
		}
		
		int var = Math.round((float)value / (float)divideBy);
		
		String expString = String.valueOf(var);
		
		int len = expString.length()%3 == 0 ? 3 : expString.length()%3;
		
		String result = expString.substring(0, len);
		expString = expString.substring(len);
		
		while(expString.equals("") == false) {
			result += "," + expString.substring(0, 3);
			expString = expString.substring(3);
		}
		
		return sign + result;
	}
	
	public static String insertCommaDivideBy(Long value, int divideBy) {
		if (value == null) value = 0L;
		String sign = "";
		if (value < 0) {
			value = - value;
			sign = "-";
		}
		
		long var = Math.round((double)value / (double)divideBy);
		
		String expString = String.valueOf(var);
		
		int len = expString.length()%3 == 0 ? 3 : expString.length()%3;
		
		String result = expString.substring(0, len);
		expString = expString.substring(len);
		
		while(expString.equals("") == false) {
			result += "," + expString.substring(0, 3);
			expString = expString.substring(3);
		}
		
		return sign + result;
	}
	public static String insertCommaDivideBy(Long value, int divideBy, boolean cipher) {
		if (value == null) value = 0L;
		
		if (cipher == false) {
			return insertCommaDivideBy(value, divideBy);
		} else {
			String sign = "";
			if (value < 0) {
				value = - value;
				sign = "-";
			}
			
			double var = (double)(Math.round((float)value / (float)divideBy * 10)) / 10;
			
			String expStringAll = String.valueOf(var);
			String expString = expStringAll.substring(0, expStringAll.indexOf("."));
			String expString2 = expStringAll.substring(expStringAll.indexOf("."));
			
			int len = expString.length()%3 == 0 ? 3 : expString.length()%3;
			
			String result = expString.substring(0, len);
			expString = expString.substring(len);
			
			while(expString.equals("") == false) {
				result += "," + expString.substring(0, 3);
				expString = expString.substring(3);
			}
			
			return sign + result + expString2;
		}
	}

	public static String getPercent(int div, int divBy) {
		if (divBy == 0) return "-";

		Format formatter = new DecimalFormat(".#");
		double value = (double)div/(double)(divBy)*100;

		if (value < 1 && value >= 0)
			return "0" + formatter.format(value);
		else
			return formatter.format(value);
	}
	
	public static String getPercent(long div, long divBy) {
		if (divBy == 0) return "-";
		
		Format formatter = new DecimalFormat(".#");
		double value = (double)div/(double)(divBy)*100;
		
		if (value < 1 && value >= 0)
			return "0" + formatter.format(value);
		else
			return formatter.format(value);
	}
		
	public static void warningMsg(HttpServletResponse res, String msg, boolean historyBack) throws Exception {
		PrintWriter pw = res.getWriter();
		pw.println("<script>");
		if(msg!=null){
			pw.println("alert('"+msg.replace("\n", "\\n").replace("\'", "\\'")+"')");
		}
		if(historyBack){
			pw.println("history.go(-1);");
		}
		pw.println("</script>");
	}
	
	public static String printPrjFnm(String prjCd, String prjNm, boolean bracketAlways)	{
		if("".equals(prjCd) && "".equals(prjNm))
			return "";
		else {
			String prjCdPrint = "".equals(prjCd) ? "" : ("".equals(prjNm) && !bracketAlways) ? prjCd : "[" + prjCd + "]";
			String prjNmPrint = "".equals(prjNm) ? "" : prjNm;
			
			String blank = "".equals(prjCd) == false && "".equals(prjNm) == false ? " " : "";
			
			return prjCdPrint + blank + prjNmPrint;
		}
	}

	public static String printUserMix(String userNm, String userId) {
		if(userNm==null || "".equals(userNm)
				|| userId==null || "".equals(userId))
			return "";
		else
			return userNm + "(" + userId +")";
	}
	
	public static String[] makeValidIdList(String commaSeparatedStr) {
		if (null == commaSeparatedStr)
			return null;
		
		if (commaSeparatedStr.isEmpty())
			return null;
		
		if (commaSeparatedStr.replaceAll("[ ,]", "").isEmpty())
			return null;
		
		return commaSeparatedStr.replace(" ", "").split(",");
	}
	
	public static List<String> makeValidIdListArray(String commaSeparatedStr) {
		List<String> result = new ArrayList();
		if (null == commaSeparatedStr)
			return result;
		
		if (commaSeparatedStr.isEmpty())
			return result;
		
		if (commaSeparatedStr.replaceAll("[ ,]", "").isEmpty())
			return result;
		String[] ab = commaSeparatedStr.replace(" ", "").split(",");
		for(String a : ab){
			result.add(a);
		}
		return result;
	}
	
	public static String htmlTagRemove(String text){
		return text.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

	public static void smsSend(String message, MemberVO sender, List<MemberVO> recieverList) throws Exception {
		
		String smsSenderUrl = "http://www.winc7788.co.kr/MSG/send/web_admin_send.htm";
		//String smsSenderUrl = "http://www.winc777888.co.kr/MSG/send/web_admin_send.htm"; //연결 불가 환경 테스트
		String userid = "dosanet";
		String passwd = "dosa0111";
		String end_alert = "0";
		String resultStr = "";
		
		URL url = new URL(smsSenderUrl);
		String line = null;
		int result = 0;
		URLConnection con = url.openConnection();
		
		con.setRequestProperty("Accept-Language",  "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
		con.setDoOutput(true);
		
		String receiver = "";
		String receiver_name = "";
		
		for (int i=0; i<recieverList.size(); i++) {
			MemberVO reciever = recieverList.get(i);
			
			if (i != 0) {
				receiver += ",";
				receiver_name += ",";
			}
				
			receiver += reciever.getMoblphonNoSmsTyp();
			receiver_name += reciever.getUserNm();
		}
		
		String parameter = URLEncoder.encode("userid", "euc-kr") + "="  + URLEncoder.encode(userid, "euc-kr");
		parameter += "&" + URLEncoder.encode("passwd", "euc-kr") + "="  + URLEncoder.encode(passwd, "euc-kr");
		parameter += "&" + URLEncoder.encode("sender", "euc-kr") + "="  + URLEncoder.encode(sender.getMoblphonNoSmsTyp(), "euc-kr");
		parameter += "&" + URLEncoder.encode("receiver", "euc-kr") + "="  + URLEncoder.encode(receiver, "euc-kr");
		parameter += "&" + URLEncoder.encode("message", "euc-kr") + "="  + URLEncoder.encode(message, "euc-kr");
		parameter += "&" + URLEncoder.encode("receiver_name", "euc-kr") + "=" + URLEncoder.encode(receiver_name, "euc-kr");
		parameter += "&" + URLEncoder.encode("end_alert", "euc-kr") + "=" + end_alert;
		
		OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
		wr.write(parameter);
		wr.flush();
	
		//응답 처리
		BufferedReader rd = null;

		rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "euc-kr"));
	
		/*
		 * 결과값에 따른 스트링 반환
		 * 참고 http://www.winc7788.co.kr/
		 */
		while ((line = rd.readLine()) != null) {
			
			result = Integer.parseInt(line.substring(0, 1));
			switch (result) {
				case 1	:
					resultStr = "필수 전달 값이 빠졌습니다.";
					break;
				case 2	:
					resultStr = "365 라는 정수입니다.";
					break;
				case 3	:
					resultStr = "1000 이라는 정수입니다.";
					break;
				case 9	:
					resultStr = "문자가 성공적으로 전달되었습니다.";
					break;
		    }
		}
		
		System.out.println(resultStr);
	}
	
	/**
     * 브라우저 구분 얻기.
     * 
     * @param request
     * @return
     */
    public static String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1) {  //IE 11에서는 MSIE로 판단할수 없음
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
    
    /**
	 * 속성이 있는 이중태그 삭제 메소드 (ex: <b style=""></b>
	 */
	public static String deleteAttrDblTag(String content, String tag) {
		
		String result = content;
		
		// img태그 시작, 끝위치
		int startIdx = content.indexOf("<" + tag);
		int endIdx = content.indexOf(">", startIdx);
		
		// 삭제할 문자열 추출
		if (startIdx > -1) {
			String delWords = content.substring(startIdx, endIdx + 1);
			
			// 문자열 변환 
			result = content.replace(delWords, "");
			
			// 또 img태그가 있을 경우,
			if (result.indexOf("<" + tag) > -1) {
				result = deleteAttrDblTag(result, tag);
			}
		}
		
		// div 인 경우, 두칸 띄움
		if ("div".equals(tag.toLowerCase()))
			result = result.replaceAll("</"+tag.toLowerCase()+">", "\n");
		else
			result = result.replaceAll("</"+tag.toLowerCase()+">", "");
		

		return result;
	}
	
	/**
	 * 단일 태그 삭제(ex: <br/>)
	 */
	public static String deleteSingleTag(String content, String tag) {
		
		String result = content;
		
		result = result.replaceAll("<"+tag.toLowerCase()+">", "");
		result = result.replaceAll("<"+tag.toLowerCase()+"/>", "");
		
		result = result.replaceAll("<"+tag.toUpperCase()+">", "");
		result = result.replaceAll("<"+tag.toUpperCase()+"/>", "");
		
		return result;
	}
	
	/**
	 * 모든 태그 삭제
	 */
	public static String deleteAllTag(String content) {
		
		// 범위 지정
		content = deleteAttrDblTag(content, "div");
		content = deleteAttrDblTag(content, "p");
		content = deleteAttrDblTag(content, "b");
		content = deleteAttrDblTag(content, "span");
		content = deleteAttrDblTag(content, "u");		
		content = deleteAttrDblTag(content, "i");
		content = deleteAttrDblTag(content, "strong");
		content = deleteAttrDblTag(content, "font");
		content = deleteAttrDblTag(content, "h1");
		content = deleteAttrDblTag(content, "h2");
		content = deleteAttrDblTag(content, "h3");
		content = deleteAttrDblTag(content, "h4");
		content = deleteAttrDblTag(content, "h5");
		content = deleteAttrDblTag(content, "h6");
		content = deleteAttrDblTag(content, "a");
		
		// img
		content = deleteAttrDblTag(content, "img");

		// Table
		content = deleteAttrDblTag(content, "table");
		content = deleteAttrDblTag(content, "thead");
		content = deleteAttrDblTag(content, "tbody");
		content = deleteAttrDblTag(content, "tr");
		content = deleteAttrDblTag(content, "th");
		content = deleteAttrDblTag(content, "td");
		content = deleteAttrDblTag(content, "colgroup");
		content = deleteAttrDblTag(content, "col");
		
		// 단일 태그
		content = deleteSingleTag(content, "br");	// 개행
		content = deleteSingleTag(content, "hr");	// 가로줄
		
		// 기타 등등
		content = content.replaceAll("&nbsp;", " ");
		content = content.replaceAll("&lt;", "<");
		content = content.replaceAll("&gt;", ">");
		
		return content;
	}
	
	/**
	 * 응답속도 체크용 로그남기기
	 */
	public static void printElapseTime(long startTime) {
		long curTime = System.currentTimeMillis();
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		
		String startStr = dayTime.format(new Date(startTime));
		System.out.println("================== 응답시간 체크 ==================");
		System.out.println("시작시간 : " + startStr);
		String curStr = dayTime.format(new Date(curTime));
		System.out.println("현재시간 : " + curStr);
		System.out.println((curTime-startTime)/1000 + "초 걸림");
		System.out.println("===================================================");
	}
	
	/**
	 * checkbox에 바인딩된 내용, javascript에서 쓸수있도록 String형 전환
	 *  [1, 2] -> "1,2"
	 */
	public static String convertSearchData(String[] strArr) throws Exception {
		String str = "";
		
		for (int i=0; i<strArr.length; i++) {
			if (!"fakeValue".equals(strArr[i]))
				str += strArr[i] + ",";
		}
		
		if (str != "")
			str = str.substring(0, str.length()-1);
		
		return str;
	}
}
