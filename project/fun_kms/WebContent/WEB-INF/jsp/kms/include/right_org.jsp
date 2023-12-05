<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<span id="right_arrow"><img src="${imagePath}/inc/arrow_right.gif" id="arrowImg" onclick="hidden_right(true);" class="cursorPointer"/></span>
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
	
	<div class="skill" >
		<c:set var="length" value="${fn:length(expList)}" />
		<dl>
			<dt>
				<ul class="right_title">
					<li class="title_txt">확장기능</li>
					<li class="btn_plus">
						<a href="javascript:popExpansion();"><img src="${imagePath}/btn/btn_plus.gif"/></a>
					</li>
				</ul>
			</dt>
			<dd>
				<c:forEach begin="0" end="5" var="i">
					<dl>
						<c:if test="${length > i}">
							<dt>
								<c:choose>
									<c:when test="${empty expList[i].expFileId || expList[i].expFileId == ''}">
										<!-- <a href="${expList[i].linkUrl}" <c:if test="${expList[i].pop}">target="_EXP_BLANK_"</c:if>> -->
										<a href="javascript:openLink('${expList[i].linkUrl}', '${expList[i].popYn}', '${expList[i].expId}', '${expList[i].popWidth}', '${expList[i].popHeight}');">
											<img src="${imagePath}/inc/bn01.gif"/>
										</a>
									</c:when>
									<c:otherwise>
										<!-- <a href="${expList[i].linkUrl}" <c:if test="${expList[i].pop}">target="_EXP_BLANK_"</c:if>> -->
										<a href="javascript:openLink('${expList[i].linkUrl}', '${expList[i].popYn}', '${expList[i].expId}', '${expList[i].popWidth}', '${expList[i].popHeight}');">
											<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${expList[i].expFileId}" />
												<c:param name="param_width" value="50" />
												<c:param name="param_height" value="45" />
											</c:import>
										</a>
									</c:otherwise>
								</c:choose>
							</dt>
							<dd>${expList[i].expSj}</dd>
						</c:if>
					</dl>
					<c:if test="${i == 2}">
						<c:out value="</dd><dd class='2ndline'>" escapeXml="false"/>
					</c:if>
				</c:forEach>
			</dd>
		</dl>
	</div>
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
if ("${user.showRight}" == "false" && ${showRight != true}) {
	hidden_right(false);
}

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