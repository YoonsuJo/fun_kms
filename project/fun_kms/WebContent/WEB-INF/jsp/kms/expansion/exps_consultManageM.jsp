<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="Consult" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">

$(document).ready(function(){
	initSearchBox();
	initContactDt();
	initCompleteDt();
	toggleError($('input[name=service_typ]:checked'));
	
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

//수정 취소 - 고객사관리 뷰 화면으로 이동
function cancelArticle() {
	
	//document.frm.action = "<c:url value='${rootPath}/cooperation/selectConsultManage.do?consult_no=${result.consult_no}'/>";
	//document.frm.submit();		
}

//상담관리 정보 수정
function modifyArticle() {
	// 상담분류에 장애처리가 선택되지 않은 경우, 장애항목 X
	var service_typ = $('input[name=service_typ]:checked').val();
	if (service_typ != 3) $('input[name=error_typ]').val('');
	
	if($('input[name="state"]:checked').val() == '3'){
		if($('input[name="comp"]').val() == ""){
			alert('처리자를 입력해주세요');
			return;
		}
	}
	
	// 연락시한 값 바인드
	chngContactDt();
	
	if (!validateConsult(document.frm)) {
		return;
	}
	
	// ValidEmail
	var email = document.frm.cust_email.value;
	if (email.length > 0) {
		if (!isValidEmail(document.frm.cust_email.value)) {
			alert('유효하지 않은 이메일입니다.');
			return;
		}
	}
	
	if(confirm("수정하시겠습니까?")){
		
		document.frm.action = "<c:url value='${rootPath}/cooperation/updateConsultManage.do'/>";
		document.frm.submit();
	}
			
}

function showArticleList() {
	if ('${commandMap.fromResultView}' == 'Y')
		document.frm.action = "<c:url value='${rootPath}/cooperation/selectConsultManageList.do' />";
	else
		document.frm.action = "<c:url value='${rootPath}/cooperation/selectConsultManageListMine.do' />";
	
	document.frm.submit();
}

//장애항목 보이기
function toggleError(obj){

	var val = $(obj).val();

	if (val == 3)
		$("#error_typ_area").show();
	else
		$("#error_typ_area").hide();
}

//고객사에 따라 고객명, 연락처 셋팅
function putData(){ 
	var obj = $("#custNm > option:selected").val();
	
	if(obj !=""){		
		text = obj.split(",");
		$("#cust_no").val(text[0]);
		$("#cust_manager").val(text[1]);
		$("#cust_telno").val(text[2]);
		//$("#cust_nm)").val(text[3]);
		document.frm.cust_nm.value=text[3];
	}	
}

function fn_egov_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "";
	}
}

function checkSmsYn(obj) {
	if (obj.checked)
		document.getElementById('sms_yn').value = 'Y';
	else
		document.getElementById('sms_yn').value = 'N';
}
function checkIssueYn(obj) {
	if (obj.checked)
		document.getElementById('issue_yn').value = 'Y';
	else
		document.getElementById('issue_yn').value = 'N';
}


//고객 정보 검색
var searchKeyword = null;
var searchAction = null;
var searchState = 0;

