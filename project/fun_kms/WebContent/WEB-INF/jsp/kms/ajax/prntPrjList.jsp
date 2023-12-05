<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
<!-- 프로젝트  -->

<input type="text" id="searchPrntPrjNm" class="span_90p"/><img id="btnClose" src="${imagePath}/btn/btn_close2.gif" class="fr cursorPointer"/>
<ul>
	<c:forEach items="${resultList}" var="result">
		<li class="prntPrjIncludedLi cursorPointer">
			[${result.prjCd}] ${result.prjNm}
			<input type="hidden" name="prntPrjIncluded_prjId" value="${result.prjId}"/>
			<input type="hidden" name="prntPrjIncluded_prjCd" value="${result.prjCd}"/>
			<input type="hidden" name="prntPrjIncluded_prjNm" value="${result.prjNm}"/>
			<input type="hidden" name="prntPrjIncluded_prntStDt" value="${result.prntStDt}"/>
			<input type="hidden" name="prntPrjIncluded_prntCompDueDt" value="${result.prntCompDueDt}"/>
			<input type="hidden" name="prntPrjIncluded_childStDt" value="${result.childStDt}"/>
			<input type="hidden" name="prntPrjIncluded_childCompDueDt" value="${result.childCompDueDt}"/>
		</li>
	</c:forEach>
</ul>