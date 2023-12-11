<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$('document').ready(function() {
	loadVacationDetail(${searchVO.no}, '');

	//토글 버튼 활성화
	$('.toggleB').click(function(){
		if($(this).hasClass('btn_arrow_down')){
			$(this).removeClass('btn_arrow_down');
			$(this).addClass('btn_arrow_up');
			$(this).closest('p').removeClass('mB20');
			$(this).closest('p').next().show();
		}
		else{
			$(this).removeClass('btn_arrow_up');
			$(this).addClass('btn_arrow_down');
			$(this).closest('p').addClass('mB20');
			$(this).closest('p').next().hide();
		}
	});
	
	//토글 버튼 활성화
	$('.toggleB2').click(function(){
		if($(this).hasClass('btn_arrow_detail')){
			$(this).removeClass('btn_arrow_detail');
			$(this).addClass('btn_arrow_brief');
			//$(this).closest('p').removeClass('mB20');
			$(this).closest('p').next().next().show();
		}
		else{
			$(this).removeClass('btn_arrow_brief');
			$(this).addClass('btn_arrow_detail');
			//$(this).closest('p').addClass('mB20');
			$(this).closest('p').next().next().hide();
		}		
	});
	//$('#workStatD').hide(); // 기본개인정보
	$('#userinfoD').hide(); // 상세개인정보
	//$('#workReportD').hide(); // 근태기록
	//$('#dayReportD').hide(); // 나의업무보고
	//$('#projectD').hide(); // 관련프로젝트
	//$('#overtimeD').hide(); // 연장근무내역
	//$('#vacD').hide(); // 휴가사용내역
	//$('#personnelAppointmentD').hide(); // 인사발령내역
	
});

window.onload = function(){	
}

function searchUserInfo(no) {
	document.subFrm2.action = "<c:url value='${rootPath}/member/selectMemberMain.do?no='/>" + no;
	document.subFrm2.action = "<c:url value='${rootPath}/member/selectMemberMain.do' />";
	document.subFrm2.submit();
}
function modifyUserInfo(no) {
	document.subFrm.no.value = no;
	document.subFrm.action = "<c:url value='${rootPath}/member/updtMemberView.do' />";
	document.subFrm.submit();
}
function loadVacationDetail(userNo, vacTyp, y) {
	$.post("${rootPath}/member/selectVacationSummaryDetailInc.do?param_userNo=" + userNo + "&param_year=" + y + "&vacTyp=" + vacTyp,
			function(data){
				$('#vacationSummaryDetail').html(data);
			}
	);
}
function loadOvertimeDetail(userNo, month, y) {
	var popup = window.open("${rootPath}/member/selectOvertimeDetailPop.do?param_userNo=" + userNo + "&param_year=" + y + "&param_month=" + month,'_POP_','');
	popup.focus();
}
function loadOvertimeDetail2(userNo, month, y) { //변경하다가 중단
	var popup = window.open("${rootPath}/member/selectOvertimeDetailPop.do?param_userNo=" + userNo + "&param_year=" + y + "&param_month=" + month,'_POP_','');
	popup.focus();
}
function moveYear(y, typ) {
	var tmp = document.getElementById(typ + "Year");

	var year = new Number(tmp.innerHTML) + y;

	if (typ == "vacation") {
		$.post("${rootPath}/member/selectVacationSummaryViewInc.do?param_userNo=${searchVO.no}&param_year=" + year,
				function(data){
					$('#vacationSummary').html(data);
				}
		);
		$.post("${rootPath}/member/selectVacationSummaryDetailInc.do?param_userNo=${searchVO.no}&param_year=" + year,
				function(data){
					$('#vacationSummaryDetail').html(data);
				}
		);
	}
	else if (typ == "overtime") {
		$.post("${rootPath}/member/selectOvertimeViewInc.do?param_userNo=${searchVO.no}&param_year=" + year,
				function(data){
					$('#overtime').html(data);
				}
		);
	}
	
	document.getElementById(typ + "Year").innerHTML = year;
	
}
function searchLayer() {
	document.frm.submit();
}

