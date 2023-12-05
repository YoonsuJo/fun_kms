<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<style type="text/css" rel="stylesheet">
.subDiv { padding-bottom:15px; }
</style>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="prjReg" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
var prntStDt = '${mapDate.prntStDt}';
var childStDt = '${mapDate.childStDt}';
var prntCompDueDt = '${mapDate.prntCompDueDt}';
var childCompDueDt = '${mapDate.childCompDueDt}';

var mode = "${mode}";
$(document).ready(function(){
	var stat ="${projectVO.stat}";
	var form = 	$('#projectVO');
	
	$('#prjInsertB').click(function(){
		if (!validatePrjReg(document.projectVO)) {
			return false;
		}
		
		if (!startDateCheck()) {
			return false;
		}
		
		if (!endDateCheck()) {
			return false;
		}
		
		// 20140725, 프로젝트 구분 유효성검사 추가
		var prjType = $('input[name=prjType]:checked').val();
		if (typeof prjType == 'undefined') {
			alert('프로젝트 구분이 입력되지 않았습니다.');
			return false;
		} else if (prjType == 'E') {
			if ($('input[name=dayReportRule]:checked').val() != 'N') {
				$('#dayReportRule3').click();
			}
			if ($('input[name=manageCostRule]:checked').val() != 'N') {
				$('#manageCostRule3').click();
			}
		}
		
		if ("${projectVO.type}" == 'M' && mode == 'W') {
			if ("${user.admin}" != "true" && "${user.isProjectadmin}" != "Y") {
				alert("권한이 없습니다.");
				history.back(-1);
				return false;
			}
		} else {
			// ToDo : admin 또는 상위프로젝트리더만 생성 가능하도록
			//if ("${user.admin || projectVO.leaderNo == user.no}" != "true")
			//{
			//	alert("권한이 없습니다 .");
			//	history.back(-1);
			//	return false;
			//}
		}

		if(mode=="W")
			form.attr("action", "/cooperation/insertProject.do");
		else {
			form.attr("action", "/cooperation/updateProject.do");
			if(	stat != form.find("input[name=stat]:checked").val()) {
				if(!confirm("상태 변경시 하위 프로젝트 및 상위 프로젝트 상태에 영향을 끼칩니다. 계속 하시겠습니까?"))
					return;
			}
		}
		form.submit();
	});
	
	$('#prjCancleB').click(function(){
		history.back(-1);
	});
	$('#orgnztTreeB, #orgnztNm').click(function(){
		if(mode=='W')
			orgGen('orgnztNm','orgnztId',1);
	});
	$('#userTreeB').click(function(){
		usrGen('leaderMix',1);
	});

	// 프로젝트 구분(메인/서브) 변경시, 이벤트 적용
	$('[name=type]').change(function(){
		if (mode==='W')	// 수정모드일 때는 프로젝트 구분, 상위 프로젝트, 주관부서 등의 정보는 변경할 수 없다.
			setPrjType();
	});

	// 프로젝트 구분(경영/영업/사업/수행) 변경시, 이벤트 적용
	var dayReportRule = $('input[name=dayReportRule]:checked').val();
	var manageCostRule = $('input[name=manageCostRule]:checked').val();
	$('[name=prjType]').change(function(){
		var v = $('input[name=prjType]:checked').val();
		if(v == 'B' || v == 'S'){ // 사업,영업			
			$('#divSales').show();
		} else {	// 나머지
			$('#divSales').hide();
		}
		
		if(v == 'E'){ // 프로젝트 폴더 		
			//dayReportRule = $('input[name=dayReportRule]:checked').val();
			//manageCostRule = $('input[name=manageCostRule]:checked').val();
			$('#dayReportRule3').click();
			$('#manageCostRule3').click();
		} else {	// 나머지
			$('input[name=dayReportRule][value='+dayReportRule+']').click();
			$('input[name=manageCostRule][value='+manageCostRule+']').click();
		}
	});

	$('[name=dayReportRule]').change(function(){
		if ($('input[name=prjType]:checked').val() == 'E' && $(this).val() == 'N')
			return false;
		dayReportRule = $(this).val();
	});
	
	$('[name=manageCostRule]').change(function(){
		if ($('input[name=prjType]:checked').val() == 'E' && $(this).val() == 'N')
			return false;
		manageCostRule = $(this).val();
	});
	
	//프로젝트 진행상태 변경시 채권관리 상태 변경 (20141224_안태규부장님 요청으로 운영자만 채권관리를 수정할 수 있도록 변경)
	$('[name=stat]').change(function(){			
		var v = $('input[name=stat]:checked').val();
		if(v == 'E'){ //종료			
			//$('input:radio[name=bondYn]:input[value=N]').attr("checked", true);
		} else if(v == 'P'){//진행			
			$('input:radio[name=bondYn]:input[value=Y]').attr("checked", true);
		}
	});

	//시작일 변경시 유효성 검사
	function startDateCheck() {
		var v = $('input[name=stDt]').val();
		
		if (prntStDt != "") {
			if (prntStDt > v) {
				alert('상위 프로젝트의 시작일 이전으로 설정할 수 없습니다.');
				$('input[name=stDt]').val(prntStDt);
				return false;
			}
		} else if (childStDt != "") {
			if (childStDt < v) {
				alert('하위 프로젝트의 시작일 이후로 설정할 수 없습니다.');
				$('input[name=stDt]').val(childStDt);
				return false;
			}
		}
		
		return true;
	}
	
	//종료일 변경시 유효성 검사
	function endDateCheck() {		
		var v = $('input[name=compDueDt]').val();
		
		if (prntCompDueDt != "") {
			if (prntCompDueDt < v) {
				alert('상위 프로젝트의 종료일 이후로 설정할 수 없습니다.');
				$('input[name=compDueDt]').val(prntCompDueDt);
				return false;
			}
		} else if (childCompDueDt != "") {
			if (childCompDueDt > v) {
				alert('하위 프로젝트의 종료일 이전으로 설정할 수 없습니다.');
				$('input[name=compDueDt]').val(childCompDueDt);
				return false;
			}
		}
		
		return true;
	}
	
	// 운영자 권한이 없을 경우 채권관리 상태를 변경할 수 없도록 수정(20141224, 안태규 부장님 요청)
	if ('${user.admin}'!="true") {
		$('input:radio[name=bondYn]').attr("disabled", true);
	}
	
	//토글 버튼 활성화
	$('.toggleB').click(function(){
		if($(this).hasClass('btn_arrow_down')){
			$(this).removeClass('btn_arrow_down');
			$(this).addClass('btn_arrow_up');
			$(this).closest('p').next().show();
		} else {
			$(this).removeClass('btn_arrow_up');
			$(this).addClass('btn_arrow_down');
			$(this).closest('p').next().hide();
		}
	});
	$('.toggleB').click();
	
	initSearchBox();	// 고객사 검색, 이벤트 정의
	setPrjType();
	
	// Default 값 할당
	if ('${projectVO.leaderMix}'=='') {
		$('#leaderMix').val('${user.userNm}(${user.userId})');
	}
	var today = new Date();
	if ('${projectVO.stDt}'=='') {
		$('#stDt').val(today.format("yyyyMMdd"));
	}
	/*
	if ('${projectVO.compDueDt}'=='') {
		$('#compDueDt').val(today.format("yyyyMMdd"));
	}
	*/
});

