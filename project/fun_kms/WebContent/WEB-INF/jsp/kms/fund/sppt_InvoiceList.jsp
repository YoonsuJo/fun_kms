<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
/////   1. Setting in Loading 
$(document).ready(function() {

	changeSearchStatus();

	/* 모드를 바꾸면 검색조건을 바꾸는 이벤트 함수를 등록함 */
	$("input[name=searchMode]").change(function(){
		var $this = $(this);
		var searchMode = parseInt($this.val());
		setSearchMode(searchMode);
	});
});

function changeSearchStatus(){

	if(parseInt($('#searchStatus').val()) & 1) {
		$('#searchCANCLE').prop("checked", true);
	}
	if(parseInt($('#searchStatus').val()) & 2) {
		$('#searchREQUEST').prop("checked", true);
	}
	if(parseInt($('#searchStatus').val()) & 4) {
		$('#searchPUBLISH').prop("checked", true);
	}
	if(parseInt($('#searchStatus').val()) & 8) {
		$('#searchCOLLECTLESS').prop("checked", true);
	}
	if(parseInt($('#searchStatus').val()) & 16) {
		$('#searchCOLLECT').prop("checked", true);
	}
	if(parseInt($('#searchStatus').val()) & 32) {
		$('#searchCOLLECTMORE').prop("checked", true);
	}
}

function setStatusValue() {
	var statusValue = 0; 
	var inputElements = document.getElementsByClassName('checkStatus');
	for(var i=0; inputElements[i]; ++i){
		if(inputElements[i].checked){
			statusValue += parseInt(inputElements[i].value);
		}
	}
	$('#searchStatus').val(statusValue);
}

/////   2. Event Methods 
function setSearchMode(mode) {
	if(mode == 1) {		/* 발행요청자 모드 */
		$('#searchREQUEST'			).prop("checked", true);
		$('#searchPUBLISH'			).prop("checked", true);
		$('#searchCOLLECTLESS'	).prop("checked", true);
		$('#searchCOLLECT'			).prop("checked", true);
		$('#searchCOLLECTMORE'	).prop("checked", true);
		$('#searchCANCLE'			).prop("checked", true);
		
		$('#searchWriterMixes' ).val($('#userMixes').val());
		$('#searchDateFrom').val("");
		$('#searchDateTo').val("");
	} else if(mode == 2) {		/* 발행 처리 담당자 모드 */
		$('#searchREQUEST'			).prop("checked", true);
		$('#searchPUBLISH'			).prop("checked", false);
		$('#searchCOLLECTLESS'	).prop("checked", false);
		$('#searchCOLLECT'			).prop("checked", false);
		$('#searchCOLLECTMORE'	).prop("checked", false);
		$('#searchCANCLE'			).prop("checked", false);

		$('#searchWriterMixes' ).val("");
		$('#searchDateFrom').val("");
		$('#searchDateTo').val($('#todayStr').val());
	} else if(mode == 3) {		/* 수금 처리 담당자 모드 */
		$('#searchREQUEST'			).prop("checked", false);
		$('#searchPUBLISH'			).prop("checked", true);
		$('#searchCOLLECTLESS'	).prop("checked", true);
		$('#searchCOLLECT'			).prop("checked", false);
		$('#searchCOLLECTMORE'	).prop("checked", false);
		$('#searchCANCLE'			).prop("checked", false);

		$('#searchWriterMixes' ).val("");
		$('#searchDateFrom').val("");
		$('#searchDateTo').val("");
	}	else {		/* 기타 모드 */
		$('#searchREQUEST'			).prop("checked", true);
		$('#searchPUBLISH'			).prop("checked", true);
		$('#searchCOLLECTLESS'	).prop("checked", true);
		$('#searchCOLLECT'			).prop("checked", true);
		$('#searchCOLLECTMORE'	).prop("checked", true);
		$('#searchCANCLE'			).prop("checked", false);

		$('#searchWriterMixes' ).val("");
		$('#searchDateFrom').val("");
		$('#searchDateTo').val("");
	}
	invoiceListSearch();
}

