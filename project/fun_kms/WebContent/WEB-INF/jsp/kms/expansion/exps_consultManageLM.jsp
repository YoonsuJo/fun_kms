<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
//시작 동작
$(document).ready(function() {
	
});

//상담관리 상세화면 이동
function view(no) {
	document.listForm.consult_no.value = no;	
	document.listForm.action = "${rootPath}/cooperation/selectConsultManage.do";
	document.listForm.submit();
}
//열람
function viewState(consultNo) {
	var popup = window.open("/cooperation/selectConsultRecieveList.do?consult_no=" + consultNo,"_POP_STATE_","width=360px,height=415px,scrollbars=yes");
	popup.focus();
}
//고객검색
function searchCust(custNm){
	var popup = window.open("${rootPath}/cooperation/selectSearchCustNmConsultManageList.do?searchCuNm2=" + encodeURI(custNm),"_POP_CUSTLIST_","width=747px,height=864px,scrollbars=yes");
	popup.focus();
}

//상담등록 화면 이동
function consultRegister(){
	location.href = "${rootPath}/cooperation/writeConsultManage.do";
}

// 담당자, 수신자 변경 레이어 show/hide
function recieveLayerShow(id) {
	var position = $("#charged_"+id).position();
	var height = $("#charged_"+id).height();
	
	// Bind Data
	$('#chargedUserIdMix').val($('#chargedWork_'+id).val());
	//$('#consultNo').val($('#consultNo_'+id).val());
	document.receiveFrm.consult_no.value = $('#consultNo_'+id).val();
	
	$('#RecieverLayer').show();
	document.getElementById("RecieverLayer").style.top = position.top + height + "px";
	document.getElementById("RecieverLayer").style.left = position.left - 400 + "px";
	document.getElementById("RecieverLayer").style.zIndex = "1";
}

function recieveLayerHide() {
	$('#RecieverLayer').hide();
}

// 담당자 변경
function changeRecieve() {
	document.receiveFrm.action = "${rootPath}/cooperation/changeConsultRecieve.do";
	document.receiveFrm.submit();
}


//처리상태 변경 레이어 show/hide
function toggleStateLayer(id) {
	//if ('${commandMap.fromResultView}'=='Y') return;
	
	console.log($('#stateLayer').css('display'));
	if ($('#stateLayer').css('display') == 'none')
		stateLayerShow(id);
	else
		stateLayerHide();
}
function stateLayerShow(id) {
	var position = $("#state_" + id).position();
	var height = $("#state_" + id).height();
	
	// Bind Data
	initCompleteDt(id);
	document.stateFrm.consult_no.value = $('#consultNo_'+id).val();
	
	$('#stateLayer').show();
	document.getElementById("stateLayer").style.top = position.top + height + "px";
	document.getElementById("stateLayer").style.left = position.left - 400 +  "px";
	document.getElementById("stateLayer").style.zIndex = "1";
}
function stateLayerHide() {
	$('#stateLayer').hide();
}

function updateState(){
	document.stateFrm.action = "<c:url value='${rootPath}/cooperation/updateConsultState.do'/>";
	document.stateFrm.submit();	
}

//처리일시 초기화
var completeDt;

function initCompleteDt(id) {
	// COMPLETE_DATE, COMPLETE_TM 문자열 가공하여 date() 객체 생성 
	var tmpDate = $('#complete_date_' + id).val();
	var tmpTime = $('#complete_tm_' + id).val();
	
	if (tmpDate == "") {
		completeDt = new Date();
	} else {
		year = tmpDate.substring(0, 4);
		month = tmpDate.substring(5, 7) - 1;
		day = tmpDate.substring(8, 10);
		hour = tmpTime;
		
		completeDt = new Date(year, month, day, hour);
	}
	
	var complete_date = document.getElementById('complete_date');
	var complete_tm = document.getElementById('complete_tm');
	
	complete_date.value = "" + completeDt.format("yyyy.MM.dd");
	complete_tm.value = "" + completeDt.format("HH");
}

//처리일시 변경(Option> immediate:즉시, before1h:1시간 후, after1h:1시간 후)
function setCompleteDt(workType) {
	switch (workType) {
		case 'immediate':
			completeDt = new Date();
			break;
		case 'before1h':
			completeDt.setHours(completeDt.getHours() - 1);
			break;
		case 'after1h':
			completeDt.setHours(completeDt.getHours() + 1);
			break;
	}
	var complete_date = document.getElementById('complete_date');
	var complete_tm = document.getElementById('complete_tm');
	
	complete_date.value = "" + completeDt.format("yyyy.MM.dd");
	complete_tm.value = "" + completeDt.format("HH");
}

