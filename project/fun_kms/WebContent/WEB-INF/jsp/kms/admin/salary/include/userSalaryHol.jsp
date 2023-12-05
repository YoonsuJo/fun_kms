<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
	<caption>개인별 인건비</caption>
	<colgroup><col class="col5" /><col class="col60" /><col class="col180" /><col class="col80" /><col class="col40" /><col width="px" /><col class="col120" /><col class="col60" /><col class="col5" /></colgroup>
	<thead>
		<tr>
		<th class="th_left"></th>
		<th scope="col">사번</th>
		<th scope="col">이름</th>
		<th scope="col">소속부서</th>
		<th scope="col">상태</th>
		<th scope="col">등록여부</th>
		<th scope="col">휴일근무수당(1일)</th>
		<th scope="col">수정</th>
		<th class="th_right"></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList3}" var="result" varStatus="status">
			<tr>
				<td class="txt_center" colspan="2">${result.sabun}</td>
				<td class="txt_center">${result.userNm}</td>
				<td class="txt_center">${result.orgnztNm}</td>
				<td class="txt_center">
						<c:choose>
						<c:when test="${result.workSt=='W'}">근무</c:when>
						<c:when test="${result.workSt=='L'}">휴직</c:when>
						<c:when test="${result.workSt=='R'}">퇴직</c:when>
					</c:choose>
				</td>
				<td class="txt_center">
					<c:choose>
						<c:when test="${result.isRegistered=='N'}">
							<span class="txtS_red">미등록</span>
						</c:when>
						<c:otherwise>
							등록
						</c:otherwise>
					
					</c:choose>
					
				</td>
				<td class="txt_center userSalary"><print:currency cost="${result.salary}"/></td>
				<td class="txt_center" colspan="2"><img  class="cursorPointer" onclick="javascript:editUserSalary('${result.userNo}',this);" src="${imagePath}/admin/btn/btn_modify02.gif"/></td>
			</tr>
		
		</c:forEach>
		
	</tbody>
	</table>