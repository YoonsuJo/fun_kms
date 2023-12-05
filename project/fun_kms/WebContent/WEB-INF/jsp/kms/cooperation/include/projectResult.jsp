<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<!-- 게시판 시작  -->
<div class="boardList02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>업무진행내역</caption>
	<colgroup>
		<col class="col70" />
		<col class="col50" />
		<col width="px"/>
		<col class="col50"/>
	</colgroup>
	<thead>
		<tr>
			<th>등록일</th>
			<th>담당자</th>
			<th>실적 내용</th>
			<th class="td_last">시간</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td class="txt_center"><print:date date="${result.writeDate}"/></td>
				<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerName}"/></td>
				<td class="pL10">
					<p class="textarea1"><c:out value="${fn:replace(result.contents, cn, br)}" escapeXml="false"/></p>
					<c:if test="${!empty result.fileId}">
						<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${result.fileId}" />
						</c:import>
					</c:if>
				</td>
				<td class="td_last txt_center">${result.workHour}</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
</div>

<div class="paginate">
	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="taskSearch" type="image"/>
</div>
<!--// 업무진행내역  끝  -->
						
							
							
