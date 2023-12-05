<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language = "javascript">
function moveToLogin(url){
	var consult_no = "${consult_no}";
	
	// 상담관리 고객정보 전달
	var directConsult = "${directConsult}";
	var custNm = "${custNm}";
	var custManager = "${custManager}";
	var custTelno = "${custTelno}";
	var custEmail = "${custEmail}";
	
	
	var urlAdd = url + "?";
	// 상품관리번호
	if (consult_no!='') urlAdd += '&consult_no='+consult_no;
	
	// 상담접수이동
	if (directConsult!='') urlAdd += '&directConsult='+directConsult;
	if (custNm!='') urlAdd += '&custNm='+custNm;
	if (custManager!='') urlAdd += '&custManager='+custManager;
	if (custTelno!='') urlAdd += '&custTelno='+custManager;
	if (custEmail!='') urlAdd += '&custEmail='+custEmail;
	//opener.location.href=url+'?consult_no=' + consult_no;
	
	// 고객사 수정 후 고객이름 검색
	var searchCust = "${searchCust}";
	if (searchCust!='') urlAdd += '&searchCust='+searchCust;
	
	
	opener.location.href=urlAdd;
	this.close();
	//var frm = document.mgsForm;
	//frm.action=url;
	//frm.submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<body onload="javascript:moveToLogin('${url}');">
<form name="mgsForm" method="post">
<input type="hidden" name="consult_no" value="${consult_no}"/>
</form>
</body>
</html>