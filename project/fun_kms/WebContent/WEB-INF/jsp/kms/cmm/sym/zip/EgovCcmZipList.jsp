<%
 /**
  * @Class Name  : EgovCcmZipList.jsp
  * @Description : EgovCcmZipList 화면
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
<title>우편번호 목록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="/css/egovframework/cmm/sym/zip/com.css">
<link href="<c:url value='/css/egovframework/cmm/sym/zip/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fn_egov_search_Zip(){
	sC = document.listForm.searchCondition.value;
	sK = document.listForm.searchKeyword.value; 
	if (sC == "1") {
		document.listForm.searchKeyword.value = sK.replace(/\-/, "");
	}
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Zip(){
	location.href = "/sym/ccm/zip/EgovCcmZipRegist.do";
}
/* ********************************************************
 * 엑셀등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_ExcelZip(){
	location.href = "/sym/ccm/zip/EgovCcmExcelZipRegist.do";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_Zip(){
	location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Zip(zip,sn){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipDetail.do'/>";
	varForm.zip.value        = zip;
	varForm.sn.value         = sn;
	varForm.submit();
}
-->
</script>
</head>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<body>
<DIV id="content" style="display">
<form name="listForm" action="<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>" method="post">
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%"class="title_left"><h1 class="title_left">
   <img src="/images/egovframework/cmm/sym/zip/icon/tit_icon.gif" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목">&nbsp;우편번호 목록</h1></td>
  <th>
  </th>
  <td width="10%">
   	<select name="searchCondition" class="select" title="searchCondition">
		   <option selected value=''>--선택하세요--</option>
		   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><label for="searchKeyword">우편번호</label></option>
		   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><label for="searchKeyword">시도명</label></option>
		   <option value='3' <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>><label for="searchKeyword">시군구명</label></option>
		   <option value='4' <c:if test="${searchVO.searchCondition == '4'}">selected="selected"</c:if>><label for="searchKeyword">읍면동명</label></option>
		   <option value='5' <c:if test="${searchVO.searchCondition == '5'}">selected="selected"</c:if>><label for="searchKeyword">리건물명</label></option>
	   </select>
	</td>
  <td width="35%">
    <input name="searchKeyword" type="text" size="35" value="${searchVO.searchKeyword}"  maxlength="35" id="searchKeyword"> 
  </td>
  <th width="10%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><span class="button"><input type="submit" value="조회" onclick="fn_egov_search_Zip(); return false;"></span></td>

      <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="등록" width="8" height="20"></td>
      <td style="background-image:URL(<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fn_egov_regist_Zip(); return false;">등록</a></td>
      <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="등록" width="8" height="20"></td>
      <td width="10"></td>

      <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="엑셀등록" width="8" height="20"></td>
      <td style="background-image:URL(<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fn_egov_regist_ExcelZip(); return false;">엑셀등록</a></td>
      <td><img src="/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="엑셀등록" width="8" height="20"></td>
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

<table width="700" cellpadding="0" class="table-line" border="0" summary="우편번호와 주소를 출력하는 우편번호 목록 테이블이다.">
<CAPTION style="display: none;">우편번호 목록</CAPTION>
<thead>
<tr>  
	<th class="title" width="10%" scope="col" nowrap>순번</th>
	<th class="title" width="20%" scope="col" nowrap>우편번호</th>
	<th class="title" width="70%" scope="col" nowrap>주소</th>
</tr>
</thead>    

<tbody>
<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fn_egov_detail_Zip('${resultInfo.zip}','${resultInfo.sn}');">
	<td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
	<td class="lt_text3" nowrap><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></td>
	<td class="lt_text"  nowrap>${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm} ${resultInfo.lnbrDongHo}</td>
</tr>   
</c:forEach>

<c:if test="${fn:length(resultList) == 0}">
	<tr>
		<td class="lt_text3" colspan=3>
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
				jsFunction="fn_egov_pageview"
				/>
	</div>
</div>

<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

</form>
<form name="Form" method="post">
	<input type=hidden name="zip">
	<input type=hidden name="sn">
	<input type="submit" id="invisible" class="invisible"/>
</form>
</DIV>


</body>
</html>