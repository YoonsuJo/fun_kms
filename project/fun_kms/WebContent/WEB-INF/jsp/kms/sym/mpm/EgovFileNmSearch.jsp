<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /** 
  * @Class Name : EgovFileNmSearch.jsp
  * @Description : 프로그램파일명 검색 화면
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
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon/";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="/css/egovframework/sym/mpm/com.css" type="text/css">
<link rel="stylesheet" href="/css/egovframework/sym/mpm/button.css" type="text/css">
<title>프로그램파일명 검색</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script language="javascript1.2"  type="text/javaScript"> 
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.progrmManageForm.pageIndex.value = pageNo;
	document.progrmManageForm.action = "<c:url value='/sym/mpm/EgovProgramListSearch.do'/>";
   	document.progrmManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */ 
function selectProgramListSearch() { 
	document.progrmManageForm.pageIndex.value = 1;
	document.progrmManageForm.action = "<c:url value='/sym/mpm/EgovProgramListSearch.do'/>";
	document.progrmManageForm.submit();
}

/* ********************************************************
 * 프로그램목록 선택 처리 함수
 ******************************************************** */ 
function choisProgramListSearch(vFileNm) { 
	eval("opener.document.all."+opener.document.all.tmp_SearchElementName.value).value = vFileNm;
    window.close();
}
-->
</script>
</head>
<body> 
<form name="progrmManageForm" action ="<c:url value='/sym/mpm/EgovProgramListSearch.do'/>" method="post">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<DIV id="main" style="display:"> 

<table width="450" cellpadding="8" class="table-search" border="0" align="center">
 <tr>
  <td width="40%"class="title_left"> 
   <h1><img src="<%=imagePath_icon %>tit_icon.gif" width="16" height="16" hspace="3" alt="" >&nbsp;프로그램파일명 검색</h1></td>
  <th >
  </th>
  <td width="10%" ></td>
  <td width="35%"></td> 
  <th width="10%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td></td>      
    </tr>
   </table>
  </th>  
 </tr>
</table>
<table width="450" border="0" cellpadding="0" cellspacing="1" align="center">
 <tr>
  <td width="100%"> 
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
      <tr> 
        <th width="30%" height="40" class=""  scope="row"><label for="searchKeyword">프로그램파일명</label><img src="<%=imagePath_icon %>required.gif" width="15" height="15" alt="필수" ></th>
        <td width="70%">
          <table border="0" cellspacing="0" cellpadding="0" align="left">
            <tr> 
              <td >&nbsp;<input name="searchKeyword" type="text" size="30" value=""  maxlength="60" title="검색조건"></td>
              <td width="5%"></td>
              <td><span class="button"><input type="submit" value="<spring:message code="button.inquire" />" onclick="selectProgramListSearch(); return false;"></span></td>  
            </tr>
          </table> 
        </td>
      </tr> 
    </table>
   </td>
 </tr>    
</table>
<table width="450" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="10">&nbsp; </td>
  </tr>
</table>
<table width="450" cellpadding="8" class="table-line" align="center" summary="프로그램파일명 검색목록으로 프로그램파일명 프로그램명으로 구성됨" >
	<caption>프로그램파일명 검색</caption>
 <thead>
  <tr>
    <th class="title" width="50%" scope="col">프로그램파일명</th>
    <th class="title" width="50%" scope="col">프로그램명</th>
  </tr>
 </thead>    
 <tbody>
 <c:forEach var="result" items="${list_progrmmanage}" varStatus="status">
  <tr>
    <td class="lt_text3">
      <span class="link"><a href="#LINK" onclick="choisProgramListSearch('<c:out value="${result.progrmFileNm}"/>'); return false;">
      <c:out value="${result.progrmFileNm}"/></a></span></td>
    <td class="lt_text3"><c:out value="${result.progrmKoreanNm}"/></td>
  </tr>
 </c:forEach>
 </tbody>  
 <!--tfoot>
  <tr class="">
   <td colspan=6 align="center"></td>
  </tr>
 </tfoot -->
</table>
<table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td height="10"></td>
  </tr>
  <tr> 
    <td height="10">
<!-- 페이징 시작 -->
<div align="center">
  <div>
	<ui:pagination paginationInfo = "${paginationInfo}"	type="image" jsFunction="linkPage"/>
  </div>
</div>
<!-- 페이징 끝 -->
    </td>
  </tr>
</table>

</DIV>
</form>
</body>
</html>

