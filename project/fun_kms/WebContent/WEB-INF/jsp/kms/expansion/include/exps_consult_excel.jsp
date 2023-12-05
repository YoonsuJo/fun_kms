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
		<col width="px" />
		<col width="px" />
		<col width="px" />
		<col width="px" />
		<col width="px" />
		<col width="px" />
		<col width="px" />
		<col width="px" />
		<col width="px" />
		<col width="px" />
		<col width="px" />
		<col class="col500" />
		<col class="col500" />
		<col width="px" />
	</colgroup>
	<thead>
		<tr>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">NO</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">상담번호</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">회사구분</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">상담일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">고객명</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">고객사</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">접수자</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">구분</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">상담분류</th>			
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">장애항목</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">담당자</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">문의내용</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">덧글</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">처리상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result" varStatus="c">
			<tr>
				<td style="text-align:center;border:1px dotted #666666;">${c.count}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.no}</td>
				
				<td style="text-align:center;border:1px dotted #666666;">
					<c:forEach items="${compnyList}" var="compny" varStatus="c">
						<c:if test="${result.compnyId == compny.code}">${compny.codeDc}</c:if>							      								      				
		      		</c:forEach>
				</td>
				
				<td style="text-align:center;border:1px dotted #666666;"><print:date date="${result.regDt}"/></td>
				
				<td style="text-align:center;border:1px dotted #666666;">${result.custManager}</td><!-- 고객명 -->
				
				<td style="text-align:center;border:1px dotted #666666;">${result.custNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.userNm}</td>
				
				<td style="text-align:center;border:1px dotted #666666;">
					<c:forEach items="${typeList}" var="type" varStatus="c">
						<c:if test="${result.typ == type.code}">${type.codeNm}</c:if>							      								      				
		      		</c:forEach>
				</td>
				<td style="text-align:center;border:1px dotted #666666;">
					<c:forEach items="${conList}" var="type" varStatus="c">
						<c:if test="${result.serviceTyp == type.code}">${type.codeNm}</c:if>							      								      				
		      		</c:forEach>
				</td>				
				<td style="text-align:center;border:1px dotted #666666;">
					<c:forEach items="${errorList}" var="type" varStatus="c">
						<c:if test="${result.errorTyp == type.code}">${type.codeNm}</c:if>							      								      				
		      		</c:forEach>
				</td>
				
				<td style="text-align:center;border:1px dotted #666666;">
				${fn:substring(result.charged, 0, fn:length(result.charged) - 1)}</td>
								
				<td style="text-align:center;border:1px dotted #666666;">${result.qCn}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.consultComment}</td>
				<td style="text-align:center;border:1px dotted #666666;">
					<c:forEach items="${stateList}" var="state" varStatus="c">
						<c:if test="${result.state == state.code}">${state.codeNm}</c:if>							      								      				
		      		</c:forEach>
				</td>
				
				
			</tr>
		</c:forEach>
	</tbody>
</table>
<!--// 게시판 끝  -->
</body>
</html>
