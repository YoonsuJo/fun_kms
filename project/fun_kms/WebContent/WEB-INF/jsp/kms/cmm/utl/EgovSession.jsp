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
<title>세션검출</title>
</head>
<script type="text/javascript">
	function process() {
		var frm = document.frm;

		if (frm.oprStr[0].checked == false && frm.oprStr[1].checked == false) {
			alert('기능을 선택해 주세요.');
			return;
		}

		if (frm.keyStr.value == '') {
			alert('세션 키값을 입력해 주세요.');
			frm.keyStr.focus();
			return;
		}
		
		frm.submit();
	}
</script>
<body>
<form name="frm" action ="./EgovComUtlTest.do" method="post">
<input type = "hidden" name="cmdStr" value="REQ-COM-107">
<input type = "hidden" name="srcString" value="">
<input type = "hidden" name="isCapital" value="">
<input type = "hidden" name="source" value="">
<input type = "hidden" name="subject" value="">
<input type = "hidden" name="object" value="">
<input type = "hidden" name="sourceStr" value="">
<input type = "hidden" name="compareStr" value="">
<input type = "hidden" name="searchStr" value="">
<input type = "hidden" name="strCode" value="">

<table border="1">
	<tr>        	
		<td colspan="3">
		기능설명:

		주어진 키 값으로 세션을 생성하고, 호출하고, 삭제하는 기능
		</td>
	</tr>
	<tr>        	
	<td colspan="3">
		생성 : <input type="radio" name="oprStr" value="C">
		삭제 : <input type="radio" name="oprStr" value="D">
	</td>
	</tr>	
	<tr>		
		<td>
		세션 키 : <input type="text" name="keyStr">
		</td>
		<td>
		세션 값 : <input type="text" name="valStr">
		</td>
		<td> 
			<input type="button" value="실행!" onclick="process()">
		</td>		
	</tr>
	<tr>	
		<td  colspan="3">
		    결과: <c:out value="${result}"/>
		</td>					
				
	</tr> 
</table>	
</form>
</body>
</html>