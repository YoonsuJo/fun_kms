<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function search(moveMonth) {
	document.frm.moveMonth.value = moveMonth;
	document.frm.submit();
}
function view() {
	document.frm.action = "${rootPath}/management/prjInputPlanView.do";
	document.frm.submit();
}

function insertView(obj) {
	$.post("${rootPath}/management/inputPrjInputPlanView.do", $('#searchFrm').serialize(), function(data) {
		var layer = $('#prjPlanLayer');
		layer.html(data);
		layer.css("top", $(obj).position().top - layer.height() + 10 + "px");
		layer.css("left", $(obj).position().left - layer.width() + 10 + "px");
		layer.show();
	});
}
function updateView(no,obj) {
	document.frm.no.value = no;
	$.post("${rootPath}/management/updatePrjInputPlanView.do", $('#searchFrm').serialize(), function(data) {
		var layer = $('#prjPlanLayer');
		layer.html(data);
		layer.css("top", $(obj).position().top + $(obj).height() + "px");
		layer.css("left", $(obj).position().left - layer.width() + "px");
		layer.show();
	});
}
function hideLayer() {
	$('#prjPlanLayer').html("");
	$('#prjPlanLayer').hide();
}

function write() {
	if (document.writeFrm.prjNm.value == '') {
		alert('프로젝트를 선택해주세요.');
		document.writeFrm.prjNm.focus();
		return;
	}
	document.writeFrm.submit();
}

function del(no) {
	if (confirm("삭제하시겠습니까?")) {
		document.frm.no.value = no;
		document.frm.action = "${rootPath}/management/deletePrjInputPlan.do";
		document.frm.submit();
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
							<li class="stitle">프로젝트 투입계획 관리</li>
							<li class="navi">홈 > 경영정보 > 프로젝트 투입계획 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 상단 검색창 시작 -->
						<form name="frm" id="searchFrm" method="POST" action="${rootPath}/management/prjInputPlanMgmt.do" onsubmit="search(0); return false;">
						<input type="hidden" name="no" value="0"/>
						<input type="hidden" name="moveMonth" value="0"/>
						<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						<input type="hidden" name="searchMonth" value="${searchVO.searchMonth}"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchPrjId" id="prjId" value="${searchVO.searchPrjId}"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td>
			               	 			<a href="javascript:search(-1);"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
			                			<span class="option_txt">${searchVO.searchYear}년 ${searchVO.searchMonth}월</span>
										<a href="javascript:search(1);" class="pR10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
									</td>
								</tr>
								<tr>
									<td class="search_right">
										프로젝트 <input type="text" name="searchPrjNm" id="prjNm" value="${searchVO.searchPrjNm}" class="input01 span_29" readonly="readonly" onfocus="prjGen('prjNm','prjId',1);"/>
										<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('prjNm','prjId',1);"/>
										부서 <input type="text" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}" class="input01 span_29" readonly="readonly" onfocus="orgGen('orgNm','orgId',1);"/>
										<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('orgNm','orgId',1);"/>
										<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02" alt="검색"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
						</form>
	                	<!-- 상단 검색창 끝 -->
	                	
						<p class="txt_right">미투입인력 : <a href="javascript:notInputMemberShow();"><span class="txtB_grey">${fn:length(notInputMemberList)}</span> 명</a></p>
						
						<!-- 게시판 시작  -->
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col150" />
		                    	<col class="col70" />
		                    	<col width="px" />
		                    	<col class="col50" />
		                    	<col class="col150" />
		                    	<col class="col70" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>소속부서</th>
		                    		<th>이름</th>
		                    		<th>프로젝트</th>
		                    		<th>투입률</th>
		                    		<th>투입기간</th>
		                    		<th class="td_last">수정/삭제</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
		                    		<td class="pL10"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/></td>
			                    	<td class="pL10"><print:user userNm="${result.userNm}" userNo="${result.userNo}"/></td>
			                    	<td class="pL10"><print:project prjId="${result.prjId}" prjNm="${result.prjNm}" prjCd="${result.prjCd}"/></td>
			                    	<td class="txt_center">${result.inputPercent}%</td>
			                    	<td class="txt_center"><print:date date="${result.inputSdt}"/> ~ <print:date date="${result.inputEdt}"/></td>
			                    	<td class="td_last txt_center">
			                    		<img src="${imagePath}/btn/btn_plus02.gif" class="cursorPointer" onclick="updateView('${result.no}',this)"/>
			                    		<a href="javascript:del('${result.no}')"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
			                    	</td>
		                    	</tr>              			                    			                    	
		                    	</c:forEach>
		                    </tbody>
		                    </table>
						</div>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
	           		    <div class="btn_area02">
	                		<img src="${imagePath}/btn/btn_add.gif" class="cursorPointer" onclick="insertView(this);"/>
                			<a href="javascript:view();"><img src="${imagePath}/btn/btn_see.gif"/></a>
	               	    </div>
	                 	<!-- 버튼 끝 -->
	                 	
	                 	<!-- 레이어  -->
	                 	<div class="Proj_plan_layer" id="prjPlanLayer" style="display:none; position:absolute">
						</div>
						<!--// 레이어  -->
						
						<!-- 미투입인력 레이어  -->
						<c:set var="memCnt" value="${fn:length(notInputMemberList)}" />
						<c:set var="layerHeight" value="${(memCnt - (memCnt%3) + 3)*10 + 50}" />
						<div class="NoPut_layer" id="NoPut_layer" style="display:none;<c:if test="${memCnt <= 45}"> height:${layerHeight}px;</c:if>">
							<table cellpadding="0" cellspacing="0" summary="">
							<caption>미투입인력</caption>
							<colgroup>
								<col width="33%">
								<col width="33%">
								<col width="33%">
							</colgroup>
							<tbody>
								<c:forEach items="${notInputMemberList}" var="mem" varStatus="c">
									<c:if test="${c.count % 3 == 1}">
									<c:out value="<tr>" escapeXml="false" />
									</c:if>
									<td><print:user userNo="${mem.no}" userNm="${mem.userNm}" userId="${mem.userId}" printId="true"/></td>
									<c:if test="${c.count % 3 == 0}">
									<c:out value="<tr>" escapeXml="false" />
									</c:if>
								</c:forEach>
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