//휴가사용 상세내역 테이블 hr_vacationD.jsp에서 호출하는 함수
function loadVacationDetail(userNo,vacTyp) {
	$.post("/member/selectVacationSummaryDetail.do?searchYear=${thisYear}&vacTyp=" + vacTyp + "&userNo=" + userNo,
			function(data){
				$('#vacationSummaryDetail').html(data);
			}
	);
}
function modifyAppVac(docId) {
	$("#vacTypDocId").val(docId);
	if (${searchVO.no} != ${user.userNo} && ${user.admin} == false) {
		alert('휴가사용내역은 본인만 수정할 수 있습니다.');
		return;
	}
	
	var url = '${rootPath}/approval/approvalRW.do?docId=' + docId + '&reWriteTyp=1';
	var action = '<c:url value="' + url + '"/>';
	document.formVacTyp.action = action;
	document.formVacTyp.submit();
}
function showVacTyp(docId){
	$("#vacTypDocId").val(docId);
	$('#vacationTypChange').show();
	$('#selectVacTyp').focus();
}
function vactyp(){
	var text = $("#selectVacTyp > option:selected").val();
	$("#vacTyp").val(text);
}
function modifyAppVacTyp(){
	var vacTyp = $("#selectVacTyp > option:selected").val();
	var docId = $("#vacTypDocId").val();
	
	if(vacTyp == ""){
		alert("휴가종류를 선택해주세요");
		$('#selectVacTyp').focus();
		return;
	}
	
	var url = '${rootPath}/member/updateVactyp.do?docId=' + docId + '&vacTyp=' + vacTyp;
	var action = '<c:url value="' + url + '"/>';
	document.formVacTyp.action = action;
	document.formVacTyp.submit();
}
function chngMemberLogin(no){
	document.subFrm.no.value = no;
	document.subFrm.action = "<c:url value='${rootPath}/member/chngMemberLogin.do' />";
	document.subFrm.submit();
}
//휴가사용 상세내역 테이블 hr_vacationD.jsp에서 호출하는 함수 끝

