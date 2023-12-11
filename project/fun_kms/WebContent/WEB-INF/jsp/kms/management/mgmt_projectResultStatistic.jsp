<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<style>
	tr.TrBg4_2 a { color: #A6A6A6;}
</style>
<script type="text/javascript">
function search(i) {
	document.frm.searchYear.value = new Number(document.frm.searchYear.value) + i;
	document.frm.submit();
}
function view(id, lv) {
	document.frm.searchId.value = id;
	document.frm.searchLv.value = lv;
	document.frm.submit();
}
function back(sn, lv) {
	var tmp = sn.split("/");
	
	document.frm.searchId.value = tmp[tmp.length - 2];
	document.frm.searchLv.value = new Number(lv) - 1;
	document.frm.submit();
}
function innerSale(typ, id, nm) {
	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "searchPrjId" + typ;
	input.value = id;

	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "searchPrjNm" + typ;
	input2.value = nm;
	
	var input3 = document.createElement("input");
	input3.type = "hidden";
	input3.name = "searchCondition" + typ;
	input3.value = 1;
	
	document.frm.appendChild(input);
	document.frm.appendChild(input2);
	document.frm.appendChild(input3);
	document.frm.action = "${rootPath}/management/innerSalesList.do";
	document.frm.submit();
}
function outSale(){
	document.frm.action ="${rootPath}/management/salesList.do";
	document.frm.submit();
};
function prjInput() {
	var searchMonth = new Number("${searchVO.searchMonth}");
	if (searchMonth < 10) searchMonth = "0" + searchMonth;
	
	var input3 = document.createElement("input");
	input3.type = "hidden";
	input3.name = "searchDate";
	input3.value = "${searchVO.searchYear}" + "" + searchMonth + "01";

	document.frm.appendChild(input3);
	document.frm.action = "${rootPath}/management/selectInputResultProject.do";
	document.frm.submit();
}
function expenseDetail(id, nm) {
	
	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "searchPrjId";
	input.value = id;
	
	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "searchPrjNm";
	input2.value = nm;
	
	var input3 = document.createElement("input");
	input3.type = "hidden";
	input3.name = "searchCondition";
	input3.value = 3;
	
	var input4 = document.createElement("input");
	input4.type = "hidden";
	input4.name = "includeNew";
	input4.value = "${searchVO.includeResult}";

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
var end = new Number("${fn:length(resultList)}");
var recalcYn = "${searchVO.searchRecalcYn}";
if (end == 0) {
	$.post("/ajax/projectResultOrgSumStatistic.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&includeResult=${searchVO.includeResult}&searchOrgId=${searchVO.searchOrgId}",
		function(data){
			$('#sumRow').html(data);
		}
	);
}
var showRight = true;
$(document).ready(function() {
	showRight = ${user.showRight};
	if (recalcYn == 'Y') {
		<c:forEach items="${resultList}" var="result" varStatus="c">
			refreshPrjNmStr("tr_${c.count}");
			
			$.post("/ajax/projectResultStatistic.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&includeResult=${searchVO.includeResult}&prjId=${result.prjId}&havingLeaf=${result.havingLeaf}",
				function(data){
					$("#tr_${c.count}").html(data);
					end--;
					
					if (end == 0) {
						$.post("/ajax/projectResultOrgSumStatistic.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&includeResult=${searchVO.includeResult}&searchOrgId=${searchVO.searchOrgId}",
							function(data){
								$('#sumRow').html(data);
							}
						);
					}
					refreshPrjNmStr("tr_${c.count}");
				}
			);
		</c:forEach>
	}

	<c:forEach items="${resultList}" var="result" varStatus="c">
		var tr = document.getElementById("tr_${c.count}");
		if (tr == null) return;
		refreshPrjNmStr("tr_${c.count}");
	</c:forEach>

	$('#center').bind('showRightEvent', function() {
		showRight = true;
		<c:forEach items="${resultList}" var="result" varStatus="c">
			var tr = document.getElementById("tr_${c.count}");
			if (tr == null) return;
			refreshPrjNmStr("tr_${c.count}");
		</c:forEach>
	});

	$('#center').bind('hideRightEvent', function() {
		showRight = false;
		<c:forEach items="${resultList}" var="result" varStatus="c">
			var tr = document.getElementById("tr_${c.count}");
			if (tr == null) return;
			refreshPrjNmStr("tr_${c.count}");
		</c:forEach>
	});
});
//사업구분 선택 //주석처리로 사용안함
function setOrgId() {
	var act = new yAjax("${rootPath}/ajax/selectUnderOrgList.do", "POST");
	act.send = "searchOrgId=" + document.frm.searchBusiId.value;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var id = xml.getValue("id",0);
		var nm = xml.getValue("nm",0);
		document.frm.searchOrgId.value = id;
		document.frm.searchOrgNm.value = nm;
	};
	act.action();
}
function refreshPrjNmStr(trId) {
	var tr = document.getElementById(trId);
	if (tr == null) return;
	
	var tdLong = document.getElementById(trId).getElementsByTagName('td')[0];
	var tdShort = document.getElementById(trId).getElementsByTagName('td')[1];
	var tdOld = document.getElementById(trId).getElementsByTagName('td')[2];
	if (tdLong == null || tdShort == null || tdOld == null) return;
	
	if (showRight) 
		tdOld.innerHTML = tdShort.innerHTML;
	else 
		tdOld.innerHTML = tdLong.innerHTML;
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
							<li class="stitle">프로젝트별 실적</li>
							<li class="navi">홈 > 경영정보 > 사업실적 > 프로젝트별 실적</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 상단 검색창 시작 -->
						<form name="frm" action="${rootPath}/management/projectResultStatistic.do" method="POST" onsubmit="search(0); return false;">
						<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchRecalcYn" value="${searchVO.searchRecalcYn}"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td colspan="2">
										<a href="javascript:search(-1);"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
											${searchVO.searchYear}년
										<a href="javascript:search(1);" class="pR10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
									</td>
								</tr>
								<tr>
									<td>
										<c:forEach begin="1" end="12" var="mnth">
										<label><input type="radio" class="radio" name="searchMonth" value="${mnth}" 
											<c:if test="${mnth == searchVO.searchMonth}">checked="checked"</c:if>
											onclick="search(0);"> ${mnth}월</label>
										</c:forEach>
									</td>
									<td class="search_right">
										<label><input type="checkbox" name="includeAllDate" value="Y" 
											<c:if test="${searchVO.includeAllDate == 'Y'}">checked="checked"</c:if>/> 전체기간포함</label><br/>	
										<label><input type="checkbox" name="includeResult" value="Y" 
											<c:if test="${searchVO.includeResult == 'Y'}">checked="checked"</c:if>/> 예상실적포함</label><br/>
										<label><input type="checkbox" name="includeAcc" value="Y" 
											<c:if test="${searchVO.includeAcc == 'Y'}">checked="checked"</c:if>/> 누적실적보기</label>
									</td>
								</tr>
								<tr>
									<td class="search_right">
										<!-- 
										<span class="option_txt">사업구분 : </span>
										<select name="searchBusiId" onchange="setOrgId();">
											<option value="">============ 선택 ============</option>
											<c:forEach items="${busiIdList}" var="busiId">
												<option value="${busiId.id}">${busiId.nm}</option>
											</c:forEach>
										</select><span class="pL7"></span>
										 -->
										<span class="option_txt">부서 : </span>
										<input type="text" class="span_12" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}" readonly="readonly" onclick="orgGen('orgNm','orgId',0);"/>
										<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('orgNm','orgId',0);"/>
									</td>
									<td class="search_right">
										<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02" alt="검색"/>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
						</fieldset>
						</form>
						<!-- 상단 검색창 끝 -->
						
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 천원</p>
<!-- 누적실적 X -->
<c:if test="${searchVO.includeAcc != 'Y'}">
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col width="px" />
								<col class="col60" />
								<col class="col60" />
								<col class="col60" />
								<col class="col60" />
								<col class="col60" />
								<col class="col60" />
								<col class="col60" />
								<col class="col60" />
								<col class="col60" />
							</colgroup>
							<thead>
								<tr class="height_th">
									<th>프로젝트</th>
									<th>사외매출</th>
									<th>사내매출</th>
									<th>사외매입</th>
									<th>사내매입</th>
									<th>매출이익</th>
									<th>인건비</th>
									<th>판관비</th>
									<th>이익</th>
									<th class="td_last">이익<br/>누계</th>
								</tr>
							</thead>		                    
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<c:choose>
										<c:when test="${result.havingLeaf == false}">
											<tr id="tr_${c.count}" 
												<c:if test="${result.stat == 'P'}">class="TrBg4_1"</c:if>
												<c:if test="${result.stat == 'E' || result.stat == 'S'}">class="TrBg4_2"</c:if>>
												<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="40"/></td>
												<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="18"/></td>
												<td class="pL10"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="18"/></td>
												<td class="txt_center">
													<!-- <a href="javascript:outSale();" target="_blank">${result.salesOutPrint}</a> -->
													<a href="/management/salesList.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&
															searchCondition=0&includeResult=Y&searchOrgId=${searchVO.searchOrgId}&searchOrgNm=${searchVO.searchOrgNm}" target="_blank">
														${result.salesOutPrint}
													</a>
												</td>
												<td class="txt_center">
													<!-- <a href="javascript:innerSale('Purchase','${result.prjId}','${result.prjNm}');" target="_blank"> -->
													<a href="/management/innerSalesList.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&
														includeResult=Y&searchPrjIdPurchase=${result.prjId}&searchPrjNmPurchase=${result.prjNm}&searchConditionPurchase=1" target="_blank">
														${result.salesInPrint}
													</a>
												</td>
												<td class="txt_center">
													<!-- <a href="javascript:outSale();" target="_blank"> -->
													<a href="/management/salesList.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&
															searchCondition=0&includeResult=Y&searchOrgId=${searchVO.searchOrgId}&searchOrgNm=${searchVO.searchOrgNm}" target="_blank">
														${result.purchaseOutPrint}
													</a>
												</td>
												<td class="txt_center">
													<!-- <a href="javascript:innerSale('Sales','${result.prjId}','${result.prjNm}');" target="_blank"> -->
													<a href="/management/innerSalesList.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&
														includeResult=Y&searchPrjIdSales=${result.prjId}&searchPrjNmSales=${result.prjNm}&searchConditionSales=1" target="_blank">
														${result.purchaseInPrint}
													</a>
												</td>
												<td class="txt_center">
													<c:if test="${result.salesProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
													${result.salesProfitPrint}
													<c:if test="${result.salesProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
												</td>
												<td class="txt_center">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.salary < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.salaryPrint}
															<c:if test="${result.salary < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="txt_center">
													<!-- <a href="javascript:expenseDetail('${result.prjId}','${result.prjNm}');" target="_blank"> -->
													<a href="/management/selectExpenseDetail.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&
														includeResult=Y&searchPrjId=${result.prjId}&searchPrjNm=${result.prjNm}&searchCondition=3&
														includeNew=${searchVO.includeResult}&includeCost=N&includeExp=Y" target="_blank">
														${result.expensePrint}
													</a>
												</td>
												<td class="txt_center">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.busiProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.busiProfitPrint}
															<c:if test="${result.busiProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="td_last txt_center">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.busiProfitAccPrint}
															<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr id="tr_${c.count}"
												<c:if test="${result.stat == 'P'}">class="TrBg4_1"</c:if>
												<c:if test="${result.stat == 'E' || result.stat == 'S'}">class="TrBg4_2"</c:if>>
												<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="37"/> 소계</td>
												<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" bracket="Y" length="15"/> 소계</td>
												<td class="txt_center bG02"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" bracket="Y" length="15"/> 소계</td>
												<td class="txt_center bG02">${result.salesOutPrint}</td>
												<td class="txt_center bG02">${result.salesInPrint}</td>
												<td class="txt_center bG02">${result.purchaseOutPrint}</td>
												<td class="txt_center bG02">${result.purchaseInPrint}</td>
												<td class="txt_center bG02">
													<c:if test="${result.salesProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
													${result.salesProfitPrint}
													<c:if test="${result.salesProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
												</td>
												<td class="txt_center bG02">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.salary < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.salaryPrint}
															<c:if test="${result.salary < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="txt_center bG02">${result.expensePrint}</td>
												<td class="txt_center bG02">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.busiProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.busiProfitPrint}
															<c:if test="${result.busiProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="td_last txt_center bG02">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.busiProfitAccPrint}
															<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr id="sumRow">
									<td class="txt_center">합계</td>
									<td class="txt_center">${sum.salesOutPrint}</td>
									<td class="txt_center">${sum.salesInPrint}</td>
									<td class="txt_center">${sum.purchaseOutPrint}</td>
									<td class="txt_center">${sum.purchaseInPrint}</td>
									<td class="txt_center">
										<c:if test="${sum.salesProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
										${sum.salesProfitPrint}
										<c:if test="${sum.salesProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
									</td>
									<td class="txt_center">
										<c:choose>
											<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
											<c:otherwise>
												<c:if test="${sum.salary < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
												${sum.salaryPrint}
												<c:if test="${sum.salary < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center">${sum.expensePrint}</td>
									<td class="txt_center">
										<c:choose>
											<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
											<c:otherwise>
												<c:if test="${sum.busiProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
												${sum.busiProfitPrint}
												<c:if test="${sum.busiProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="td_last txt_center">
										<c:choose>
											<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
											<c:otherwise>
												<c:if test="${sum.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
												${sum.busiProfitAccPrint}
												<c:if test="${sum.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</tfoot>
							</table>
						</div>
