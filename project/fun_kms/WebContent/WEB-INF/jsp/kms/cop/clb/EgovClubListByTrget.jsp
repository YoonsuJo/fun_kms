<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : EgovClubListByTrget.jsp
  * @Description : 동호회 목록 조회화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.06   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.04.06
  *  @version 1.0 
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/cop/clb/com.css' />" rel="stylesheet" type="text/css" >
<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_clbInfs('1');
		}
	}

	function fn_egov_insert_addClbInf() {
		document.frm.action = "<c:url value='/cop/clb/addCmmntyClubInf.do'/>";
		document.frm.submit();
	}
	
	function fn_egov_select_clbInfs(pageIndex) {
		document.frm.pageIndex.value = pageIndex; 
		document.frm.action = "<c:url value='/cop/clb/selectCmmntyClubList.do'/>";
		document.frm.submit();		
	}
	
	function fn_egov_inqire_clbInf(clbId) {
		document.frm.clbId.value = clbId;
		document.frm.action = "<c:url value='/cop/clb/selectCmmntyClubInf.do'/>";
		document.frm.submit();		
	}
</script>
<title>동호회 목록</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body>
<form name="frm" method="post">
<input type="hidden" name="cmmntyId" />
<input type="hidden" name="clbId" />
<input type="hidden" name="trgetId" value="${trgetId}" />
<input type="hidden" name="trgetNm" value="${trgetNm}" />

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="40%"class="title_left">
	  <img src="<c:url value='/images/egovframework/cop/clb/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="">
	   &nbsp;동호회 목록 </td>
	  <th >
	  </th>
	  <td width="10%" >
	   	<select name="searchCnd" class="select">
			   <!-- option selected value=''>--선택하세요--</option-->
			   <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >동호회명</option>
			   <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >커뮤니티명</option>
		   </select>
		</td>
	  <td widht="35%">
	    <input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);"> 
	  </td>
	  <th width="10%">
	   <table border="0" cellspacing="0" cellpadding="0">
	    <tr> 
	      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_left.gif' />" width="8" height="20" alt="button left"></td>
	      <td background="<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>" class="text_left" nowrap>
	      <a href="javascript:fn_egov_select_clbInfs('1')">조회</a> 
	      </td>
	      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td>
	      <td>&nbsp;&nbsp;</td>
	      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_left.gif'/>" width="8" height="20" alt="button left"></td>
	      <td background="<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>" class="text_left" nowrap>
	      <a href="javascript:fn_egov_insert_addClbInf()">등록</a> 
	      </td>
	      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td>    
	    </tr>
	   </table>
	  </th>  
	 </tr>
	</table>
	<table width="100%" cellpadding="8" class="table-line">
	 <thead>
	  <tr>
	    <th class="title" width="10%" nowrap>번호</th>
	    <th class="title" width="30%" nowrap>동호회명</th>
	    <th class="title" width="20%" nowrap>커뮤니티명</th>
	    <th class="title" width="20%" nowrap>등록일</th>
	    <th class="title" width="17%" nowrap>사용여부</th>   
	  </tr>
	 </thead>    
	 <tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
		    <td class="lt_text3" nowrap>
		     	<a href="javascript:fn_egov_inqire_clbInf('<c:out value="${result.clbId}"/>')">
		    	<c:out value="${result.clbNm}"/></a>
		    </td>
		    <td class="lt_text3" nowrap><c:out value="${result.cmmntyNm}"/></td>
		    <td class="lt_text3" nowrap><c:out value="${result.frstRegisterPnttm}"/></td>
		    <td class="lt_text3" nowrap>
		    	<c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
		    	<c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>		    
		    </td>  
		  </tr>		
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td class="lt_text3" nowrap colspan="5"><spring:message code="common.nodata.msg" /></td>  
		  </tr>		 
		 </c:if>	
	 </tbody>  
	 <!--tfoot>
	  <tr class="">
	   <td colspan=6 align="center"></td>
	  </tr>
	 </tfoot -->
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td height="10"></td>
	  </tr>
	</table>
	<div align="center">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_clbInfs" />
	</div>
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

</div>
</form>
</body>
</html>