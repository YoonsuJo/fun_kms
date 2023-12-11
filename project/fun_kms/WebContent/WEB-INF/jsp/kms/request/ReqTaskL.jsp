<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function searchAll(){
	$('#taskType1').attr("checked", true);
	$('#taskType2').attr("checked", true);
	$('#taskType3').attr("checked", true);
	$('#taskType4').attr("checked", true);
	$('#taskType5').attr("checked", true);
	$('#taskType6').attr("checked", true);
	$('#taskType7').attr("checked", true);

	$('#status1').attr("checked", true);
	$('#status2').attr("checked", true);
	$('#status3').attr("checked", true);

	document.fm.searchWorkerMixes.value = "";
	document.fm.searchTitle.value = "";
	document.fm.searchWriterMixes.value = "";
	document.fm.searchDateFrom.value = "";
	document.fm.searchDateTo.value = "";
	document.fm.searchPrjNm.value = "";
	document.fm.searchPrjId.value = "";
	
	search();
}

function searchToDo(){
	$('#taskType1').attr("checked", true);
	$('#taskType2').attr("checked", true);
	$('#taskType3').attr("checked", true);
	$('#taskType4').attr("checked", true);
	$('#taskType5').attr("checked", true);
	$('#taskType6').attr("checked", true);
	$('#taskType7').attr("checked", true);

	$('#status1').attr("checked", true);
	$('#status2').attr("checked", true);
	$('#status3').attr("checked", false);

	document.fm.searchWorkerMixes.value = "";
	document.fm.searchTitle.value = "";
	document.fm.searchWriterMixes.value = "";
	document.fm.searchDateFrom.value = "";
	document.fm.searchDateTo.value = "";
	document.fm.searchPrjNm.value = "";
	document.fm.searchPrjId.value = "";

	search();
}

function searchMyReq(){
	$('#taskType1').attr("checked", true);
	$('#taskType2').attr("checked", true);
	$('#taskType3').attr("checked", true);
	$('#taskType4').attr("checked", true);
	$('#taskType5').attr("checked", true);
	$('#taskType6').attr("checked", true);
	$('#taskType7').attr("checked", true);

	$('#status1').attr("checked", true);
	$('#status2').attr("checked", true);
	$('#status3').attr("checked", false);

	document.fm.searchWorkerMixes.value = "${user.userNm}" + "(" + "${user.userId}" + ")";
	document.fm.searchTitle.value = "";
	document.fm.searchWriterMixes.value = "";
	document.fm.searchDateFrom.value = "";
	document.fm.searchDateTo.value = "";
	document.fm.searchPrjNm.value = "";
	document.fm.searchPrjId.value = "";

	search();
}

function searchMyWrite(){
	$('#taskType1').attr("checked", true);
	$('#taskType2').attr("checked", true);
	$('#taskType3').attr("checked", true);
	$('#taskType4').attr("checked", true);
	$('#taskType5').attr("checked", true);
	$('#taskType6').attr("checked", true);
	$('#taskType7').attr("checked", true);

	$('#status1').attr("checked", true);
	$('#status2').attr("checked", true);
	$('#status3').attr("checked", true);

	document.fm.searchWorkerMixes.value = "";
	document.fm.searchTitle.value = "";
	document.fm.searchWriterMixes.value = "${user.userNm}" + "(" + "${user.userId}" + ")";
	document.fm.searchDateFrom.value = "";
	document.fm.searchDateTo.value = "";
	document.fm.searchPrjNm.value = "";
	document.fm.searchPrjId.value = "";

	search();
}

function search(pageNo) {

	if(pageNo == null) {
		document.fm.pageIndex.value = 1;
	} else {
		document.fm.pageIndex.value = pageNo;
	}

	document.fm.method="POST";
	document.fm.action = "<c:url value='${rootPath}/request/ReqTaskL.do'/>";
	document.fm.submit();
}

function viewReqTask(no) {
	var s_width = screen.width;
	var s_height = screen.height;
	var left = -1000;
	var top = 100;
	
	var url = "/request/ReqTaskV.do?no=" + no;
	var title = "_REQUEST_TASK_WRITE_";
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	
	var popup = window.open(url, title, option);
	//	popup.moveTo( ( ( (s_width -500)/2* (-1)) ), ((s_height-570)/2));
	//	popup.moveTo(200, 200);
	popup.focus();
}

