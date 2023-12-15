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
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col width="px" />
		<col class="col50" />
	</colgroup>
	<thead>
		<tr>
			<th colspan="7">법인차량 사용신청내역 (기간 : ${startDt} ~ ${endDt})</th>
		</tr>
		<tr>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">차량번호</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">차종</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사용기간</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사용구분</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">행선지</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사용목적</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사용자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td style="text-align:center;border:1px dotted #666666;">${result.carId}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.carTyp}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.stDt} ${result.stTm} ~ ${result.edDt} ${result.edTm}</td>
				<td style="text-align:center;border:1px dotted #666666;">
					<c:if test="${result.purpose == 'W'}">업무용</c:if>
					<c:if test="${result.purpose == 'P'}">개인용</c:if>
				</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.destination}</td>
				<td style="border:1px dotted #666666;">${result.rsvNote}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.userNm}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!--// 게시판 끝  -->
</body>
</html>
