<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
    	<!-- 프로젝트  -->

<ul>
	<c:forEach items="${resultList}" var="result">
		<li class="customerIncludedLi cursorPointer"><img src="${imagePath}/ico/ico_peo.gif" />
			${result.custNm} [<print:date date="${result.publishDate}"/> ${result.bondSj}]
			<input type="hidden" name="customerIncluded_custNm" value="${result.custNm}"/>
			<input type="hidden" name="customerIncluded_custBusiNo" value="${result.custBusiNo}"/>
			<input type="hidden" name="customerIncluded_custAdres" value="${result.custAdres}"/>
			<input type="hidden" name="customerIncluded_custRepNm" value="${result.custRepNm}"/>
			<input type="hidden" name="customerIncluded_custBusiCond" value="${result.custBusiCond}"/>
			<input type="hidden" name="customerIncluded_custBusiTyp" value="${result.custBusiTyp}"/>
			
			<input type="hidden" name="customerIncluded_taxEmail1" value="${result.taxEmail1}"/>
			<input type="hidden" name="customerIncluded_taxUserNm1" value="${result.taxUserNm1}"/>
			<input type="hidden" name="customerIncluded_taxTelno1" value="${result.taxUserTelNo1}"/>
			<input type="hidden" name="customerIncluded_taxEmail2" value="${result.taxEmail2}"/>
			<input type="hidden" name="customerIncluded_taxUserNm2" value="${result.taxUserNm2}"/>
			<input type="hidden" name="customerIncluded_taxTelno2" value="${result.taxUserTelNo2}"/>
			<input type="hidden" name="customerIncluded_taxEmail3" value="${result.taxEmail3}"/>
			<input type="hidden" name="customerIncluded_taxUserNm3" value="${result.taxUserNm3}"/>
			<input type="hidden" name="customerIncluded_taxTelno3" value="${result.taxUserTelNo3}"/>
			<input type="hidden" name="customerIncluded_taxEmail4" value="${result.taxEmail4}"/>
			<input type="hidden" name="customerIncluded_taxUserNm4" value="${result.taxUserNm4}"/>
			<input type="hidden" name="customerIncluded_taxTelno4" value="${result.taxUserTelNo4}"/>
			<input type="hidden" name="customerIncluded_taxEmail5" value="${result.taxEmail5}"/>
			<input type="hidden" name="customerIncluded_taxUserNm5" value="${result.taxUserNm5}"/>
			<input type="hidden" name="customerIncluded_taxTelno5" value="${result.taxUserTelNo5}"/>
			
		</li>
	</c:forEach>
</ul>

    	