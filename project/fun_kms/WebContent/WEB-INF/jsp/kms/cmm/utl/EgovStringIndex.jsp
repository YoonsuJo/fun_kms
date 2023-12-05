<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"
	"http://java.sun.com/xml/ns/j2ee/web-jsptaglibrary_2_0.xsd">
<html>
<head>
<link href="<c:url value='/css/egovframework/cmm/utl/com.css' />" rel="stylesheet" type="text/css">
<title>문자열 검색</title>
<script type="text/javascript">
	function process() {
		var frm = document.frm;

		if (frm.source.value == '') {
			alert('대상 문자열을 입력해 주세요.');
			frm.source.focus();
			return;
		}

		if (frm.searchStr.value == '') {
			alert('검색대상을 입력해 주세요.');
			frm.searchStr.focus();
			return;
		}
		
		frm.submit();
	}
</script>
</head>
<body>
<form name="frm" action ="./EgovComUtlTest.do" method="post">
<input type = "hidden" name="cmdStr" value="REQ-COM-142">

<input type = "hidden" name="srcString" value="">
<input type = "hidden" name="isCapital" value="">

<input type = "hidden" name="subject" value="">
<input type = "hidden" name="object" value="">
<input type = "hidden" name="sourceStr" value="">
<input type = "hidden" name="compareStr" value="">

<input type = "hidden" name="strCode" value="">
<input type = "hidden" name="keyStr" value="">
<input type = "hidden" name="oprStr" value="">
<input type = "hidden" name="valStr" value="">
<table border="1">
	<tr>        	
		<td>
		기능설명:
		</td>
		<td>
		주어진 문자열을 중 검색대상 문자열의 존재여부를 리턴한다.
		</td>
	</tr>
	<tr>		
		<td>
		   대상 문자열 : <input type = "text" name="source">
		</td>
		<td>
		    검색대상  : <input type = "text" name="searchStr">
		</td>
	</tr>
	<tr>	
		<td>
		    결과:<input type = "text" name="resultString" value='<c:out value="${result}"/>'>
		</td>					
		<td> <input type = "button" method="post"  value="실행!" onclick="process()">
		</td>				
	</tr> 
</table>
</form>
</body>
</html>