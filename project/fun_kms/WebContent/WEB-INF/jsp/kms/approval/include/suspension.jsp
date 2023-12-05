<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${suspensionTyp==1}">
		<p class="th_stitle mB10">수정기안 정보</p>
		<span class="txtS_red"> ※	이 문서는 수정 기안으로 효력이 상실된 문서입니다.</span>
		<div class="boardWrite02 mB20">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			    <caption>수정기안 보기</caption>
			     <colgroup><col class="col120" /><col width="px" /><col class="col120" /></colgroup>
			     <tbody>
				     	<tr>
					      	<td class="title" rowspan="2">수정된 결재문서</td>
					      	<td class="txt_center title">제목</td>
					      	<td class="txt_center title">기안일시</td>
				     	</tr>
					     <tr>
					      	<td class="pL10"><a href="/approval/approvalV.do?docId=${childDoc.docId}" target="_blank" ><span class="span_12">${childDoc.subject}</span></a></td>
					      	<td class="pL10">${childDoc.writeDtLong}</td>
				     	</tr>
			     </tbody>
		     </table>
		</div>
	</c:when>
	<c:otherwise>
		<c:if test="${childDoc != null}"> 
<!--		취소기안의 경우 new_at이 0으로 남으므로 자식 문서가 없는경우 안보여줌-->
			<p class="th_stitle mB10">취소기안 정보</p>
			<span class="txtS_red"> ※	이 문서는 취소 기안으로 효력이 상실된 문서입니다.</span>
			<div class="boardWrite02 mB20">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				    <caption>취소기안 보기</caption>
				     <colgroup><col class="col120" /><col width="px" /><col class="col120" /></colgroup>
				     <tbody>
					     	<tr>
						      	<td class="title" rowspan="2">결재된 취소문서</td>
						      	<td class="txt_center title">제목</td>
						      	<td class="txt_center title">기안일시</td>
					     	</tr>
						     <tr>
						      	<td class="pL10"><a href="/approval/approvalV.do?docId=${childDoc.docId}" target="_blank" ><span class="span_12">${childDoc.subject}</span></a></td>
						      	<td class="pL10">${childDoc.writeDtLong}</td>
					     	</tr>
				     </tbody>
			     </table>
			</div>
		</c:if>
	</c:otherwise>
</c:choose>

