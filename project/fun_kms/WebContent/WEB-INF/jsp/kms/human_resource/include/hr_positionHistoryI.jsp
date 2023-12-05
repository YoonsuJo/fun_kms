<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
<caption>인사발령 이력</caption>
<colgroup>
	<col class="col70" />
	<col class="col60" />
	<col class="col40" />
	<col class="col90" />
	<col class="col250" />
	<col class="col70" />
	<col width="px" />
</colgroup>
<thead>
	<tr>
	<th scope="col">발령일자</th>
	<th scope="col">발령사항</th>
	<th scope="col">직급</th>
	<th scope="col">소속회사</th>
	<th scope="col">부서</th>
	<th scope="col">보직</th>
	<th scope="col">비고</th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${resultList}" var="r">
		<tr>
			<td class="txt_center"><c:out value="${r.chngDtPrint}" /></td>
			<td class="txt_center"><c:out value="${r.chngCodePrint}" /></td>
			<td class="txt_center"><c:out value="${r.aftRankNm}" /></td>
			<td class="txt_center"><c:out value="${r.aftCompNm}" /></td>
			<td class="txt_center"><c:out value="${r.aftOrgnztNm}" /></td>
			<td class="txt_center"><c:out value="${r.aftPositionPrint}" /></td>
			<td class="txt_center"><c:out value="${r.note}" escapeXml="false"/></td>
		</tr>
	</c:forEach>
</tbody>
</table>
