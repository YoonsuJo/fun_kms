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
<title>메시지 조회</title>
<script type="text/javascript">
	function process() {
		var frm = document.frm;

		if (frm.strCode.value == '') {
			alert('메시지 키값을 입력해 주세요.');
			frm.strCode.focus();
			return;
		}
		
		frm.submit();
	}
</script>
</head>
<body>
<form name="frm" action ="./EgovComUtlTest.do" method="post">
<input type = "hidden" name="srcString" value="">
<input type = "hidden" name="isCapital" value="">
<input type = "hidden" name="source" value="">
<input type = "hidden" name="subject" value="">
<input type = "hidden" name="object" value="">
<input type = "hidden" name="sourceStr" value="">
<input type = "hidden" name="compareStr" value="">
<input type = "hidden" name="searchStr" value="">

<input type = "hidden" name="keyStr" value="">
<input type = "hidden" name="oprStr" value="">
<input type = "hidden" name="valStr" value="">

<table border="1">
	<tr>        	
		<td colspan="3">
		기능설명:
		주어진 조건에 맞는 메시지를 확인할 수 있는 기능을 제공
		</td>
	</tr>
	<tr>		
		<td>
		   메시지 종류 : <select name="cmdStr">
		   				<option value="REQ-COM-126">경고</option>
		   				<option value="REQ-COM-127">에러</option>
		   				<option value="REQ-COM-128">정보</option>
		   				<option value="REQ-COM-129">확인</option>
		   			</select>
		</td>
		<td>
		    메시지 키  : <input type="text" name="strCode">
		</td>
		<td> <input type="button" value="실행!" onclick="process()">
		</td>			
	</tr>
	<tr>	
		<td colspan="3">
		    결과메시지:<c:out value="${result}"/>
		</td>					
			
	</tr> 
</table>
</form>
</body>
</html>