<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
<caption>직급별 기준인건비</caption>
<colgroup><col class="col5" /><col class="col120" /><col class="col150" /><col class="col150" /><col width="px" /><col class="col90" /><col class="col5" /></colgroup>
<thead>
	<tr>
	<th class="th_left"></th>
	<th scope="col">직급코드</th>
	<th scope="col">직급명</th>
	<th scope="col">상태</th>
	<th scope="col">기준인건비(월)</th>
	<th scope="col">수정</th>
	<th class="th_right"></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${resultList1}"  var="elem" varStatus="status">
	<tr>
		<td class="txt_center rankCode" colspan="2">${elem.rankCode }</td>
		<td class="txt_center">${elem.rankNm }</td>
		<td class="txt_center">${elem.useAt }</td>
		<td class="txt_center rankSalary"><print:currency cost="${elem.salary }"/></td>
		<td class="txt_center" colspan="2"><img class="cursorPointer" onclick="javascript:editRankSalary('${elem.rankCode}',this);" src="${imagePath}/admin/btn/btn_modify02.gif"/></td>
	</tr>
	
	</c:forEach>
</tbody>
</table>

