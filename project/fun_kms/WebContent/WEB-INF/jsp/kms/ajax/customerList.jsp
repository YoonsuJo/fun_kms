<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
<!-- 프로젝트  -->

<ul>
	<c:forEach items="${resultList}" var="result">
		<li class="customerIncludedLi cursorPointer">
			${result.custNm}
			<input type="hidden" name="customerIncluded_custId" value="${result.custId}"/>
			<input type="hidden" name="customerIncluded_custNm" value="${result.custNm}"/>
		</li>
	</c:forEach>
</ul>
    	