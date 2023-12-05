<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
//시작 동작
$(document).ready(function() {
	bindSearchData();
});

// 검색데이터들을 바인딩시킨다.
function bindSearchData() {
	
	// checkbox bind
	var searchState = '${searchVO.searchState}';
	var searchReceiveTyp = '${searchVO.searchReceiveTyp}';
	var searchTyp = '${searchVO.searchTyp}';
	var searchServiceTyp = '${searchVO.searchServiceTyp}';
	var searchErrorTyp = '${searchVO.searchErrorTyp}';
	var searchDetailTyp = '${searchVO.searchDetailTyp}';
	
	bindSearchChkData('searchState', searchState);
	bindSearchChkData('searchReceiveTyp', searchReceiveTyp);
	bindSearchChkData('searchTyp', searchTyp);
	bindSearchChkData('searchServiceTyp', searchServiceTyp);
	bindSearchChkData('searchErrorTyp', searchErrorTyp);
	bindSearchChkData('searchDetailTyp', searchDetailTyp);
	
	// 간단히/자세히 bind
	if ('${searchVO.searchDetail}' == 'Y') $('#btnDetail').click();
	
	// 전체 기간 bind 및 기간 event처리
	if ('${searchVO.searchRegDtS}' == '' && '${searchVO.searchRegDtE}' == '') {
		$('#searchAllPeriod').attr('checked', true);
		$('#searchRegDtS').attr('disabled', true);
		$('#searchRegDtE').attr('disabled', true);
	} else {
		$('#searchAllPeriod').attr('checked', false);
		$('#searchRegDtS').attr('disabled', false);
		$('#searchRegDtE').attr('disabled', false);
	}
	
}

// checkbox 검색데이터들을 바인딩시킨다.
function bindSearchChkData(name, data) {
	if (data=="") return;
	
	var dataList = data.split(',');
	for (var i=0; i<dataList.length; i++) {
		$('input[name='+name+'][value='+dataList[i]+']').attr('checked', true);
		//$('input[name='+name+'][value='+dataList[i]+']').click();
	}
	$('#'+name+'All').attr('checked', false);
}

