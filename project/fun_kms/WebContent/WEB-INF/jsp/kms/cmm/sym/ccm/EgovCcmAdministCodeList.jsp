<%
 /**
  * @Class Name  : EgovCcmAdministCodeList.jsp
  * @Description : EgovCcmAdministCodeList 화면
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
<title>행정코드 목록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="/css/egovframework/cmm/sym/ccm/com.css">
<link href="<c:url value='/css/egovframework/cmm/sym/ccm/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/sym/ccm/adc/EgovCcmAdministCodeList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fnSearch(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fnRegist(){
	location.href = "/sym/ccm/adc/EgovCcmAdministCodeRegist.do";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnModify(){
	location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fnDetail(administZoneSe,administZoneCode){
	var varForm				       = document.all["Form"];
	varForm.action                 = "<c:url value='/sym/ccm/adc/EgovCcmAdministCodeDetail.do'/>";
	varForm.administZoneSe.value   = administZoneSe;
	varForm.administZoneCode.value = administZoneCode;
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	// 
}
-->
</script>
</head>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<body>
<DIV id="content" style="display">
<form name="listForm" action="<c:url value='/sym/ccm/adc/EgovCcmAdministCodeList.do'/>" method="post">
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%"class="title_left"><h1 class="title_left">
   <img src="/images/egovframework/cmm/sym/ccm/icon/tit_icon.gif" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목">&nbsp;행정코드 목록</h1></td>
  <th>
  </th>
  <td width="10%">
   	<select name="searchCondition" class="select" title="" id="searchCondition">
		   <option selected value=''>--선택하세요--</option>
		   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><label for="searchKeyword">법정동 지역명</label></option>
		   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><label for="searchKeyword">행정동 지역명</label></option>
	   </select>
	</td>
  <td width="35%">
    <input name="searchKeyword" type="text" size="35" value="${searchVO.searchKeyword}"  maxlength="35" id="searchKeyword"> 
  </td>
  <th width="10%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><span class="button"><input type="submit" value="조회" onclick="fnSearch(); return false;"></span></td>

      <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="등록" width="8" height="20"></td>
      <td style="background-image:URL(<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fnRegist(); return false;">등록</a></td>
      <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="등록" width="8" height="20"></td>
    </tr>
   </table>
  </th>  
 </tr>
</table>

<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<table width="700" cellpadding="0" class="table-line" border="0" summary="구분, 행정구역코드, 행정구역명, 사용여부가 담긴 행정코드 목록을 조회한다.">
<CAPTION style="display: none;">행정코드 목록</CAPTION>
<thead>
<tr>  
	<th scope="col" class="title" width="10%" nowrap>순번</th>
	<th scope="col" class="title" width="15%" nowrap>구분</th>
	<th scope="col" class="title" width="15%" nowrap>행정구역코드</th>
	<th scope="col" class="title" width="50%" nowrap>행정구역명</th>
	<th scope="col" class="title" width="10%" nowrap>사용여부</th>
</tr>
</thead>    
<tbody>
<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fnDetail('${resultInfo.administZoneSe}', '${resultInfo.administZoneCode}');">
	<td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
	<td class="lt_text3" nowrap>
		<c:choose>
			<c:when test='${resultInfo.administZoneSe == "1"}'>법정동</c:when>
			<c:when test='${resultInfo.administZoneSe == "2"}'>행정동</c:when>
		</c:choose>
	</td>
	<td class="lt_text3" nowrap>${resultInfo.administZoneCode}</td>
	<td class="lt_text"  nowrap>${resultInfo.administZoneNm}</td>
	<td class="lt_text3" nowrap><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
</tr>   
</c:forEach>

<c:if test="${fn:length(resultList) == 0}">
	<tr> 
		<td class="lt_text3" colspan=5>
			<spring:message code="common.nodata.msg" />
		</td>
	</tr>   	          				 			   
</c:if>
    	
    	
</tbody>  
</table>

<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<div align="center">
	<div>
		<ui:pagination paginationInfo = "${paginationInfo}"
				type="image"
				jsFunction="linkPage"
				/>
	</div>
</div>

<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

</form>
<form name="Form" method="post">
	<input type=hidden name="administZoneSe">
	<input type=hidden name="administZoneCode">
	<input type="submit" id="invisible" class="invisible"/>
</form>

</DIV>
</body>
</html>
