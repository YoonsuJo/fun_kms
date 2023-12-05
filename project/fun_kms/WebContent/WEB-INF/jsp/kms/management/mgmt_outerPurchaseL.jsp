<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>

<%@ include file="../include/top_inc.jsp"%>
<script>
function search(){
	var form = $('#searchVO');
	var sd = form.find('input[name=searchStartDate]');
	var ed = form.find('input[name=searchEndDate]');
	
	if (sd.val().length==8)
		sd.val(sd.val().substring(0,4)+'-'+sd.val().substring(4,6)+'-'+sd.val().substring(6,8));
	if (ed.val().length==8)
		ed.val(ed.val().substring(0,4)+'-'+ed.val().substring(4,6)+'-'+ed.val().substring(6,8));
	
	form.submit();
}

$(document).ready(function(){
	$('#searchOrgNm, #searchOrgTreeB').click(function(){
		orgGen('searchOrgNm','searchOrgId',2);
	});
});

function linkDetail(type, orgId, orgNm, prjId, prjNm, salesDocId) {
	var detailFrm = document.detailFrm;
	
	if (orgId!=undefined && orgId!='') detailFrm.searchOrgId.value = orgId;
	if (orgNm!=undefined && orgNm!='') detailFrm.searchOrgNm.value = orgNm;
	if (prjId!=undefined && prjId!='') detailFrm.searchPrjId.value = prjId;
	if (prjNm!=undefined && prjNm!='') detailFrm.searchPrjNm.value = prjNm;
	if (salesDocId!=undefined && salesDocId!='') detailFrm.searchDocId.value = salesDocId;

	detailFrm.action = '${rootPath}/management/outerPurchaseList.do?searchType=' + type;
	
	detailFrm.submit();
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
							<c:choose>
							<c:when test="${searchVO.searchType=='ORG'}">
								<li class="stitle">사외매입내역-부서별</li>
								<li class="navi">홈 > 경영정보 > 매출관리 > 사외매입내역-부서별</li>
							</c:when>
							<c:when test="${searchVO.searchType=='PRJ'}">
								<li class="stitle">사외매입내역-프로젝트별</li>
								<li class="navi">홈 > 경영정보 > 매출관리 > 사외매입내역-프로젝트별</li>
							</c:when>
							<c:when test="${searchVO.searchType=='DOC'}">
								<li class="stitle">사외매입내역-문서별</li>
								<li class="navi">홈 > 경영정보 > 매출관리 > 사외매입내역-문서별</li>
							</c:when>
							<c:when test="${searchVO.searchType=='EXP'}">
								<li class="stitle">사외매입내역-지출별</li>
								<li class="navi">홈 > 경영정보 > 매출관리 > 사외매입내역-지출별</li>
							</c:when>
							</c:choose>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 상단 검색창 시작 -->
						<form:form commandName="searchVO" id="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="searchType" id="searchType" value="${searchVO.searchType}" />
						<input type="hidden" name="searchPrjId" id="searchPrjId" value="${searchVO.searchPrjId}" />
						<input type="hidden" name="searchPrjNm" id="searchPrjNm" value="${searchVO.searchPrjNm}" />
						<input type="hidden" name="searchDocId" id="searchDocId" value="${searchVO.searchDocId}" />
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
								<colgroup>
									<col class="col40" />
									<col class="col370" />
									<col width="px" />
								</colgroup>
							<tbody>
								<tr>
									<td class="option_txt fr pR5">기간</td>
									<td> 
										<input type="text" class="input01 span_4 calGen" name="searchStartDate" value="${fn:replace(searchVO.searchStartDate, '-', '')}"/> ~
										<input type="text" class="input01 span_4 calGen" name="searchEndDate" value="${fn:replace(searchVO.searchEndDate, '-', '')}"/>
										<span class="T11">(매출 전자문서 기안일 기준)</span>
									</td>
									<td>
										<label class="pR5"><input type="checkbox" id="searchIncEndPrj" name="searchIncEndPrj" value="Y" 
												<c:if test="${searchVO.searchIncEndPrj=='Y'}">checked="checked"</c:if>/>종료/중단 프로젝트 포함</label>
										<label><input type="checkbox" id="searchIncAllTarget" name="searchIncAllTarget" value="Y" 
												<c:if test="${searchVO.searchIncAllTarget=='Y'}">checked="checked"</c:if>/>관리대상 모두 포함</label>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="pL10">
										<label class="pR5"><input type="radio" name="searchDecideYn" value="" 
											<c:if test="${searchVO.searchDecideYn==''}">checked="checked"</c:if>/>확정/예상</label>
										<label class="pR5"><input type="radio" name="searchDecideYn" value="Y" 
											<c:if test="${searchVO.searchDecideYn=='Y'}">checked="checked"</c:if>/>확정</label>
										<label class="pR5"><input type="radio" name="searchDecideYn" value="N" 
											<c:if test="${searchVO.searchDecideYn=='N'}">checked="checked"</c:if>/>예상</label>
										<span style="display:inline-block; width:30px;"></span>
										<label><input type="checkbox" name="searchNewAt" value="0"
											<c:if test="${searchVO.searchNewAt=='0'}">checked="checked"</c:if>/>
											<span class="tooltip" onmouseover="bindTooltip(this, '5046', '200');">무효건만 조회</span></label>
									</td>
									<td class="search_right">
										<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02" onclick="search();" alt="검색"/>
									</td>
								</tr>
								<c:if test="${searchVO.searchType=='PRJ'}">
									<tr>
										<td class="option_txt fr pR5">부서</td>
										<td>
											<input type="text" class="input01 span_13" name="searchOrgNm" id="searchOrgNm" value="${searchVO.searchOrgNm}" readonly="readonly"/>
											<input type="hidden" name="searchOrgId" id="searchOrgId" value="${searchVO.searchOrgId}" />
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="searchOrgTreeB"/>
										</td>
									</tr>
								</c:if>
								<c:if test="${searchVO.searchType!='PRJ'}">
										<input type="hidden" name="searchOrgId" id="searchOrgId" value="${searchVO.searchOrgId}" />
										<input type="hidden" name="searchOrgNm" id="searchOrgNm" value="${searchVO.searchOrgNm}" />
									</c:if>
							</tbody>
							</table>
							</div>
						</fieldset>
						</form:form>
						<!-- 상단 검색창 끝 -->
						
						<!-- 게시판 시작  -->
						<div class="boardList02 mB20">
						<c:choose>
						<c:when test="${searchVO.searchType=='ORG'}">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>공지사항 보기</caption>
								<colgroup>
									<col width="px" />
									<col class="col160" />
									<col class="col160" />
									<col class="col160" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>부서명</th>
										<th><span>매출</span></th>
										<th><span class="tooltip" onmouseover="bindTooltip(this, '4724', '200');">사외매입</span></th>
										<th><span class="tooltip" onmouseover="bindTooltip(this, '4725', '200');">총 매입액</span></th>
									</tr>
								</thead>
								<tbody>
									<!-- 합계 -->
									<c:set var="sumSales" value="0"/>
									<c:set var="sumPurchase" value="0"/>
									<c:set var="sumExp" value="0"/>
									<c:forEach items="${resultList}" var="result">
									<tr class="cursorPointer" onclick="linkDetail('PRJ', '${result.orgId}', '${result.orgNm}')">
										<td class="txt_center">${result.orgNm}</td>
										<td class="txt_right pR10"><print:currency cost="${result.sales}"/></td>
										<td class="txt_right pR10"><print:currency cost="${result.purchaseOut}"/></td>
										<td class="txt_right pR10"><print:currency cost="${result.expSpend}"/></td>
									</tr>
									
									<c:set var="sumSales" value="${sumSales + result.sales}"/>
									<c:set var="sumPurchase" value="${sumPurchase + result.purchaseOut}"/>
									<c:set var="sumExp" value="${sumExp + result.expSpend}"/>
									
									</c:forEach>
									
									<tr class="TrBg2">
										<td class="txt_center b">합계</td>
										<td class="txt_right pR10 b"><print:currency cost="${sumSales}"/></td>
										<td class="txt_right pR10 b"><print:currency cost="${sumPurchase}"/></td>
										<td class="txt_right pR10 b"><print:currency cost="${sumExp}"/></td>
									</tr>
								</tbody>
							</table>
						</c:when>
						<c:when test="${searchVO.searchType=='PRJ'}">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>공지사항 보기</caption>
								<colgroup>
									<col class="col110" />
									<col width="px" />
									<col class="col110" />
									<col class="col110" />
									<col class="col110" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>부서명</th>
										<th>프로젝트명</th>
										<th><span>매출</span></th>
										<th><span class="tooltip" onmouseover="bindTooltip(this, '4724', '200');">사외매입</span></th>
										<th><span class="tooltip" onmouseover="bindTooltip(this, '4725', '200');">총 매입액</span></th>
									</tr>
								</thead>
								<tbody>
									<!-- 합계 -->
									<c:set var="sumSales" value="0"/>
									<c:set var="sumPurchase" value="0"/>
									<c:set var="sumExp" value="0"/>
									<c:forEach items="${resultList}" var="result">
									<tr>
										<td class="txt_center cursorPointer" onclick="linkDetail('DOC', '', '', '${result.prjId}', '${result.prjNm}');">
											${result.orgNm}
										</td>
										<td>
											<print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="30"/>
										</td>
										<td class="txt_right pR10 cursorPointer" onclick="linkDetail('DOC', '', '', '${result.prjId}', '${result.prjNm}');">
											<print:currency cost="${result.sales}"/>
										</td>
										<td class="txt_right pR10 cursorPointer" onclick="linkDetail('DOC', '', '', '${result.prjId}', '${result.prjNm}');">
											<print:currency cost="${result.purchaseOut}"/>
										</td>
										<td class="txt_right pR10 cursorPointer" onclick="linkDetail('DOC', '', '', '${result.prjId}', '${result.prjNm}');">
											<print:currency cost="${result.expSpend}"/>
										</td>
									</tr>
									
									<c:set var="sumSales" value="${sumSales + result.sales}"/>
									<c:set var="sumPurchase" value="${sumPurchase + result.purchaseOut}"/>
									<c:set var="sumExp" value="${sumExp + result.expSpend}"/>
									
									</c:forEach>
									
									<tr class="TrBg2">
										<td colspan="2" class="txt_center b">합계</td>
										<td class="txt_right pR10 b"><print:currency cost="${sumSales}"/></td>
										<td class="txt_right pR10 b"><print:currency cost="${sumPurchase}"/></td>
										<td class="txt_right pR10 b"><print:currency cost="${sumExp}"/></td>
									</tr>
								</tbody>
							</table>
						</c:when>
						<c:when test="${searchVO.searchType=='DOC'}">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>공지사항 보기</caption>
								<colgroup>
									<col class="col110" />
									<col class="col110" />
									<col width="px" />
									<col class="col110" />
									<col class="col110" />
									<col class="col110" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>부서명</th>
										<th>프로젝트명</th>
										<th>매출 문서명</th>
										<th><span>매출</span></th>
										<th><span class="tooltip" onmouseover="bindTooltip(this, '4724', '200');">사외매입</span></th>
										<th><span class="tooltip" onmouseover="bindTooltip(this, '4725', '200');">총 매입액</span></th>
									</tr>
								</thead>
								<tbody>
									<!-- 합계 -->
									<c:set var="sumSales" value="0"/>
									<c:set var="sumPurchase" value="0"/>
									<c:set var="sumExp" value="0"/>
									<c:forEach items="${resultList}" var="result">
									<tr>
										<td class="txt_center cursorPointer" onclick="linkDetail('EXP', '', '', '', '', '${result.salesDocId}');">
											${result.orgNm}
										</td>
										<td class="txt_center">
											<print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="15"/>
										</td>
										<td class="txt_center">
											<a href="${rootPath}/approval/approvalV.do?docId=${result.salesDocId}" target="_blank">
											${result.salesSj}
											</a>
										</td>
										<td class="txt_right pR10 cursorPointer" onclick="linkDetail('EXP', '', '', '', '', '${result.salesDocId}');">
											<print:currency cost="${result.sales}"/>
										</td>
										<td class="txt_right pR10 cursorPointer" onclick="linkDetail('EXP', '', '', '', '', '${result.salesDocId}');">
											<print:currency cost="${result.purchaseOut}"/>
										</td>
										<td class="txt_right pR10 cursorPointer" onclick="linkDetail('EXP', '', '', '', '', '${result.salesDocId}');">
											<print:currency cost="${result.expSpend}"/>
										</td>
									</tr>
									
									<c:set var="sumSales" value="${sumSales + result.sales}"/>
									<c:set var="sumPurchase" value="${sumPurchase + result.purchaseOut}"/>
									<c:set var="sumExp" value="${sumExp + result.expSpend}"/>
									
									</c:forEach>
									
									<tr class="TrBg2">
										<td colspan="3" class="txt_center b">합계</td>
										<td class="txt_right pR10 b"><print:currency cost="${sumSales}"/></td>
										<td class="txt_right pR10 b"><print:currency cost="${sumPurchase}"/></td>
										<td class="txt_right pR10 b"><print:currency cost="${sumExp}"/></td>
									</tr>
								</tbody>
							</table>
						</c:when>
						<c:when test="${searchVO.searchType=='EXP'}">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>공지사항 보기</caption>
								<colgroup>
									<col width="px" />
									<col class="col110" />
									<col class="col110" />
									<col class="col110" />
									<col class="col200" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>프로젝트명</th>
										<th><span class="tooltip" onmouseover="bindTooltip(this, '4723', '200');">매출</span></th>
										<th><span class="tooltip" onmouseover="bindTooltip(this, '4724', '200');">사외매입</span></th>
										<th><span class="tooltip" onmouseover="bindTooltip(this, '4725', '200');">총 매입액</span></th>
										<th class="td_last"><span class="tooltip" onmouseover="bindTooltip(this, '4726', '200');">[상태]지출결의서명</span></th>
									</tr>
								</thead>
								<tbody>
									<!-- 프로젝트별 합계 -->
									<c:set var="prePrjId" value=""/>
									<c:set var="prjSumSales" value="0"/>
									<c:set var="prjSumPurchase" value="0"/>
									<c:set var="prjSumExp" value="0"/>
									<!-- 이전 문서 -->
									<c:set var="preDocId" value=""/>
									
									<c:forEach items="${resultList}" var="result">
										
									<!-- 합계 출력 -->
									<c:if test="${prePrjId!='' && prePrjId!=result.prjId}">
										<tr class="TrBg2">
											<td class="txt_center b">합계</td>
											<td class="txt_right pR10 b"><print:currency cost="${prjSumSales}"/></td>
											<td class="txt_right pR10 b"><print:currency cost="${prjSumPurchase}"/></td>
											<td class="txt_right pR10 b"><print:currency cost="${prjSumExp}"/></td>
											<td class="td_last"></td>
										</tr>
										<c:set var="prjSumSales" value="0"/>
										<c:set var="prjSumPurchase" value="0"/>
										<c:set var="prjSumExp" value="0"/>
									</c:if>
									<tr>
										<td class="txt_center">
											<c:if test="${prePrjId!=result.prjId}">
												<print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="22"/>
											</c:if>
										</td>
										<td class="txt_right pR10">
											<c:if test="${preDocId!=result.salesDocId}">
												<a href="${rootPath}/approval/approvalV.do?docId=${result.salesDocId}" target="_blank" title="${result.salesSj}">
													<print:currency cost="${result.sales}"/>
												</a>
											</c:if>
										</td>
										<td class="txt_right pR10">
											<c:if test="${preDocId!=result.salesDocId}">
												<a href="${rootPath}/approval/approvalV.do?docId=${result.salesDocId}" target="_blank" title="${result.salesSj}">
													<print:currency cost="${result.purchaseOut}"/>
												</a>
											</c:if>
										</td>
										<td class="txt_right pR10">
											<c:if test="${!empty result.expSj}">
												<a href="${rootPath}/approval/approvalV.do?docId=${result.expDocId}" target="_blank" title="${result.expSj}">
													<print:currency cost="${result.expSpend}"/>
												</a>
											</c:if>
										</td>
										<td class="td_last txt_center">
											<c:if test="${!empty result.expSj}">
												<a href="${rootPath}/approval/approvalV.do?docId=${result.expDocId}" target="_blank" title="${result.expSj}">
													[<c:forEach items="${docStatList}" var="docStat" varStatus="c"><c:if test="${result.expDocStat == docStat.code}">${docStat.codeNm}</c:if></c:forEach>]
													${result.expSj}
												</a>
											</c:if>
										</td>
									</tr>
									
									<c:if test="${preDocId!=result.salesDocId}">
										<c:set var="prjSumSales" value="${prjSumSales + result.sales}"/>
										<c:set var="prjSumPurchase" value="${prjSumPurchase + result.purchaseOut}"/>
									</c:if>
									
									<c:set var="prjSumExp" value="${prjSumExp + result.expSpend}"/>
									<c:set var="prePrjId" value="${result.prjId}"/>
									<c:set var="preDocId" value="${result.salesDocId}"/>
									
									</c:forEach>
									
									<tr class="TrBg2">
										<td class="txt_center b">합계</td>
										<td class="txt_right pR10 b"><print:currency cost="${prjSumSales}"/></td>
										<td class="txt_right pR10 b"><print:currency cost="${prjSumPurchase}"/></td>
										<td class="txt_right pR10 b"><print:currency cost="${prjSumExp}"/></td>
										<td class="td_last"></td>
									</tr>
								</tbody>
							</table>
						</c:when>
						</c:choose>
						</div>
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
<form name="detailFrm" method="post" target="_blank">
	<input type="hidden" name="searchStartDate" value="${searchVO.searchStartDate}"/>
	<input type="hidden" name="searchEndDate" value="${searchVO.searchEndDate}"/>
	<input type="hidden" name="searchOrgId" value="${searchVO.searchOrgId}"/>
	<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}"/>
	<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
	<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
	<input type="hidden" name="searchDocId" value="${searchVO.searchDocId}"/>
	<input type="hidden" name="searchIncEndPrj" value="${searchVO.searchIncEndPrj}"/>
	<input type="hidden" name="searchIncAllTarget" value="${searchVO.searchIncAllTarget}"/>
	<input type="hidden" name="searchDecideYn" value="${searchVO.searchDecideYn}"/>
	<input type="hidden" name="searchNewAt" value="${searchVO.searchNewAt}"/>
</form>
</html>
