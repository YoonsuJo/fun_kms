<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

<c:if test="${type == 'head'}">
<script>

</script>
</c:if>

<c:if test="${type == 'body'}">

<c:if test="${fn:length(resultList) != 0}">
<div class="replyL mT20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>댓글보기</caption>
		<colgroup>
		<col class="col100" />
		<col width="px" />
		<col class="col150" />
		</colgroup>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td class="writer">${result.userNm}</td>
				<td class="txt">
					<print:textarea text="${result.cn}" />
					<c:if test="${not empty result.atchFileId}">
					<p style="margin-top:10px;">
					<c:import url="/selectFileInfs.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" value="${result.atchFileId}" />
						<c:param name="param_isComment" value="true" />
					</c:import>
					</p>
					</c:if>
				</td>
				<td class="date">${result.regDt}</td>
			</tr>
		</c:forEach>
	</table>
</div>
</c:if>


</c:if>