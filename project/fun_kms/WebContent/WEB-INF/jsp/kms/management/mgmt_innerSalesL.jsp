<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function selRadio(i,typ) {
	if (typ == "S") {
		document.frm.searchConditionSales[i].checked = true;
	}
	else if (typ == "P") {
		document.frm.searchConditionPurchase[i].checked = true;
	}
	
	var orgId = document.getElementById("orgId_" + typ);
	var orgNm = document.getElementById("orgNm_" + typ);
	var prjId = document.getElementById("prjId_" + typ);
	var prjNm = document.getElementById("prjNm_" + typ);
	var prjChk = document.getElementById("prjChk_" + typ);
	var prjChkTxt = document.getElementById("prjChkTxt_" + typ);
	var orgTree = document.getElementById("orgTree_" + typ);
	var prjTree = document.getElementById("prjTree_" + typ);

	var orgIdValue = {
		S : "${searchVO.searchOrgIdSales}",
		P : "${searchVO.searchOrgIdPurchase}"
	};
	var orgNmValue = {
		S : "${searchVO.searchOrgNmSales}",
		P : "${searchVO.searchOrgNmPurchase}"
	};
	var prjIdValue = {
		S : "${searchVO.searchPrjIdSales}",
		P : "${searchVO.searchPrjIdPurchase}"
	};
	var prjNmValue = {
		S : "${searchVO.searchPrjNmSales}",
		P : "${searchVO.searchPrjNmPurchase}"
	};
	var prjChkChecked = {
		S : "${searchVO.includeUnderPrjSales}" == "Y",
		P : "${searchVO.includeUnderPrjPurchase}" == "Y"
	};
	
	if (i == 0) {
		orgId.value = orgIdValue[typ];
		orgNm.value = orgNmValue[typ];
		prjId.value = "";
		prjNm.value = "";
		prjChk.checked = false;

		orgNm.style.display = "";
		prjNm.style.display = "none";
		orgTree.style.display = "";
		prjTree.style.display = "none";
		prjChk.style.display = "none";
		prjChkTxt.style.display = "none";
	}
	else if (i == 1) {
		orgId.value = "";
		orgNm.value = "";
		prjId.value = prjIdValue[typ];
		prjNm.value = prjNmValue[typ];
		prjChk.checked = prjChkChecked[typ];

		orgNm.style.display = "none";
		prjNm.style.display = "";
		orgTree.style.display = "none";
		prjTree.style.display = "";
		prjChk.style.display = "";
		prjChkTxt.style.display = "";
	}
}

function search(moveYear) {
	document.frm.searchYear.value = new Number("${searchVO.searchYear}") + moveYear;
	document.frm.submit();
}
function detail(salesPrjId, purchasePrjId) {
	document.frm.salesPrjId.value = salesPrjId;
	document.frm.purchasePrjId.value = purchasePrjId;
	document.frm.action = "${rootPath}/management/innerSalesDetailList.do";
	document.frm.submit();
}

