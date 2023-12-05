<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>
var chk = false;
var chkErrorChk = "";

function register() {
	document.dailyPlanFm.action = '<c:url value="/daily/insertDailyPlan.do" />';
	document.dailyPlanFm.submit();
}
function changeOutWork() {

	var workTimeTR = document.getElementById("outsideWorkTime");
	var workPlaceTR = document.getElementById("outsideWorkPlace");
	
	if($("#checkOutWork").prop("checked")){
		$("#checkOutWork").val('O');
		workTimeTR.style.display = "";
		workPlaceTR.style.display = "";
	}else{
		$("#checkOutWork").val('');
		workTimeTR.style.display = "none";
		workPlaceTR.style.display = "none";
	}
}

function viewTask(no, taskId, taskTitle) {
	executeCopy("+ " + "[" + taskId + "] " + taskTitle);

	var s_width = screen.width;
	var s_height = screen.height;
	var left = -1000;
	var top = 100;
	
	var url = "/request/ReqTaskV.do?no=" + no;
	var title = "_REQUEST_TASK_WRITE_";
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	
	var popup = window.open(url, title, option);
	//	popup.moveTo( ( ( (s_width -500)/2* (-1)) ), ((s_height-570)/2));
	//	popup.moveTo(200, 200);
	popup.focus();

}

function executeCopy(text) {
	var input = document.createElement('textarea');
	document.body.appendChild(input);
	input.value = (text);
	input.focus();
	input.select();
	document.execCommand('Copy');
	input.remove();
}

</script>
</head>

<body>
<div id="pop_board1">
	<div id="pop_top">
	<ul>
	<c:set var = "year" value = "${fn:substring(dailyPlanVO.writeDate, 0, 4)}" />
	<c:set var = "month" value = "${fn:substring(dailyPlanVO.writeDate, 4, 6)}" />
	<c:set var = "date" value = "${fn:substring(dailyPlanVO.writeDate, 6, 8)}" />
		<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
		<li class="popTitle">업무 계획  [${year}년 ${month}월 ${date}일]</li>
	</ul>
	</div>
	<div class="pop_con16">
	
		<c:set var="wsOverDate" value="${fn:replace(thisTime,'.','')}"/>
		<c:set var="wsOverDate" value="${fn:substring(wsOverDate,0,8)}"/>
		<c:set var="thisTime" value="${fn:substring(thisTime,11,13)}"/>	
		<c:if test="${thisTime == '00' || thisTime == '01' || thisTime == '02' ||thisTime == '03' ||thisTime == '04' ||thisTime == '05' || thisTime == '06'}">
			<c:set var="wsOverDate" value="${yesterday}"/>
		</c:if>
		
		<div class="pop_board_soft">
			<form:form name="dailyPlanFm" id="dailyPlanFm" commandName="dailyPlanFm" method="POST" >
				<input type="hidden" name="no" value="${dailyPlanVO.no}"/>
				<input type="hidden" name="writerNo" value="${dailyPlanVO.writerNo}"/>
				<input type="hidden" name="writeDate" value="${dailyPlanVO.writeDate}"/>
			<c:if test="${fn:length(rtVOList) > 0}" >
			<p class="th_stitle">작업목록</p>
				<table cellpadding="0" cellspacing="0" >
				<colgroup>
					<col width="px" />
					<col class="col60" />
					<col class="col60" />
					<col class="col40" />
				</colgroup>
				<tbody>
				<c:forEach items="${rtVOList}" var="vo" varStatus="c">
					<tr>
						<td class="pL10 txt_left"><a href="javascript:viewTask('${vo.no}', '${vo.taskId}', '${vo.title}');">+ [${vo.taskId}] ${vo.title}</a></td>
						<td class="txt_center">${vo.writerName}</td>
						<td class="txt_center"> ${vo.regDatetime}</td>
						<td class="txt_center">${vo.priorityStr}</td>
					</tr>
				</c:forEach>
				</tbody>
				</table>
			<br/>
			</c:if>
			<input type="image" src="${imagePath}/editor/btn_cancel.gif" class="fr" onclick="javascript:window.close();"/>
			<input type="image" src="${imagePath}/editor/btn_regist.gif" class="fr" onclick="javascript:register();"/>
			<p class="th_stitle">업무계획</p>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col90" />
					<col width="px" />
					<col class="col150" />
				</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="title">날짜</td>
						<td class="pL10"> [${dailyPlanVO.writeDate}]</td>
						<td class="title">외근등록 <input type="checkbox"  name="checkOutWork" id="checkOutWork" onclick="changeOutWork();"/></td>
					</tr>
					<tr>
						<td class="pL5 pT5 pB5 " colspan="3">
							<textarea  class="w98p h400" name="contents" rows="20" style="resize:both">${dailyPlanVO.contents }</textarea>
						</td>
					</tr>
					<tr id="outsideWorkTime" style="display:none">
						<td class="title">외근 시간</td>
						<td class="pL10" colspan="2"><input type="text" class="input03 w20" name="fromTime" id="fromTime" onfocus="numGen('fromTime',9,18,5);"/> 시 ~ 
						<input type="text" class="input03 w20" name="toTime" id="toTime" onfocus="numGen('toTime',9,18,5);"/> 시 
						</td>
					</tr>
					<tr id="outsideWorkPlace" style="display:none">
						<td class="title end">행선지 </td>
						<td class="pL10 end"  colspan="2"><input type="text" class="w300" name="workPlace" id="workPlace" "/>
						</td>
					</tr>
 				</tbody>
			</table>
			</form:form>
		</div>	
		
		<div class="pop_btn_area06">
			<a href="javascript:register();"><img src="${imagePath}/editor/btn_regist.gif"/></a>
			<a href="javascript:window.close();"><img src="${imagePath}/editor/btn_cancel.gif"/></a>
		</div>
	</div>
</div>

</body>
</html>
