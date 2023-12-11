<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<%
pageContext.setAttribute("crcn","\r\n");
pageContext.setAttribute("br","</br>");
%>
<script>

function search(searchType) {
	var error = checkValidUserMixsAuth(document.frm.searchUserNm.value);
	if(error["errorCode"] == 2 || error["errorCode"] == 3 || error["errorCode"] == 4) {
		return;
	}
		
	document.frm.searchType.value = searchType;
	
	if($("#includeEndCheck").prop("checked")){
		document.frm.includeEnd.value = 'Y';
	}else{
		document.frm.includeEnd.value = 'N';
	}

	if(searchType == 'seven'){
		document.frm.searchDateFrom.value = '${searchVO.searchFirstDateOfThisWeek}'; 
		document.frm.searchDateTo.value = '${searchVO.searchLastDateOfThisWeek}'; 
	}else if(searchType == 'thirty'){
		var df = document.frm.searchDateFrom.value; 
		var dt = document.frm.searchDateTo.value;
		document.frm.searchDateFrom.value = getFirstDayOfMonth(df);
		document.frm.searchDateTo.value = getLastDayOfMonth(df);
	}else if(searchType == 'next'){
		var df = document.frm.searchDateFrom.value; 
		var dt = document.frm.searchDateTo.value;
		document.frm.searchDateFrom.value = getFirstDayOfMonth(df);
		document.frm.searchDateTo.value = getLastDayOfMonth(df);
	}
	
	document.frm.action = "${rootPath}/cooperation/selectDayReportMyList.do";	
	document.frm.submit();
}


function searchDate(dateMove) {
	var error = checkValidUserMixsAuth(document.frm.searchUserNm.value);
	if(error["errorCode"] == 2 || error["errorCode"] == 3 || error["errorCode"] == 4) {
		return;
	}
		
	document.frm.searchType.value = '${searchVO.searchType}';
	
	if($("#includeEndCheck").prop("checked")){
		document.frm.includeEnd.value = 'Y';
	}else{
		document.frm.includeEnd.value = 'N';
	}
	document.frm.dateMove.value = dateMove;
	document.frm.action = "${rootPath}/cooperation/selectDayReportMyList.do";	
	document.frm.submit();
}



