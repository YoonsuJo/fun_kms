<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
    	<!-- 프로젝트  -->

<ul>
	<c:forEach items="${resultList}" var="result">
		<li class="customerIncludedLi cursorPointer"><img src="${imagePath}/ico/ico_peo.gif" />
			<print:date date="${result.publishDate}"/> ${result.custNm} [${result.prjCd}] ${result.prjNm}
			<input type="hidden" name="searchBondPrjNo" value="${result.prjNo}"/>
			<input type="hidden" name="searchCustNm" value="<print:date date='${result.publishDate}'/> ${result.custNm} [${result.prjCd}] ${result.prjNm}"/>
			<input type="hidden" name="searchBondPrjId" value="${result.prjId}"/>
		</li>
	</c:forEach>
</ul>

    	