<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    		<!-- 이전 레벨이 높으면 ul 시작 -->
            <!-- 이전 레벨이 낮으면 ul 끝 -->



	    <c:forEach items="${resultListTree}" var="result1" varStatus="status" >
	    		<c:if test="${v_level lt result1.orgLv and status.count gt 1}">
	    	
	    		<ul>
				</c:if>
	    		<c:if test="${v_level gt result1.orgLv  and status.count gt 1}">	
	    			<c:set var="v_diff" value="${v_level - result1.orgLv}"/>
	    			<c:forEach begin="0" end="${v_diff-1}" step="1" >
	    					</ul>
	    			</c:forEach>   
				</c:if>				
				    		
				<li>
				<input type="checkbox" name="v_org" value="${result1.orgnztId}/${result1.orgnztNm}" >
				<img src="${imagePath }/ico/ico_folder.gif" /><label> ${result1.orgnztNm}</label>

		        <c:set var="v_level" value="${result1.orgLv}"/>	 		
	    </c:forEach>
