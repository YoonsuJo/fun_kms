<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<p class="th_stitle mB10">
<!-- docContent, appr_pop_print 에서 include 하는 수정, 취소기안 정보 뷰 -->
<c:if test="${commonDoc.reWriteTyp == 1 }">수정기안 정보</c:if>
<c:if test="${commonDoc.reWriteTyp == 2 }">취소기안 정보</c:if>
<c:if test="${commonDoc.reWriteTyp != 1 && commonDoc.reWriteTyp != 2 }">수정/취소기안 정보</c:if>
</p>
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup><col class="col120" /><col width="px" /><col class="col120" /></colgroup>
	<tbody>
		<tr>
		<td class="title" rowspan="2">기존 결재문서</td>
		<td class="txt_center title">제목</td>
		<td class="txt_center title">기안일시</td>
		</tr>
		<tr>
		<td class="pL10"><a href="/approval/approvalV.do?docId=${parentDoc.docId}" target="_blank" ><span class="span_12">${parentDoc.subject}</span></a></td>
		<td class="pL10">${parentDoc.writeDtLong}</td>
		</tr>
		<tr>
		<td class="title">변경 구분</td>
		<td class="pL10" colspan="2">
			<input type="radio" name="reWriteTyp" disabled <c:if test="${commonDoc.reWriteTyp==1 }">checked</c:if>  value="1" onclick="reWriteTypChange(1);"  /> 수정 
			<input type="radio" name="reWriteTyp" disabled <c:if test="${commonDoc.reWriteTyp==2 }">checked</c:if>  value="2" onclick="reWriteTypChange(2);" /> 취소
		</td>
		</tr>
	</tbody>
	</table>
</div>