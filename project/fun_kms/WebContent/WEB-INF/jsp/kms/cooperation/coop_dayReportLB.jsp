<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(dateMove) {
	document.frm.taskId.value = "";
	document.frm.taskState.value = "";
	document.frm.dateMove.value = dateMove;
	document.frm.action = "${rootPath}/cooperation/selectDayReport.do";
	document.frm.submit();
}
function updateState(taskId, taskState) {
	document.frm.taskId.value = taskId;
	document.frm.taskState.value = taskState;
	document.frm.action = "${rootPath}/cooperation/updateTaskState.do";
	document.frm.submit();
}
function viewTask(taskId) {
	document.frm.taskId.value = taskId;
	document.frm.action = "${rootPath}/cooperation/selectTaskInfo.do";
	document.frm.submit();
}

function showDetail(obj) {
	var dtl = obj.parentNode.parentNode.previousSibling;
	dtl.style.display = "";
	obj.src="${imagePath}/btn/btn_off.gif";
	obj.onclick = new Function("hideDetail(this)");
}
function hideDetail(obj) {
	var dtl = obj.parentNode.parentNode.previousSibling;
	dtl.style.display = "none";
	obj.src="${imagePath}/btn/btn_on.gif";
	obj.onclick = new Function("showDetail(this)");
}
function showDetailAll() {
	var btn = document.getElementsByName("dayReportBtn");

	for (var i=0; i<btn.length; i++) {
		showDetail(btn[i]);
	}
}
function hideDetailAll() {
	var btn = document.getElementsByName("dayReportBtn");

	for (var i=0; i<btn.length; i++) {
		hideDetail(btn[i]);
	}
}
function mover(obj, bool) {
	if (bool == 1) {
		obj.className = "Mover";
		obj.childNodes[0].childNodes[2].childNodes[1].style.display = "";
	}
	else if (bool == 0) {
		obj.className = "";
		obj.childNodes[0].childNodes[2].childNodes[1].style.display = "none";
	}
}
function writeTask(date) {
	var popup = window.open("${rootPath}/cooperation/insertTaskView.do?no=${searchVO.searchUserNo}&date=" + date,"_TASK_POP_","width=570px,height=450px,scrollbars=yes,resizable=yes");
	popup.focus();
}
function writeDayReport(taskId,userNo,searchDate) {
	var popup = window.open("${rootPath}/cooperation/insertDayReportView.do?taskId=" + taskId + "&userNo=" + userNo + "&searchDate=" + searchDate,"_DAY_REPORT_POP_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
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
				document.getElementById("dRLayer").style.top = position.top + (height/2) - h + "px";

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
	if(typ == 'MY'){
		document.frm.action = "${rootPath}/cooperation/selectDayReportMyList.do";
		document.frm.submit();
		}else{
		$.post("/member/updateUiSetting.do?dayReportTyp=" + typ, function(data) {
			if (data == '\r\nsuccess') {
				location.reload();
			}
		});
	}	
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
						<li class="stitle">나의업무 요약보기</li>
						<li class="navi">홈 > 업무공유  > 업무계획/실적  > 나의업무 요약보기</li>
					</ul>
				</div>
				
				<span class="stxt">개인별 업무계획 및 실적을 관리하는 곳입니다. 실적을 등록/수정하시려면 시간을 클릭해주세요.</span>
				<span class="stxt_btn">
					<a href="javascript:dayReportTyp('MY');"><img src="${imagePath}/btn/btn_myview.gif"/></a>
					<a href="javascript:dayReportTyp('D');"><img src="${imagePath}/btn/btn_detailview.gif"/></a>
				</span>
				
				<!-- S: section -->
				<div class="section01">
				
			    <!-- 상단 검색창 시작 -->
			    <form name="frm" id="searchFrm" method="GET" onsubmit="search(0); return false;">
			    	<input type="hidden" name="taskId" value=""/>
			    	<input type="hidden" name="taskState" value=""/>
			    	<input type="hidden" name="dateMove" value="0"/>
			    	<input type="hidden" name="param_returnUrl" value="/cooperation/selectDayReport.do"/>
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
	                		<li class="li_left">
	                			<a href="javascript:search(-7);"><img src="${imagePath}/btn/btn_first.gif"/></a>
	               	 			<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif"></a>
	                			<!-- <span class="option_txt">2011년 8월 4일</span> -->
	                			<input type="text" name="searchDate" value="${searchVO.searchDate}" class="calGen" maxlength="8" style="width:55px;"/>
								<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif"></a>
	                			<a href="javascript:search(7);"><img src="${imagePath}/btn/btn_end.gif"></a>
	                		</li>
	                		<li class="li_right">
	                			<span class="option_txt">사용자</span><span class="pL7"></span>
								<!-- 
								<input type="text" name="searchUserNm" id="searchUserNm" class="search_txt02 userNameAuto userValidateCheckAuth" value="${searchVO.searchUserNm}"/>
								<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm',1);"/>
								 -->
								<input type="text" class="search_txt02 userNameAuto userValidateCheckAuth" name="searchUserNm" id="searchUserNm" value="${searchVO.searchUserNm}"/>
	                    		<!-- <img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm',1);" /> -->
	                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm', 1, null, null, '1');" />
	                    		    
								<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색"/>
	                		</li>
	                		</ul>
						</div>
	                </fieldset>
	            </form>
	            <!-- 상단 검색창 끝 -->
	            
	            <!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>프로젝트 현황</caption>
	                    <colgroup>
	                    	<col class="col50" />
	                    	<col width="px"/>
	                    	<col class="col40" />
	                   	 	<col class="col40" />
                    		<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    </colgroup>
	                    <thead>
	                    	<tr>
	                    		<th colspan="2">작업목록</th>
	                    		<th class="td_last" colspan="8">주간업무실적(시간)</th>
	                    	</tr>
	                    	<tr>
	                    		<th colspan="2">
	                    			<a href="javascript:showDetailAll();"><img src="${imagePath}/btn/btn_view.gif"/></a>
	                    			<a href="javascript:hideDetailAll();"><img src="${imagePath}/btn/btn_view02.gif"/></a>
	                    			<a href="javascript:writeTask('');"><img src="${imagePath}/btn/btn_new.gif"/></a>
	                    		</th>
	                    		<c:forEach items="${dateList}" var="date">
		                    		<th <c:if test="${date.date == searchVO.searchDate}">class="txtB_blue2"</c:if>>${fn:substring(date.date,4,6)}/${fn:substring(date.date,6,8)}<br/>(${date.day})</th>
	                    		</c:forEach>
	                    		
	                    		<th class="td_last">합계</th>
	                    	</tr>
	                    </thead>
	                    <tfoot>
                    		<c:set var="workTimeSum" value="0"/>
                    		<c:set var="leftTimeSum" value="0"/>
	                    	<tr>
	                    		<td class="txt_center" colspan="2">합계</td>
	                    		<c:forEach items="${workTime}" var="tm">
		                    		<td class="txt_center">${tm}</td>
                    				<c:set var="workTimeSum" value="${workTimeSum + tm}"/>
	                    		</c:forEach>
	                    		<td class="txt_center td_last">${workTimeSum}</td>
	                    	</tr>
	                    <%--
	                    	<tr>
	                    		<td class="txt_right pR10" colspan="2">미투입 시간</td>
	                    		<c:forEach items="${leftTime}" var="tm">
		                    		<td class="txt_center">${tm}</td>
                    				<c:set var="leftTimeSum" value="${leftTimeSum + tm}"/>
	                    		</c:forEach>
	                    		<td class="txt_center td_last">${leftTimeSum}</td>
	                    	</tr>
	                    --%>
	                    </tfoot>
	                    <!-- 미완료 작업  -->
	                    <tbody>
	                    	<!-- 지연된 작업  -->
	                    	<c:set value="${fn:length(processList)}" var="prlen"/>
	                    	<c:forEach items="${processList}" var="pr" varStatus="c">
	                    		<tr>
	                    			<c:if test="${c.count == 1}">
		                    			<td class="txt_center" rowspan="${prlen}">미완료<br/>작업</td>
	                    			</c:if>
	                    			<td onmouseover="mover(this, 1);" onmouseout="mover(this, 0);"
	                    				><ul
	                    					><li><p class="txtB_Black"><print:project prjCd="${pr.task.prjCd}" prjId="${pr.task.prjId}" prjNm="${pr.task.prjNm}"/></p></li
			                    			><li>
			                    				<a href="javascript:viewTask('${pr.task.taskId}');">
				                    				<c:choose>
				                    					<c:when test="${pr.task.taskDuedate < searchVO.today && pr.task.taskDuedate != ''}">
						                    				<span class="txtB_red">${pr.task.taskSjPrint}</span>
				                    					</c:when>
				                    					<c:when test="${pr.task.taskDuedate == searchVO.today}">
						                    				<span class="txtB_blue2">${pr.task.taskSjPrint}</span>
				                    					</c:when>
				                    					<c:otherwise>
						                    				<span class="txtB_Black">${pr.task.taskSjPrint}</span>
				                    					</c:otherwise>
				                    				</c:choose>
			                    				</a>
			                    			</li
			                    			><li
			                    				><span
			                    					<c:choose>
				                    					<c:when test="${pr.task.taskDuedate < searchVO.today && pr.task.taskDuedate != ''}">class="txt_red2"</c:when>
				                    					<c:when test="${pr.task.taskDuedate == searchVO.today}">class="txt_blue3"</c:when>
				                    					<c:otherwise>class="T11"</c:otherwise>
				                    				</c:choose>
			                    				>기간 : ${pr.task.taskStartdatePrint} ${pr.task.taskStarttimePrint} ~ ${pr.task.taskDuedatePrint} ${pr.task.taskDuetimePrint}
			                    				</span
			                    				><span class="btn_area06" style="display:none;">
			                    					<c:if test="${user.admin || user.no == pr.task.userNo}">
			                    					<a href="javascript:writeDayReport('${pr.task.taskId}','${searchVO.searchUserNo}','${searchVO.searchDate}');"><img src="${imagePath}/btn/btn_result02.gif"/></a>
			                    					<a href="javascript:updateState('${pr.task.taskId}', 'C');"><img src="${imagePath}/btn/btn_complete02.gif"/></a>
			                    					</c:if>
		                    					</span>
		                    				</li>
		                    			</ul>
		                    			<ul>
		                    				<li>${pr.task.taskCnPrint}</li>
			                    			<c:forEach items="${pr.taskContentList}" var="tc">
				                    			<li class="detailTxt"><a href="${tc.linkUrl}" target="_TCNT_BLANK_">[${tc.taskCntTypPrint}] ${tc.taskCntSj}</a></li>
			                    			</c:forEach>
			                    		</ul
			                    		><ul><li><img src="${imagePath}/btn/btn_off.gif" onclick="hideDetail(this);" style="cursor:pointer;" name="dayReportBtn"/></li></ul>
			                    	</td>
			                    	<c:forEach items="${pr.dayReportDateList}" var="view">
			                    		<c:choose>
				                    		<c:when test="${view.date == searchVO.searchDate}">
						                    	<td class="Dover cursorPointer"
						                    		<c:if test="${view.count != 0}">onmouseover="showDRLayer('${pr.task.taskId}','${view.date}','${view.date}',this)" onmouseout="hideDRLayer()" onclick="showDRPop('${view.date}','${searchVO.searchUserNo}','${pr.task.taskId}')"</c:if>
						                    		<c:if test="${view.count == 0}">onclick="writeDayReport('${pr.task.taskId}','${searchVO.searchUserNo}','${view.date}');"</c:if>
						                    	>${view.sum}</td>
				                    		</c:when>
				                    		<c:otherwise>
						                    	<td class="txt_center cursorPointer"
						                    		<c:if test="${view.count != 0}">onmouseover="showDRLayer('${pr.task.taskId}','${view.date}','${view.date}',this)" onmouseout="hideDRLayer()" onclick="showDRPop('${view.date}','${searchVO.searchUserNo}','${pr.task.taskId}')"</c:if>
						                    		<c:if test="${view.count == 0}">onclick="writeDayReport('${pr.task.taskId}','${searchVO.searchUserNo}','${view.date}');"</c:if>
						                    	>${view.sum}</td>
				                    		</c:otherwise>
			                    		</c:choose>
			                    	</c:forEach>
			                    	<td class="td_last txt_center"<c:if test="${pr.sum != 0}">onmouseover="showDRLayer('${pr.task.taskId}','${dateList[0].date}','${dateList[6].date}',this)" onmouseout="hideDRLayer()"</c:if>>${pr.sum}</td>
	                    		</tr>
	                    	</c:forEach>
	                    	<c:set value="${fn:length(endList)}" var="endlen"/>
	                    	<c:forEach items="${endList}" var="end" varStatus="c">
	                    		<tr>
	                    			<c:if test="${c.count == 1}">
	                    				<td class="txt_center" rowspan="${endlen}">완료된<br/>작업</td>
	                    			</c:if>
	                    			<td onmouseover="mover(this, 1);" onmouseout="mover(this, 0);"
	                    				><ul
	                    					><li><p class="txtB_Black"><print:project prjCd="${end.task.prjCd}" prjId="${end.task.prjId}" prjNm="${end.task.prjNm}"/></p></li
			                    			><li>
			                    				<a href="javascript:viewTask('${end.task.taskId}');">${end.task.taskSjPrint}</a>
			                    			</li
			                    			><li
			                    				><span class="T11">완료일 : ${end.task.taskEnddatePrint}</span
			                    				><span class="btn_area06" style="display:none;">
			                    					<c:if test="${end.task.userNo == user.no || user.admin}">
			                    					<a href="javascript:writeDayReport('${end.task.taskId}','${searchVO.searchUserNo}','${searchVO.searchDate}');"><img src="${imagePath}/btn/btn_result02.gif"/></a>
			                    					<a href="javascript:updateState('${end.task.taskId}', 'P');"><img src="${imagePath}/btn/btn_uncomplete.gif"/></a>
			                    					</c:if>
		                    					</span>
		                    				</li>
			                    		</ul>
	                    				<!-- 자세히S -->
		                    			<ul style="display:none;">
			                    			<li>${end.task.taskCnPrint}</li>
			                    			<c:forEach items="${end.taskContentList}" var="tc">
				                    			<li class="detailTxt">[${tc.taskCntTypPrint}] ${tc.taskCntSj}</li>
			                    			</c:forEach>
			                    		</ul
			                    		><ul><li><img src="${imagePath}/btn/btn_on.gif" onclick="showDetail(this);" style="cursor:pointer;" name="dayReportBtn"/></li></ul>
			                    	</td>
			                    	<c:forEach items="${end.dayReportDateList}" var="view">
			                    		<c:choose>
				                    		<c:when test="${view.date == searchVO.searchDate}">
						                    	<td class="Dover cursorPointer"
						                    		<c:if test="${view.count != 0}">onmouseover="showDRLayer('${end.task.taskId}','${view.date}','${view.date}',this)" onmouseout="hideDRLayer()" onclick="showDRPop('${view.date}','${searchVO.searchUserNo}','${end.task.taskId}')"</c:if>
						                    		<c:if test="${view.count == 0}">onclick="writeDayReport('${end.task.taskId}','${searchVO.searchUserNo}','${view.date}');"</c:if>
						                    	>${view.sum}</td>
				                    		</c:when>
				                    		<c:otherwise>
						                    	<td class="txt_center cursorPointer"
						                    		<c:if test="${view.count != 0}">onmouseover="showDRLayer('${end.task.taskId}','${view.date}','${view.date}',this)" onmouseout="hideDRLayer()" onclick="showDRPop('${view.date}','${searchVO.searchUserNo}','${end.task.taskId}')"</c:if>
						                    		<c:if test="${view.count == 0}">onclick="writeDayReport('${end.task.taskId}','${searchVO.searchUserNo}','${view.date}');"</c:if>
						                    	>${view.sum}</td>
				                    		</c:otherwise>
			                    		</c:choose>
			                    	</c:forEach>
			                    	<td class="td_last txt_center"<c:if test="${end.sum != 0}">onmouseover="showDRLayer('${end.task.taskId}','${dateList[0].date}','${dateList[6].date}',this)" onmouseout="hideDRLayer()"</c:if>>${end.sum}</td>
	                    		</tr>
	                    	</c:forEach>
	                    	<!-- 완료된 작업  -->
	                    </tbody>
	                    </table>
					</div>
					<%--
					<span class="T11 th_txt2 pR20 mB20">* 투입하지 않은 시간에 대한 비용은 소속부서의 공통비용으로 처리됩니다.</span>
					--%>
					<!--// 게시판  끝  -->
					
					<div class="boardList02 mT20">
						<c:import url="${rootPath}/cooperation/postTaskList.do">
							<c:param name="param_eDate" value="${dateList[6].date}" />
							<c:param name="param_userNo" value="${searchVO.searchUserNo}" />
						</c:import>
					</div>
					
					
					
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
<div id="searchLayer" class="search_layer Bdsearch_layer" style="display:none;"></div>
</body>
</html>
