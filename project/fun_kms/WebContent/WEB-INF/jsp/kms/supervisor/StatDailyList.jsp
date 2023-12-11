<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>
$(document).ready(function(){

});

function search() {
	// todo
	var form = $('#frm1');
	if(form.find('[name=startDt]').val() == null || form.find('[name=startDt]').val().length<8 ||
			form.find('[name=endDt]').val() == null || form.find('[name=endDt]').val().length<8){
		alert("시작일/종료일을 입력하여 주십시오.");
		return; 
	}
	document.frm1.action = "/admin/statistics/selectDayReportExcel1.do";
	document.frm1.submit();
}

function MoveDate(dateMove) {
	/* checkValidUserMixsAuth가 머하는 기능인지 잘 모르겠음 
		var error = checkValidUserMixsAuth(document.frm.searchUserNm.value);
		if(error["errorCode"] == 2 || error["errorCode"] == 3 || error["errorCode"] == 4) {
			return;
		}
	*/
	document.dailyReportFm.dateMove.value = dateMove;
	document.dailyReportFm.action = "${rootPath}/daily/DailyReportWeekList.do";
	document.dailyReportFm.submit();
}

</script>
</head>

<body>
<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../include/left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">업무실적 입력현황</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	

				<!-- 상단 검색창 시작 -->
				<form name="dailyReportFm" id="dailyReportFm" method="POST" >
					<input type="hidden" name="searchUseYn" value="Y"/>
					<input type="hidden" name="dateMove" value="0"/>
					<input type="hidden" name="writerNo" id="writerNo" value="${searchWriterNo}"/>
					<input type="hidden" name="userNo" id="userNo" value="${user.userNo}"/>
					<fieldset>
					<legend>상단 검색</legend>
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
									<span class="tooltip" onmouseover="bindTooltip(this, '6121', '200');">
									<input type="text" class="input03 w60" name="writerName" value="${searchWriterName}"/>
									</span>
								</td>
								<td  class="searchInput"> <span class="tooltip" onmouseover="bindTooltip(this, '6122', '200');">기준일 : </span>
									<a href="javascript:MoveDate(-28);"><img src="${imagePath}/btn/btn_first.gif"/></a>
									<a href="javascript:MoveDate(-7);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif"></a>
									<input type="text" class="calGen w60 input03" name="atDate" value="${searchAtDate}" readonly="readonly" 
											onchange="javascript:MoveDate(0);"/>
									<a href="javascript:MoveDate(7);" class="pL10"><img src="${imagePath}/btn/btn_next.gif"></a>
									<a href="javascript:MoveDate(28);"><img src="${imagePath}/btn/btn_end.gif"></a>
								</td>
							</tr>
							<tr>
								<td class="pT5 txt_center" colspan="2">
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
					</div>
					<!-- E: section -->	
					<div class="boardList02 mB5">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<colgroup>
							<col class="col50" />
							<col class="col350"/>
							<col class="col500"/>
						</colgroup>
						<thead>
							<tr>
								<th>요일</th>
								<th>업무 계획</th>
								<th class="td_last">업무 실적</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${dailyReportVOList}" var="vo" varStatus="status">
							<tr class="TrBg${searchAtDate == vo.writeDate ? 2 : 3}" id="row_${status.index}">
								<td class="SolLine txt_center Bg_color0${searchAtDate == vo.writeDate ? 2 : 1}" >${vo.writeDay}요일<br/>
									<span class="T11" ><print:date date="${vo.writeDate}" printType="S"/></span></td>
								<td class="SolLine verTop p5 " onmouseover="showBtn('${status.index}', '0')" onmouseout="hideBtn('${status.index}', '0')">
									<p class=th_plus03><a href="javascript:writeDailyReport(${vo.no}, ${vo.writeDate});">
									<img src="${imagePath}/editor/btn_regist.gif" id="btn_${status.index}_0" style="display:none;"/></a></p>
<!--									<p class="textarea1"><c:out value="${fn:replace(vo.contents, cn, br)}" escapeXml="false"/></p>
-->									<p class="textarea1">${vo.contents}</p>
								</td>
								<td class="SolLine verTop p5 td_last" onmouseover="showBtn('${status.index}', '1')" onmouseout="hideBtn('${status.index}', '1')">
									<p class=th_plus03><a href="javascript:writeDailyProject(${vo.no}, ${vo.writeDate});">
									<img src="${imagePath}/editor/btn_regist.gif" id="btn_${status.index}_1" style="display:none;"/></a></p>
								<c:forEach items="${vo.dailyProjectVOList}" var="pvo" varStatus="s">
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


				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
