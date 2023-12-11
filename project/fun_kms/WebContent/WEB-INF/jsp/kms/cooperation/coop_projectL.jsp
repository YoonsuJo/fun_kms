<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

function viewProject(prjId){
	/*
	var form = $('#searchVO');
	form.attr("action", "/cooperation/selectProjectV.do?prjId="+prjId);
	form.submit();
	*/
	/*
	var popup = window.open("/cooperation/selectProjectV.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	*/

	var popup = window.open("/cooperation/selectProjectV.do?prjId=" + prjId, '_POP_PROJECT_VIEW' + prjId, '');
	popup.focus();
}
function interest(prjId) {
	var form = $('#searchVO');
	// form.find('[name$=prjId]').val(prjId);
	form.attr("action", "/cooperation/switchPrjInterest.do?prjId=" + prjId);
	form.submit();
}
$(document).ready(function(){
	var form = 	$('#searchVO');
	$('#projectSearchB').click(function(){
		form.attr("action", "/cooperation/selectProjectList.do");
		form.submit();
	});
});


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
						<li class="stitle">프로젝트현황</li>
						<li class="navi">홈 > 업무공유  > 프로젝트  > 프로젝트현황</li>
					</ul>
				</div>
				
				<!-- S: section -->
				
				<div class="section01">
				<form name="popupFrm" action="">
					<input type="hidden" name="prjId" />
				</form>
				<form:form commandName="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
				
				<!-- 상단 검색창 시작 -->
				<fieldset>
				<legend>상단 검색</legend>
					<div class="top_search07 mB20">
					<table cellpadding="0" cellspacing="0" summary="">
					<caption>상단 검색</caption>
					<colgroup>
<!-- 						<col width="px" /> -->
<!-- 						<col width="px" /> -->
<!-- 						<col width="width:20%" /> -->
						<col width="210px" />
						<col width="width:80%" />
					</colgroup>
					<tbody>
						<tr>
							<td>
								진행상태 : <form:checkboxes items="${codeList3}" path="searchStatL" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</td>
							<td class="search_right">
								주관부서<span class="pL7"></span>
								<form:input path="searchOrgnztNm" readonly="true" size="40" cssClass="search_txt02 w65" onclick="orgGen('searchOrgnztNm','searchOrgnztId',2);" />
								<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('searchOrgnztNm','searchOrgnztId',2);" class="cursorPointer" />
								<form:hidden path="searchOrgnztId"/>
								<input name="returnUrl" type="hidden" value="${rootPath}/cooperation/selectProjectList.do" />
								<img src="${imagePath}/btn/btn_search02.gif" id="projectSearchB" class="cursorPointer" alt="검색" />
							</td>
						</tr>
						<tr>
							<td colspan="2"><p class="T11">(최상위 프로젝트 기준)</p></td>
						</tr>
					</tbody>
					</table>
					</div>
					
				</fieldset>
			
				<!-- 상단 검색창 끝 -->
				
				
				</form:form>
				<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<jsp:include page="${jspPath}/cooperation/include/projectListTable.jsp"></jsp:include>
					</div>
					
					<!--// 게시판  끝  -->
					
					<!-- 버튼 시작 ${user.admin} ${user.isProjectadmin}-->
					<div class="btn_area">
						<c:if test="${user.admin == true || user.isProjectadmin == 'Y'}">
							<a href="/cooperation/writeProject.do?type=M">
								<img src="${imagePath}/btn/btn_add.gif"/>
							</a>
						</c:if>
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