//검색
function search(pageNo, excel) {
	//document.listForm.searchRegDtS.value=document.listForm.curRegDtS.value;
	//document.listForm.searchRegDtE.value=document.listForm.curRegDtE.value;
	
	// 엑셀저장 초기화
	document.listForm.excel.value = excel;
	
	// 각 체크박스 검색조건에 전체가 아닐 경우, fakeValue를 추가하여 자바에서 해당조건에 대해 String[]로 인식하도록 작업.(ibatis에서 조건식에 적용하기 위해)
	// 상단검색박스에 hidden Div를 생성하여, 거기에 input 태그에 value를 fakeValue 값을 추가.(SQL에는 들어가되, 실제로 검색이 되지는 않는다.)
	var div = $('<div style="display:none;"></div>');
	if (!$('#searchStateAll').is(':checked'))
		div.append('<input type="checkbox" name="searchState" value="fakeValue" checked="checked" />');
	if (!$('#searchReceiveTypAll').is(':checked'))
		div.append('<input type="checkbox" name="searchReceiveTyp" value="fakeValue" checked="checked" />');
	if (!$('#searchTypAll').is(':checked'))
		div.append('<input type="checkbox" name="searchTyp" value="fakeValue" checked="checked" />');
	if (!$('#searchServiceTypAll').is(':checked'))
		div.append('<input type="checkbox" name="searchServiceTyp" value="fakeValue" checked="checked" />');
	if (!$('#searchErrorTypAll').is(':checked'))
		div.append('<input type="checkbox" name="searchErrorTyp" value="fakeValue" checked="checked" />');
	if (!$('#searchDetailTypAll').is(':checked'))
		div.append('<input type="checkbox" name="searchDetailTyp" value="fakeValue" checked="checked" />');
	div.appendTo('#searchDiv');
	
	document.listForm.pageIndex.value = pageNo;

	// 접수자, 담당자 검색
	var conName = document.listForm.searchConNm.value;	
	if(conName.indexOf("(") != -1)
		document.listForm.searchConNm.value = conName.substring(0, conName.indexOf("("));
	var damName = document.listForm.searchDamNm.value;	
	if(damName.indexOf("(") != -1)
		document.listForm.searchDamNm.value = damName.substring(0, damName.indexOf("("));

	/*
	//전체검색조건
	if(document.listForm.allchk.value = "checked"){
		$("#ckValue").val("checked");
	}
	*/
	document.listForm.submit();
}
//엑셀저장
function excelDown() {
	if ('${paginationInfo.totalRecordCount}' > 2000) {
		alert('2,000건 이하의 데이터를 지정해주시기 바랍니다.\n(총 : ' + '${paginationInfo.totalRecordCount}' + '건)');
		return;
	}
	search(1, 'Y');	
}
//상담관리 상세화면 이동
function view(no) {
	document.listForm.consult_no.value = no;	
	document.listForm.action = "${rootPath}/cooperation/selectConsultManage.do";
	document.listForm.submit();
}
//고객사등록 화면 이동
function clientRegister(){

	document.listForm.action = "${rootPath}/cooperation/writeClient.do";
	document.listForm.submit();
	
}
//열람
function viewState(consultNo) {
	var popup = window.open("/cooperation/selectConsultRecieveList.do?consult_no=" + consultNo,"_POP_STATE_","width=360px,height=415px,scrollbars=yes");
	popup.focus();
}
//고객검색
function searchCust(custNm){
	var popup = window.open("${rootPath}/cooperation/selectSearchCustNmConsultManageList.do?searchCuNm2=" + encodeURI(custNm),"_POP_CUSTLIST_","width=747px,height=864px,scrollbars=yes");
	popup.focus();
}


// 간단히/자세히 토글
function toggleCondition(obj){
	if ($(obj).hasClass('btn_arrow_down')) {
		// 자세히 클릭
		$(obj).removeClass('btn_arrow_down');
		$(obj).addClass('btn_arrow_up');
		$('.toggleCondition').show();
		var clone = $(obj).clone();
		var span = $(obj).closest('span');
		span.html('간단히 ');
		span.append(clone);
		$('#searchDetail').val('Y');
	} else {
		// 간단히 클릭
		$(obj).removeClass('btn_arrow_up');
		$(obj).addClass('btn_arrow_down');
		$('.toggleCondition').hide();
		var clone = $(obj).clone();
		var span = $(obj).closest('span');
		span.html('자세히 ');
		span.append(clone);
		$('#searchDetail').val('N');
	}
}

// cate: 조건구분, type- whole:전체선택, dtl:세부선택여부
function clickChkbox(cate, type) {
	var allchk = $('#'+cate+'All');

	if (type == 'whole') {
		// 전체를 클릭했을 경우	
		if (allchk.is(':checked')) {
			$('input[name='+cate+']').attr('checked', false);
		} else {
			allchk.attr('checked', true);
		}
	} else {
		// 세부조건을 클릭했을 경우
		allchk.attr('checked', false);
		$('input[name='+cate+'][value=fakeVal]').attr('checked', true);
	}
}

function clickChkboxDate() {
	var allchk = $('#searchAllPeriod');

	/*
	if (allchk.is(':checked')) {
		$('#searchRegDtS').attr('disabled', 'disabled');
		$('#searchRegDtE').attr('disabled', 'disabled');
	} else {
		$('#searchRegDtS').removeAttr('disabled');
		$('#searchRegDtE').removeAttr('disabled');
	}
	*/
	$('#searchRegDtS').attr('disabled', allchk.is(':checked'));
	$('#searchRegDtE').attr('disabled', allchk.is(':checked'));
}

