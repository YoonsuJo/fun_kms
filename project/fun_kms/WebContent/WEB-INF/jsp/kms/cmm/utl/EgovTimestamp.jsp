<%--
  Class Name : EgovTimestamp.jsp
  Description : 응용어플리케이션에서 고유값을 사용하기 위해 시스템에서17자리의TIMESTAMP값을 구하는 기능
  Modification Information
 
      수정일                  수정자                   수정내용
  -------    --------    ---------------------------
 2009.02.01    박정규                 최초 생성
 
    author   : 박정규
    since    : 2009.02.10
   
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" session="false" %>
<%@page import="egovframework.com.utl.fcc.service.EgovStringUtil"  %>
<%@page import="java.util.*"  %>
<%!
    String safeGetParameter (HttpServletRequest request, String name){
        String value = request.getParameter(name);
        if (value == null) {
            value = "";
        }
        return value;
    }
%>


<link href="/css/egovframework/cmm/utl/com.css" rel="stylesheet" type="text/css">

<%
// 준비화면, 실행결과 출력화면의 구분
String execFlag = safeGetParameter(request,"execFlag");
if(execFlag==null || execFlag.equals("")) {
	execFlag="READY";
}
 
%>
<%
if(execFlag.equals("READY")){
	// 실행을 위한 화면 준비
	System.out.println("READY");
%>

<!-- 준비화면  시작-->
<form name="fm125" action ="/EgovPageLink.do" method=post>
<input type = "hidden" name="execFlag" value="REQ-COM-125">
<input type = "hidden" name="cmdStr" value="REQ-COM-125">
<input type = "hidden" name="link" value="cmm/utl/EgovTimestamp">
<table border="1">
	<tr>
		<td>
		기능설명:
		</td>
		<td>
		     응용어플리케이션에서 고유값을 사용하기 위해 시스템에서17자리의TIMESTAMP값을 구하는 기능<br>
		</td>
		<td> 
			<input type = "button" method="post"  value="실행!" onclick="fm125.submit()">
		</td>				
	</tr> 
</table>
</form>
<!--  준비화면 끝 -->

<%	
}else if(execFlag.equals("REQ-COM-125")){
%>

<%
//실행결과 출력화면인 경우 결과정보 확인 - util 형태로 바로 확인

String	resultStr = EgovStringUtil.getTimeStamp();
%>

<!-- 결과화면 시작 -->
<form name="fm125" action ="/EgovPageLink.do" method=post>
<input type = "hidden" name="execFlag" value="READY">
<input type = "hidden" name="cmdStr" 	value="REQ-COM-125">
<input type = "hidden" name="link" value="cmm/utl/EgovTimestamp">
<table border="1">
   	<tr>
   		<td>응용어플리케이션에서 고유값을 사용하기 위해 시스템에서17자리의TIMESTAMP값을 구하는 기능
   		</td>
   		<td>값: <%=resultStr%>
   		</td>   		
   	</tr>
</table> 
<br>
<input type = "button" method="post"  value="화면으로 돌아가기" onclick="fm125.submit()">
</form>
<!--  결과화면 끝 -->


<%
}
%>

