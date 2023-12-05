<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function search(i) {
	document.frm.searchYear.value = new Number(document.frm.searchYear.value) + i;
	document.frm.submit();
}
function view(id, lv) {
	document.frm.searchId.value = id;
	document.frm.action = "${rootPath}/management/stepResultStatistic.do";
	document.frm.submit();
}
function back(sn, lv) {
	var tmp = sn.split("/");
	
	document.frm.searchId.value = tmp[tmp.length - 2];
	document.frm.action = "${rootPath}/management/stepResultStatistic.do";
	document.frm.submit();
}

function detail(prjId, prjNm, includeUnderPrj) {
	document.subfrm.searchPrjId.value = prjId;
	document.subfrm.searchPrjNm.value = prjNm;
	document.subfrm.includeUnderPrj.value = includeUnderPrj;
	document.subfrm.action = "${rootPath}/management/selectInputResultProjectDetail.do";
	document.subfrm.submit();
}

var recalcYn = "${searchVO.searchRecalcYn}";
$(document).ready(function() {
	if (recalcYn == 'Y') {
		<c:forEach items="${resultList}" var="result" varStatus="c">
			var isSub = 'Y';
			<c:if test="${resultList[0].typ == 'PRJ' && result.typ == 'PRJ' && c.count == 2}">
				isSub = 'N';
			</c:if>
				
			<c:if test="${not (result.typ == 'ORG' && result.havingLeaf == false)}">
			$.post("/ajax/stepResultStatistic.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&includeResult=${searchVO.includeResult}&id=${result.id}&lv=${result.lv}&typ=${result.typ}&havingLeaf=${result.havingLeaf}&cnt=${c.count}&prtTyp=${resultList[0].typ}&isSub="+isSub,
				function(data){
					$('#tr_${c.count}').html(data);
				}
			);
			</c:if>
		</c:forEach>
	}
});

function viewMonthLaborOfProjectPop(prjId, prjNm) {
	var target = document.frm.target;
	var POP_NAME = "_MONTH_LABOR_PROJECT_POP_";
	document.frm.method = "POST";
	document.frm.target = POP_NAME;
	document.frm.action = "/management/MonthLaborResultOfProject.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=1000px, height=700px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.frm.searchPrjId.value = prjId;
	document.frm.searchPrjNm.value = prjNm;
	document.frm.submit();
	popup.focus();
	document.frm.target = target;
}