/////   3. Call Methods 
/* 간단히/자세히 토글 */
function toggleCondition(){
	var btnDetail = $('#btnDetail');
	if (btnDetail.hasClass('btn_arrow_down')) {
		// 자세히 클릭
		btnDetail.removeClass('btn_arrow_down');
		btnDetail.addClass('btn_arrow_up');
		$('.option').show();
		var clone = btnDetail.clone();
		var span = btnDetail.closest('span');
		span.html('간단히 ');
		span.append(clone);
		$('#searchDetail').val('Y');
	} else {
		// 간단히 클릭
		btnDetail.removeClass('btn_arrow_up');
		btnDetail.addClass('btn_arrow_down');
		$('.option').hide();
		var clone = btnDetail.clone();
		var span = btnDetail.closest('span');
		span.html('자세히 ');
		span.append(clone);
		$('#searchDetail').val('N');
	}
}

//프로젝트 검색조건 초기화
function clsPrj() {
	$('#searchPrjName').val('');
	$('#searchPrjId').val('');
}

/* 전체 선택 체크박스 */
function allChckChange(obj) {
	var chk = document.getElementsByName("chck");
	if (obj.checked) {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=true;
		}
	}
	else {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=false;
		}
	}
}

/////   4. Submit Methods 
/* 검색 버튼 눌렀을때 */
function invoiceListSearch() {
	setStatusValue();
	document.invoiceFm.pageIndex.value = 1;
	document.invoiceFm.action = '<c:url value="${rootPath}/fund/invoiceList.do" />';
	document.invoiceFm.submit();
}

/* 페이지 이동 */
function invoiceListPaging(pageIndex) {
	document.invoiceFm.pageIndex.value = pageIndex;
	document.invoiceFm.action = '<c:url value="${rootPath}/fund/invoiceList.do" />';
	document.invoiceFm.submit();
}

//TENY_170313 선택된 계산서를 일괄 삭제하는 기능
function deleteInvoice() {
//	if (confirm('<spring:message code="common.delete.msg" />')) {
		if (confirm("삭제하시겠습니까? 선택된 계산서중 미발행과 취소된 계산서만 삭제됩니다")) {
		var chk = document.getElementsByName("chck");
		var invoiceIdList = "";
		
		for(var i=0; i<chk.length; i++) {
			if (chk[i].checked) {
				if (invoiceIdList != "") {
					invoiceIdList += ",";
				}
				invoiceIdList += chk[i].value;
			}
		}
		if (invoiceIdList == "") {
			alert("선택된 계산서가 없습니다.");
			return;
		}
		document.invoiceFm.invoiceId.value = invoiceIdList;
		document.invoiceFm.action = "<c:url value='${rootPath}/fund/deleteInvoiceList.do'/>";
		document.invoiceFm.submit();
	}
}

//TENY_170708 발행 요청자가 계산서 발행 요청작업을 POPUP장으로 띄워서 입력하는 기능
function popInvoiceWrite(){
	
	var POP_NAME = "_POP_INVOICE_WRITE_";
	var target = document.invoiceFm.target;
	document.invoiceFm.target = POP_NAME;
	$('#openPop').val("Y");
	document.invoiceFm.action = '<c:url value="/fund/invoiceWrite.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=940px,height=800px;");
	document.invoiceFm.submit();
	popup.focus();
	document.invoiceFm.target = target;
}


//TENY_170327 계산서 내용을 POPUP장으로 띄워서 조회하는 기능
function popInvoiceView(invoiceId){
	
	var POP_NAME = "_POP_INVOICE_VIEW_";
	var target = document.invoiceFm.target;
	document.invoiceFm.invoiceId.value = invoiceId;
	document.invoiceFm.target = POP_NAME;
	$('#openPop').val("Y");
	document.invoiceFm.action = '<c:url value="/fund/invoiceView.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=940px,height=800px;");
	document.invoiceFm.submit();
	popup.focus();
	document.invoiceFm.target = target;
}

//TENY_170313 수금 담당자가 수금등록을 POPUP장으로 띄워서 입력하는 기능
function popCollectWrite(invoiceId){
	document.invoiceFm.invoiceId.value = invoiceId;
	
	var POP_NAME = "_POP_COLLEC_WRITE_";
	var target = document.invoiceFm.target;
	document.invoiceFm.target = POP_NAME;
	document.invoiceFm.action = '<c:url value="/fund/invoiceCollectWrite.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=900px,height=800px;");
	document.invoiceFm.submit();
	popup.focus();
	document.invoiceFm.target = target;
}

