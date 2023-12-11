<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

$(document).ready(function() {

	$('.select01').change(function(){
		OrgIdEvent(this);
	});

	function OrgIdEvent(selector) {
		var option = selector.children(':selected');
		$('#orgnztId').val(option.val());			
	};
});

function addMenuPop(){
	
	var POP_NAME = "_ADD_TEAM_MENU_POP_";
	var target = document.fm.target;
	document.fm.target = POP_NAME;
	document.fm.action = "/mypage/teamMenuW.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=900px,height=200px;");
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function modifyMenu(no) {

	var POP_NAME = "_MODIFY_TEAM_MENU_POP_";
	var target = document.fm.target;
	document.fm.no.value = no;
	document.fm.target = POP_NAME;
	document.fm.action = "/mypage/teamMenuM.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=900px,height=200px;");
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}
function deleteMenu(no) {
	if (confirm("삭제하시겠습니까?")) {
		document.fm.no.value = no;
		document.fm.action = '<c:url value="${rootPath}/mypage/deleteMenu.do" />';
		document.fm.submit();
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

function search() {
	document.fm.action = '<c:url value="${rootPath}/mypage/teamMenuL.do" />';
	document.fm.submit();
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
						<li class="stitle">팀메뉴관리</li>
						<li class="navi">나의메뉴 > 팀메뉴관리</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					<form name="fm" method="POST">
						<input type="hidden" name="no" value="0"/>
						<input type="hidden" name="type" id=type value="2"/>
					<!-- 게시판 시작 -->
					<span class="th_plus03">
					<select  name="orgnztId" id="orgnztId" class="select01"  onchange="search();">
						<c:forEach items="${orgTreeList}" var="ea" varStatus="c">
						<c:choose>
							<c:when test="${ea.orgnztId == fm.orgnztId}">
								<option value="${ea.orgnztId}" selected > ${ea.orgnztNm}</option>
							</c:when>
							<c:otherwise>
								<option value="${ea.orgnztId}" > ${ea.orgnztNm} </option>
							</c:otherwise>
						</c:choose>
						</c:forEach>
					</select>
					</span>
					<p class="th_stitle">팀메뉴 편집 <span class="pL7"></span>
					<span style="position:relative; top:4px;"><a href="javascript:addMenuPop();"><img src="/images/btn/btn_plus.gif"/></a></span>
					</p>
					<div class="boardList02 mB20">
					</form>
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col40" />
							<col class="col120" />
							<col width="px" />
							<col class="col50" />
						</colgroup>
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
					<br/>※ 상단메뉴트(부서업무)에 나타나는 팀메뉴는 20번까지만 표시됩니다.
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
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
