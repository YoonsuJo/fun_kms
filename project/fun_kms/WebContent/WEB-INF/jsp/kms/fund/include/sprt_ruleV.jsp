<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>
<c:choose>
<c:when test="${empty result.contentNo}">
	<script>
	$(document).ready(function() {
		$('#writeB').show();
		$('#insertB').hide();
		$('#modifyB').hide();
		$('#updateB').hide();
		$('#deleteB').hide();
		$('#recoverB').hide();
		$('#cancelB').hide();
	});
	</script>
	※ 등록된 규정이 없습니다.
</c:when>
<c:otherwise>
	<input type="hidden" name="contentNo" value="${result.contentNo }"/>
	<input type="hidden" name="titleNo" value="${result.titleNo }"/>
	<script>
	$(document).ready(function() {
		$('#writeB').show();
		$('#insertB').hide();
		$('#modifyB').show();
		$('#updateB').hide();
		$('#deleteB').show();
		$('#recoverB').hide();
		$('#cancelB').hide();
		<c:if test="${result.useAt != 'Y' }">
			$('#deleteB').hide();
			$('#recoverB').show();
		</c:if>

		$('.use').each(function(){
			if ($(this).find("#title").val() == "${result.titleNo }") {
				$(this).find('span').addClass("txtB_blue");
			}
		});
		/*
		$.post("${rootPaht }/support/ruleHistoryL.do?titleNo=${result.titleNo }", function(data) {
			$('#history').html(data);
		});
		*/
	});
	</script>
	<div class="regulation">
		<c:if test="${result.useAt != 'Y' }">
		<p class="info_del">※ 삭제된 규정입니다.</p>
		</c:if>
		<table width="100%"  cellpadding="0" cellspacing="0" summary="">
			<caption></caption>
			<colgroup>
				<col class="col100">
				<col width="px">
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td>${result.sj }</td>
				</tr>
				<tr>
					<td colspan="2">${result.cn } </td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${result.atchFileId}" />
						</c:import>
					</td>
				</tr>
				<tr>
					<th>히스토리</th>
					<td class="pad">
						<c:forEach items="${resultList}" var="history">
						<c:if test="${history.typ == 'REG' || history.typ == 'MOD'}">
						<a href="/support/ruleL.do?contentNo=${history.contentNo }">
						<ul <c:if test="${result.contentNo == history.contentNo}">class="highlight"</c:if>>
							<c:choose>
							<c:when test="${history.typ == 'REG'}"><li class="rltitle T_blue">생성</li></c:when>
							<c:when test="${history.typ == 'MOD'}"><li class="rltitle T_black">수정</li></c:when>
							<c:when test="${history.typ == 'DEL'}"><li class="rltitle T_red">삭제</li></c:when>
							<c:when test="${history.typ == 'RCV'}"><li class="rltitle T_green">복원</li></c:when>
							<c:otherwise>${history.typ}</c:otherwise>
							</c:choose>
							<li>${history.tm }</li>
						</ul>
						</a>
						</c:if>
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</c:otherwise>
</c:choose>