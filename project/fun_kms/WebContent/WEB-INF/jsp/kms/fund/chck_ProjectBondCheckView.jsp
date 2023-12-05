
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>

/////   1. Setting in Loading 
$(document).ready(function() {
	
	$('.chckTot').change(function(){
		var $this = $(this);
		var salesValue = $this.data('salesValue');
		var salesSum = parseInt(jsDeleteComma($('#salesSum').val()));
		if($this.is(":checked")) {
			$('#salesSum').val(salesSum + salesValue); 
		}
		else {
			$('#salesSum').val(salesSum - salesValue); 
		}
		jsMakeCurrency(document.getElementById('salesSum'));
	});
	
	$('.chckGen').change(function(){
		var $this = $(this);
		var salesValue = $this.data('salesValue');
		var salesSum = parseInt(jsDeleteComma($('#salesSum').val()));
		if($this.is(":checked")) {
			$('#salesSum').val(salesSum + salesValue); 
		}
		else {
			$('#salesSum').val(salesSum - salesValue); 
		}
		jsMakeCurrency(document.getElementById('salesSum'));
	});
	
	$('.chckInv').change(function(){
		var $this = $(this);
		var invoiceValue = $this.data('invoiceValue');
		var collectValue = $this.data('collectValue');
		var invoiceSum = parseInt(jsDeleteComma($('#invoiceSum').val()));
		var collectSum = parseInt(jsDeleteComma($('#collectSum').val()));
		if($this.is(":checked")) {
			$('#invoiceSum').val(invoiceSum + invoiceValue); 
			$('#collectSum').val(collectSum + collectValue); 
		}
		else {
			$('#invoiceSum').val(invoiceSum - invoiceValue); 
			$('#collectSum').val(collectSum - collectValue); 
		}
		jsMakeCurrency(document.getElementById('invoiceSum'));
		jsMakeCurrency(document.getElementById('collectSum'));
	});
});

/////   2. Event Methods 

/////   3. Call Methods 
function viewDoc(docId){
	/*
	var form = $('#searchVO');
	form.attr("action", "/fund/selectProjectPopV.do?prjId="+prjId);
	form.submit();
	*/
	var popup = window.open("/approval/approvalV.do?docId="+docId, "_POP_PROJECT_VIEW", "width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function allChckChangeTot(obj) {
	var chk = document.getElementsByName("chckTot");
	var salesSum = parseInt(jsDeleteComma($('#salesSum').val()));
	if (obj.checked) {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=true;
			salesSum += chk[i].data-sales-value;
		}
	}
	else {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=false;
			salesSum -= chk[i].data-sales-value;
		}
	}

	jsMakeCurrency(document.getElementById('salesSum'));
}

function allChckChangeGen(obj) {
	var chk = document.getElementsByName("chckGen");
	var salesSum = parseInt(jsDeleteComma($('#salesSum').val()));
	if (obj.checked) {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=true;
			salesSum += parseInt(chk[i].dataset.salesValue);
		}
	}
	else {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=false;
			salesSum -= parseInt(chk[i].dataset.salesValue);
		}
	}
	$('#salesSum').val(salesSum); 
	jsMakeCurrency(document.getElementById('salesSum'));
}

function allChckChangeInv(obj) {
	var chk = document.getElementsByName("chckInv");
	var invoiceSum = parseInt(jsDeleteComma($('#invoiceSum').val()));
	var collectSum = parseInt(jsDeleteComma($('#collectSum').val()));
	if (obj.checked) {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=true;
			invoiceSum += parseInt(chk[i].dataset.invoiceValue);
			collectSum += parseInt(chk[i].dataset.collectValue);
		}
	}
	else {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=false;
			invoiceSum -= parseInt(chk[i].dataset.invoiceValue);
			collectSum -= parseInt(chk[i].dataset.collectValue);
		}
	}

	$('#invoiceSum').val(invoiceSum); 
	$('#collectSum').val(collectSum); 
	jsMakeCurrency(document.getElementById('invoiceSum'));
	jsMakeCurrency(document.getElementById('collectSum'));
}

