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
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col width="px" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
		<col class="col50" />
	</colgroup>
	<thead>
		<tr>
			<th colspan="14">경비지출내역 (기간 : ${startDt} ~ ${endDt})</th>
		</tr>
		<tr>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">지출일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">기안일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">기안자</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">계정과목</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">계정코드</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">금액</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">구분</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">카드번호</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">지급요청일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">내용</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">프로젝트</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">결재상태</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">지급일</th>
			<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">지출회사</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td class="txt_center">${result.expDt}</td>
				<td class="txt_center">${result.docDt}</td>
				<td class="txt_center">${result.writerNm}</td>
				<td class="txt_center">[${result.prntAccNm}] ${result.accNm}</td>
				<td class="txt_center">${result.accId}</td>
				<td class="txt_center">${result.expSpend}</td>
				<td class="txt_center">
					<c:if test="${result.expSpendType == 'CC'}">카드결제</c:if>
					<c:if test="${result.expSpendType == 'CP'}">회사결제</c:if>
					<c:if test="${result.expSpendType == 'PP'}">개인결제</c:if>
				</td>
				<td class="txt_center">${result.cardId}</td>
				<td class="txt_center">${result.payingDueDate}</td>
				<td class="pL10">${result.expCt}</td>
				<td class="txt_center">[${result.prjCd}] ${result.prjNm}</td>
				<td class="txt_center">
					<c:if test="${result.docStat == 'APP001' || result.docStat == 'APP002' || result.docStat == 'APP003'}">결재중</c:if>
					<c:if test="${result.docStat == 'APP004' || result.docStat == 'APP005'}">결재완료</c:if>
				</td>
				<td class="txt_center">${result.handleDt}</td>
				<td class="txt_center">${result.companyNm}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!--// 게시판 끝  -->
</body>
</html>
