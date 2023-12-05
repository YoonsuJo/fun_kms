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
		<col class="col50" />
		<col class="col50" />
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
	</colgroup>
	<thead>
		<tr>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사번</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">이름</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">ID</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">주민번호</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">직급</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">소속부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">상태</th>			
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">입사일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">인정입사일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">퇴사일</th>			
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">이메일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">휴대전화</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">내선</th>			
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">주소</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td style="text-align:center;border:1px dotted #666666;"><c:out value="${result.sabun}"/></td>
				<td style="text-align:center;border:1px dotted #666666;">${result.userNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.userId}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.ihidNumFront} - ${result.ihidNumBack}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.rankNm}</td>
				<td style="border:1px dotted #666666;">${result.orgnztNm}</td>
				<td style="text-align:center;border:1px dotted #666666;"><c:out value="${result.workStPrint}"/></td>				
				<td style="text-align:center;border:1px dotted #666666;"><print:date date="${result.compinDt}" /></td>
				<td style="text-align:center;border:1px dotted #666666;"><print:date date="${result.acceptCompinDt}" /></td>
				<td style="text-align:center;border:1px dotted #666666;"><print:date date="${result.compotDt}" /></td>
				<td style="text-align:center;border:1px dotted #666666;">${result.emailAdres}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.moblphonNo}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.offmTelnoInner}</td>				
				<td style="text-align:center;border:1px dotted #666666;">${result.homeAdres}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!--// 게시판 끝  -->
</body>
</html>