//TENY_170327 세금계산서 발행 작업을 POPUP장으로 띄워서 입력하는 기능
function popInvoiceView(invoiceId){
	
	var POP_NAME = "_POP_INVOICE_VIEW_";
	var target = document.invoiceFm.target;
	document.invoiceFm.invoiceId.value = invoiceId;
	document.invoiceFm.target = POP_NAME;
	document.invoiceFm.action = '<c:url value="/fund/invoiceView.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=900px,height=800px;");
	document.invoiceFm.submit();
	popup.focus();
	document.invoiceFm.target = target;
}

/////   4. Submit Methods 
function closeBondMng(){
	var salesSum = parseInt(jsDeleteComma($('#salesSum').val()));
	var invoiceSum = parseInt(jsDeleteComma($('#invoiceSum').val()));
	var collectSum = parseInt(jsDeleteComma($('#collectSum').val()));
	if((salesSum + invoiceSum) == 0) {
		alert("수금종료할 매출과 계산서를 선택하여 주시기바랍니다.");
		return;
	}
/*	if(salesSum != invoiceSum) {
		alert("매출금액 합계와 세금계산서 발행금액 합계가 일치하여야 합니다");
		return;
	}
*/		
	if (!confirm("선택된 매출과 계산서에 대해 수금관리종료를 하시겠습니까?")) {
		return;
	}
	// 선택된 매출들의 docid를 하나의 String으로 만든다.
	var chckList = document.getElementsByName("chckSales");
	// docId리스트 스트링
	var salesDocIds = "";
	for(var i=0; i<chckList.length; i++) {
		if (chckList[i].checked) {
			if (salesDocIds != "") {
				salesDocIds += ",";
			}
			salesDocIds += chckList[i].value;
		}
	}
	// 선택된 세금계산서들의 invoiceProject No를 하나의 String으로 만든다.
	var chck2List = document.getElementsByName("chckInvoice");
	// docId리스트 스트링
	var invPrjNos = "";
	for(var i=0; i<chck2List.length; i++) {
		if (chck2List[i].checked) {
			if (invPrjNos != "") {
				invPrjNos += ",";
			}
			invPrjNos += chck2List[i].value;
		}
	}
	document.invcStatVOFm.salesDocIds.value = salesDocIds;
	document.invcStatVOFm.invPrjNos.value = invPrjNos;
	document.invcStatVOFm.action = "<c:url value='${rootPath}/fund/closeBondMng.do'/>";
	document.invcStatVOFm.submit();
}
</script>

