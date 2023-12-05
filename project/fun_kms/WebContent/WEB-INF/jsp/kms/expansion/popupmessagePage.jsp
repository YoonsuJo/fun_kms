<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language = "javascript">
function showMessagebox(str){		
	alert(str);		
	this.close();
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title></title>
</head>
<body onload="javascript:showMessagebox('${message}');">
<form name="mgsForm" method="post">
<input type="hidden" name="message" value="${message}"/>
</form>
</body>
</html>