// TENY_170313 수금현황을 POPUP장으로 띄워서 보는 기능 
function popCollectView(invoiceId){
	document.invoiceFm.invoiceId.value = invoiceId;
	
	var POP_NAME = "_POP_COLLEC_VIEW_";
	var target = document.invoiceFm.target;
	document.invoiceFm.target = POP_NAME;
	document.invoiceFm.action = '<c:url value="/fund/invoiceCollectView.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=700px,height=600px;");
	document.invoiceFm.submit();
	popup.focus();
	document.invoiceFm.target = target;
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
						<li class="stitle">계산서 목록</li>
						<li class="navi">계산서 관리 > 계산서 목록</li>
					</ul>
				</div>  

				<span class="stxt">(*) 표시가 있는 항목은 필수 입력 항목입니다.</span>

				<!-- S: section -->
				<div class="section01">
				<form name="invoiceFm" id="invoiceFm" method="POST" action="" onsubmit="invoiceListSearch(); return false;">
					<input type="hidden" name="searchCondition" 						value="Y"/>
					<input type="hidden" name="searchStatus" 	id="searchStatus" 	value="${invoiceVO.searchStatus}"/>
					<input type="hidden" name="pageIndex" 								value="${invoiceVO.pageIndex}"/>
					<input type="hidden" name="invoiceId" 								value=""/>
					<input type="hidden" name="openPop" 		id="openPop"		value="N"/>
					<input type="hidden" id="userMixes"									value="${user.userNm}(${user.userId})"/>
					<input type="hidden" id="todayStr"											value="${today}"/>

				<!-- 상단 검색창 시작 -->
				<fieldset>
				<legend>상단 검색</legend>
					<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0">
							<caption>상단 검색</caption>
							<colgroup>
								<col class="col700" />
								<col class="col200" />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<c:choose>
											<c:when test="${invoiceVO.searchMode == 1}">
												<label><input type="radio" name="searchMode" checked="checked" value="1"> 발행요청업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" value="2"> 발행업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" value="3"> 수금업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" value="4"> 기타업무 </label>
											</c:when>
											<c:when test="${invoiceVO.searchMode == 2}">
												<label><input type="radio" name="searchMode" value="1"> 발행요청업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" checked="checked" value="2"> 발행업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" value="3"> 수금업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" value="4"> 기타업무 </label>
											</c:when>
											<c:when test="${invoiceVO.searchMode == 3}">
												<label><input type="radio" name="searchMode" value="1"> 발행요청업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" value="2"> 발행업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" checked="checked" value="3"> 수금업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" value="4"> 기타업무 </label>
											</c:when>
											<c:otherwise>
												<label><input type="radio" name="searchMode" value="1"> 발행요청업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" value="2"> 발행업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" value="3"> 수금업무 </label><span class="pL70"></span>
												<label><input type="radio" name="searchMode" checked="checked" value="4"> 기타업무 </label>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="search_right" >
										<span>간단히 <img class="btn_arrow_up cursorPointer " id="btnDetail" onclick="toggleCondition();"/></span>
<%-- 										<img src="${imagePath}/btn/btn_replay.gif" onclick="javascript:clsPrj();" class="cursorPointer" title="프로젝트 검색조건 초기화" style="padding-top:2px;">
 --%>									 	<input type="image" src="../../images/btn/btn_search02.gif" class="search_btn02" alt="검색"/>
									</td>
								<tr class="option">
									<td class="pT5">처리상태 :
										<label><input type="checkbox" class="checkStatus" id="searchREQUEST" value="2" /> 요청 </label>
										<label><input type="checkbox" class="checkStatus" id="searchPUBLISH" value="4" /> 발행 </label>
										<label><input type="checkbox" class="checkStatus" id="searchCOLLECTLESS" value="8" /> 수금중 </label>
										<label><input type="checkbox" class="checkStatus" id="searchCOLLECT" value="16" /> 수금완료 </label>
										<label><input type="checkbox" class="checkStatus" id="searchCOLLECTMORE" value="32" /> 수금초과 </label>
										<label><input type="checkbox" class="checkStatus" id="searchCANCLE" value="1" /> 취소 </label>
									</td>
								</tr>
								<tr class="option">
									<td colspan="2" class="pT5">
										<label>요청자 </label>
											<input type="text" class="search_txt02 w200 userNameAuto userValidateCheckAuth" name="searchWriterMixes" id="searchWriterMixes" value="${invoiceVO.searchWriterMixes}"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchWriterMixes', 1, null, null, '1');" /><span class="pL7"></span>
										<label>발행예정일 </label>
											<input type="text" readonly name="searchDateFrom" id="searchDateFrom" class="w100 txt_center calGen" value="${invoiceVO.searchDateFrom}"/> ~
											<input type="text" readonly name="searchDateTo" id="searchDateTo" class="w100 txt_center calGen" value="${invoiceVO.searchDateTo}"/>
									</td>
								</tr>
								<tr class="option">
									<td colspan="2" class="pT5">
										<label>요청제목 </label>
										<input type="text" name="searchTitle" class="input01 span_10" value="${invoiceVO.searchTitle}" />
										<span class="pL7"></span><label>고객사명 </label>
											<input type="text" name="searchCompanyName" class="input01 span_10" value="${invoiceVO.searchCompanyName}"/> 
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</fieldset>
				<!-- 상단 검색창 끝 -->
				</form>

				<img src="/images/btn/btn_delete.gif" onclick="javascript:deleteInvoice();" class="fr cursorPointer pL5"/>
				<img src="/images/btn/btn_publishRqst.gif" onclick="javascript:popInvoiceWrite();" class="fr cursorPointer pL5"/>
				<p class="th_stitle">계산서 목록</p>
				<div class="boardList mB20">
					<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
					<caption>공지사항</caption>
					<colgroup>
						<col class="col20" />
						<col class="col40" />
						<col width="px" />
						
						<col class="col120" />
						<col class="col70" />
						<col class="col60" />
						
						<col class="col60" />
						<col class="col60" />
						<col class="col60" />
						
						<col class="col50" />
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAll" onclick="javascript:allChckChange(this);" /></th>
							<th>번호</th>
							<th>제   목</th>
							
							<th>고객사</th>
							<th>발행액</th>
							<th>발행사</th>
							
							<th>요청자</th>
							<th>요청일</th>
							<th>예정일</th>
							<th class="th_right">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
						<c:when test="${empty resultList }">
							<tr><td colspan="10" class="td_last txt_center" > </td></tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><input type="checkbox" name="chck" value="${result.invoiceId}"/></td>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((invoiceVO.pageIndex-1) * paginationInfo.recordCountPerPage + c.count) + 1}"/></td>
									<td class="pL5"><a href="javascript:popInvoiceView('${result.invoiceId}');">
										<div style="height:100%;width:100%">${result.title}</div></a></td>
									<td class="txt_center">${result.custCompanyName}</td>
									<td class="txt_right"><print:currency cost="${result.totalSum}" /></td>
									<td class="txt_center">${result.publishCoAcronym}</td>

									<td class="txt_center"><print:user userNo="${result.writeUserNo}" userNm="${result.writeUserName}"/></td>
									<td class="txt_center">${result.writeDatetime}</td>
									<td class="txt_center"><print:date date="${result.publishReqDate}" printType='S'/></td>
								<c:choose>
									<c:when test="${result.status == 1}">
										<td class="txt_center">취소</td>
									</c:when>
									<c:when test="${result.status == 2}">
										<td class="txt_center"><a href="javascript:popInvoiceView('${result.invoiceId}');">
											<div style="height:100%;width:100%">요청</div></a></td>
									</c:when>
									<c:when test="${result.status == 4}">
										<td class="txt_center"><a href="javascript:popCollectWrite('${result.invoiceId}');">발행</a></td>
									</c:when>
									<c:when test="${result.status == 8}">
										<td class="txt_center"><a href="javascript:popCollectWrite('${result.invoiceId}');">수금중</a></td>
									</c:when>
									<c:when test="${result.status == 16}">
										<td class="txt_center"><a href="javascript:popCollectView('${result.invoiceId}');">완료</a></td>
									</c:when>
									<c:when test="${result.status == 32}">
										<td class="txt_center"><a href="javascript:popCollectView('${result.invoiceId}');">과수금</a></td>
									</c:when>
									<c:otherwise>
										<td class="txt_center">상태</td>
									</c:otherwise>
								</c:choose>
								</tr>
							</c:forEach>
						</c:otherwise>
						</c:choose>
					</tbody>
					</table>
				</div>	<!-- E:boardList -->

				<div class="paginate">
					<ui:pagination paginationInfo="${paginationInfo}" jsFunction="invoiceListPaging" type="image"/>
				</div>
				<div class="btn_area">
					<img src="../../images/btn/btn_publishRqst.gif" onclick="javascript:popInvoiceWrite();" class="cursorPointer"/>
					<img src="../../images/btn/btn_delete.gif" onclick="javascript:deleteInvoice();" class="cursorPointer"/>
				</div>

				</div>	<!-- E: section -->

			</div>	<!-- E: center -->              
	
			<%@ include file="../include/right.jsp"%>
	
			</div>	<!-- E: centerBg -->
		</div>	<!-- E: contents -->
	</div>	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
