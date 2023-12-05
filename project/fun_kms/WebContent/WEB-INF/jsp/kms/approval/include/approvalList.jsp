<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<div class="boardList02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>관련 매출건</caption>
	<colgroup>
		<col class="col60" />
		<col class="col120" />
		<col width="px"/>
		<col class="col60" />
		<col class="col60" />
		<col class="col100" />
	</colgroup>
	<thead>
		<tr>
			<th>번호 </th>
			<th>문서종류</th>
			<th>제목</th>
			<th>기안자</th>
			<th>기안일시</th>
			<th class="td_last">결재상태</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${empty resultList }">
				<tr><td colspan="6" class="td_last txt_center" >※ 관련결재문서가 없습니다.</td></tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${resultList}" var="result" varStatus="c">
					<tr>
						<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
						<td class="txt_center">${result.templtNm}</td>
						<td class="txt_center"><a href="/approval/approvalV.do?docId=${result.docId }">${result.subject}</a></td>
						<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
						<td class="txt_center">${result.writeDtMedium}</td>
						<td class="td_last txt_center" >${result.docStatPrint}<br>(${result.preAppDtMedium})</td>					
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
	</table>
</div>
<!-- 
<div class="paginate">
	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="salesSearch" type="image"/>
</div>
 -->