<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

<!-- S: 업무연락 -->
<span class="th_stitle_left">업무연락 <img src="${imagePath}/btn/btn_refresh.gif" class="cursorPointer" onclick="busiRefresh();"/></span>
<span class="btn_area06 mB5">
	<a href="${rootPath}/cooperation/insertBusinessContactView.do"><img src="${imagePath}/btn/btn_write01.gif"/></a>
	<a href="${rootPath}/cooperation/selectBusinessContactList.do"><img src="${imagePath}/btn/btn_more.gif"/></a>
</span>
<div class="boardList mB20">
	<table cellpadding="0" cellspacing="0" summary="업무연락 목록입니다.">
	<caption>업무연락</caption>
	<colgroup>
		<col class="col100" />
		<col width="px" />
		<col class="col50" />
		<col class="col100" />
		<col class="col100" />
		<col class="col70" />
	</colgroup>
	<thead>
		<tr>
		<th scope="col">프로젝트 코드</th>
		<th scope="col">제목</th>
		<th scope="col">작성자</th>
		<th scope="col">작성일시</th>
		<th scope="col">변경일시</th>
		<th scope="col">열람상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${bcList}" var="bc">
			<tr>
				<td class="txt_center">${bc.prjCd}</td>
				<td class="txt_left">
					<a href="${rootPath}/cooperation/selectBusinessContact.do?bcId=${bc.bcId}">
						<c:choose>
							<c:when test="${bc.readYn == 'Y'}">${bc.bcSj}</c:when>
							<c:otherwise><span class="txt_red">${bc.bcSj}</span></c:otherwise>
						</c:choose>
						<span class="txt_reply">[${bc.commentCnt}]</span>
					</a>
				</td>
				<td class="txt_center"><print:user userNm="${bc.userNm}" userNo="${bc.userNo}" userId="${bc.userId}"/></td>
				<td class="txt_center">${bc.regDt}</td>
				<td class="txt_center">${bc.modDt}</td>
				<td class="txt_center">${bc.readStatPrint}</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
</div>
<!-- E: 업무연락 -->

