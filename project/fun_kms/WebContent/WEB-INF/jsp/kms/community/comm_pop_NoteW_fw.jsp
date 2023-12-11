<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/notepop_inc.jsp"%>
<script>
$(document).ready(function() {
	
	//alert("${message}");
	
	if (confirm('업무연락 조회권한이 없습니다.\n작성자에게 수신자 추가 요청을 하시겠습니까?')) {
		//var form = document.note;
		
		//form.action = "<c:out value='${rootPath}/community/sendNoteView.do'/>";
		//form.target = "_POP_NOTE_WRITE_";
		//form.submit();
		
		window.open('${rootPath}/community/sendNoteView.do?sendOriMsgYn=Y&noteCn=${noteVO.noteCn}&recieverNo=${noteVO.recieverNo}', '_POP_NOTE_WRITE_', 'top=0px, left=0px, width=500px, height=415px, scrollbars=yes');
	}
	history.go(-1);
	/*
	setTimeout(function(){  
		history.go(-1);  
    },1000);
	*/
});
</script>
</head>
<body>
<%--
<form method="GET" name="note">
	<input type="hidden" name="noteCn" value="<c:out value='${noteVO.noteCn}'/>" />
	<input type="hidden" name="recieverNo" value="<c:out value='${noteVO.recieverNo}'/>" />
	<input type="hidden" name="readChk" value="Y" />
</form>
--%>
</body>
</html>