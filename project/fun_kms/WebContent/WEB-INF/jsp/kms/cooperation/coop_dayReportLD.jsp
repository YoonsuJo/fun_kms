<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(dateMove) {
	var error = checkValidUserMixsAuth(document.frm.searchUserNm.value);
	if(error["errorCode"] == 2 || error["errorCode"] == 3 || error["errorCode"] == 4) {
		return;
	}
	
	document.frm.taskId.value = "";
	document.frm.taskState.value = "";
	document.frm.dateMove.value = dateMove;
	document.frm.action = "${rootPath}/cooperation/selectDayReport.do";
	document.frm.submit();
}
function search2(dateMove) {
	var error = checkValidUserMixsAuth(document.form.searchUserNm.value);
	if(error["errorCode"] == 2 || error["errorCode"] == 3|| error["errorCode"] == 4) {
		return;
	}
	
	document.form.taskId.value = "";
	document.form.taskState.value = "";
	document.form.dateMove.value = dateMove;
	document.form.action = "${rootPath}/cooperation/selectDayReport.do";
	document.form.submit();
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
	if(typ == 'MY'){
		document.frm.action = "${rootPath}/cooperation/selectDayReportMyList.do";
		document.frm.submit();
		}else{
		$.post("/member/updateUiSetting.do?dayReportTyp=" + typ, function(data) {
			if (data == '\r\nsuccess') {
				location.reload();
			}
		});
	}
}
function showBtn(idx) {
	document.getElementById("btn_1_" + idx).style.display = "";
	document.getElementById("btn_2_" + idx).style.display = "";
}
function hideBtn(idx) {
	document.getElementById("btn_1_" + idx).style.display = "none";
	document.getElementById("btn_2_" + idx).style.display = "none";
}
function setLeader(leader) {
	document.frm.searchUserNm.value = leader;
	search(0);
}
$('document').ready(function() {
	$('.toggle_select').addClass('mB20');
	
	//토글 버튼 활성화
	$('.toggle_select').click(function(){
		if($(this).hasClass('btn_arrow_down')){
			$(this).removeClass('btn_arrow_down');
			$(this).addClass('btn_arrow_up');
			$('.toggle_select').removeClass('mB20');
			$('#toggle_select_div').show();
		}
		else{
			$(this).removeClass('btn_arrow_up');
			$(this).addClass('btn_arrow_down');
			$('.toggle_select').addClass('mB20');
			$('#toggle_select_div').hide();
		}
	});
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
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
			<div id="center">
				<div class="path_navi">
					<ul>
						<li class="stitle">나의업무 상세보기</li>
						<li class="navi">홈 > 업무공유  > 업무계획/실적  > 나의업무 상세보기</li>
					</ul>
				</div>
				
				<span class="stxt">개인별 업무계획 및 실적을 관리하는 곳입니다. 작업을 등록하시려면 날짜를 클릭해주세요.</span>
				<span class="stxt_btn">
					<a href="javascript:dayReportTyp('MY');"><img src="${imagePath}/btn/btn_myview.gif"/></a>
					<a href="javascript:dayReportTyp('B');"><img src="${imagePath}/btn/btn_sumview.gif"/></a>
				</span>
				
				<!-- S: section -->
				<div class="section01">
				
				<!-- 상단 검색창 시작 -->
				<form name="frm" id="searchFrm" method="GET" onsubmit="search(0); return false;">
					<input type="hidden" name="taskId" value=""/>
					<input type="hidden" name="taskState" value=""/>
					<input type="hidden" name="dateMove" value="0"/>
					<input type="hidden" name="no" value=""/>
					<input type="hidden" name="userNo" value="${user.userNo}"/>
					<input type="hidden" name="param_returnUrl" value="/cooperation/selectDayReport.do"/>
					<!-- <fieldset>
					<legend>상단 검색</legend>
						<div class="scheduleDate mB20">
							<ul>
							<li class="li_left">
								<a href="javascript:search(-7);"><img src="${imagePath}/btn/btn_first.gif"/></a>
								<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif"></a> -->
								<!-- <span class="option_txt">2011년 8월 4일</span> -->
								<!--<input type="text" name="searchDate" value="${searchVO.searchDate}" class="calGen" maxlength="8" style="width:55px;"/>
								<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif"></a>
								<a href="javascript:search(7);"><img src="${imagePath}/btn/btn_end.gif"></a>
							</li>
							<li class="li_right">
								<span class="option_txt">사용자</span><span class="pL7"></span>
								<input type="text" name="searchUserNm" id="searchUserNm" class="search_txt02 userNameAuto userValidateCheck" value="${searchVO.searchUserNm}"/>
								<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm',1);"/>
								<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색"/>
							</li>
							</ul>
						</div>
					</fieldset> -->
					
																																			<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<colgroup>
							<col width="160px;">
							<col width="*">
							<col width="80px;">
						</colgroup>
						<tbody>
							<tr>
								<td class="val_Top pT5 pL5">
									<a href="javascript:search(-7);"><img src="${imagePath}/btn/btn_first.gif"/></a>
									<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif"></a>
									<!-- <span class="option_txt">2011년 8월 4일</span> -->
									<input type="text" name="searchDate" value="${searchVO.searchDate}" class="calGen" maxlength="8" style="width:55px;"/>
									<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif"></a>
									<a href="javascript:search(7);"><img src="${imagePath}/btn/btn_end.gif"></a>
								</td>
								<td class="pT5" style="text-align: right;">
									<span class="option_txt">사용자 : </span><span class="pL7"></span>
									<input type="text" class="search_txt02 userNameAuto userValidateCheckAuth" name="searchUserNm" id="searchUserNm" value="${searchVO.searchUserNm}"/>
									<!-- <img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm',1);" /> -->
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm', 1, null, null, '1');" />
									<span class="pL7"></span>
								</td>
								<td class="val_Top search_right" rowspan="2">
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색"/>
								</td>
							</tr>
							<tr>
								<td class="pT5 txt_left" colspan="3" style="text-align: left;">
									<span class="option_txt">빠른 선택</span>
									<a href="javascript:setLeader('${searchVO.searchUserNm}');">${quickUserNm}</a>
									<img class="btn_arrow_down cursorPointer toggle_select"/>
									<div id="toggle_select_div" style="display:none;">
										<table>
											<fmt:parseNumber var="parseNum" value="${fn:length(resultList1)/12}" integerOnly="true" />
											<c:set var="totalTr" value="${parseNum}"/>
											<c:set var="plusTd" value="${(fn:length(resultList1)%12)}"/>
											<c:set var="endTd" value="${12 - plusTd}"/>
											<c:set var="curTr" value="${0}"/>
											<c:forEach items="${resultList1}" var="resultList1" varStatus="cnt2">
												<c:if test="${cnt2.count == 1}">
													<tr>
												</c:if>
													<td width="8%"><a href="javascript:setLeader('${resultList1.userNm}(${resultList1.userId})');">${resultList1.userNm}</a></td>
												<c:if test="${totalTr == curTr && cnt2.count == plusTd}">
													<c:forEach var="in" begin="1" end="${endTd}">
														<td width="8%">&nbsp;</td>
													</c:forEach>
												</c:if>
												<c:if test="${cnt2.count != 1 && cnt2.count % 12 == 0 && cnt2.last == false}">
													</tr>
													<tr>
													<c:set var="curTr" value="${curTr+1}"/>
												</c:if>
												<c:if test="${cnt2.last}">
													</tr>
												</c:if>
											</c:forEach>
										</table>
									</div>
									<!--<span class="option_txt">빠른 선택 :</span>
									<a href="javascript:setLeader('${user.userNm}(${user.userId})');">${user.userNm }</a>
									<span class="pL7"></span><img class="btn_arrow_down cursorPointer toggle_select"/>
									<div id="toggle_select_div">
										<c:forEach items="${resultList1}" var="resultList1" varStatus="cnt0">
										<a href="javascript:setLeader('${resultList1.userNm}(${resultList1.userId})');">${resultList1.userNm}</a>
										<span class="pL7"></span>
										</c:forEach>
									</div> -->
								</td>
							</tr>
							<tr>
							</tr>
						</tbody>
						</table>
						</div>
					</fieldset>
					
				</form>
				<!--// 상단 검색창 끝 -->
				
				
				<!-- 게시판 시작  -->
					<p class="th_plus04">
						<a href="#row_1"><img src="${imagePath}/btn/btn_Mon.gif"/></a>
						<a href="#row_2"><img src="${imagePath}/btn/btn_Tue.gif"/></a>
						<a href="#row_3"><img src="${imagePath}/btn/btn_Wed.gif"/></a>
						<a href="#row_4"><img src="${imagePath}/btn/btn_Thu.gif"/></a>
						<a href="#row_5"><img src="${imagePath}/btn/btn_Fri.gif"/></a>
						<a href="#row_6"><img src="${imagePath}/btn/btn_Sat.gif"/></a>
						<a href="#row_7"><img src="${imagePath}/btn/btn_Sun.gif"/></a>
					</p>
					<p class="th_plus03">
						<a href="javascript:writeTask('');"><img src="${imagePath}/btn/btn_newWork.gif"/></a>
					</p>
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
							<tr class="TrBg${searchVO.today == result.date ? 2 : 3}" id="row_${weekDay.count}">
								<td class="txt_center SolLine Bg_color0${searchVO.today == result.date ? 2 : 1}" rowspan="${taskSize == 0 ? 1 : taskSize}">
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
											<!-- <p class="txt_blue3">기간 : ${task.taskStartdatePrint} ~ ${task.taskDuedatePrint} ${task.taskDuetimePrint}</p> -->
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
										<li class="Acon">${dayReport.dayReportCnPrint}<br/>
											<c:if test="${!empty dayReport.attachFileId}">
												<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${dayReport.attachFileId}" />
												</c:import>
											</c:if>
										</li>
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
							<c:out value='<tr class="TrBg${searchVO.today == result.date ? 2 : 3}">' escapeXml="false"/>
								</c:if>
								</c:forEach>
							</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<div class="btn_area02 mB10">
						<a href="javascript:writeTask('');"><img src="${imagePath}/btn/btn_newWork.gif"/></a>
						<a href="#searchFrm"><img src="${imagePath}/btn/btn_top.gif"/></a>
					</div>
					
					<!--// 게시판  끝  -->
					
				<!-- 하단 검색창 시작 -->
				<form name="form" id="searchFrm" method="GET" onsubmit="search2(0); return false;">
					<input type="hidden" name="taskId" value=""/>
					<input type="hidden" name="taskState" value=""/>
					<input type="hidden" name="dateMove" value="0"/>
					<input type="hidden" name="no" value=""/>
					<input type="hidden" name="userNo" value="${user.userNo}"/>
					
					<input type="hidden" name="param_returnUrl" value="/cooperation/selectDayReport.do"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="scheduleDate mB20">
							<ul>
							<li class="li_left">
								<a href="javascript:search(-7);"><img src="${imagePath}/btn/btn_first.gif"/></a>
								<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif"></a>
								<!-- <span class="option_txt">2011년 8월 4일</span> -->
								<input type="text" name="searchDate" value="${searchVO.searchDate}" class="calGen" maxlength="8" style="width:55px;"/>
								<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif"></a>
								<a href="javascript:search(7);"><img src="${imagePath}/btn/btn_end.gif"></a>
							</li>
							<li class="li_right">
								<span class="option_txt">사용자</span><span class="pL7"></span>
								<input type="text" name="searchUserNm" id="searchUserNm" class="search_txt02 userNameAuto userValidateCheck" value="${searchVO.searchUserNm}"/>
								<!-- <img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm',1);"/> -->
								<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm', 1, null, null, '1');" />
								<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색"/>
							</li>
							</ul>
						</div>
					</fieldset>
				</form>
				<!--// 하단 검색창 끝 -->
					
					<div class="boardList02 mT20">
						<c:import url="${rootPath}/cooperation/postTaskList.do">
							<c:param name="param_eDate" value="${dateList[6].date}" />
							<c:param name="param_userNo" value="${searchVO.searchUserNo}" />
						</c:import>
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