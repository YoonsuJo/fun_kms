<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
    	<!-- 프로젝트  -->

<ul>
	<c:forEach items="${resultList}" var="result" varStatus="status">
		<li class="cursorPointer">
			<input type="hidden" name="usrGen_${statu.index }usrNo" value="${result.userNo }"/>
			<input type="hidden" name="usrGen_${statu.index }usrNm" value="${result.userNm }"/>
			<input type="hidden" name="usrGen_${statu.index }usrId" value="${result.userId }"/>
			<img src="${imagePath}/ico/ico_peo.gif"/>
			<span class="userMix">${result.userNm }(${result.userId })</span> 
			<span class="orgnztNm">${result.orgnztNm }</span>	
		</li>
	</c:forEach>
</ul>

    	