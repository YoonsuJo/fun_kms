<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function(){
	
});
	
function MoveDate(dateMove) {
	/* checkValidUserMixsAuth가 머하는 기능인지 잘 모르겠음 
		var error = checkValidUserMixsAuth(document.frm.searchUserNm.value);
		if(error["errorCode"] == 2 || error["errorCode"] == 3 || error["errorCode"] == 4) {
			return;
		}
	*/
	var form = $('#searchVO');
	$('#dateMove').val(dateMove);  // 월단위로 움직임. 즉, 1이면 한달앞로
	form.action = "${rootPath}/cooperation/selectMyProjectList.do";
	form.submit();
}

function searchOthers(userNo, userName) {
/* checkValidUserMixsAuth가 머하는 기능인지 잘 모르겠음 
	var error = checkValidUserMixsAuth(document.frm.searchUserNm.value);
	if(error["errorCode"] == 2 || error["errorCode"] == 3 || error["errorCode"] == 4) {
		return;
	}
*/
	var form = $('#searchVO');
	$('#searchUserInputNo').val(userNo);
	$('#searchUserInputNm').val(userName);
	form.action = "${rootPath}/cooperation/selectMyProjectList.do";
	form.submit();
}


function viewProject(prjId){
	/*
	var form = $('#searchVO');
	form.attr("action", "/cooperation/selectProjectV.do?prjId="+prjId);
	form.submit();
	*/

	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=960px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
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
						<li class="stitle">개인별 수행중인 프로젝트</li>
						<li class="navi">홈 > 프로젝트 관리</li>
					</ul>
				</div>	
				
				
				<!-- S: section -->
				<div class="section01">
				<form name="searchVO" id="searchVO" method="POST" >
					<input type="hidden" name="searchUseYn" value="Y"/>
					<input type="hidden" name="dateMove" id="dateMove" value="0"/>
					
					<div class="top_search mB20">
					<table cellpadding="0" cellspacing="0" >
					<caption>상단 검색</caption>
					<colgroup>
						<col class="col100">
						<col width="px">
					</colgroup>
					<tbody>
						<tr>
							<td>
								<input type="text" class="input03 w60" name="searchUserInputNm" id="searchUserInputNm" value="${searchVO.searchUserInputNm}"/>
								<input type="hidden" name="searchUserInputNo" id="searchUserInputNo" value="${searchVO.searchUserInputNo}"/>
							</td>
							<td  class="searchInput">기준일 : 
								<a href="javascript:MoveDate(-3);"><img src="${imagePath}/btn/btn_first.gif"/></a>
								<a href="javascript:MoveDate(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif"></a>
								<input type="text" class="calGen w60 input03" name="searchDate" value="${searchVO.searchDate}" readonly="readonly" 
										onchange="javascript:MoveDate(0);"/>
								<a href="javascript:MoveDate(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif"></a>
								<a href="javascript:MoveDate(3);"><img src="${imagePath}/btn/btn_end.gif"></a>
							</td>
						</tr>
						<tr>
							<td class="pT5 txt_center" colspan="2">
								<c:forEach items="${userList}" var="userVO" varStatus="s">
									<c:if test="${userVO.userNo != searchVO.searchUserInputNo}">
									<a href="javascript:searchOthers('${userVO.userNo}', '${userVO.userName}')">
										<span class="pL10"> ${userVO.userName} </span></a>
									</c:if>
								</c:forEach>
							</td>
						</tr>
					</tbody>
					</table>
					</div>
				</form>

					<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
					<p>※ 아래 목록은 기준일에 사용자가 프로젝트의 투입인력으로 설정된 프로젝트 목록입니다. </p> 
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
				<c:if test="${user.isLeader == 'Y'}">
					<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<p class="th_plus02">단위 : 천원</p>
						<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col30" />
								<col class="col500" />
								<col class="col100" />
								<col class="col80" />
								<col class="col80" />
							</colgroup>
							<thead>
								<tr class="height_th">
									<th>번호</th>
									<th>프로젝트</th>
									<th>담당자</th>
									<th>인건비</th>
									<th>근무시간</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td class="txt_center" colspan="3">합계</td>
									<td class="pR10 txt_right"></td>
									<td></td>
								</tr>
							</tfoot>
							<tbody>
								<c:forEach items="${mrVOList}" var="vo" varStatus="vs">
									<tr>
										<td class="txt_center"><c:out value="${vs.count}"/></td>
										<td class="pL10"><print:project prjCd="${vo.prjCode}" prjId="${vo.prjId}" prjNm="${vo.prjName}"/>	</td>
										<td class="txt_center">${vo.writerName }</td>
										<td class="pR10 txt_right"><print:currency cost="${vo.amount}" divideBy="${divideby}"/> </td>
										<td class="txt_center">${vo.workHour}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!--// 게시판 끝  -->
					</c:if>
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
