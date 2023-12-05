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
		var sectorName = "${sector.busiSectorNm}";
	</c:if>
</c:forEach>

function gotoBizPlan() {
	document.bizStatisticFm.action = "${rootPath}/management/selectAnnualBusinessPlan.do";
	document.bizStatisticFm.target = ""; 
	document.bizStatisticFm.submit();
}
function openResultList(resultType) {
	/* searchYear, searchMonth, searchOrgId 세가지 값을 채워서 보내면 됨. */
	var url    ="";
	var title = "POP_RESULT_" + resultType;
	var status = "toolbar=no,directories=no,scrollbars=yes,resizable=yes,status=no,menubar=no,width=950px, height=800px, top=0,left=20"; 
	window.open("", title,status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
	
	document.bizStatisticFm.searchResultType.value = resultType;
	document.bizStatisticFm.searchOrgId.value = sectorVal;
	document.bizStatisticFm.searchOrgNm.value = sectorName;
	document.bizStatisticFm.target = title; 
	document.bizStatisticFm.action = "/management/MonthResultList.do";
	document.bizStatisticFm.method = "POST"; 
	document.bizStatisticFm.submit();
}

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

	document.bizStatisticFm.appendChild(input);
	document.bizStatisticFm.appendChild(input2);

	document.bizStatisticFm.action ="${rootPath}/management/updateStatistic.do";
	document.bizStatisticFm.submit();
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

	document.bizStatisticFm.appendChild(input);
	document.bizStatisticFm.appendChild(input2);

	document.bizStatisticFm.action ="${rootPath}/management/updateStatisticDate.do";
	document.bizStatisticFm.submit();
}

function search(i) {
	document.bizStatisticFm.searchYear.value = new Number(document.bizStatisticFm.searchYear.value) + i;
	document.bizStatisticFm.action = "${rootPath}/management/monthResultStatistic.do";
	document.bizStatisticFm.target = ""; 
	document.bizStatisticFm.submit();
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
							<li class="stitle">월간사업실적</li>
							<li class="navi">홈 > 경영정보 > 사업실적 > 월간사업실적</li>
						</ul>
					</div>

					<!-- S: section -->
					<div class="section01">
	
						<!-- 상단 검색창 시작 -->
					<form name="bizStatisticFm" id="bizStatisticFm" method="POST">
						<input type="hidden" name="searchConditionYn" value="Y"/>
						<input type="hidden" name="searchYear" id="searchYear" value="${searchVO.searchYear}"/>
						<input type="hidden" name="searchOrgId" id="searchOrgId" value=""/>
						<input type="hidden" name="searchOrgNm" id="searchOrgNm" value=""/>
						<input type="hidden" name="searchResultType" id="searchResultType" value="0"/>
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
						<p class="th_plus02">(단위 : 백만원)</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="월간사업실적 화면입니다.">
							<caption>월간사업실적</caption>
							<colgroup>
								<col class="col120"/>
								<col class="col100"/>
								<col class="col100"/>
								<col class="col100"/>
								<col class="col100"/>
								<col class="col100"/>
								<col class="col100"/>
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2">구분</th>
									<th colspan="3">월별 실적</th>
									<th colspan="3" class="td_last">누계</th>
								</tr>
								<tr>
									<th>목표</th>
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
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonth.salesOutStr}"/></a></td>
									<td class="txt_center T15"><a href="javascript:openResultList('10');"><print:currency cost="${bsResultMonth.salesOutStr}"/></a></td>
									<td class="txt_center T15">${bsrMonthVO.salesOutRate}%</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonthSum.salesOutStr}"/></td>
									<td class="txt_center T15"><a href="javascript:openResultList('11');"><print:currency cost="${bsResultMonthSum.salesOutStr}"/></td>
									<td class="txt_center T15 td_last">${bsrMonthSumVO.salesOutRate}%</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">사내매출</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonth.salesInStr}"/></a></td>
									<td class="txt_center T15"><a href="javascript:openResultList('20');"><print:currency cost="${bsResultMonth.salesInStr}"/></a></td>
									<td class="txt_center T15">${bsrMonthVO.salesInRate}%</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonthSum.salesInStr}"/></td>
									<td class="txt_center T15"><a href="javascript:openResultList('21');"><print:currency cost="${bsResultMonthSum.salesInStr}"/></td>
									<td class="txt_center T15 td_last">${bsrMonthSumVO.salesInRate}%</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">사외매입</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonth.purchaseOutStr}"/></a></td>
									<td class="txt_center T15"><a href="javascript:openResultList('30');"><print:currency cost="${bsResultMonth.purchaseOutStr}"/></a></td>
									<td class="txt_center T15">${bsrMonthVO.purchaseOutRate}%</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonthSum.purchaseOutStr}"/></td>
									<td class="txt_center T15"><a href="javascript:openResultList('31');"><print:currency cost="${bsResultMonthSum.purchaseOutStr}"/></td>
									<td class="txt_center T15 td_last">${bsrMonthSumVO.purchaseOutRate}%</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">사내매입</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonth.purchaseInStr}"/></a></td>
									<td class="txt_center T15"><a href="javascript:openResultList('40');"><print:currency cost="${bsResultMonth.purchaseInStr}"/></a></td>
									<td class="txt_center T15">${bsrMonthVO.purchaseInRate}%</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonthSum.purchaseInStr}"/></td>
									<td class="txt_center T15"><a href="javascript:openResultList('41');"><print:currency cost="${bsResultMonthSum.purchaseInStr}"/></td>
									<td class="txt_center T15 td_last">${bsrMonthSumVO.purchaseInRate}%</td>
								</tr>
								<tr>
									<td class="txt_center T15 bG pT5 pB5">매출이익</td>
									<td class="txt_center T15 bG"><print:currency cost="${bsPlanMonth.salesProfitStr}"/></td>
									<td class="txt_center T20 bG"><print:currency cost="${bsResultMonth.salesProfitStr}"/></td>
									<td class="txt_center T20 bG">${bsrMonthVO.salesProfitRate}%</td>
									<td class="txt_center T15 bG"><print:currency cost="${bsPlanMonthSum.salesProfitStr}"/></td>
									<td class="txt_center T20 bG"><print:currency cost="${bsResultMonthSum.salesProfitStr}"/></td>
									<td class="txt_center T15 bG td_last">${bsrMonthSumVO.salesProfitRate}%</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">인건비</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonth.laborStr}"/></a></td>
									<td class="txt_center T15"><a href="javascript:openResultList('50');"><print:currency cost="${bsResultMonth.laborStr}"/></a></td>
									<td class="txt_center T15">${bsrMonthVO.laborRate}%</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonthSum.laborStr}"/></td>
									<td class="txt_center T15"><a href="javascript:openResultList('51');"><print:currency cost="${bsResultMonthSum.laborStr}"/></td>
									<td class="txt_center T15 td_last">${bsrMonthSumVO.laborRate}%</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">판관비</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonth.expenseStr}"/></a></td>
									<td class="txt_center T15"><a href="javascript:openResultList('60');"><print:currency cost="${bsResultMonth.expenseStr}"/></a></td>
									<td class="txt_center T15">${bsrMonthVO.expenseRate}%</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonthSum.expenseStr}"/></td>
									<td class="txt_center T15"><a href="javascript:openResultList('61');"><print:currency cost="${bsResultMonthSum.expenseStr}"/></td>
									<td class="txt_center T15 td_last">${bsrMonthSumVO.expenseRate}%</td>
								</tr>
								<tr>
									<td class="txt_center T15 bG pT5 pB5">사업부공헌이익</td>
									<td class="txt_center T15 bG"><print:currency cost="${bsPlanMonth.bizProfitStr}"/></a></td>
									<td class="txt_center T20 bG"><print:currency cost="${bsResultMonth.bizProfitStr}"/></a></td>
									<td class="txt_center T20 bG">${bsrMonthVO.bizProfitRate}%</td>
									<td class="txt_center T15 bG"><print:currency cost="${bsPlanMonthSum.bizProfitStr}"/></td>
									<td class="txt_center T20 bG"><print:currency cost="${bsResultMonthSum.bizProfitStr}"/></td>
									<td class="txt_center T15 bG td_last">${bsrMonthSumVO.bizProfitRate}%</td>
								</tr>
								<tr>
									<td class="txt_center T15 pT5 pB5">공통비</td>
									<td class="txt_center T15"><a href="javascript:gotoBizPlan();">0</a></td>
