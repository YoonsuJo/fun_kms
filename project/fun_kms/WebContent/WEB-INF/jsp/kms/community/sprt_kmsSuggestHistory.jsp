<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>


<!-- 처리내역 시작  -->
<p class="th_stitle">처리 내역</p>
<div class="boardList02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>공지사항 보기</caption>
		<colgroup><col class="col120" /><col class="col120" /><col class="col120" /><col width="px" /></colgroup>
		<thead>
			<tr>
				<th>날짜</th>
				<th>이름</th>
				<th>처리상태</th>
				<th class="td_last">의견</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty hList}">
				<tr>
					<td class="td_last txt_center" colspan="4">처리내역이 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${hList}" var="history">
				<tr>
					<td class="txt_center">${history.regDt}</td>
					<td class="txt_center"><print:user userNo="${history.userNo}" userNm="${history.userNm}" userId="${history.userId}" printId="true"/></td>
					<td class="txt_center">
						<c:choose>
							<c:when test="${history.sgstSt == 'E'}">작업예정</c:when>
							<c:when test="${history.sgstSt == 'C'}">작업중</c:when>
							<c:when test="${history.sgstSt == 'H'}">향후작업</c:when>
							<c:when test="${history.sgstSt == 'R'}">기각</c:when>
							<c:when test="${history.sgstSt == 'F'}">처리완료</c:when>
							<c:otherwise>작업예정</c:otherwise>
						</c:choose>
					</td>
					<td class="td_last pL10">${history.note}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!--// 처리내역 끝  -->

<c:if test="${user.admin || user.board}">
<!-- 의견 시작  -->
<div class="replyW02 mT20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>댓글달기</caption>
		<colgroup><col class="col80" /><col width="px"/><col class="col200" /></colgroup>
		<tr>
			<td class="writer">의견</td>
			<td class="pL10 pT10 pB10">
			<textarea name="note" ></textarea>
		</td>	
		</tr>
	</table>
             <div class="btn_area07">
				<a href="javascript:insertHistory('C')"><img src="${imagePath}/btn/btn_working.gif"/></a>
				<a href="javascript:insertHistory('H')"><img src="${imagePath}/btn/btn_hereafter.gif"/></a>
				<a href="javascript:insertHistory('R')"><img src="${imagePath}/btn/btn_dismiss02.gif"/></a>
				<a href="javascript:insertHistory('F')"><img src="${imagePath}/btn/btn_handlingcomp.gif"/></a>
				</div>
</div>
<!--// 의견 끝  -->
</c:if>
	