</c:if>

<!-- 누적실적 O -->
<c:if test="${searchVO.includeAcc == 'Y'}">
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col width="px" />
								<col class="col70" />
								<col class="col70" />
								<col class="col70" />
								<col class="col70" />
								<col class="col70" />
								<col class="col70" />
								<col class="col70" />
								<col class="col70" />
							</colgroup>
							<thead>
								<tr class="height_th">
									<th>프로젝트</th>
									<th>사외매출</th>
									<th>사내매출</th>
									<th>사외매입</th>
									<th>사내매입</th>
									<th>매출이익</th>
									<th>인건비</th>
									<th>판관비</th>
									<th>이익</th>
								</tr>
							</thead>		                    
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<c:choose>
										<c:when test="${result.havingLeaf == false}">
											<tr id="tr_${c.count}">
												<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="40"/></td>
												<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="18"/></td>
												<td class="pL10"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="18"/></td>
												<td class="txt_center">
													${result.salesOutAccPrint}
												</td>
												<td class="txt_center">
													${result.salesInAccPrint}
												</td>
												<td class="txt_center">
													${result.purchaseOutAccPrint}
												</td>
												<td class="txt_center">
													${result.purchaseInAccPrint}
												</td>
												<td class="txt_center">
													<c:if test="${result.salesProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
													${result.salesProfitAccPrint}
													<c:if test="${result.salesProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
												</td>
												<td class="txt_center">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.salaryAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.salaryAccPrint}
															<c:if test="${result.salaryAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="txt_center">
													${result.purchaseInAccPrint}
												</td>
												<td class="td_last txt_center">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.busiProfitAccPrint}
															<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr id="tr_${c.count}">
												<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="37"/> 소계</td>
												<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" bracket="Y" length="15"/> 소계</td>
												<td class="txt_center bG02"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" bracket="Y" length="15"/> 소계</td>
												<td class="txt_center bG02">${result.salesOutAccPrint}</td>
												<td class="txt_center bG02">${result.salesInAccPrint}</td>
												<td class="txt_center bG02">${result.purchaseOutAccPrint}</td>
												<td class="txt_center bG02">${result.purchaseInAccPrint}</td>
												<td class="txt_center bG02">
													<c:if test="${result.salesProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
													${result.salesProfitAccPrint}
													<c:if test="${result.salesProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
												</td>
												<td class="txt_center bG02">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.salaryAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.salaryAccPrint}
															<c:if test="${result.salaryAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="txt_center bG02">${result.expensePrint}</td>
												<td class="td_last txt_center bG02">
													<c:choose>
														<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
														<c:otherwise>
															<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
															${result.busiProfitAccPrint}
															<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr id="sumRow">
									<td class="txt_center">합계</td>
									<td class="txt_center">${sum.salesOutAccPrint}</td>
									<td class="txt_center">${sum.salesInAccPrint}</td>
									<td class="txt_center">${sum.purchaseOutAccPrint}</td>
									<td class="txt_center">${sum.purchaseInAccPrint}</td>
									<td class="txt_center">
										<c:if test="${sum.salesProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
										${sum.salesProfitAccPrint}
										<c:if test="${sum.salesProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
									</td>
									<td class="txt_center">
										<c:choose>
											<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
											<c:otherwise>
												<c:if test="${sum.salaryAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
												${sum.salaryAccPrint}
												<c:if test="${sum.salaryAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center">${sum.expensePrint}</td>
									<td class="td_last txt_center">
										<c:choose>
											<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
											<c:otherwise>
												<c:if test="${sum.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
												${sum.busiProfitAccPrint}
												<c:if test="${sum.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</tfoot>
							</table>
						</div>
</c:if>
						<!--// 게시판 끝  -->
						
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
