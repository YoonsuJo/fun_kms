<%
 /**
  * @Class Name  : EgovCcmExcelZipRegist.jsp
  * @Description : EgovCcmExcelZipRegist 화면
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
<title>우편번호 엑셀파일 등록</title>
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
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_ExcelZip(){
	var varForm				 = document.all["Form"];

	// 파일 확장명 확인
	var arrExt      = "xls";
	var objInput    = varForm.elements["fileNm"];
	var strFilePath = objInput.value;
	var arrTmp      = strFilePath.split(".");
	var strExt      = arrTmp[arrTmp.length-1].toLowerCase();

	if (arrExt != strExt) {
		alert("엑셀 파일을 첨부하지 않았습니다.\n확인후 다시 처리하십시오. ");
		abort;
	} 
	
	varForm.action           = "/sym/ccm/zip/EgovCcmExcelZipRegist.do";
	varForm.submit();

}
-->
</script>
</head>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<body>
<!-- 엑셀 등록 메시지  -->
${sResult}
<DIV id="content" style="width:712px">
<!-- 상단타이틀 -->
<form name="Form" action="<c:url value='/sym/ccm/zip/EgovCcmZipRegist.do'/>" method="post" enctype="multipart/form-data" >
<!-- 상단 타이틀  영역 -->
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%"class="title_left"><h1 class="title_left">
   <img src="/images/egovframework/cmm/sym/zip/icon/tit_icon.gif" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목">&nbsp;우편번호 엑셀파일 등록</h1></td>
 </tr>
</table>
<!-- 줄간격조정  -->
<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<!-- 등록  폼 영역  -->
<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="우편번호 엑셀파일을 첨부할 수 있는 등록 테이블이다.">
<CAPTION style="display: none;">우편번호 엑셀파일 등록</CAPTION>
  <tr>
    <th width="20%" height="23" class="required_text" scope="row" nowrap ><label for="fileNm">우편번호 엑셀파일</label><img src="/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>
  	<td><input name="fileNm" type="file" id="fileNm"/></td>
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

  <td><span class="button"><input type="submit" value="저장" onclick="fn_egov_regist_ExcelZip(); return false;"></span></td>       
</tr>
</table>

<input name="cmd" type="hidden" value="<c:out value='ExcelZipRegist'/>"/>
</form>
</DIV>
</body>
</html>