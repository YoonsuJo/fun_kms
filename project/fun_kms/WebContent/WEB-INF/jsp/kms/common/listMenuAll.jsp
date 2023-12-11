<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function modify(no) {
	document.subForm.no.value = no;
	document.subForm.action = '<c:url value="${rootPath}/mypage/modifyMymenu.do" />';
	document.subForm.submit();
}
function del(no) {
	if (confirm("삭제하시겠습니까?")) {
		document.subForm.no.value = no;
		document.subForm.action = '<c:url value="${rootPath}/mypage/deleteMymenu.do" />';
		document.subForm.submit();
	}
}

var fixHelper = function(e, ui) {
	ui.children().each(function() {
		$(this).width($(this).width());
	});
	return ui;
};

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
			$.post("/mypage/ajaxOrderUpdate.do",
				{"orderResult" : order}
				, function(data) {}
			);
		}
	});
	$('#tableBody').disableSelection();
});

</script>
</head>

<body>

<div id="wrap">
	<%@ include file="../include/head.jsp"%>
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
						<li class="stitle">전체메뉴</li>
						<li class="navi">홈 > 전체메뉴</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
						
					<!-- 공통업무 시작 -->
					<p class="th_stitle">공통업무</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col250" />
							<col class="col250" />
							<col class="col250" />
							<col class="col250" />
						</colgroup>
						<thead>
							<tr>
								<th>나의업무</th>
								<th>프로젝트관리</th>
								<th>전자결재</th>
								<th>펀네트회의실</th>
							</tr>
						</thead>
						<tbody id="tableBody">
								<tr>
									<td class="txt_left"></td>
									<td class="txt_left"></td>
									<td class="txt_left"></td>
									<td class="txt_left"></td>
								</tr>
						</tbody>
						</table>
					</div>
					<!-- 공통업무 끝  -->
					
					<!-- 정보공유 시작 -->
					<p class="th_stitle">정보공유</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col250" />
							<col class="col250" />
							<col class="col250" />
							<col class="col250" />
						</colgroup>
						<thead>
							<tr>
								<th>나의업무</th>
								<th>프로젝트관리</th>
								<th>전자결재</th>
								<th>펀네트회의실</th>
							</tr>
						</thead>
						<tbody id="tableBody">
								<tr>
									<td class="txt_left"></td>
									<td class="txt_left"></td>
									<td class="txt_left"></td>
									<td class="txt_left"></td>
								</tr>
						</tbody>
						</table>
					</div>
					<!-- 정보공유 끝  -->

					<!-- 버튼 시작 -->
					<div class="btn_area">
						<a href="${rootPath}/mypage/addMymenu.do"><img src="${imagePath}/btn/btn_add.gif"/></a>
					</div>
					<!-- 버튼 끝 -->
					
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
