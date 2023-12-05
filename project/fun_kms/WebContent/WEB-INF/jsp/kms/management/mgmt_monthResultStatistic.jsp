<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">

var id = "";
var nm = "";

<c:forEach items="${orgList}" var="org" varStatus="c">
	id += "${org.id},";
	nm += "${org.nm},";
</c:forEach>

<c:forEach items="${sectorList}" var="sector" varStatus="c">
	<c:if test="${sector.no == searchVO.searchSectorNo}">
		var sectorNo = "${sector.no}";
		var sectorVal = "${sector.busiSectorVal}";
	</c:if>
</c:forEach>

function updateStatistic(year, month) {

	if(!confirm(year + "년 " + month + "월 월간사업실적 업데이트를 하시겠습니까?") ){
		return;
	}

	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "updateYear";
	input.value = year;

	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "updateMonth";
	input2.value = month;

	document.frm.appendChild(input);
	document.frm.appendChild(input2);

	document.frm.action ="${rootPath}/management/updateStatistic.do";
	document.frm.submit();
}

function updateStatisticDate(year, month) {

	if(!confirm("월간사업실적 테이블의 프로젝트 시작 종료일 업데이트를 하시겠습니까?") ){
		return;
	}

	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "updateYear";
	input.value = year;

	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "updateMonth";
	input2.value = month;

	document.frm.appendChild(input);
	document.frm.appendChild(input2);

	document.frm.action ="${rootPath}/management/updateStatisticDate.do";
	document.frm.submit();
}

function search(i) {
	document.frm.searchYear.value = new Number(document.frm.searchYear.value) + i;
	document.frm.submit();
}

function outSale(includeResult){
	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "searchOrgId";
	input.value = id;

	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "searchOrgNm";
	input2.value = nm;

	var input3 = document.createElement("input");
	input3.type = "hidden";
	input3.name = "includeResult";
	input3.value = includeResult;

	document.frm.appendChild(input);
	document.frm.appendChild(input2);
	document.frm.appendChild(input3);
	document.frm.action ="${rootPath}/management/salesList.do";
	document.frm.submit();
};

function outPurchase(includeResult) {
	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "searchOrgId";
	input.value = id;

	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "searchOrgNm";
	input2.value = nm;

	var input3 = document.createElement("input");
	input3.type = "hidden";
	input3.name = "includeResult";
	input3.value = includeResult;

	document.frm.appendChild(input);
	document.frm.appendChild(input2);
	document.frm.appendChild(input3);
	document.frm.action = "${rootPath}/management/salesList.do";
	document.frm.submit();
}

function innerSale(typ, includeResult) {
	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "searchOrgId" + typ;
	input.value = id;

	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "searchOrgNm" + typ;
	input2.value = nm;

	var input3 = document.createElement("input");
	input3.type = "hidden";
	input3.name = "includeResult";
	input3.value = includeResult;

	document.frm.appendChild(input);
	document.frm.appendChild(input2);
	document.frm.appendChild(input3);
	document.frm.action = "${rootPath}/management/innerSalesList.do";
	document.frm.submit();
}

function prjInput() {
	var searchMonth = new Number("${searchVO.searchMonth}");
	if (searchMonth < 10) searchMonth = "0" + searchMonth;

	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "searchOrgId";
	input.value = id;

	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "searchOrgNm";
	input2.value = nm;

	var input3 = document.createElement("input");
	input3.type = "hidden";
	input3.name = "searchDate";
	input3.value = "${searchVO.searchYear}" + "" + searchMonth + "01";

	document.frm.appendChild(input);
	document.frm.appendChild(input2);
	document.frm.appendChild(input3);
	document.frm.action = "${rootPath}/management/selectInputResultProject.do";
	document.frm.submit();
}

function expensePlan() {
	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "searchOrgId";
	input.value = id;

	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "searchOrgNm";
	input2.value = nm;

	var input4 = document.createElement("input");
	input4.type = "hidden";
	input4.name = "includeResult";
	input4.value = "Y";

	document.frm.appendChild(input);
	document.frm.appendChild(input2);
	document.frm.appendChild(input4);
	document.frm.action = "${rootPath}/management/planResultStatistic.do";
	document.frm.submit();
}