function viewTask(taskId) {
	document.frm.taskId.value = taskId;
	document.frm.action = "${rootPath}/cooperation/selectTaskInfo.do";
	document.frm.submit();
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

function setLeader(leader) {
	document.frm.searchUserNm.value = leader;
	search('${searchVO.searchType}');
}

function writeTask() {
	var popup = window.open("${rootPath}/cooperation/insertTaskView.do?no=${searchVO.searchUserNo}&date=","_TASK_POP_","width=570px,height=450px,scrollbars=yes,resizable=yes");
	popup.focus();
}

function writeDayReport(taskId) {
	var popup = window.open("${rootPath}/cooperation/insertDayReportView.do?taskId=" + taskId + "&userNo=${searchVO.searchUserNo}&searchDate=","_DAY_REPORT_POP_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}


function hideLayerName(openedLayerName) {
	$('#'+openedLayerName).hide();
}

function leaderModifyCall(taskId,leaderMixes){
	document.layerFrm.taskId.value = taskId; 
	document.layerFrm.leaderMixes.value = leaderMixes; 
	
	$('#leaderModify').hide();
	$('#taskDuedateModify').hide();
	$('#endDtModify').hide();
	var scrolled = $(window).scrollTop();
	var position = $('#leaderModifyPosition_'+taskId).offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#leaderModify').css("left",($('#leaderModifyPosition_'+taskId).offset().left+46)+"px");
	$('#leaderModify').css("top",($('#leaderModifyPosition_'+taskId).offset().top+28)+"px");	
	$('#leaderModify').show();
}

function leaderModify(){
	document.layerFrm.taskDuedate.value = "";
	document.layerFrm.taskState.value = "";

	if($("#includeEndCheck").prop("checked")){
		document.layerFrm.includeEnd.value = 'Y';
	}else{
		document.layerFrm.includeEnd.value = 'N';
	}

	
	if(document.layerFrm.leaderMixes.value == ""){
		alert('담당자를 입력하십시오.');
	}else{
		document.layerFrm.action = "${rootPath}/cooperation/updateTaskState.do";
		document.layerFrm.submit();		
	}

}


function taskDuedateModifyCall(taskId,taskDuedate, taskStartdate){
	
	document.layerFrm.taskId.value = taskId; 
	document.layerFrm.taskDuedate.value = taskDuedate; 
	document.layerFrm.taskStartdate.value = taskStartdate; 
	
	$('#leaderModify').hide();
	$('#taskDuedateModify').hide();
	$('#endDtModify').hide();
	var scrolled = $(window).scrollTop();
	var position = $('#taskDuedateModifyPosition_'+taskId).offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#taskDuedateModify').css("left",($('#taskDuedateModifyPosition_'+taskId).offset().left+46)+"px");
	$('#taskDuedateModify').css("top",($('#taskDuedateModifyPosition_'+taskId).offset().top+28)+"px");	
	$('#taskDuedateModify').show();
}
function taskDuedateModify(){
	
	if(document.layerFrm.taskDuedate.value == ""){
		document.layerFrm.leaderMixes.value = "";
		document.layerFrm.taskState.value = "";
		document.layerFrm.taskDuedate.value = "";
		document.layerFrm.taskStartdate.value = "";
		alert('완료 예정일을 입력하십시오.');
		return;
	}else if(document.layerFrm.taskStartdate.value == ""){
		document.layerFrm.leaderMixes.value = "";
		document.layerFrm.taskState.value = "";
		document.layerFrm.taskDuedate.value = "";
		document.layerFrm.taskStartdate.value = "";
		alert('시작일을 입력하십시오.');
		return;
	}else{
		document.layerFrm.leaderMixes.value = "";
		document.layerFrm.taskState.value = "";

		if($("#includeEndCheck").prop("checked")){
			document.layerFrm.includeEnd.value = 'Y';
		}else{
			document.layerFrm.includeEnd.value = 'N';
		}
		
		document.layerFrm.action = "${rootPath}/cooperation/updateTaskState.do";
		document.layerFrm.submit();	
				
	}
}


function endDtModifyCall(taskId, taskState, dayReportTm,dayReportCnt){
	if(dayReportCnt == "0"){
		alert("등록된 실적이 없습니다.");
	}else{
		document.layerFrm.taskId.value = taskId; 
		if(taskState == 'C'){
			//document.layerFrm.taskState.value = "P"; 
			//$('#PText').hide();
			//$('#CText').show();
			alert("미완료는 작업 상세 보기에서 업무확인 후 처리 하시기 바랍니다.");
			return;
			
		}else{
			document.layerFrm.taskState.value = "C";
			$('#CText').hide();
			$('#PText').show();
		}
		$('#leaderModify').hide();
		$('#taskDuedateModify').hide();
		$('#endDtModify').hide();
		var scrolled = $(window).scrollTop();
		var position = $('#endDtModifyPosition_'+taskId).offset();
		var left = position.left + 0;
		var top = position.top + 10 - scrolled ;
		$('#endDtModify').css("left",($('#endDtModifyPosition_'+taskId).offset().left+46)+"px");
		$('#endDtModify').css("top",($('#endDtModifyPosition_'+taskId).offset().top+28)+"px");	
		$('#endDtModify').show();
	}
}
function endDtModify(){
	document.layerFrm.leaderMixes.value = "";
	document.layerFrm.taskDuedate.value = "";

	if($("#includeEndCheck").prop("checked")){
		document.layerFrm.includeEnd.value = 'Y';
	}else{
		document.layerFrm.includeEnd.value = 'N';
	}

	
	document.layerFrm.action = "${rootPath}/cooperation/updateTaskState.do";
	document.layerFrm.submit();	
}


function showDRLayer(taskId, sDate, eDate, obj) {
	var position = $(obj).position();
	var width = $(obj).width();
	var height = $(obj).height();

	$('#dRLayer').html("");
	
	$.post("${rootPath}/ajax/dayReportLayer.do?searchUserNo=${searchVO.searchUserNo}&taskId=" + taskId + "&sDate=" + sDate + "&eDate=" + eDate,
			function(data){
				$('#dRLayer').html(data);

				var str_value = data;
				var re;
				var resultArray;
				var br = 0;
				var p = 0;
				var dt = 0;
				var li = 0;
				var h = 0;
								
				if(str_value.indexOf("br") > 0){
				re = new RegExp("br", "ig");
				resultArray = str_value.match(re);
				br = resultArray.length*18;
				}
				//if(str_value.indexOf("/p") > 0){
				//re = new RegExp("/p", "ig");
				//resultArray = str_value.match(re);
				//p = resultArray.length;
				//}
				if(str_value.indexOf("/dt") > 0){
				re = new RegExp("/dt", "ig");
				resultArray = str_value.match(re);
				dt = resultArray.length*41;	
				}
				if(str_value.indexOf("/li") > 0){
				re = new RegExp("/li", "ig");
				resultArray = str_value.match(re);
				li = (resultArray.length-1)*20;
				}
				h = br + p + dt + li; 		

				//document.getElementById("dRLayer").style.top = position.top + (height/2 + 10) + "px";
				document.getElementById("dRLayer").style.top = position.top - h + "px";

				document.getElementById("dRLayer").style.left = position.left + (width/2 + 10) + "px";				
				$('#dRLayer').show();				
		}
	);
}

function hideDRLayer() {
	$('#dRLayer').hide();
}


function showDRPop(date, userNo, taskId) {
	var popup = window.open("${rootPath}/cooperation/selectDayReportList.do?taskId=" + taskId + "&date=" + date + "&param_userNo=" + userNo, "_POP_DAYREPORT_", "width=560px,height=570px,scrollbars=yes");
	popup.focus();
}

function dayReportTyp(typ) {
	$.post("/member/updateUiSetting.do?dayReportTyp=" + typ, function(data) {
		if (data == '\r\nsuccess') {
			document.frm.action = "${rootPath}/cooperation/selectDayReport.do";
			document.frm.submit();
		}
	});
}


function showToolTip(layerName, obj, text, pos) {	

	var scrolled = $(window).scrollTop();
	var position = $('#'+obj).offset();	
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;	

	$('#ToolTipBox').hide();
	var ToolTipBox = document.getElementById("ToolTipBox");
	ToolTipBox.innerHTML = text;
	
	$('#'+layerName).css("left",($('#'+obj).offset().left+5)+"px");
	if(pos == 'up'){
		var height = $('#ToolTipBox').height()+1;
		$('#'+layerName).css("top",($('#'+obj).offset().top-height)+"px");	
	}else if(pos == 'down'){
		$('#'+layerName).css("top",($('#'+obj).offset().top+28)+"px");	
	}
	$('#'+layerName).show();
	
}

function hideToolTip()
{	
	$('#ToolTipBox').hide();
}

function writeProject() {
	$.ajax({
		url: "/ajax/selectPrntPrjListCnt.do",
		type: "POST",
		async: false,
		//dataType: "json",
		success: function(data) {
			if (data.indexOf("PRJ_") > -1) {
				//document.newPrjFrm.prntPrjId.value = data;
				document.newPrjFrm.submit();
			} else { 
				alert("프로젝트 생성 권한이 없습니다.");
			}
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("데이터 로딩에 실패했습니다. 관리자에게 문의해주세요.");
			return false;
		}
	});
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
							<li class="stitle">나의 업무</li>
							<li class="navi">홈 > 업무공유 > 업무계획/실적 > 나의 업무</li>
						</ul>
					</div>
	
					<span class="stxt">하루를 시작할때 업무를 정의하고 하루를 마감할때 업무를 정리하는 곳입니다.</span>
				<span class="stxt_btn">
					<a href="javascript:dayReportTyp('B');"><img src="${imagePath}/btn/btn_sumview.gif"/></a>
					<a href="javascript:dayReportTyp('D');"><img src="${imagePath}/btn/btn_detailview.gif"/></a>		                                		                
				</span>
	
				<!-- S: section -->
				<div class="section01">			    	
				<!-- 상단 검색창 시작 -->
			    <form name="frm" id="searchFrm" method="get" onsubmit="search('${searchVO.searchType}'); return false;">
			    	<input type="hidden" name="dateMove" value="0"/>
			    	<input type="hidden" name="searchType" value="${searchVO.searchType}"/>			    	
			    	<input type="hidden" name="taskId" value=""/>
			    	<input type="hidden" name="taskState" value=""/>		    	
			    	<input type="hidden" name="includeEnd" value="${searchVO.includeEnd}"/>
			    	
			    	<input type="hidden" name="searchDateFrom" value="${searchVO.searchDateFrom}"/>		    	
			    	<input type="hidden" name="searchDateTo" value="${searchVO.searchDateTo}"/>		    	
		    				    	
			    	<input type="hidden" name="param_returnUrl" value="/cooperation/selectDayReportMyList.do"/>
	                <fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								
								<c:choose>
									<c:when test="${searchVO.searchType == 'today'}">
									<td class="val_Top pT5 pL5" style="width: 110px">
			               	 			<a href="javascript:searchDate(-1);"><img src="${imagePath}/btn/btn_arw_left.gif"></a>
			                			<input type="text" name="searchDate" value="${searchVO.searchDate}" class="calGen" maxlength="8" style="width:55px;"/>
										<a href="javascript:searchDate(1);"><img src="${imagePath}/btn/btn_arw_right.gif"></a>
			                		</td>
			                    	</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								
								<td class="val_Top pT5 pL5 search_left">
                   				사용자 :<input type="text" class="search_txt02 userNameAuto userValidateCheckAuth" name="searchUserNm" id="searchUserNm" value="${searchVO.searchUserNm}"/>
	                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm', 1, null, null, '1');" />
				                <span class="pL7"></span>
				            	<input type="checkbox" name="includeEndCheck"  id="includeEndCheck" onclick="javascript:search('${searchVO.searchType}');" <c:if test="${searchVO.includeEnd == 'Y'}">checked="checked"</c:if>> 
								<span style=""><b>완료된 작업</b></span>
								<span class="pL7"></span>
				                </td>
								<td class="val_Top search_right" rowspan="2">
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색"/>		                                		
			                    </td>
							</tr>
							
							<c:if test = "${searchVO.searchType != 'today'}">
							<input type="hidden" name="searchDate" value="${searchVO.today}"/>
							</c:if>
		                    <tr>
								<td class="pT5 search_left" colspan="3" style="text-align: left;">
									<span class="pL7"></span>
									<span class="option_txt">빠른 선택</span>
									<a href="javascript:setLeader('${searchVO.searchUserNm}');">${quickUserNm}</a>
									<img class="btn_arrow_down cursorPointer toggle_select"/>
									<div id="toggle_select_div" style="display:none;">
										<table>       		
											<fmt:parseNumber var="parseNum" value="${fn:length(resultList1)/12}" integerOnly="true" />
											<c:set var="totalTr" value="${parseNum}"/>
		               						<c:set var="plusTd" value="${(fn:length(resultList1)%12)}"/>
		               						<c:set var="endTd" value="${12 - plusTd}"/>
		               						<c:set var="curTr" value="${0}"/>			
		               						<c:forEach items="${resultList1}" var="resultList1" varStatus="cnt2">			               						
		               							<c:if test="${cnt2.count == 1}">
		               								<tr>
		               							</c:if>
		               								<td width="8%"><a href="javascript:setLeader('${resultList1.userNm}(${resultList1.userId})');">${resultList1.userNm}</a></td>               							
		               							<c:if test="${totalTr == curTr && cnt2.count == plusTd}">
		               								<c:forEach var="in" begin="1" end="${endTd}">
		               									<td width="8%">&nbsp;</td>
		               								</c:forEach>
		               							</c:if>
		               							<c:if test="${cnt2.count != 1 && cnt2.count % 12 == 0 && cnt2.last == false}">
		               								</tr>
		               								<tr>
		               								<c:set var="curTr" value="${curTr+1}"/>
		               							</c:if>
		               							<c:if test="${cnt2.last}">
		               								</tr>
		               							</c:if>
		               						</c:forEach>
	               						</table>
									</div>			
			                    </td>
		                    </tr>	
						</tbody>
						</table>
	                    </div>
	                </fieldset>
	            </form>
	            <!--// 상단 검색창 끝 -->					
					<div class="boardList mB20">
						<div class="tab_typeA">
							<ul>
								<li class="<c:choose>
											<c:when test="${searchVO.searchType == 'today'}">												
											on
											</c:when>										
											<c:otherwise>
											off												
											</c:otherwise>
											</c:choose>
											cursorPointer" 
									onclick="javascript:search('today');">오늘
									<span class="txt_blue3">(${todayPCnt} / ${todayCCnt})</span>
								</li> <!-- 수정  todayCCnt - todayPCnt => todayPCnt -->
								<li class="<c:choose>
											<c:when test="${searchVO.searchType == 'seven'}">												
											on
											</c:when>										
											<c:otherwise>
											off												
											</c:otherwise>
											</c:choose>
											cursorPointer" 
									 onclick="javascript:search('seven');">이번주
									<span class="txt_blue3">(${sevenPCnt} / ${sevenCCnt})</span>
								</li>
								<li class="<c:choose>
											<c:when test="${searchVO.searchType == 'thirty'}">												
											on
											</c:when>										
											<c:otherwise>
											off												
											</c:otherwise>
											</c:choose>
											cursorPointer" 
									 onclick="javascript:search('thirty');">이번달
									<span class="txt_blue3">(${thirtyPCnt} / ${thirtyCCnt})</span>
								</li>
								<li class="<c:choose>
											<c:when test="${searchVO.searchType == 'next'}">												
											on
											</c:when>										
											<c:otherwise>
											off												
											</c:otherwise>
											</c:choose>
											cursorPointer" 
									 onclick="javascript:search('next');">향후
									<span class="txt_blue3">(${nextPCnt} / ${nextCCnt})</span>
								</li>
							</ul>

							<!-- 버튼 시작 -->
		           		    <div style="float:right;margin-bottom:1px;margin-top: 9px;border:0px solid red;">
		                		<a href="javascript:writeProject();"><img src="${imagePath}/btn/btn_newPrj.jpg" alt="새프로젝트"/></a>
		                		<a href="javascript:writeTask();"><img src="${imagePath}/btn/btn_newWork.gif" alt="새작업"/></a>
		               	    </div>
		                 	<!-- 버튼 끝 -->
						</div>

							
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col35" />
							<col class="col90" />
							<col width="px" />
							<col class="col55" />
							<col class="col55" />
							<col class="col55" />
							<col class="col70" />
							<col width="40px" />
							<col width="25px" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">프로젝트코드</th>
							<th scope="col">작업명</th>
							<th scope="col">등록자</th>
							<th scope="col">담당자</th>
							<th scope="col">완료일</th>
							<th scope="col">상태</th><!-- 	P작업중 C작업완료 -->
							<th scope="col" colspan="2">실적</th>
							</tr>
						</thead>
						<tbody>
						
						
						<c:forEach items="${resultList}" var="result" varStatus="c">											
							
						
						
						<c:choose>
							<c:when test="${searchVO.searchType == 'today'}">
							<tr
								<c:choose>
											<c:when test="${result.taskState == 'D'}">
											   style='background-color:#FFFFFF;'
											</c:when>
											<c:when test="${result.taskState == 'P' && searchVO.searchDate == result.taskDuedate}">
												style='background-color:#FFFFFF;'
											</c:when>
											<c:when test="${result.taskState == 'P' && searchVO.searchDate < result.taskDuedate}">												
												style='background-color:#F9F9F9;'
											</c:when>
											<c:when test="${result.taskState == 'C'}">
												style='background-color:#E7E7E7;'
											</c:when>										
											<c:otherwise>	
												style='background-color:#F9F9F9;'												
											</c:otherwise>
										</c:choose>							
								>
							</c:when>
							<c:otherwise>	
							<tr
								<c:choose>
										<c:when test="${result.taskState == 'C'}">
												style='background-color:#E7E7E7;'
											</c:when>										
											<c:otherwise>	
												style='background-color:#FFFFFF;'												
											</c:otherwise>
										</c:choose>							
								>										
							</c:otherwise>
						</c:choose>			
											
								
									<td class="txt_center">						
									 <c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/>
									</td>
									
									<td class="txt_center"
										id="prjId_${result.taskId}" onmouseover="javascript:showToolTip('ToolTipBox','prjId_${result.taskId}','${fn:replace(result.prjNm, crcn,br)}','up');" onmouseout="javascript:hideToolTip();"
									>
									<a href="${PathConfig.rootPath }/cooperation/selectProjectV.do?prjId=${result.prjId}" + " target="_blank">${result.prjCd}</a></td>
									
									<td class="pL10"
										id="taskId_${result.taskId}" onmouseover="javascript:showToolTip('ToolTipBox','taskId_${result.taskId}','${fn:replace(result.taskCn, crcn,br)}','up');" onmouseout="javascript:hideToolTip();"
									>
										<a href="javascript:viewTask('${result.taskId}');">
										<c:choose>
										<c:when test="${searchVO.searchType == 'today'}">																
											<c:choose>
												<c:when test="${result.taskState == 'D'}">
													<span class ="txtS_red">${result.taskSj}</span>
												</c:when>
												<c:when test="${result.taskState == 'P' && searchVO.searchDate == result.taskDuedate}">
													<span class ="txtS_blue">${result.taskSj}</span>
												</c:when>
												<c:when test="${result.taskState == 'P' && searchVO.searchDate < result.taskDuedate}">												
													<span class ="txtS_Black">${result.taskSj}</span>
												</c:when>
												<c:when test="${result.taskState == 'C'}">												
													<span class ="txtS_gray">${result.taskSj}</span>
												</c:when>
												<c:otherwise>	
													<span class ="txtS_Black">${result.taskSj}</span>												
												</c:otherwise>
											</c:choose>											
										</c:when>
										<c:otherwise>	
											<c:choose>
												<c:when test="${result.taskState == 'D'}">
													<span class ="txtS_red">${result.taskSj}</span>
												</c:when>
												<c:when test="${result.taskState == 'P'}">
													<span class ="txtS_blue">${result.taskSj}</span>
												</c:when>											
												<c:when test="${result.taskState == 'C'}">												
													<span class ="txtS_gray">${result.taskSj}</span>
												</c:when>
												<c:otherwise>	
													<span class ="txtS_blue">${result.taskSj}</span>												
												</c:otherwise>
											</c:choose>															
										</c:otherwise>
									</c:choose>				
									</a>
									</td>
									
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">
									<c:choose>														
										<c:when test="${user.no == result.writerNo || user.no == result.userNo || user.admin}">
										<a href="javascript:leaderModifyCall('${result.taskId}','${result.userNm}(${result.userId})');" id="leaderModifyPosition_${result.taskId}">
										</c:when>
										<c:otherwise>
										<a href="#">
										</c:otherwise>
									</c:choose>
									${result.userNm}</a></td>
									<td class="txt_center">
									
									<c:choose>														
										<c:when test="${user.no == result.writerNo || user.no == result.userNo || user.admin}">
										<a href="javascript:taskDuedateModifyCall('${result.taskId}','${result.taskDuedate}','${result.taskStartdate}');" id="taskDuedateModifyPosition_${result.taskId}" title="시작일: ${fn:substring(result.taskStartdate,4,6)}.${fn:substring(result.taskStartdate,6,8)}">
										</c:when>
										<c:otherwise>
										<a href="#" id="taskDuedateModifyPosition_${result.taskId}" title="시작일: ${fn:substring(result.taskStartdate,4,6)}.${fn:substring(result.taskStartdate,6,8)}">
										</c:otherwise>
									</c:choose>
									
									<c:choose>
									<c:when test="${searchVO.searchType == 'today'}">
									<c:choose>
											<c:when test="${result.taskState == 'D'}">
												<span class="">${fn:substring(result.taskDuedate,4,6)}.${fn:substring(result.taskDuedate,6,8)}</span>	
											</c:when>
					 						<c:when test="${result.taskState == 'P' && searchVO.today == result.taskDuedate}">
												<span class ="">${fn:substring(result.taskDuedate,4,6)}.${fn:substring(result.taskDuedate,6,8)}</span>
											</c:when>
											<c:when test="${result.taskState == 'P' && searchVO.today < result.taskDuedate}">												
												<span class="txtS_Black">${fn:substring(result.taskDuedate,4,6)}.${fn:substring(result.taskDuedate,6,8)}</span>
											</c:when>			
											<c:when test="${result.taskState == 'C'}">
												<span class="">${fn:substring(result.taskDuedate,4,6)}.${fn:substring(result.taskDuedate,6,8)}</span>	
											</c:when>
											<c:otherwise>
												<span class="txtS_Black">${fn:substring(result.taskDuedate,4,6)}.${fn:substring(result.taskDuedate,6,8)}</span>
											</c:otherwise>									
									</c:choose> 
									</c:when>
									<c:otherwise>	
									<c:choose>
											<c:when test="${result.taskState == 'D'}">
												<span class="">${fn:substring(result.taskDuedate,4,6)}.${fn:substring(result.taskDuedate,6,8)}</span>	
											</c:when>
					 						<c:when test="${result.taskState == 'P'}">
												<span class ="">${fn:substring(result.taskDuedate,4,6)}.${fn:substring(result.taskDuedate,6,8)}</span>
											</c:when>			
											<c:when test="${result.taskState == 'C'}">
												<span class="">${fn:substring(result.taskDuedate,4,6)}.${fn:substring(result.taskDuedate,6,8)}</span>	
											</c:when>
											<c:otherwise>
												<span class ="">${fn:substring(result.taskDuedate,4,6)}.${fn:substring(result.taskDuedate,6,8)}</span>
											</c:otherwise>									
									</c:choose> 														
									</c:otherwise>
									</c:choose>													
									</a></td>
									<td class="txt_center">
									
									<c:choose>														
										<c:when test="${user.no == result.writerNo || user.no == result.userNo || user.admin}">
										<a href="javascript:endDtModifyCall('${result.taskId}','${result.taskState}','${result.dayReportTm}','${result.dayReportCnt}');" id="endDtModifyPosition_${result.taskId}"> 
										</c:when>
										<c:otherwise>
										<a href="#" id="endDtModifyPosition_${result.taskId}"> 
										</c:otherwise>
									</c:choose>									
										
										<!--완료-C 미완료-IC 지연-D  -->
					                    <c:choose>
										<c:when test="${searchVO.searchType == 'today'}">
					                    <c:choose>
											<c:when test="${result.taskState == 'D'}">
												<span class="txtS_red">지연</span>	
											</c:when>
					 						<c:when test="${result.taskState == 'P' && searchVO.today == result.taskDuedate}">
												<span class ="txtS_blue">미완료</span>
											</c:when>
											<c:when test="${result.taskState == 'P' && searchVO.today < result.taskDuedate}">												
												<span class="txtS_Black">미완료</span>
											</c:when>			
											<c:when test="${result.taskState == 'C'}">
												<span class="txtS_gray">완료(${fn:substring(result.taskEnddate,4,6)}.${fn:substring(result.taskEnddate,6,8)})</span>	
											</c:when>
											<c:otherwise>
												<span class="txtS_Black">미완료</span>
											</c:otherwise>
										</c:choose>
										</c:when>
										<c:otherwise>	
					                    <c:choose>
											<c:when test="${result.taskState == 'D'}">
												<span class="txtS_red">지연</span>	
											</c:when>
					 						<c:when test="${result.taskState == 'P'}">
												<span class ="txtS_blue">미완료</span>
											</c:when>			
											<c:when test="${result.taskState == 'C'}">
												<span class="txtS_gray">완료(${fn:substring(result.taskEnddate,4,6)}.${fn:substring(result.taskEnddate,6,8)})</span>	
											</c:when>
											<c:otherwise>
												<span class ="txtS_blue">미완료</span>
											</c:otherwise>
										</c:choose>														
										</c:otherwise>
									    </c:choose> 								
									</a>
									</td>
							
									<td class="txt_center" <c:if test="${result.dayReportTodayCnt > 0}"> onmouseover="showDRLayer('${result.taskId}','${searchVO.today}','${searchVO.today}',this)" onmouseout="hideDRLayer()"</c:if>
									<c:if test="${result.dayReportTodayCnt == 0}">								
									id="dayReportToday_${result.taskId}" onmouseover="javascript:showToolTip('ToolTipBox','dayReportToday_${result.taskId}','오늘 등록한 실적이 없습니다.','down');" onmouseout="javascript:hideToolTip();"
									</c:if>
									>								
											<!-- 
											<a href="javascript:writeDayReport('${result.taskId}');">
											 -->
											<a href="javascript:showDRPop('','${result.userNo}','${result.taskId}');">
											
											<!-- 
											<c:choose>
											<c:when test="${result.dayReportTm == '0' && result.dayReportCnt == '0'}">
											<a href="javascript:writeDayReport('${result.taskId}');">
											</c:when>										
											<c:otherwise>																			
											<a href="javascript:showDRPop('','${result.userNo}','${result.taskId}');">						
											</c:otherwise>
 											</c:choose>
 											-->											
										 
										<c:choose>
										<c:when test="${searchVO.searchType == 'today'}">
										<c:choose>														
											<c:when test="${result.taskState == 'D'}">
												<span class="txtS_red">${result.dayReportTodayTm}/${result.dayReportTm}</span>	
											</c:when>
					 						<c:when test="${result.taskState == 'P' && searchVO.today == result.taskDuedate}">
												<span class="txtS_blue">${result.dayReportTodayTm}/${result.dayReportTm}</span>
											</c:when>
											<c:when test="${result.taskState == 'P' && searchVO.today < result.taskDuedate}">												
												 <span class="txtS_Black">${result.dayReportTodayTm}/${result.dayReportTm}</span>
											</c:when>			
											<c:when test="${result.taskState == 'C'}">
												<span class="">${result.dayReportTodayTm}/${result.dayReportTm}</span>													
											</c:when>										
											<c:otherwise>
												 <span class="txtS_Black">${result.dayReportTodayTm}/${result.dayReportTm}</span>
											</c:otherwise>
										</c:choose>
										</c:when>
										<c:otherwise>	
										<c:choose>														
											<c:when test="${result.taskState == 'D'}">
												<span class="txtS_red">${result.dayReportTodayTm}/${result.dayReportTm}</span>	
											</c:when>
					 						<c:when test="${result.taskState == 'P'}">
												<span class="txtS_blue">${result.dayReportTodayTm}/${result.dayReportTm}</span>
											</c:when>			
											<c:when test="${result.taskState == 'C'}">
												<span class="">${result.dayReportTodayTm}/${result.dayReportTm}</span>													
											</c:when>										
											<c:otherwise>
												<span class="txtS_blue">${result.dayReportTodayTm}/${result.dayReportTm}</span>
											</c:otherwise>
										</c:choose>														
										</c:otherwise>
										</c:choose>	 
										</a>
									</td>
									<td>
										<a 
										id="pencilImg_${result.taskId}" onmouseover="javascript:showToolTip('ToolTipBox','pencilImg_${result.taskId}','실적등록','down');" onmouseout="javascript:hideToolTip();"
										href="javascript:writeDayReport('${result.taskId}');"><img src="${imagePath}/btn/btn_write01.gif"/></a>
									</td>
								</tr>							
						
							</c:forEach>
							
						</tbody>
						</table>
					</div>
					
					<!-- 페이징 시작 
					<div class="paginate">
	                	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					페이징 끝 -->
					
					<!-- 버튼 시작 
           		    <div class="btn_area">
                		<a href="javascript:insertMission();"><img src="${imagePath}/btn/btn_mission.gif" alt="새작업"/></a>
               	    </div>
                 	 버튼 끝 -->
                 	 
                 	 
                 	
					
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

<!-- 레이어 수정 화면 시작 -->
<form name="layerFrm" method="POST">
<input type="hidden" name="taskId" value=""/>
<input type="hidden" name="taskState" id="taskState">
<input type="hidden" name="userId" value=""/>
<input type="hidden" name="userNo" value="${user.userNo}"/>
<input type="hidden" name="param_returnUrl" value="/cooperation/selectDayReportMyList.do"/>

<input type="hidden" name="includeEnd" value=""/>
              

		              
		
           	<div class="simpleMsg_layer ms_layer" id="leaderModify" >
           		<div class="ms_layer_con">
           			<ul>
           				<li class="m_tt mB15">담당자</li>
           				<li>
                 		<input type="text" class="userNameAuto userValidateCheckAuth" name="leaderMixes" id="leaderMixes" value="" />
                 		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('leaderMixes',1);"/>
           				</li>
           				<li class="txt_right mT20">
                  	    <input type="button" value="변경" class="btn_gray" onclick="javascript:leaderModify();"/>
                  		<input type="button" value="취소" class="btn_gray" onclick="javascript:hideLayerName('leaderModify');"/>
           				</li>
           			</ul>
           		</div>	
</div>	
<div class="simpleMsg_layer ms_layer" id="taskDuedateModify" >
	<div class="ms_layer_con">
           			<ul>
           				<li class="m_tt mB15">시&nbsp;&nbsp;작&nbsp;&nbsp;일&nbsp;&nbsp;: <input type="text" name="taskStartdate" id="taskStartdate" class="span_7 calGen" value=""/></li>
           				<li class="m_tt mB15">완료예정일 : <input type="text" name="taskDuedate" id="taskDuedate" class="span_7 calGen" value=""/></li>
           				<li class="txt_right mT20">
                 		<input type="button" value="변경" class="btn_gray" onclick="javascript:taskDuedateModify();"/>
                 		<input type="button" value="취소" class="btn_gray" onclick="javascript:hideLayerName('taskDuedateModify');"/>
           				</li>
           			</ul>
           		</div>	
</div>	
<div class="simpleMsg_layer ms_layer" id="endDtModify" style="width:240px;" >
	<ul>
		<li>
			<div id="PText" class="ms_layer_con"> 
				<ul>
					<li class="m_tt txtB_Black mB15">작업완료</li>
					<li>수고하셨습니다.</li>
				</ul>
			</div>
		</li>
		<li>
			<div id="CText" class="ms_layer_con">	
				<ul>
					<li class="m_tt txtB_red mB15">작업 미완료</li>
					<li>완료된 작업을 미완료 상태로 변경합니다.</li>
				</ul>
			</div>
		</li>
		<li class="txt_right mT20">
			<input type="button" value="완료" class="btn_gray" onclick="javascript:endDtModify();"/>
			<input type="button" value="취소" class="btn_gray" onclick="javascript:hideLayerName('endDtModify');"/>
		</li>
	</ul>	
</div>						
</form>	                
 <!-- 레이어 수정 화면 끝 -->
 
<div class="simpleMsg_layer" id="ToolTipBox">내용입력</div>

 <!-- 실적 레이어  -->
<div class="project_layer" id="dRLayer" style="display:none; z-index:5">

	<dl>
		<dt>[프로젝트코드] 프로젝트명 <p>작업제목입니다.</p></dt>
		<dd>
			<ul>
				<li>2011.08.09 (2시간)</li>
				<li class="Rcon">실적 입력 내용 </li>
			</ul>
			<ul>
				<li>2011.08.09 (2시간)</li>
				<li class="Rcon">실적 입력 내용 </li>
			</ul>
		</dd>
	</dl>
</div>
<!--// 실적 레이어  끝  -->

<form name="newPrjFrm" method="GET" action="${rootPath}/cooperation/writeProject.do" target="_blank">
<!-- <input type="hidden" name="prntPrjId" value=""/> -->
<input type="hidden" name="type" value="S">
</form>
					 				
</body>
</html>
