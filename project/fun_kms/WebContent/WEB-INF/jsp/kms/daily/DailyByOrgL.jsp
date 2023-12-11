<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function MoveDate(dateMove) {
	document.dailyPlanFm.dateMove.value = dateMove;
	document.dailyPlanFm.action = "${rootPath}/daily/DailyByOrgL.do";
	document.dailyPlanFm.submit();
}

function searchOthers(writerOrgnztId, writerOrgnztName) {
	document.dailyPlanFm.writerOrgnztId.value = writerOrgnztId;
	document.dailyPlanFm.writerOrgnztName.value = writerOrgnztName;
	document.dailyPlanFm.action = "${rootPath}/daily/DailyByOrgL.do";
	document.dailyPlanFm.submit();
}

function searchWeek() {
	document.dailyPlanFm.action = "${rootPath}/daily/DailyByWeekL.do";
	document.dailyPlanFm.submit();
}

function searchOthersWeek(writerNo, writerName) {
	document.dailyPlanFm.writerNo.value = writerNo;
	document.dailyPlanFm.writerName.value = writerName;
	document.dailyPlanFm.action = "${rootPath}/daily/DailyByWeekL.do";
	document.dailyPlanFm.submit();
}
function writeDailyPlan(no, writerNo, writeDate) {
	
	var popup = window.open("${rootPath}/daily/DailyPlanWUPop.do?no=" + no + "&writerNo=" + writerNo + "&writeDate=" + writeDate, "_DAY_REPORT_POP_","width=700px, height=650px,scrollbars=yes");
	popup.focus();
}

