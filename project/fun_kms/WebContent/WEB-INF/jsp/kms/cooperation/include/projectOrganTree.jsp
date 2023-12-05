<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    		<!-- 이전 레벨이 높으면 ul 시작 -->
            <!-- 이전 레벨이 낮으면 ul 끝 -->



	    <c:forEach items="${resultListTree}" var="result1" varStatus="status" >
    		<c:if test="${v_level lt result1.lv and status.count gt 1}">
    			<c:out value="<ul>" escapeXml="false"/>
			</c:if>
    		<c:if test="${v_level gt result1.lv  and status.count gt 1}">	
    			<c:set var="v_diff" value="${v_level - result1.lv}"/>
    			<c:forEach begin="0" end="${v_diff-1}" step="1" >
    				<c:out value="</ul>" escapeXml="false"/>
    			</c:forEach>   
			</c:if>				
			    		
			<c:out value="<li>" escapeXml="false"/>
			<c:choose>
				<c:when test="${result1.typ=='PRJ'}">
					<input type="checkbox" name="v_prj" value="${result1.id}/${result1.nm}" >
					<label> ${result1.nm}</label>
				</c:when>
				<c:otherwise >
					<input type="checkbox" name="v_org" value="${result1.id}/${result1.nm}" >
					<label> ${result1.nm}</label>
				</c:otherwise>		
			</c:choose>
			

	        <c:set var="v_level" value="${result1.lv}"/>	 		
	    </c:forEach>
