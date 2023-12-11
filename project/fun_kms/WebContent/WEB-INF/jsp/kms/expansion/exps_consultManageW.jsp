<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="Consult" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
$(document).ready(function() {
	custNmAutoComplete();
	initSearchBox();
	initContactDt();
	initCompleteDt();
	
	$('input[name="state"]').change(function(){
		if($('input[name="state"]:checked').val() == '3'){
			$('#complete').show();
		}else{
			$('#complete').hide();	
		}
	});
	
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
	if(confirm('입력한 내용이 초기화 됩니다.')) {
		document.frm.action = "<c:url value='${rootPath}/cooperation/writeConsultManage.do'/>";
		document.frm.submit();
	}
}

//상담관리 정보 인서트
function insertArticle() {

	// 상담분류에 장애처리가 선택되지 않은 경우, 장애항목 X
	var service_typ = $('input[name=service_typ]:checked').val();
	if (service_typ != 3) $('input[name=error_typ]').val('');
	
	// 연락시한 값 바인드
	chngContactDt();

	$("input[name=cust_nm]").val($("input[name=searchCust]").val());
	
	// 빠른선택 + 추가 문자열 합치기.
	var chargeList = $('input[name=quickCharged]:checked');
	var chargeArr = "";
	for (var i=0; i<chargeList.length; i++) {
		chargeArr += chargeList[i].value + ",";
	}
	$('#charged').val(chargeArr + $('#charged').val());
	//$('#charged').val($('#quickCharged').val() + $('#charged').val());
	
	var compList = $('input[name=quickComp]:checked');
	var compArr = "";
	for(var i=0;i<compList.length;i++){
		compArr += compList[i].value + ",";
	}
	$('#comp').val(compArr + $('#comp').val());
	
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
	
	// ValidEmail
	var email = document.frm.cust_email.value;
	if (email.length > 0) {
		if (!isValidEmail(document.frm.cust_email.value)) {
			alert('유효하지 않은 이메일입니다.');
			return;
		}
	}
	
	if(confirm("등록하시겠습니까?")){
		document.frm.action = "<c:url value='${rootPath}/cooperation/insertConsultManage.do'/>";
		document.frm.submit();
	}
}

//장애항목 보이기
function toggleError(obj){

	var val = $(obj).val();
	
	if (val == 3) {
		$("#error_typ_area").show();
	}
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

var searchKeyword = null;
var searchAction = null;

function custNmAutoComplete(){

	var custDiv = null;
	var searchTyp = '';
	
	$('#companyListAuto').click(function() {
		popCustSearch();
	});

	function popCustSearch() {

		if (custDiv != null) {
			custDiv.dialog('destroy');
			custDiv.remove();
		}

		custDiv = $('<div id="_custDiv">'+
				'<div class="ui_layer customer">'+
				'	<dl>'+
				'		<dd>검색어 : <input type="text" name="custSearchKeyword"/></dd>'+
				'	</dl>'+
				'	<div class="ui_List" style="height:490px;">'+
				'	</div>'+
				'</div>'+
			'</div>');
		
		custDiv.appendTo('body');
		var position = $('#companyListAuto').offset();
		// custDiv.css("left",(position.left - 20)+"px");
		// custDiv.css("top",(position.top - 5)+"px");
		// custDiv.css("position","absolute");

		$('[name=custSearchKeyword]').keyup(function(){

			searchKeyword = this.value;
			//prjIdObj.data("searchKeyword",searchKeyword);
			if(searchAction)
			{
				clearTimeout( searchAction );
				}
			searchAction = setTimeout(customerIncluded,300);
		});

		var width = custDiv.find(".ui_layer").css("width");
		width = parseInt(width.substr(0, width.indexOf("px"))) + 8;
		custDiv.dialog({
			width : width
			,height : 570
			,closeOnEscape: true 
			,resizable: true 
			,draggable: true
			,autoOpen: true 		
			,position : [(position.left - 20), (position.top - 5)]   
		});
	}
	
	function customerIncluded(){

		if (searchKeyword == "") {
			return;
		}
		searchKeyword = encodeURI(searchKeyword);
		//alert(searchKeyword);
		$.post("/ajax/consultCompanyList.do?searchCust="+searchKeyword,function(data){

			var size = $(data).find('.customerIncludedLi').size();
			if (size == 0) {
				return;
			}
			
			custDiv.find('.ui_List').html(data);
			
			//selectedPrjId = prjIdObj.val();
			//if(selectedPrjId!="")
			//	$('.prjUserIncludedLi input[name=prjUserIncluded_prjId][value='+selectedPrjId +']').parent().addClass('txtB_blue2');
			
			$('body').bind('click.customer', function custLayerClickEvent(event){
				if (!$(event.target).closest(custDiv).length) {
					custDiv.hide();
					$('body').unbind('click.customer');
					};
				}
			);

			$('.customerIncludedLi').click(function(){
				$('[name=cust_no]').val($(this).find('[name=customerIncluded_custNo]').val());

				$('input[name=searchCust]').val($(this).find('[name=customerIncluded_custNm]').val());
				$('input[name=cust_nm]').val($(this).find('[name=customerIncluded_custNm]').val());
				//$("#custNm > option[value=($(this).find('[name=customerIncluded_custNm]').val())").attr("selected","true");
				//$('[name=custNm]').val($(this).find('[name=customerIncluded_custNm]').val());
				$('[name=cust_manager]').val($(this).find('[name=customerIncluded_custManager]').val());
				$('[name=cust_telno]').val($(this).find('[name=customerIncluded_custTelno]').val());
				$('[name=cust_email]').val($(this).find('[name=customerIncluded_custEmail]').val());

				if(typeof callback!= "undefined")
				{
					callback.call(this,prjNmObj, prjIdObj);
				}
				custDiv.dialog('destroy');
				custDiv.remove();
				$('body').unbind('click.customer');
			});
		});
	};
}

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


// 연락시한 초기화
var contactDt = new Date();

function initContactDt() {
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

// 연락시한 텍스트가 변경될 때, date 객체 변경
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

// contactDt 객체값 input 태그에 바인드
function bindContactDt() {
	document.getElementById('contact_dt').value = "" + contactDt.format("yyyy.MM.dd HH:mm");
	document.getElementById('contact_date').value = "" + contactDt.format("yyyy.MM.dd");
	document.getElementById('contact_hour').value = "" + contactDt.format("HH");
	document.getElementById('contact_minute').value = "" + contactDt.format("mm");
}

//고객사등록 화면 이동
function clientRegister(){
	var popup = window.open("/cooperation/writeClient.do?directConsult=Y","_POP_CLIENT_","width=580px,height=374px,scrollbars=no");
	popup.focus();
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
							<li class="stitle">상담접수</li>
							<li class="navi">홈 > 상담관리 > 상담접수</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						
						<p><span class="th_stitle">접수 내용 </span><span> (*) 표시는 필수입력 항목입니다.</span></p> 
						
						<!-- 상담관리 게시판 시작  -->
						<form:form commandName="Consult" name="frm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="no"/>
						<input type="hidden" name="cust_no" id="cust_no" />
						<input type="hidden" name="cust_nm" id="cust_nm" />
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
										<input type="text" name="searchCust" class="span_70p" style="ime-mode:active;"/>
										<a href="javascript:clientRegister();"><img src="${imagePath}/btn/btn_registerCustomer.gif"/></a><!--고객사등록하기  -->
									</th>
									<th class="write_info">접수방법(*)</th>
									<th class="write_info2" colspan="2">
										<ul class="rd_align_25p">
										<c:forEach items="${receiveList}" var="receive" varStatus="c">
											<li><label>
											<input type="radio" name="receive_typ" value="${receive.code}" <c:if test="${c.count==1}">checked="checked"</c:if> />${receive.codeNm}
											</label></li>
										</c:forEach>
										</ul>
									</th>
								</tr>
								<tr>
									<th class="write_info">고객명</th>
									<th class="write_info2"><input type="text" class="span_90p" name="cust_manager"  id="cust_manager" value="${result.custManager}" /></th>
									<th class="write_info">연락처</th>
									<th class="write_info2"><input type="text" class="span_90p" name="cust_telno"  id="cust_telno" value="${result.custTelno}" /></th>
									<th class="write_info">이메일</th>
									<th class="write_info2"><input type="text" class="span_90p" name="cust_email"  id="cust_email" value="${result.custEmail}" /></th>
								</tr>
								<tr>
									<th class="write_info">열람권한</th>
									<th class="write_info2" colspan="5">
										<div>
										빠른선택 :
										<c:forEach items="${chargedList}" var="charged" varStatus="c">
											<label><input type="checkbox" name="quickCharged" value="${charged.userNm}(${charged.userId})" checked/> ${charged.userNm} &nbsp;</label>
										</c:forEach>
										<span class="fr">※ 기본 담당자 변경은 한마음 관리자에게 문의하세요.</span>
			                    		</div>
			                    		추&nbsp;&nbsp;&nbsp;&nbsp;가 :
										<input type="text" class="span_12 userNamesAuto userValidateCheck" name="charged" id="charged" value=""/>
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('charged',0)"/>
										
										<label>
										<input type="checkbox" name="push_yn" value="Y"> Push 알림
										</label>
									</th>
								</tr>
								<tr>
									<th class="write_info">문의내용(*)</th>
									<th class="write_info2" colspan="5"><textarea name="q_cn" class="span_95p height_170"></textarea></th>
								</tr>
								<tr>
									<th class="write_info">첨부파일</th>
									<th class="write_info2" colspan="5">
										<input name="file_1" id="egovComFileUploader" type="file" name="atch_file_id" class="write_input07"/>
										<div id="egovComFileList"></div>
										<script type="text/javascript">
											var maxFileNum = 3;
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum , 'write_input');
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										</script>
									</th>
								</tr>
								<tr>
									<th class="write_info">처리상태(*)</th>
									<th class="write_info2" colspan="5">
										<label><input type="radio" name="state" value="1" checked="checked" />접수 &nbsp;</label>
										<label><input type="radio" name="state" value="3"  />완료 &nbsp;</label>
									</th>
								</tr>
								<tr>
									<th class="write_info">연락시한(*)</th>
									<th class="write_info2" colspan="5">
										<input type="hidden" id="contact_dt" name="contact_dt" class="span_6" readonly="true" />
										<input type="text" id="contact_date" name="contact_date" class="input01 span_5 calGen" onchange="javascript:chngContactDt();" />
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
						
						<!-- S: 처리 내용 -->
						<div id="complete" style="display:none;" class="mT10">
							<p class="th_stitle mB10">처리내용</p>			
							
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
											<input type="text" class="span_12 userNamesAuto userValidateCheck" name="comp" id="comp" value=""/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('comp',0)"/>
										</th>
									</tr>
									<tr>
										<th class="write_info">구분</th>
										<th class="write_info2" colspan="5">
											<ul class="rd_align_15p">
												<c:forEach items="${typeList}" var="typ" varStatus="c">
													<li><label>
														<input type="radio" name="typ" value="${typ.code}" />${typ.codeNm} &nbsp;
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
														<input type="radio" name="service_typ" value="${con.code}" onclick="javascript:toggleError(this);" />${con.codeNm} &nbsp;
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
														<input type="radio" name="error_typ" value="${err.code}" />${err.codeNm}
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
														<input type="radio" name="detail_typ" value="${detail.code}" />${detail.codeNm}
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
											<textarea name="comp_cn" class="textarea height_70" cols="50" rows="6" value=''></textarea>
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
											<a href="javascript:toggleStateLayer()"><span class="txtB_blue2">완료</span></a>
										</th>
										<th class="write_info">처리일시</th>
										<th class="write_info2"><print:date date="${result.complete_date}"/> ${result.complete_tm} <c:if test="${!empty result.complete_date}">시</c:if></th>
									</tr>
								</thead>
							</table>
						</div>
							
						</div>			
						
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
												<label><input type="radio"checked="checked" />완료 &nbsp;</label>
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
												<input type="number" id="comp_duration" name="comp_duration" class="input01 span_5" value="0"/> 분
											</td>
										</tr>
									</tbody>
								</table>
								</div>
								
								<div class="pop_btn_area">
									<img src="${imagePath}/btn/btn_close.gif" alt="닫기" class="cursorPointer" onclick="javascript:stateLayerHide()">
								</div>
							</div>
							<!--// 처리상태 변경 레이어  -->								
						
						</form:form>
						<!--//상담관리 게시판 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area02">		                	
							<a href="javascript:insertArticle()"><img src="${imagePath}/btn/btn_regist.gif"/></a><!--등록하기  -->
							<a href="javascript:cancelArticle();"><img src="${imagePath}/btn/btn_cancel.gif"/></a><!--취소하기  -->
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
