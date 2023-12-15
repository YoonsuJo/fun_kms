<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="ProgId" content="Excel.Sheet">
<meta name="Generator" content="Microsoft Excel 11">
<%@ include file="../../include/ajax_inc.jsp"%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0">
	<colgroup>
		<col class="col50" />
		<col class="col50" />
		<col width="px" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
	</colgroup>
	<thead>
		<tr>
			<th colspan="13">휴일근무내역 (기간 : ${startDt} ~ ${endDt})</th>
		</tr>
		<tr>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">이름</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">소속회사</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">근무일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">시작일시</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">종료일시</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">근무일수</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">결재상태</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">휴일근무수당</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">휴일근무수당<br/>(결재완료)</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">휴일근무수당<br/>(결재중)</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">처리상태</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트코드</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트명</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<c:choose>
				<c:when test="${result.rowType == 'total'}">
					<tr>
						<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;" colspan="6">총계</td>
						<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;">${result.period}일</td>
						<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;"></td>
						<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;">${result.costAll}</td>
						<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;">${result.costConfirmed}</td>
						<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;">${result.costExpected}</td>
						<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;"></td>
						<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;"></td>
						<td style="background-color:#fff5ce;border:1px dotted #666666;"></td>
					</tr>
				</c:when>
				<c:when test="${result.rowType == 'subtotal'}">
					<tr>
						<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;" colspan="6">${result.userNm} 소계</td>
						<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;">${result.period}일</td>
						<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;"></td>
						<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;">${result.costAll}</td>
						<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;">${result.costConfirmed}</td>
						<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;">${result.costExpected}</td>
						<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;"></td>
						<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;"></td>
						<td style="background-color:#dbf0ff;border:1px dotted #666666;"></td>
					</tr>
				</c:when>
				<c:otherwise> <!-- rowType == 'item' -->
					<tr>
						<td style="text-align:center;border:1px dotted #666666;">${result.userNm}</td>
						<td style="text-align:center;border:1px dotted #666666;">${result.compNm}</td>
						<td style="border:1px dotted #666666;">${result.orgNm}</td>
						<td style="text-align:center;border:1px dotted #666666;">${result.stDt}</td>
						<td style="text-align:center;border:1px dotted #666666;">${result.stDt} ${result.stTm}</td>
						<td style="text-align:center;border:1px dotted #666666;">${result.edDt} ${result.edTm}</td>
						<td style="text-align:center;border:1px dotted #666666;">${result.period}일</td>
						<td style="text-align:center;border:1px dotted #666666;">
							<c:if test="${result.confirmYn == 'N'}">결재중</c:if>
							<c:if test="${result.confirmYn == 'Y'}">결재완료</c:if>
						</td>
						<td style="text-align:center;border:1px dotted #666666;">${result.costAll}</td>
						<td style="text-align:center;border:1px dotted #666666;">${result.costConfirmed}</td>
						<td style="text-align:center;border:1px dotted #666666;">${result.costExpected}</td>
						<td style="text-align:center;border:1px dotted #666666;">
							<c:if test="${result.handleStat == 0}">미처리</c:if>
							<c:if test="${result.handleStat == 1}">처리(<print:date date="${result.handleDt}" printType="S"/>)</c:if>
							<c:if test="${result.handleStat == 2}">처리취소(<print:date date="${result.handleDt}" printType="S"/>)</c:if>
							<c:if test="${result.handleStat == 3}">기타</c:if>
						</td>
						<td style="text-align:center;border:1px dotted #666666;">${result.prjCd}</td>
						<td style="border:1px dotted #666666;">${result.prjNm}</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</tbody>
</table>
<!--// 게시판 끝  -->
</body>
</html>
