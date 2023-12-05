<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
	<caption>사원연봉결정</caption>
	<colgroup>
		<col width="px" />
		<col class="col50" />
		<col class="col6" />									
		<col class="col60" />
		<col class="col60" />
		
		<col class="col170" />		
		<col class="col80" />		
		<col class="col80" />													
		<col class="col80" />
<!--		<col class="col70" />-->

		<col class="col70" />
		
	</colgroup>
	<thead>
		<tr>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'org'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'org'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('org');">부서</a></span></th>								
		<th scope="col"><span
			<c:if test="${searchVO.orderBy != 'name'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'name'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('name');">이름</a></span></th>
		<th scope="col"><span
			<c:if test="${searchVO.orderBy != 'age'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'age'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('age');">나이</a></span></th>
		<th scope="col"><span
			<c:if test="${searchVO.orderBy != 'degree'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'degree'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('degree');">학력</a></span></th>										
		<th scope="col"><span
			<c:if test="${searchVO.orderBy != 'rank'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'rank'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('rank');">직급</a></span></th>
		
		<th scope="col">1차/2차 평가자</th>
		<th scope="col">1차점수</th>								
		<th scope="col">2차점수</th>
		<th scope="col">최종점수</th>		
<!--		<th scope="col">상태</th>-->
		
		<th scope="col">수정</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<tr>				
<!--				부서-->
				<td class="txt_center">${result.orgnztNm } </td>
<!--				이름-->
				<td class="txt_center">
					<print:user userNo="${result.userNo}" userNm="${result.userNm}"/>
					<input type="hidden" name="userName${result.userNo }" id="userName${result.userNo }" value="${result.userNm}" />				
				</td>
<!--				나이-->
				<td class="txt_center">
					만${result.age }세<br/>(${result.ageKor }세) 
				</td>
<!--				학력-->
				<td class="txt_center">
				<c:forEach items="${degreeCode}" var="degree">								        		 
	        		<c:if test="${result.degree == degree.code}">
	        			<c:out value="${degree.codeNm}" />
	        		</c:if>								        		
        		</c:forEach>									
				</td>
<!--				직급-->
				<td class="txt_center">
					${result.rankNm } <br/>
					<c:if test="${year < result.promotionYear - 1}">진급이전</c:if>
					<c:if test="${year == result.promotionYear - 1}">진급예정</c:if>					
					<c:if test="${year >= result.promotionYear}">${year - result.promotionYear + 1}년차 </c:if>
				</td>
<!--				1차 2차 평가자-->
				<td class="txt_center">
				1차: <input type="text" name="eva1Nm${result.userNo }" id="eva1Nm${result.userNo }" class="write_input06 userNameAuto userValidateCheck" value="${result.eva1Nm}" /><br/>
				2차: <input type="text" name="eva2Nm${result.userNo }" id="eva2Nm${result.userNo }" class="write_input06 userNameAuto userValidateCheck" value="${result.eva2Nm}" />
				</td>
<!--				1차 평가점수-->
				<td class="txt_center">
				<input type="text" name="score1${result.userNo }" id="score1${result.userNo }" maxlength="3" class="write_input10" value="${result.score1}" 
				onkeyup="calRate('${result.userNo }');" 
				onKeyPress="onlyNumber();enterUserSalary('${result.userNo}', acceptBtn${result.userNo});" />												
				</td>
<!--				2차 평가점수-->
				<td class="txt_center">
				<input type="text" name="score2${result.userNo }" id="score2${result.userNo }" maxlength="3" class="write_input10" value="${result.score2}" 
				onkeyup="calRate('${result.userNo }');" 
				onKeyPress="onlyNumber();enterUserSalary('${result.userNo}', acceptBtn${result.userNo});"/>
				</td>
<!--				최종점수-->
				<td class="txt_center">
				<input type="text" name="grade${result.userNo }" id="grade${result.userNo }" maxlength="3" class="read_input" readonly="readonly"  value="${result.grade }" />				
				</td>
<!--				상태 // MODEL에서 불러오지 않음-->
<!--				<td class="txt_center">-->
<!--					<c:forEach items="${statusCode}" var="status">-->
<!--						<c:if test="${status.code == result.status}">-->
<!--							${status.codeNm }<br/>-->
<!--						</c:if>					-->
<!--					</c:forEach>-->
<!--				</td>-->
<!--				수정-->
				<td class="txt_center">
				<img  class="cursorPointer" id="acceptBtn${result.userNo}" name="acceptBtn${result.userNo}"
					onclick="javascript:editUserSalary('${result.userNo}', this);" src="${imagePath}/admin/btn/btn_modify02.gif"/>				
				</td>
			</tr>									
		</c:forEach>									
	</tbody>
	</table>