var searchState = 0;
function initSearchBox(){
	//return;
	$('input[name=custNm]').keyup(function(e) {
		
		if (e.which == 38)	// 방향키 위로
		{
			if (0 > searchState - 1)
				return;
			else
				searchState = searchState - 1;
			$('.customerIncludedLi').removeClass('light_on');
			$($('.customerIncludedLi').get(searchState)).addClass('light_on');
		}
		else if (e.which == 40)	// 방향키 아래로
		{
			if ($('.customerIncludedLi').length - 1 < searchState + 1)
				return;
			else
				searchState = searchState + 1;
			$('.customerIncludedLi').removeClass('light_on');
			$($('.customerIncludedLi').get(searchState)).addClass('light_on');
		}
		else if (e.which == 13)	// Enter 키
		{
			if (searchState == -1) return;
			$('input[name=custId]').val($('.light_on').find('input[name=customerIncluded_custId]').val());
			$('input[name=custNm]').val($('.light_on').find('input[name=customerIncluded_custNm]').val());
			if ($('#custDiv').length > 0) $('#custDiv').remove();
		}
		else
		{
			searchKeyword = $(this).val();
			if (searchKeyword == "" || searchKeyword == " ") {
				if($('#custDiv').length > 0) $('#custDiv').remove();
				$('input[name=custId]').val('');
				return;
			}
			searchKeyword = encodeURI(searchKeyword);
			$.post("/ajax/selectCustomerList.do?searchKeyword="+searchKeyword,function(data){
				if($('#custDiv').length > 0) $('#custDiv').remove();
				var size = $(data).find('.customerIncludedLi').size();
				if (size == 0) return;
				var custDiv = '<div id="custDiv" class="Customer_layer"></div>';
				custDiv = $(custDiv);
				custDiv.html(data);
				custDiv.css('top', $('input[name=custNm]').offset().top + 20);
				custDiv.css('left', $('input[name=custNm]').offset().left);
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
					$('input[name=custId]').val($('.light_on').find('input[name=customerIncluded_custId]').val());
					$('input[name=custNm]').val($('.light_on').find('input[name=customerIncluded_custNm]').val());
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

// 상위 프로젝트 선택 레이어 생성
function prntPrjGen() {
	$.post("/ajax/selectPrntPrjList.do",function(data){
		if($('#prntPrjDiv').length > 0) $('#prntPrjDiv').remove();
		var size = $(data).find('.prntPrjIncludedLi').size();
		if (size == 0) return;
		var prntPrjDiv = '<div id="prntPrjDiv" class="Customer_layer"></div>';
		prntPrjDiv = $(prntPrjDiv);
		prntPrjDiv.html(data);
		prntPrjDiv.css('top', $('#lblPrntPrj').offset().top + 20);
		prntPrjDiv.css('left', $('#lblPrntPrj').offset().left);
		prntPrjDiv.css('zIndex', '1');
		prntPrjDiv.css('position', 'absolute');
		prntPrjDiv.appendTo('body');
		prntPrjDiv.show();

		prntPrjDiv.find('li').mouseover(function() {
			$('.prntPrjIncludedLi').removeClass('light_on');
			$(this).addClass('light_on');
		});
		prntPrjDiv.find('li').mouseout(function() {
			$('.prntPrjIncludedLi').removeClass('light_on');
		});
		prntPrjDiv.find('li').click(function() {
			$('input[name=prntPrjId]').val($('.light_on').find('input[name=prntPrjIncluded_prjId]').val());
			var prntPrjNm = '[' + $('.light_on').find('input[name=prntPrjIncluded_prjCd]').val() + ']'
							+ $('.light_on').find('input[name=prntPrjIncluded_prjNm]').val()
			$('#lblPrntPrj').html(prntPrjNm);
			prntStDt = $('.light_on').find('input[name=prntPrjIncluded_prntStDt]').val();
			childStDt = $('.light_on').find('input[name=prntPrjIncluded_childStDt]').val()
			prntCompDueDt = $('.light_on').find('input[name=prntPrjIncluded_prntCompDueDt]').val()
			childCompDueDt = $('.light_on').find('input[name=prntPrjIncluded_childCompDueDt]').val()
			if ($('#prntPrjDiv').length > 0) $('#prntPrjDiv').remove();
			$('#rdoSub').attr('checked', true);
		});
		
		$('#searchPrntPrjNm').focus();
		
		$('#searchPrntPrjNm').keyup(function(e) {
			var keyword = $(this).val();
			$('.prntPrjIncludedLi').hide();
			$('.prntPrjIncludedLi').find('input[name=prntPrjIncluded_prjNm][value*='+keyword+']').parent().show();
		});
		
		$('#btnClose').click(function() {
			if ($('#prntPrjDiv').length > 0) $('#prntPrjDiv').remove();
		});
	});
}

function delPrntPrj() {
	$('#lblPrntPrj').html('-');
	$('input[name=prntPrjId]').val('');
	$('#rdoMain').attr('checked', true);
}

var prePrntPrjId = '${projectVO.prntPrjId}';
var prePrntPrjNm = '${projectVO.prntPrjNm}';
var preOrgnztId = '${projectVO.orgnztId}';
var preOrgnztNm = '${projectVO.orgnztNm}';
function setPrjType() {
	var type = $('input[name=type]:checked').val();
	$('#type').val(type);
	
	// 수정모드일 때는 프로젝트 구분, 상위 프로젝트, 주관부서 등의 정보는 변경할 수 없다.
	if (mode==='W')	{
		if (type=='M') {		
			prePrntPrjId = $('#prntPrjId').val();
			prePrntPrjNm = $('#prntPrjNm').val();
			$('#prntPrjId').val('');
			$('#prntPrjNm').val('').attr('disabled', true);
			$('#imgPrjTree').hide();
			$('#orgnztId').val(preOrgnztId);
			$('#orgnztNm').val(preOrgnztNm).attr('disabled', false);
			$('#orgnztTreeB').show();
		} else if (type=='S') {
			$('#prntPrjId').val(prePrntPrjId);
			$('#prntPrjNm').val(prePrntPrjNm).attr('disabled', false);
			$('#imgPrjTree').show();
			$('#orgnztId').val(preOrgnztId);
			$('#orgnztNm').val(preOrgnztNm).attr('disabled', true);
			$('#orgnztTreeB').hide();
			preOrgnztId = $('#orgnztId').val();
			preOrgnztNm = $('#orgnztNm').val();
		}
	} else if (mode==='M')	{
		$('input[name=type]').attr('disabled', true);
		$('#prntPrjId').val(prePrntPrjId);
		$('#prntPrjNm').val(prePrntPrjNm).attr('disabled', true);
		$('#imgPrjTree').hide();
		$('#orgnztId').val(preOrgnztId);
		$('#orgnztNm').val(preOrgnztNm).attr('disabled', true);
		$('#orgnztTreeB').hide();
	}
}

// 상위프로젝트의 프로젝트 주관부서, 생성권한, 기간 등의 정보를 가져온다.
function getPrjInfo() {
	var prjId = $('#prntPrjId').val();
	
	$.ajax({
		url: "/ajax/selectPrntPrj.do",
		data: {
			prjId: prjId
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			if (data.auth.equals('Y')) {
				prntStDt = data.prntStDt;
				childStDt = data.childStDt;
				prntCompDueDt = data.prntCompDueDt;
				childCompDueDt = data.childCompDueDt;
				//$('#prntPrjId').val(data.prjId);
				//$('#prntPrjNm').val(data.prjNm);
				$('#orgnztId').val(data.orgnztId);
				$('#orgnztNm').val(data.orgnztNm);
				preOrgnztId = $('#orgnztId').val();
				preOrgnztNm = $('#orgnztNm').val();
			} else {
				alert('하위 프로젝트를 생성할 수 있는 권한이 없습니다. 해당 PL에게 문의하세요.');
				$('#prntPrjId').val(prePrntPrjId);
				$('#prntPrjNm').val(prePrntPrjNm);
			}
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("프로젝트에 대한 데이터를 가져오는데 실패하였습니다.");
  	 	}
	});
}

function movePrj() {
	if(confirm("저장하지 않은 정보는 잃을 수 있습니다.\n프로젝트 이동 페이지로 넘어가겠습니까?"))
		location.href = '/cooperation/moveProjectW.do?prjId=${projectVO.prjId}';
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
						<li class="stitle">${title }</li>
						<li class="navi">공통업무 > 프로젝트관리  > ${title }</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<form:form commandName="projectVO" name="projectVO" method="post" enctype="multipart/form-data" >
				<form:hidden path="prjId"/>
				<form:hidden path="type"/>
				<input type="hidden" name="returnUrl" value="${returnUrl}"/>
				
				<div class="section01">

				<!-- 게시판 시작  -->
				<div class="boardWrite02 mB20">
					<div class="subDiv">
						<p class="th_stitle">기본 정보</p>
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>프로젝트 개요</caption>
							<colgroup>
								<col class="col120" />
								<col width="px" />
								<col class="col120" />
								<col width="px" />
							</colgroup>
							<tbody>
								<tr>
									<td class="title">프로젝트명(*)</td>
									<td class="pL10" colspan="3">
										<form:input path="prjNm" cssClass="span_12" />
									</td>
								</tr>
								<tr>
									<td class="title">프로젝트 종류(*)</td>
									<td class="pL10">
										<label><input type="radio" name="prjType" value="M" <c:if test="${projectVO.prjType=='M' || projectVO.prjType==''}">checked </c:if>/> 경영</label></br>
										<label><input type="radio" name="prjType" value="S" <c:if test="${projectVO.prjType=='S' }">checked </c:if>/>
											<span class="tooltip" onmouseover="bindTooltip(this, '4805', '200');">영업</span></label></br>
										<label><input type="radio" name="prjType" value="B" <c:if test="${projectVO.prjType=='B' }">checked </c:if>/>
											<span class="tooltip" onmouseover="bindTooltip(this, '4806', '200');">사업</span></label></br>
										<label><input type="radio" name="prjType" value="P" <c:if test="${projectVO.prjType=='P' }">checked </c:if>/> 수행</label></br>
										<label><input type="radio" name="prjType" value="E" <c:if test="${projectVO.prjType=='E' }">checked </c:if>/> 프로젝트 폴더</label></br>
									</td>
									<td class="pL10" colspan="2">
										<label></label>
									</td>
								</tr>
								<tr>
									<td class="title">구분(*)</td>
									<td class="pL10">
										<label><input type="radio" name="type" id="rdoMain" 
													<c:if test="${!user.admin && user.isProjectadmin!='Y'}">disabled="disabled"</c:if> 
													<c:if test="${projectVO.type=='M' }">checked </c:if> value="M" /> 메인프로젝트</label>
										</br><label><input type="radio" name="type" id="rdoSub" 
													<c:if test="${!user.admin && user.isProjectadmin!='Y'}">disabled="disabled"</c:if> 
													<c:if test="${projectVO.type=='S' }">checked </c:if> value="S" /> 서브프로젝트</label>
									</td>
									<td class="pL10" colspan="2">
										<p>상위프로젝트가 없이 부서에 속하는 프로젝트</p>
										<p>상위프로젝트가 있는 프로젝트</p>
									</td>
								</tr>
								<c:if test="${mode=='M'}"> 
									<tr>
										<td class="title">프로젝트코드</td>
										<td class="pL10" colspan="3">
											<!-- <form:input path="prjCd" cssClass="span_12" /> -->
											${projectVO.prjCd}
										</td>
									</tr>
								</c:if>
								<tr>
									<td class="title"><c:if test="${mode=='W'}">상위프로젝트</c:if>
										<c:if test="${mode=='M'}">
											<span class="tooltip" onmouseover="bindTooltip(this, '4939', '200');">상위프로젝트</span>
										</c:if>
									</td>
									<td class="pL10" colspan="3">
										<input type="text" class="span_12" name="prntPrjNm" id="prntPrjNm" readonly="readonly" 
												onclick="prjGen('prntPrjNm','prntPrjId',1, null, getPrjInfo)" onfocus="prjGen('prntPrjNm','prntPrjId',1, null, getPrjInfo)"/>
										<form:hidden path="prntPrjId"/>
										<img id="imgPrjTree" src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prntPrjNm','prntPrjId',1, null, getPrjInfo)" />
										<c:if test="${mode=='M'}">
											<span class="tooltip" onmouseover="bindTooltip(this, '4915', '200');">
												<input type="button" value="이동" class="btn_gray" onclick="movePrj()"/>
											</span>
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="title"><c:if test="${mode=='W'}">주관부서(*)</c:if>
										<c:if test="${mode=='M'}">
											<span class="tooltip" onmouseover="bindTooltip(this, '4939', '200');">주관부서(*)</span>
										</c:if>
									</td>
									<td class="pL10">
										<input type="text" name="orgnztNm" id="orgnztNm" value="${projectVO.orgnztNm }" 
												readonly="true" class="span_11" />
										<form:hidden path="orgnztId"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="orgnztTreeB" class="cursorPointer"/>
									</td>
									<td class="title">담당자/PL(*)</td>
									<td class="pL10">
										<form:input path="leaderMix" cssClass="span_9 userNameAuto userValidateCheck"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="userTreeB" class="cursorPointer"/>
									</td>
								</tr>
								<tr>
									<td class="title">진행상태(*)</td>
									<td class="pL10">
										<form:radiobuttons items="${codeList3}" path="stat" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
									</td>
									<td class="title">기간(*)</td>
									<td class="pL10">
										<form:input path="stDt" cssClass="calGen span_4"/>
										~ <form:input path="compDueDt" cssClass="calGen span_4"/>
									</td>
								</tr>
								<tr>
									<td class="title"><span class="tooltip" onmouseover="bindTooltip(this, '4913', '200');">정렬순서</span></td>
									<td class="pL10" colspan="3">
										<form:input path="ord" cssClass="span_3" /> (기본값: 100 범위: 10~999)
									</td>
								</tr>
								<tr>
									<td class="title">개요</td>
									<td class="pL10 pT5 pB5" colspan="3">
										<form:textarea path="prjCn" cssClass="span_15 height_170"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div id="divSales" class="subDiv"
						<c:if test="${projectVO.prjType!='S' && projectVO.prjType!='B'}">style="display:none;"</c:if> >
						<p class="th_stitle">사업/영업 관리 <img class="btn_arrow_up cursorPointer toggleB" id="salesTB"/></p>
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>프로젝트 개요</caption>
							<colgroup>
								<col class="col120" />
								<col width="px" />
								<col class="col120" />
								<col width="px" />
							</colgroup>
							<tr>
								<td class="title">고객사</td>
								<td colspan="3" class="pL10">
									<form:input path="custNm" cssClass="span_11" />
									<input type="hidden" id="custId" name="custId" class="span_8" readonly="true" value="${projectVO.custId}"/>
									<a href="${rootPath}/cooperation/insertCustomerView.do" target="_blank"><img src="${imagePath}/btn/btn_add.gif"/></a>
								</td>
							</tr>
							<tr>
								<td class="title">예상 매출</td>
								<td class="pL10" colspan="3">
									<form:input path="planSales" cssClass="span_12" />
								</td>
							</tr>
							<tr>
								<td class="title">예상 이익</td>
								<td class="pL10" colspan="3">
									<form:input path="planProfit" cssClass="span_12" />
								</td>
							</tr>
							<tr>
								<td class="title">예상 시기</td>
								<td class="pL10" colspan="3">
									<form:input path="planDate" cssClass="span_12" />
								</td>
							</tr>
						</table>
					</div>
					
					<div class="subDiv">
						<p class="th_stitle mT10">프로젝트 속성 설정 <img class="btn_arrow_up cursorPointer toggleB" id="salesTB"/></p>
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>프로젝트 개요</caption>
							<colgroup>
								<col class="col120" />
								<col width="px" />
								<col class="col120" />
								<col width="px" />
							</colgroup>
							<tr>
								<td class="title">업무실적등록</td>
								<td class="pL10">
									<form:radiobuttons items="${codeList2}" path="dayReportRule"  itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
								</td>
								<td class="title">비용지출</td>
								<td class="pL10">
									<form:radiobuttons items="${codeList2}" path="manageCostRule"  itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
								</td>
							</tr>
							<c:if test="${mode=='W' && projectVO.type=='S'}">
								<tr>
									<td class="title">상위 프로젝트<br/> 투입인력 가져오기</td>
									<td class="pL10" colspan="3">
										<form:radiobuttons items="${codeList1}" path="insertPrntPrjInput"  itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
									</td>
								</tr>
							</c:if>
							<c:if test="${projectVO.type=='S' || user.admin}">
								<tr>
									<td class="title"><span class="tooltip" onmouseover="bindTooltip(this, '4802', '250');">예산초과관리</span></td>
									<td class="pL10 pT5 pB5" colspan="3">
										<form:radiobuttons items="${codeList1}" path="budgetExceedRule"  itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/><br/>
									</td>
								</tr>
							</c:if>
							<tr>
								<td class="title"><span class="tooltip" onmouseover="bindTooltip(this, '4803', '250');">채권관리</span></td>
								<td class="pL10 pT5 pB5" colspan="3">
									<form:radiobuttons items="${codeList1}" path="bondYn"  itemLabel="codeNm" delimiter="&nbsp;" itemValue="code" />
								</td>
							</tr>
							<tr>
								<td class="title"><span class="tooltip" onmouseover="bindTooltip(this, '4804', '250');">제안서속성</span></td>
								<td class="pL10 pT5 pB5" colspan="3">
									<form:radiobuttons items="${codeList1}" path="proposal"  itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!--// 게시판 끝  -->
			
				<!-- 버튼 시작 -->
				<div class="btn_area">
					<c:choose>
						<c:when test="${mode=='W'}">
							<img src="${imagePath}/btn/btn_create.gif" id="prjInsertB" class="cursorPointer" />
						</c:when>
						<c:otherwise>
							<img src="${imagePath}/btn/btn_save.gif" id="prjInsertB" class="cursorPointer" />
						</c:otherwise>
					</c:choose>
					<img src="${imagePath}/btn/btn_cancel.gif" id="prjCancleB" class="cursorPointer" />
				</div>
				<!-- 버튼 끝 -->

				</div>
				</form:form>
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
