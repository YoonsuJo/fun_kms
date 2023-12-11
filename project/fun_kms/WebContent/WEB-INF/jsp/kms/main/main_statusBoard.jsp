<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<link rel="stylesheet" href="${commonPath}/css/main.css" type="text/css" media="all" />
<script>

function projectSearch(pageIndex) {
	document.projectFrm.pageIndex.value = pageIndex;
	$.post("${rootPath}/ajax/selectProjectList3.do", $('#projectFrm').serialize(), function(data) {
		$('#projectInnerD').html(data);
	});
}
function viewProject(prjId){
	var form = $('#searchVO');
	form.attr("action", "/project/viewProjectPop.do?prjId="+prjId);
	form.submit();
}

function updateState(taskId, taskState) {
	document.frm.taskId.value = taskId;
	document.frm.taskState.value = taskState;
	document.frm.action = "${rootPath}/cooperation/updateTaskState.do";
	document.frm.submit();
}
function viewTask(taskId) {
	document.frm.taskId.value = taskId;
	document.frm.action = "${rootPath}/cooperation/selectTaskInfo.do";
	document.frm.submit();
}
function deleteDayReport(taskId, no) {
	if (confirm("삭제하시겠습니까?")) {
		document.frm.taskId.value = taskId;
		document.frm.no.value = no;
		document.frm.action = "${rootPath}/cooperation/deleteDayReportPop.do";
		document.frm.submit();
	}
}

