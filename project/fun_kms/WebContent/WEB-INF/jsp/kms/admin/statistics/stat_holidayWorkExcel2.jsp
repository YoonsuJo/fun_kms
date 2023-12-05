<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
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
		<col width="px" />
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
			<th colspan="9">${compNm} 휴일근무내역 (기간 : ${startDt} ~ ${endDt})</th>
		</tr>
		<tr>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">이름</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">근무일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">시작일시</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">종료일시</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">근무일수</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">휴일근무수당</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">처리상태</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트코드</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트명</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${result.userHolWorkList}" var="uhw">
			<c:forEach items="${uhw.detailList}" var="detail" varStatus="c">
				<tr>
                   	<c:if test="${c.count == 1}">
                   	<td style="text-align:center;border:1px dotted #666666;" rowspan="${fn:length(uhw.detailList)}">${detail.userNm}</td>
                   	</c:if>
					<td style="border:1px dotted #666666;">${detail.orgNm}</td>
					<td style="text-align:center;border:1px dotted #666666;">${detail.stDt}</td>
					<td style="text-align:center;border:1px dotted #666666;">${detail.stDt} ${detail.stTm}</td>
					<td style="text-align:center;border:1px dotted #666666;">${detail.edDt} ${detail.edTm}</td>
					<td style="text-align:center;border:1px dotted #666666;">${detail.period}일</td>
					<td style="text-align:center;border:1px dotted #666666;">${detail.costConfirmed}</td>
					<td style="text-align:center;border:1px dotted #666666;">
						<c:if test="${detail.handleStat == 0}">미처리</c:if>
						<c:if test="${detail.handleStat == 1}">처리(<print:date date="${detail.handleDt}" printType="S"/>)</c:if>
						<c:if test="${detail.handleStat == 2}">처리취소(<print:date date="${detail.handleDt}" printType="S"/>)</c:if>
						<c:if test="${detail.handleStat == 3}">기타</c:if>
					</td>
					<td style="text-align:center;border:1px dotted #666666;">${detail.prjCd}</td>
					<td style="border:1px dotted #666666;">${detail.prjNm}</td>
				</tr>
			</c:forEach>
			<tr>
				<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;" colspan="5">${uhw.subTotal.userNm} 소계</td>
				<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;">${uhw.subTotal.period}일</td>
				<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;">${uhw.subTotal.costConfirmed}</td>
				<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;"></td>
				<td style="background-color:#dbf0ff;text-align:center;border:1px dotted #666666;"></td>
				<td style="background-color:#dbf0ff;border:1px dotted #666666;"></td>
			</tr>
		</c:forEach>
		<tr>
			<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;" colspan="5">총계</td>
			<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;">${result.total.period}일</td>
			<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;">${result.total.costConfirmed}</td>
			<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;"></td>
			<td style="background-color:#fff5ce;text-align:center;border:1px dotted #666666;"></td>
			<td style="background-color:#fff5ce;border:1px dotted #666666;"></td>
		</tr>
	</tbody>
</table>
<!--// 게시판 끝  -->
</body>
</html>
