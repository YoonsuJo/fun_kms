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

function updateTaskStatus(no, status) {
	var invoiceId = $('#invoiceId').val();
	
	$.ajax({
		url: "/request/updateTaskStatusAjax.do",
		data: {
			no: no,
			status:status
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			// 수행 프로젝트가 아닐 경우, 오류메시지
			if (!data.RETURN.equals('OK')) {
				alert('작업 상태변경이 되지 못하였습니다');
				return false;
			}
			location.reload();
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("작업 상태변경을 실패하였습니다.");
  	 	}
	});
}

function modifyReqTask() {
	document.fm.method = "POST";
	document.fm.action = "<c:url value='${rootPath}/request/ReqTaskM.do'/>";
	document.fm.searchReload.value = "N";
	document.fm.submit();
}

function viewRequest(no) {
	var s_width = screen.width;
	var s_height = screen.height;
	var left = -1000;
	var top = 100;
	
	var url = "/request/RequestV.do?no=" + no;
	var title = "_REQUEST_VIEW_";
	var option = "width=1200px, height=800px";
	
	var popup = window.open(url, title, option);
	popup.focus();
}

</script>
</head>

<body>
<div id="pop_board1">
	<div id="pop_top">
	<ul>
		<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
		<li class="popTitle">작업내용 조회</li>
	</ul>
	</div>
	<div class="pop_con16">
		<div class="pop_board1">
			<input type="button" value="닫기" class="mL10 fr btn_gray" onclick="javascript:window.close();"/>
			<input type="button" value="수정" class="mL10 fr btn_gray" onclick="javascript:modifyReqTask();"/>
		<c:if test="${rtVO.status < 4}">
			<input type="button" value="완료" class="mL10 fr btn_gray" onclick="javascript:updateTaskStatus(${rtVO.no}, 4);"/>
		</c:if>
		<c:if test="${rtVO.status < 2}">
			<input type="button" value="시작" class="mL10 fr btn_gray" onclick="javascript:updateTaskStatus(${rtVO.no}, 2);"/>
		</c:if>
			<p class="th_stitle">작업내용</p>
			<form:form name="fm" id="fm" commandName="fm" method="POST" >
				<input type="hidden" name="no" value="${rtVO.no}"/>
				<input type="hidden" name="reqNo" value="${rtVO.reqNo}"/>
				<input type="hidden" name="searchReload" value="N"/>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col100" />
					<col class="col100" />
					<col class="col100" />
					<col class="col100" />
					<col class="col100" />
					<col class="col100" />
				</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="title">작업명</td>
						<td class="pL5" colspan="5">[${rtVO.taskId}] ${rtVO.title}</td>
					</tr>
					<tr>
						<td class="title">요구명</td>
						<td class="pL5" colspan="5"><a href="javascript:viewRequest('${rtVO.reqNo}');">[${rtVO.reqId}] ${rtVO.reqTitle}</a></td>
					</tr>
					<tr>
						<td class="title">작업종류</td>
						<td class="pL5 txt_center">${rtVO.taskTypeStr}</td>
						<td class="title">우선순위</td>
						<td class="pL5 txt_center">${rtVO.priorityStr}</td>
						<td class="title">상태</td>
						<td class="pL5 txt_center">${rtVO.statusStr}</td>
					</tr>
					<tr>
						<td class="title">담당자</td>
						<td class="pL5 txt_center">${rtVO.workerName}</td>
						<td class="title">시작일시</td>
						<td class="pL5 txt_center">${rtVO.startDatetime}</td>
						<td class="title">완료일시</td>
						<td class="pL5 txt_center">${rtVO.finishDatetime}</td>
					</tr>
					<tr>
						<td class="title">작성자</td>
						<td class="pL5 txt_center">${rtVO.writerName}</td>
						<td class="title">작성일</td>
						<td class="pL5 txt_center">${rtVO.regDatetime}</td>
						<td class="title">예상완료일</td>
						<td class="pL5 txt_center"></td>
					</tr>
					<tr>
						<td class="pL5 pT5 pB5 " colspan="6">
							<p class="textarea1">${rtVO.contents}</p>
						</td>
					</tr>
 				</tbody>
			</table>
			</form:form>
		</div>	
	</div>
</div>

</body>
</html>
