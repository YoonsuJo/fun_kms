<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

var changed = false;

var fixHelper = function(e, ui) {
    ui.children().each(function() {
        $(this).width($(this).width());
    });
    return ui;
};

$(document).ready(
function(){
	
	$('#showExp').sortable({
	 	helper: fixHelper,
		update: function(event, ui) { 

			var order = new Object();
			$('#showExp').children('ul').each(function(idx, elm) {
				var expId = (elm.id).toString();
			  	order[idx] = expId;
			});

			order = JSON.stringify(order);
			order = escape(order);
			$.post("${rootPath}/mypage/ajaxExpOrderUpdate.do",
				{"orderResult" : order}
				, function(data) {}
			);
			changed = true;
		 }
	});
	$('#showExp').disableSelection();
	
});

function expAction(action, expId) {
	if (action == "add") {
		if ("${fn:length(expList)}" > 5) {
			alert("확장기능은 6개까지 등록할 수 있습니다.");
			return;
		}
		location.href = "/mypage/expansionAdd.do?expId=" + expId;
		changed = true;
	}
	if (action == "del") {
		location.href = "/mypage/expansionDel.do?expId=" + expId;
		changed = true;
	}
}

function reloadOpener() {
	if (changed) {
		opener.location.reload();
		changed = false;
	}
}
</script>
</head>

<body onunload="reloadOpener();"><div id="pop_expansion">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">확장기능 관리</li>
		</ul>
 	</div>
 	
 	<div id="pop_con05">
 	
 	<!-- 자주쓰는 확장기능  -->
 		<p class="stitle">자주쓰는 확장기능</p>
 		<div class="left_fun">
	 		<div class="left_sfun" id="showExp">
	 			<c:forEach items="${expList}" var="show" varStatus="c">
		 			<ul class="list" id="${show.expId}">
						<li class="list_icon">
							<c:choose>
								<c:when test="${empty show.expFileId || show.expFileId == ''}">
									<img src="${imagePath}/inc/bn0${c.count}.gif"/>
								</c:when>
								<c:otherwise>
									<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${show.expFileId}" />
										<c:param name="param_width" value="50" />
										<c:param name="param_height" value="45" />
									</c:import>
								</c:otherwise>
							</c:choose>
						</li>	
						<li class="list_txt">${show.expSj}</li>
						<li class="list_btn02">
		 					<a href="javascript:expAction('del','${show.expId}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
						</li>
						<li class="list_stxt">${show.expCnShort}</li>
		 			</ul>
	 			</c:forEach>
	 		</div>
 		</div>
 	<!--// 자주쓰는 확장기능  -->	
 	
 	<!-- 모든 확장기능  -->
 		<p class="stitle02">모든 확장기능</p>
 		<div class="right_fun">
	 		<div class="right_sfun" id="hiddenExp">
	 			<c:forEach items="${unuseExpList}" var="hidden" varStatus="c">
		 			<ul class="list" id="${hidden.expId}">
						<li class="list_icon">
							<c:choose>
								<c:when test="${empty hidden.expFileId || hidden.expFileId == ''}">
									<img src="${imagePath}/inc/bn0${c.count}.gif"/>
								</c:when>
								<c:otherwise>
									<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${hidden.expFileId}" />
										<c:param name="param_width" value="50" />
										<c:param name="param_height" value="45" />
									</c:import>
								</c:otherwise>
							</c:choose>
						</li>	
						<li class="list_txt">${hidden.expSj}</li>
						<li class="list_btn02">
	 						<a href="javascript:expAction('add','${hidden.expId}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
						</li>
						<li class="list_stxt">${hidden.expCnShort}</li>
		 			</ul>
	 			</c:forEach>
	 		</div>
 		</div>
 	<!--// 모든 확장기능  -->
 	
 	<!-- 버튼 시작 -->
		<div class="btn_area05">
			<a href="javascript:window.close();"><img src="${imagePath}/btn/btn_close.gif"/></a>
		</div>
	<!-- 버튼 끝 -->	
 		
 	</div>
</div>

</body>
</html>
