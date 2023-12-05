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
	//명불허전 IE 버그로 인해 위에서 미리 계수함. IE를 주깁시다. IE는 나으 원쑤
	//document.getElementById('countTop').innerHTML =  document.getElementById('countBottom').innerHTML;
});
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
var notInputMemberShowBool = 0;
function notInputMemberShow() {
	if(notInputMemberShowBool == 0){
		$('#NoPut_layer').show();
		notInputMemberShowBool = 1;		
	} else {
		$('#NoPut_layer').hide();
		notInputMemberShowBool = 0;
	}
}
function notInputMemberHide() {
	$('#NoPut_layer').hide();
	notInputMemberShowBool = 0;
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
							<li class="stitle">개인별 투입 계획 현황</li>
							<li class="navi">홈 > 경영정보 > 인력투입관리 > 개인별 투입 계획 현황</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
					
					<!-- 상단 검색창 시작 -->
						<form name="frm" action="${rootPath}/management/selectInputResultPlanPersonStatus.do" onsubmit="search(0); return false;" method="POST">
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
									<label><input type="checkbox" name="searchUnder100" value="Y" class="check"
									<c:if test="${searchVO.searchUnder100 == 'Y'}">checked</c:if> /> 계획MM 100% 미만 </label>
								</li>
								<li class="li_right">
									<label><input type="radio" onclick="selRadio(0);" name="searchCondition" value="0" /> 사용자</label>
									<label><input type="radio" onclick="selRadio(1);" name="searchCondition" value="1"/> 부서</label><span class="pL7"></span>
									<input type="text" name="searchUserMix" id="usrNm" class="search_txt02 span_9 userNamesAuto" value="${searchVO.searchUserMix}"/>
									<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02 span_9" value="${searchVO.searchOrgNm}" readonly="readonly" onclick="orgGen('orgNm','orgId',0);"/>
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
						
					<!-- 명불허전 IE 버그로 인해 위에서 미리 계수 시작 -->
						<c:set var="countPerson" value="0"/>
                    	<c:set var="countPrj" value="0"/>	                    	
						<c:forEach items="${resultList}" var="result">						
							<c:set var="countPerson" value="${countPerson + 1}"/>								
							<c:forEach items="${result.inputResultPersonList}" var="irp" varStatus="c">
								<c:set var="countPrj" value="${countPrj + 1}"/>								
							</c:forEach>
						</c:forEach>
						
						<p class="txt_right">
							<span class="fl">
								미계획인력 : <a href="javascript:notInputMemberShow();"><span class="txtB_grey">${fn:length(notInputMemberList)}</span> 명</a>
							</span>
							<span id="countTop" class="txt_right"> 
	           		    		검색결과 ${countPerson } 명
							</span>
						</p>
					<!-- 명불허전 IE 버그로 인해 위에서 미리 계수 끝 -->
					
					<!-- 게시판 시작  -->
						<div class="boardList02 mB5" >
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>프로젝트 현황</caption>
							<colgroup>
								<col class="col70" />
								<col class="col120" />
								<col width="px"/>
								<col class="col70" />
								<col class="col140" />
								<col class="col70" />
							</colgroup>
							<thead>
								<tr>
									<th>이름</th>
									<th>부서</th>
									<th>프로젝트</th>
									<th>계획</th>
									<th>인력투입계획 기간</th>
									<th class="td_last">투입률</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="countPerson" value="0"/>
		                    	<c:set var="countPrj" value="0"/>	                    	
								<c:forEach items="${resultList}" var="result">
									<c:set var="irpSize" value="${fn:length(result.inputResultPersonList)}" />
									<tr>
										<c:set var="countPerson" value="${countPerson + 1}"/>
										<td class="txt_center" rowspan="${irpSize}"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center" rowspan="${irpSize}"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/></td>
										
										<c:forEach items="${result.inputResultPersonList}" var="irp" varStatus="c">
											<c:set var="countPrj" value="${countPrj + 1}"/>
											<td class="pL10">
<!--											<print:project prjCd="${irp.prjCd}" prjId="${irp.prjId}" prjNm="${irp.prjNm}"/>-->
											<a href="/cooperation/selectProjectV.do?prjId=${irp.prjId}" target="_blank">
												${irp.prjCd}${irp.prjNm}
											</a>
											</td>
											<td class="txt_center">
											<c:choose>
												<c:when test="${irp.pn == 0.0}"><span class="txt_red">${irp.pn}</span></c:when>
												<c:otherwise>${irp.pn}</c:otherwise>
											</c:choose>
											</td>
											<td class="txt_center">
												<a href="/approval/approvalV.do?docId=${irp.docId}" target="_blank">
													${irp.stDtPrint} ~ ${irp.edDtPrint}
												</a>
											</td>
											<td class="td_last txt_center">${irp.inputPercent}%</td>
									<c:out value="</tr>" escapeXml="false"/>
									<c:out value="<tr>" escapeXml="false"/>
										</c:forEach>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!--// 게시판  끝  -->

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
						
						<p class="txt_right">
							<span id="countBottom">
<!--	           		    		총 ${countPerson } 명 / 문서 : ${countPrj } 건-->
<!--	           		    		미투입인력 : <a href="javascript:notInputMemberShow();"><span class="txtB_grey">${fn:length(notInputMemberList)}</span> 명</a>-->
	           		    	</span>
           		    	</p>
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
