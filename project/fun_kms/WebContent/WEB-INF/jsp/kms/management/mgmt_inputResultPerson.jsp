<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<%
	String tmp_prjId = request.getParameter("prjId");

%>



<script>

function search(moveMonth) {
	document.frm.moveMonth.value = moveMonth;
	document.frm.submit();
}
function selRadio(i, setValue) {
	var usrNm = document.getElementById("usrNm");
	var orgNm = document.getElementById("orgNm");
	var orgId = document.getElementById("orgId");
	var usrTree = document.getElementById("usrTree");
	var orgTree = document.getElementById("orgTree");

	if (setValue == null) {
		usrNm.value = "";
		orgNm.value = "";
		orgId.value = "";
	}
	
	if (i == 0) {
		usrNm.style.display = "";
		orgNm.style.display = "none";
		usrTree.style.display = "";
		orgTree.style.display = "none";
	}
	else if (i == 1) {
		usrNm.style.display = "none";
		orgNm.style.display = "";
		usrTree.style.display = "none";
		orgTree.style.display = "";
	}
}

function notInputMemberShow() {
	$('#NoPut_layer').show();
}
function notInputMemberHide() {
	$('#NoPut_layer').hide();
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
							<li class="stitle">개인별 인력투입실적</li>
							<li class="navi">홈 > 경영정보 > 인력투입관리 > 개인별 투입실적</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
					
					<!-- 상단 검색창 시작 -->
						<form name="frm" action="${rootPath}/management/selectInputResultPerson.do" onsubmit="search(0); return false;" method="POST">
						<input type="hidden" name="moveMonth" value="0"/>
						<input type="hidden" name="searchDate" value="${searchVO.searchDate}"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="scheduleDate mB20">
								<ul>
								<li class="li_left">
									<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
									<span class="option_txt">${searchVO.searchDatePrint}</span>
									<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
								</li>
								<li class="li_right">
									<label><input type="radio" onclick="selRadio(0);" name="searchCondition" value="0"/> 사용자</label>
									<label><input type="radio" onclick="selRadio(1);" name="searchCondition" value="1"/> 부서</label><span class="pL7"></span>
									<input type="text" name="searchUserMix" id="usrNm" class="search_txt02 span_27 userNamesAuto" value="${searchVO.searchUserMix}"/>
									<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02 span_27" value="${searchVO.searchOrgNm}" readonly="readonly" onclick="orgGen('orgNm','orgId',0);"/>
									<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('usrNm',0);"/>
									<img id="orgTree" src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);"/>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(0); return false;"/>
								</li>
								</ul>
							</div>
						</fieldset>
						</form>
					<!--// 상단 검색창 끝 -->
						<script>
							setValue("searchCondition", "${searchVO.searchCondition}");
							setValue("searchArea", "${searchVO.searchArea}");
							selRadio("${searchVO.searchCondition}" , "");
						</script>
						
						<p class="txt_right">미투입인력 : <a href="javascript:notInputMemberShow();"><span class="txtB_grey">${fn:length(notInputMemberList)}</span> 명</a></p>
						
						<!-- 게시판 시작  -->
						<div class="boardList02 mB5" >
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>프로젝트 현황</caption>
							<colgroup>
								<col class="col70" />
								<col class="col120" />
								<col width="px"/>
								<col class="col70" />
								<col class="col70" />
							</colgroup>
							<thead>
								<tr>
									<th>이름</th>
									<th>부서</th>
									<th>프로젝트</th>
									<th>시간</th>
									<th class="td_last">투입율</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="tmp_prjId" value="<%=tmp_prjId%>" />		
								<c:choose>
								<c:when test="${tmp_prjId == null || tmp_prjId == ''}">
									<c:forEach items="${resultList}" var="result">
										<c:set var="irpSize" value="${fn:length(result.inputResultPersonList)}" />									
										<tr>
											<td class="txt_center" rowspan="${irpSize + 1}"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
											<td class="txt_center" rowspan="${irpSize + 1}"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/> </td>
											<c:forEach items="${result.inputResultPersonList}" var="irp" varStatus="c">
												<td class="pL10"><print:project prjCd="${irp.prjCd}" prjId="${irp.prjId}" prjNm="${irp.prjNm}"/></td>
												<td class="txt_center">${irp.tm}</td>
												<td class="td_last txt_center">${irp.tmPercent}%</td>
												<c:out value="</tr>" escapeXml="false"/>
												<c:out value="<tr>" escapeXml="false"/>
											</c:forEach>
											<td class="td_last txt_center bG" colspan="3">투입시간 : ${result.totalTm}시간</td>
										</tr>									
									</c:forEach>
								</c:when>		
								<c:otherwise>
									<c:forEach items="${resultList}" var="result">
										<c:set var="irpSize" value="${fn:length(result.inputResultPersonList)}" />
										<tr>
											<c:forEach items="${result.inputResultPersonList}" var="irp" varStatus="c">
												<c:choose>
												<c:when test="${irp.prjId == tmp_prjId }">												
													<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
													<td class="txt_center"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/> </td>
													<td class="pL10"><print:project prjCd="${irp.prjCd}" prjId="${irp.prjId}" prjNm="${irp.prjNm}"/></td>
													<td class="txt_center">${irp.tm}/${result.totalTm}</td>
													<td class="td_last txt_center">${irp.tmPercent}%</td>
												</c:when>		
												<c:otherwise>
												
												</c:otherwise>
												</c:choose>
											</c:forEach>										
										</tr>
									</c:forEach>	
								</c:otherwise>
								</c:choose>								
							</tbody>
							</table>
							<p>
								<a href="javascript:notInputMemberHide();"><img src="${imagePath}/btn/btn_close.gif"/></a>
							</p>
						</div>
						<!-- //미투입인력 레이어 -->
						
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
