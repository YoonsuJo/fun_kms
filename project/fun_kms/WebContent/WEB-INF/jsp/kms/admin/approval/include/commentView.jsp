<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>

<%@ include file="../../../include/ajax_inc.jsp"%>

<p class="th_stitle mB10">결재진행현황 </p>

	<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
	<caption>전자결재</caption>
	<colgroup>
		<col class="col80" />
		<col class="col80" />
		<col class="col80" />
		<col class="col150" />
		<col width="px" />
	</colgroup>
	<thead>
		<tr>
		<th scope="col">이름</th>
		<th scope="col">결재자타입</th>
		<th scope="col">진행내역</th>
		<th scope="col">일시</th>
		<th scope="col">의견</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="comment" items="${commentList}" varStatus="status">
		<tr>
			<td class="txt_center" ><print:user userNo="${comment.writerNo}" userNm="${comment.writerNm}"/></td>
			<td class="txt_center"><c:out value="${comment.appTypNm}"/>&nbsp;</td>
			<td class="txt_center">
				${comment.statPrint}
			</td>
			<td class="txt_center"><c:out value="${comment.wtDt}"/>&nbsp;</td>
			<td class="txt_left"><print:textarea text="${comment.eappCt}"/></td>
		</tr>
		</c:forEach>
																																																					
	</tbody>
	</table>




