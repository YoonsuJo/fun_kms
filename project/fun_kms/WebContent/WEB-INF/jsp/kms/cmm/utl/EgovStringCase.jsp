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
<title>문자열 변환</title>
<script type="text/javascript">
	function process() {
		var frm = document.frm;

		if (frm.isCapital[0].checked == false && frm.isCapital[1].checked == false) {
			alert('대/소문자 여부을 선택해 주세요.');
			return;
		}

		if (frm.srcString.value == '') {
			alert('대상 문자열을 입력해 주세요.');
			frm.srcString.focus();
			return;
		}
		
		frm.submit();
	}
</script>
</head>
<body>
<form name="frm" action ="./EgovComUtlTest.do" method="post">
<input type = "hidden" name="cmdStr" value="REQ-COM-139">

<input type = "hidden" name="source" value="">
<input type = "hidden" name="subject" value="">
<input type = "hidden" name="object" value="">
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
		<td>
		주어진 문자열을 대문자 혹은 소문자로 바꾼다.
		</td>
	</tr>
	<tr>		
		<td>
		   대상 문자열:<input type = "text" name="srcString">
		</td>
		<td>
		    대/소문자 여부:  대문자<input type = "radio" name="isCapital" value="Y">
		    &nbsp;소문자 <input type = "radio" name="isCapital" value="N">
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