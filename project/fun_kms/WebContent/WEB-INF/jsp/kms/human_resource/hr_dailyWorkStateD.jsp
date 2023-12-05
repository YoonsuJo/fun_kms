<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/ajax_inc.jsp"%>
<script>

var attendNote = {};
<c:forEach items="${resultList}" var="result">
	//attendNote["no_${result.userNo}"] = "${result.attendNotePrint}";
	//attendNote["no_${result.userNo}"] = "${result.attendNotePrintDetail}";
	attendNote["no_${result.userNo}${result.wsId}"] = "${result.attendNotePrintDetail}";
</c:forEach>

function showAttendNote(userNo, wsId, attendCdPrint, obj) {

	if(attendCdPrint=="출근" || attendCdPrint=="조기출근" 
	|| attendCdPrint=="지각" || attendCdPrint=="미로그인"
	|| attendCdPrint=="입사" || attendCdPrint=="주말근무" ){
		return false;
	}
	
	var position = $(obj).position();	
	var note = document.getElementById("atndNt");
	//note.innerHTML = attendNote["no_" + userNo];
	//note.innerHTML = attendNote["no_" + wsId];
	note.innerHTML = attendNote["no_" + userNo + wsId];
	note.parentNode.style.top = (position.top + 30) + "px";
	note.parentNode.style.left = (position.left - 110) + "px";
	note.parentNode.style.display = "";
}
function hideAttendNote() {
	var note = document.getElementById("atndNt");
	note.parentNode.style.display = "none";
}
</script>
<!-- 게시판 시작  -->
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col80" />
		<col width="px" />
		<col class="col80" />
		<col class="col80" />
		<col class="col100" />
		<col class="col40" />
	</colgroup>
	<thead>
		<tr>
			<th>이름</th>
			<th>소속부서</th>
			<th>근태종류</th>
			<th>출근시각</th>
			<th>IP</th>
			<th class="td_last">&nbsp;</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
<!--				<td class="txt_center">${result.orgnztNm}</td>-->
				<td class="">${result.orgnztNmFullLong}</td>
				<td class="txt_center" onmouseover="showAttendNote('${result.userNo}','${result.wsId}','${result.attendCdPrint}',this);" onmouseout="hideAttendNote();">
					${result.attendCdPrint}</td>
				<td class="txt_center">${result.attendTm}</td>
				<td class="txt_center">${result.attendIp}</td>
				<td class="txt_center td_last">
					<c:if test="${result.attendCd == 'ET' && user.admin}">
						<a href="${rootPath}/member/updateWorkStateExceptionView.do?wsId=${result.wsId}"><img src="${imagePath}/btn/btn_plus02.gif" /></a>
						<a href="${rootPath}/member/deleteWorkStateException.do?wsId=${result.wsId}"><img src="${imagePath}/btn/btn_minus02.gif" /></a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