function viewProject(prjId){
	/*
	var form = $('#searchVO');
	form.attr("action", "/cooperation/selectProjectV.do?prjId="+prjId);
	form.submit();
	*/
	
//	var popup = window.open("/cooperation/selectProjectPopV.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=950px,height=800px,scrollbars=yes,resizable=no");
	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=960px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
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
							<li class="stitle">다단계 성과분석
							<c:if test="${searchVO.searchRecalcYn != 'Y'}">(전일집계)</c:if> 
							<c:if test="${searchVO.searchRecalcYn == 'Y'}">(실시간)</c:if>
							</li>
							<li class="navi">홈 > 경영정보 > 사업실적 > 다단계 성과분석</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 상단 검색창 시작 -->
						<form name="frm" action="${rootPath}/management/stepResultStatistic.do" method="GET">
						<input type="hidden" name="searchId" value="${searchVO.searchId}"/>
						<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						<input type="hidden" name="searchRecalcYn" value="${searchVO.searchRecalcYn}"/>
						<input type="hidden" name="searchPrjId" value=""/>
						<input type="hidden" name="searchPrjNm" value=""/>
						<c:set var="linkMonth" value="${searchVO.searchMonth}"/>
						<c:if test="${searchVO.searchMonth < 10}">
							<c:set var="linkMonth" value="0${searchVO.searchMonth}"/>
						</c:if>
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
<!--										프로젝트 시작일 xxxxxxxx 이전 / 종료일 xxxxxxxx 이후 //숨김처리-->
										<span class="option_txt"><input type="hidden" name="startDate" class="calGen" value="${searchVO.startDate}" style="width:50px;" maxlength="8" /></span>
										<span class="option_txt"><input type="hidden" name="endDate" class="calGen" value="${searchVO.endDate}" style="width:50px;" maxlength="8" /></span>
									</td>
									<td>
										<c:forEach begin="1" end="12" var="mnth">
										<label><input type="radio" class="radio" name="searchMonth" value="${mnth}" 
											<c:if test="${mnth == searchVO.searchMonth}">checked="checked"</c:if>
											onclick="search(0);"> ${mnth}월</label>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<label class="tooltip" onmouseover="bindTooltip(this, '4859', '200');">
											<input type="checkbox" name="includeAllDate" value="Y" onclick="search(0);" 
											<c:if test="${searchVO.includeAllDate == 'Y'}">checked="checked"</c:if>/>
											전체기간포함
										</label>&nbsp;&nbsp;
										<label class="tooltip" onmouseover="bindTooltip(this, '4860', '200');">
											<input type="checkbox" name="includeResult" value="Y" onclick="search(0);" 
											<c:if test="${searchVO.includeResult == 'Y'}">checked="checked"</c:if>/>
											예상실적포함
										</label>&nbsp;&nbsp;
										<label class="tooltip" onmouseover="bindTooltip(this, '4861', '200');">
											<input type="checkbox" name="includeAcc" value="Y" onclick="search(0);" 
											<c:if test="${searchVO.includeAcc == 'Y'}">checked="checked"</c:if>/>
											누적실적보기
										</label>	
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
			<c:if test="${searchVO.includeAcc != 'Y'}">
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col class="" />
								<col class="col55" />
								<col class="col55" />
								<col class="col55" />
								<col class="col55" />
								<col class="col55" />
								<col class="col55" />
								<col class="col55" />
								<col class="col55" />
								<col class="col55" />
								<col class="col70" />
								<col class="col55" />
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2">&nbsp;</th>
									<th rowspan="2">사외매출</th>
									<th rowspan="2">사내매출</th>
									<th rowspan="2">사외매입</th>
									<th rowspan="2">사내매입</th>
									<th rowspan="2">매출이익</th>
									<th colspan="2">인건비</th>
									<th colspan="2">판관비</th>
									<th rowspan="2">영업이익<br/>(수행실적)</th>
									<th class="td_last" rowspan="2">영업이익<br/>누계</th>
								</tr>
								<tr>
									<th>예산</th>
									<th>실적</th>
									<th>예산</th>
									<th>실적</th>
								</tr>
							</thead>
							<tbody id="tBody">
								<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr id="tr_${c.count}" <c:if test="${c.count == 1}">class="TrBg4"</c:if>
								<c:if test="${result.stat == 'P'}">class="TrBg4_1"</c:if>
								<c:if test="${result.stat == 'E' || result.stat == 'S'}">class="TrBg4_2"</c:if>>
									<c:choose>
										<c:when test="${c.count == 1}">
											<td class="T11B
												<c:if test="${result.typ == 'ORG'}">bul01</c:if>
												<c:if test="${result.typ == 'PRJ' && result.prjType == 'E'}">bul05</c:if>
												<c:if test="${result.typ == 'PRJ'}">bul03</c:if>
											">
												<c:if test="${result.typ == 'ORG'}"><print:org orgnztId="${result.id}" orgnztNm="${result.nm}"/></c:if>
												<c:if test="${result.typ == 'PRJ'}"><print:project prjId="${result.id}" prjNm="${result.nm}"/></c:if>
												 전체
												<c:if test="${result.lv != 0}">
												<a href="javascript:back('${result.sn}','${result.lv}');"><img src="${imagePath}/btn/btn_arrow_prev_on.gif"/></a>
												</c:if>
											</td>
										</c:when>
										<c:otherwise>
											<td class="T11
												<c:if test="${result.typ == 'ORG'}">bul02</c:if>
												<c:if test="${resultList[0].typ == 'ORG' && result.typ == 'PRJ'}">
													<c:if test="${result.prjType == 'E'}">bul05</c:if>
													<c:if test="${result.prjType != 'E'}">bul03</c:if>
												</c:if>
												<c:if test="${resultList[0].typ == 'PRJ' && result.typ == 'PRJ'}">
													<c:if test="${result.prjType == 'E'}">
														<c:if test="${c.count == 2}">bul05</c:if>
														<c:if test="${c.count > 2}">bul06</c:if>
													</c:if>
													<c:if test="${result.prjType != 'E'}">
														<c:if test="${c.count == 2}">bul03</c:if>
														<c:if test="${c.count > 2}">bul04</c:if>
													</c:if>
												</c:if>
											">
												<c:if test="${result.typ == 'ORG'}"><print:org orgnztId="${result.id}" orgnztNm="${result.nm}"/></c:if>
												<c:if test="${result.typ == 'PRJ'}">
												 <%-- 스타일때문에 변경(문제생기면 주석풀고 밑에 <a> 주석 처리 <print:project prjId="${result.id}" prjNm="${result.nm}"/> --%>
												<a href="javascript:viewProject('${result.id}');"  
												<c:if test="${result.stat == 'E' || result.stat == 'S'}">style="color: #A6A6A6;"</c:if>
												<c:if test="${result.stat == 'P'}">style="font-weight: bold;"</c:if>>${result.nm}</a>
												</c:if>
												<c:if test="${result.havingLeaf}">
												<a href="javascript:view('${result.id}','${result.lv}');"><img src="${imagePath}/btn/btn_arrow_next_on.gif"/></a>
												</c:if>
											</td>
										</c:otherwise>
									</c:choose>
									<td class="txt_center  T11B">${result.salesOutPrint}</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
														${result.salesInPrint}
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B">${result.purchaseOutPrint}</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
														${result.purchaseInPrint}
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B bG04">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
									<c:if test="${result.salesProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
									<span <c:if test="${result.stat == 'E' || result.stat == 'S'}">style="color: #A6A6A6;"</c:if>
																<c:if test="${result.stat == 'P'}">style="font-weight: bold;"</c:if>>
														${result.salesProfitPrint}
														</span>
									<c:if test="${result.salesProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise> 
														${result.salaryPlanPrint}
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
<!--			                    	인건비실적-->
									<td class="txt_center  T11B bG">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
									<c:if test="${result.salaryPlan < result.salary}"><c:out value='<span class="link">' escapeXml="false"/></c:if>
										<c:if test="${result.typ == 'PRJ'}">
											<!-- <a href="javascript:detail('${result.id}','${result.nm }','Y');" -->
											<a href="javascript: viewMonthLaborOfProjectPop('${result.id}', '${result.nm}');"  
											<c:if test="${result.stat == 'E' || result.stat == 'S'}">style="color: #A6A6A6;"</c:if>
																	<c:if test="${result.stat == 'P'}">style="font-weight: bold;"</c:if>></c:if>
											${result.salaryPrint}
										<c:if test="${result.typ == 'PRJ'}"></a></c:if>
									<c:if test="${result.salaryPlan < result.salary}"><c:out value='</span>' escapeXml="false"/></c:if>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
														${result.expensePlanPrint}
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
									<c:if test="${result.expensePlan < result.expense}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
									${result.expensePrint}
									<c:if test="${result.expensePlan < result.expense}"><c:out value='</span>' escapeXml="false"/></c:if>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B bG04">
										<c:choose>
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
									<c:if test="${result.busiProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
									<span <c:if test="${result.stat == 'E' || result.stat == 'S'}">style="color: #A6A6A6;"</c:if>
																<c:if test="${result.stat == 'P'}">style="font-weight: bold;"</c:if>>
																${result.busiProfitPrint}
														</span>
									<c:if test="${result.busiProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="td_last  T11B txt_center">
										<c:choose>
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
									<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
									${result.busiProfitAccPrint}
									<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
			</c:if>
			<c:if test="${searchVO.includeAcc == 'Y'}">
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col class="" />
								<col class="col60" />
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
								<tr>
									<th rowspan="2">&nbsp;</th>
									<th rowspan="2">누계<br/>사외매출</th>
									<th rowspan="2">누계<br/>사내매출</th>
									<th rowspan="2">누계<br/>사외매입</th>
									<th rowspan="2">누계<br/>사내매입</th>
									<th rowspan="2">누계<br/>매출이익</th>
									<th colspan="2">누계 인건비</th>
									<th colspan="2">누계 판관비</th>
									<th class="td_last" rowspan="2">영업이익<br/>누계</th>
								</tr>
								<tr>
									<th>예산</th>
									<th>실적</th>
									<th>예산</th>
									<th>실적</th>
								</tr>
							</thead>
							<tbody id="tBody">
								<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr id="tr_${c.count}" <c:if test="${c.count == 1}">class="TrBg4"</c:if>
								<c:if test="${result.stat == 'P'}">class="TrBg4_1"</c:if>
								<c:if test="${result.stat == 'E' || result.stat == 'S'}">class="TrBg4_2"</c:if>>
									<c:choose>
										<c:when test="${c.count == 1}">
											<td class="T11B
												<c:if test="${result.typ == 'ORG'}">bul01</c:if>
												<c:if test="${result.typ == 'PRJ' && result.prjType == 'E'}">bul05</c:if>
												<c:if test="${result.typ == 'PRJ'}">bul03</c:if>
											">
												<c:if test="${result.typ == 'ORG'}"><print:org orgnztId="${result.id}" orgnztNm="${result.nm}"/></c:if>
												<c:if test="${result.typ == 'PRJ'}"><print:project prjId="${result.id}" prjNm="${result.nm}"/></c:if>
												 전체
												<c:if test="${result.lv != 0}">
												<a href="javascript:back('${result.sn}','${result.lv}');"><img src="${imagePath}/btn/btn_arrow_prev_on.gif"/></a>
												</c:if>
											</td>
										</c:when>
										<c:otherwise>
											<td class="T11
												<c:if test="${result.typ == 'ORG'}">bul02</c:if>
												<c:if test="${resultList[0].typ == 'ORG' && result.typ == 'PRJ'}">
													<c:if test="${result.prjType == 'E'}">bul05</c:if>
													<c:if test="${result.prjType != 'E'}">bul03</c:if>
												</c:if>
												<c:if test="${resultList[0].typ == 'PRJ' && result.typ == 'PRJ'}">
													<c:if test="${result.prjType == 'E'}">bul05</c:if>
													<c:if test="${result.prjType != 'E'}">
														<c:if test="${c.count == 2}">bul03</c:if>
														<c:if test="${c.count > 2}">bul04</c:if>
													</c:if>
												</c:if>
											">
												<c:if test="${result.typ == 'ORG'}"><print:org orgnztId="${result.id}" orgnztNm="${result.nm}"/></c:if>
												<c:if test="${result.typ == 'PRJ'}">
												<!-- 스타일때문에 변경(문제생기면 주석풀고 밑에 <a> 주석 처리 <print:project prjId="${result.id}" prjNm="${result.nm}"/>-->
												<a href="javascript:viewProject('${result.id}');"  
												<c:if test="${result.stat == 'E' || result.stat == 'S'}">style="color: #A6A6A6;"</c:if>
												<c:if test="${result.stat == 'P'}">style="font-weight: bold;"</c:if>>${result.nm}</a>
												</c:if>
												<c:if test="${result.havingLeaf}">
												<a href="javascript:view('${result.id}','${result.lv}');"><img src="${imagePath}/btn/btn_arrow_next_on.gif"/></a>
												</c:if>			                    				
											</td>
										</c:otherwise>
									</c:choose>
									<td class="txt_center  T11B">${result.salesOutAccPrint}</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
														${result.salesInAccPrint}
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B">${result.purchaseOutAccPrint}</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
														${result.purchaseInAccPrint}
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B bG04">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
									<c:if test="${result.salesProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
									<span <c:if test="${result.stat == 'E' || result.stat == 'S'}">style="color: #A6A6A6;"</c:if>
																<c:if test="${result.stat == 'P'}">style="font-weight: bold;"</c:if>>
														${result.salesProfitAccPrint}
														</span>
									<c:if test="${result.salesProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise> 
														${result.salaryPlanAccPrint}
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
<!--			                    	인건비실적-->
									<td class="txt_center  T11B bG">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
									<c:if test="${result.salaryPlan < result.salary}"><c:out value='<span class="link">' escapeXml="false"/></c:if>
										<c:if test="${result.typ == 'PRJ'}">
											<!-- <a href="javascript:detail('${result.id}','${result.nm }','Y');" target="_blank" -->
											<a href="/management/selectInputResultProjectDetail.do?searchPrjId=${result.id}&searchPrjNm=${result.nm}&includeUnderPrj=Y&searchDate=${searchVO.searchYear}${linkMonth}01" target="_blank" 
											<c:if test="${result.stat == 'E' || result.stat == 'S'}">style="color: #A6A6A6;"</c:if>
																	<c:if test="${result.stat == 'P'}">style="font-weight: bold;"</c:if>></c:if>
											${result.salaryAccPrint}
										<c:if test="${result.typ == 'PRJ'}"></a></c:if>
									<c:if test="${result.salaryPlan < result.salary}"><c:out value='</span>' escapeXml="false"/></c:if>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
														${result.expensePlanAccPrint}
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center  T11B">
										<c:choose>	
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
									<c:if test="${result.expensePlan < result.expense}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
									${result.expenseAccPrint}
									<c:if test="${result.expensePlan < result.expense}"><c:out value='</span>' escapeXml="false"/></c:if>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="td_last  T11B txt_center">
										<c:choose>
											<c:when test="${result.typ == 'ORG' && result.havingLeaf == false}">0</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
													<c:otherwise>
									<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
									${result.busiProfitAccPrint}
									<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
			</c:if>
						<!--// 게시판 끝  -->
						
						<c:set var="searchMonth" value="${searchVO.searchMonth}"/>
						<c:if test="${searchVO.searchMonth < 10}"><c:set var="searchMonth" value="0${searchVO.searchMonth}"/></c:if>	
						<form name="subfrm" method="POST">
							<input type="hidden" name="searchDate" value="${searchVO.searchYear}${searchMonth}01"/>
							<input type="hidden" name="searchPrjId"/>
							<input type="hidden" name="searchPrjNm"/>
							<input type="hidden" name="includeUnderPrj"/>
						</form>
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
