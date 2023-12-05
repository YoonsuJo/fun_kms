<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
 
<c:import url="${rootPath}/cooperation/selectConsultCommentList.do">
	<c:param name="type" value="head" />
</c:import>

</head>
<script type="text/javascript">

$(document).ready(function() {
	initCompleteDt();
	
	$('input[name="service_typ"]').change(function(){
		if($('input[name="service_typ"]:checked').val() != '3'){
			$('input[name="error_typ"]').prop('checked', false);
			$('input[name="error_typ"]').attr('disabled', true);
			$('input[name="detail_typ"]').prop('checked', false);
			$('input[name="detail_typ"]').attr('disabled', true);
		}else{
			$('input[name="error_typ"]').attr('disabled', false);
			$('input[name="detail_typ"]').attr('disabled', false);
		}
	});
});

//상담관리 삭제
function deleteArticle() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "<c:url value='${rootPath}/cooperation/deleteBoardArticle.do'/>";
		document.frm.submit();
	}
}

//덧글 등록
function interest() {
	if ("${result.interestYn}" == "Y") {
		document.frm.interestYn.value = "N";
	}
	else {
		document.frm.interestYn.value = "Y";
	}
	document.frm.action = "${rootPath}/cooperation/updateBusinessContactInterest.do";
	document.frm.submit();
}

function copyList(typ, obj) {
	var chared = "<c:forEach items='${result.chargedList}' var='char' varStatus='c'><c:if test='${c.count != 1}'>,</c:if> ${char.userNm}(${char.userId})</c:forEach>";
	var add = "<c:forEach items='${result.addList}' var='add' varStatus='c'><c:if test='${c.count != 1}'>,</c:if> ${add.userNm}(${add.userId})</c:forEach>";
	var data = '';
	
	if(typ == 'char')
		data = chared;
	else if(typ == 'add')
		data = add;

	var sUserAgent = navigator.userAgent;
	var isOpera = sUserAgent.indexOf("Opera") > -1;
	var isIE = sUserAgent.indexOf("compatible") > -1 && sUserAgent.indexOf("MSIE") > -1 && !isOpera;
	if(isIE) {
		window.clipboardData.setData('Text',data);
		var tmp = '담당자';
		if(typ == 'add') tmp = '참조자';
		window.alert(tmp + "가 복사되었습니다.");
	} else {
		if($('.copy_chargedList').length>0)
		{
			$('body').unbind('click.copyLayer');
			$('.copy_chargedList').remove();
		}
		
		var layer = $('<div class="copy_recieveList">' + data + '<br/><p align="right">※ 드래그하여 복사해주세요.</p></div>');
		
		layer.css("left",($(obj).offset().left+20)+"px");
		layer.css("top",($(obj).offset().top+15)+"px");

		layer.css("width", 300);
		
		layer.appendTo('body');

		function copyLayerClickEvent(event){
		if (!$(event.target).closest(layer).length && event.target !== $(obj).get(0)) {
			$('body').unbind('click.copyLayer');
					layer.remove();
			};
		}
		$('body').bind('click.copyLayer', copyLayerClickEvent );
	}
}
/*
function updateState(consultNo) {
	var popup = window.open("/cooperation/updateConsultStateView.do?consult_no=" + consultNo,"_POP_STATE_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}
function updateJira(consultNo) {
	var popup = window.open("/cooperation/updateConsultJiraView.do?consult_no=" + consultNo,"_POP_STATE_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}
*/
function updateRequestId(consultNo) {
	var popup = window.open("/cooperation/updateConsultRequestIdView.do?consult_no=" + consultNo,"_POP_REQUEST_ID_","width=580px,height=260px,scrollbars=yes");
	popup.focus();
}

function deleteRequestId(consultNo) {
	if (confirm('상품관리번호를 삭제하시겠습니까?')) {
		document.frm.action = "<c:url value='${rootPath}/cooperation/deleteConsultRequestId.do'/>";
		document.frm.submit();	
	}
}

