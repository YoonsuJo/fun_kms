<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link type="text/css" href="style.css" rel="stylesheet" charset="utf-8"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="print" uri="print" %>
<link rel="stylesheet" href="${commonPath}/css/goodmorning_style.css" type="text/css" media="all" />


<script>
function update() {
	/*
	var nttSj = document.board.nttSj.value;
	nttSj = nttSj.replace(/\r\n/g, '<br/>');
	nttSj = nttSj.replace(/\n/g, '<br/>');
	nttSj = nttSj.replace(/\r/g, '<br/>');
	document.board.nttSj.value = nttSj; 
	*/
	
	document.board.action = "<c:url value='${rootPath}/community/updateBoardArticle.do'/>";
	document.board.submit();					
}
function listArticle() {
	document.board.action = "<c:url value='${rootPath}/community/selectBoardList.do'/>";
	document.board.submit();
}
</script>

</head>

<body>
<form:form commandName="commBoard" name="board" method="post" enctype="multipart/form-data" >
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/community/forUpdateBoardArticle.do'/>"/>
<input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
<input type="hidden" name="tmplatId" value="<c:out value='${bdMexHmstr.tmplatId}'/>" />
<input type="hidden" name="exDt" value="<c:out value='99991231'/>" />
<input type="hidden" name="exHm" value="<c:out value='${result.exHm}'/>" />

<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
<input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />



<div class="morning">
	<div class="top">한마음 아침인사 등록</div>
    <div class="morning_con">
    	<div class="greeting">
        <p class="greeting_tl">오늘의 한마음 첫 출근자입니다. 한마음 임직원에게 아침인사를 남겨주세요.</p>
        	<div class="regist" >
            	<textarea name="nttSj" id="nttSj">${result.nttSj}</textarea>
            </div>
        </div>
        <div class="btn_area">
        	<a href="javascript:update();" class="btn"><img src="${imagePath}/btn/btn_regist.gif" alt="등록" /></a>
	    	<a href="javascript:self.close();" class="btn"><img src="${imagePath}/btn/btn_close.gif" alt="창닫기" /></a>
        </div>
    </div>
</div>
</form:form>
</body>
</html>
