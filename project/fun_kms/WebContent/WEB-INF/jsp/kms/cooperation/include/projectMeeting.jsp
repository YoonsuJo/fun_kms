<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<script>
function viewState(mtId) {
	var popup = window.open("/cooperation/selectMeetingRoomRecieveList.do?mtId=" + mtId,"_POP_STATE_","width=360px,height=415px,scrollbars=yes");
	popup.focus();
}
</script>

<div class="boardList02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>프로젝트 현황</caption>
	<colgroup>
		<col class="col40" />
		<col class="col90" />
		<col width="px"/>
		<col class="col50" />
		<col class="col98" />
		<col class="col98" />
		<col class="col50" />
	</colgroup>
	<thead>
		<tr>
			<th>번호</th>
			<th>프로젝트코드</th>
			<th>회의명</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>변경일</th>
			<th class="td_last">열람</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result" varStatus="c">
			<tr>
				<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
				<td class="txt_center"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}"/></td>
				<td class="pL10">
					<a href="${rootPath}/cooperation/selectMeetingRoom.do?mtId=${result.mtId}">
						<c:choose>
							<c:when test="${result.redYn == 'Y'}"><span class="txt_red">${result.mtSj}</span></c:when>
							<c:otherwise>${result.mtSj}</c:otherwise>
						</c:choose>
						<span class="txt_reply">[${result.commentCnt}]</span>
					</a>
				</td>
				<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
				<td class="txt_center">${fn:substring(result.regDt,0,10)}</td>
				<td class="txt_center">${result.modDt}</td>
				<td class="txt_center"><a href="javascript:viewState('${result.mtId}')">${result.readStatPrint}</a></td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
</div>

<div class="paginate">
	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="busiSearch" type="image"/>
</div>
