<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<style type="text/css" rel="stylesheet">
	.searching {
		text-align: center;
		font-size:12px;
		margin-bottom: 20px;
	}
	.progress-label {
		position: absolute;
		padding-left: 20px;
		font-weight: bold;
	}
	.ui-progressbar-value {
		background-color : rgb(204,204,204);
	}
	.ui-progressbar-value.ui-widget-header {
		background : #CCCCCC;
	}
	.subDiv { padding-bottom: 15px; }
</style>

<script>
var prjId = "${projectVO.prjId }";
var maxWork = 9;
var curWork = 0;

$(document).ready(function(){
	
	var mode = "${mode}";
	var form = $('#projectVO');

	$('#prntPrjInputB').click(function() {
		if(confirm('상위프로젝트의 투입인력을 가져오시겠습니까?')) {
			$.post('/ajax/insertPrntPrjInput.do',{prjId:prjId}, function(data){
				if(data.indexOf('success')>=0) {
					window.location = window.location;
				}
			});
		};
	});
	
	$('#projectInputS').click(function() {		
		var _this = $(this);
		var position = _this.offset();
		$.post("/ajax/writeProjectInput.do?prjId="+prjId,function(data) {
			var layer = $('<div id="projectInputL">'+ data + '</div>');
			
			/*
			layer.dialog( {
				height: 500
				,width:1000 
				,closeOnEscape: true 
				,resizable: true 
				,draggable: true	
				,modal :true
				,autoOpen: true		
				,position : [50,100]
				,close: function(event,ui){
					layer.remove();

				}
			});	
			*/
			
			// [20140930, dwkim] dialog 방식을 layer 방식으로 변경 (userTree 공통모듈이 제대로 안 먹혀서..)
			$('body').append(layer);
			$('#projectInputL').css('position', 'absolute');
			$('#projectInputL').css('top', '200px');
			$('#projectInputL').css('left', '200px');
			
			/* form 값이 바꼇는지를 체크 하는 변수 */
			var isChanged = false;
			
			$('#userTreeB').click(function(){
				usrGen('userInput',2,userAdd);
			});
			
			$('#userAddB').click(function(){
				userAdd($('#userInput'));
			});

			$('#userInput').keydown(function(e) {
				if(e.keyCode == 13 && !$(this).data("autocomplete").menu.active){
					userAdd($(this));
				}
			});
			
			$('#prjInputSaveB').click(function() {
				//check안된 box에 valid한 값을 setting하기 위해 clone된 form을 만들어서 보내준다.
				var cloneForm = $('#projectInputVO');
				cloneForm.find(":checkbox").each(function(){
					if($(this).is(":checked"))
						;
					else
						$(this).val(0);
				});
				cloneForm.find(":checkbox").attr("checked","checked");
				$.post("/ajax/updateProjectInput.do",cloneForm.serialize(), function(data){
					if(data.indexOf("success")) {
						window.location = window.location;
					}
				});
			});
			$('#prjInputCancleB').click(function(){
				layer.dialog("destroy");
				layer.remove();
			});
			function moveProjectInputYear(event) {
				if(isChanged) {
					if(!confirm("저장되지 않은 값이 있습니다. 이동하시겠습니까?"))
						return;
				}
				var offset = event.data.key1;
				var year = parseInt($('#projectInputVO input[name=year]').val()) + parseInt(offset);
				
				$.post("/ajax/writeProjectInput.do?prjId="+ prjId +"&year="+year,function(data){
					$('#projectInputVO input[name=year]').val(year);
					$('#projectInputYear').html(year);
					var tableData = $(data).find('#userInputTable');
					$('#userInputTable').html(tableData.html());
					isChanged = false;
				});
			}
			
			$('#moveYearNext').bind("click",{key1 : 1},moveProjectInputYear);
			$('#moveYearPrev').bind("click",{key1 : -1},moveProjectInputYear);

			$('#projectInputVO input[name=monthAll]').live('change', function(event){
				isChanged = true;
				var checked = $(this).is(":checked");
				if(checked)
					$(this).parent().parent().find("input[type=checkbox]").attr("checked",true);
				else
					$(this).parent().parent().find("input[type=checkbox]").attr("checked",false);
			});
			$('#projectInputVO input[name!=monthAll]').change(function(event){
				isChanged= true;
			});
			$('.verticalAll').live('change', function(){
				isChanged= true;
				if($(this).is(":checked"))
					$('.monthList' + $(this).val()).attr("checked",true);
				else
					$('.monthList' + $(this).val()).attr("checked",false);
			});
			
			$('.checkboxAll').live('change', function(){
				isChanged= true;
				if($(this).is(":checked"))
					$('#userInputTable input[type=checkbox]').attr("checked",true);
				else
					$('#userInputTable input[type=checkbox]').attr("checked",false);
			});

			function userAdd(userNmObj, userIdObj){
				var userNmList = makeUserNmArray(userNmObj.val());
				var userIdList = makeUserIdArray(userNmObj.val());
				userNmObj.val("");
				for( var i =0; i<userIdList.length; i++) {
					var trLength = $('#projectInputVO').find("tr").length;
					if($('#projectInputVO').find("input[name=userIdList][value="+escapeJQuerySelector(userIdList[i]) +"]").length>0) {
						alert(userNmList[i] + "은(는) 이미 추가된 사원입니다.");
						continue;
					}

					var tr = $('<tr>' + 
							'<td class="hidden"><input type="hidden" name="userIdList" value="'+userIdList[i] +'"/></td>' +
							'<td class="txt_center">'+ trLength +'</td>' +
							'<td class="txt_center userNm">'+userNmList[i]+'</td>' +
							'<td class="txt_center"><input name="monthList" class="monthList1" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList2" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList3" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList4" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList5" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList6" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList7" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList8" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList9" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList10" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList11" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" class="monthList12" type="checkbox" value="1"/></td>' +
							'<td class="td_last txt_center"><input name="monthAll" type="checkbox" /></td>' +
							'</tr>');
						tr.appendTo($('#userInputTable').find('tbody'));
				}				
			};
		});
	});
	

	//기본 항목 중, 선택적인 조회항목  토글 활성화
	$('.toggleBtnOpt').click(function(){
		if($(this).hasClass('btn_arrow_down')){
			$(this).removeClass('btn_arrow_down');
			$(this).addClass('btn_arrow_up');
			$('.hidArea').show();
		} else {
			$(this).removeClass('btn_arrow_up');
			$(this).addClass('btn_arrow_down');
			$('.hidArea').hide();
		}
	});

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
	
	//$('#pTest').text('조회 중: 하위프로젝트,매출건,매입건(사내),매입건(사외),업무연락,회의실,결재문서,월별실적,작업,');
	// 작업목록 로딩
	taskSearch(1,0);
	
	// 하위프로젝트 로딩
	rowProjectSearch();
	
	// 매출건 로딩
	salesSearch(1,0);
	
	// 매입건(사내) 로딩
	purchaseInSearch(0);
	
	// 매입건(사외) 로딩
	purchaseOutSearch(0);
	
	// 월별 실적 로딩
	monthlyReport(0);
	
	// 업무연락 로딩
	busiSearch(1,0);
	
	// 펀네트 회의실 로딩
	meetSearch(1,0);
	
	// 관련결재문서 로딩
	approvalSearch(1);	
	
	// 업무연락, 펀네트회의실, 월별실적, 작업은 숨김 상태가 default //월별실적도 많이 사용해서 기본 펼치기로 변경
	/*
	$('#taskD').hide();
	$('#projectChildD').hide();
	$('#salesD').hide();
	$('#purchaseInD').hide();
	$('#purchaseOutD').hide();
	$('#busiContactD').hide();
	$('#meetingD').hide();
	$('#approvalD').hide();
	$('#monthlyReportD').hide();
	*/
});

