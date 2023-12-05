<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>
<c:forEach items="${resultList}" var="result">
	<a href="/support/ruleL.do?contentNo=${result.contentNo }">
	<ul <c:if test="${result.contentNo == result.contentNo}">class="highlight"</c:if>>
	<c:choose>
	<c:when test="${result.typ == 'REG'}"><li class="rltitle T_blue">생성</li></c:when>
	<c:when test="${result.typ == 'MOD'}"><li class="rltitle T_black">수정</li></c:when>
	<c:when test="${result.typ == 'DEL'}"><li class="rltitle T_red">삭제</li></c:when>
	<c:when test="${result.typ == 'RCV'}"><li class="rltitle T_green">복원</li></c:when>
	<c:otherwise>${result.typ}</c:otherwise>
	</c:choose>
	<li>${result.tm }</li>
	</ul>
	</a>
</c:forEach>