<%-- 									<td class="txt_center T15"><a href="javascript:gotoBizPlan();"><print:currency cost="${bsPlanMonth.commonCostStr}"/></a></td> --%>
									<td class="txt_center T15"><print:currency cost="${bsResultMonth.commonCostStr}"/></a></td>
									<td class="txt_center T15" td_last>-</td>
<!--									<td class="txt_center T15">${bsrMonthVO.commonCostRate}%</td>
-->									<td class="txt_center T15"><a href="javascript:gotoBizPlan();">0</a></td>
<%-- 									<td class="txt_center T15"><print:currency cost="${bsPlanMonthSum.commonCostStr}"/></td> --%>
									<td class="txt_center T15"><print:currency cost="${bsResultMonthSum.commonCostStr}"/></td>
									<td class="txt_center T15" td_last>-</td>
<!-- 									<td class="txt_center T15 td_last">${bsrMonthSumVO.commonCostRate}%</td>
-->								</tr>
								<tr>
									<td class="txt_center T15 bG pT5 pB5">영업이익</td>
									<td class="txt_center T15 bG">0</td>
<%-- 									<td class="txt_center T15 bG"><print:currency cost="${bsPlanMonth.netProfitStr}"/></a></td> --%>
									<td class="txt_center T20 bG"><print:currency cost="${bsResultMonth.netProfitStr}"/></a></td>
									<td class="txt_center T20 bG">${bsrMonthVO.netProfitRate}%</td>
									<td class="txt_center T15 bG">0</td>
<%-- 									<td class="txt_center T15 bG"><print:currency cost="${bsPlanMonthSum.netProfitStr}"/></td> --%>
									<td class="txt_center T20 bG"><print:currency cost="${bsResultMonthSum.netProfitStr}"/></td>
									<td class="txt_center T15 bG td_last">${bsrMonthSumVO.netProfitRate}%</td>
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
								<p class="th_plus02">
									<a href="javascript:updateStatistic('${searchVO.searchYear}', '${searchVO.searchMonth}');">${searchVO.searchMonth}월 실적 업데이트</a>
									<br/>
									<a href="javascript:updateStatisticDate('${searchVO.searchYear}', '${searchVO.searchMonth}');">프로젝트 시작일/종료일 업데이트</a>
									<!-- <a href="javascript:updateStatistic('${searchVO.searchYear}', '${searchVO.searchMonth}');">일괄 업데이트</a> -->
								</p>
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