// Progress Bar 시작
function displayProc(curWork, maxWork) {
	var progressbar = $( "#progressbar" );
	var percent = Math.round(curWork/maxWork*100, 0);
	progressbar.progressbar( "value", percent);
	
	
}

$(function() {
	var progressbar = $( "#progressbar" ),
		progressLabel = $( ".progress-label" );

	progressbar.progressbar({
		value: false,
		change: function() {
			progressLabel.text( '프로젝트 상세정보 조회 중... ' + progressbar.progressbar( "value" ) + "%" );
		},
		complete: function() {
			//progressLabel.text( "Complete!" );
			progressbar.hide();
			$('#pTest').hide();
		}
	});
});
//Progress Bar 끝


function viewProject(prjId) {
	var form = $('#searchVO');
	form.find("[name$=prjId]").val(prjId);
	form.attr("action", "/cooperation/selectProjectV.do?prjId="+prjId);
	form.submit();
}

//하위프로젝트
function rowProjectSearch() {
	$('#projectChildInnerD').html('<div class="searching">조회중입니다...</div>');
	$.post("/ajax/selectProjectList.do",$('#searchProjectChildVO').serialize(), function(data){
		$('#projectChildInnerD').html(data);
		$('#searchProjectChildVO input[name=searchStatL]').bind("change",function(){
			$.post("/ajax/selectProjectList.do",$('#searchProjectChildVO').serialize(),function(data){
				$('#projectChildInnerD').html(data);
			});
		});
		displayProc(++curWork, maxWork);
		$('#pTest').text($('#pTest').text().replace('하위프로젝트,',''));
	});
}


//매출건
var salesSearchYear = ${searchVO.searchYear };
function salesSearch(pageIndex, pos) {
	if (pos==null) pos=0;
	salesSearchYear = salesSearchYear + pos;
	$('#salesYear').html(salesSearchYear);
	
	if (pos != 0) $('#salesAllYear').attr('checked', false);	// 년도 변경시 전체보기 해제
	
	if ($('#salesAllYear').is(':checked')) tmpSearchYear = "";	// 전체보기시 검색년도값 null로 초기화
	else tmpSearchYear = salesSearchYear;
	
	$('#salesInnerD').html('<div class="searching">조회중입니다...</div>');
	$.post('${rootPath}/ajax/salesList.do',{prjId:prjId, pageIndex:1, searchYear:tmpSearchYear},function(data){
		$('#salesInnerD').html(data);
		displayProc(++curWork, maxWork);
		$('#pTest').text($('#pTest').text().replace('매출건,',''));
	});
}

