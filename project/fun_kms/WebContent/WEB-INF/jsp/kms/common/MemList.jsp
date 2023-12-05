<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	    <c:forEach items="${resultList}" var="result" varStatus="status" >
	    	<li onclick="fn_chekck2(this.form,'<c:out value="${result.userId}"/>:&lt;<c:out value="${result.userNm}"/>&gt;')">	<c:out value="${result.userId}"/>:&lt;<c:out value="${result.userNm}"/>&gt;</li>
	    </c:forEach>