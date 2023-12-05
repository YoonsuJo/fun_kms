<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
<title>문자열 유효성 체크</title>
<script type="text/javascript">
	function process() {
		var frm = document.frm;

		if (frm.sourceStr.value == '') {
			alert('원 문자열을 입력해 주세요.');
			frm.sourceStr.focus();
			return;
		}

		if (frm.compareStr.value == '') {
			alert('비교 문자열을 입력해 주세요.');
			frm.compareStr.focus();
			return;
		}
		
		frm.submit();
	}
</script>
</head>
<body>
<form name="frm" action ="./EgovComUtlTest.do" method="post">
<input type = "hidden" name="cmdStr" value="REQ-COM-141">
<input type = "hidden" name="srcString" value="">
<input type = "hidden" name="isCapital" value="">
<input type = "hidden" name="source" value="">
<input type = "hidden" name="subject" value="">
<input type = "hidden" name="object" value="">

<input type = "hidden" name="searchStr" value="">
<input type = "hidden" name="strCode" value="">
<input type = "hidden" name="keyStr" value="">
<input type = "hidden" name="oprStr" value="">
<input type = "hidden" name="valStr" value="">
<table border="1">
	<tr>        	
		<td colspan="2">
		기능설명:
		두 개의 문자열을 비교하여 서로 값이 같은지를 확인한다.
		</td>
	</tr>
	<tr>		
		<td>
		    원 문자열:<input type = "text" name="sourceStr">
		</td>
		<td>
		    비교 문자열:<input type = "text" name="compareStr" >
		</td>
	</tr>
	<tr>	
		<td >
		    결과:<c:out value="${result}"/>
		</td>					
		<td> <input type = "button" method="post"  value="실행!" onclick="process()">
		</td>				
	</tr> 
</table>
</form>
</body>
</html>