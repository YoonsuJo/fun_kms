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
	</colgroup>
	<thead>
		<tr>
			<th colspan="9">업무실적 입력현황 (기간 : ${startDt} ~ ${endDt})</th>
		</tr>
		<tr>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">이름</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">소속부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">총근무일수</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">재직일수</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">휴가</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">대상일수</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">정상작성</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">시간미입력</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">미작성</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td class="txt_center">${result.userNm}</td>
				<td class="pL10">${result.orgNm}</td>
				<td class="txt_center">${result.totalWorkDay}</td>
				<td class="txt_center">${result.userWorkDay}</td>
				<td class="txt_center">${result.vac}</td>
				<td class="txt_center">${result.duty}</td>
				<td class="txt_center">${result.good}</td>
				<td class="txt_center">${result.zeroTime}</td>
				<td class="txt_center">${result.noInput}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!--// 게시판 끝  -->
</body>
</html>
