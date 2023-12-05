<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    		<!-- 이전 레벨이 높으면 ul 시작 -->
            <!-- 이전 레벨이 낮으면 ul 끝 -->



	    <c:forEach items="${resultListTree}" var="result" varStatus="status" >
	  
    		<c:if test="${v_level lt result.lv and status.count gt 1}">
    			<c:out value="<ul>" escapeXml="false"/>
			</c:if>
    		<c:if test="${v_level gt result.lv  and status.count gt 1}">	
    			<c:set var="v_diff" value="${v_level - result.lv}"/>
    			<c:forEach begin="0" end="${v_diff-1}" step="1" >
    				<c:out value="</ul>" escapeXml="false"/>
    			</c:forEach>   
			</c:if>				
			    		
			<c:out value="<li>" escapeXml="false"/>
					<img src="${imagePath}/ico/ico_proj.gif" />
					<input type="checkbox" name="v_mission" value="${result.missionId}/${result.missionNm}/${result.dueDt}/${result.missionLv}/${result.prjId}/${result.prjNm}" >
					
					<label>${result.missionNm}(${result.leaderNm}/${result.dueDt})</label>
			
			<c:set var="v_level" value="${result.lv}"/>	
			 		
	    </c:forEach>