//매입건(사내)
var purchaseInSearchYear = ${searchVO.searchYear };
function purchaseInSearch(pos) {
	purchaseInSearchYear = purchaseInSearchYear + pos;
	$('#purchaseInYear').html(purchaseInSearchYear);
	
	if (pos != 0) $('#purchaseInAllYear').attr('checked', false);	// 년도 변경시 전체보기 해제
	
	if ($('#purchaseInAllYear').is(':checked')) tmpSearchYear = "";	// 전체보기시 검색년도값 null로 초기화
	else tmpSearchYear = purchaseInSearchYear;
	
	$('#purchaseInInnerD').html('<div class="searching">조회중입니다...</div>');
	$.post('${rootPath}/ajax/purchaseInList.do',{prjId:prjId, searchYear:tmpSearchYear},function(data){
		$('#purchaseInInnerD').html(data);
		displayProc(++curWork, maxWork);
		$('#pTest').text($('#pTest').text().replace('매입건(사내),',''));
	});
}

//매입건(사외)
var purchaseOutSearchYear = ${searchVO.searchYear };
function purchaseOutSearch(pos) {
	purchaseOutSearchYear = purchaseOutSearchYear + pos;
	$('#purchaseOutYear').html(purchaseOutSearchYear);
	
	if (pos != 0) $('#purchaseOutAllYear').attr('checked', false);	// 년도 변경시 전체보기 해제
	
	if ($('#purchaseOutAllYear').is(':checked')) tmpSearchYear = "";	// 전체보기시 검색년도값 null로 초기화
	else tmpSearchYear = purchaseOutSearchYear;
	
	$('#purchaseOutInnerD').html('<div class="searching">조회중입니다...</div>');
	$.post('${rootPath}/ajax/purchaseOutList.do',{prjId:prjId, searchYear:tmpSearchYear},function(data){
		$('#purchaseOutInnerD').html(data);
		displayProc(++curWork, maxWork);
		$('#pTest').text($('#pTest').text().replace('매입건(사외),',''));
	});
}

//업무연락
var busiSearchYear = ${searchVO.searchYear };
function busiSearch(pageIndex, pos) {
	document.busiFrm.pageIndex.value = pageIndex;
	
	if (pos==null) pos=0;
	busiSearchYear = busiSearchYear + pos;
	$('#busiYear').html(busiSearchYear);

	if (pos != 0) $('#busiAllYear').attr('checked', false);	// 년도 변경시 전체보기 해제
	
	if ($('#busiAllYear').is(':checked')) tmpSearchYear = "";	// 전체보기시 검색년도값 null로 초기화
	else tmpSearchYear = busiSearchYear;
	document.busiFrm.searchYear.value = tmpSearchYear;

	$('#busiContactInnerD').html('<div class="searching">조회중입니다...</div>');
	$.post("${rootPath}/ajax/selectBusinessContactList.do", $('#busiFrm').serialize(), function(data) {
		$('#busiContactInnerD').html(data);
		displayProc(++curWork, maxWork);
		$('#pTest').text($('#pTest').text().replace('업무연락,',''));
	});
}

//펀네트 회의실
var meetSearchYear = ${searchVO.searchYear };
function meetSearch(pageIndex, pos) {
	document.meetFrm.pageIndex.value = pageIndex;
	
	if (pos==null) pos=0;
	meetSearchYear = meetSearchYear + pos;
	$('#meetYear').html(meetSearchYear);

	if (pos != 0) $('#meetAllYear').attr('checked', false);	// 년도 변경시 전체보기 해제
	
	if ($('#meetAllYear').is(':checked')) tmpSearchYear = "";	// 전체보기시 검색년도값 null로 초기화
	else tmpSearchYear = meetSearchYear;
	document.meetFrm.searchYear.value = tmpSearchYear;
	
	$('#meetingRoomInnerD').html('<div class="searching">조회중입니다...</div>');
	$.post("${rootPath}/ajax/selectMeetingRoomList.do", $('#meetFrm').serialize(), function(data) {
		$('#meetingRoomInnerD').html(data);
		displayProc(++curWork, maxWork);
		$('#pTest').text($('#pTest').text().replace('회의실,',''));
	});
}

//관련결재문서
function approvalSearch(pageIndex) {
	document.approvalFrm.pageIndex.value = pageIndex;
	
	$('#approvalInnerD').html('<div class="searching">조회중입니다...</div>');
	$.post("${rootPath}/ajax/selectApprovalList.do", $('#approvalFrm').serialize(), function(data) {
		$('#approvalInnerD').html(data);
		displayProc(++curWork, maxWork);
		$('#pTest').text($('#pTest').text().replace('결재문서,',''));
	});
}

// 월별실적
var monthlyReportSearchYear = ${searchVO.searchYear };
//월별실적 년도이동기능 추가 Arvin 2012-12-25
function monthlyReport(pos) {	
	monthlyReportSearchYear = monthlyReportSearchYear + pos;
	$('#monthlyReportYear').html(monthlyReportSearchYear);		
	var prjId = "${projectVO.prjId }";
	var checkVal = $('#monthlyReportD input[name=includeUnderPrj]:checked').val();
	
	$('#monthlyReportInnerD').html('<div class="searching">조회중입니다...</div>');
	$.post('/ajax/cooperation/selectProjectMonthlyReport.do',{prjId : prjId, searchYear : monthlyReportSearchYear, includeUnderPrj : checkVal},function(data){
		$('#monthlyReportInnerD').html(data);
		displayProc(++curWork, maxWork);
		$('#pTest').text($('#pTest').text().replace('월별실적,',''));
	});
}