function initSearchBox(){
	//return;
	$('input[name=searchCust]').keyup(function(e) {
		
		if (e.which == 38)
		{
			if (0 > searchState - 1)
				return;
			else
				searchState = searchState - 1;
			$('.customerIncludedLi').removeClass('light_on');
			$($('.customerIncludedLi').get(searchState)).addClass('light_on');
		}
		else if (e.which == 40)
		{
			if ($('.customerIncludedLi').length - 1 < searchState + 1)
				return;
			else
				searchState = searchState + 1;
			$('.customerIncludedLi').removeClass('light_on');
			$($('.customerIncludedLi').get(searchState)).addClass('light_on');
		}
		else if (e.which == 13)
		{
			if (searchState == -1) return;
			$('[name=cust_no]').val($('.light_on').find('input[name=customerIncluded_custNo]').val());
			$('input[name=searchCust]').val($('.light_on').find('input[name=customerIncluded_custNm]').val());
			$('input[name=cust_nm]').val($('.light_on').find('input[name=customerIncluded_custNm]').val());
			if ($('#custDiv').length > 0) $('#custDiv').remove();
		}
		else
		{
			searchKeyword = $(this).val();
			if (searchKeyword == "" || searchKeyword == " ") {
				if($('#custDiv').length > 0) $('#custDiv').remove();
				return;
			}
			searchKeyword = encodeURI(searchKeyword);
			$.post("/ajax/consultCompanyList.do?searchCust="+searchKeyword,function(data){
				if($('#custDiv').length > 0) $('#custDiv').remove();
				var size = $(data).find('.customerIncludedLi').size();
				if (size == 0) return;
				var custDiv = '<div id="custDiv" class="Customer_layer"></div>';
				custDiv = $(custDiv);
				custDiv.html(data);
				custDiv.css('top', $('input[name=searchCust]').offset().top + 20);
				custDiv.css('left', $('input[name=searchCust]').offset().left);
				custDiv.css('zIndex', '1');
				custDiv.appendTo('body');
				custDiv.show();

				custDiv.find('li').mouseover(function() {
					$('.customerIncludedLi').removeClass('light_on');
					$(this).addClass('light_on');
				});
				custDiv.find('li').mouseout(function() {
					$('.customerIncludedLi').removeClass('light_on');
					searchState = -1;
				});
				custDiv.find('li').click(function() {
					$('[name=cust_no]').val($('.light_on').find('input[name=customerIncluded_custNo]').val());
					$('input[name=searchCust]').val($('.light_on').find('input[name=customerIncluded_custNm]').val());
					$('input[name=cust_nm]').val($('.light_on').find('input[name=customerIncluded_custNm]').val());
					if ($('#custDiv').length > 0) $('#custDiv').remove();
				});
				$('body').bind('click.custSerach', function(event){
					if (!$(event.target).closest(custDiv).length && event.target !== $('#custDiv').get(0)) {
						$('body').unbind('click.custSerach');
						if ($('#custDiv').length > 0) $('#custDiv').remove();
					}
				});
				
				searchState = -1;
			});
		}
	});
}

//고객사등록 화면 이동
function clientRegister(){
	var popup = window.open("/cooperation/writeClient.do","_POP_CLIENT_","width=580px,height=374px,scrollbars=no");
	popup.focus();
}

//연락시한 초기화
var contactDt;

function initContactDt() {
	// contact_dt 문자열 가공하여 date() 객체 생성 
	tmpDt = '${result.contact_dt}';
	year = tmpDt.substring(0, 4);
	month = tmpDt.substring(5, 7) - 1;
	day = tmpDt.substring(8, 10);
	hour = tmpDt.substring(11, 13);
	minute = tmpDt.substring(14, 16);
	
	contactDt = new Date(year, month, day, hour, minute);
	bindContactDt();
}

// 연락시한 변경(Option> 1:즉시, 2:10분 후, 3:1시간 후, 4:금일 중)
function setContactDt(workType) {
	chngContactDt();
	switch (workType) {
		case 'immediate':
			contactDt = new Date();
			break;
		case '10m':
			contactDt.setMinutes(contactDt.getMinutes() + 10);
			break;
		case '1h':
			contactDt.setHours(contactDt.getHours() + 1);
			break;
		case 'today':
			contactDt = new Date();
			contactDt.setHours(18);
			contactDt.setMinutes(0);
			contactDt.setSeconds(0);
			break;
	}
	bindContactDt();
}

