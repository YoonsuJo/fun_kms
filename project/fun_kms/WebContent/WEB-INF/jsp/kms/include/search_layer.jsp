<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
<c:if test="${type == 'head'}">
<script>
function searchLayer(pageNo) {
	$('#searchLayer').html("");
	$.post("${rootPath}/common/memberSearchLayer.do?pageIndex=" + pageNo, $("#searchFrm").serialize(),
			function(data){
				$('#searchLayer').html(data);
			}
	);
	//$("#searchLayer").focus();
	//$("#searchLayer").fadeIn(1000);
	$("#searchLayer").show();
	document.getElementById("searchLayer").focus();
}
function viewMem(userNo,userNm) {
	document.subFrm.no.value = userNo;
	document.subFrm.action = '<c:url value="${rootPath}/member/selectMemberMain.do" />';
	document.subFrm.submit();
}
function hideLayer() {
	$("#searchLayer").hide();
}
</script>
</c:if>

<c:if test="${type == 'body'}">
<!-- 사용자 레이어 -->
<ul>
	<c:forEach items="${memList}" var="mem">
		<li><a href="javascript:viewMem('${mem.no}','${mem.userNm}');">${mem.userNm}(${mem.userId})</a></li>
	</c:forEach>
	<c:if test="${empty memList}">
		<li>검색결과가 없습니다.</li>
		<script>
		//$("#searchLayer").fadeOut(5000);
		</script>
	</c:if>
</ul>
<div class="paginate">
	<ui:pagination paginationInfo="${memPaginationInfo}" type="image" jsFunction="searchLayer" />
</div>
<div class="pop_btn_area">
	<a href="javascript:hideLayer();"><img src="${imagePath}/btn/btn_close.gif"/></a>
</div>
<!--// 사용자 레이어 -->	
</c:if>