	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../../include/ajax_inc.jsp"%>


<p class="th_stitle">상위계정관리</p>
<div class="boardList02">
	<table id="prntAccListT" cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
	<caption>상위계정관리</caption>
	<colgroup><col class="col250" /><col width="px" /></colgroup>
	<thead>
		<tr>
		<th scope="col">상위계정</th>
		<th scope="col">계정분류</th>
		<th class="td_last" scope="col">사용여부</th>
		</tr>
	</thead>
	<tbody>
		
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr class="center cursorPointer">
				<td class="hidden"><input type="hidden" value="${result.accId }" name="accId"/></td>
				<td>${result.accNm }</td>
				<td>${result.prntTypNm }</td>
				<td class="td_last">${result.useAt }</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
</div>

<div class="btn_area03">
    <img src="${imagePath}/admin/btn/btn_add.gif" id="prntAccAddB" class="cursorPointer"/>
</div>

<div id="prntAccAddL">
</div>