function delConsult(){
	
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "<c:url value='${rootPath}/cooperation/deleteConsultManage.do'/>";
		document.frm.submit();	
	}
}
/*
function toggleInfo(obj){
	if($(obj).hasClass('btn_arrow_down')){
		$(obj).removeClass('btn_arrow_down');
		$(obj).addClass('btn_arrow_up');
		$('.toggleInfo').show();
		$(obj).prev().html('간단히');
	}
	else{
		$(obj).removeClass('btn_arrow_up');
		$(obj).addClass('btn_arrow_down');
		$('.toggleInfo').hide();
		$(obj).prev().html('자세히');
	}
}
*/

// 담당자, 수신자 변경 레이어 show/hide
function recieveLayerShow() {
	var position = $("#btn_chng").position();
	var height = $("#btn_chng").height();
	
	$('#RecieverLayer').show();
	document.getElementById("RecieverLayer").style.top = position.top + height + "px";
	document.getElementById("RecieverLayer").style.left = position.left - 400 + "px";
	document.getElementById("RecieverLayer").style.zIndex = "1";
}
function recieveLayerHide() {
	$('#RecieverLayer').hide();
}

function changeRecieve() {
	document.frm.consultView.value = "Y";
	document.frm.action = "${rootPath}/cooperation/changeConsultRecieve.do";
	document.frm.submit();
}
function updateIssue() {	
	document.frm.action = "${rootPath}/cooperation/updateIssue.do";	
	document.frm.submit();	
}

// 처리상태 변경 레이어 show/hide
function toggleStateLayer() {
	//if ('${commandMap.fromResultView}'=='Y') return;
	
	console.log($('#stateLayer').css('display'));
	if ($('#stateLayer').css('display') == 'none')
		stateLayerShow();
	else
		stateLayerHide();
}
function stateLayerShow() {
	var position = $("#stateTh").position();
	var height = $("#stateTh").height();
	
	$('#stateLayer').show();
	document.getElementById("stateLayer").style.top = position.top + height + "px";
	document.getElementById("stateLayer").style.left = position.left + "px";
	document.getElementById("stateLayer").style.zIndex = "1";
}
function stateLayerHide() {
	$('#stateLayer').hide();
}

// 목록보기
function showArticleList() {
	if ('${commandMap.fromResultView}' == 'Y')
		document.frm.action = "<c:url value='${rootPath}/cooperation/selectConsultManageList.do' />";
	else
		document.frm.action = "<c:url value='${rootPath}/cooperation/selectConsultManageListMine.do' />";
	
	document.frm.submit();
}


//처리일시 초기화
var completeDt;

function initCompleteDt() {
	// COMPLETE_DATE, COMPLETE_TM 문자열 가공하여 date() 객체 생성 
	var tmpDate = '${result.complete_date}';
	var tmpTime = '${result.complete_tm}';
	
	if (tmpDate == "") {
		completeDt = new Date();
	} else {
		year = tmpDate.substring(0, 4);
		month = tmpDate.substring(5, 7) - 1;
		day = tmpDate.substring(8, 10);
		hour = tmpTime;
		
		completeDt = new Date(year, month, day, hour);
	}
	
	var complete_date = document.getElementById('complete_date');
	var complete_tm = document.getElementById('complete_tm');
	
	complete_date.value = "" + completeDt.format("yyyy.MM.dd");
	complete_tm.value = "" + completeDt.format("HH");
}

//처리일시 변경(Option> immediate:즉시, before1h:1시간 후, after1h:1시간 후)
function setCompleteDt(workType) {
	switch (workType) {
		case 'immediate':
			completeDt = new Date();
			break;
		case 'before1h':
			completeDt.setHours(completeDt.getHours() - 1);
			break;
		case 'after1h':
			completeDt.setHours(completeDt.getHours() + 1);
			break;
	}
	var complete_date = document.getElementById('complete_date');
	var complete_tm = document.getElementById('complete_tm');
	
	complete_date.value = "" + completeDt.format("yyyy.MM.dd");
	complete_tm.value = "" + completeDt.format("HH");
}

