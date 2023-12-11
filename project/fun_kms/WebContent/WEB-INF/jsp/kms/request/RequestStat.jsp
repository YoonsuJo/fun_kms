<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function searchNewRequest(userId, userName){
	$('#status1').val("1");
	$('#status2').val("0");
	$('#status3').val("4");
	$('#status4').val("8");
	$('#status5').val("16");
	$('#status6').val("0");
	$('#status7').val("0");
	document.fm.searchManagerMixes.value = userName + "(" + userId + ")";
	
	document.fm.searchFinishDateFrom.value 	= "";
	document.fm.searchFinishDateTo.value 		= "";

	searchRequestL();
}

function searchTreatedRequest(userId, userName){
	$('#status1').val("1");
	$('#status2').val("2");
	$('#status3').val("4");
	$('#status4').val("8");
	$('#status5').val("16");
	$('#status6').val("32");
	$('#status7').val("64");
	document.fm.searchManagerMixes.value = userName + "(" + userId + ")";
	
	document.fm.searchTreatedDateFrom.value = "";
	document.fm.searchTreatedDateTo.value = "";
	
	document.fm.isTreatedYn = "Y";
	
	searchRequestL();
}

function searchFinishRequest(userId, userName){
	$('#status1').val("0");
	$('#status2').val("0");
	$('#status3').val("0");
	$('#status4').val("0");
	$('#status5').val("16");
	$('#status6').val("0");
	$('#status7').val("0");

/* 	document.fm.searchFinishDateFrom.value 	= document.fm.searchFinishDateFrom.value;
	document.fm.searchFinishDateTo.value 		= document.fm.searchFinishDateTo.value;
	document.fm.searchDateFrom.value 		= "";
	document.fm.searchDateTo.value 		= ""; */
	document.fm.searchFinishDateFrom.value 	= "";
	document.fm.searchFinishDateTo.value 		= "";	

	document.fm.searchManagerMixes.value = userName + "(" + userId + ")";

	searchRequestL();
}

function searchRemainRequest(userId, userName){
	$('#status1').val("1");
	$('#status2').val("0");
	$('#status3').val("4");
	$('#status4').val("8");
	$('#status5').val("0");
	$('#status6').val("0");
	$('#status7').val("0");	

/* 	document.fm.searchDateFrom.value 			= "";
	document.fm.searchDateTo.value 			= "";
	document.fm.searchFinishDateFrom.value 	= "";
	document.fm.searchFinishDateTo.value 		= ""; */
	document.fm.searchFinishDateFrom.value 	= "";
	document.fm.searchFinishDateTo.value 		= "";	

	document.fm.searchManagerMixes.value = userName + "(" + userId + ")";

	searchRequestL();
}

function searchRequestL() {

	document.fm.method="POST";
	document.fm.action = "<c:url value='${rootPath}/request/RequestL.do'/>";
	document.fm.submit();
}

function search() {
	document.fm.method="POST";
	document.fm.action = "<c:url value='${rootPath}/request/RequestStat.do'/>";
	document.fm.submit();
}

function searchReqTask() {

	location.href = "/request/ReqTaskL.do";
}

function searchRequestList() {
	location.href = "/request/RequestL.do";
}

/*function searchRequestProcess() {
	location.href = "/request/RequestList.do";
}*/

