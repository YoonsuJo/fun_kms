<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function modifyMenu(no) {
	var POP_NAME = "_MODIFY__MENU_POP_";
	var target = document.fm.target;
	document.fm.target = POP_NAME;
	document.fm.action = "/menu/modifyMenuPop.do";

	var popup = window.open("about:blank", POP_NAME, "width=800px,height=200px;");
	document.fm.no.value = no;
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function deleteMenu(no) {
	if (confirm("삭제하시겠습니까?")) {
		document.fm.no.value = no;
		document.fm.action = '<c:url value="${rootPath}/menu/deleteMenu.do" />';
		document.fm.submit();
	}
}

var fixHelper = function(e, ui) {
	ui.children().each(function() {
		$(this).width($(this).width());
	});
	return ui;
};


/* function updateTaskStatus(no, status) {
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
 */
$(document).ready(function(){
	$('#tableBody').sortable({
		helper: fixHelper,
		update: function(event, ui) { 

			var order = new Object();
			$('#tableBody').children('tr').each(function(idx, elm) {
				var no = (elm.id).toString().substring(3);
				order[idx] = no;
			});

			order = JSON.stringify(order);
			order = escape(order);
			$.post("/menu/ajaxMenuOrderUpdate.do",
				{"orderResult" : order}
				, function(data) {
					location.reload();
				}
			);
		}
	});
	$('#tableBody').disableSelection();
});

function searchTeamMenu() {

	location.href = "/menu/teamMenuL.do";
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
						<li class="stitle">나의메뉴</li>
						<li class="navi">나의메뉴 > 나의메뉴</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
						
					<!-- 게시판 시작 -->
					<a href="javascript:searchTeamMenu();"><span class="th_plus03 txtB_grey">팀메뉴 관리</span></a>
					<p class="th_stitle">나의메뉴 편집</p>
					<div class="boardList02 mB20">
						<form name="fm" method="POST" action="${rootPath}/menu/modifyMymenu.do">
							<input type="hidden" name="no" value="0"/>
							<input type="hidden" name="type" value="1"/>
						</form>
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup><col class="col40" /><col class="col120" /><col width="px" /><col class="col50" /></colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>URL</th>
								<th class="td_last">&nbsp;</th>
							</tr>
						</thead>
						<tbody id="tableBody">
							<c:if test="${empty mVOList}">
								<tr>
									<td class="txt_center" colspan="4">결과가 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${mVOList}" var="ea" varStatus="s">
								<tr id="no_${ea.no}">
									<td class="txt_center">${s.count}</td>
									<td class="pL7 txt_left"> ${ea.title}</td>
									<td class="pL7 txt_left">${ea.url}</td>
									<td class="td_last txt_center">
										<a href="javascript:modifyMenu('${ea.no}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
										<a href="javascript:deleteMenu('${ea.no}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					<!-- 게시판 끝  -->
					<br/>※ 체크리스트에 나타나는 나의 메뉴는 20번까지만 표시됩니다.
					<br/>※ 각 항목을 끌었다 놓음으로써 정렬 순서를 변경할 수 있습니다.<br/>
				</div>
				<!-- E: section -->
			</div>
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
</div>
</body>
</html>