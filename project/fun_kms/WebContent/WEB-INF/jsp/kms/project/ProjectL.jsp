<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function writeProject(){
	var popup = window.open("/project/writeProjectPop.do?isReload=Y",
			"_POP_PROJECT_WRITE",
			"width=970px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
}

function viewProject(prjId){
	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,
			"_POP_PROJECT_VIEW",
			"width=970px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
}

function modifyProject(prjId){
	var popup = window.open("/project/modifyProjectPop.do?isReload=Y&prjId="+prjId,
			"_POP_PROJECT_MODIFY",
			"width=970px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
}

function search(page){
	var form = $('#searchVO');
	if(!isNaN(page))
		form.find("input[name='pageIndex']").val(page);
	form.attr("action", "/project/listProject.do");
	form.submit();
	
}

$(document).ready(function(){
	var form = $('#searchVO');
	form.find("input[type=text]").keyup(function(e) {
		//alert(e.keyCode);
		if(e.keyCode == 13) {
			form.submit();
		}
	});
	
	var preOrgnztId = '';
	var preOrgnztNm = '';
	$('#chkAllOrgnzt').click(function(e) {
		var searchOrgnztId = $('#searchOrgnztId');
		var searchOrgnztNm = $('#searchOrgnztNm');
		if ($(this).is(':checked')) {
			preOrgnztId = searchOrgnztId.val();
			preOrgnztNm = searchOrgnztNm.val();
			searchOrgnztId.val('');
			searchOrgnztNm.val('');
		} else {
			searchOrgnztId.val(preOrgnztId);
			searchOrgnztNm.val(preOrgnztNm);
		}
	});
});

function resetAllOrgnzt() {
	$('#chkAllOrgnzt').attr('checked', false);
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
						<li class="stitle">프로젝트 관리</li>
						<li class="navi">공통업무  > 프로젝트 관리</li>
					</ul>
				</div>	
				
				
				<!-- S: section -->
				<div class="section01">
					<form:form commandName="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input name="initFlag" type="hidden" value="Y"/>
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col class="col120"/>
								<col class="col500"/>
								<col class="col120" />
								<col class="col150"/>
								<col class="col120" />
								<col class="col150"/>
							</colgroup>
							<tbody>
								<tr>
									<td class="search_right">주관부서</td>
									<td>
											<form:input path="searchOrgnztNm" readonly="true" cssClass="search_txt05 w300" onclick="orgGen('searchOrgnztNm','searchOrgnztId',2); resetAllOrgnzt();"/>
											<form:hidden path="searchOrgnztId"/>
											<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('searchOrgnztNm','searchOrgnztId',2); resetAllOrgnzt();" class="cursorPointer" />
											<label><input type="checkbox" id="chkAllOrgnzt" <c:if test="${empty searchVO.searchOrgnztId}"> checked="checked"</c:if>> 전체</label>
									</td>
									<td class="search_right">PL</td>
									<td><form:input path="searchLeaderMix" cssClass="search_txt05 userNameAuto w140"/></td>
									<td class="search_right">투입인력</td>
									<td><form:input path="searchUserInputMix" cssClass="search_txt05 userNameAuto w140"/></td>
								</tr>
								<tr>
									<td class="search_right">프로젝트</td>
									<td><form:input path="searchPrjNm" cssClass="search_txt05 w98p"/></td>
									<td class="search_right" >진행상태</td>
									<td colspan="2">
											<input name="returnUrl" type="hidden" value="${rootPath}/project/listProject.do" />
											<form:checkboxes items="${codeList3}" path="searchStatL" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
									</td>
									<td>
											<img src="${imagePath}/btn/btn_search02.gif" alt="검색" class="cursorPointer" onclick="search();"/>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
						</fieldset>
						<!-- 상단 검색창 끝 -->
					</form:form>

					<!-- 게시판 시작  -->
						<c:if test="${user.admin == true || user.isProjectadmin == 'Y'}">
							<input type="button" value="등록" class="fr btn_gray" onclick="javascript:writeProject();"/>
						</c:if>
					<p class="th_stitle">프로젝트 목록</p>
					<div class="boardList02 mB20">
						<jsp:include page="${jspPath}/project/include/projectListTable.jsp"></jsp:include>
					</div>
					<!--// 게시판  끝  -->
					
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
