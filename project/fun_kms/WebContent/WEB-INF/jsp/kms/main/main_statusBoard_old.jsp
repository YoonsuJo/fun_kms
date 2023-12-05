<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<link rel="stylesheet" href="${commonPath}/css/main.css" type="text/css" media="all" />
<script>
function changeTab(obj) {
	var ul = document.getElementById("statusBoardTab");

	for (var i=0; i<ul.childNodes.length; i++) {
		var tmp = ul.childNodes[i];
		if (tmp.tagName == "li" || tmp.tagName == "LI") {
			if (obj.title == tmp.title) {
				tmp.className = "on cursorPointer";
				document.getElementById(tmp.title).style.display = "";
			} else {
				tmp.className = "off cursorPointer";
				document.getElementById(tmp.title).style.display = "none";
			}
		}
	}
}
function showTaskLayer(taskId, obj) {
	var position = $(obj).position();
	var height = $(obj).height();
	var width = $(obj).width();
	
	$('#situation_layer').html("");
	$.post("${rootPath}/ajax/statusBoardTaskLayer.do?taskId=" + taskId, function(data){
		$('#situation_layer').html(data);
	});
	$('#situation_layer').get(0).style.top = position.top + (height / 2) + "px";
	$('#situation_layer').get(0).style.left = position.left + width - 10 + "px";
	$('#situation_layer').show();
}
function hideTaskLayer() {
	$('#situation_layer').hide();
}
function showScheduleLayer(scheId, obj) {
	var act = new yAjax("${rootPath}/ajax/getScheduleXml.do", "POST");
	act.send = "scheId=" + scheId;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var title = xml.getValue("title",0);
		var time = xml.getValue("time",0);
		var write = xml.getValue("write",0);
		var content = xml.getValue("content",0);
		document.getElementById("TT").innerHTML = title;
		document.getElementById("TM").innerHTML = time;
		document.getElementById("WR").innerHTML = write;
		document.getElementById("CN").innerHTML = content;
	};
	act.action();

	var position = $(obj).position();
	var height = $('#situation_layer02').height();
	var width = $(obj).width();
	
	$('#situation_layer02').get(0).style.top = position.top - height + 10 + "px";
	$('#situation_layer02').get(0).style.left = position.left + width - 10 + "px";
	$('#situation_layer02').show();
}
function hideScheduleLayer() {
	$('#situation_layer02').hide();
}
function writeTask() {
	var popup = window.open("${rootPath}/cooperation/insertTaskView.do?no=${user.no}","_TASK_POP_","width=560px,height=350px,scrollbars=yes");
	popup.focus();
}
function busiRefresh() {
	$.post("${rootPath}/statusBoardBusiCntct.do",function(data) {
		$('#busiCntct').html(data);
	});
}
function eappRefresh() {
	$.post("${rootPath}/statusBoardEapp.do",function(data) {
		$('#eapp').html(data);
	});
}
function statusBoardTimer() {
	eappRefresh();
	busiRefresh();
	setTimeout("statusBoardTimer()",60000);
}

