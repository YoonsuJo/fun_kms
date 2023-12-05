<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>
<script>
$(document).ready(function() {
});
</script>
<c:forEach items="${resultList}" var="result">
	<c:choose><c:when test="${result.useAt == 'Y'}">
		<input type="hidden" name="ord_titleNo" value="${result.titleNo }"/>
		<select name="ord_ord">
			<c:forEach items="${resultList}" var="o">
			<c:choose><c:when test="${o.useAt == 'Y'}">
			<option value="${o.ord }" <c:if test="${o.ord == result.ord}">selected</c:if>>${o.ord }</option>
			</c:when></c:choose>
			</c:forEach>
		</select>
		<a href="/support/ruleL.do?titleNo=${result.titleNo }">${result.sj }</a>
		<br/>
	</c:when></c:choose>
</c:forEach>
<br/>
<br/>&nbsp;<a href="javascript:updateOrder();"><img src="${imagePath}/btn/btn_save2.gif" style="margin-left:5px"/></a>
&nbsp;<a href="${rootPath }/support/ruleL.do"><img src="${imagePath}/btn/btn_cancel2.gif" /></a>