<%
 /**
  * @Class Name  : EgovCcmZipRegist.jsp
  * @Description : EgovCcmZipRegist 화면
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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<title>우편번호 등록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="/css/egovframework/cmm/sym/zip/zip.css">
<link href="<c:url value='/css/egovframework/cmm/sym/zip/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="zip" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Zip(){
	location.href = "/sym/ccm/zip/EgovCcmZipList.do";
}
/* ********************************************************
 * 등록처리
 ******************************************************** */
function fn_egov_regist_Zip(form){
	if(confirm("<spring:message code='common.save.msg'/>")){
		if(!validateZip(form)){ 			
			return;
		}else{
			form.submit();
		}
	}
}
-->
</script>
</head>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<body>
<DIV id="content" style="width:712px">
<!-- 상단타이틀 -->
<form:form commandName="zip" name="zip" method="post">

<!-- 상단 타이틀  영역 -->
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%"class="title_left"><h1 class="title_left">
   <img src="/images/egovframework/cmm/sym/zip/icon/tit_icon.gif" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목">&nbsp;우편번호 등록</h1></td>
 </tr>
</table>
<!-- 줄간격조정  -->
<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<!-- 등록  폼 영역  -->
<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="우편번호, 시도명, 시군구명, 읍면동명, 리건물명, 번지동호를 입력하는 우편번호 등록 테이블입니다.">
<CAPTION style="display: none;">우편번호 등록</CAPTION>
  <tr> 
    <th width="20%" height="23" class="required_text" scope="row" nowrap ><label for="zip">우편번호</label><img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>
    <td width="80%" nowrap>
      <form:input  path="zip" size="6" maxlength="6" id="zip"/>
      <form:errors path="zip"/> &nbsp;* 우편번호의 '-'를 제외하고 입력하시오.
    </td>
  </tr>
  <tr>
    <th width="20%" height="23" class="required_text" scope="row" nowrap ><label for="ctprvnNm">시도명</label><img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td width="80%" nowrap>
      <form:input  path="ctprvnNm" size="20" maxlength="20" id="ctprvnNm"/>
      <form:errors path="ctprvnNm"/>
    </td>
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" scope="row" nowrap ><label for="signguNm">시군구명</label><img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td width="80%" nowrap>
      <form:input  path="signguNm" size="20" maxlength="20" id="signguNm"/>
      <form:errors path="signguNm"/>
    </td>
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" scope="row" nowrap ><label for="emdNm">읍면동명</label><img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td width="80%" nowrap>
      <form:input  path="emdNm" size="30" maxlength="30" id="emdNm"/>
      <form:errors path="emdNm"/>
    </td>
  </tr> 
  <tr>
    <th width="20%" height="23" scope="row" nowrap ><label for="liBuldNm">리건물명</label></th>          
    <td width="80%" nowrap>
      <form:input  path="liBuldNm" size="60" maxlength="60" id="liBuldNm"/>
      <form:errors path="liBuldNm"/>
    </td>
  </tr> 
  <tr>
    <th width="20%" height="23" scope="row" nowrap ><label for="lnbrDongHo">번지동호</label></th>          
    <td width="80%" nowrap>
      <form:input  path="lnbrDongHo" size="20" maxlength="20" id="lnbrDongHo"/>
      <form:errors path="lnbrDongHo"/>
    </td>    
  </tr> 
</table>
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="10"></td>
  </tr>
</table>

<!-- 줄간격조정  -->
<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>
<!-- 목록/저장버튼  -->
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
  <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="목록" width="8" height="20"></td>
  <td style="background-image:URL(<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fn_egov_list_Zip(); return false;">목록</a></td>
  <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="목록" width="8" height="20"></td>      
  <td width="10"></td>
 
  <td><span class="button"><input type="submit" value="저장" onclick="fn_egov_regist_Zip(document.zip); return false;"></span></td>      
</tr>
</table>

<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
</form:form>
</DIV>
</body>
</html>