//자르기(usrGen 으로 데이터 가져왔을때, 사용자명만 잘라내기)
function cutUsrGenName() {
	var searchKeyword = $('.bot_search input[name=searchKeyword]');
	var val = searchKeyword.val();
	val = val.substring(0, val.indexOf('('));
	searchKeyword.val(val);
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
							<li class="stitle">인사정보 통합검색</li>
							<li class="navi">홈 > 인사정보</li>
						</ul>
					</div>
					
					<span class="stxt">임직원의 근무현황, 개인정보, 인사발령내역 등을 한 눈에 확인할 수 있습니다.</span>
					
					<!-- S: section -->
					<div class="section01">
						<form id="searchFrm" name="frm" method="POST" action="${rootPath}/headSearch.do" onsubmit="searchLayer(); return false;">
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="bot_search mB10">
								<ul>
									<li class="option_txt">
										사용자<span class="pL7"></span><input type="radio" name="searchCondition" value="0" checked="checked">
									</li>
									<li class="search_box">
										<input type="text" name="searchKeyword" id="searchKeyword" class="search_txt02 userNameAutoHead"/>
										<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchKeyword',1,cutUsrGenName);" class="cursorPointer">
									</li>
									<li><a href="javascript:searchLayer();"><img src="${imagePath}/btn/btn_search02.gif" alt="검색"/></a></li>
								</ul>
							</div>
						</fieldset>
						<!-- 상단 검색창 끝 -->
						</form>
						
						<!-- 사원정보 시작  -->
						<p class="th_stitle">사원정보
<!--	            		<img class="cursorPointer toggleB2 btn_arrow_down" id="workStatTB"/>-->
						<img class="cursorPointer toggleB2 btn_arrow_detail" id="workStatTB"/>
						<c:if test="${user.loginauth }">
							${searchVO.no}
							<input type="button" value="로그인" onclick="javascript:chngMemberLogin(${searchVO.no});" >
						</c:if>
						</p>
						<div id="workStatD" class="boardList02 mB20" >
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>근무현황</caption>
							<colgroup>
								<col width="px" />
								<col width="60px" />
								<col width="60px" />
								<col width="100px" />
								<col width="180px" />
							</colgroup>
<!--		                    <thead>-->
<!--		                    	<tr>-->
<!--			                    	<th>부서</th>-->
<!--			                    	<th>이름</th>-->
<!--			                    	<th>직급</th>-->
<!--		                    		<th>휴대폰</th>-->
<!--		                    		<th class="td_last">회사번호</th>-->
<!--		                    	</tr>-->
<!--		                    </thead>-->
							<tbody>
								<tr>
									<td class="txt_center">${searchVO.orgnztNmFullLong}</td>
									<td class="txt_center"><print:user userNo="${searchVO.no}" userNm="${searchVO.userNm}"/></td>
									<td class="txt_center">${searchVO.rankNm}</td>
									<td class="txt_center">
									<c:if test="${fn:length(searchVO.moblphonNo) == 0 || searchVO.moblphonNo == null}">이동전화 미입력</c:if>
									${searchVO.moblphonNo}</td>
									<td class="txt_center">
									<c:if test="${fn:length(searchVO.offmTelno) == 0 || searchVO.offmTelno == null}">회사전화 미입력</c:if>
									${searchVO.offmTelno}(내선:${searchVO.offmTelnoInner}<c:if test="${fn:length(searchVO.offmTelnoInner) == 0 || searchVO.offmTelnoInner == null}">미입력</c:if>)
									</td>
								</tr>
							</tbody>
							</table>
						</div>
						<!-- 사원정보  끝  -->
						
						<!-- 개인정보 시작  -->
<!--	            		<p class="th_stitle3 mB20">상세개인정보 <img class="cursorPointer toggleB btn_arrow_down" id="userinfoTB"/></p>-->
						<div id="userinfoD" class="boardWrite02  mB20" style="display:none" >
							<c:import url="${rootPath}/member/selectMemberInc.do" charEncoding="utf-8">
								<c:param name="param_userNo" value="${searchVO.no}" />
							</c:import>
							<!-- 버튼 시작 -->
							<div class="btn_area">
								<c:if test="${user.no == searchVO.no || user.admin}">
									<a href="javascript:modifyUserInfo(${searchVO.no});"><img src="${imagePath}/btn/btn_modify.gif"/></a>
								</c:if>
							</div>
							<!-- 버튼 끝 -->
							
						</div>
						<!--// 개인정보  끝  -->
						
						<p class="th_stitle3 mB20">근태현황 <img class="cursorPointer toggleB btn_arrow_up" id="workReportTB"/></p>
						<div id="workReportD" class="boardList02 mB5">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>근태정보</caption>
							<colgroup>
								<col width="px" />
								<col width="px" />
								<col width="px" />
							</colgroup>
							<thead>
									<th>현재상태</th>
									<th>현재위치</th>
									<th class="td_last">기간</th>
							</thead>
							<tbody>
								<tr>
									<td class="txt_center">
										<a href="/member/workStateDetail.do?searchUserNo=${searchVO.no }&mode=week">
										${state.state}
										<c:if test="${fn:length(state.attendTm) > 0 }">(${state.attendTm } ${state.gubun})</c:if>
										</a>
										</td>
									<td class="txt_center">${state.wsPlace}<c:if test="${!empty state.mtPlace}">(${state.mtPlace})</c:if></td>
									<td class="td_last txt_center">${state.period}</td>
								</tr>
							</tbody>
							</table>
						</div>
						
						<p class="th_stitle3 mB20">근태등록정보 <img class="cursorPointer toggleB btn_arrow_up" id="workReportTB"/></p>
						<div id="workReportD" class="boardList02 mB5">

						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>근태등록정보</caption>
						<colgroup>
							<col class="col70" />
							<col class="col120" />
							<col class="col160" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
								<th>부재종류</th>
								<th>기간</th>
								<th>장소</th>
								<th class="td_last">사유</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${workstateList}" var="workstate">
								<tr class="height_td">
								<!-- 야근 : 사유 야근시간 출근시간 -->
								<!-- 휴가 : 기간 사유 -->
								<!-- 외근 : 시간 장소 목적 등록자 등록시간 -->
								<!-- 출장 : 기간 장소 등록자 -->
								<!-- 파견 : 기간 장소 등록자 -->
									<!--부재종류-->
									<td class="txt_center">
									<a href="${rootpath}/member/dailyWorkStateStatistic.do#${workstate.wsTypLowerCase }${searchVO.no}">${workstate.wsTypPrint }</a></td>
									<!--기간-->
									<td class="txt_center">${workstate.wsBgnDe}
									<c:if test="${workstate.wsTyp == 'V' || workstate.wsTyp == 'T' || workstate.wsTyp == 'S'}">
										<br/>~${workstate.wsEndDe}
									</c:if></td>
									<!--장소-->
									<td class="txt_center">${workstate.wsPlace}</td>
									<!--사유/목적-->
									<td class="txt_center"><print:textarea text="${workstate.wsPurpose}"/>
									<c:if test="${workstate.wsTyp == 'O' }">
										(출발 ${workstate.wsBgnTm}시  ~ ${workstate.wsEndTm}시 복귀)
									</c:if>
									<c:if test="${workstate.wsTyp == 'N' }">
										(${workstate.wsBgnTm}시)
									</c:if>
									</td>
									<!--시간-->
<!--									<td class="txt_center">-->
<!--									</td>-->
									<!--등록자-->
<!--									<td class="txt_center"><print:user userNo="${workstate.writerNo}" userNm="${workstate.writerNm}"/></td>-->
									<!--등록시간-->
<!--									<td class="txt_center">${workstate.regDtLong}</td>											                    	-->
								</tr>
							</c:forEach>
							<c:if test="${empty workstateList}">
								<tr>
									<td class="td_last txt_center" colspan="4">부재현황이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
						</div>
						
						<!-- 나의업무보고 시작-->
						<p class="th_stitle3 mB20">나의업무보고 <img class="cursorPointer toggleB btn_arrow_up" id="dayReportTB"/></p>
						<div id="dayReportD" class="boardList02 mB5">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>나의업무보고</caption>
						<colgroup>
							<col class="col50" />
							<col width="px"/>
							<col width="px"/>
						</colgroup>
						<thead>
							<tr>
								<th>요일</th>
								<th>계획</th>
								<th class="td_last">실적</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="result" value="${dayReportDetail}"/>
							<c:set var="taskSize" value="${fn:length(result.taskList)}"/>
							<tr class="TrBg3" id="row_${weekDay.count}">
								<td class="txt_center SolLine Bg_color01" rowspan="${taskSize == 0 ? 1 : taskSize}">
									<a href="${rootPath}/cooperation/selectDayReport.do?searchDate=${searchDate }&searchUserNm=${searchVO.userNm }(${searchVO.userId })">
										${result.day}요일<br />
										<span class="T11"><print:date date="${result.date}" printType="S"/></span>
									</a>
								</td>
								<c:set var="taskLength" value="${fn:length(result.taskList)}"/>
								<c:if test="${empty result.taskList}">
									<td colspan="2" class="txt_center td_last SolLine pT5 pB5">등록된 작업이 없습니다.</td>
								</c:if>
								
							<c:forEach items="${result.taskList}" var="task" varStatus="c">
								<td class="verTop p5<c:if test="${c.count == taskSize}"> SolLine </c:if>">
									<p class="txtB_Black"><print:project prjId="${task.prjId}" prjCd="${task.prjCd}" prjNm="${task.prjNm}"/></p>
									<c:choose>
										<c:when test="${task.taskDuedate < result.date && task.taskDuedate != '' && task.taskState == 'P'}">
											<p><a href="${rootPath}/cooperation/selectTaskInfo.do?taskId=${task.taskId}"><span class="txtB_red">${task.taskSjPrint}</span></a></p>
											<p class="txt_red">기간 : ${task.taskStartdatePrint} ${task.taskStarttimePrint} ~ ${task.taskDuedatePrint} ${task.taskDuetimePrint} (예정일경과)</p>
										</c:when>
										<c:otherwise>
											<p>
											<a href="${rootPath}/cooperation/selectTaskInfo.do?taskId=${task.taskId}">
												<span class="txtB_blue2">${task.taskSjPrint}</span></a></p>
										</c:otherwise>
									</c:choose>
									
									<p><c:out value="${task.taskCnPrint}" escapeXml="false"/></p>
									<c:forEach items="${task.taskContentList}" var="taskContent">
										<p class="txtS_green"><a href="${taskContent.linkUrl}" target="_TC_LINK_">[${taskContent.taskCntTypPrint}] ${taskContent.taskCntSj}</a></p>
									</c:forEach>
								</td>
								<td class="td_last verTop<c:if test="${c.count == taskSize}"> SolLine </c:if>">
									<c:forEach items="${task.dayReportList}" var="dayReport">
									<ul class="BusiAchievements">
										<li class="Acon">${dayReport.dayReportCnPrint}</li>
										<li class="ATime">
											<ul>
												<li>[<span class="txt_blue">${dayReport.dayReportTm}시간</span>]</li>
											<c:if test="${user.admin}">
												<li>
<!--			                    					<a href="javascript:updateDayReport('${task.taskId}','${dayReport.no}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>-->
<!--	                    							<a href="javascript:deleteDayReport('${task.taskId}','${dayReport.no}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>-->
												</li>
											</c:if>
											</ul>
										</li>
									</ul>
									</c:forEach>
								</td>
								<c:out value="</tr>" escapeXml="false"/>
								<c:out value='<tr class="TrBg3}">' escapeXml="false"/>
								</c:forEach>
							</tr>
						</tbody>
						</table>
						</div>
						<!-- 나의업무보고 끝-->
						
						<!-- 관련프로젝트 개인별 인력투입실적 시작 -->
						<form name="subFrm2" method="POST">
						<p class="th_stitle3 mB20">관련프로젝트 <img class="cursorPointer toggleB btn_arrow_up" id="projectTB"/>
							<input type="hidden" name="no" value="${searchVO.no}"/>
							<label>
								<input type="checkbox" name="searchAllInputPrj" id="searchAllInputPrj" value="Y"
								onclick="javascript:searchUserInfo(${searchVO.no});"
								<c:if test="${searchAllInputPrj == 'Y'}">checked="checked"</c:if>/> 투입 프로젝트 전체보기
							</label>
						</p>
						
						<div id="projectD" class="boardList02 mB5" >
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>프로젝트 현황</caption>
							<colgroup>
								<col class="col70" />
								<col class="col120" />
								<col width="px"/>
								<col class="col70" />
								<col class="col70" />
							</colgroup>
							<thead>
								<tr>
									<th>이름</th>
									<th>부서</th>
									<th>프로젝트</th>
									<th>시간</th>
									<th class="td_last">투입율</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${inputResultPersonList}" var="result">
									<c:set var="irpSize" value="${fn:length(result.inputResultPersonList)}" />
									<tr>
										<td class="txt_center" rowspan="${irpSize + 1}"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center" rowspan="${irpSize + 1}">
										<a href="/management/selectInputResultPerson.do?searchUserMix=${searchVO.userNm }(${searchVO.userId })">
											<print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/>
										</a></td>
										
										<c:forEach items="${result.inputResultPersonList}" var="irp" varStatus="c">
											<td class="pL10"><print:project prjCd="${irp.prjCd}" prjId="${irp.prjId}" prjNm="${irp.prjNm}"/></td>
											<td class="txt_center">${irp.tm}</td>
											<td class="td_last txt_center">${irp.tmPercent}%</td>
									<c:out value="</tr>" escapeXml="false"/>
									<c:out value="<tr>" escapeXml="false"/>
										</c:forEach>
										<td class="td_last txt_center bG" colspan="3">투입시간 : ${result.totalTm}시간</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						</form>
						<!-- 관련프로젝트 개인별 인력투입실적 끝  -->
						
						<!-- 연장근무내역 시작  -->
						<p class="th_stitle3 mB20">연장근무내역 <img class="cursorPointer toggleB btn_arrow_up" id="overtimeTB"/></p>
						<div id="overtimeD">
							<div class="scheduleDate mB20">
								<a href="javascript:moveYear(-1,'overtime');" class="pR5"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
								<span id="overtimeYear">${thisYear}</span>년
								<a href="javascript:moveYear(1,'overtime');" class="pL5"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
							</div>
							<div class="boardList02 mB20" id="overtime">
								<c:import url="${rootPath}/member/selectOvertimeViewInc.do" charEncoding="utf-8">
									<c:param name="param_userNo" value="${searchVO.no}" />
									<c:param name="param_year" value="${thisYear}" />
								</c:import>
							</div>
						</div>
							<!--// 연장근무내역  끝  -->
							
							<!-- 휴가사용내역 시작  -->
							<p class="th_stitle3 mB20">휴가사용내역 <img class="cursorPointer toggleB btn_arrow_up" id="vacTB"/></p>
						<div id="vacD">
							<div class="scheduleDate mB20">
								<a href="javascript:moveYear(-1,'vacation');" class="pR5"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
								<span id="vacationYear">${thisYear}</span>년
								<a href="javascript:moveYear(1,'vacation');" class="pL5"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
							</div>
							<p class="th_stitle2 mT10">년도별 휴가사용 통계</p>
							<div class="boardList02 mB20" id="vacationSummary">
								<c:import url="${rootPath}/member/selectVacationSummaryViewInc.do" charEncoding="utf-8">
									<c:param name="param_userNo" value="${searchVO.no}" />
									<c:param name="param_year" value="${thisYear}" />
								</c:import>
							</div>
							<p class="th_stitle2 mT10">휴가사용 상세내역</p>
							<div class="boardList02 mB20" id="vacationSummaryDetail">
								<c:import url="${rootPath}/member/selectVacationSummaryDetailInc.do" charEncoding="utf-8">
									<c:param name="param_userNo" value="${searchVO.no}" />
									<c:param name="param_year" value="${thisYear}" />
								</c:import>
							</div>
						</div>
						<!--// 휴가사용내역  끝  -->
						
						<!-- 인사발령내역 시작  -->
						<p class="th_stitle3 mT20">인사발령내역 <img class="cursorPointer toggleB btn_arrow_up" id="personnelAppointmentTB"/></p>
						<div id="personnelAppointmentD" class="boardList">
							<c:import url="${rootPath}/member/selectPositionHistoryInc.do" charEncoding="utf-8">
								<c:param name="param_userNo" value="${searchVO.no}" />
							</c:import>
						</div>
						<!-- 게시판 끝  -->
					</div>
					<!-- E: section -->
					<form name="subFrm" method="POST">
						<input type="hidden" name="no" />
					</form>
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
<div class="search_layer" id="searchLayer" style="display:none;">
</div>
</body>
</html>
