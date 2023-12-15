<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta name="ProgId" content="Excel.Sheet">
<meta name="Generator" content="Microsoft Excel 11">
<%@ include file="../include/ajax_inc.jsp"%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0">
	<colgroup>
		<col width="px" />
		<col class="col100" />
		<col class="col90" />
		<col class="col50" />
		<col class="col80" />
		<col class="col80" />
		<col class="col80" />
	</colgroup>
	<thead>
		<tr>
			<th colspan="7" height="5"></th>
		</tr>
		<tr>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">계정과목</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">회사구분</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">상신자</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">지출일자</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">금액</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">지출구분</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td bgcolor="#ffffff" class="pL10">[${result.prjCd}] ${result.prjNm}</td>
				<td bgcolor="#ffffff" class="txt_center" onmouseover="expLayerShow('${result.accNm}','${result.expCtPrint}',this);" onmouseout="expLayerHide();">${result.accNm}</td>
				<td bgcolor="#ffffff" class="txt_center">
					<c:forEach items="${comCdList}" var="comCd">
						<c:if test="${comCd.code == result.companyCd}">${comCd.codeNm}</c:if>
					</c:forEach>
				</td>
				<td bgcolor="#ffffff" class="txt_center">${result.userNm}</td>
				<td bgcolor="#ffffff" class="txt_center">${result.expDtPrint}</td>
				<td bgcolor="#ffffff" class="txt_center">${result.expSpendPrint}</td>
				<td bgcolor="#ffffff" class="txt_center">${result.expSpendTypPrint}</td>
			</tr>
			<tr>
				<td colspan="7" height="1" style="background-color:#858585;"></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!--// 게시판 끝  -->
</body>
</html>
