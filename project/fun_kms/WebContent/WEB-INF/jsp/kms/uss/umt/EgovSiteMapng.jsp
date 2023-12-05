<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="egovframework.com.uss.umt.web.EgovSiteMapngController"  %>
<%@ page import="egovframework.com.uss.umt.service.SiteMapngVO"  %>
<%
 /**
  * @Class Name : EgovSiteMapng.jsp
  * @Description : 사이트맵 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.10    이용          최초 생성
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *  
  */
 
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/uss/umt/icon/";
  String imagePath_button = "/images/egovframework/uss/umt/button/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/css/egovframework/uss/umt/map.css" type="text/css">
<title>사이트맵</title>
<script language="javascript1.2">
<!--
/* ********************************************************
 * 조회 함수
 ******************************************************** */
function fSiteMapng() {
	document.siteMapngForm.action = "<c:url value='/uss/umt/EgovSiteMapng.action'/>";
    document.siteMapngForm.submit();
}
/* ********************************************************
 * Url Call 함수
 ******************************************************** */
function fCallUrl(fURL){
	window.location = fURL;
}
-->
</script>
</head>
<body> 
<form name="siteMapngForm" action ="javascript:fSiteMapng()" method="post">

<DIV id="main" style="display:"> 

<table width="717" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%"class="title_left">
  <img src="<%=imagePath_icon %>tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle">&nbsp;사이트맵</td>
  <td width="10%">&nbsp;</td>
  <td widht="25%">&nbsp;</td>
  <th width="25%"></th>
 </tr>
</table>
  
<input type="hidden" name="scrtyId" value="">
<c:import url="${fn:trim(resultVO.bndeFileNm)}" />
</DIV>
</form>
</body>
</html>

