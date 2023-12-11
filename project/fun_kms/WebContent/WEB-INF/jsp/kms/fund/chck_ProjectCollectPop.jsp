
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
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
							<li class="stitle">계산서발행 및 수금내역(상세)</li>
							<li class="navi">채권관리 > 계산서발행 및 수금내역(상세)</li>
						</ul>
					</div> <!-- div class="path_navi" -->
	
					<span class="stxt">본 페이지에서는 프로젝트별 상세 수금내역 목록을 제공한다.</span>
					<!-- S: section -->
					<div class="section01">
					<!-- 상단 검색창 시작 -->
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col250" />
								<col class="col250" />
								<col class="col250" />
								<col class="col250" />
							</colgroup>
							<tbody>
								<tr>
									<td colspan="2"><label>프로젝트ID </label><input type="text" readonly="readonly" name="prjId" class="input01 w150" value="${InvcStatVOFm.prjId}" /></td>
									<td colspan="2"><label>프로젝트명 </label><input type="text" readonly="readonly" name="prjName" class="input01 w400" value="${InvcStatVOFm.prjName}" /></td>
								</tr>
							</tbody>
							</table>
							</div>
					<!-- 상단 검색창 끝 -->

					<form:form commandName="invoiceFm" id="invoiceFm" name="invoiceFm" method="post"  >
						<input type="hidden" name="invoiceId" value=""/>
						<input type="hidden" name="openPop" value="Y"/>
						
					<!-- 세금계산서 목록  -->
					<p class="th_stitle mB10">세금계산서 발햄 및 수금 목록</p>
					<span class="th_plus03">( 단위 : 원 )</span>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" >
						<colgroup>
							<col class="col30" />
							<col class="col60" />
							<col class="col60" />
							<col class="col400" />
							<col class="col80" />
							<col class="col80" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>날짜</th>
								<th>구분</th>
								<th>내역</th>
								<th>금액</th>
								<th>잔금</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${icmVOList}" var="result" varStatus="vs">
							<tr>
								<td class="txt_center"><c:out value="${vs.count}"/></td>
								<td class="txt_center">${result.date}</td>
						<c:choose>
							<c:when test="${result.type == 'I'}">
								<td class="txt_center">계산서발행</td>
							</c:when>
							<c:otherwise>
								<td class="txt_center">수금</td>
							</c:otherwise>
						</c:choose>
								<td class="txt_left pL7">${result.title}</a></td>
								<td class="txt_right pR10"><print:currency cost="${result.amount}"/></td>
								<td class="txt_right pR10"><print:currency cost="${result.remain}"/></td>
							</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>  <!-- class="boardList02 mB20" -->
					<!-- 계산서 목록끝  -->
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