//작업	-> 페이징 처리(ui:pagination) 때문에, 이 메서드만 parameter의 순서를 변경함
var taskSearchYear = ${searchVO.searchYear };
function taskSearch(pageIndex, pos) {
	document.taskFrm.pageIndex.value = pageIndex;
	
	if (pos==null) pos=0;
	taskSearchYear = taskSearchYear + pos;
	$('#taskYear').html(taskSearchYear);

	if (pos != 0) $('#taskAllYear').attr('checked', false);	// 년도 변경시 전체보기 해제
	
	if ($('#taskAllYear').is(':checked')) tmpSearchYear = "";	// 전체보기시 검색년도값 null로 초기화
	else tmpSearchYear = taskSearchYear;
	document.taskFrm.searchYear.value = tmpSearchYear;

	$('#taskInnerD').html('<div class="searching">조회중입니다...</div>');
	$.post("${rootPath}/ajax/resultList.do", $('#taskFrm').serialize(), function(data) {
		$('#taskInnerD').html(data);
		displayProc(++curWork, maxWork);
		$('#pTest').text($('#pTest').text().replace('작업,',''));
	});
}

//안쓰나? 검색해도 안나옴
function selectExpenseStatistic(year) {
	document.monthlyReportFrm.searchYear.value = year;
	document.monthlyReportFrm.action = "${rootPath}/management/selectExpenseStatistic.do";
	document.monthlyReportFrm.submit();
}
//주석처리됨
function interest(prjId) {
	var form = $('#searchVO');
	form.find('[name$=prjId]').val(prjId);
	form.attr("action", "/cooperation/switchPrjInterest.do");
	form.submit();
}
</script>
</head>

