<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
<form id ="userSalaryForm">
<div id="pop_expense02">
 	 	
	${memberVO.orgnztNm } <print:user userNo="${memberVO.userNo}" userNm="${memberVO.userNm}"/> ${memberVO.rankNm } 
							
 	<!-- 게시판  -->
 	<p class="th_stitle">최근 5년간 연봉정보</p>
		<div class="boardList mB20">
			<table cellpadding="0" cellspacing="0" summary="연봉정보">
			<caption>연봉정보</caption>
			<colgroup>
				<col width="px" />
				<col width="px" />
				<col width="px" />
				<col width="px" />
			</colgroup>
			<thead>
				<tr>
				<th scope="col">년도</th>
				<th scope="col">연봉</th>
				<th scope="col">인상금액</th>
				<th scope="col">상승률</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result">
					<tr>
<!--					년도-->
						<td class="txt_center">${result.year }</td>
<!--					연봉-->
						<td class="txt_center">
							<a href="javascript:historySR('${result.userNo }', '${result.salaryReal }')"><print:currency cost='${result.salaryReal }'/></a>
						</td>										
<!--					인상금액-->
						<td class="txt_center">
							<c:if test="${result.salaryNext != 0}">
								<a href="javascript:historyIA('${result.userNo }', '${result.increaseAmount }')"><print:currency cost='${result.increaseAmount }'/></a>
							</c:if>
						</td>
<!--					상승률-->
						<td class="txt_center">
							<c:if test="${result.salaryNext != 0}">			
								<a href="javascript:historyIR('${result.userNo }', '${result.increaseRate }')">${result.increaseRate }%</a>			
							</c:if>				  
						</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
		</div>
		
</div>
</form>