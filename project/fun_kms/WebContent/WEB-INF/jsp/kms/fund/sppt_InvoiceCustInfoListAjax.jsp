<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
    	<!-- 프로젝트  -->
<!-- 세금계산서 작성시 회사명, 대표자, 사업자번호, 주소, 업태, 업종, 담당자 정보를 가져오기 위하여 ajax -->
<ul>
<c:forEach items="${resultList}" var="result">
	<li class="custInfoListLi cursorPointer"><img src="${imagePath}/ico/ico_peo.gif" />
		${result.custCompanyName}
		<input type="hidden" name="custILLi_custCompanyName" 	value="${result.custCompanyName}"/>
		<input type="hidden" name="custILLi_custCeoName" 		value="${result.custCeoName}"/>
		<input type="hidden" name="custILLi_custBusiNo" 			value="${result.custBusiNo}"/>
		<input type="hidden" name="custILLi_custAddress" 			value="${result.custAddress}"/>
		<input type="hidden" name="custILLi_custBusiType" 			value="${result.custBusiType}"/>
		<input type="hidden" name="custILLi_custBusiKind" 			value="${result.custBusiKind}"/>
		<input type="hidden" name="custILLi_custName1" 			value="${result.custName1}"/>
		<input type="hidden" name="custILLi_custName2" 			value="${result.custName2}"/>
		<input type="hidden" name="custILLi_custName3" 			value="${result.custName3}"/>
		<input type="hidden" name="custILLi_custName4" 			value="${result.custName4}"/>
		<input type="hidden" name="custILLi_custName5" 			value="${result.custName5}"/>
		<input type="hidden" name="custILLi_custEmail1" 			value="${result.custEmail1}"/>
		<input type="hidden" name="custILLi_custEmail2" 			value="${result.custEmail2}"/>
		<input type="hidden" name="custILLi_custEmail3" 			value="${result.custEmail3}"/>
		<input type="hidden" name="custILLi_custEmail4" 			value="${result.custEmail4}"/>
		<input type="hidden" name="custILLi_custEmail5" 			value="${result.custEmail5}"/>
		<input type="hidden" name="custILLi_custTelNo1" 			value="${result.custTelNo1}"/>
		<input type="hidden" name="custILLi_custTelNo2" 			value="${result.custTelNo2}"/>
		<input type="hidden" name="custILLi_custTelNo3" 			value="${result.custTelNo3}"/>
		<input type="hidden" name="custILLi_custTelNo4" 			value="${result.custTelNo4}"/>
		<input type="hidden" name="custILLi_custTelNo5" 			value="${result.custTelNo5}"/>
	</li>
</c:forEach>
</ul>

    	