function writeDailyResult(no, writerNo, writeDate) {
	if(no == 0){
		alert("실적등록은 업무계획이 먼저 작성되어야 합니다");
		return;
	}
	var s_width = screen.width;
	var s_height = screen.height;
	var left = -1000;
	var top = 100;
	
	var url = "${rootPath}/daily/DailyResultWUPop.do?writerNo=" + writerNo + "&writeDate=" + writeDate;
	var title = "_DAY_PROJECT_POP_";
//	var option = "width=800px,height=600px,scrollbars=yes";
	var option = "width=900px, height=800px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	
	var popup = window.open(url, title, option);
	//	popup.moveTo( ( ( (s_width -500)/2* (-1)) ), ((s_height-570)/2));
	//	popup.moveTo(200, 200);
	popup.focus();
}
function showBtn(idx, kind) {
	if($('#writerNo').val() != $('#userNo').val()) {
		if($('#userNo').val() != '2'){
			return;
		}
	}
	document.getElementById("btn_" + idx + "_" + kind).style.display = "";
}
function hideBtn(idx, kind) {
	if($('#writerNo').val() != $('#userNo').val()) {
		if($('#userNo').val() != '2'){
			return;
		}
	}
	document.getElementById("btn_" + idx + "_" + kind).style.display = "none";
}
$('document').ready(function() {
	$('.toggle_select').addClass('mB20');
	
	//토글 버튼 활성화
	$('.toggle_select').click(function(){
		if($(this).hasClass('btn_arrow_down')){
			$(this).removeClass('btn_arrow_down');
			$(this).addClass('btn_arrow_up');
			$('.toggle_select').removeClass('mB20');
			$('#toggle_select_div').show();
		}
		else{
			$(this).removeClass('btn_arrow_up');
			$(this).addClass('btn_arrow_down');
			$('.toggle_select').addClass('mB20');
			$('#toggle_select_div').hide();
		}
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
						<li class="stitle">나의업무(부서별)</li>
						<li class="navi">홈 > 업무공유  > 나의업무(부서별) </li>
					</ul>
				</div>
				
				<span class="stxt01">※ 부서원들의 업무계획 및 업무실적을 상호참조할 수 있습니다.</span>
<!-- 				<span class="stxt_btn">
					<a href="javascript:dayPlanTyp('MY');"><img src="${imagePath}/btn/btn_myview.gif"/></a>
					<a href="javascript:dayPlanTyp('B');"><img src="${imagePath}/btn/btn_sumview.gif"/></a>
				</span>
 -->				
				<!-- S: section -->
				<div class="section01">
				
				<!-- 상단 검색창 시작 -->
				<form name="dailyPlanFm" id="dailyPlanFm" method="GET" >
					<input type="hidden" name="searchUseYn" value="Y"/>
					<input type="hidden" name="dateMove" value="0"/>
					<input type="hidden" name="writerOrgnztId" id="writerOrgnztId" value="${writerOrgnztId}"/>
					<input type="hidden" name="userNo" id="userNo" value="${user.userNo}"/>
					<input type="hidden" name="writerNo" id="writerNo" value="0"/>
					<input type="hidden" name="writerName" id="writerName" value=""/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<colgroup>
							<col class="col100">
							<col width="px">
							<col class="col100">
						</colgroup>
						<tbody>
							<tr>
								<td>
									<span class="tooltip" onmouseover="bindTooltip(this, '6121', '200');">
									<input type="text" class="input03 w150" name="writerOrgnztName" id="writerOrgnztName" value="${writerOrgnztName}"/>
									</span>
								</td>
								<td  class="searchInput"> <span class="tooltip" onmouseover="bindTooltip(this, '6122', '200');">기준일 : </span>
									<a href="javascript:MoveDate(-7);"><img src="${imagePath}/btn/btn_first.gif"/></a>
									<a href="javascript:MoveDate(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif"></a>
									<input type="text" class="calGen w70 input03" name="atDate" value="${atDate}" readonly="readonly" 
											onchange="javascript:MoveDate(0);"/>
									<a href="javascript:MoveDate(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif"></a>
									<a href="javascript:MoveDate(7);"><img src="${imagePath}/btn/btn_end.gif"></a>
								</td>
									<td>
									<span class="stxt_btn">
										<a href="javascript:searchWeek();"><img src="${imagePath}/btn/btn_dailyWeek.gif"/></a>
									</span>
								</td>
							</tr>
							<tr>
								<td class="pT5 txt_left" colspan="3">
									<c:set var="listCount" value="${fn:length(organList)}" />
									<c:forEach items="${organList}" var="organ" varStatus="s">
										<c:choose>
											<c:when test="${user.isLeader eq 'Y'}">
												<c:if test="${organ.orgnztId eq 'ORGAN_00000000000001' || organ.orgnztId eq 'ORGAN_00000000000311' || organ.orgnztId eq 'ORGAN_00000000000211' || organ.orgnztId eq 'ORGAN_00000000000012' || organ.orgnztId eq 'ORGAN_TOP_ORGAN_CODE' || organ.orgnztId eq 'ORGAN_00000000000441'}">
													<c:if test="${(organ.orgnztId != 'ORGAN_STD_ORGAN_CODE') && (organ.orgnztId != 'ORGAN_RET_ORGAN_CODE')}">
														<c:if test="${(listCount > 10) && ((s.count == '6') || (s.count == '10') || (s.count == '13') || (s.count == '17')  || (s.count == '22') || (s.count == '27'))}"></br></c:if>
														<span class="txtB_Black pL10"><a href="javascript:searchOthers('${organ.orgnztId}', '${organ.orgnztNm}')"> ${organ.orgnztNm} [${organ.orgLv}]</a></span>
													</c:if>
												</c:if>
											</c:when>
											<c:otherwise>
												<c:if test="${(organ.orgnztId != 'ORGAN_STD_ORGAN_CODE') && (organ.orgnztId != 'ORGAN_RET_ORGAN_CODE')}">
													<c:if test="${(listCount > 10) && ((s.count == '6') || (s.count == '10') || (s.count == '13') || (s.count == '17')  || (s.count == '22') || (s.count == '27'))}"></br></c:if>
													<span class="txtB_Black pL10"><a href="javascript:searchOthers('${organ.orgnztId}', '${organ.orgnztNm}')"> ${organ.orgnztNm} [${organ.orgLv}]</a></span>
												</c:if>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</td>
							</tr>
						</tbody>
						</table>
						</div>
					</fieldset>
					
				</form>
				<!--// 상단 검색창 끝 -->
				
				
				<!-- 게시판 시작  -->
					<div class="boardList02 mB5">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<colgroup>
							<col class="col50" />
							<col class="col350"/>
							<col class="col500"/>
						</colgroup>
						<thead>
							<tr>
								<th>작성자</th>
								<th>업무 계획</th>
								<th class="td_last">업무 실적</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${dailyPlanVOList}" var="vo" varStatus="status">
							<tr class="TrBg${searchAtDate == vo.writeDate ? 2 : 3}" id="row_${status.index}">
								<td class="SolLine txt_center Bg_color0${searchAtDate == vo.writeDate ? 2 : 1}" >
									<a href="javascript:searchOthersWeek(${vo.writerNo}, '${vo.writerName}');">
									<span class="T11" >${vo.writerName}</span></a></td>
								<td class="SolLine verTop p5 " onmouseover="showBtn('${status.index}', '0')" onmouseout="hideBtn('${status.index}', '0')">
									<p class=th_plus03><a href="javascript:writeDailyPlan(${vo.no}, ${vo.writerNo}, ${empty vo.writeDate ? atDate : vo.writeDate});">
									<img src="${imagePath}/editor/btn_regist.gif" id="btn_${status.index}_0" style="display:none;"/></a></p>
<!--									<p class="textarea1"><c:out value="${fn:replace(vo.contents, cn, br)}" escapeXml="false"/></p>
-->									<p class="textarea1">${vo.contents}</p>
								</td>
								<td class="SolLine verTop p5 td_last" onmouseover="showBtn('${status.index}', '1')" onmouseout="hideBtn('${status.index}', '1')">
									<p class=th_plus03><a href="javascript:writeDailyResult(${vo.no}, ${vo.writerNo}, ${empty vo.writeDate ? atDate : vo.writeDate});">
									<img src="${imagePath}/editor/btn_regist.gif" id="btn_${status.index}_1" style="display:none;"/></a></p>
								<c:forEach items="${vo.dailyResultVOList}" var="pvo" varStatus="s">
									<p class="th_plus04 txtB_Black"><print:project prjId="${pvo.prjId}" prjCd="${pvo.prjCd}" prjNm="${pvo.prjName}"/></p>
									<p class="th_plus04 txtB_blue">&nbsp;[${pvo.workHour}시간]</p></br>
									<p class="textarea1"><c:out value="${fn:replace(pvo.contents, cn, br)}" escapeXml="false"/></p>
								</c:forEach>
								</td>
							</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>

					<div class="btn_area02 mB10">
						<a href="#dailyPlanFm"><img src="${imagePath}/btn/btn_top.gif"/></a>
					</div>
					<!--// 게시판  끝  -->
					
				</div>
				<!-- E: section -->
			</div>
			<!-- E: center -->
			<%@ include file="/WEB-INF/jsp/kms/common/menu/right.jsp"%>
			</div>
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div> <!-- wrap -->
</body>
</html>