function modifyReqTask(no) {
	var s_width = screen.width;
	var s_height = screen.height;
	var left = -1000;
	var top = 100;
	
	var url = "/request/ReqTaskM.do?no=" + no;
	var title = "_REQUEST_REQTASK_MODIFY_";
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	
	var popup = window.open(url, title, option);
	//	popup.moveTo( ( ( (s_width -500)/2* (-1)) ), ((s_height-570)/2));
	//	popup.moveTo(200, 200);
	popup.focus();
}

function searchRequestList() {
	location.href = "/request/RequestL.do";
}

function searchReqTaskStat() {
	location.href = "/request/ReqTaskStat.do";
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
							<li class="stitle"> 작업목록</li>
							<li class="navi">요구사항 관리 > 작업목록</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<a href="javascript:searchReqTaskStat();"><span class="th_plus03 txtB_grey pL10"> [작업통계] </span></a>
						<a href="javascript:searchRequestList();"><span class="th_plus03 txtB_grey pL10"> [요구사항목록] </span></a>
						<a href="javascript:searchRequestProcess();"><span class="th_plus03 txtB_grey pL10"> [요구사항 관리] </span></a>
						<p class="th_stitle">작업목록 검색</p>
						 <form name="fm" id="fm" methos="POST" >
							<input type="hidden" name="searchUseYn" id="searchUseYn" value="Y"/>
							<input type="hidden" name="no" id="no" value="0"/>
							<input type="hidden" name="param_returnUrl" id="param_returnUrl" value="<c:url value='/request/ReqTaskL.do'/>"/>
							<input type="hidden" name="excel" value="N" />
							<input type="hidden" name="pageIndex" value="${fm.pageIndex}"/>
							<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
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
 									<tr>
										<th class="pT5 pR5 txtB_Black">작업유형</th>
										<td colspan="3">
											<label><input type="checkbox" name="taskType1" id="taskType1" value="1" <c:if test="${fm.taskType1 == 1}">checked="checked"</c:if>/> 분석</label>
											<label><input type="checkbox" name="taskType2" id="taskType2" value="2" <c:if test="${fm.taskType2 == 2}">checked="checked"</c:if>/> 설계</label>
											<label><input type="checkbox" name="taskType3" id="taskType3" value="4" <c:if test="${fm.taskType3 == 4}">checked="checked"</c:if>/> 구현</label>
											<label><input type="checkbox" name="taskType4" id="taskType4" value="8" <c:if test="${fm.taskType4 == 8}">checked="checked"</c:if>/> 시험</label>
											<label><input type="checkbox" name="taskType5" id="taskType5" value="16" <c:if test="${fm.taskType5 == 16}">checked="checked"</c:if>/> 오류처리</label>
											<label><input type="checkbox" name="taskType6" id="taskType6" value="32" <c:if test="${fm.taskType6 == 32}">checked="checked"</c:if>/> 연구</label>
											<label><input type="checkbox" name="taskType7" id="taskType7" value="64" <c:if test="${fm.taskType7 == 64}">checked="checked"</c:if>/> 기타</label>
										</td>
										<td class="txt_center">
											<input type="button" value="전체검색" class="btn_gray w70 txt_center" onclick="javascript:searchAll();"/>
										</td>
									</tr>
 									<tr>
										<th class="pT5 pR5 txtB_Black">처리상태</th>
										<td colspan="3">
											<label><input type="checkbox" name="status1" id="status1" value="1" <c:if test="${fm.status1 == 1}">checked="checked"</c:if>/> 생성</label>
											<label><input type="checkbox" name="status2" id="status2" value="2" <c:if test="${fm.status2 == 2}">checked="checked"</c:if>/> 처리중</label>
											<label><input type="checkbox" name="status3" id="status3" value="4" <c:if test="${fm.status3 == 4}">checked="checked"</c:if>/> 처리완료</label>
										</td>
										<td class="txt_center">
											<input type="button" value="미처리건" class="btn_gray w70 txt_center" onclick="javascript:searchToDo();"/>
										</td>
									</tr>
									<tr>
										<th class="pT5 pR5 txtB_Black">작성자</th>
										<td>
											<input type="text" class="search_txt02 w150 userNameAuto userValidateCheckAuth" name="searchWriterMixes" id="searchWriterMixes" value="${fm.searchWriterMixes}"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchWriterMixes', 1, null, null, '1');" />
										</td>
										<th class="pT5 pR5 txtB_Black">작성일</th>
										<td >
											<input type="text" name="searchDateFrom" id="searchSdate" class="w70 txt_center calGen" value="${fm.searchDateFrom}"/> ~
											<input type="text" name="searchDateTo" id="searchEdate" class="w70 txt_center calGen" value="${fm.searchDateTo}"/>		                   				
										</td>
										<td class="txt_center">
											<input type="button" value="작성한것" class="btn_gray w70 txt_center" onclick="javascript:searchMyWrite();"/>
										</td>
									</tr>
									<tr>
										<th class="pT5 pR5 txtB_Black">담당자</th>
										<td>
											<input type="text" class="search_txt02 w400 userNameAuto userValidateCheckAuth" name="searchWorkerMixes" id="searchWorkerMixes" value="${fm.searchWorkerMixes}"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchWorkerMixes', 0, null, null, '1');" />
										</td>
										<th class="pT5 pR5 txtB_Black">완료일</th>
										<td >
											<input type="text" name="searchFinishDateFrom" id="searchFinishDateFrom" class="w70 txt_center calGen" value="${fm.searchFinishDateFrom}"/> ~
											<input type="text" name="searchFinishDateTo" id="searchFinishDateTo" class="w70 txt_center calGen" value="${fm.searchFinishDateTo}"/>		                   				
										</td>
										<td class="txt_center">
											<input type="button" value="처리할것" class="btn_gray w70 txt_center" onclick="javascript:searchMyReq();"/>
										</td>
									</tr>
									<tr>
										<th class="pT5 pR5 txtB_Black">프로젝트</th>
										<td colspan="3">
											<input type="text" class="w500" name="searchPrjNm" id="searchPrjNm" value="${fm.searchPrjNm}" readonly="readonly" onclick="prjGen('searchPrjNm','searchPrjId',1)" onfocus="prjGen('searchPrjNm','searchPrjId',1)"/>
											<input type="hidden" name="searchPrjId" id="searchPrjId" value="${fm.searchPrjId}" />
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('searchPrjNm','searchPrjId',1)" />
											<img src="/images/egovframework/cmm/fms/icon/bu5_close.gif" class="cursorPointer" width="19" height="18" 
												onClick="resetSearchPrj()" alt="검색프로젝트 초기화" title="검색 프로젝트 삭제">
										</td>
										<td class="txt_center" rowspan="2">
											<input type="button" value="조건검색" class="btn_gray w70 txt_center" onclick="javascript:search();"/>
										</td>
									</tr>
									<tr>
										<th class="pT5 pR5 txtB_Black">작업명</th>
										<td colspan="3"><input type="text" class="w400"  name="searchTitle" id="searchTitle" value="${fm.searchTitle}"/></td>
									</tr>
								</tbody>
								</table>
								</div>
							</fieldset>
						</form>
						<!--// 상단 검색창 끝 -->
						</br>
						<p class="th_stitle">작업목록</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col40" />
								<col class="col80" />
								<col width="px"/>
								<col class="col80" />
								<col class="col60" />
								
								<col class="col80" />
								<col class="col60" />
								<col class="col80" />
								<col class="col60" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">번호</th>
								<th scope="col">작업번호</th>
								<th scope="col">작업명</th>
								<th scope="col">우선순위</th>
								<th scope="col">작성자</th>
								<th scope="col">작성일</th>
								<th scope="col">담당자</th>
								<th scope="col">완료일</th>
								<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${rtVOList}" var="vo" varStatus="c">
									<tr>
										<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((fm.pageIndex-1) * fm.recordCountPerPage + c.count) + 1}"/></td>
										<td class="txt_center" ><a href="javascript:modifyReqTask('${vo.no}')">${vo.taskId}</a></td>
										<td class="txt_left"><a href="javascript:viewReqTask('${vo.no}');">${vo.title}</a></td>
										<td class="txt_center">${vo.priorityStr}</td>
										<td class="txt_center">
											<print:user userNo="${vo.writerNo}" userNm="${vo.writerName}" userId="${vo.writerId}" printId="false"/>
										</td>
										<td class="txt_center">${vo.regDatetime}</td>
										<td class="txt_center">
											${vo.cnt }<%-- <print:user userNo="${vo.workerNo}" userNm="${vo.workerName}" userId="${vo.workerId}" printId="false"/> --%>
										</td>
										<td class="txt_center">${vo.finishDatetime}</td>
										<td class="txt_center"><a href="javascript:modifyReqTask('${vo.no}')">${vo.statusStr}</a></td>
									</tr>
								</c:forEach>
								<c:if test="${empty rtVOList}">
									<tr>
										<td class="txt_center td_last" colspan="7">검색된 작업건이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
							</table>
						</div>
					<!-- 페이징 시작 -->
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					<!-- 페이징 끝 -->
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