<body>
<div id="wrap">
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">프로젝트 채권내역(상세)</li>
							<li class="navi">홈 > 경영정보 > 프로젝트 채권내역(상세)</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					<!-- 상단 검색창 시작 -->
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col300" />
								<col class="col600" />
							</colgroup>
							<tbody>
								<tr>
									<td><label>프로젝트ID </label><input type="text" readonly="readonly" name="prjId" class="input01 w200" value="${invcStatVO.prjId}" /></td>
									<td><label>프로젝트명 </label><input type="text" readonly="readonly" name="prjName" class="input01 w500" value="${invcStatVO.prjName}" /></td>
								</tr>
							</tbody>
							</table>
							</div>
					<!-- 상단 검색창 끝 -->

					<form:form commandName="invoiceFm" id="invoiceFm" name="invoiceFm" method="post"  >
						<input type="hidden" name="invoiceId" value=""/>
						<input type="hidden" name="openPop" value="Y"/>
						
					<!-- 세금계산서 목록  -->
					<span class="th_plus03">[ 단위 : 원 (부가세 포함 )]</span>
					<span class="th_plus03 txt_red pR15">미수금</span>
					<span class="th_plus03 txt_blue pR15">과수금</span>
					<p class="th_stitle mB10">세금계산서 발행/수금 목록</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" >
						<colgroup>
							<col class="col30" />
							<col class="col400" />
							<col class="col60" />

							<col class="col70" />
							<col class="col70" />
							<col class="col70" />
							<col class="col70" />

							<col class="col50" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>계산서 제목</th>
								<th>날짜</th>

								<th>총발행</th>
								<th>발행</th>
								<th>수금</th>
								<th>잔액</th>

								<th>담당자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pcVOList}" var="result" varStatus="c">
							<tr>
 								<td class="txt_center"><c:out value="${c.count}"/></td>
								<td class="txt_left pL7"><a href="javascript:popInvoiceView('${result.invoiceId}');">${result.title}</a></td>
								<td class="txt_center">${result.date}</td>
								
								<td class="txt_right pR5"><print:currency cost="${result.invoiceSum}"/></td>
								<td class="txt_right pR5"><print:currency cost="${result.projectSum}"/></td>
								<td class="txt_right pR5"><print:currency cost="${result.collectSum}"/></td>
							<c:choose>
								<c:when test="${result.remain  > 0}">
									<td class="txt_right pR10"><span class="txt_red"><print:currency cost="${result.remain}"/></span></td>
								</c:when>
								<c:otherwise>
									<td class="txt_right pR5"><print:currency cost="${result.remain}"/></td>
								</c:otherwise>
							</c:choose>
								<td class="txt_center">${result.userName}</td>
							</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>  <!-- class="boardList02 mB20" -->
					<!-- 계산서 목록끝  -->
					</form:form>	<!-- 상단 검색창 끝 -->

					<!-- 매출 목록  -->
					<p class="th_stitle mB10">매출 목록(종합매출)</p>
					<p class="th_plus03">( N : NewAt     S : Status     B : BondYn     D : DeciedYn )            단위 : 원</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col20" />
							<col class="col40" />
							<col class="col300" />
							<col class="col60" />
							<col class="col60" />
							<col class="col20" />
							<col class="col20" />
							<col class="col20" />
							<col class="col20" />
							<col class="col90" />
							<col class="col90" />
							<col class="col90" />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="checkAllTot" onclick="javascript:allChckChangeTot(this);" /></th>
								<th >번호</th>
								<th >문서제목</th>
								<th >작성일</th>
								<th >문서상태</th>
								<th >N</th>
								<th >S</th>
								<th >B</th>
								<th >D</th>
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4691', '300');">총계약금<br/>일반매출</span></th>
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4688', '250');">본매출<br/>일반매출</span></th>
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4689', '200');">유지보수<br/>일반매출</span></th>
							</tr>
							<tr>
								<th class="txt_center" colspan="9">합계</th>
								<th class="txt_right pR10"><print:currency cost="${totSalesSum.salesSales}"/></th>
								<th class="txt_right pR10"><print:currency cost="${totSalesSum.salesSales}"/></th>
								<th class="txt_right pR10"><print:currency cost="${totSalesSum.salesMaintSales}"/></th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td class="txt_center" colspan="9">합계</td>
								<td class="txt_right pR10"><print:currency cost="${totSalesSum.salesSales}"/></td>
								<td class="txt_right pR10"><print:currency cost="${totSalesSum.salesSales}"/></td>
								<td class="txt_right pR10"><print:currency cost="${totSalesSum.salesMaintSales}"/></td>
							</tr>
						</tfoot>
						<tbody>
							<c:forEach items="${totSalesList}" var="result" varStatus="c">
							<tr >
								<td class="txt_center"><input type="checkbox" name="chckTot" class="chckTot" value="${result.salesDocId}" data-sales-value="${result.salesSales}" /></td>
								<td class="txt_center"><c:out value="${c.count}"/></td>
								<td class="txt_center"><a href="javascript:viewDoc('${result.salesDocId}');">${result.salesSubject}</a></td>
								<td class="txt_center">${result.salesDocDate}</td>
								<td class="txt_center">${result.salesDocStat}</td>
								<td class="txt_center">${result.salesNewAt}</td>
								<td class="txt_center">${result.salesStatus}</td>
								<td class="txt_center">${result.salesBondYn}</td>
								<td class="txt_center">${result.salesDeciedYn}</td>
								<td class="txt_right pR10"><print:currency cost="${result.salesSales}"/></td>
								<td class="txt_right pR10"><print:currency cost="${result.salesSales}"/></td>
								<td class="txt_right pR10"><print:currency cost="${result.salesMaintSales}"/></td>
							</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>  <!-- class="boardList02 mB20" -->
					<!-- 매출 목록끝  -->

					<p class="th_stitle mB10">매출 목록(일반매출)</p>
					<p class="th_plus03">( N : NewAt     S : Status     B : BondYn     D : DeciedYn )            단위 : 원</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col20" />
							<col class="col40" />
							<col class="col300" />
							<col class="col60" />
							<col class="col60" />
							<col class="col20" />
							<col class="col20" />
							<col class="col20" />
							<col class="col20" />
							<col class="col90" />
							<col class="col90" />
							<col class="col90" />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="checkAllGen" onclick="javascript:allChckChangeGen(this);" /></th>
								<th >번호</th>
								<th >문서제목</th>
								<th >작성일</th>
								<th >문서상태</th>
								<th >N</th>
								<th >S</th>
								<th >B</th>
								<th >D</th>
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4691', '300');">총계약금<br/>일반매출</span></th>
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4688', '250');">본매출<br/>일반매출</span></th>
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4689', '200');">유지보수<br/>일반매출</span></th>
							</tr>
							<tr>
								<th class="txt_center" colspan="9">합계</th>
								<th class="txt_right pR10"><print:currency cost="${genSalesSum.salesSales}"/></th>
								<th class="txt_right pR10"><print:currency cost="${genSalesSum.salesSales}"/></th>
								<th class="txt_right pR10"><print:currency cost="${genSalesSum.salesMaintSales}"/></th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td class="txt_center" colspan="9">합계</td>
								<td class="txt_right pR10"><print:currency cost="${genSalesSum.salesSales}"/></td>
								<td class="txt_right pR10"><print:currency cost="${genSalesSum.salesSales}"/></td>
								<td class="txt_right pR10"><print:currency cost="${genSalesSum.salesMaintSales}"/></td>
							</tr>
						</tfoot>
						<tbody>
							<c:forEach items="${genSalesList}" var="result" varStatus="c">
							<tr >
								<td class="txt_center"><input type="checkbox" name="chckGen" class="chckGen" value="${result.salesDocId}" data-sales-value="${result.salesSales}" /></td>
								<td class="txt_center"><c:out value="${c.count}"/></td>
								<td class="txt_center"><a href="javascript:viewDoc('${result.salesDocId}');">${result.salesSubject}</a></td>
								<td class="txt_center">${result.salesDocDate}</td>
								<td class="txt_center">${result.salesDocStat}</td>
								<td class="txt_center">${result.salesNewAt}</td>
								<td class="txt_center">${result.salesStatus}</td>
								<td class="txt_center">${result.salesBondYn}</td>
								<td class="txt_center">${result.salesDeciedYn}</td>
								<td class="txt_right pR10"><print:currency cost="${result.salesSales}"/></td>
								<td class="txt_right pR10"><print:currency cost="${result.salesSales}"/></td>
								<td class="txt_right pR10"><print:currency cost="${result.salesMaintSales}"/></td>
							</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>  <!-- class="boardList02 mB20" -->
					<!-- 매출 목록끝  -->

					<form:form commandName="invcStatVOFm" id="invcStatVOFm" name="invcStatVOFm" method="post"  >
						<input name="salesDocIds" type="hidden" value=""/>
						<input name="invPrjNos" type="hidden" value=""/>
						<input name="salesType" type="hidden" value="T"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col300" />
								<col class="col300" />
								<col class="col300" />
								<col class="col100" />
							</colgroup>
							<tbody>
								<tr>
									<td><label>프로젝트ID </label><input type="text" readonly="readonly" name="prjId" class="input01 w150" value="${invcStatVO.prjId}" /></td>
									<td colspan="2"><label>프로젝트명 </label><input type="text" readonly="readonly" name="prjName" class="input01 w300" value="${invcStatVO.prjName}" /></td>
									<td rowspan="2"><img src="../../images/btn/btn_accept02.gif" onclick="javascript:closeBondMng();" class="cursorPointer"/>
								</tr>
								<tr>
									<td><label>매출금 합계 </label><input type="text" class="input02 w100" readonly="readonly" id="salesSum" value="0"/></td>
									<td><label>계산서 발행 합계 </label><input type="text" class="input02 w100" readonly="readonly" id="invoiceSum" value="0"/></td>
									<td><label>수금 합계 </label><input type="text" class="input02 w100" readonly="readonly" id="collectSum" value="0"/></td>
								</tr>
							</tbody>
							</table>
						</fieldset>
					</form:form>	<!-- 상단 검색창 끝 -->

					</div>	<!-- E: section -->
				</div>	<!-- E: center -->				
				<%@ include file="../include/right.jsp"%>
			</div>	<!-- E: centerBg -->
		</div>	<!-- E: contents -->
	</div>  <!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div> <!-- id=wrap -->
</body>
</html>
