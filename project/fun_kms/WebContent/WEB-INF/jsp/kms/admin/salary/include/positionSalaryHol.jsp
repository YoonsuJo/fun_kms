<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
<caption>보직별 기준인건비</caption>
<colgroup><col class="col5" /><col class="col120" /><col width="px" /><col class="col90" /><col class="col5" /></colgroup>
<thead>
	<tr>
	<th class="th_left"></th>
	<th scope="col">보직</th>
	<th scope="col">휴일근무수당(1일)</th>
	<th scope="col">수정</th>
	<th class="th_right"></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${resultList2}"  var="elem" varStatus="status">
	<tr>
		<td class="txt_center positionCode" colspan="2">${elem.positionNm }</td>
		<td class="txt_center positionSalary"><print:currency cost="${elem.salary}"/></td>
		<td class="txt_center" colspan="2"><img class="cursorPointer" onclick="javascript:editPositionSalary('${elem.positionCode}',this);" src="${imagePath}/admin/btn/btn_modify02.gif"/></td>
	</tr>
	
	</c:forEach>
</tbody>
</table>

