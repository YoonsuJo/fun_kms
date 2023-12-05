<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<div class="boardList02 mB20">
	<c:set var="sum" value="0"/>
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>관련 매출건</caption>
	<colgroup>
		<col width="px"/>
		<col class="col60" />
		<col class="col60" />
		<col class="col100" />
		<col class="col40" />
		<col class="col100" />
	</colgroup>
	<thead>
		<tr>
			<th>제목</th>
			<th>기안자</th>
			<th>기안일</th>
			<th>결재상태</th>
			<th>효력</th>
			<th class="td_last">금액</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${empty resultList }">
				<tr><td colspan="6" class="td_last txt_center" >※ 관련 매입건이 없습니다.</td></tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${resultList}" var="result" varStatus="c">
					<c:if test="${result.newAt == 1}"><c:set var="sum" value="${sum + result.cost}"/></c:if>
					<tr>
						<td class="txt_left pL5 pR5"><a href="/approval/approvalV.do?docId=${result.docId }" target="_blank">${result.subject}</a></td>
						<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
						<td class="txt_center"><print:date date="${result.writeDtShort}" printType='S'/></td>
						<td class="txt_center" >${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
						<td class="txt_center" >
							<c:if test="${result.newAt == 1}">유효</c:if>
							<c:if test="${result.newAt == 0}">무효</c:if>
						</td>
						<td class="td_last txt_right pR5"><print:currency cost="${result.cost}" /></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
	<tfoot>
		<tr>
			<td class="txt_center" colspan="5">합계</td>
			<td class="txt_right pR5" ><print:currency cost="${sum}" /></td>
		</tr>
	</tfoot>
	</table>
</div>