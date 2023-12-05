<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<div class="boardList02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>관련 매출건</caption>
	<colgroup>
		<col class="col100" />
		<col width="px" />
		<col class="col60" />
		<col class="col80" />
		<col class="col80" />
		<col class="col60" />
		<col class="col40" />
	</colgroup>
	<thead>
		<tr>
			<th>결제문서 종류</th>
			<th>제목</th>
			<th>기안자</th>
			<th>기안일</th>
			<th>매출액</th>
			<th>채권관리</th>
			<th class="td_last">효력</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${empty resultList }">
				<tr><td colspan="7" class="td_last txt_center" >※ 관련 매출건이 없습니다.</td></tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${resultList}" var="result" varStatus="c">
					<tr>
						<td class="txt_center">${result.templtNm}<br>(${result.decideYnPrint})</td>
						<td class="txt_center"><a href="/approval/approvalV.do?docId=${result.docId }">${result.subject}</a></td>
						<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
						<td class="txt_center"><print:date date="${result.writeDtShort}" printType='S'/></td>
						<td class="txt_center">
							<span <c:if test="${result.bondManageYn == 'Y' && result.newAt == 1}">class="txt_blue"</c:if>>
								<print:currency cost="${result.expSum}"/>
							</span>
						</td>
						<c:choose>
							<c:when test="${user.admin}">
								<td class="txt_center">
									<a href="javascript:toggleBondManageYn('${result.bondManageYn}', '${result.docId}');">
										<span <c:if test="${result.bondManageYn == 'N'}">class="txt_red"</c:if>>${result.bondManageYn}</span>
									</a>
								</td>
							</c:when>
							<c:otherwise>
								<td class="txt_center">
									<span <c:if test="${result.bondManageYn == 'N'}">class="txt_red"</c:if>>${result.bondManageYn}</span>
								</td>
							</c:otherwise>
						</c:choose>
						<td class="txt_center">
							<c:if test="${result.newAt == 1}">유효</c:if>
							<c:if test="${result.newAt == 0}"><span class="txt_red">무효</span></c:if>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
	</table>
</div>