function writeTask(date) {
	var popup = window.open("${rootPath}/cooperation/insertTaskView.do?no=${searchVO.searchUserNo}&date=" + date,"_TASK_POP_","width=570px,height=450px,scrollbars=yes,resizable=yes");
	popup.focus();
}
function writeDayReport(taskId,userNo,searchDate) {
	var popup = window.open("${rootPath}/cooperation/insertDayReportView.do?taskId=" + taskId + "&userNo=" + userNo + "&searchDate=" + searchDate,"_DAY_REPORT_POP_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}

function updateDayReport(taskId, no) {
	var popup = window.open("${rootPath}/cooperation/updateDayReportView.do?taskId=" + taskId + "&no=" + no,"_DAY_REPORT_POP_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}

function dayReportTyp(typ) {
	$.post("/member/updateUiSetting.do?dayReportTyp=" + typ, function(data) {
		if (data == '\r\nsuccess') {
			location.reload();
		}
	});
}
function showBtn(idx) {
	document.getElementById("btn_1_" + idx).style.display = "";
	document.getElementById("btn_2_" + idx).style.display = "";
}
function hideBtn(idx) {
	document.getElementById("btn_1_" + idx).style.display = "none";
	document.getElementById("btn_2_" + idx).style.display = "none";
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
			<%@ include file="left_status.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
			<div id="center">
				<div class="path_navi">
					<ul>
						<li class="stitle">현황판</li>
						<li class="navi">홈 > 현황판</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
					<form:form commandName="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
					</form:form>
					
					<span class="th_stitle_left pB10">참여중인 프로젝트 <a id="btnMoreInterestProject" href="javascript:switchProjectList();"><img src="${imagePath}/btn/btn_more.gif"/></a></span>
					<div class="boardList02 mB20" id="ProjectChildD">
						<form name="projectFrm" id="projectFrm" method="POST" onsubmit="projectSearch(1); return false;">
						<input type="hidden" name="pageIndex"/>
						<input type="hidden" name="searchStat" value="P"/>
						<div id="projectInnerD">
							<c:import url="${rootPath}/ajax/selectProjectList3.do">
								<c:param name="pageIndex" value="1"/>
								<c:param name="searchStat" value="P"/>
							</c:import>
						</div>
						</form>
					</div>
					
					<!-- S: 나의업무현황 -->
					<form name="frm" id="searchFrm" method="GET" onsubmit="search(0); return false;">
						<input type="hidden" name="taskId" value=""/>
						<input type="hidden" name="taskState" value=""/>
						<input type="hidden" name="dateMove" value="0"/>
						<input type="hidden" name="no" value=""/>
						<input type="hidden" name="param_returnUrl" value="/statusBoard.do"/>
						<input type="hidden" name="searchDate" value="${searchVO.searchDate}" class="calGen" maxlength="8" style="width:55px;"/>
						<input type="hidden" name="searchUserNm" id="searchUserNm" class="search_txt02 userNameAuto userValidateCheck" value="${searchVO.searchUserNm}"/>
					</form>
					<div>
						<span class="th_stitle_left pB10">나의업무현황</span>
						<span class="th_stitle_right"><a href="javascript:writeTask('');"><img src="${imagePath}/btn/btn_newWork.gif"/></a></span>
					</div>
					<div class="boardList02 mB5">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>프로젝트 현황</caption>
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
							<c:forEach items="${resultList}" var="result" varStatus="weekDay">
							<c:set var="taskSize" value="${fn:length(result.taskList)}"/>
							<c:choose>
							<c:when test="${searchVO.today == result.date}">
								<tr class="TrBg3" id="row_${weekDay.count}">
									<td class="txt_center SolLine Bg_color01" rowspan="${taskSize == 0 ? 1 : taskSize}">
										${result.day}요일<br />
										<span class="T11"><a href="javascript:writeTask('${result.date}');"><print:date date="${result.date}" printType="S"/></a></span>
									</td>
									<c:set var="taskLength" value="${fn:length(result.taskList)}"/>
									<c:if test="${empty result.taskList}">
									<td colspan="2" class="txt_center td_last SolLine pT5 pB5">등록된 작업이 없습니다.</td>
									</c:if>
									<c:forEach items="${result.taskList}" var="task" varStatus="c">
									<td class="verTop p5<c:if test="${c.count == taskSize}"> SolLine </c:if>" onmouseover="showBtn('${weekDay.count}_${c.count}')" onmouseout="hideBtn('${weekDay.count}_${c.count}')">
										<p class="txtB_Black"><print:project prjId="${task.prjId}" prjCd="${task.prjCd}" prjNm="${task.prjNm}"/></p>
										<c:choose>
											<c:when test="${task.taskDuedate < result.date && task.taskDuedate != '' && task.taskState == 'P'}">
												<p><a href="javascript:viewTask('${task.taskId}');"><span class="txtB_red">${task.taskSjPrint}</span></a></p>
												<p class="txt_red">기간 : ${task.taskStartdatePrint} ${task.taskStarttimePrint} ~ ${task.taskDuedatePrint} ${task.taskDuetimePrint} (예정일경과)</p>
											</c:when>
											<c:otherwise>
												<p><a href="javascript:viewTask('${task.taskId}');"><span class="txtB_blue2">${task.taskSjPrint}</span></a></p>
												<p class="txt_blue3">기간 : ${task.taskStartdatePrint} ${task.taskStarttimePrint} ~ ${task.taskDuedatePrint} ${task.taskDuetimePrint}</p>
											</c:otherwise>
										</c:choose>
										
										<p><c:out value="${task.taskCnPrint}" escapeXml="false"/></p>
										<c:forEach items="${task.taskContentList}" var="taskContent">
										<p class="txtS_green"><a href="${taskContent.linkUrl}" target="_TC_LINK_">[${taskContent.taskCntTypPrint}] ${taskContent.taskCntSj}</a></p>
										</c:forEach>
										<p class="P_height">
											<c:if test="${task.userNo == user.no || user.admin}">
											<a href="javascript:writeDayReport('${task.taskId}','${searchVO.searchUserNo}','${result.date}');"><img src="${imagePath}/btn/btn_result02.gif" id="btn_1_${weekDay.count}_${c.count}" style="display:none;"/></a>
											<c:choose>
												<c:when test="${task.taskState == 'C'}">
											<a href="javascript:updateState('${task.taskId}', 'P');"><img src="${imagePath}/btn/btn_uncomplete.gif" id="btn_2_${weekDay.count}_${c.count}" style="display:none;"/></a>
												</c:when>
												<c:otherwise>
											<a href="javascript:updateState('${task.taskId}', 'C');"><img src="${imagePath}/btn/btn_complete02.gif" id="btn_2_${weekDay.count}_${c.count}" style="display:none;"/></a>
												</c:otherwise>
											</c:choose>
											</c:if>
										</p>
										
									</td>
									<td class="td_last verTop<c:if test="${c.count == taskSize}"> SolLine </c:if>">
										<c:forEach items="${task.dayReportList}" var="dayReport">
										<ul class="BusiAchievements">
											<li class="Acon">${dayReport.dayReportCnPrint}</li>
											<li class="ATime">
												<ul>
													<li>[<span class="txt_blue">${dayReport.dayReportTm}시간</span>]</li>
													<li>
														<a href="javascript:updateDayReport('${task.taskId}','${dayReport.no}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
														<a href="javascript:deleteDayReport('${task.taskId}','${dayReport.no}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
													</li>
												</ul>
											</li>
										</ul>
										</c:forEach>
									</td>
									<c:if test="${taskLength != c.count}">
								<c:out value="</tr>" escapeXml="false"/>
								<c:out value='<tr class="TrBg3">' escapeXml="false"/>
									</c:if>
									</c:forEach>
								</tr>
							</c:when>
							<c:otherwise>
							</c:otherwise>
							</c:choose>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<!-- E: 나의업무현황 -->
					
					<div id="situation_layer" style="display:none;">
						<dl>
							<dt>[프로젝트코드] 프로젝트명</dt>
							<dd class="title">작업제목입니다	</dd>
							<dd>완료예정일 : 2011.09.06</dd>
							<dd>작업 상세 내용입니다...여러줄로 표시할 수 있습니다....</dd>
							<dd class="add_link">[업무연락] 신규 KMS 화면 구성자료 공유</dd>
							<dd class="add_link">[관련자료 종류] 관련자료 제목</dd>
						</dl>
					</div>
					
					<div id="situation_layer02" style="display:none;">
						<dl>
							<dt id="TT">정기현 과장 애기 돌잔치</dt>
							<dd>
								<ul class="layer_left">
									<li>시&nbsp;&nbsp;&nbsp;간</li>
									<li>작성자</li>
									<li>내&nbsp;&nbsp;&nbsp;용</li>
								</ul>
								<ul class="layer_right">
									<li id="TM">14:30~15:30</li>
									<li id="WR">안태규</li>
									<li id="CN">정기현과장 딸 정시원 돌잔치정기현과장 딸 정시원 돌잔치정기현과장 딸 정시원 돌잔치</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
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
