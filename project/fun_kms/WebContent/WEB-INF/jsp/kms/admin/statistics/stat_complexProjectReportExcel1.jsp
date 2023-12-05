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
			<th colspan="13">개인별 프로젝트투입율 및 프로젝트 실적 (기간 : ${startDt} ~ ${endDt})</th>			
		</tr>
		<tr>
			<th colspan="18" style="background-color:#ffff66;border:2px solid #666666;">투입프로젝트</th>
			<th colspan="13" style="background-color:#ffff66;border:2px solid #666666;">매입프로젝트1</th>
			<th colspan="13" style="background-color:#ffff66;border:2px solid #666666;">매입프로젝트2</th>
			<th colspan="13" style="background-color:#ffff66;border:2px solid #666666;">매입프로젝트3</th>
			<th colspan="12" style="background-color:#ffff66;border:2px solid #666666;">매입프로젝트4</th>			
		</tr>
		<tr>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">소속부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">이름</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트코드</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트명</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">주관부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">투입율</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">중복개수</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">환산투입율</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">매출이익</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">인건비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">판관비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">공통비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">영업이익</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">받은인건비</th>
<!--			Prj1-->
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트코드</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트명</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">주관부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">매출이익</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">인건비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">판관비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">공통비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">영업이익</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">받은인건비</th>
<!--			Prj2-->			
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트코드</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트명</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">주관부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">매출이익</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">인건비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">판관비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">공통비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">영업이익</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">받은인건비</th>
<!--			Prj3-->
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트코드</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트명</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">주관부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">매출이익</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">인건비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">판관비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">공통비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">영업이익</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">받은인건비</th>
<!--			Prj4-->
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트코드</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트명</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">주관부서</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매출</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사외매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">사내매입</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">매출이익</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">인건비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">판관비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">공통비</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">영업이익</th>
			
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">			
			<tr>
				<td style="text-align:center;border:1px dotted #666666;">${result.userOrgNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.userNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.prjCd}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.prjNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.prjOrgNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.orgRatio}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.repeatCount}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.realRatio}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.salesOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.salesIn}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.purchaseOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.purchaseInNormal}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.salesProfit}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.labor}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.exp}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.purchaseInCommon}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.totalProfit}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.prjSalesInLabor}</td>
				
				<td style="text-align:center;border:1px dotted #666666;">${result.p1PrjCd}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1PrjNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1OrgNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1SalesOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1SalesIn}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1PurchaseOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1PurchaseInNoraml}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1SalesProfit}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1Labor}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1Exp}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1PurchaseInCommon}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1TotalProfit}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p1PrjSalesInLabor}</td>
				
				<td style="text-align:center;border:1px dotted #666666;">${result.p2PrjCd}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2PrjNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2OrgNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2SalesOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2SalesIn}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2PurchaseOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2PurchaseInNoraml}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2SalesProfit}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2Labor}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2Exp}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2PurchaseInCommon}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2TotalProfit}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p2PrjSalesInLabor}</td>
				
				<td style="text-align:center;border:1px dotted #666666;">${result.p3PrjCd}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3PrjNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3OrgNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3SalesOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3SalesIn}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3PurchaseOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3PurchaseInNoraml}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3SalesProfit}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3Labor}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3Exp}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3PurchaseInCommon}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3TotalProfit}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p3PrjSalesInLabor}</td>
				
				<td style="text-align:center;border:1px dotted #666666;">${result.p4PrjCd}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4PrjNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4OrgNm}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4SalesOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4SalesIn}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4PurchaseOut}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4PurchaseInNoraml}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4SalesProfit}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4Labor}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4Exp}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4PurchaseInCommon}</td>
				<td style="text-align:center;border:1px dotted #666666;">${result.p4TotalProfit}</td>
				
			</tr>			
		</c:forEach>
	</tbody>
</table>
<!--// 게시판 끝  -->
</body>
</html>
