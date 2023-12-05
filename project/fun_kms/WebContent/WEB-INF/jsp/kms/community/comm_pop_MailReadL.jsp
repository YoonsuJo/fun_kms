<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "<c:url value='${rootPath}/community/selectSendMailState.do'/>";
	document.frm.submit();
}
</script>
</head>

<body><div id="pop_message">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">열람상태</li>
		</ul>
 	</div>
 	
 	<div id="pop_con"> 		
 		<table cellpadding="0" cellspacing="0">
 			<caption>열람상태</caption>
 			<colgroup><col class="col5" /><col class="col50" /><col width="px" /><col class="col120" /><col class="col90" /><col class="col5" /></colgroup>
 			<thead>
 				 <tr>
					<th class="th_left"></th>
					<th class="title" scope="col">번호</th>
					<th class="title" scope="col">받는사람</th>
					<th class="title" scope="col">수신확인일시</th>
					<th class="title" scope="col">상태</th>
					<th class="th_right"></th>
				</tr> 
 			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="c">
					<tr>
						<td class="txt_center" colspan="2"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
						<td class="txt_center"><print:user userNo="${result.recieverNo}" userNm="${result.recieverNm}" userId="${result.recieverId}" printId="true"/></td>
						<td class="txt_center">
							<c:choose>
								<c:when test="${not empty result.readDt}"><c:out value="${result.readDt}"/></c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</td>
						<td class="txt_center" colspan="2">
							<c:choose>
								<c:when test="${not empty result.readDt}">읽음</c:when>
								<c:otherwise><span class="txt_blue">미열람</span></c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
 		</table>
		<form name="frm" method="POST" action="<c:url value='${rootPath}/community/selectSendMailState.do'/>">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input name="mailId" type="hidden" value="<c:out value='${searchVO.mailId}'/>"/>
		</form>
 		<!-- 하단 숫자 시작 -->
		<div class="paginate">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />
			<p class="pop_btn_area03"><a href="javascript:window.close();"><img src="${imagePath}/btn/btn_close.gif" alt="창닫기"></a></p>
		</div>
		<!-- 하단 숫자 끝 -->

 	</div>
</div>

</body>
</html>
