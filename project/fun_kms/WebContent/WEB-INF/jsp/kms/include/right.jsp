<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<span id="right_arrow"></span>
<script>
function modifySchedule2(scheId) {
	location.href = "${rootPath}/community/modifySchedule.do?scheId=" + scheId;
}
function deleteSchedule2(scheId) {
	if (confirm("삭제하시겠습니까?")) {
		location.href = "${rootPath}/community/deleteSchedule.do?scheId=" + scheId;
	}
}
function popExpansion() {
	var popup = window.open('${rootPath}/mypage/expansionPop.do','_POP_EXP_','width=485px,height=470px;');
	popup.focus();
}

function writeTask2() {
	var popup = window.open("${rootPath}/cooperation/insertTaskView.do?no=${user.no}&date=${calendarInfo.date}","_TASK_POP_","width=570px,height=450px,scrollbars=yes,resizable=yes");
	popup.focus();
}
function writeDayReport2(taskId) {
	var popup = window.open("${rootPath}/cooperation/insertDayReportView.do?taskId=" + taskId + "&userNo=${user.no}&searchDate=${calendarInfo.date}","_DAY_REPORT_POP_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}
function goSchedule() {
	this.location.href = "${rootPath}/community/scheduleList.do?scheYear=" + document.rightCalFrm.calYear.value + "&scheMonth=" + document.rightCalFrm.calMonth.value + "&scheDate=" + document.rightCalFrm.date.value.substring(6,8);
}
</script>
<form id="rightCalFrm" name="rightCalFrm" method="POST" class="hidden">
	<input type="hidden" name="calYear" value="${calendarInfo.calYear}"/>
	<input type="hidden" name="calMonth" value="${calendarInfo.calMonth}"/>
	<input type="hidden" name="date" value="${calendarInfo.date}"/>
</form>

<!-- S: right -->
<div id="right">
	<!--달력-->
	<div class="calendar" id="calBody" >
	</div>
	
	<!--일정/할일-->
	<div class="schedule" id="scheBody">
	</div>
	
<!--나의메뉴-->
<!--	<div class="mymenu">-->
<!--		<dl>-->
<!--			<dt>-->
<!--				<ul class="right_title">-->
<!--					<li class="title_txt">나의메뉴</li>-->
<!--					<li class="btn_plus"><a href="${rootPath}/mypage/MymenuList.do"><img src="${imagePath}/btn/btn_plus.gif"/></a></li>-->
<!--				</ul>-->
<!--			</dt>-->
<!--			<c:forEach items="${myMenuList}" var="menu">-->
<!--				<dd><a href="${menu.linkUrl}"><c:out value="${menu.menuSj}" /></a></dd>-->
<!--			</c:forEach>-->
<!--		</dl>-->
<!--	</div>-->
	
</div>

<!-- 마우스 오버했을시 상세정보 -->
<div id="sdetail_info" style="display:none;">
	<dl>
		<dt id="sSj"></dt>
		<dd>
			<ul class="layer_left">
				<li>시&nbsp;&nbsp;&nbsp;간</li>
				<li id="hOrg">부&nbsp;&nbsp;&nbsp;서</li>
				<li>작성자</li>
				<li>내&nbsp;&nbsp;&nbsp;용</li>
			</ul>
			<ul class="layer_right">
				<li id="sTm"></li>
				<li id="sOrg"></li>
				<li id="sNo"></li>
				<li id="sCn"></li>
			</ul>
		</dd>
	</dl>
</div>
<script>
right.style.display='none';
document.getElementById('center').style.width='942px';
$('#center').trigger('hideRightEvent');

//hidden_right(true);

function openLink(linkUrl, popYn, expId, popW, popH) {
	if (popYn == 'Y') {
		var target = "_EXP_BLANK_" + expId;

		var option = "";
		if (popW.length > 0 && popH.length > 0) option = "width=" + popW + "px,height=" + popH + "px" + ",scrollbars=yes,resizable=yes";
		
		if(linkUrl.indexOf("222.112.235.135") > -1){
			linkUrl = "http://222.112.235.135/game/startV.jsp?id=${user.userId}&no=${user.no}";
		}	
		
		var popup = window.open(linkUrl, target, option);
		popup.focus();
	}
	else {
		location.replace(linkUrl);
	}
}

</script>
<!--// 마우스 오버했을시 상세정보 -->
<!-- E: right -->