<%
 /**
  * @Class Name  : EgovCcmZipDetail.jsp
  * @Description : EgovCcmZipDetail 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *
  *  @author 공통서비스팀 
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *  
  */
%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<title>우편번호 상세조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="/css/egovframework/cmm/sym/zip/com.css">
<link href="<c:url value='/css/egovframework/cmm/sym/zip/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Zip(){
	location.href = "/sym/ccm/zip/EgovCcmZipList.do";
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fn_egov_modify_Zip(){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipModify.do'/>";
	varForm.zip.value        = "${result.zip}";
	varForm.sn.value         = "${result.sn}";
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_Zip(){
	if (confirm("<spring:message code='common.delete.msg'/>")) {
		var varForm				 = document.all["Form"];
		varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipRemove.do'/>";
		varForm.zip.value        = "${result.zip}";
		varForm.sn.value         = "${result.sn}";
		varForm.submit();
	}
}
-->
</script>
</head>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<body>
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%" class="title_left"><h1 class="title_left">
   <img src="/images/egovframework/cmm/sym/zip/icon/tit_icon.gif" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목">&nbsp;우편번호 상세조회</h1></td>
 </tr>
</table>
<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="우편번호, 시도명, 시군구명, 읍면동명, 리건물명, 번지동호를 가지고 있는 우편번호 상세조회 테이블이다.">
<CAPTION style="display: none;">우편번호 상세조회</CAPTION>
  <tr> 
    <th width="20%" height="23" class="required_text" scope="row" nowrap >우편번호<img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>
    <td><c:out value='${fn:substring(result.zip, 0,3)}'/>-<c:out value='${fn:substring(result.zip, 3,6)}'/></td>
  </tr>
  <tr>
    <th width="20%" height="23" class="required_text" scope="row" nowrap >시도명<img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.ctprvnNm}</td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" scope="row" nowrap >시군구명<img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.signguNm}</td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" scope="row" nowrap >읍면동명<img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.emdNm}</td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" scope="row" nowrap >리건물명<img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.liBuldNm}</td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" scope="row" nowrap >번지동호<img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.lnbrDongHo}</td>    
  </tr> 
</table>
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="10"></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
  <td><span class="button"><input type="submit" value="수정" onclick="fn_egov_modify_Zip(); return false;"></span></td>

  <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="삭제" width="8" height="20"></td>  
  <td style="background-image:URL(<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fn_egov_delete_Zip(); return false;">삭제</a></td>  
  <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="삭제" width="8" height="20"></td>
  <td width="10"></td>

  <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="목록" width="8" height="20"></td>
  <td style="background-image:URL(<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fn_egov_list_Zip(); return false;">목록</a></td>
  <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="목록" width="8" height="20"></td>           
</tr>
</table>
<form name="Form" method="post">
	<input type=hidden name="zip">
	<input type=hidden name="sn">
	<input type="submit" id="invisible" class="invisible"/>
</form>
</body>
</html>