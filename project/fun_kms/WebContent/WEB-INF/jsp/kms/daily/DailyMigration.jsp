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
function migrate() {
	document.dailyPlanFm.action = '<c:url value="/daily/migrateDailyPlan.do" />';
	document.dailyPlanFm.submit();
}

function MoveDate(dateMove) {
	document.dailyPlanFm.dateMove.value = dateMove;
	document.dailyPlanFm.action = "${rootPath}/daily/DailyMigration.do";
	document.dailyPlanFm.submit();
}

function searchOthers(writerNo, writerName) {
	document.dailyPlanFm.writerNo.value = writerNo;
	document.dailyPlanFm.writerName.value = writerName;
	document.dailyPlanFm.action = "${rootPath}/daily/DailyMigration.do";
	document.dailyPlanFm.submit();
}

function searchOrg() {
	document.dailyPlanFm.action = "${rootPath}/daily/DailyByOrgL.do";
	document.dailyPlanFm.submit();
}

function writeDailyPlan(no, writerNo, writeDate) {
	var popup = window.open("${rootPath}/daily/DailyPlanWUPop.do?no=" + no + "&writerNo=" + writerNo + "&writeDate=" + writeDate, "_DAY_REPORT_POP_","width=700px, height=600px,scrollbars=yes");
	popup.
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
		return;
	}
	document.getElementById("btn_" + idx + "_" + kind).style.display = "";
}
function hideBtn(idx, kind) {
	if($('#writerNo').val() != $('#userNo').val()) {
		return;
	}
	document.getElementById("btn_" + idx + "_" + kind).style.display = "none";
}

function setLeader(leader) {
	document.frm.searchUserNm.value = leader;
	search(0);
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
						<li class="stitle">나의업무(개인별) </li>
						<li class="navi">홈 > 업무공유  > 나의업무(개인별) </li>
					</ul>
				</div>
				
				<span class="stxt01">※ 개인별 업무계획 및 업무실적을 관리하는 곳입니다. 부서원간 참조할 수 있습니다.</span>
				<!-- S: section -->
				<div class="section01">
				
				<!-- 상단 검색창 시작 -->
				<form name="dailyPlanFm" id="dailyPlanFm" method="POST" >
					<input type="hidden" name="searchUseYn" value="Y"/>
					<input type="hidden" name="dateMove" value="0"/>
					<input type="hidden" name="userNo" id="userNo" value="${user.userNo}"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<colgroup>
							<col class="col100">
							<col width="px">
							<col width="px">
							<col class="col100">
						</colgroup>
						<tbody>
							<tr>
								<td>
									<span class="tooltip" onmouseover="bindTooltip(this, '6121', '200');">
									<input type="text" class="input03 w60" name="writerName" value="${searchWriterName}"/>
									</span>
								</td>
								<td  class="searchInput"> <span class="tooltip" onmouseover="bindTooltip(this, '6122', '200');">기준일 : </span>
									<a href="javascript:MoveDate(-28);"><img src="${imagePath}/btn/btn_first.gif"/></a>
									<a href="javascript:MoveDate(-7);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif"></a>
									<input type="text" class="calGen w70 input03" name="atDate" value="${searchAtDate}" readonly="readonly" 
											onchange="javascript:MoveDate(0);"/>
									<a href="javascript:MoveDate(7);" class="pL10"><img src="${imagePath}/btn/btn_next.gif"></a>
									<a href="javascript:MoveDate(28);"><img src="${imagePath}/btn/btn_end.gif"></a>
								</td>
								<td  class="searchInput"> 
									<span class="tooltip" onmouseover="bindTooltip(this, '6122', '200');">시작일 : </span>
									<input type="text" class="calGen w70 input03" name="fromDate" value="20170101" readonly="readonly" />
									<span class="tooltip" onmouseover="bindTooltip(this, '6122', '200');">종료일 : </span>
									<input type="text" class="calGen w70 input03" name="toDate" value="20170414" readonly="readonly" />
									<input type="text" name="writerNo" id="writerNo" value="0"/>
								</td>
								<td>
									<c:if test="${user.isLeader == 'Y'}">
									<span class="stxt_btn">
										<a href="javascript:migrate();"><img src="${imagePath}/editor/btn_add.gif"/></a>
									</span>
									</c:if>
								</td>
							</tr>
							<tr>
								<td class="pT5 txt_center" colspan="3">
										<a href="javascript:searchOthers('2', '서장열')">
											<span class="txtB_Black pL10"> 서장열 </span></a>
									<c:forEach items="${memberList}" var="member" varStatus="s">
										<c:if test="${member.userNo != searchWriterNo}">
										<a href="javascript:searchOthers('${member.userNo}', '${member.userName}')">
											<span class="txtB_Black pL10"> ${member.userName} </span></a>
										</c:if>
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
					<p >
						<a href="#row_0"><img src="${imagePath}/btn/btn_Mon.gif"/></a>
						<a href="#row_1"><img src="${imagePath}/btn/btn_Tue.gif"/></a>
						<a href="#row_2"><img src="${imagePath}/btn/btn_Wed.gif"/></a>
						<a href="#row_3"><img src="${imagePath}/btn/btn_Thu.gif"/></a>
						<a href="#row_4"><img src="${imagePath}/btn/btn_Fri.gif"/></a>
						<a href="#row_5"><img src="${imagePath}/btn/btn_Sat.gif"/></a>
						<a href="#row_6"><img src="${imagePath}/btn/btn_Sun.gif"/></a>
					</p>
<!--
	 					<p class="th_plus03">
						<a href="javascript:writeTask('');"><img src="${imagePath}/btn/btn_newWork.gif"/></a>
					</p>
 -->
					<div class="boardList02 mB5">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<colgroup>
							<col class="col50" />
							<col class="col400"/>
							<col width="px">
						</colgroup>
						<thead>
							<tr>
								<th>요일</th>
								<th>업무 계획</th>
								<th class="td_last">업무 실적</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${dailyPlanVOList}" var="vo" varStatus="status">
							<tr class="TrBg${searchAtDate == vo.writeDate ? 2 : 3}" id="row_${status.index}">
								<td class="SolLine txt_center Bg_color0${searchAtDate == vo.writeDate ? 2 : 1}" >${vo.writeDay}요일<br/>
									<span class="T11" ><print:date date="${vo.writeDate}" printType="S"/></span></td>
								<td class="SolLine verTop p5 " onmouseover="showBtn('${status.index}', '0')" onmouseout="hideBtn('${status.index}', '0')">
									<p class=th_plus03><a href="javascript:writeDailyPlan(${vo.no}, ${vo.writerNo}, ${vo.writeDate});">
									<img src="${imagePath}/editor/btn_regist.gif" id="btn_${status.index}_0" style="display:none;"/></a></p>
<!--									<p class="textarea1"><c:out value="${fn:replace(vo.contents, cn, br)}" escapeXml="false"/></p>
-->									<p class="textarea1">${vo.contents}</p>
								</td>
								<td class="SolLine verTop p5 td_last" onmouseover="showBtn('${status.index}', '1')" onmouseout="hideBtn('${status.index}', '1')">
									<p class=th_plus03><a href="javascript:writeDailyResult(${vo.no}, ${vo.writerNo}, ${vo.writeDate});">
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