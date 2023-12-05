<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
/////   1. Setting in Loading 
$(document).ready(function() {

	changeSearchStatus();
	
	$('.checkStatus').change(function(){
		var $this = $(this);
		var statusValue = parseInt($this.val());
		var searchStatus = parseInt($('#searchStatus').val());
		if($this.is(":checked")) {
			$('#searchStatus').val(searchStatus | statusValue); 
		}
		else {
			$('#searchStatus').val(searchStatus ^ statusValue); 
		}
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
}

/////   2. Event Methods 

/////   3. Call Methods 
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

// 프로젝트 검색조건 초기화
function clsPrj() {
	$('#searchPrjName').val('');
	$('#searchPrjId').val('');
}

/////   4. Submit Methods 
function invoiceListPaging(pageIndex) {
	document.invoiceFm.pageIndex.value = pageIndex;
	document.invoiceFm.action = '<c:url value="${rootPath}/fund/invoiceList.do" />';
	document.invoiceFm.submit();
}

function invoiceListSearch() {
	document.invoiceFm.pageIndex.value = 1;
	document.invoiceFm.action = '<c:url value="${rootPath}/fund/invoiceList.do" />';
	document.invoiceFm.submit();
}

function invoiceView(invoiceId) {
	document.invoiceFm.invoiceId.value = invoiceId;
	document.invoiceFm.action = '<c:url value="${rootPath}/fund/invoiceView.do" />';
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

//TENY_170313 새로운 계산서 발행요청서를 작성하는 페이지로 이동하는 기능
function writeInvoice() {
	document.invoiceFm.action = "<c:url value='${rootPath}/fund/invoiceWrite.do'/>";
	document.invoiceFm.submit();
}

//TENY_170313 수금등록을 POPUP장으로 띄워서 입력하는 기능
function popCollectWrite(invoiceId){
	document.invoiceFm.invoiceId.value = invoiceId;
	
	var POP_NAME = "_POP_COLLEC_WRITE_";
	var target = document.invoiceFm.target;
	document.invoiceFm.target = POP_NAME;
	document.invoiceFm.action = '<c:url value="/fund/invoiceCollectWrite.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=600px,height=600px;");
	document.invoiceFm.submit();
	popup.focus();
	document.invoiceFm.target = target;
}

// TENY_170313 수금현황을 POPUP장으로 띄워서 보는 기능 
function popCollectView(invoiceId){
	document.invoiceFm.invoiceId.value = invoiceId;
	
	var POP_NAME = "_POP_COLLEC_WRITE_";
	var target = document.invoiceFm.target;
	document.invoiceFm.target = POP_NAME;
	document.invoiceFm.action = '<c:url value="/fund/invoiceCollectView.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=600px,height=400px;");
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
						<li class="stitle">세금계산서 발행요청 현황 (사업부)</li>
						<li class="navi">홈 > 업무지원 > 각종신청 > 세금계산서 발행요청</li>
					</ul>
				</div>  

				<span class="stxt">본 기능은 사업부의 기능으로 세금계산서를 요청하고 발행요청사항을 관리하는 화면. </span>

				<!-- S: section -->
				<div class="section01">
				<form name="invoiceFm" id="invoiceFm" method="POST" action="" onsubmit="invoiceListSearch(); return false;">
					<input type="hidden" name="searchMode" 		value="${invoiceVO.searchMode}"/>
					<input type="hidden" name="searchCondition" 	value="${invoiceVO.searchCondition}"/>
					<input type="hidden" name="searchStatus" id="searchStatus" value="${invoiceVO.searchStatus}"/>
					<input type="hidden" name="pageIndex" 			value="${invoiceVO.pageIndex}"/>
					<input type="hidden" name="invoiceId" value=""/>

				<!-- 상단 검색창 시작 -->
				<fieldset>
				<legend>상단 검색</legend>
					<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0">
							<caption>상단 검색</caption>
							<colgroup>
								<col width="600" />
								<col width="200" />
							</colgroup>
							<tbody>
								<tr>
									<td class="pT5" >처리상태 :
										<label><input type="checkbox" class="checkStatus" id="searchREQUEST" value="2" /> 미발행 </label>
										<label><input type="checkbox" class="checkStatus" id="searchPUBLISH" value="4" /> 발행 </label>
										<label><input type="checkbox" class="checkStatus" id="searchCANCLE" value="1" /> 취소 </label>
									</td>
									<td class="search_right" rowspan="2">
										<input type="image" src="../../images/btn/btn_search02.gif" class="search_btn02" alt="검색"/>
										&nbsp;<img src="${imagePath}/btn/btn_replay.gif" onclick="javascript:clsPrj();" class="cursorPointer" title="프로젝트 검색조건 초기화" style="padding-top:2px;">
									</td>
								</tr>
								<tr>
									<td colspan="2" class="pT5">
										<label>요청제목 </label><input type="text" name="searchTitle" class="input01 span_10" value="${invoiceVO.searchTitle}" />
										<span class="pL7"></span><label>요청자 </label>
											<input type="text" name="searchWriterName" class="input01 span_7 userNameAutoHead" value="${invoiceVO.searchWriterName}"/>
										<span class="pL7"></span><label>업체명 </label>
											<input type="text" name="searchCompanyName" class="input01 span_10" value="${invoiceVO.searchCompanyName}"/> 
									</td>
							</tbody>
						</table>
					</div>
				</fieldset>
				<!-- 상단 검색창 끝 -->
				</form>

				<div class="btn_area">
					<img src="../../images/btn/btn_publishRqst.gif" onclick="javascript:writeInvoice();" class="cursorPointer"/>
					<img src="../../images/btn/btn_delete.gif" onclick="javascript:deleteInvoice();" class="cursorPointer"/>
				</div>
				<div class="boardList mB20">
					<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
					<caption>공지사항</caption>
					<colgroup>
						<col class="col20" />
						<col class="col40" />
						<col width="px" />
						
						<col class="col120" />
						<col class="col60" />
						<col class="col60" />
						
						<col class="col60" />
						<col class="col60" />
						<col class="col60" />
						
						<col class="col60" />
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAll" onclick="javascript:allChckChange(this);" /></th>
							<th>번호</th>
							<th>제   목</th>
							
							<th>고객사</th>
							<th>발행액</th>
					<c:choose>
						<c:when test="${invoiceVO.searchMode == 2}">
							<th>수금액</th>
						</c:when>
						<c:otherwise>
							<th>발행사</th>
						</c:otherwise>
					</c:choose>
							
							<th>요청자</th>
							<th>요청일</th>
					<c:choose>
						<c:when test="${invoiceVO.searchMode == 2}">
							<th>발행일</th>
						</c:when>
						<c:otherwise>
							<th>예정일</th>
						</c:otherwise>
					</c:choose>
							
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
									<td class="pL5"><a href="${rootPath}/fund/invoiceView.do?invoiceId=${result.invoiceId}">
									<div style="height:100%;width:100%">${result.title}</div></a></td>
									<td class="txt_center">${result.custCompanyName}</td>
									<td class="txt_right"><print:currency cost="${result.totalSum}" /></td>
								<c:choose>
									<c:when test="${invoiceVO.searchMode == 2}">
										<td class="txt_right">${result.totalCollect}</td>
									</c:when>
									<c:otherwise>
										<td class="txt_center">${result.publishCoAcronym}</td>
									</c:otherwise>
								</c:choose>
									<td class="txt_center"><print:user userNo="${result.writeUserNo}" userNm="${result.writeUserName}"/></td>
									<td class="txt_center">${result.writeDatetime}</td>
									<td class="txt_center"><print:date date="${result.publishReqDate}" printType='S'/></td>
								<c:choose>
									<c:when test="${result.status == 1}">
										<td class="txt_center">취소</td>
									</c:when>
									<c:when test="${result.status == 2}">
										<td class="txt_center">요청</td>
									</c:when>
									<c:when test="${result.status == 4}">
										<td class="txt_center">발행</td>
									</c:when>
									<c:when test="${result.status == 8}">
										<td class="txt_center">수금중</td>
									</c:when>
									<c:when test="${result.status == 16}">
										<td class="txt_center">완료</td>
									</c:when>
									<c:when test="${result.status == 32}">
										<td class="txt_center">과수금</td>
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
					<img src="../../images/btn/btn_publishRqst.gif" onclick="javascript:writeInvoice();" class="cursorPointer"/>
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