<body>

	<!-- S: center -->
	<div id="pop_reg_div01">
		<div id="pop_top">
			<ul>
				<li><img src="../images/inc/pop_bullet.gif" /></li>
				<li class="popTitle">프로젝트 상세정보</li>
			</ul>
		</div>	
		
		<!-- S: section -->
		<div class="pop_reg_div02">
			<form:form commandName="searchVO" name="searchVO" id="searchVO" method="post" enctype="multipart/form-data" >
				<input name="prjId" type="hidden" value="${projectVO.prjId }" />
				<input name="returnUrl" type="hidden" value="/project/ProjectVPop2.do?prjId=${projectVO.prjId }" />
			</form:form>
			<form:form commandName="projectVO" name="projectVO" method="post" enctype="multipart/form-data" >
			<!-- 게시판 시작  -->
				<p class="th_stitle">프로젝트 개요 <img class="btn_arrow_down cursorPointer toggleBtnOpt" title="버튼을 클릭하여 펼칠 수 있습니다."/></p>
				<div class="boardWrite02 mB20">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
					<caption>프로젝트 개요</caption>
					<colgroup>
						<col class="col120" />
						<col width="px"/>
						<col class="col120" />
						<col width="px"/>
					</colgroup>
					<tbody>
						<tr>									
							<td class="title">프로젝트명</td>
							<td class="pL10" colspan="3"><span class="txtB_grey">[${projectVO.prjCd }] ${projectVO.prjNm }</span></td>
						</tr>
						<tr>
							<td class="title">주관부서</td>
							<td class="pL10">${projectVO.orgnztNm }</td>
							<td class="title">담당자(PL)</td>
							<td class="pL10">${projectVO.leaderMix}</td>
						</tr>
						
						<tr>
							<td class="title">진행상태</td>
							<td class="pL10">
								<c:forEach items="${codeList3}" var="progress">
									<c:if test="${projectVO.stat == progress.code}">${progress.codeDc}</c:if>
								</c:forEach>
							</td>
							<td class="title">기간</td>
							<td class="pL10" > 
								<print:date date="${projectVO.stDt}"/> 
								~ <print:date date="${projectVO.compDueDt}"/> 
							</td>
						</tr>
						<tr class="hidArea" style="display:none;">
							<td class="title">구분</td>
							<td class="pL10">
								<input name="" type="radio" name="type" disabled="disabled" <c:if test="${projectVO.type=='M' }">checked </c:if> /> 메인프로젝트
								<input name="" type="radio" name="type" disabled="disabled" <c:if test="${projectVO.type=='S' }">checked </c:if>/> 서브프로젝트
							</td>
							<td class="title">종류</td>
							<td class="pL10" >
								<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='M' }">checked </c:if>/> 경영
								<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='B' }">checked </c:if>/> 사업
								<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='S' }">checked </c:if>/> 영업
								<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='P' }">checked </c:if>/> 수행
								<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='E' }">checked </c:if>/> 기타
							</td>
						</tr>
						<tr class="hidArea" style="display:none;">
							<td class="title">상위프로젝트</td>
							<td class="pL10" colspan="3">
								<print:project prjCd="${projectVO.prntPrjCd }" prjId="${projectVO.prntPrjId}" prjNm="${projectVO.prntPrjNm}"/>										
							</td>
						</tr>
						<tr class="hidArea" style="display:none;">
							<td class="title">생성일</td>
							<td class="pL10"><print:date date="${projectVO.regDt }"/></td>
							<td class="title">정렬순서</td>
							<td class="pL10">${projectVO.ord } (기본값: 100 범위: 10~999)</td>
						</tr>
						<tr class="hidArea" style="display:none;">
							<td class="title">투입인력</td>
							<td class="pL10" colspan="2">
								<c:choose>
									<c:when test="${empty prjInputMaxUser }">
										<span class="txt_blue cursorPointer" id="projectInputS">투입 인력이 없습니다</span>
									</c:when>
									<c:otherwise>
										<span class="txt_blue cursorPointer" id="projectInputS">${prjInputMaxUser.userNm} 외 ${prjInputCnt - 1}명</span>		
									</c:otherwise>
								</c:choose> 
								<span class="T11"> (클릭하면 상세정보를 확인할 수 있습니다)</span>
							</td>
							<td>
								<c:if test="${projectVO.type=='S' && (user.admin || prjAuth=='Y' || prjAuth2=='Y')}">
									<span id="prntPrjInputB" class="cursorPointer mL20">※ 상위프로젝트 투입인력 가져오기</span>
								</c:if>
							</td>
						</tr>
						<tr class="hidArea" style="display:none;">
							<td class="title">개요</td>
							<td class="pL10 pT5 pB5" colspan="3"><print:textarea text="${projectVO.prjCn}"/> </td>
						</tr>
					</tbody>
				</table>
				
				<c:if test="${projectVO.prjType=='S' || projectVO.prjType=='B'}">
				<table cellpadding="0" cellspacing="0" class="hidArea" style="display:none;">
					<colgroup>
						<col class="col120" />
						<col width="px"/>
						<col class="col120" />
						<col width="px"/>
					</colgroup>
					<tbody>
						<tr>
							<td class="title">고객사</td>
							<td class="pL10" ><a href="${rootPath}/cooperation/selectCustomer.do?custId=${projectVO.custId}" target="_blank">${projectVO.custNm}</a></td>
							<td class="title">예상 시기</td>
							<td class="pL10" >${projectVO.planDate}</td>
						</tr>
						<tr>
							<td class="title">예상 매출</td>
							<td class="pL10" >${projectVO.planSales}</td>
							<td class="title">예상 이익</td>
							<td class="pL10" >${projectVO.planProfit}</td>
						</tr>
					</tbody>
				</table>
				</c:if>
				
				<table cellpadding="0" cellspacing="0" class="hidArea" style="display:none;">
					<colgroup>
						<col class="col120" />
						<col width="px"/>
						<col class="col120" />
						<col width="px"/>
					</colgroup>
					<tbody>
						<tr>
							<td class="title">업무실적등록</td>
							<td class="pL10" >
								<form:radiobuttons items="${codeList2}" path="dayReportRule" disabled="true" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</td>
							<td class="title">비용지출</td>
							<td class="pL10" >
								<form:radiobuttons items="${codeList2}" path="manageCostRule" disabled="true" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</td>
						</tr>
						<tr>
							<td class="title"><span class="tooltip" onmouseover="bindTooltip(this, '4802', '250');">예산초과관리</span></td>
							<td class="pL10">
								<form:radiobuttons items="${codeList1}" path="budgetExceedRule" disabled="true" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</td>
							<td class="title"><span class="tooltip" onmouseover="bindTooltip(this, '4803', '250');">채권관리</span></td>
							<td class="pL10 pT5 pB5" colspan="1">
								<form:radiobuttons items="${codeList1}" path="bondYn" disabled="true" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</td>
						</tr>
						<tr>
							<td class="title"><span class="tooltip" onmouseover="bindTooltip(this, '4804', '250');">제안서 속성</span></td>
							<td class="pL10 pT5 pB5" colspan="3">
								<form:radiobuttons items="${codeList1}" path="proposal" disabled="true" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</td>
						</tr>
					</tbody>
				</table>
				</div>
				<!--// 게시판 끝  -->
				
				<!-- 버튼 시작 -->
				<div class="btn_area02 pB30">
					<ul>
						<li class="right">
							<c:if test="${user.admin || user.isProjectadmin == 'Y' || prjAuth=='Y' || prjAuth2=='Y'}">
								<input type="button" value="수 정" class="btn_gray w60" onclick="location.href = '/project/modifyProjectPop.do?prjId=${projectVO.prjId}'"/>
							</c:if>
							<c:if test="${user.admin || user.isProjectadmin == 'Y' || prjAuth=='Y' || prjAuth2=='Y'}">
								<input type="button" value="이 동" class="btn_gray w60" onclick="location.href = '/project/ProjectMovePop.do?prjId=${projectVO.prjId}'"/>
							</c:if>
							<c:if test="${user.admin || user.isProjectadmin == 'Y' || prjAuth=='Y' || prjAuth2=='Y'}">
								<input type="button" value="종 료" class="btn_gray w60" onclick="location.href = '/project/updateProjectStatEnd.do?prjId=${projectVO.prjId}'"/>
							</c:if>
							<c:if test="${user.admin || user.isPrjtransferadmin == 'Y'}">
								<span class="tooltip" onmouseover="bindTooltip(this, '4914', '200');">
								<input type="button" value="이 관" class="btn_gray w60" onclick="location.href = '/cooperation/transferProjectW.do?prjId=${projectVO.prjId}'"/>
								</span>
							</c:if>
							<input type="button" value="취 소" class="btn_gray w60" onclick="window.close()"/>
						</li>
					</ul>
				</div>
				<!--// 버튼 끝 -->
			</form:form> 
				
			<div id="progressbar" style="width:300px; margin-bottom:20px;">
				<div class="progress-label"></div>
			</div>
			<p id="pTest"></p>
			
			<!-- 작업목록 시작  -->
			<div class="subDiv">
				<p class="th_stitle">관련 작업 <img class="btn_arrow_down cursorPointer toggleB" id="taskTB"/></p>
				<div id="taskD" style="display:none;">
					<form name="taskFrm" id="taskFrm" method="POST" action="" onsubmit="taskSearch(1,0); return false;">
					<input type="hidden" name="pageIndex"/>
					<input type="hidden" name="param_prjId" value="${projectVO.prjId}"/>
					<input type="hidden" name="searchYear" value=""/>
					<fieldset>
					<legend>체크</legend>
						<div class="bot_search mT10">
						<ul>
							<li class="Sleft">
								<img class="cursorPointer pR10 pT2" onclick="javascript:taskSearch(1,-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
								<span id="taskYear" class="option_txt">${searchVO.searchYear }년</span>
								<img class="cursorPointer pL10 pT2" onclick="javascript:taskSearch(1,1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
								<label style="padding-left:10px;"><input id="taskAllYear" type="checkbox" onclick="javascript:taskSearch(1,0);"/> 전체보기</label>
							</li>
							<li class="Sright">
								하위프로젝트
								<input type="radio" name="includeUnderProject" value="Y" onclick="taskSearch(1,0);"/> 포함<span class="pL7"></span>
								<input type="radio" name="includeUnderProject" value="N" onclick="taskSearch(1,0);" checked="checked"/> 미포함
							</li>
						</ul>
						</div>
					</fieldset>
					</form>
					
					<!-- 게시판 시작  -->
					<div id="taskInnerD">
					</div>
				</div>
			</div>

			<!-- 업무연락 시작  -->
			<div class="subDiv">
				<p class="th_stitle">관련 업무연락 <img class="btn_arrow_down cursorPointer toggleB" id="busiContactTB"/></p>
				<div id="busiContactD" style="display:none;">
					<form name="busiFrm" id="busiFrm" method="POST" action="" onsubmit="busiSearch(1,0); return false;">
					<input type="hidden" name="pageIndex"/>
					<input type="hidden" name="ajax" value="Y"/>
					<input type="hidden" name="searchPrjId" value="${projectVO.prjId}"/>
					<input type="hidden" name="interestYn"/>
					<input type="hidden" name="bcId"/>
					<input type="hidden" name="searchYear" value=""/>
					<fieldset>
					<legend>체크</legend>
						<div class="bot_search mT10">
						<ul>
							<li class="Sleft">
								<img class="cursorPointer pR10 pT2" onclick="javascript:busiSearch(1,-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
								<span id="busiYear" class="option_txt">${searchVO.searchYear }년</span>
								<img class="cursorPointer pL10 pT2" onclick="javascript:busiSearch(1,1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
								<label style="padding-left:10px;"><input id="busiAllYear" type="checkbox" onclick="javascript:busiSearch(1,0);"/> 전체보기</label>
							</li>
							<li class="Sright">
								하위프로젝트
								<input type="radio" name="includeUnderProject" value="Y" onclick="busiSearch(1,0);"/> 포함<span class="pL7"></span>
								<input type="radio" name="includeUnderProject" value="N" onclick="busiSearch(1,0);" checked="checked"/> 미포함
							</li>
						</ul>
						</div>
					</fieldset>
					</form>
					<!-- 게시판 시작  -->
					<div id="busiContactInnerD">
						<%--
						<c:import url="${rootPath}/ajax/selectBusinessContactList.do">
							<c:param name="searchPrjId" value="${projectVO.prjId}"/>
							<c:param name="includeUnderProject" value="N"/>
							<c:param name="ajax" value="Y"/>
						</c:import>
						--%>
					</div>
				</div>
			</div>
			<!--// 업무연락  끝  -->
			
			<!-- 펀네트회의실 시작  -->
			<div class="subDiv">
				<p class="th_stitle">관련 회의 <img class="btn_arrow_down cursorPointer toggleB" id="meetingTB"/></p>
				<div id="meetingD" style="display:none;">
					<form name="meetFrm" id="meetFrm" method="POST" action="" onsubmit="meetSearch(1,0); return false;">
					<input type="hidden" name="pageIndex"/>
					<input type="hidden" name="ajax" value="Y"/>
					<input type="hidden" name="searchPrjId" value="${projectVO.prjId}"/>
					<input type="hidden" name="interestYn"/>
					<input type="hidden" name="bcId"/>
					<input type="hidden" name="searchYear" value=""/>
					<fieldset>
					<legend>체크</legend>
						<div class="bot_search mT10">
						<ul>
							<li class="Sleft">
								<img class="cursorPointer pR10 pT2" onclick="javascript:meetSearch(1,-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
								<span id="meetYear" class="option_txt">${searchVO.searchYear }년</span>
								<img class="cursorPointer pL10 pT2" onclick="javascript:meetSearch(1,1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
								<label style="padding-left:10px;"><input id="meetAllYear" type="checkbox" onclick="javascript:meetSearch(1,0);"/> 전체보기</label>
							</li>
							<li class="Sright">
								하위프로젝트
								<input type="radio" name="includeUnderProject" value="Y" onclick="meetSearch(1,0);"/> 포함<span class="pL7"></span>
								<input type="radio" name="includeUnderProject" value="N" onclick="meetSearch(1,0);" checked="checked"/> 미포함
							</li>
						</ul>
						</div>
					</fieldset>
					</form>
					<!-- 게시판 시작  -->
					<div id="meetingRoomInnerD">
						<%--
						<c:import url="${rootPath}/ajax/selectMeetingRoomList.do">
							<c:param name="searchPrjId" value="${projectVO.prjId}"/>
							<c:param name="includeUnderProject" value="N"/>
							<c:param name="ajax" value="Y"/>
						</c:import>
						--%>
					</div>
				</div>
			</div>
			<!--// 펀네트회의실  끝  -->

			<!-- 게시판 시작  -->
			<div class="subDiv">
				<p class="th_stitle">하위프로젝트 <img class="btn_arrow_down cursorPointer toggleB"/>
					<c:if test="${user.admin || prjAuth=='Y' || user.isProjectadmin == 'Y' || prjAuth2=='Y'}">
						<a href="/cooperation/writeProject.do?prntPrjId=${projectVO.prjId }&type=S">
							<img src="${imagePath }/btn/btn_add.gif"/>
						</a>
					</c:if>
				</p>
				
				<div id="projectChildD" style="display:none;">
					<!-- 하단 상태체크 시작 -->
					<form:form commandName="searchProjectChildVO" name="searchProjectChildVO" method="post" enctype="multipart/form-data" >
					<input type="hidden" name ="searchPrntPrjId" value= "${searchProjectChildVO.prjId }"/>
					<fieldset>
					<legend>체크</legend>
						<div class="bot_search mT10">
						<ul>
							<li class="Sright">
							진행상태 : 
							<form:checkboxes items="${codeList3}" path="searchStatL" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</li>
						</ul>
						</div>
					</fieldset>
					<!-- 하단 상태체크 끝 -->
					</form:form>
					<div class="boardList02 mB20" id="ProjectChildInnerD">
					</div>
				</div>
			</div>
			<!--// 게시판  끝  -->

			<!-- 매출건 시작  -->
			<div class="subDiv">
				<p class="th_stitle">매출건 <img class="btn_arrow_down cursorPointer toggleB" id="salesTB"/></p>
				<div id="salesD" style="display:none;">
					<form name="salesFrm" id="salesFrm" method="POST" action="" onsubmit="salesSearch(0,1); return false;">
					<input type="hidden" name="pageIndex"/>
					<input type="hidden" name="prjId" value="${projectVO.prjId}"/>
					
					<fieldset>
					<legend>체크</legend>
						<div class="bot_search mT10 mB20">
						<ul>
							<li class="Sleft">
								<img class="cursorPointer pR10 pT2" onclick="javascript:salesSearch(1,-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
								<span id="salesYear" class="option_txt">${searchVO.searchYear }년</span>
								<img class="cursorPointer pL10 pT2" onclick="javascript:salesSearch(1,1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
								<label style="padding-left:10px;"><input id="salesAllYear" type="checkbox" onclick="javascript:salesSearch(1,0);"/> 전체보기</label>
							</li>
						</ul>
						</div>
					</fieldset>
					
					<!-- 게시판 시작  -->
					<div id="salesInnerD">
						<%--
						<c:import url="${rootPath}/ajax/salesList.do">
							<c:param name="pageIndex" value="1"/>
						</c:import>
						--%>
					</div>
					</form>
				</div>
			</div>
			<!--// 매출건  끝  -->
			
			
			<!-- 매입건(사내) 시작  -->
			<div class="subDiv">
				<p class="th_stitle">매입건(사내) <img class="btn_arrow_down cursorPointer toggleB" id="purchaseInTB"/></p>
				<div id="purchaseInD" style="display:none;">
					<fieldset>
					<legend>체크</legend>
						<div class="bot_search mT10 mB20">
						<ul>
							<li class="Sleft">
								<img class="cursorPointer pR10 pT2" onclick="javascript:purchaseInSearch(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
								<span id="purchaseInYear" class="option_txt">${searchVO.searchYear }년</span>
								<img class="cursorPointer pL10 pT2" onclick="javascript:purchaseInSearch(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
								<label style="padding-left:10px;"><input id="purchaseInAllYear" type="checkbox" onclick="javascript:purchaseInSearch(0);"/> 전체보기</label>
							</li>
						</ul>
						</div>
					</fieldset>
					<!-- 게시판 시작  -->
					<div id="purchaseInInnerD">
						<%--
						<c:import url="${rootPath}/ajax/purchaseInList.do">
						</c:import>
						--%>
					</div>
				</div>
			</div>
			<!--// 매입건(사내) 끝  -->
			
			<!-- 매입건(사외) 시작  -->
			<div class="subDiv">
				<p class="th_stitle">매입건(사외) <img class="btn_arrow_down cursorPointer toggleB" id="purchaseOutTB"/></p>
				<div id="purchaseOutD" style="display:none;">
					<fieldset>
					<legend>체크</legend>
						<div class="bot_search mT10 mB20">
						<ul>
							<li class="Sleft">
								<img class="cursorPointer pR10 pT2" onclick="javascript:purchaseOutSearch(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
								<span id="purchaseOutYear" class="option_txt">${searchVO.searchYear }년</span>
								<img class="cursorPointer pL10 pT2" onclick="javascript:purchaseOutSearch(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
								<label style="padding-left:10px;"><input id="purchaseOutAllYear" type="checkbox" onclick="javascript:purchaseOutSearch(0);"/> 전체보기</label>
							</li>
						</ul>
						</div>
					</fieldset>
					<!-- 게시판 시작  -->
					<p class="th_plus02">단위 : 원</p>
					<div id="purchaseOutInnerD">
						<%--
						<c:import url="${rootPath}/ajax/purchaseOutList.do">
						</c:import>
						--%>
					</div>
				</div>
			</div>
			<!--// 매입건(사외) 끝  -->
			
			
			
			<!-- 관련결재문서 시작  -->
			<div class="subDiv">
				<p class="th_stitle">관련 결재문서(메일발송결재) <img class="btn_arrow_down cursorPointer toggleB" id="approvalTB"/></p>
				<div id="approvalD" style="display:none;">
					<form name="approvalFrm" id="approvalFrm" method="POST" action="" onsubmit="approvalSearch(1); return false;">
					<input type="hidden" name="pageIndex"/>
					<input type="hidden" name="ajax" value="Y"/>
					<input type="hidden" name="searchPrjId" value="${projectVO.prjId}"/>
					<input type="hidden" name="interestYn"/>
					<input type="hidden" name="bcId"/>
					<fieldset>
					<legend>체크</legend>
						<div class="bot_search mT10">
						<ul>
							<li class="Sright">
								하위프로젝트
								<input type="radio" name="includeUnderProject" value="Y" onclick="approvalSearch(1);"/> 포함<span class="pL7"></span>
								<input type="radio" name="includeUnderProject" value="N" onclick="approvalSearch(1);" checked="checked"/> 미포함
							</li>
						</ul>
						</div>
					</fieldset>
					</form>
					<!-- 게시판 시작  -->
					<div id="approvalInnerD">
						<%--
						<c:import url="${rootPath}/ajax/selectApprovalList.do">
							<c:param name="searchPrjId" value="${projectVO.prjId}"/>
							<c:param name="includeUnderProject" value="N"/>
							<c:param name="ajax" value="Y"/>
						</c:import>
						--%>
					</div>
				</div>
			</div>
			<!--// 관련결재문서  끝  -->

			<!-- 월별실적 시작  -->
			<div class="subDiv">
				<p class="th_stitle">월별실적 
				<img class="cursorPointer toggleB btn_arrow_down" id="monthlyReportTB"/></p>
				<div id="monthlyReportD" style="display:none;">
					<form name="monthlyReportFrm" id="monthlyReportFrm" action="" method="get">
						<input name="searchDate" type="hidden" value=""/>
						<input name="searchPrjId" type="hidden" value="${projectVO.prjId}"/>
						<input name="searchYear" type="hidden" value=""/>
						<input name="searchCondition" type="hidden" value="3"/>
						<input name="includeCost" type="hidden" value="N"/>
						<input name="includeExp" type="hidden" value="Y"/>
						<fieldset>
						<legend>체크</legend>
							<div class="bot_search mT10 mB20">
							<ul>
								<li class="Sleft">
									<img id="userSalaryMonthBackB" class="cursorPointer pR10 pT2" onclick="javascript:monthlyReport(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
									<span id="monthlyReportYear" class="option_txt">${searchVO.searchYear }년</span>
									<img id="userSalaryMonthForwardB" class="cursorPointer pL10 pT2" onclick="javascript:monthlyReport(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">									
								</li>
								<li class="Sright">
									하위프로젝트
									<input type="radio" name="includeUnderPrj" value="Y"/> 포함<span class="pL7"></span>
									<input type="radio" name="includeUnderPrj" value="N"  checked="checked"/> 미포함
								</li>
							</ul>
							</div>
						</fieldset>
					</form>
						
					<!-- 게시판 시작  -->
					<p class="th_plus02">단위 : 천원</p>
					<div class="boardList02 mB20" id="monthlyReportInnerD">
					</div>
				</div>
			</div>
			<!--// 월별실적  끝  -->
		</div>
		<!-- E: section -->
	</div>
	<!-- E: center -->				
</body>
</html>