$(document).ready(function() {
	statusBoardTimer();
});
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
			<%@ include file="left.jsp"%>
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
					
					<div class="Height02" id="busiCntct">
						<c:import url="${rootPath}/statusBoardBusiCntct.do"></c:import>
					</div>
					<!-- S: 전자결재 -->
					<div class="Height" id="eapp">
						<c:import url="${rootPath}/statusBoardEapp.do"></c:import>
					</div>
					<!-- E: 전자결재 -->
					
					<!-- S: 오늘의 할일 -->
					<div class="situation01">
						<c:set var="taskLength" value="${fn:length(taskList)}"/>
						<span class="th_stitle_left mB5">오늘의 할일</span>
						<span class="btn_area06 mB5">
							<a href="javascript:writeTask();"><img src="${imagePath}/btn/btn_write01.gif"/></a>
							<a href="${rootPath}/cooperation/selectDayReport.do"><img src="${imagePath}/btn/btn_more.gif"/></a>
						</span>
						<div class="todayWork">
							<ul>
								<c:if test="${empty taskList}">
									<li class="non">등록된 작업이 없습니다.</li>
								</c:if>
								<c:forEach items="${taskList}" var="task" varStatus="c">
									<li class="cursorPointer<c:if test="${c.count == taskLength}"> bottom_line</c:if>"
										onmouseover="showTaskLayer('${task.taskId}',this)" onmouseout="hideTaskLayer();"
										onclick="location.href='${rootPath}/cooperation/selectTaskInfo.do?taskId=${task.taskId}'">
										<dl>
											<c:choose>
												<c:when test="${task.taskDuedate < today && task.taskDuedate != ''}">
													<dt class="txtB_red">${task.taskSjPrint}</dt>
													<dd class="txt_red2">완료예정일 : ${task.taskDuedatePrint}</dd>
			                   					</c:when>
			                   					<c:when test="${task.taskDuedate == today}">
					                    			<dt class="txtB_blue2">${task.taskSjPrint}</dt>
					                    			<dd class="txt_blue3">완료예정일 : ${task.taskDuedatePrint}</dd>
			                   					</c:when>
			                   					<c:otherwise>
					                    			<dt class="txtB_Black">${task.taskSjPrint}</dt>
					                    			<dd class="txt_grey">완료예정일 : ${task.taskDuedatePrint}</dd>
			                   					</c:otherwise>
											</c:choose>
										</dl>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<!-- E: 오늘의 할일 -->
					
					<!-- S: 관련자 부재현황 -->
					<div class="situation02">
						<span class="th_stitle_left mB5">관련자 부재현황</span>
						<span class="btn_area06 mB5">
							<a href="${rootPath}/member/selectAbsenceState.do"><img src="${imagePath}/btn/btn_more.gif"/></a>
						</span>
						<div class="boardList">
						<table cellpadding="0" cellspacing="0" summary="관련자 부재현황 목록입니다.">
						<caption>관련자 부재현황</caption>
						<colgroup>
							<col class="col50" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">이름</th>
							<th scope="col">부재현황</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${stateList}" var="state">
								<tr>
									<td class="txt_center"><print:user userNm="${state.userNm}" userNo="${state.userNo}" userId="${state.userId}"/></td>
									<td class="txt_center">${state.state}(${state.period})</td>
								</tr>
							</c:forEach>
							<c:if test="${empty stateList}">
								<tr>
									<td class="txt_center" colspan="2">부재자가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					</div>
					<!-- E: 관련자 부재현황 -->
				
					<!-- S: 주요일정 -->
					<div class="situation03">
						<c:set var="scheduleLength" value="${fn:length(scheduleList)}"/>
						<span class="th_stitle_left mB5">주요일정</span>
						<span class="btn_area06 mB5">
							<a href="${rootPath}/community/addScheduleView.do"><img src="${imagePath}/btn/btn_write01.gif"/></a>
							<a href="${rootPath}/community/scheduleCalendar.do"><img src="${imagePath}/btn/btn_more.gif"/></a>
						</span>
						<div class="todayWork">
							<ul>
								<c:if test="${empty scheduleList}">
									<li class="non">등록된 일정이 없습니다.</li>
								</c:if>
								<c:forEach items="${scheduleList}" var="schedule" varStatus="c">
									<li class="cursorPointer<c:if test="${c.count == scheduleLength}"> bottom_line</c:if>"
										onmouseover="showScheduleLayer('${schedule.scheId}',this)" onmouseout="hideScheduleLayer();"
										onclick="location.href='${rootPath}/community/scheduleList.do?scheYear=${schedule.scheYear}&scheMonth=${schedule.scheMonth}&scheDate=${schedule.scheDate}';">
										<span class="icon">
											<c:choose>
												<c:when test="${schedule.scheTyp == 'C'}">
													<img src="${imagePath}/community/ico_schedule_01.gif" />
												</c:when>
												<c:when test="${schedule.scheTyp == 'T'}">
													<img src="${imagePath}/community/ico_schedule_02.gif" />
												</c:when>
												<c:when test="${schedule.scheTyp == 'P'}">
													<img src="${imagePath}/community/ico_schedule_03.gif" />
												</c:when>
												<c:otherwise>
												</c:otherwise>
											</c:choose>
										</span>
										<dl>
											<c:choose>
												<c:when test="${schedule.today}">
													<dt class="title txt_blue">${schedule.scheDateStateBoard}</dt>
													<dd class="contents txt_blue"><c:out value="${schedule.scheSjShort}" /></dd>
												</c:when>
												<c:when test="${schedule.tomorrow}">
													<dt class="title txtB_Black">${schedule.scheDateStateBoard}</dt>
													<dd class="contents txtB_Black"><c:out value="${schedule.scheSjShort}" /></dd>
												</c:when>
												<c:otherwise>
													<dt class="title">${schedule.scheDateStateBoard}</dt>
													<dd class="contents"><c:out value="${schedule.scheSjShort}" /></dd>
												</c:otherwise>
											</c:choose>
										</dl>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<!-- E: 주요일정 -->
					
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