function expenseDetail() {
	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "searchOrgId";
	input.value = id;

	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "searchOrgNm";
	input2.value = nm;

	var input3 = document.createElement("input");
	input3.type = "hidden";
	input3.name = "searchCondition";
	input3.value = "2";

	var input4 = document.createElement("input");
	input4.type = "hidden";
	input4.name = "includeNew";
	input4.value = "N";

	var input5 = document.createElement("input");
	input5.type = "hidden";
	input5.name = "includeCost";
	input5.value = "N";

	var input6 = document.createElement("input");
	input6.type = "hidden";
	input6.name = "includeExp";
	input6.value = "Y";

	document.frm.appendChild(input);
	document.frm.appendChild(input2);
	document.frm.appendChild(input3);
	document.frm.appendChild(input4);
	document.frm.appendChild(input5);
	document.frm.appendChild(input6);
	document.frm.action = "${rootPath}/management/selectExpenseDetail.do";
	document.frm.submit();
}

function notInputMemberShow() {
	$('#NoPut_layer').show();
}
function notInputMemberHide() {
	$('#NoPut_layer').hide();
}
</script>
</head>

<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">월간사업실적
							<c:if test="${searchVO.searchRecalcYn == 'Y' }">(실시간)</c:if>
							<c:if test="${searchVO.searchRecalcYn == 'N' }">(전일집계)</c:if></li>
							<li class="navi">홈 > 경영정보 > 사업실적 > 월간사업실적</li>
						</ul>
					</div>

					<!-- S: section -->
					<div class="section01">
	
						<!-- 상단 검색창 시작 -->
					<form name="frm" action="${rootPath}/management/monthResultStatistic.do" method="POST" onsubmit="search(0); return false;">
						<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						<input type="hidden" name="searchRecalcYn" value="${searchVO.searchRecalcYn}"/>
						<input type="hidden" name="searchResultType" value="0"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td>
										<a href="javascript:search(-1);"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
										${searchVO.searchYear}년
										<a href="javascript:search(1);" class="pR10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
									</td>
									<td class="search_right" >
										<c:forEach begin="1" end="12" var="mnth">
										<label><input type="radio" class="radio" name="searchMonth" value="${mnth}" 
											<c:if test="${mnth == searchVO.searchMonth}">checked="checked"</c:if>
											onclick="search(0);">${mnth}월</label><span class="pL5"></span>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="search_right" colspan="2">
										<span class="option_txt">사업구분 : </span><span class="pL7"></span>
										<select class="span_11" name="searchSectorNo" onchange="search(0);">
											<c:forEach items="${sectorList}" var="sector">
												<option value="${sector.no}" <c:if test="${sector.no == searchVO.searchSectorNo}">selected="selected"</c:if>>${sector.busiSectorNm}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
						</fieldset>
						</form>
						<!-- 상단 검색창 끝 -->
		
						<!-- 게시판 시작 -->
						<p class="txt_left">미투입인력 : <a href="javascript:notInputMemberShow();"><span class="txtB_grey">${fn:length(notInputMemberList)}</span> 명</a></p>
						<p class="th_plus02">단위 : 백만원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="월간사업실적 화면입니다.">
							<caption>월간사업실적</caption>
							<colgroup>
								<col width="120px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2">구분</th>
									<th colspan="4">월별 실적</th>
									<th colspan="3" class="td_last">누계</th>
								</tr>
								<tr>
									<th>목표</th>
									<th>예상</th>
									<th>실적</th>
									<th>달성률</th>
									<th>목표</th>
									<th>실적</th>
									<th class="td_last">달성률</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="txt_center T15 pT5 pB5">사외매출</td>
									<td class="txt_center T15"><a href="${rootPath}/management/selectAnnualBusinessPlan.do?searchYear=${searchVO.searchYear}&searchSectorNo=${searchVO.searchSectorNo}">${result.salesBusiPlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:outSale('Y');">${result.salesOutPlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:outSale('N');">${result.salesOutPrint}</a></td>
									<td class="txt_center T15">
					
									<c:set value="${fn:replace(result.salesBusiPlanPrint, ',', '')}" var="salesBusiPlan" />
									<c:set value=" ${fn:replace(result.salesOutPrint, ',', '')}"	 var="salesOut" />
									<c:if test="${result.salesBusiPlan >= 100000 && result.salesOut >= 100000}">
									<fmt:formatNumber value="${(salesOut/salesBusiPlan)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.salesBusiPlan < 100000 || result.salesOut < 100000}">
									0%
									</c:if>
					
									</td>
									<td class="txt_center T15">${result.salesBusiPlanAccPrint}</td>
									<td class="txt_center T15">${result.salesOutAccPrint}</td>
									<td class="td_last txt_center T15">
									<c:set value="${fn:replace(result.salesBusiPlanAccPrint, ',', '')}" var="salesBusiPlanAcc" />
									<c:set value=" ${fn:replace(result.salesOutAccPrint, ',', '')}"	 var="salesOutAcc" />
								
									<c:if test="${result.salesBusiPlanAcc >= 100000 && result.salesOutAcc >= 100000}">
									<fmt:formatNumber value="${(salesOutAcc/salesBusiPlanAcc)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.salesBusiPlanAcc < 100000 || result.salesOutAcc < 100000}">
									0%
									</c:if>
								
									</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">사내매출</td>
									<td class="txt_center T15">-</td>
									<td class="txt_center T15"><a href="javascript:innerSale('Purchase','Y');">${result.salesInPlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:innerSale('Purchase','N');">${result.salesInPrint}</a></td>
									<td class="txt_center T15">-</td>
									<td class="txt_center T15">-</td>
									<td class="txt_center T15">${result.salesInAccPrint}</td>
									<td class="td_last txt_center T15">-</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">사외매입</td>
									<td class="txt_center T15"><a href="${rootPath}/management/selectAnnualBusinessPlan.do?searchYear=${searchVO.searchYear}&searchSectorNo=${searchVO.searchSectorNo}">${result.purchaseOutBusiPlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:outPurchase('Y');">${result.purchaseOutPlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:outPurchase('N');">${result.purchaseOutPrint}</a></td>
									<td class="txt_center T15">
									<c:set value="${fn:replace(result.purchaseOutBusiPlanPrint, ',', '')}" var="purchaseOutBusiPlan" />
									<c:set value=" ${fn:replace(result.purchaseOutPrint, ',', '')}"	 var="purchaseOut" />
														
									<c:if test="${result.purchaseOutBusiPlan >= 100000 && result.purchaseOut >= 100000}">
									<fmt:formatNumber value="${(purchaseOut/purchaseOutBusiPlan)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.purchaseOutBusiPlan < 100000 || result.purchaseOut < 100000}">
									0%
									</c:if>
					
									</td>
									<td class="txt_center T15">${result.purchaseOutBusiPlanAccPrint}</td>
									<td class="txt_center T15">${result.purchaseOutAccPrint}</td>
									<td class="td_last txt_center T15">
									<c:set value="${fn:replace(result.purchaseOutBusiPlanAccPrint, ',', '')}" var="purchaseOutBusiPlanAcc" />
									<c:set value=" ${fn:replace(result.purchaseOutAccPrint, ',', '')}"	 var="purchaseOutAcc" />
					
									<c:if test="${result.purchaseOutBusiPlanAcc >= 100000 && result.purchaseOutAcc >= 100000}">
									<fmt:formatNumber value="${(purchaseOutAcc/purchaseOutBusiPlanAcc)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.purchaseOutBusiPlanAcc < 100000 || result.purchaseOutAcc < 100000}">
									0%
									</c:if>
														
									</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">사내매입</td>
									<td class="txt_center T15"><a href="${rootPath}/management/selectAnnualBusinessPlan.do?searchYear=${searchVO.searchYear}&searchSectorNo=${searchVO.searchSectorNo}">${result.purchaseInBusiPlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:innerSale('Sales','Y');">${result.purchaseInPlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:innerSale('Sales','N');">${result.purchaseInPrint}</a></td>
									<td class="txt_center T15">
									<c:set value="${fn:replace(result.purchaseInBusiPlanPrint, ',', '')}" var="purchaseInBusiPlan" />
									<c:set value=" ${fn:replace(result.purchaseInPrint, ',', '')}"	 var="purchaseIn" />
					
									<c:if test="${result.purchaseInBusiPlan >= 100000 && result.purchaseIn >= 100000}">
									<fmt:formatNumber value="${(purchaseIn/purchaseInBusiPlan)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.purchaseInBusiPlan < 100000 || result.purchaseIn < 100000}">
									0%
									</c:if>
					
									</td>
									<td class="txt_center T15">${result.purchaseInBusiPlanAccPrint}</td>
									<td class="txt_center T15">${result.purchaseInAccPrint}</td>
									<td class="td_last txt_center T15">
									<c:set value="${fn:replace(result.purchaseInBusiPlanAccPrint, ',', '')}" var="purchaseInBusiPlanAcc" />
									<c:set value=" ${fn:replace(result.purchaseInAccPrint, ',', '')}"	 var="purchaseInAcc" />
					
									<c:if test="${result.purchaseInBusiPlanAcc >= 100000 && result.purchaseInAcc >= 100000}">
									<fmt:formatNumber value="${(purchaseInAcc/purchaseInBusiPlanAcc)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.purchaseInBusiPlanAcc < 100000 || result.purchaseInAcc < 100000}">
									0%
									</c:if>
					
									</td>
								</tr>
								<tr>
									<td class="txt_center bG T15 pT5 pB5">매출이익</td>
									<td class="txt_center bG T15">
										<c:if test="${result.salesProfitBusiPlan < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.salesProfitBusiPlanPrint}<br/>(${0}%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.salesProfitBusiPlan >= 100000}">
											${result.salesProfitBusiPlanPrint}<br/>(${result.salesProfitBusiPlanPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.salesProfitPlan < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.salesProfitPlanPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.salesProfitPlan >= 100000}">
											${result.salesProfitPlanPrint}<br/>(${result.salesProfitPlanPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.salesProfit < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.salesProfitPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.salesProfit >= 100000}">
											${result.salesProfitPrint}<br/>(${result.salesProfitPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
									<c:set value="${fn:replace(result.salesProfitBusiPlanPrint, ',', '')}" var="salesProfitBusiPlan" />
									<c:set value=" ${fn:replace(result.salesProfitPrint, ',', '')}"	 var="salesProfit" />
														
									<c:if test="${result.salesProfitBusiPlan >= 100000 && result.salesProfit >= 100000}">
									<fmt:formatNumber value="${(salesProfit/salesProfitBusiPlan)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.salesProfitBusiPlan < 100000 || result.salesProfit < 100000}">
										0%
									</c:if>
					
					
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.salesProfitBusiPlanAcc < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.salesProfitBusiPlanAccPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.salesProfitBusiPlanAcc >= 100000}">
											${result.salesProfitBusiPlanAccPrint}<br/>(${result.salesProfitBusiPlanAccPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.salesProfitAcc < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.salesProfitAccPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.salesProfitAcc >= 100000}">
											${result.salesProfitAccPrint}<br/>(${result.salesProfitAccPercent}%)
										</c:if>
									</td>
									<td class="td_last txt_center bG T15">
									<c:set value="${fn:replace(result.salesProfitBusiPlanAccPrint, ',', '')}" var="salesProfitBusiPlanAcc" />
									<c:set value=" ${fn:replace(result.salesProfitAccPrint, ',', '')}"	 var="salesProfitAcc" />
					
									<c:if test="${result.salesProfitBusiPlanAcc >= 100000 && result.salesProfitAcc >= 100000}">
									<fmt:formatNumber value="${(salesProfitAcc/salesProfitBusiPlanAcc)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.salesProfitBusiPlanAcc < 100000 || result.salesProfitAcc < 100000}">
										0%
									</c:if>
					
									</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">인건비</td>
									<td class="txt_center T15"><a href="${rootPath}/management/selectAnnualBusinessPlan.do?searchYear=${searchVO.searchYear}&searchSectorNo=${searchVO.searchSectorNo}">${result.salaryBusiPlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:prjInput();">${result.salaryPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:prjInput();">${result.salaryPrint}</a></td>
									<td class="txt_center T15">
									<c:set value="${fn:replace(result.salaryBusiPlanPrint, ',', '')}" var="salaryBusiPlan" />
									<c:set value=" ${fn:replace(result.salaryPrint, ',', '')}"	 var="salary" />
					
									<c:if test="${result.salaryBusiPlan >= 100000 && result.salary >= 100000}">
										<fmt:formatNumber value="${(salary/salaryBusiPlan)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.salaryBusiPlan < 100000 || result.salary < 100000}">
										0%
									</c:if>
					
									</td>
									<td class="txt_center T15">${result.salaryBusiPlanAccPrint}</td>
									<td class="txt_center T15">${result.salaryAccPrint}</td>
									<td class="td_last txt_center T15">
									<c:set value="${fn:replace(result.salaryBusiPlanAccPrint, ',', '')}" var="salaryBusiPlanAcc" />
									<c:set value=" ${fn:replace(result.salaryAccPrint, ',', '')}"	 var="salaryAcc" />
					
									<c:if test="${result.salaryBusiPlanAcc >= 100000 && result.salaryAcc >= 100000}">
										<fmt:formatNumber value="${(salaryAcc/salaryBusiPlanAcc)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.salaryBusiPlanAcc < 100000 || result.salaryAcc < 100000}">
										0%
									</c:if>
														
									</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">판관비</td>
									<td class="txt_center T15"><a href="${rootPath}/management/selectAnnualBusinessPlan.do?searchYear=${searchVO.searchYear}&searchSectorNo=${searchVO.searchSectorNo}">${result.expenseBusiPlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:expensePlan();">${result.expensePlanPrint}</a></td>
									<td class="txt_center T15"><a href="javascript:expenseDetail();">${result.expensePrint}</a></td>
									<td class="txt_center T15">
									<c:set value="${fn:replace(result.expenseBusiPlanPrint, ',', '')}" var="expenseBusiPlan" />
									<c:set value=" ${fn:replace(result.expensePrint, ',', '')}"	 var="expense" />
					
									<c:if test="${result.expenseBusiPlan >= 100000 && result.expense >= 100000}">
										<fmt:formatNumber value="${(expense/expenseBusiPlan)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.expenseBusiPlan < 100000 || result.expense < 100000}">
										0%
									</c:if>
					
									</td>
									<td class="txt_center T15">${result.expenseBusiPlanAccPrint}</td>
									<td class="txt_center T15">${result.expenseAccPrint}</td>
									<td class="td_last txt_center T15">
									<c:set value="${fn:replace(result.expenseBusiPlanAccPrint, ',', '')}" var="expenseBusiPlanAcc" />
									<c:set value=" ${fn:replace(result.expenseAccPrint, ',', '')}"	 var="expenseAcc" />
					
									<c:if test="${result.expenseBusiPlanAcc >= 100000 && result.expenseAcc >= 100000}">
										<fmt:formatNumber value="${(expenseAcc/expenseBusiPlanAcc)*100}" pattern=".0"/>%
									</c:if>
									<c:if test="${result.expenseBusiPlanAcc < 100000 || result.expenseAcc < 100000}">
										0%
									</c:if>
					
									</td>
								</tr>
								<tr>
									<td class="txt_center bG T15 pT5 pB5">사업부공헌이익</td>
									<td class="txt_center bG T15">
										<c:if test="${result.diviProfitBusiPlan < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.diviProfitBusiPlanPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.diviProfitBusiPlan >= 100000}">
											${result.diviProfitBusiPlanPrint}<br/>(${result.diviProfitBusiPlanPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.diviProfitPlan < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.diviProfitPlanPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.diviProfitPlan >= 100000}">
											${result.diviProfitPlanPrint}<br/>(${result.diviProfitPlanPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.diviProfit < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.diviProfitPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.diviProfit >= 100000}">
											${result.diviProfitPrint}<br/>(${result.diviProfitPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
									<c:set value="${fn:replace(result.diviProfitBusiPlanPrint, ',', '')}" var="busiProfitBusiPlan" />
									<c:set value=" ${fn:replace(result.diviProfitPrint, ',', '')}"	 var="busiProfit" />
									<c:if test="${result.diviProfit < 100000 || result.diviProfitBusiPlan < 100000}">
									<c:out value='<span class="txt_red">' escapeXml="false"/>
										0%
									<c:out value='</span>' escapeXml="false"/>
									</c:if>
									<c:if test="${result.diviProfit >= 100000 && result.diviProfitBusiPlan >= 100000}">
										<fmt:formatNumber value="${(busiProfit/busiProfitBusiPlan)*100}" pattern=".0"/>%
									</c:if>
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.diviProfitBusiPlanAcc < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.diviProfitBusiPlanAccPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.diviProfitBusiPlanAcc >= 100000}">
											${result.diviProfitBusiPlanAccPrint}<br/>(${result.diviProfitBusiPlanAccPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.diviProfitAcc < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.diviProfitAccPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.diviProfitAcc >= 100000}">
											${result.diviProfitAccPrint}<br/>(${result.diviProfitAccPercent}%)
										</c:if>
									</td>
									<td class="td_last txt_center bG T15">
									<c:set value="${fn:replace(result.diviProfitBusiPlanAccPrint, ',', '')}" var="busiProfitBusiPlanAcc" />
									<c:set value=" ${fn:replace(result.diviProfitAccPrint, ',', '')}"	 var="busiProfitAcc" />
									<c:if test="${result.diviProfitAcc < 100000 || result.diviProfitBusiPlanAcc < 100000}">
									<c:out value='<span class="txt_red">' escapeXml="false"/>
										0%
									<c:out value='</span>' escapeXml="false"/>
									</c:if>
									<c:if test="${result.diviProfitAcc >= 100000 && result.diviProfitBusiPlanAcc >= 100000}">
										<fmt:formatNumber value="${(busiProfitAcc/busiProfitBusiPlanAcc)*100}" pattern=".0"/>%
									</c:if>
									</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">공통비</td>
									<td class="txt_center T15"><a href="${rootPath}/management/selectAnnualBusinessPlan.do?searchYear=${searchVO.searchYear}&searchSectorNo=${searchVO.searchSectorNo}">${result.commonPrint}</a></td>
									<td class="txt_center T15"><a href="${rootPath}/management/selectAnnualBusinessPlan.do?searchYear=${searchVO.searchYear}&searchSectorNo=${searchVO.searchSectorNo}">${result.commonPrint}</a></td>
									<td class="txt_center T15"><a href="${rootPath}/management/selectAnnualBusinessPlan.do?searchYear=${searchVO.searchYear}&searchSectorNo=${searchVO.searchSectorNo}">${result.commonPrint}</a></td>
									<td class="txt_center T15">-</td>
									<td class="txt_center T15">${result.commonAccPrint}</td>
									<td class="txt_center T15">${result.commonAccPrint}</td>
									<td class="td_last txt_center T15">-</td>
								</tr>
								<tr>
									<td class="txt_center bG T15 pT5 pB5">영업이익</td>
									<td class="txt_center bG T15">
										<c:if test="${result.busiProfitBusiPlan < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.busiProfitBusiPlanPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.busiProfitBusiPlan >= 100000}">
											${result.busiProfitBusiPlanPrint}<br/>(${result.busiProfitBusiPlanPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.busiProfitPlan < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.busiProfitPlanPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.busiProfitPlan >= 100000}">
											${result.busiProfitPlanPrint}<br/>(${result.busiProfitPlanPercent}%)
										</c:if>

									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.busiProfit < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.busiProfitPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.busiProfit >= 100000}">
											${result.busiProfitPrint}<br/>(${result.busiProfitPercent}%)
										</c:if>
									</td>
									<td class="txt_center bG T15">
									<c:set value="${fn:replace(result.busiProfitBusiPlanPrint, ',', '')}" var="busiProfitBusiPlan" />
									<c:set value=" ${fn:replace(result.busiProfitPrint, ',', '')}"	 var="busiProfit" />
					
									<c:if test="${result.busiProfit < 100000 || result.busiProfitBusiPlan < 100000}">
									<c:out value='<span class="txt_red">' escapeXml="false"/>
										0%
									<c:out value='</span>' escapeXml="false"/>
									</c:if>
									<c:if test="${result.busiProfit >= 100000 && result.busiProfitBusiPlan >= 100000}">
										<fmt:formatNumber value="${(busiProfit/busiProfitBusiPlan)*100}" pattern=".0"/>%
									</c:if>
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.busiProfitBusiPlanAcc < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.busiProfitBusiPlanAccPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.busiProfitBusiPlanAcc >= 100000}">
											${result.busiProfitBusiPlanAccPrint}<br/>(${result.busiProfitBusiPlanAccPercent}%)
										</c:if>
						
									</td>
									<td class="txt_center bG T15">
										<c:if test="${result.busiProfitAcc < 100000}">
											<c:out value='<span class="txt_red">' escapeXml="false"/>
											${result.busiProfitAccPrint}<br/>(0%)
											<c:out value='</span>' escapeXml="false"/>
										</c:if>
										<c:if test="${result.busiProfitAcc >= 100000}">
											${result.busiProfitAccPrint}<br/>(${result.busiProfitAccPercent}%)
										</c:if>
								
									</td>
									<td class="td_last txt_center bG T15">
									<c:set value="${fn:replace(result.busiProfitBusiPlanAccPrint, ',', '')}" var="busiProfitBusiPlanAcc" />
									<c:set value=" ${fn:replace(result.busiProfitAccPrint, ',', '')}"	 var="busiProfitAcc" />
					
									<c:if test="${result.busiProfitAcc < 100000 || result.busiProfitBusiPlanAcc < 100000}">
									<c:out value='<span class="txt_red">' escapeXml="false"/>
										0%
									<c:out value='</span>' escapeXml="false"/>
									</c:if>
									<c:if test="${result.busiProfitAcc >= 100000 && result.busiProfitBusiPlanAcc >= 100000}">
										<fmt:formatNumber value="${(busiProfitAcc/busiProfitBusiPlanAcc)*100}" pattern=".0"/>%
									</c:if>
					
					
									</td>
								</tr>
								<%-- 차후 개발 내용
								<tr>
									<td class="txt_center">운전자금손익</td>
									<td class="txt_center">-</td>
									<td class="txt_center">-</td>
									<td class="txt_center">-</td>
									<td class="txt_center">-</td>
									<td class="td_last txt_center">-</td>
								</tr>
								<tr>
									<td class="txt_center bG">평가손익</td>
									<td class="txt_center bG">-<br/>(%)</td>
									<td class="txt_center bG">-<br/>(%)</td>
									<td class="txt_center bG">-<br/>(%)</td>
									<td class="txt_center bG">-<br/>(%)</td>
									<td class="td_last txt_center bG">-<br/>(%)</td>
								</tr>
								--%>
							</tbody>
							</table>
							
							<br/><br/>
							<!-- 
								<p class="th_plus02">
									최신 업데이트 : ${lastModDt} (경영 실적 업데이트를 원하시면 KMS 관리자에게게 문의하세요)
								</p>
							<br/>
							 -->
							<c:if test="${user.admin && searchVO.searchRecalcYn != 'Y'}">
								<p class="th_plus02">
									<a href="javascript:updateStatistic('${searchVO.searchYear}', '${searchVO.searchMonth}');">${searchVO.searchMonth}월 실적 업데이트</a>
									<br/>
									<a href="javascript:updateStatisticDate('${searchVO.searchYear}', '${searchVO.searchMonth}');">프로젝트 시작일/종료일 업데이트</a>
									<!-- <a href="javascript:updateStatistic('${searchVO.searchYear}', '${searchVO.searchMonth}');">일괄 업데이트</a> -->
								</p>
							</c:if>
						</div>
						<!--// 게시판 끝 -->
		
						<!-- 미투입인력 레이어 -->
						<c:set var="memCnt" value="${fn:length(notInputMemberList)}" />
						<c:set var="layerHeight" value="${(memCnt - (memCnt%3) + 3)*10 + 50}" />
						<div class="NoPut_layer" id="NoPut_layer" style="display:none;<c:if test="${memCnt <= 45}"> height:${layerHeight}px;</c:if>">
							<table cellpadding="0" cellspacing="0" summary="">
							<caption>미투입인력</caption>
							<colgroup>
								<col width="33%">
								<col width="33%">
								<col width="33%">
							</colgroup>
							<tbody>
								<c:forEach items="${notInputMemberList}" var="mem" varStatus="c">
									<c:if test="${c.count % 3 == 1}">
									<c:out value="<tr>" escapeXml="false" />
									</c:if>
									<td><print:user userNo="${mem.no}" userNm="${mem.userNm}" userId="${mem.userId}" printId="true"/></td>
									<c:if test="${c.count % 3 == 0}">
									<c:out value="<tr>" escapeXml="false" />
									</c:if>
								</c:forEach>
							</tbody>
							</table>
							<p>
								<a href="javascript:notInputMemberHide();"><img src="${imagePath}/btn/btn_close.gif"/></a>
							</p>
						</div>
						<!-- //미투입인력 레이어 -->
		
					</div>
					<!-- E: section -->
				</div>
				<!-- E: center -->
				<%@ include file="../include/right.jsp"%>
			</div>
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
