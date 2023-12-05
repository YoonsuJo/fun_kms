<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<div class="boardList02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>관련 매입건(사내)</caption>
	<colgroup>
		<col class="col120" />
		<col width="px"/>
		<col class="col60" />
		<col class="col60" />
		<col class="col100" />
		<col class="col40" />
	</colgroup>
	<thead>
		<tr>
			<th>구분</th>
			<th>제목</th>
			<th>기안자</th>
			<th>기안일</th>
			<th>결재상태</th>
			<th class="td_last">효력</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${empty resultList }">
				<tr><td colspan="6" class="td_last txt_center" >※ 관련 매입건이 없습니다.</td></tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${resultList}" var="result" varStatus="c">
					<tr>
						<td class="txt_center">${result.templtNm}</td>
						<td class="txt_left pL5 pR5"><a href="/approval/approvalV.do?docId=${result.docId }" target="_blank">${result.subject}</a></td>
						<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
						<td class="txt_center"><print:date date="${result.writeDtShort}" printType='S'/></td>
						<td class="txt_center" >${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
						<td class="td_last txt_center">
							<c:if test="${result.newAt == 1}">유효</c:if>
							<c:if test="${result.newAt == 0}">무효</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
	</table>
</div>