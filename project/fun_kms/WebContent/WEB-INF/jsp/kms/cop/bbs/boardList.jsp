<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/cop/bbs/"/>
<% 
 /**
  * @Class Name : EgovNoticeList.jsp
  * @Description : 게시물 목록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.19   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.19
  *  @version 1.0 
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:import url="/common.jsp" />
<link href="<c:url value='/css/egovframework/cop/bbs/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css">
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/egovframework/cop/bbs/EgovBBSMng.js' />" ></script>

<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
	function press(event) {
	}

	function fn_egov_addNotice() {
	}
	
	function fn_egov_select_noticeList(pageNo) {
	}
	
	function fn_egov_inqire_notice(nttId, bbsId) {		
	}
//-->
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
<!--
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_noticeList('1');
		}
	}

	function fn_egov_addNotice() {
		document.frm.action = "<c:url value='/cop/bbs${prefix}/addBoardArticle.do'/>";
		document.frm.submit();
	}
	
	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_inqire_notice(nttId, bbsId) {
		document.subForm.nttId.value = nttId;
		document.subForm.bbsId.value = bbsId;
		document.subForm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
		document.subForm.submit();			
	}
//-->
</script>
</c:otherwise>
</c:choose>
<title><c:out value="${brdMstrVO.bbsNm}"/></title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>
<body>
<div class="bbsMasterMainHead">
		this is head
	</div>
	<c:import url="/cop/bbs/leftMenu.do" />
	
	<div class="bbsMasterMainCenter">
		<div id="border">
			<form name="frm" action ="<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>" method="post">
				<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
<input type="hidden" name="nttId"  value="0" />
<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%" class="title_left">
  	<h1>		
  		<img src="<c:url value='/images/egovframework/cop/bbs/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="">&nbsp;<c:out value="${brdMstrVO.bbsNm}"/>
  	</h1>
  </td>
  <td width="10%"class="title_left">
	<select name="searchCnd" class="select" title="검색조건 선택">
		   <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >제목</option>
		   <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >내용</option>			   
		   <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >작성자</option>			   
	</select>
  </td>
  <td width="35%">
    <input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력"> 
  </td>
  <th width="10%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="<c:out value="${ImgUrl}"/>btn/bu2_left.gif" alt="버튼이미지" title="버튼이미지" width="8" height="20"></td>
      <td class="btnBackground" nowrap><input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_select_noticeList('1'); return false;" style="height:20px;width:26px;padding:0px 0px 0px 0px;" ></td>
      <td><img src="<c:out value="${ImgUrl}"/>btn/bu2_right.gif" alt="버튼이미지" title="버튼이미지" width="8" height="20"></td>

      <c:if test="${brdMstrVO.authFlag == 'Y'}">
	      <td><img src="<c:out value="${ImgUrl}"/>btn/bu2_left.gif" alt="버튼이미지" title="버튼이미지" width="8" height="20"></td>
	      <td class="btnBackground" nowrap><a href="<c:url value='/cop/bbs${prefix}/addBoardArticle.do?bbsId=${boardVO.bbsId}'/>"><spring:message code="button.create" /></a></td>
	      <td><img src="<c:out value="${ImgUrl}"/>btn/bu2_right.gif" alt="버튼이미지" title="버튼이미지" width="8" height="20"></td>
      </c:if>
    </tr>
    
   </table>	  			  
  </th>
 </tr>
 </table>		
</form>		

<table width="100%" cellpadding="8" class="listTable" summary="번호, 제목, 게시시작일, 게시종료일, 작성자, 작성일, 조회수   입니다">
 <thead>
  <tr>
    <!-- th class="title" width="3%" nowrap><input type="checkbox" name="all_check" class="check2"></th-->  
    <th scope="col" class="listTitle" width="10%" nowrap>번호</th>
    <th scope="col" class="listTitle" width="44%" nowrap>제목</th>
   	<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
	    <th scope="col" class="listTitle" width="20%" nowrap>게시시작일</th>
	    <th scope="col" class="listTitle" width="20%" nowrap>게시종료일</th>
   	</c:if>
   	<c:if test="${anonymous != 'true'}">
    	<th scope="col" class="listTitle" width="20%" nowrap>작성자</th>
    </c:if>
    <th scope="col" class="listTitle" width="15%" nowrap>작성일</th>   
    <th scope="col" class="listTitle" width="8%" nowrap>조회수</th>         
  </tr>
 </thead>    
 <tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
	  <tr>
	    <!--td class="lt_text3" nowrap><input type="checkbox" name="check1" class="check2"></td-->
	    <td class="listCenter" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>		    
	    <td class="listLeft" nowrap>
	    	<c:if test="${result.replyLc!=0}">
	    		<c:forEach begin="0" end="${result.replyLc}" step="1">
	    			&nbsp;
	    		</c:forEach>
	    		<img src="<c:url value='/images/egovframework/cop/bbs/icon/reply_arrow.gif'/>" alt="reply arrow">
	    	</c:if>
	    	<c:choose>
	    		<c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
	    			<c:out value="${result.nttSj}" />
	    		</c:when>
	    		<c:otherwise>
		    		<form name="subForm" method="post" action="<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>">
						<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
						<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
						<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
						<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
						<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			    		<span class="link"><input type="submit" style="width:320px;border:solid 0px black;text-align:left; cursor: pointer;" value="<c:out value="${result.nttSj}"/>" onclick="javascript:fn_egov_inqire_notice('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>'); return false;"></span>
			    	</form>    
	    		</c:otherwise>
	    	</c:choose>
	    </td>
    	<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
		    <td class="listCenter" nowrap><c:out value="${result.ntceBgnde}"/></td>
		    <td class="listCenter" nowrap><c:out value="${result.ntceEndde}"/></td>
    	</c:if>
    	<c:if test="${anonymous != 'true'}">
	    	<td class="listCenter" nowrap><c:out value="${result.frstRegisterNm}"/></td>
	    </c:if>
	    <td class="listCenter" nowrap><c:out value="${result.frstRegisterPnttm}"/></td>
	    <td class="listCenter" nowrap><c:out value="${result.inqireCo}"/></td>
	  </tr>
	 </c:forEach>	  
	 <c:if test="${fn:length(resultList) == 0}">
	  <tr>
    	<c:choose>
    		<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
    			<td class="listCenter" colspan="7" ><spring:message code="common.nodata.msg" /></td>
    		</c:when>
    		<c:otherwise>
    			<c:choose>
    				<c:when test="${anonymous == 'true'}">
		    			<td class="listCenter" colspan="4" ><spring:message code="common.nodata.msg" /></td>
		    		</c:when>
		    		<c:otherwise>
		    			<td class="listCenter" colspan="5" ><spring:message code="common.nodata.msg" /></td>
		    		</c:otherwise>
		    	</c:choose>		
    		</c:otherwise>
    	</c:choose>		  
 		  </tr>		 
	 </c:if>  
 </tbody>  
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="10"></td>
  </tr>
</table>					

<div align="center">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />	
</div>	

</div>

	</div>
	<div class="bbsMasterMainRight">
		this is right
	</div>
	<div class="clear">
	</div>
	<div class="bbsMasterMainFooter">
		this is footer
	</div>

</body>
</html>