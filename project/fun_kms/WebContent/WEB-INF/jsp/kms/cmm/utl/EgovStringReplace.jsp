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
<title>문자열 치환</title>
<script type="text/javascript">
	function process() {
		var frm = document.frm;

		if (frm.source.value == '') {
			alert('원 문자열을 입력해 주세요.');
			frm.source.focus();
			return;
		}

		if (frm.subject.value == '') {
			alert('치환대상 문자열을 입력해 주세요.');
			frm.subject.focus();
			return;
		}

		if (frm.object.value == '') {
			alert('치환 문자열을 입력해 주세요.');
			frm.object.focus();
			return;
		}
		
		frm.submit();
	}
</script>
</head>
<body>
<form name="frm" action ="./EgovComUtlTest.do" method="post">
<input type = "hidden" name="cmdStr" value="REQ-COM-140">

<input type = "hidden" name="srcString" value="">
<input type = "hidden" name="isCapital" value="">
<input type = "hidden" name="sourceStr" value="">
<input type = "hidden" name="compareStr" value="">
<input type = "hidden" name="searchStr" value="">
<input type = "hidden" name="strCode" value="">
<input type = "hidden" name="keyStr" value="">
<input type = "hidden" name="oprStr" value="">
<input type = "hidden" name="valStr" value="">


<table border="1">
	<tr>        	
		<td>
		기능설명:
		</td>
		<td colspan="2">
		원 문자열에서 치환대상 문자열을 치환문자열로 치환한다.
		</td>
	</tr>
	<tr>		
		<td>
		    원 문자열:<input type = "text" name="source">
		</td>
		<td>
		    치환대상 문자열:<input type = "text" name="subject" >
		</td>
		<td>
		    치환 문자열:<input type = "text" name="object" >
		</td>
	</tr>
	<tr>	
		<td colspan="2">
		    결과:<input type = "text" name="resultString" value='<c:out value="${result}"/>'>
		</td>					
		<td> <input type = "button" method="post"  value="실행!" onclick="process()">
		</td>				
	</tr> 
</table>
</form>
</body>
</html>