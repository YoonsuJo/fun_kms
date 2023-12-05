	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script>
$(document).ready(function(){
	;
});
function search(){
	document.frm.action = '<c:url value="${rootPath}/admin/status/loginStatusL.do" />';
	document.frm.submit();
}
</script>
</head>

<body>

<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">로그인 현황</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
					
					
					<p class="th_stitle"><print:user userNo="${memberInfo.member.no}" userNm="${memberInfo.member.userNm }" userId="${memberInfo.member.userId}" printId="true"/> 월별 로그인 현황</p>
					
					<!-- 상단 검색창 시작 -->
					<form name="frm" action="${rootPath}/admin/status/loginStatusL.do" method="POST" onsubmit="search(0); return false;">
					<input type="hidden" name="searchDate" value="${searchDate}"/>
					</form>
			       	<!-- 상단 검색창 끝 -->
	            
           		 	<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col140" />
	                    	<col width="px" />
	                    	<col width="px" />
                    	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>순번</th>
	                    		<th>로그인 날짜</th>
	                    		<th class="td_last">최초 로그인 시각</th>
	                    	</tr>
	                    	
	                    </thead>
	                    <tbody>
	                    	<c:choose>
	                    	<c:when test="${empty resultList}">
	                    		<tr>
	                    			<td class="txt_center td_last" colspan="3">※ 해당 월의 사용자 로그인 내역이 없습니다.</td>
	                    		</tr>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<c:forEach items="${resultList}" var="result" varStatus="c">
			                    	<tr>
				                    	<td class="txt_center">${c.count}</td>
				                    	<td class="txt_center"><print:date date="${result.attendDt}"/></td>
				                    	<td class="txt_center td_last">${result.attendTm}</td>
			                    	</tr>
		                    	</c:forEach>
	                    	</c:otherwise>
	                    	</c:choose>
	                    </tbody>
	                    </table>
					</div>
					
					<div class="btn_area">
	                	<a href="javascript:search();"><img src="${imagePath }/admin/btn/btn_list.gif" /></a>
                	</div>
					<!--// 게시판 끝  -->
		                
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