//처리일시 텍스트가 변경될 때, date 객체 변경
function chngCompleteDt() {
	var date = document.getElementById('complete_date').value;
	date = date.replaceAll('.', '');
	var year = date.substring(0,4);
	var month = date.substring(4,6) - 1;
	var day = date.substring(6,8);
	var hour = document.getElementById('complete_tm').value;
	
	completeDt = new Date(year, month, day, hour);

	var complete_date = document.getElementById('complete_date');
	var complete_tm = document.getElementById('complete_tm');
	
	complete_date.value = "" + completeDt.format("yyyy.MM.dd");
	complete_tm.value = "" + completeDt.format("HH");
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
				<div id="center2">
					<div class="path_navi">
						<ul>
							<li class="stitle">상담처리</li>
							<li class="navi">홈 > 상담관리 > 상담처리</li>
						</ul>
					</div>
					<br/>
					<span class="mT30 mL20">※ 열람권한이 있는 '접수, 처리중'인 상담목록만 전시되며 목록에서 내용을 선택하여 접수내용 확인 및 처리결과를 등록할 수 있습니다.</span>

					<!-- S: section -->
					<div class="section01">
						
						<!-- 상담접수 버튼 -->	
						<div class="pop_btn_area">
							<a href="javascript:consultRegister();"><img src="${imagePath}/btn/btn_goConsul.gif"/></a>
						</div>
						
						<!-- 게시판 시작 -->
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="고객사정보 목록입니다.">
							<caption>고객사정보</caption>
							<colgroup>
							<col width="30px" />
							<col width="70px" />
							<col width="60px" />
							<col width="px" />
							<col class="col50" />
							<col class="col50" />
							<col class="col70" />
							<col class="col60" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">고객사</th>
							<th scope="col">고객명</th>
							<th scope="col">문의내용</th>
							<th scope="col">접수자</th>
							<th scope="col">접수일</th>
							<th scope="col">연락시한<br/>(남은시간)</th>
							<th scope="col">처리<br/>상태</th>
							</tr>
						</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<input type="hidden" id="chargedWork_${result.no}" value="${result.chargedWork}"/>
									<input type="hidden" id="complete_date_${result.no}" value="${result.completeDate}"/>
									<input type="hidden" id="complete_tm_${result.no}" value="${result.completeTm}"/>
									<input type="hidden" id="consultNo_${result.no}" value="${result.consultNo}"/>
									<tr <c:if test="${result.red == 'Y'}">class="txt_red"</c:if> >
										<td class="txt_center">
											<!--<c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/>-->
											${result.no}
										</td>
										<td class="pL5" style="text-align:center;">
											<a href="javascript:searchCust('${result.custNm}');" title="${result.custNm}">
												<div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">${result.custNm}</div>
											</a>
										</td>
										<td class="pL5" style="text-align:center;">
											<div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">${result.custManager}</div>
										</td>
										<td class="pL5" style="text-align:center;">
											<a href="${rootPath}/cooperation/selectConsultManage.do?consult_no=${result.consultNo}" title="${result.qCn}">
												<c:choose>
												<c:when test="${result.red == 'Y'}">
													<span class="txt_red">
														<c:if test="${fn:length(result.qCn) > 40}">
															${fn:substring(result.qCn, 0, 40)}...
														</c:if>
														<c:if test="${fn:length(result.qCn) <= 40}">
															${result.qCn}
														</c:if>
													</span>
												</c:when>
												<c:otherwise>
													<c:if test="${fn:length(result.qCn) > 40}">
														${fn:substring(result.qCn, 0, 40)}...
													</c:if>
													<c:if test="${fn:length(result.qCn) <= 40}">
														${result.qCn}
													</c:if>
												</c:otherwise>
												</c:choose>
												<c:if test="${result.red == 'Y'}">
												</c:if>
												<c:if test="${result.commentCnt > 0}">[${result.commentCnt}]</c:if>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center"><print:date date="${result.regDt}" printType="M"/></td>
										<td class="txt_center">
											<c:if test="${!empty result.contactDtOri}">
												<print:date date="${result.contactDtOri}" printType="MMDDHHMM"/>
												<br/>
												<c:if test="${result.remainTotalMin >= 1440}">(1일 이상)</c:if>
												<c:if test="${result.remainTotalMin < 1440}">
													(<c:if test="${result.remainHour > 0}">${result.remainHour}시간 </c:if>${result.remainMin}분)
												</c:if>
											</c:if>
										</td>
										<td class="txt_center">
											<c:forEach items="${stateList}" var="state" varStatus="c">
												<c:if test="${result.state == state.code}">
													
													<a href="javascript:toggleStateLayer('${result.no}');" id="state_${result.no}">
														<c:choose>
														<c:when test="${result.red == 'Y'}">
															<span class="txt_red">${state.codeNm}</span>
														</c:when>
														<c:otherwise>
															${state.codeNm}
														</c:otherwise>
														</c:choose>
													</a>
												</c:if>
											</c:forEach>
										</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!--// 게시판 끝 -->
						<form name="popFrm" method="POST" action="${rootPath}/cooperation/selectSearchCustNmConsultManageList.do">
							<input type="hidden" name="searchCuNm2"/>
						</form>
						
						<!-- 수신자 변경 레이어  -->
						<form name="receiveFrm" method="POST" >
						<div id="RecieverLayer" class="Receiver_layer" style="display:none;">
							<p><span class="txtB_Black">담당자 변경</span></p>
							<div class="boardWrite02 mB20">
							
							<input type="hidden" name="consult_no" value="" />
							<table cellpadding="0" cellspacing="0">
								<colgroup><col class="col100" /><col width="px"/></colgroup>
								<tbody>
									<tr>
										<td class="title" >담당자</td>
										<td class="pL10">
											<input type="text" class="span_13 userNamesAuto userValidateCheck" name="chargedUserIdMix" id="chargedUserIdMix" value="" />
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('chargedUserIdMix',0)"/>
										</td>
									</tr>
								</tbody>
							</table>
							</div>
							
							<div class="btn_area">
								<a href="javascript:changeRecieve();"><img src="${imagePath}/btn/btn_apply.gif"/></a>
								<a href="javascript:recieveLayerHide();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
							</div>
						</div>
						</form>
						<!--// 수신자 변경 레이어  -->
						
						<!-- 처리상태 변경 레이어  -->
						<form name="stateFrm" method="POST" >
						<div id="stateLayer" class="state_layer" style="display:none;">
							<p><span class="txtB_Black">※ 처리결과 등록</span></p>
							<div class="boardWrite02 mB20">
							 
							<input type="hidden" name="consult_no" value="" />
							<table cellpadding="0" cellspacing="0">
								<colgroup><col class="col100" /><col width="px"/></colgroup>
								<tbody>
									<tr>
										<td class="title" >처리상태</td>
										<td class="pL10">
											<label><input type="radio" name="state" value="3" checked="checked" />완료 &nbsp;</label>
											<label><input type="radio" name="state" value="2" />처리중 &nbsp;</label>
										</td>
									</tr>
									<tr>
										<td class="title" >처리일시</td>
										<td class="pL10">
											<input type="text" id="complete_date" name="complete_date" class="input01 span_5 calGen" onchange="javascript:chngCompleteDt();"/>
											<input type="text" id="complete_tm" name="complete_tm" class="input01 span_3" maxlength="2" onchange="javascript:chngCompleteDt();" /> 시
											<br/>
											<input type="button" value="현재" class="btn_gray" onclick="javascript:setCompleteDt('immediate');"/>
											<input type="button" value="1시간 전" class="btn_gray" onclick="javascript:setCompleteDt('before1h');"/>
											<input type="button" value="1시간 후" class="btn_gray" onclick="javascript:setCompleteDt('after1h');"/>
										</td>
									</tr>
								</tbody>
							</table>
							</div>
							
							<div class="pop_btn_area">
								<img src="${imagePath}/btn/btn_regist.gif" alt="등록" class="cursorPointer" onclick="javascript:updateState()"/>
								<img src="${imagePath}/btn/btn_cancel.gif" alt="취소" class="cursorPointer" onclick="javascript:stateLayerHide()">
							</div>
						</div>
						</form>
						<!--// 처리상태 변경 레이어  -->
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
