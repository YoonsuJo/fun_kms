<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/ajax_inc.jsp"%>

<p class="th_stitle">자기개발비 사용 상세내역</p>
<!-- 게시판 시작  -->
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>자기개발비 보기</caption>
	<colgroup>
		<col class="col100" />
		<col class="col100" />
		<col width="px" />
	</colgroup>
	<thead>
		<tr>
			<th>사용일</th>
			<th>금액</th>
			<th class="td_last">사유</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td class="txt_center">${result.expDt}</td>
				<td class="txt_center"><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}">${result.expSpendPrint}</a></td>
				<td class="td_last pL10"><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}"><print:textarea text="${result.expCtPrint}" /></a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
<!--// 게시판  끝  -->

