<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
    	<!-- 프로젝트  -->

<ul>
		<c:forEach items="${resultListTree}" var="result">
		<li class="missionUserIncludedLi cursorPointer"><img src="${imagePath}/ico/ico_proj.gif" />
			${result.missionNm}(${result.leaderNm}/${result.dueDt})
			<input type="hidden" name="missionUserIncluded_missionId" value="${result.missionId}"/>
			<input type="hidden" name="missionUserIncluded_missionNm" value="${result.missionNm}"/>
			<input type="hidden" name="missionUserIncluded_dueDt" value="${result.dueDt}"/>
			<input type="hidden" name="missionUserIncluded_missionLv" value="${result.missionLv}"/>
			<input type="hidden" name="missionUserIncluded_prjId" value="${result.prjId}"/>
			<input type="hidden" name="missionUserIncluded_prjNm" value="${result.prjNm}"/>
		</li>
	</c:forEach>
	
</ul>
