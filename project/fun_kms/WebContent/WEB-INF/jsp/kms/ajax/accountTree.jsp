<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    		<!-- 이전 레벨이 높으면 ul 시작 -->
            <!-- 이전 레벨이 낮으면 ul 끝 -->

 <style>
 .spop_left{width:285px;float:left}
 </style>

<ul class="spop_left">
  <c:forEach items="${accountListTree}" var="result" varStatus="status" >
  <c:if test="${status.count != 0 && status.count % 23 == 0 && status.count < 69}">
</ul>
<ul class="spop_left">
  </c:if>
  		<li <c:if test="${result.accLv==2}">class="cursorPointer  accLeaf" onclick="javascript:selectAcc(this);"</c:if>>
  			<input name="_accNm" type="hidden" value="${result.accNm }">
  			<input name="_accId" type="hidden" value="${result.accId }">
  			<input name="_accLv" type="hidden" value="${result.accLv }">
  			<input name="_prntAccId" type="hidden" value="${result.prntAccId }">
  			<input name="_prntAccNm" type="hidden" value="${result.prntAccNm }">
  			<c:if test="${result.accLv==2}">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;</c:if> ${result.accNm }
  		</li>		
  </c:forEach>
</ul>

 <!-- 
 <ul class="spop_left">
 	<li>대메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li>대메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 </ul>
  <ul class="spop_left">
 	<li>대메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li>대메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 </ul>
  <ul class="spop_left">
 	<li>대메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li>대메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 	<li> - 소메뉴</li>
 </ul>
 -->