var showRight = true;
$(document).ready(function() {
	showRight = ${user.showRight};
	
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

function refreshPrjNmStr(trId) {
	var tr = document.getElementById(trId);
	if (tr == null) return;
	
	var tdLong = document.getElementById(trId).getElementsByTagName('td')[1];
	var tdShort = document.getElementById(trId).getElementsByTagName('td')[2];
	var tdOld = document.getElementById(trId).getElementsByTagName('td')[3];
	if (tdLong == null || tdShort == null || tdOld == null) return;
	
	if (showRight) 
		tdOld.innerHTML = tdShort.innerHTML;
	else 
		tdOld.innerHTML = tdLong.innerHTML;

	var tdLong = document.getElementById(trId).getElementsByTagName('td')[5];
	var tdShort = document.getElementById(trId).getElementsByTagName('td')[6];
	var tdOld = document.getElementById(trId).getElementsByTagName('td')[7];
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
							<li class="stitle">사내매출내역</li>
							<li class="navi">홈 > 경영정보 > 매출관리 > 사내매출내역</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 상단 검색창 시작 -->
						<form name="frm" method="POST" action="${rootPath}/management/innerSalesList.do" onsubmit="search(0); return false;">
						<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						<input type="hidden" name="searchOrgIdSales" id="orgId_S"/>
						<input type="hidden" name="searchPrjIdSales" id="prjId_S"/>
						<input type="hidden" name="searchOrgIdPurchase" id="orgId_P"/>
						<input type="hidden" name="searchPrjIdPurchase" id="prjId_P"/>
						<input type="hidden" name="salesPrjId"/>
						<input type="hidden" name="purchasePrjId"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td colspan="2">
										<a href="javascript:search(-1);"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
										<span class="option_txt">${searchVO.searchYear}년</span>
										<a href="javascript:search(1);" class="pR10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
									</td>
								</tr>
								<tr>
									<td>
										<c:forEach begin="1" end="12" var="m">
											<label><input type="radio" class="radio" name="searchMonth" value="${m}"
												<c:if test="${searchVO.searchMonth == m}">checked="checked"</c:if>> ${m}월</label>
										</c:forEach>
									</td>
									<td class="search_right">
										<label><input type="checkbox" name="includeResult" value="Y" <c:if test="${searchVO.includeResult == 'Y'}">checked="checked"</c:if>/> 예상실적포함</label>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										매입 :
										<label><input type="radio" class="radio" name="searchConditionSales" value="0" onclick="selRadio(0,'S');"><span class="option_txt">부서 </span></label>
										<label><input type="radio" class="radio" name="searchConditionSales" value="1" onclick="selRadio(1,'S');"><span class="option_txt">프로젝트 </span></label>
										<input type="text" class="input01 span_13" name="searchOrgNmSales" id="orgNm_S" readonly="readonly" onclick="orgGen('orgNm_S','orgId_S',0)"/>
										<input type="text" class="input01 span_13" name="searchPrjNmSales" id="prjNm_S" readonly="readonly" onclick="prjGen('prjNm_S','prjId_S',1)"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="orgTree_S" class="search_btn02 cursorPointer" onclick="orgGen('orgNm_S','orgId_S',0)"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="prjTree_S" class="search_btn02 cursorPointer" onclick="prjGen('prjNm_S','prjId_S',1)"/>
										<label><input type="checkbox" id="prjChk_S" name="includeUnderPrjSales" value="Y" <c:if test="${searchVO.includeUnderPrjSales == 'Y'}">checked="checked"</c:if>><span id="prjChkTxt_S" class="option_txt">하위프로젝트포함</span></label>
										<span class="pL15"></span>
									</td>
								</tr>
								<tr>
									<td>
										매출 :
										<label><input type="radio" class="radio" name="searchConditionPurchase" value="0" onclick="selRadio(0,'P');"><span class="option_txt">부서 </span></label>
										<label><input type="radio" class="radio" name="searchConditionPurchase" value="1" onclick="selRadio(1,'P');"><span class="option_txt">프로젝트 </span></label>
										<input type="text" class="input01 span_13" name="searchOrgNmPurchase" id="orgNm_P" readonly="readonly" onclick="orgGen('orgNm_P','orgId_P',0)"/>
										<input type="text" class="input01 span_13" name="searchPrjNmPurchase" id="prjNm_P" readonly="readonly" onclick="prjGen('prjNm_P','prjId_P',1)"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="orgTree_P" class="search_btn02 cursorPointer" onclick="orgGen('orgNm_P','orgId_P',0)"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="prjTree_P" class="search_btn02 cursorPointer" onclick="prjGen('prjNm_P','prjId_P',1)"/>
										<label><input type="checkbox" id="prjChk_P" name="includeUnderPrjPurchase" value="Y" <c:if test="${searchVO.includeUnderPrjPurchase == 'Y'}">checked="checked"</c:if>><span id="prjChkTxt_P" class="option_txt">하위프로젝트포함</span></label>
										<span class="pL7"></span>
									</td>
									<td class="search_right">	
										<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02"/>
										<script type="text/javascript">
										selRadio('${searchVO.searchConditionSales}','S');
										selRadio('${searchVO.searchConditionPurchase}','P');
										</script>
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
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col class="col100" />
								<col class="px" />
								<col class="col100" />
								<col width="px" />
								<col class="col80" />
							</colgroup>
							<thead>
								<tr>
									<th>매입부서</th>
									<th>매입 프로젝트</th>
									<th>매출 부서</th>
									<th>매출 프로젝트</th>
									<th class="td_last">금액</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="sum" value="0" />
								<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr id="tr_${c.count}">
									<td class="txt_center">${result.salesOrgNm}</td>
									<td style="display:none;"><print:project prjCd="${result.salesPrjCd}" prjId="${result.salesPrjId}" prjNm="${result.salesPrjNm}" length="60"/></td>
									<td style="display:none;"><print:project prjCd="${result.salesPrjCd}" prjId="${result.salesPrjId}" prjNm="${result.salesPrjNm}" length="20"/></td>									
									<td class="pL10">		  <print:project prjCd="${result.salesPrjCd}" prjId="${result.salesPrjId}" prjNm="${result.salesPrjNm}" length="20"/></td>
									<td class="txt_center">${result.purchaseOrgNm}</td>
									<td style="display:none;"><print:project prjCd="${result.purchasePrjCd}" prjId="${result.purchasePrjId}" prjNm="${result.purchasePrjNm}" length="60"/></td>
									<td style="display:none;"><print:project prjCd="${result.purchasePrjCd}" prjId="${result.purchasePrjId}" prjNm="${result.purchasePrjNm}" length="20"/></td>
									<td class="pL10"><print:project prjCd="${result.purchasePrjCd}" prjId="${result.purchasePrjId}" prjNm="${result.purchasePrjNm}" length="20"/></td>
									<td class="td_last txt_center"><a href="javascript:detail('${result.salesPrjId}', '${result.purchasePrjId}');">${result.costPrint}</a></td>
								</tr>
								<c:set var="sum" value="${sum+result.cost}" />
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td class="txt_center" colspan="4">합계</td>
									<td class="td_last txt_center Bg"><fmt:formatNumber value="${sum/1000}" pattern="#,##0"/></td>
								</tr>
							</tfoot>
							</table>
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
</html>
