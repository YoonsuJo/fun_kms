<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(dateMove) {

	var error = checkValidUserMixs(document.frm.searchUserNm.value);
	if(error["errorCode"] == 2 || error["errorCode"] == 3) {
		return;
	}
	
	document.frm.taskId.value = "";
	document.frm.taskState.value = "";
	document.frm.dateMove.value = dateMove;
	document.frm.action = "${rootPath}/mobile/cooperation/selectDayReport.do";
	document.frm.submit();
}
function updateState(taskId, taskState) {
	document.frm.taskId.value = taskId;
	document.frm.taskState.value = taskState;
	document.frm.action = "${rootPath}/mobile/cooperation/updateTaskState.do";
	document.frm.submit();
}
function viewTask(taskId) {
	document.frm.taskId.value = taskId;
	document.frm.action = "${rootPath}/mobile/cooperation/selectTaskInfo.do";
	document.frm.submit();
}

function writeTask(date) {
	document.frm.action = "${rootPath}/mobile/cooperation/insertTaskView.do?no=${searchVO.searchUserNo}&date=" + date;
	document.frm.submit();
	
}
function writeDayReport(taskId, userNo, searchDate) {
	document.frm.taskId.value = taskId;
	document.frm.userNo.value = userNo;
	document.frm.searchDate.value = searchDate;
	document.frm.action = "${rootPath}/mobile/cooperation/insertDayReportView.do";
	document.frm.submit();
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

function updateTask(taskId) {
	document.frm.taskId.value = taskId;
	document.frm.action = "${rootPath}/mobile/cooperation/updateTaskView.do";
	document.frm.submit();
}

function deleteTask(taskId) {
	if (confirm("이 업무를 삭제하면 그동안의 작업진행내역도 함께 삭제됩니다.\r\n정말로 삭제하시겠습니까?")) {
		document.frm.taskId.value = taskId;
		document.frm.action = "${rootPath}/mobile/cooperation/deleteTask.do";
		document.frm.submit();
	}
}

function updateDayReport(taskId, no) {
	document.frm.taskId.value = taskId;
	document.frm.no.value = no;
	document.frm.action = "${rootPath}/mobile/cooperation/updateDayReportView.do";
	document.frm.submit();
}

function deleteDayReport(taskId, no) {
	if (confirm("삭제하시겠습니까?")) {
		document.frm.taskId.value = taskId;
		document.frm.no.value = no;
		document.frm.action = "${rootPath}/mobile/cooperation/deleteDayReportPop.do";
		document.frm.submit();
	}
}

</script>
<div id="showhidden"></div>
<!-- S:Section Area -->
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>나의업무상세</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:58px;"><font class="fontShadow"><a href="javascript:writeTask('${result.date}');">계획등록</a></font></div>
</ul>
<div id="viw">
<form name="frm" id="searchFrm" method="GET" onsubmit="search(0); return false;">
<input type="hidden" name="taskId" value=""/>
<input type="hidden" name="taskState" value=""/>
<input type="hidden" name="dateMove" value="0"/>
<input type="hidden" name="no" value=""/>
<input type="hidden" name="userNo" value=""/>
<input type="hidden" name="param_returnUrl" value="/mobile/cooperation/selectDayReport.do?searchDate=${searchVO.searchDate}"/>
<input type="hidden" name="searchUserNm" id="searchUserNm" value="${searchVO.searchUserNm}"/>

<!-- S:콘텐츠 들어가는곳 -->

<div class="chh">
	<h1>
		<a href="javascript:search(-7);"><img src="http://static.naver.net/www/m/im/bl.gif" width="1" height="1" alt="이전일"><span class="dayy" style="padding:3px 6px 4px 6px; font-size:10px; color:gray"><<</span></a>
		<a href="javascript:search(-1);" class="pR10"><img src="http://static.naver.net/www/m/im/bl.gif" width="1" height="1" alt="이전일"><span class="dayy" style="padding:3px 6px 4px 6px; font-size:10px; color:gray"><</span></a>
		<span><input type="text" name="searchDate" value="${searchVO.searchDate}" maxlength="8" style="width:63px;" class="dayinput" /></span>
		<a href="javascript:search(1);" class="pL10"><img src="http://static.naver.net/www/m/im/bl.gif" width="1" height="1" alt="다음일"><span  class="dayy" style="padding:3px 6px 4px 6px; font-size:10px; color:gray">></span></a>
		<a href="javascript:search(7);"><img src="http://static.naver.net/www/m/im/bl.gif" width="1" height="1" alt="다음일"><span  class="dayy" style="padding:3px 6px 4px 6px; font-size:10px; color:gray">>></span></a>
	</h1>
	<div class="dayy" style="position:absolute; right:5px; top:6px; width:30px;"><a href="/mobile/cooperation/selectDayReport.do">오늘</a></div>
</div>

<c:forEach items="${resultList}" var="result" varStatus="weekDay">
<c:if test="${searchVO.searchDate == result.date}">
<c:set var="taskSize" value="${fn:length(result.taskList)}"/>
<c:forEach items="${result.taskList}" var="task" varStatus="c">
<hr class="hr_e1e1e1" />
<div id="workttl">
	<h1>계획내용</h1>
	<hr class="hr_e1e1e1" />
	<div class="works" style="position:absolute; right:8px; top:6px; width:30px;"><a href="javascript:updateTask('${task.taskId}');">수정</a></div>
	<div class="works" style="position:absolute; right:50px; top:6px; width:30px;"><a href="javascript:deleteTask('${task.taskId}');">삭제</a></div>
	<c:choose>
	<c:when test="${task.taskState == 'C'}">
	<div class="works" style="position:absolute; right:92px; top:6px; width:40px;">
		<a href="javascript:updateState('${task.taskId}', 'P');">미완료</a>
	</div>
	</c:when>
	<c:otherwise>
	<div class="works" style="position:absolute; right:92px; top:6px; width:30px;">
		<a href="javascript:updateState('${task.taskId}', 'C');">완료</a>
	</div>
	</c:otherwise>
	</c:choose>
</div>
<ul class="work_vclip">
	<li class="listG wrap_cont">
		<span class="cont">
		<c:choose>
			<c:when test="${task.taskDuedate < result.date && task.taskDuedate != '' && task.taskState == 'P'}">
			<span class="tit_txt list_shadow"><print:project prjId="${task.prjId}" prjCd="${task.prjCd}" prjNm="${task.prjNm}"/></span>
			<span class="texta">${task.taskSjPrint}</span>
			<p class="texta" style="font-size:12px">기간 : ${task.taskStartdatePrint} ${task.taskStarttimePrint} ~ ${task.taskDuedatePrint} ${task.taskDuetimePrint} (예정일경과)</p>
			</c:when>
			<c:otherwise>
			<span class="tit_txt list_shadow"><print:project prjId="${task.prjId}" prjCd="${task.prjCd}" prjNm="${task.prjNm}"/></span>
			<span class="textd">${task.taskSjPrint}</span>
			</c:otherwise>
		</c:choose>	
		</span>				
	</li>
</ul>
<p class="workViewA">
<c:forEach items="${task.taskContentList}" var="taskContent">
[${taskContent.taskCntTypPrint}] ${taskContent.taskCntSj}<br />
</c:forEach>
<c:out value="${task.taskCnPrint}" escapeXml="false"/>
</p>
<hr class="hr_e1e1e1" />
<div id="workttl">
	<h1>실적내용</h1>
	<hr class="hr_e1e1e1" />
	<div class="works" style="position:absolute; right:8px; top:6px; width:55px;"><a href="javascript:writeDayReport('${task.taskId}','${searchVO.searchUserNo}','${result.date}');">실적등록</a></div>
</div>
<div  style="position:relative"></div>
<p>
<c:forEach items="${task.dayReportList}" var="dayReport">
	<div id="work_detail" style="position:relative"><br />
	<div class="works" style="position:absolute; left:50px; bottom:15px; width:30px;"><a href="javascript:updateDayReport('${task.taskId}','${dayReport.no}');">수정</a></div>
	<div class="works" style="position:absolute; left:8px; bottom:15px; width:30px;"><a href="javascript:deleteDayReport('${task.taskId}','${dayReport.no}');">삭제</a></div>
	${dayReport.dayReportCnPrint}<br /><br /><br /><br />
	</div>
</c:forEach>
</p>
</c:forEach>
<c:if test="${fn:length(result.taskList) == 0}">
<br/>
<br/>
<h1 align="center">&nbsp;&nbsp;&nbsp;<b>등록된 계획이 없습니다.</b></h1>
<br/>
<br/>
</c:if>
</c:if>
</c:forEach>	
</form>
</div>

<div id="btn_ext">
	<div class="bgBtn shadowBtn btnTop btn_ext" style="width:50px; float:left;"><a href="" class="">위로<span class="bl_select"><img src="${commonMobilePath}/image/bl_select.png" alt="선택"/></span></a></div>
</div>
<div id="paginate"></div>
<jsp:include page="../include/footer.jsp"></jsp:include>