// 
function selectPageUnit(cnt) {
	$('input[name=pageUnit]').val(cnt);
	
	// Cookie에 페이지 조회 줄수 담기(30일 보관)
	setCookie('hanmam_consult_pageunit', cnt, 30);
	
	search(1, 'N');
}

//상담등록 화면 이동
function consultRegister() {
	document.listForm.action = "${rootPath}/cooperation/writeConsultManage.do";
	document.listForm.submit();
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
				<div id="center2">
					<div class="path_navi">
						<ul>
							<li class="stitle">상담결과</li>
							<li class="navi">홈 > 상담관리 > 상담결과</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
						
						<!-- 상단 검색창 시작 -->
						<form name="listForm" method="POST" action="${rootPath}/cooperation/selectConsultManageList.do" onsubmit="search(1, 'N'); return false;">
						<input type="hidden" name="pageIndex" value="1"/>
						<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
						<input type="hidden" name="excel" value="N" />
						<input type="hidden" name="fromResultView" value="Y" />
						<input type="hidden" name="consult_no" />
						<input type="hidden" id="searchDetail" name="searchDetail" value="${searchVO.searchDetail}" />
<!--			    	<input type="hidden" name="searchTyp" id="searchTyp"/>-->
<!--			    	<input type="hidden" name="searchServiceTyp" id="searchServiceTyp"/>-->
<!--			    	<input type="hidden" name="searchErrorTyp" id="searchErrorTyp"/>-->
						
					<fieldset>
					<legend>상단 검색</legend>
						<div id="searchDiv" class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<colgroup>
							<col class="col80" />
							<col class="col60"/><!-- <col width="35%" /> -->
							<col class="col270"/>
							<col class="col80" />
							<col class="col330"/><!-- <col width="35%" /> -->
							<col width="px" /><!-- <col class="col100" /> -->
						</colgroup>
						<tbody>
							<tr>
								<th class="fr pT5 pR5 txtB_Black">고객사</th>
								<td class="pT5 pL5" colspan="2">
									<input type="text" class="span_95p input01" name="searchCuNm" value="${searchVO.searchCuNm}"/>
								<th class="fr pT5 pR5 txtB_Black">고객명</th>
								<td class="pT5 pL5">
									<input type="text" class="span_95p input01" name="searchcustManager" value="${searchVO.searchcustManager}"/>
								</td>
								<td><!-- 검색하기 버튼 -->
									<input type="image" src="${imagePath}/btn/btn_search02.gif" id="imgSearch" class="search_btn02 th_stitle_right cursorPointer" alt="검색" onclick="search(1, 'N'); return false;" />
								</td>
							</tr>
							<tr>
								<th class="fr pT5 pR5 txtB_Black">문의내용</th>
								<td class="pT5 pL5" colspan="2">
									<input type="text" class="span_95p input01" name="searchQCn" value="${searchVO.searchQCn}"/>
								<th class="fr pT5 pR5 txtB_Black">처리상태</th>
								<td class="pT5 pL5">
									<label>
									<input type="checkbox" id="searchStateAll" value="" checked="checked" onclick="clickChkbox('searchState', 'whole');"/> 전체 &nbsp;
									</label>
									<c:forEach items="${stateList}" var="state" varStatus="c">
										<label>
										<input type="checkbox" name="searchState" value="${state.code}" 
											<c:if test="${searchVO.searchState==state.code}">checked="checked"</c:if> 
											onclick="clickChkbox('searchState', 'dtl');" />
										<span class="nb" > ${state.codeNm} &nbsp;</span>
										</label>
									</c:forEach>
								</td>
								<td class="fr"><!-- 간단히/자세히 버튼 -->
									<span>자세히 <img class="btn_arrow_down cursorPointer" id="btnDetail" onclick="javascript:toggleCondition(this);"/></span>
								</td>
							</tr>
							<tr class="toggleCondition" style="display:none;">
								<th class="fr pT5 pR5 txtB_Black">접수자</th>
								<td class="pT5 pL5" colspan="2">
									<input type="text" class="span_90p input01 userNameAuto" name="searchConNm" id="searchConNm" value="${searchVO.searchConNm}"/>
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchConNm',1);">
								<th class="fr pT5 pR5 txtB_Black">처리자</th>
								<td class="pT5 pL5">
									<input type="text" class="span_90p input01 userNameAuto" name="searchDamNm" id="searchDamNm" value="${searchVO.searchDamNm}"/>
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchDamNm',1);">
								</td>
								<td></td>
							</tr>
							<tr class="toggleCondition" style="display:none;">
								<th class="fr pT5 pR5 txtB_Black">접수일</th>
								<td class="pT5 pL5" colspan="2">
									<input type="text" id="searchRegDtS" name="searchRegDtS" value="${searchVO.searchRegDtS}" class="calGen" maxlength="8" style="width:55px;" disabled="disabled"/>&nbsp;-
									<input type="text" id="searchRegDtE" name="searchRegDtE" value="${searchVO.searchRegDtE}" class="calGen" maxlength="8" style="width:55px;" disabled="disabled"/>&nbsp;
									<input type="hidden" id="ckValue" name="ckValue" value=""/>
									<label><input type="checkbox" title="전체기간" name="searchAllPeriod" id="searchAllPeriod" onclick="clickChkboxDate();" checked="checked" /> 전체</label>
								</td>
								<th class="fr pT5 pR5 txtB_Black">접수방법</th>
								<td class="pT5 pL5">
									<label>
									<input type="checkbox" id="searchReceiveTypAll" value=""  checked="checked" onclick="clickChkbox('searchReceiveTyp', 'whole');"/> 전체 &nbsp;
									</label>
									<c:forEach items="${receiveList}" var="receive" varStatus="c">
										<label>
										<input type="checkbox" name="searchReceiveTyp" value="${receive.code}" 
											<c:if test="${searchVO.searchReceiveTyp==receive.code}">checked="checked"</c:if> 
											onclick="clickChkbox('searchReceiveTyp', 'dtl');" />
										<span class="nb" > ${receive.codeNm} &nbsp;</span>
										</label>
									</c:forEach>
								</td>
								<td></td>
							</tr>
							<tr class="toggleCondition" style="display:none;">
								<th class="fr pT5 pR5 txtB_Black">구분</th>
								<td class="pT5 pL5">
									<label>
									<input type="checkbox" id="searchTypAll" value="" checked="checked" onclick="clickChkbox('searchTyp', 'whole');"/> 전체 &nbsp;
									</label>
								</td>
								<td class="pT5 pL5" colspan="3">
									<ul class="rd_align_15p">
									<c:forEach items="${typeList}" var="typ" varStatus="c">
										<li><label>
										<input type="checkbox" name="searchTyp" value="${typ.code}" 
											<c:if test="${searchVO.searchTyp==typ.code}">checked="checked"</c:if> 
											onclick="clickChkbox('searchTyp', 'dtl');" />
										<span class="nb" > ${typ.codeNm} &nbsp;</span>
										</label></li>
									</c:forEach>
									</ul>
								</td>
								<td></td>
							</tr>
							<tr class="toggleCondition" style="display:none;">
								<th class="fr pT5 pR5 txtB_Black">상담분류</th>
								<td class="pT5 pL5">
									<label>
									<input type="checkbox" id="searchServiceTypAll" value="" checked="checked" onclick="clickChkbox('searchServiceTyp', 'whole');"/> 전체 &nbsp;
									</label>
								</td>
								<td class="pT5 pL5" colspan="3">
									<ul class="rd_align_15p">
									<c:forEach items="${conList}" var="service" varStatus="c">
										<li><label>
										<input type="checkbox" name="searchServiceTyp" value="${service.code}" 
											<c:if test="${searchVO.searchServiceTyp==service.code}">checked="checked"</c:if> 
											onclick="clickChkbox('searchServiceTyp', 'dtl');" />
										<span class="nb" > ${service.codeNm} &nbsp;</span>
										</label></li>
									</c:forEach>
									</ul>
								</td>
								<td></td>
							</tr>
							<tr class="toggleCondition" style="display:none;">
								<th class="fr pT5 pR5 txtB_Black">장애항목</th>
								<td class="pT5 pL5">
									<label>
									<input type="checkbox" id="searchErrorTypAll" value=""  checked="checked" onclick="clickChkbox('searchErrorTyp', 'whole');"/> 전체 &nbsp;
									</label>
								</td>
								<td class="pT5 pL5" colspan="3">
									<ul class="rd_align_25p">
									<c:forEach items="${errorList}" var="err" varStatus="c">
										<li><label>
										<input type="checkbox" name="searchErrorTyp" value="${err.code}" 
											<c:if test="${searchVO.searchErrorTyp==err.code}">checked="checked"</c:if> 
											onclick="clickChkbox('searchErrorTyp', 'dtl');"/>
										<span class="nb" > ${err.codeNm} &nbsp;</span>
										</label></li>
									</c:forEach>
									</ul>
								</td>
							</tr>
							<tr class="toggleCondition" style="display:none;">
								<th class="fr pT5 pR5 txtB_Black">세부항목</th>
								<td class="pT5 pL5">
									<label>
									<input type="checkbox" id="searchDetailTypAll" value=""  checked="checked" onclick="clickChkbox('searchDetailTyp', 'whole');"/> 전체 &nbsp;
									</label>
								</td>
								<td class="pT5 pL5" colspan="3">
									<ul class="rd_align_25p">
									<c:forEach items="${detailList}" var="det" varStatus="c">
										<li><label>
										<input type="checkbox" name="searchDetailTyp" value="${det.code}" 
											<c:if test="${searchVO.searchDetailTyp==det.code}">checked="checked"</c:if> 
											onclick="clickChkbox('searchDetailTyp', 'dtl');"/>
										<span class="nb" > ${det.codeNm} &nbsp;</span>
										</label></li>
									</c:forEach>
									</ul>
								</td>
							</tr>
						</tbody>
						</table>
						</div>
					</fieldset>
						</form>
					<!-- 상단 검색창 끝 -->
					
					<!-- 게시판 시작 -->
					<div class="boardList mB20">
						<!-- 상단 바 시작 -->
						<div class="pB10">
							<select class="select01" onchange="selectPageUnit(this.options[this.selectedIndex].value)">
								<option value="15" <c:if test="${paginationInfo.recordCountPerPage==15}">selected="selected"</c:if> >15줄</option>
								<option value="30" <c:if test="${paginationInfo.recordCountPerPage==30}">selected="selected"</c:if> >30줄</option>
								<option value="50" <c:if test="${paginationInfo.recordCountPerPage==50}">selected="selected"</c:if> >50줄</option>
							</select>
							<span class="txtB_Black">총 : ${paginationInfo.totalRecordCount}건</span>
							<a href="javascript:excelDown();" class="fr"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>
							<a href="javascript:consultRegister();" class="fr"><img src="${imagePath}/btn/btn_goConsul.gif"/></a>
						</div>
						<!-- 상단 바 끝 -->
						
						<!-- Data -->
						<table cellpadding="0" cellspacing="0" summary="상담결과 목록입니다.">
						<caption>상담결과</caption>
						<colgroup>
							<col width="30px" />
							<col width="50px" />
							<col width="60px" />
							<col width="70px" />
							<col width="70px" />
							<col width="60px" />
							<col width="px" />
							<col class="col50" />
							<col class="col50" />
							<col class="col50" />
							<col class="col40" />
							<col class="col60" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col">상담<br/>분류</th>
							<th scope="col">장애항목</th>
							<th scope="col">고객사</th>
							<th scope="col">고객명</th>
							<th scope="col">문의내용</th>
							<th scope="col">접수자</th>
							<th scope="col">처리자</th>
							<th scope="col">접수일</th>
							<th scope="col">처리<br/>상태</th>
							<th scope="col">소요시간</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center">
										<!--<c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/>-->
										${result.no}
									</td>
<!--
									<td class="txt_center">
										<c:forEach items="${compnyList}" var="compny" varStatus="c">
											<c:if test="${result.compnyId == compny.code}">${compny.codeDc}</c:if>							      								      				
										</c:forEach>
									</td>
-->
									<td class="txt_center">
										<c:forEach items="${typeList}" var="type" varStatus="c">
											<c:if test="${result.typ == type.code}">${type.codeNm}</c:if>							      								      				
										</c:forEach>
									</td>
									<td class="txt_center">
										<c:forEach items="${conList}" var="type" varStatus="c">
											<c:if test="${result.serviceTyp == type.code}">${type.codeNm}</c:if>							      								      				
										</c:forEach>
									</td>
									<td class="txt_center">
										<c:forEach items="${errorList}" var="err" varStatus="c">
											<c:if test="${result.errorTyp == err.code}">${err.codeNm}</c:if>							      								      				
										</c:forEach>
									</td>
									<td class="pL5" style="text-align:center;">
										<a href="javascript:searchCust('${result.custNm}');" title="${result.custNm}">
										<div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">${result.custNm}</div>
										</a>
									</td>
									<td class="pL5" style="text-align:center;">
										<div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">${result.custManager}</div>
									</td>
									<td class="pL5" style="text-align:center;">
										<a href="${rootPath}/cooperation/selectConsultManage.do?fromResultView=Y&consult_no=${result.consultNo}" title="${result.qCn}">
											<c:if test="${fn:length(result.qCn) > 40}">
												${fn:substring(result.qCn, 0, 40)}...
											</c:if>
											<c:if test="${fn:length(result.qCn) <= 40}">
												${result.qCn}
											</c:if>
											<c:if test="${result.commentCnt > 0}">[${result.commentCnt}]</c:if>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
									<td class="txt_center">
										<div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;" title="${result.comp}">${fn:substring(result.comp, 0, fn:length(result.comp) - 1)}</div>
									</td>
									<td class="txt_center"><print:date date="${result.regDt}" printType="M"/></td>
									<td class="txt_center">
										<c:forEach items="${stateList}" var="state" varStatus="c">
											<c:if test="${result.state == state.code}">${state.codeNm}</c:if>							      								      				
										</c:forEach>
									</td>
									<td class="txt_center">${result.compDuration} 분</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					<!--// 게시판 끝 -->
					<form name="popFrm" method="POST" action="${rootPath}/cooperation/selectSearchCustNmConsultManageList.do">
						<input type="hidden" name="searchCuNm2"/>
					</form>
					<!-- 페이징 시작 -->
					<div class="paginate">
										<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					
					<!-- 하단 바 시작 -->
					<div class="pB10">
						<select class="select01" onchange="selectPageUnit(this.options[this.selectedIndex].value)">
							<option value="15" <c:if test="${paginationInfo.recordCountPerPage==15}">selected="selected"</c:if> >15줄</option>
							<option value="30" <c:if test="${paginationInfo.recordCountPerPage==30}">selected="selected"</c:if> >30줄</option>
							<option value="50" <c:if test="${paginationInfo.recordCountPerPage==50}">selected="selected"</c:if> >50줄</option>
						</select>
						<a href="javascript:excelDown();" class="fr"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>
						<a href="javascript:consultRegister();" class="fr"><img src="${imagePath}/btn/btn_goConsul.gif"/></a>
					</div>
					<!-- 하단 바 끝 -->
				</div>
				<!-- E: section -->
	
				</div>
				<!-- E: center -->
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
