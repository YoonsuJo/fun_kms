<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
    	<!-- 프로젝트  -->

<ul>
	<c:forEach items="${customerList}" var="result">
		<li class="customerIncludedLi cursorPointer">
			${result.custNm}/${result.custManager}/${result.custTelno}/${result.custEmail}
			<input type="hidden" name="customerIncluded_custNo" value="${result.no}"/>
			<input type="hidden" name="customerIncluded_custNm" value="${result.custNm}"/>
			<input type="hidden" name="customerIncluded_custManager" value="${result.custManager}"/>
			<input type="hidden" name="customerIncluded_custTelno" value="${result.custTelno}"/>
			<input type="hidden" name="customerIncluded_custEmail" value="${result.custEmail}"/>
		</li>
	</c:forEach>
</ul>
    	