function searchRequestProcess(mode)
{
	$('#status1').val("0");
	$('#status3').val("0");
	$('#status4').val("0");
	$('#status5').val("0");
	$('#status6').val("0");
	$('#status7').val("0");
	
	switch(mode){
		case 1: 
			$('#status1').val("1");
			break;
		case 2:
			$('#status3').val("4");
			break;
		case 3:
			$('#status5').val("16");
			break;
		case 4:
			$('#status6').val("32");
			break;
		case 5:
			$('#status7').val("64");			
			break;
	}

/* 	document.fm.searchFinishDateFrom.value 	= document.fm.searchFinishDateFrom.value;
	document.fm.searchFinishDateTo.value 		= document.fm.searchFinishDateTo.value;
	document.fm.searchDateFrom.value 		= "";
	document.fm.searchDateTo.value 		= ""; */
	document.fm.searchFinishDateFrom.value 	= "";
	document.fm.searchFinishDateTo.value 		= "";	
	
	searchRequestL();
	
/* 	document.fm.searchProcessMode.value = mode;
	
	document.fm.method="POST";
	document.fm.action = "<c:url value='${rootPath}/request/RequestList.do'/>";
	document.fm.submit(); */
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
							<li class="stitle">요구사항 처리통계</li>
							<li class="navi">요구사항 관리 > 요구사항 처리통계</li>
						</ul>
					</div>
	
					<!-- S: section -->
					
					<div class="section01">
						<!-- <a href="javascript:searchReqTask();"><span class="th_plus03 txtB_grey pL10"> [작업목록] </span></a> -->
						<a href="javascript:searchRequestList();"><span class="th_plus03 txtB_grey pL10"> [요구사항검색] </span></a>
						<a href="javascript:searchRequestProcess(1);"><span class="th_plus03 txtB_grey pL10"> [요구사항 관리] </span></a>
						<p class="th_stitle">요구사항 처리통계</p>
						<div id="busiContactD">
						 <form name="fm" id="fm" methos="POST" >
							<input type="hidden" name="searchUseYn" id="searchUseYn" value="Y"/>
							<input type="hidden" name="no" id="no" value="0"/>
							<input type="hidden" name="reqType1" id="reqType1" value="1" />
							<input type="hidden" name="reqType2" id="reqType2" value="2" />
							<input type="hidden" name="reqType3" id="reqType3" value="4" />
							<input type="hidden" name="reqType4" id="reqType4" value="8" />
							<input type="hidden" name="status1" id="status1" value="0" />
							<input type="hidden" name="status2" id="status2" value="0" />
							<input type="hidden" name="status3" id="status3" value="0" />
							<input type="hidden" name="status4" id="status4" value="0" />
							<input type="hidden" name="status5" id="status5" value="0" />
							<input type="hidden" name="status6" id="status6" value="0" />
							<input type="hidden" name="status7" id="status7" value="0" />
							<input type="hidden" name="searchFinishDateFrom" id="searchFinishDateFrom" value="${fm.searchDateFrom}"/>
							<input type="hidden" name="searchFinishDateTo" id="searchFinishDateTo" value="${fm.searchDateTo}"/>
							<input type="hidden" name="searchProcessMode" id="searchProcessMode" value="1"/>
							<input type="hidden" name="pageIndex" value="1"/>
							<fieldset>
								<legend>상단 검색</legend>
								<div class="top_search07">
									<table cellpadding="0" cellspacing="0" >
									<caption>상단 검색</caption>
									<colgroup>
										<col class="col100"/>
										<col class="col150"/>
										<col class="col150"/>
										<col class="col150"/>
										<col class="col150"/>
										<col class="col150"/>
										<col class="col150"/>
										<col class="col150"/>
										<col class="col150"/>
									</colgroup>
									<tbody>
										<tr>
											<td class="txt_center">전체 현황 </td>
											<td>총건수 : ${ReqStat.stTotal}</td>
											<td><a href="javascript:searchRequestProcess(1);">대기중 : ${ReqStat.stRequest}</a></td>
											<%-- <td><a href="javascript:searchRequestProcess(12);">검토중 : ${ReqStat.stReview}</a></td> --%>
											<td><a href="javascript:searchRequestProcess(2);">구현중 : ${ReqStat.stProcess}</a></td>
											<td><a href="javascript:searchRequestProcess(3);">완료 : ${ReqStat.stComplete}</a></td>
											<td><a href="javascript:searchRequestProcess(4);">보류 : ${ReqStat.stDefer}</a></td>
											<td><a href="javascript:searchRequestProcess(5);">삭제 : ${ReqStat.stDelete}</a></td>
										</tr>
									</tbody>
									</table>
								</div>
							</fieldset>															
							<fieldset style="margin-top:10px;">
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
											<input type="text" class="search_txt02 w400 userNamesAuto userValidateCheckAuth" name="searchManagerMixes" id="searchManagerMixes" value="${fm.searchManagerMixes}"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchManagerMixes', 0, null, null, '1');" />
										</td>
										<th class="fr pT5 pR5 txtB_Black">조회기간</th>
										<td >
											<input type="text" name="searchDueDateFrom" id="searchDueDateFrom" class="w70 txt_center calGen" value="${fm.searchDueDateFrom}"/> ~
											<input type="text" name="searchDueDateTo" id="searchDueDateTo" class="w70 txt_center calGen" value="${fm.searchDueDateTo}"/>		                   				
										</td>
										<td class="txt_center">
											<input type="button" value="조건검색" class="btn_gray w70" onclick="javascript:search();"/>
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
						<p class="th_stitle">요구사항 처리 목록</p>
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
								<c:forEach items="${rVOList}" var="vo" varStatus="c">
									<tr>
										<td class="txt_center">
											<print:user userNo="${vo.managerNo}" userNm="${vo.managerName}" userId="${vo.managerId}" printId="false"/>
										</td>
										<td class="txt_center">	<a href="javascript:searchNewRequest('${vo.managerId}', '${vo.managerName}');">${vo.newRequest}</a></td>
										<td class="txt_center">	<a href="javascript:searchFinishRequest('${vo.managerId}', '${vo.managerName}');">${vo.finishRequest}</a></td>
										<td class="txt_center">	<a href="javascript:searchRemainRequest('${vo.managerId}', '${vo.managerName}');">${vo.remainRequest}</a></td>
									</tr>
								</c:forEach>
								<c:if test="${empty rVOList}">
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