//연락시한 텍스트가 변경될 때, date 객체 변경
function chngContactDt() {
	var date = document.getElementById('contact_date').value;
	date = date.replaceAll('.', '');
	var year = date.substring(0,4);
	var month = date.substring(4,6) - 1;
	var day = date.substring(6,8);
	var hour = document.getElementById('contact_hour').value;
	var minute = document.getElementById('contact_minute').value;
	
	contactDt = new Date(year, month, day, hour, minute);
	bindContactDt();
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

//처리상태 변경 레이어 show/hide
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

// contactDt 객체값 input 태그에 바인드
function bindContactDt() {
	document.getElementById('contact_dt').value = "" + contactDt.format("yyyy.MM.dd HH:mm");
	document.getElementById('contact_date').value = "" + contactDt.format("yyyy.MM.dd");
	document.getElementById('contact_hour').value = "" + contactDt.format("HH");
	document.getElementById('contact_minute').value = "" + contactDt.format("mm");
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
							<li class="stitle">상담내용 수정</li>
							<li class="navi">홈 > 상담관리 > 상담내용 수정</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						
						<!-- 상담관리 게시판 시작  -->
						<form:form commandName="Consult" name="frm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/cooperation/updateConsultManageView.do'/>"/>
						<input type="hidden" name="consult_no" value="${result.consult_no}"/>
						<input type="hidden" name="atch_file_id" value="${result.atch_file_id}"/>
						<input type="hidden" name="cust_no" value="${result.cust_no}" id="cust_no"/>
						<input type="hidden" name="fromResultView" value="${commandMap.fromResultView}" />
						<input type="hidden" name="cust_nm" value="${result.cust_nm}" />
						<c:if test="${result.state ne 3}">
							<input type="hidden" name="state" value="${result.state}"/>
						</c:if>
						<!-- <input type="hidden" name="cust_nm" value="${result.cust_nm}" id="cust_nm"/>  -->
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>상담관리 신규등록</caption>
											
								<colgroup>
									<col class="col100" />
									<col width="px" />
									<col class="col100" />
									<col width="px" />
									<col class="col100" />
									<col width="px" />
								</colgroup>
								<thead>
									<tr>
										<th class="write_info">고객사(*)</th>
										<th class="write_info2" colspan="2">
										<input type="text" name="searchCust" class="span_70p" style="ime-mode:active;" value="${result.cust_nm}"/>
										<a href="javascript:clientRegister();"><img src="${imagePath}/btn/btn_registerCustomer.gif"/></a><!--고객사등록하기  -->
									</th>
										<th class="write_info">접수방법(*)</th>
										<th class="write_info2" colspan="2">
											<ul class="rd_align_25p">
											<c:forEach items="${receiveList}" var="receive" varStatus="c">
												<li><label>
												<input type="radio" name="receive_typ" value="${receive.code}" <c:if test="${result.receive_typ == receive.code}">checked="checked"</c:if> />${receive.codeNm} &nbsp;
												</label></li>
											</c:forEach>
											</ul>
										</th>
									</tr>
									<tr>
										<th class="write_info">고객명</th>
										<th class="write_info2"><input type="text" class="span_90p" name="cust_manager"  id="cust_manager" value="${result.cust_manager}" /></th>
										<th class="write_info">연락처</th>
										<th class="write_info2"><input type="text" class="span_90p" name="cust_telno"  id="cust_telno" value="${result.cust_telno}" /></th>
										<th class="write_info">이메일</th>
										<th class="write_info2"><input type="text" class="span_90p" name="cust_email"  id="cust_email" value="${result.cust_email}" /></th>
									</tr>
									<tr>
										<th class="write_info">열람권한</th>
										<th class="write_info2" colspan="5">
											<input type="text" class="span_90p userNamesAuto userValidateCheck" name="charged" id="charged" value="<c:forEach items="${result.chargedList}" var="char">${char.userNm}(${char.userId}), </c:forEach>"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('charged',0)"/>
											<!-- 
											<input type="hidden" name="sms_yn" id="sms_yn" value="" />
											<input type="checkbox" name="sms" onclick="javascript:checkSmsYn(this);" <c:if test="${result.sms_yn == 'Y'}">disabled="disabled"</c:if> value="Y" <c:if test="${result.sms_yn == 'Y'}">checked="checked"</c:if> >
											SMS 알림
											-->
										</th>
									</tr>
									<tr>
										<th class="write_info">문의내용(*)</th>
										<th class="write_info2" colspan="5"><textarea name="q_cn" class="span_95p height_274">${result.q_cn}</textarea></th>
									</tr>
									<tr>
										<th class="write_info">첨부파일</th>
										<th class="write_info2" colspan="5">
											<c:if test="${not empty result.atch_file_id}">
												<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${result.atch_file_id}" />
												</c:import>
											</c:if>	
											<c:if test="${empty result.atch_file_id || result.atch_file_id == null || result.atch_file_id ==''}">
												<input type="hidden" name="fileListCnt" value="0" />
											</c:if>
											<div id="file_upload_posbl"  style="display:none;" >	
												<input type="file" name="file_1" id="egovComFileUploader" class="write_input"/>
												<div id="egovComFileList"></div>
											</div>
											<div id="file_upload_imposbl"  style="display:none;" >
												<spring:message code="common.imposbl.fileupload" />
											</div>			

											<script type="text/javascript">
											var existFileNum = document.frm.fileListCnt.value;
											var maxFileNum = 3;
											
											if (existFileNum=="undefined" || existFileNum ==null) {
												existFileNum = 0;
											}
											var uploadableFileNum = maxFileNum - existFileNum;
											if (uploadableFileNum<0) {
												uploadableFileNum = 0;
											}
											if (uploadableFileNum != 0) {
												fn_egov_check_file('Y');
												var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum , 'write_input');
												multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
											} else {
												fn_egov_check_file('N');
											}
											</script>
										</th>
									</tr>
									<tr>
										<th class="write_info">연락시한(*)</th>
										<th class="write_info2" colspan="5">
											<input type="hidden" id="contact_dt" name="contact_dt" class="span_6" readonly="true" />
											<input type="text" id="contact_date" name="contact_date" class="input01 span_5 calGen" onchange="javascript:chngContactDt();"/>
											<input type="text" id="contact_hour" name="contact_hour" class="input01 span_1" maxlength="2" 
													onfocus="numGen('contact_hour',0,23,5);" onchange="javascript:chngContactDt();" />시&nbsp;
											<input type="text" id="contact_minute" name="contact_minute" class="input01 span_1" maxlength="2" 
													onfocus="numGen('contact_minute',0,59,5);" onchange="javascript:chngContactDt();" />분&nbsp;
											<input type="button" value="즉시" class="btn_gray" onclick="javascript:setContactDt('immediate');"/>
											<input type="button" value="10분 후" class="btn_gray" onclick="javascript:setContactDt('10m');"/>
											<input type="button" value="1시간 후" class="btn_gray" onclick="javascript:setContactDt('1h');"/>
											<input type="button" value="금일 중" class="btn_gray" onclick="javascript:setContactDt('today');"/>
										</th>
									</tr>
								</thead>
							</table>
						</div>	
						
						<c:if test="${result.state eq 3}">
							<br/>
							<p class="th_stitle">처리내용</p>			
							<div class="boardView">
							
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
														<input type="radio" name="service_typ" value="${con.code}" onclick="javascript:toggleError(this);" <c:if test="${con.code == result.service_typ}">checked="checked"</c:if>/>${con.codeNm} &nbsp;
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
														<input type="radio" name="error_typ" value="${err.code}" <c:if test="${err.code == result.error_typ}">checked="checked"</c:if>/>${err.codeNm}
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
							</div>
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
												<input type="text" id="complete_date" name="complete_date" class="input01 span_5 calGen" onchange="javascript:chngCompleteDt();" value="${result.complete_date}"/>
												<input type="text" id="complete_tm" name="complete_tm" class="input01 span_3" maxlength="2" onchange="javascript:chngCompleteDt();" value="${result.complete_tm}"/> 시
												<br/>
												<input type="button" value="현재" class="btn_gray" onclick="javascript:setCompleteDt('immediate');"/>
												<input type="button" value="1시간 전" class="btn_gray" onclick="javascript:setCompleteDt('before1h');"/>
												<input type="button" value="1시간 후" class="btn_gray" onclick="javascript:setCompleteDt('after1h');"/>
											</td>
										</tr>
										<tr>
											<td class="title">처리 소요 시간</td>
											<td class="pL10">
												<input type="number" id="comp_duration" name="comp_duration" class="input01 span_5" value="${result.comp_duration}"/> 분
											</td>
										</tr>
									</tbody>
								</table>
								</div>
								
								<div class="pop_btn_area">
									<img src="${imagePath}/btn/btn_close.gif" alt="닫기" class="cursorPointer" onclick="javascript:stateLayerHide()">
								</div>
							</div>
						</c:if>				
						
						
						</form:form>
						<!--//상담관리 게시판 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area02">
							<a href="javascript:modifyArticle();"><img src="${imagePath}/btn/btn_regist.gif" alt="등록" /></a><!--등록하기  -->
							<a href="javascript:history.back();"><img src="${imagePath}/btn/btn_cancel.gif" alt="취소" /></a><!--취소하기  -->
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
