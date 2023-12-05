<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function viewProject(prjId){
	/*
	var form = $('#searchVO');
	form.attr("action", "/cooperation/selectProjectV.do?prjId="+prjId);
	form.submit();
	*/
	
//	var popup = window.open("/cooperation/selectProjectPopV.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=950px,height=800px,scrollbars=yes,resizable=no");
	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=940px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function search(){
	var form = $('#searchVO');
	if(!isNaN(page))
		form.find("input[name='pageIndex']").val(page);
	form.attr("action", "/cooperation/selectProjectList2.do");
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
	
	$('#leaderNoList').change(function(){
		var form = $('#searchVO');

		var sel = document.getElementById("leaderNoList");
		var val = sel.options[sel.selectedIndex].value;
		if(val == "0")
			return;
		$('#searchLeaderNo').val(val);
		$('#searchUserNo').val("0");
		form.attr("action", "/cooperation/selectMyProjectList.do");
		form.submit();
	});
	$('#userNoList').change(function(){
		var form = $('#searchVO');

		var sel = document.getElementById("userNoList");
		var val = sel.options[sel.selectedIndex].value;
		if(val == "0")
			return;
		$('#searchUserNo').val(val);
		$('#searchLeaderNo').val("0");
		form.attr("action", "/cooperation/selectMyProjectList.do");
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
						<li class="stitle">수행중인 프로젝트</li>
						<li class="navi">홈 > 프로젝트 관리</li>
					</ul>
				</div>	
				
				
				<!-- S: section -->
				<div class="section01">
					<form:form commandName="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name=searchUseYn value="Y"/>
						<input type="hidden" name="searchLeaderNo" id="searchLeaderNo" value=""/>
						<input type="hidden" name="searchUserNo" id="searchUserNo" value=""/>
						
						<table cellpadding="0" cellspacing="0">
							<caption>상단 검색</caption>
							<colgroup>
								<col width="400" />
								<col width="400" />
								<col width="200" />
							</colgroup>
							<tbody>
								<tr>
									<td >
										<span class="txtB_bold">PL : </span><select class="select01" name="leaderNoList" id="leaderNoList" >
											<option value="0" > 선택 </option>
											<c:forEach items="${userList}" var="userList">
											<c:choose>
												<c:when test="${userList.userNo == searchVO.searchLeaderNo}">
													<option value="${userList.userNo}" selected > ${userList.userName} </option>
												</c:when>
												<c:otherwise>
													<option value="${userList.userNo}" > ${userList.userName} </option>
												</c:otherwise>
											</c:choose>
											</c:forEach>
										</select>
									</td>
									<td >
										<span class="txtB_bold">참여자 : </span><select class="select01" name="userNoList" id="userNoList" >
											<option value="0" > 선택 </option>
											<c:forEach items="${userList}" var="user">
											<c:choose>
												<c:when test="${user.userNo == searchVO.searchUserNo}">
													<option value="${user.userNo}" selected > ${user.userName} </option>
												</c:when>
												<c:otherwise>
													<option value="${user.userNo}" > ${user.userName} </option>
												</c:otherwise>
											</c:choose>
											</c:forEach>
										</select>
									</td>
									<td class="search_right">
					<div class="btn_area07">
							<a href="/cooperation/selectProjectList2.do"><img src="${imagePath}/btn/btn_search02.gif"/></a>
							<a href="/cooperation/writeProject.do?type=M"><img src="${imagePath}/btn/btn_add.gif"/></a>
					</div>
									</td>
								</tr>
							</tbody>
						</table>
					</form:form>

					<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
					<table id="projectListT" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
					    <caption>프로젝트 현황</caption>
					    <colgroup>
						    <col class="col120" />
						    <col width="px"/>
						    <col class="col70" />
						    <col class="col50" />
						    <col class="col50" />
						    <col class="col80" />
						    <col class="col80" />
					    </colgroup>
					    <thead>
					    	<tr>
					    		<th>주관부서</th>
					    		<th>프로젝트</th>
					    		<th>PL</th>
					    		<th>상태</th>
					    		<th>구분</th>
					    		<th>시작일</th>
					    		<th class="td_last">종료일</th>
					    	</tr>
					    </thead>
					    <tbody>
					    	<c:forEach items="${resultList}" varStatus="status" var="result">
							<tr>
								<td class="txt_center">${result.orgnztNm }</td>
								<td class="pL10">
									<a class="cursorPointer" onclick="viewProject('${result.prjId }');">
										<span class="txtS_grey">[${result.prjCd }]</span>
										<span class="txtB_grey">${result.prjNm}</span>
									</a>
								</td>
								<td class="txt_center"><print:user userNo="${result.leaderNo}" userNm="${result.leaderNm}"/></td>
								<td class="txt_center">
									<c:choose>
										<c:when test="${result.stat == 'P'}">진행</c:when>
										<c:when test="${result.stat == 'S'}">중단</c:when>
										<c:when test="${result.stat == 'E'}">종료</c:when>
										<c:otherwise>${result.stat }</c:otherwise>
									</c:choose>
								</td>
								<td class="txt_center">
									<c:choose>
										<c:when test="${result.prjType == 'P'}">수행</c:when>
										<c:when test="${result.prjType == 'S'}">영업</c:when>
										<c:when test="${result.prjType == 'B'}">사업</c:when>
										<c:when test="${result.prjType == 'M'}">경영</c:when>
										<c:when test="${result.prjType == 'E'}">폴더</c:when>
										<c:otherwise>?</c:otherwise>
									</c:choose>
								</td>
								<td class="txt_center">${result.stDt}</td>
								<td class="txt_center">${result.compDueDt}</td>
							</tr>	   
							</c:forEach>                 			                    			                    	
						</tbody>
					</table>
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
