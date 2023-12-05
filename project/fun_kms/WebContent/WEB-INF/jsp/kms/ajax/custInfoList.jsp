<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
    	<!-- 프로젝트  -->
<!-- 세금계산서 작성시 회사명, 대표자, 사업자번호, 주소, 업태, 업종, 담당자 정보를 가져오기 위하여 ajax -->
<ul>
<c:forEach items="${resultList}" var="result">
	<li class="custInfoListLi cursorPointer"><img src="${imagePath}/ico/ico_peo.gif" />
		${result.custCompanyName}
		<input type="hidden" name="custInfoListLi_custCompanyName" 	value="${result.custCompanyName}"/>
		<input type="hidden" name="custInfoListLi_custCeoName" 		value="${result.custCeoName}"/>
		<input type="hidden" name="custInfoListLi_custBusiNo" 		value="${result.custBusiNo}"/>
		<input type="hidden" name="custInfoListLi_custAddress" 		value="${result.custAddress}"/>
		<input type="hidden" name="custInfoListLi_custBusiType" 	value="${result.custBusiType}"/>
		<input type="hidden" name="custInfoListLi_custBusiKine" 	value="${result.custBusiKind}"/>
		<input type="hidden" name="custInfoListLi_custName1" 		value="${result.custName1}"/>
		<input type="hidden" name="custInfoListLi_custName1" 		value="${result.custName1}"/>
		<input type="hidden" name="custInfoListLi_custName1" 		value="${result.custName1}"/>
		<input type="hidden" name="custInfoListLi_custName1" 		value="${result.custName1}"/>
		<input type="hidden" name="custInfoListLi_custName1" 		value="${result.custName1}"/>
		<input type="hidden" name="custInfoListLi_custEmail1" 		value="${result.custEmail1}"/>
		<input type="hidden" name="custInfoListLi_custEmail1" 		value="${result.custEmail1}"/>
		<input type="hidden" name="custInfoListLi_custEmail1" 		value="${result.custEmail1}"/>
		<input type="hidden" name="custInfoListLi_custEmail1" 		value="${result.custEmail1}"/>
		<input type="hidden" name="custInfoListLi_custEmail1" 		value="${result.custEmail1}"/>
		<input type="hidden" name="custInfoListLi_custTelNo1" 		value="${result.custTelNo1}"/>
		<input type="hidden" name="custInfoListLi_custTelNo1" 		value="${result.custTelNo1}"/>
		<input type="hidden" name="custInfoListLi_custTelNo1" 		value="${result.custTelNo1}"/>
		<input type="hidden" name="custInfoListLi_custTelNo1" 		value="${result.custTelNo1}"/>
		<input type="hidden" name="custInfoListLi_custTelNo5" 		value="${result.custTelNo5}"/>
	</li>
</c:forEach>
</ul>

    	