//처리일시 텍스트가 변경될 때, date 객체 변경
function chngCompleteDt() {
	var date = document.getElementById('complete_date').value;
	date = date.replaceAll('.', '');
	var year = date.substring(0,4);
	var month = date.substring(4,6) - 1;
	var day = date.substring(6,8);
	var hour = document.getElementById('complete_tm').value;
	
	completeDt = new Date(year, month, day, hour);

	var complete_date = document.getElementById('complete_date');
	var complete_tm = document.getElementById('complete_tm');
	
	complete_date.value = "" + completeDt.format("yyyy.MM.dd");
	complete_tm.value = "" + completeDt.format("HH");
}

function updateState(){
	if($('input[name="state"]:checked').val() == '3'){
		if($('input[name="comp"]').val() == ""){
			alert('처리자를 입력해주세요');
			return;
		}
	}
	
	if($('input[name="state"]:checked').val() == '3'){
		if(!($('input[name="typ"]:checked').length > 0)){
			alert('구분은 필수 입력값입니다.');
			return;
		}
		if(!($('input[name="service_typ"]:checked').length > 0)){
			alert('상담분류는 필수 입력값입니다.');
			return;
		}
		if($('input[name="service_typ"]:checked').val()=='3'){
			if(!($('input[name="error_typ"]:checked').length > 0)){
				alert('장애항목은 필수 입력값입니다.');
				return;
			}
			if(!($('input[name="detail_typ"]:checked').length > 0)){
				alert('장애항목세부는 필수 입력값입니다.');
				return;
			}
		}
	}
	
	document.frm.action = "<c:url value='${rootPath}/cooperation/updateConsultState.do'/>";
	document.frm.submit();	
}

//고객사 수정 팝업
function clientView(no){
	var popup = window.open("/cooperation/selectClient.do?no="+no,"_POP_CLIENT_","width=580px,height=374px,scrollbars=no");
	popup.focus();
}


