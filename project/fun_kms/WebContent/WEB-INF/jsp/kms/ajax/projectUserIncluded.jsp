<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
    	<!-- 프로젝트  -->

<ul>
	<c:forEach items="${resultList}" var="result">
		<li class="prjUserIncludedLi cursorPointer"><img src="${imagePath}/ico/ico_proj.gif" />
			<print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" link="N"/>
			<input type="hidden" name="prjUserIncluded_prjId" value="${result.prjId}"/>
			<input type="hidden" name="prjUserIncluded_prjNm" value="[${result.prjCd}]${result.prjNm}"/>
		</li>
	</c:forEach>
</ul>

    	