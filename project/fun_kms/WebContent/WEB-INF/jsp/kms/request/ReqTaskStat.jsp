<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function searchNewTask(userId, userName){
	document.fm.searchWorkerMixes.value = userName + "(" + userId + ")";
	
	document.fm.searchFinishDateFrom.value 	= "";
	document.fm.searchFinishDateTo.value 		= "";

	searchReqTaskL();
}

function searchFinishTask(userId, userName){
	$('#status1').val("0");
	$('#status2').val("0");

	document.fm.searchFinishDateFrom.value 	= document.fm.searchFinishDateFrom.value;
	document.fm.searchFinishDateTo.value 		= document.fm.searchFinishDateTo.value;
	document.fm.searchDateFrom.value 		= "";
	document.fm.searchDateTo.value 		= "";

	document.fm.searchWorkerMixes.value = userName + "(" + userId + ")";

	searchReqTaskL();
}

function searchRemainTask(userId, userName){
	$('#status1').val("1");
	$('#status2').val("2");
	$('#status3').val("0");

	document.fm.searchDateFrom.value 			= "";
	document.fm.searchDateTo.value 			= "";
	document.fm.searchFinishDateFrom.value 	= "";
	document.fm.searchFinishDateTo.value 		= "";

	document.fm.searchWorkerMixes.value = userName + "(" + userId + ")";

	searchReqTaskL();
}

function searchReqTaskL() {

	document.fm.method="POST";
	document.fm.action = "<c:url value='${rootPath}/request/ReqTaskL.do'/>";
	document.fm.submit();
}

function search() {

	document.fm.method="POST";
	document.fm.action = "<c:url value='${rootPath}/request/ReqTaskStat.do'/>";
	document.fm.submit();
}

function searchRequestList() {
	location.href = "/request/RequestL.do";
}

function searchReqTaskList() {
	location.href = "/request/ReqTaskL.do";
}
function searchRequestProcess() {
	location.href = "/request/RequestList.do";
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
							<li class="stitle">작업 처리통계</li>
							<li class="navi">요구사항 관리 > 작업처리통계</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<a href="javascript:searchReqTaskList();"><span class="th_plus03 txtB_grey pL10"> [작업목록] </span></a>
						<a href="javascript:searchRequestList();"><span class="th_plus03 txtB_grey pL10"> [요구사항목록] </span></a>
						<a href="javascript:searchRequestProcess();"><span class="th_plus03 txtB_grey pL10"> [요구사항 관리] </span></a>
						<p class="th_stitle">작업처리통계</p>

						<div id="busiContactD">
						 <form name="fm" id="fm" methos="POST" >
							<input type="hidden" name="searchUseYn" id="searchUseYn" value="Y"/>
							<input type="hidden" name="no" id="no" value="0"/>
							<input type="hidden" name="taskType1" id="taskType1" value="1" />
							<input type="hidden" name="taskType2" id="taskType2" value="2" />
							<input type="hidden" name="taskType3" id="taskType3" value="4" />
							<input type="hidden" name="taskType4" id="taskType4" value="8" />
							<input type="hidden" name="taskType5" id="taskType5" value="16" />
							<input type="hidden" name="taskType6" id="taskType6" value="32" />
							<input type="hidden" name="taskType7" id="taskType7" value="64" />
							<input type="hidden" name="status1" id="status1" value="1" />
							<input type="hidden" name="status2" id="status2" value="2" />
							<input type="hidden" name="status3" id="status3" value="4" />
							<input type="hidden" name="searchFinishDateFrom" id="searchFinishDateFrom" value="${fm.searchDateFrom}"/>
							<input type="hidden" name="searchFinishDateTo" id="searchFinishDateTo" value="${fm.searchDateTo}"/>
							<fieldset>
								<legend>상단 검색</legend>
								<div class="top_search07">
								<table cellpadding="0" cellspacing="0" >
								<caption>상단 검색</caption>
								<colgroup>
									<col class="col100"/>
									<col class="col500"/>
									<col class="col100"/>
									<col class="col200"/>
									<col class="col80"/>
								</colgroup>
								<tbody>
									</tr>
										<th class="fr pT5 pR5 txtB_Black">담당자</th>
										<td>
											<input type="text" class="search_txt02 w400 userNamesAuto userValidateCheckAuth" name="searchWorkerMixes" id="searchWorkerMixes" value="${fm.searchWorkerMixes}"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchWorkerMixes', 0, null, null, '1');" />
										</td>
										<th class="fr pT5 pR5 txtB_Black">조회기간</th>
										<td >
											<input type="text" name="searchDateFrom" id="searchDateFrom" class="w70 txt_center calGen" value="${fm.searchDateFrom}"/> ~
											<input type="text" name="searchDateTo" id="searchDateTo" class="w70 txt_center calGen" value="${fm.searchDateTo}"/>		                   				
										</td>
										<td class="txt_center">
											<input type="button" value="조건검색" class="fr btn_gray w70" onclick="javascript:search();"/>
										</td>
									</tr>
								</tbody>
								</table>
								</div>
							</fieldset>
						</form>
						</div>
						<!--// 상단 검색창 끝 -->

						</br>
						<p class="th_stitle">작업 처리 통계</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col200" />
								<col class="col200" />
								<col class="col200" />
								<col class="col200" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">담당자</th>
								<th scope="col">신규건수</th>
								<th scope="col">완료건수</th>
								<th scope="col">잔여건수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${rtVOList}" var="vo" varStatus="c">
									<tr>
										<td class="txt_center">
											<print:user userNo="${vo.workerNo}" userNm="${vo.workerName}" userId="${vo.workerId}" printId="false"/>
										</td>
										<td class="txt_center">	<a href="javascript:searchNewTask('${vo.workerId}', '${vo.workerName}');">${vo.newTask}</a></td>
										<td class="txt_center">	<a href="javascript:searchFinishTask('${vo.workerId}', '${vo.workerName}');">${vo.finishTask}</a></td>
										<td class="txt_center">	<a href="javascript:searchRemainTask('${vo.workerId}', '${vo.workerName}');">${vo.remainTask}</a></td>
									</tr>
								</c:forEach>
								<c:if test="${empty rtVOList}">
									<tr>
										<td class="txt_center td_last" colspan="4">검색된  요구사항건이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
							</table>
						</div>
					</div>
					<!-- E: section -->
				</div>
				<!-- E: center -->
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