</script>
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
							<li class="stitle">상담내용 보기</li>
							<li class="navi">홈 > 상담관리 > 상담내용 보기</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<form name="frm" method="POST" >
						<input type="hidden" name="consultView" />
						<!-- 상담관리 게시판 시작  -->
						<div class="boardView">

							<!-- S: 접수내용 -->
							<p class="th_stitle">접수내용</p>			
							
							<input type="hidden" name="no"/>
							<input type="hidden" name="consult_no" value="${result.consult_no}"/>
							<input type="hidden" name="fromResultView" value="${commandMap.fromResultView}" />
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>상담관리 상세보기</caption>
								<colgroup>
									<col class="col100" />
									<col width="px" />
									<col class="col100" />
									<col class="col100" />
									<col class="col100" />
									<col width="px" />
									<col class="col100" />
									<col width="22%" />
								</colgroup>
								<thead>
									<tr>
										<th class="write_info">상담번호</th>
										<th class="write_info2">${result.cno}</th>
										<th class="write_info">접수자</th>
										<th class="write_info2">${result.user_nm}</th>
										<th class="write_info">접수방법</th>
										<th class="write_info2">
											<c:forEach items="${receiveList}" var="receive" varStatus="c">
											<c:if test="${result.receive_typ == receive.code}">${receive.codeNm}</c:if>
											</c:forEach>
										</th>
										<th class="write_info">접수일시</th>
										<th class="write_info2"><print:date date="${result.reg_dt}" printMin="Y"/></th>
									</tr>
									<tr>
										<th class="write_info">고객사</th>
										<th class="write_info2" colspan="3">
											<a href="javascript:clientView('${result.cust_no}');">${result.cust_nm}</a>
										</th>
										<th class="write_info">연락시한</th>
										<th class="write_info2" colspan="3"><print:date date="${result.contact_dt}" printMin="Y"/> 까지 연락</th>
									</tr>
									<tr>
										<th class="write_info">고객명</th>
										<th class="write_info2" colspan="2">${result.cust_manager}</th>
										<th class="write_info">연락처</th>
										<th class="write_info2" colspan="2">${result.cust_telno}</th>
										<th class="write_info">이메일</th>
										<th class="write_info2"><a href="mailto:${result.cust_email}?subject=${message.subject}&body=${message.body}" id="cust_email">${result.cust_email}</a></th>
									</tr>
									<tr>
										<th class="write_info">열람권한</th>
										<th class="write_info2" colspan="7">
											<c:forEach items="${result.chargedList}" var="char" varStatus="c">
												<c:if test="${c.count != 1}">,</c:if>
												<print:user userNo="${char.userNo}" userNm="${char.userNm}"/>(
													<c:choose>
														<c:when test="${empty char.readtime}"><span class="txt_red">미열람</span></c:when>
														<c:otherwise>${char.readtime } <span class="txt_blue">열람</span></c:otherwise>
													</c:choose>
												)
											</c:forEach>
											<c:if test="${!empty result.chargedList}">
												<img class="cursorPointer" onclick="javascript:copyList('char',this);" src="${imagePath}/btn/btn_receiveCopy.gif" />
											</c:if>
										</th>
									</tr>
									<tr>
										<th class="write_info">문의내용</th>
										<th class="write_info2" colspan="7"><print:textarea text="${result.q_cn}" /></th>
									</tr>
									<tr>
										<th class="write_info">첨부파일</th>
										<th class="write_info2" colspan="7">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atch_file_id}" />
										</c:import>
										</th>
									</tr>
								</thead>
							</table>
							<!-- E: 접수내용 -->

							<br/>

							<c:if test="${result.state eq 3}">
								<p class="th_stitle">처리내용</p>
								
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>처리내용</caption>
									<colgroup>
										<col class="col100" />
										<col width="px" />
									</colgroup>
									<thead>
										<tr>
											<th class="write_info">처리자</th>
											<th id="stateTh" class="write_info2" colspan="5">
												<c:forEach items="${result.compList}" var="comp" varStatus="c">
													<c:if test="${c.count != 1}">,</c:if>
													<print:user userNo="${comp.userNo}" userNm="${comp.userNm}"/>
												</c:forEach>
											</th>
										</tr>
										<tr>
											<th class="write_info">구분</th>
											<th class="write_info2" colspan="5">
												<ul class="rd_align_15p">
													<c:forEach items="${typeList}" var="typ" varStatus="c">
														<c:if test="${result.typ eq typ.code}">${typ.codeNm}</c:if>
													</c:forEach>
												</ul>
											</th>
										</tr>
										<tr>
											<th class="write_info">상담분류</th>
											<th class="write_info2" colspan="5">
												<ul class="rd_align_15p">
													<c:forEach items="${conList}" var="con" varStatus="c">
														<c:if test="${result.service_typ eq con.code}">${con.codeNm}</c:if>
													</c:forEach>
												</ul>
											</th>
										</tr>
										<tr>
											<th class="write_info">장애항목</th>
											<th class="write_info2" colspan="5">
												<ul class="rd_align_15p">
													<c:forEach items="${errorList}" var="error" varStatus="c">
														<c:set var="errList" value="${fn:split(result.error_typ,',')}"/>
														<c:forEach var="err" items="${errList}" varStatus="e">
															<c:if test="${e.count != 1}">,</c:if>
															<c:if test="${error.code eq err}">${error.codeNm}</c:if>
														</c:forEach>
													</c:forEach>
												</ul>
											</th>
										</tr>
										<tr>
											<th class="write_info">장애항목세부</th>
											<th class="write_info2" colspan="5">
												<ul class="rd_align_15p">
													<c:forEach items="${detailList}" var="detail" varStatus="c">
														<c:set var="detList" value="${fn:split(result.detail_typ,',')}"/>
														<c:forEach var="det" items="${detList}" varStatus="d">
															<c:if test="${d.count != 1}">,</c:if>
															<c:if test="${detail.code eq det}">${detail.codeNm}</c:if>
														</c:forEach>
													</c:forEach>
												</ul>
											</th>
										</tr>
										<tr>
											<th class="write_info">조치사항<br/>(상세)</th>
											<th class="write_info2" colspan="5"><print:textarea text="${result.comp_cn}" /></th>
										</tr>
									</thead>
								</table>
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>처리내용</caption>
								<colgroup>
									<col class="col100" />
									<col width="px" />
									<col class="col100" />
									<col width="px" />
								</colgroup>
								<thead>
									<tr>
										<th class="write_info">처리상태</th>
										<th id="stateTh" class="write_info2">
											<c:forEach items="${stateList}" var="state" varStatus="c">
											<c:if test="${result.state == state.code}"><span class="txtB_blue2">${state.codeNm}</span></c:if>
											</c:forEach>
										</th>
										<th class="write_info">처리일시</th>
										<th class="write_info2"><print:date date="${result.complete_date}"/> ${result.complete_tm} <c:if test="${!empty result.complete_date}">시 (${result.comp_duration} 분)</c:if></th>
									</tr>
								</thead>
								</table> 
							</c:if>
							
							
							<c:if test="${result.state ne 3}">
							<!-- S: 처리 내용 -->
							<p class="th_stitle">처리내용</p>			
							
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>처리내용</caption>
								<colgroup>
									<col class="col100" />
									<col width="px" />
								</colgroup>
								<thead>
									<tr>
										<th class="write_info">처리자</th>
										<th id="stateTh" class="write_info2" colspan="5">
											<input type="text" class="span_12 userNamesAuto userValidateCheck" name="comp" id="comp" value="<c:forEach items="${result.compList}" var="char">${char.userNm}(${char.userId}), </c:forEach>"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('comp',0)"/>
										</th>
									</tr>
									<tr>
										<th class="write_info">구분</th>
										<th class="write_info2" colspan="5">
											<ul class="rd_align_15p">
												<c:forEach items="${typeList}" var="typ" varStatus="c">
													<li><label>
														<input type="radio" name="typ" value="${typ.code}" <c:if test="${typ.code == result.typ}">checked="checked"</c:if> />${typ.codeNm} &nbsp;
													</label></li>
												</c:forEach>
											</ul>
										</th>
									</tr>
									<tr>
										<th class="write_info">상담분류</th>
										<th class="write_info2" colspan="5">
											<ul class="rd_align_15p">
												<c:forEach items="${conList}" var="con" varStatus="c">
													<li><label>
														<input type="radio" name="service_typ" value="${con.code}" <c:if test="${con.code == result.service_typ}">checked="checked"</c:if> onclick="javascript:toggleError(this);" />${con.codeNm} &nbsp;
													</label></li>
												</c:forEach>
											</ul>
										</th>
									</tr>
									<tr>
										<th class="write_info">장애항목</th>
										<th class="write_info2" colspan="5">
											<ul class="rd_align_15p">
												<c:forEach items="${errorList}" var="err" varStatus="c">
													<li style="width:12%"><label>
														<input type="radio" name="error_typ" value="${err.code}" <c:if test="${err.code == result.error_typ}">checked="checked"</c:if> />${err.codeNm}
													</label></li>
												</c:forEach>
											</ul>
										</th>
									</tr>
									<tr>
										<th class="write_info">장애항목세부</th>
										<th class="write_info2" colspan="5">
											<ul class="rd_align_15p">
												<c:forEach items="${detailList}" var="detail" varStatus="c">
													<li style="width:12%"><label>
														<input type="radio" name="detail_typ" value="${detail.code}" <c:if test="${detail.code == result.detail_typ}">checked="checked"</c:if> />${detail.codeNm}
													</label></li>
												</c:forEach>
											</ul>
										</th>
									</tr>
								</thead>
							</table>
							
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>댓글달기</caption>
								<colgroup>
									<col class="col100"/>
									<col width="px"/>
								</colgroup>
								<thead>
									<tr>
										<th class="write_info">
											조치사항<br/>(상세)
										</th>
										<th class="write_info2 pL10 pT5 pB5">
											<textarea name="comp_cn" class="textarea height_70" cols="50" rows="6">${result.comp_cn}</textarea>
										</th>
									</tr>

								</thead>
							</table>
							
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>처리내용</caption>
								<colgroup>
									<col class="col100" />
									<col width="px" />
									<col class="col100" />
									<col width="px" />
								</colgroup>
								<thead>
									<tr>
										<th class="write_info">처리상태</th>
										<th id="stateTh" class="write_info2">
											<a href="javascript:toggleStateLayer()">
												<c:forEach items="${stateList}" var="state" varStatus="c">
												<c:if test="${result.state == state.code}"><span class="txtB_blue2">${state.codeNm}</span></c:if>
												</c:forEach>
											</a>
										</th>
										<th class="write_info">처리일시</th>
										<th class="write_info2"><print:date date="${result.complete_date}"/> ${result.complete_tm} <c:if test="${!empty result.complete_date}">시 (${result.comp_duration} 분)</c:if></th>
									</tr>
								</thead>
							</table>
							</c:if>

							<!-- 수신자 변경 레이어  -->
							<input name="userNo" type="hidden" value="${result.userNo}" />
							<div id="RecieverLayer" class="Receiver_layer" style="display:none;">
								<dl>
									<dt>담당자 변경</dt>
									<dd>
										<div class="boardWrite02 mB10">
											<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
											<caption>담당자 변경</caption>
											<colgroup><col class="col100" /><col width="px" /></colgroup>
											<tbody>
												<tr>
													<td class="title">담당자</td>
													<td class="pL10">
														<input type="text" class="span_13 userNamesAuto userValidateCheck" name="chargedUserIdMix" id="recUserMixes"
															value="<c:forEach items='${result.chargedList}' var='chr'>${chr.userNm}(${chr.userId}), </c:forEach>" />
														<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recUserMixes',0)"/>
													</td>
												</tr>
												<!--
												<tr>
													<td class="title">참조자</td>
													<td class="pL10">
														<input type="text" class="span_13 userNamesAuto userValidateCheck" name="addUserIdMix" id="refUserMixes"
															value="<c:forEach items='${result.addList}' var='add'>${add.userNm}(${add.userId}), </c:forEach>" />
														<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('refUserMixes',0)" />
													</td>
												</tr>
												-->
											</tbody>
											</table>
										</div>
										<div class="btn_area">
												<a href="javascript:changeRecieve();"><img src="${imagePath}/btn/btn_apply.gif"/></a>
												<a href="javascript:recieveLayerHide();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
										</div>
									</dd>
								</dl>
							</div>
							<!--// 수신자 변경 레이어 끝  -->


							<!-- 처리상태 변경 레이어  -->
							<div id="stateLayer" class="state_layer" style="display:none;">
								<p><span class="txtB_Black">※ 처리결과 등록</span></p>
								<div class="boardWrite02 mB20">
								 
								<table cellpadding="0" cellspacing="0">
									<colgroup><col class="col100" /><col width="px"/></colgroup>
									<tbody>
										<tr>
											<td class="title" >처리상태</td>
											<td class="pL10">
												<label><input type="radio" name="state" value="3" checked="checked" />완료 &nbsp;</label>
												<label><input type="radio" name="state" value="2" />처리중 &nbsp;</label>
											</td>
										</tr>
										<tr>
											<td class="title" >처리일시</td>
											<td class="pL10">
												<input type="text" id="complete_date" name="complete_date" class="input01 span_5 calGen" onchange="javascript:chngCompleteDt();"/>
												<input type="text" id="complete_tm" name="complete_tm" class="input01 span_3" maxlength="2" onchange="javascript:chngCompleteDt();" /> 시
												<br/>
												<input type="button" value="현재" class="btn_gray" onclick="javascript:setCompleteDt('immediate');"/>
												<input type="button" value="1시간 전" class="btn_gray" onclick="javascript:setCompleteDt('before1h');"/>
												<input type="button" value="1시간 후" class="btn_gray" onclick="javascript:setCompleteDt('after1h');"/>
											</td>
										</tr>
										<tr>
											<td class="title">처리 소요 시간</td>
											<td class="pL10">
												<input type="number" id="comp_duration" name="comp_duration" value="${result.comp_duration}" class="input01 span_5"/> 분
											</td>
										</tr>
									</tbody>
								</table>
								</div>
								
								<div class="pop_btn_area">
									<img src="${imagePath}/btn/btn_regist.gif" alt="등록" class="cursorPointer" onclick="javascript:updateState()"/>
									<img src="${imagePath}/btn/btn_cancel.gif" alt="취소" class="cursorPointer" onclick="javascript:stateLayerHide()">
								</div>
							</div>
							<!--// 처리상태 변경 레이어  -->
							
							
						</div>				
							
						</form>
						<!-- 덧글입력부분 임포트S -->
						<div id="commentArea">
							<c:import url="${rootPath}/cooperation/selectConsultCommentList.do">							
								<c:param name="type" value="body" />
								<c:param name="commentNo" value="${result.no}" />
							</c:import>
						</div>
								<!-- 덧글입력부분 임포트E -->
						<!--//상담관리 게시판 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area02">
							<!-- <a href="javascript:updateState('${result.consult_no}')"><img src="${imagePath}/btn/btn_statusModify.gif" alt="처리상태변경" /></a> -->
							<c:set var="isMod" value="false" />
							<c:forEach items="${result.chargedList}" var="char" varStatus="c">
								<c:if test="${user.no == char.userNo}">
									<a href="${rootPath}/cooperation/updateConsultManageView.do?fromResultView=${commandMap.fromResultView}&consult_no=${result.consult_no}"><img src="${imagePath}/btn/btn_modify.gif" alt="수정" /></a>
									<c:set var="isMod" value="true" />
								</c:if>
							</c:forEach>
							<c:if test="${!isMod}">
								<c:if test="${user.no == result.userNo || user.admin}">
									<a href="${rootPath}/cooperation/updateConsultManageView.do?fromResultView=${commandMap.fromResultView}&consult_no=${result.consult_no}"><img src="${imagePath}/btn/btn_modify.gif" alt="수정" /></a>
								</c:if>
							</c:if>
							<c:if test="${user.no == result.userNo || user.admin }">
								<a href="javascript:delConsult();"><img src="${imagePath}/btn/btn_delete.gif" alt="삭제" /></a>
							</c:if>
							
							<!-- 담당자 권한 확인 -->
							<c:set var="isAdmin" value="false" />
							<c:forEach items="${result.chargedList}" var="char" varStatus="c">
								<c:if test="${char.userNo == user.no}">
									<c:set var="isAdmin" value="true" />
								</c:if>
							</c:forEach>
							
							<c:if test="${user.no == result.userNo || user.admin || isAdmin  || user.isConsultadmin=='Y'}">
							<a href="javascript:recieveLayerShow();"><img id="btn_chng" src="${imagePath}/btn/btn_change.gif"/></a>
							</c:if>
							<a href="javascript:showArticleList();"><img src="${imagePath}/btn/btn_list.gif" alt="목록" /></a><!--목록보기  -->
						</div>
						<!-- 버튼 끝 -->
	
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
