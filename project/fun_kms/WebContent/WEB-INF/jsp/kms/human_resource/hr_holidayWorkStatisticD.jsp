<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

<p class="th_stitle">휴일근무 상세 내역</p>
<!-- 게시판 시작  -->
<div class="boardList02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>공지사항 보기</caption>
		<colgroup>
			<col class="col80" />
			<col class="col200" />
			<col class="col40" />
			<col class="col100" />
			<col width="px" />
		</colgroup>
		<thead>
			<tr>
				<th>이름</th>
				<th>기간</th>
				<th>일수</th>
				<th>프로젝트 코드</th>
				<th class="td_last">사유</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${resultList}" var="result">
				<tr>
					<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
					<td class="txt_center">${result.stDt} ${result.stTm} ~ ${result.edDt} ${result.edTm}</td>
					<td class="txt_center">${result.period}</td>
					<td class="txt_center">${result.prjCd}</td>
					<td class="td_last txt_center">${result.content}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!--// 게시판  끝  -->

