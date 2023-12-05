<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageIndex) {

	var error = checkValidUserMixsAuth(document.frm.searchUserNm.value);
	if(error["errorCode"] == 2 || error["errorCode"] == 3 || error["errorCode"] == 4) {
		return;
	}
	
	document.frm.pageIndex.value = pageIndex;
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
	
	initSearchDt();	// 날짜 초기화
});

function setLeader(leader) {
	document.frm.searchUserNm.value = leader+",";
	search('1');
}


function updateDayReport(taskId, no) {
	var popup = window.open("${rootPath}/cooperation/updateDayReportView.do?taskId=" + taskId + "&no=" + no,"_DAY_REPORT_POP_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}
function deleteDayReport(taskId, no) {
	if (confirm("삭제하시겠습니까?")) {
		document.frm.taskId.value = taskId;
		document.frm.no.value = no;
		document.frm.action = "${rootPath}/cooperation/deleteDayReportPop.do";
		document.frm.submit();
	}
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
	if(document.layerFrm.leaderMixes.value == ""){
		alert('담당자를 입력하십시오.');
	}else{
		document.layerFrm.action = "${rootPath}/cooperation/updateTaskState.do";
		document.layerFrm.submit();		
	}

}

function writeTask() {
	var popup = window.open("${rootPath}/cooperation/insertTaskView.do?no=${searchVO.searchUserNo}&date=","_TASK_POP_","width=570px,height=450px,scrollbars=yes,resizable=yes");
	popup.focus();
}

var searchSdate;
var searchEdate;
var today = new Date();
var weekCnt= 0;
var monthCnt= 0;
function initSearchDt() {
	var tmpDateS = '${searchVO.searchSdate}';
	var tmpDateE= '${searchVO.searchEdate}';
	
	searchSdate = new Date(tmpDateS.substring(0,4), tmpDateS.substring(4,6) - 1, tmpDateS.substring(6,8));
	searchEdate = new Date(tmpDateE.substring(0,4), tmpDateE.substring(4,6) - 1, tmpDateE.substring(6,8));
}

//조회기간 변경(Option> day, week)
function setSearchDt(workType) {
	switch (workType) {
		case 'day':
			searchSdate = new Date();
			searchEdate = new Date();
			break;
		case 'week':
			searchSdate = new Date();
			searchEdate = new Date();
			var dayOfWeek = searchSdate.getDay();
			searchSdate.setDate(searchSdate.getDate() - dayOfWeek + 1);
			searchEdate.setDate(searchEdate.getDate() - dayOfWeek + 5);
			break;
	}
	document.getElementById('searchSdate').value = "" + searchSdate.format("yyyyMMdd");
	document.getElementById('searchEdate').value = "" + searchEdate.format("yyyyMMdd");
}

//조회기간 변경 좌,우 버튼
function chgSearchDt(workType, direction) {
	switch (workType) {
		case 'day':
			if (direction=="pre") {
				searchSdate.setDate(searchSdate.getDate() - 1);
				searchEdate.setDate(searchEdate.getDate() - 1);
			} else {
				searchSdate.setDate(searchSdate.getDate() + 1);
				searchEdate.setDate(searchEdate.getDate() + 1);
			}
			break;
		case 'week':
			if (direction=="pre") {
				searchSdate.setDate(searchSdate.getDate() - 7);
				searchEdate.setDate(searchEdate.getDate() - 7);
			} else {
				searchSdate.setDate(searchSdate.getDate() + 7);
				searchEdate.setDate(searchEdate.getDate() + 7);
			}
	}
	document.getElementById('searchSdate').value = "" + searchSdate.format("yyyyMMdd");
	document.getElementById('searchEdate').value = "" + searchEdate.format("yyyyMMdd");
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
							<li class="stitle">업무실적 조회</li>
							<li class="navi">홈 > 업무공유 > 업무계획/실적 > 업무실적 조회</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
				<!-- 상단 검색창 시작 -->
			   <form name="frm" method="GET" onsubmit="search(1); return false;" action="${rootPath}/cooperation/selectDayReportMyDList.do">
					<input type="hidden" name="pageIndex" value="1"/>			
					<input type="hidden" name="searchPrjId" id="prjId" value="${searchVO.searchPrjId}"/>
			    	<input type="hidden" name="param_returnUrl" value="/cooperation/selectDayReportMyDList.do"/>
			    	
					<input type="hidden" name="taskId" value=""/>			
			    	<input type="hidden" name="no" value=""/>

		
	                <fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<colgroup>
							<col class="col80" />
							<col class="col280"/>
							<col class="col50" />
							<col class="col170"/>
							<col class="col60"/>
							<col width="px" />
						</colgroup>
						<tbody>
							<tr class="pT5">
								<td class="txt_center">
	                   				실적 등록일
	                   			</td>
	                   			<td colspan="4">
	                   				<input type="text" name="searchSdate" id="searchSdate" class="span_5 calGen" value="${searchVO.searchSdate}"/> ~
	                   				<input type="text" name="searchEdate" id="searchEdate" class="span_5 calGen" value="${searchVO.searchEdate}"/>
	                   				<input type="button" value="<1" class="btn_gray" onclick="chgSearchDt('day', 'pre');"/>
									<input type="button" value="오늘" class="btn_gray" onclick="setSearchDt('day');"/>
									<input type="button" value="1>" class="btn_gray" onclick="chgSearchDt('day', 'next');"/>
									<span class="pL7"></span>
									<input type="button" value="<7" class="btn_gray" onclick="chgSearchDt('week', 'pre');"/>
									<input type="button" value="이번주" class="btn_gray" onclick="setSearchDt('week');"/>
									<input type="button" value="7>" class="btn_gray" onclick="chgSearchDt('week', 'next');"/>
					            </td>
								<td class="val_Top search_right">
							    	<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(1); return false;"/>                    		
			                    </td>
				            </tr>
				            <tr class="pT5">
				            	<td class="txt_center">담당자</td>
			                    <td>
			                    	<input type="text" style="width:240px;" class="userNamesAuto userValidateCheckAuth" name="searchUserNm" id="searchUserNm"value="${searchVO.searchUserNm}"/>
			                   		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm',0, null, null, '1')"/>
			                    </td>
				            	<td class="txt_center">작업명</td>
				            	<td><input type="text" name="searchText" class="write_input09" value="${searchVO.searchText}"></td>
				            	<td class="txt_center">프로젝트</td>
				            	<td>
				            		<input type="text" name="searchPrjNm" id="prjNm" class="search_txt02" value="${searchVO.searchPrjNm}" readonly="readonly" onfocus="prjGen('prjNm','prjId',1);"/>
					                <img src="${imagePath}/btn/btn_tree.gif" id="tree" onclick="prjGen('prjNm','prjId',1);" class="cursorPointer"/>
				            	</td>
				            </tr>
		                    <tr>
								<td class="pT5 search_left" colspan="6" style="text-align: left;">	
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
		                    <tr>
		                    </tr>						
						</tbody>
						</table>
	                    </div>
	                </fieldset>

	            </form>
	            <!--// 상단 검색창 끝 -->
	            			
					<div class="boardList02 mB5">
						<div class="tab_typeA">
						 <!-- 버튼 시작 -->
		           		    <div style="float:left;margin-bottom:1px;margin-top: 9px;border:0px solid red;">
		                		총 ${paginationInfo.totalRecordCount}건
		               	    </div>
		           		    <div style="float:right;margin-bottom:1px;margin-top: 9px;border:0px solid red;">
		                		<a href="javascript:writeTask();"><img src="${imagePath}/btn/btn_newWork.gif" alt="새작업"/></a>
		               	    </div>
		                 	<!-- 버튼 끝 -->
						</div>
						
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<!--  <col class="col150" />-->							
							<col width="px" />
							<col width="px" />
							<col class="col50" />
							<col class="col50" />
							<!-- <col class="col70" /> -->
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<!-- <th scope="col">프로젝트코드</th>	 -->						
							<th scope="col">계획</th>
							<th scope="col">실적</th>
							<th scope="col">등록자</th>
							<th scope="col">담당자</th>
						<!-- 	<th scope="col">실적등록일</th> -->
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="task" varStatus="c">
						
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
								<!-- 
									<td class="txt_center" title="${task.prjNm}"><a href="${PathConfig.rootPath }/cooperation/selectProjectV.do?prjId=${task.prjId}" + " target="_blank">${task.prjCd}</a></td>
								 -->
									<td class="pL10">		
										<p class="txtB_Black"><print:project prjId="${task.prjId}" prjCd="${task.prjCd}" prjNm="${task.prjNm}"/></p>
										<c:choose>
		               					<c:when test="${task.taskDuedate < searchVo.date && task.taskDuedate != '' && task.taskState == 'P'}">
				                    		<p><a href="javascript:viewTask('${task.taskId}');"><span class="txtB_red">${task.taskSjPrint}</span></a></p>
				                    		<p class="txt_red">기간 : ${task.taskStartdatePrint} ${task.taskStarttimePrint} ~ ${task.taskDuedatePrint} ${task.taskDuetimePrint} (예정일경과)</p>
			                    		</c:when>
			                    		<c:otherwise>
				                    		<p><a href="javascript:viewTask('${task.taskId}');"><span class="txtB_blue2">${task.taskSjPrint}</span></a></p>
				                    		<!-- <p class="txt_blue3">기간 : ${task.taskStartdatePrint} ~ ${task.taskDuedatePrint} ${task.taskDuetimePrint}</p> -->
				                    	</c:otherwise>
				                   	</c:choose>
										<p><c:out value="${task.taskCnPrint}" escapeXml="false"/></p>
									</td>
									<td class="verTop p5">		           
	                    			<c:forEach items="${task.dayReportList}" var="dayReport">
		                    		<ul class="BusiAchievements">		                    			
		                    			<li class="Acon">${dayReport.dayReportCnPrint}<br/>
		                    				<c:if test="${!empty dayReport.attachFileId}">
												<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${dayReport.attachFileId}" />
												</c:import>
											</c:if>
		                    			</li>
		                    			<li class="ATime">
		                    				<ul>
		                    					<li>${dayReport.dayReportDt}</li>
		                    					<li>[<span class="txt_blue">${dayReport.dayReportTm}시간</span>]</li>
		                    					<li>
		                    						<a href="javascript:updateDayReport('${task.taskId}','${dayReport.no}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
                    								<a href="javascript:deleteDayReport('${task.taskId}','${dayReport.no}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
		                    					</li>
		                    				</ul>
		                    			</li>
		                    		</ul>
	                    			</c:forEach>
		                    		</td>
		                    	
									<td class="txt_center">${task.writerNm}</td>
									<td class="txt_center">
									<c:choose>														
										<c:when test="${user.no == task.writerNo || user.no == task.userNo || user.admin}">
										<a href="javascript:leaderModifyCall('${task.taskId}','${task.userNm}(${task.userId})');" id="leaderModifyPosition_${task.taskId}">
										</c:when>
										<c:otherwise>
										<a href="#" id="leaderModifyPosition_${task.taskId}">
										</c:otherwise>
									</c:choose>									
									${task.userNm}</a></td>
														
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<!-- 페이징 시작 -->
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					<!-- 페이징 끝 -->
					
				</div>
				<!-- E: section -->
	
				</div>
				<!-- E: center -->	
				<%//@ include file="../include/right.jsp"%>
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
<input type="hidden" name="userId" value=""/>
<input type="hidden" name="userNo" value="${user.userNo}"/>
<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
<input type="hidden" name="searchText" value="${searchVO.searchText}"/>
<input type="hidden" name="searchSdate" value="${searchVO.searchSdate}"/>
<input type="hidden" name="searchEdate" value="${searchVO.searchEdate}"/>
<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
<input type="hidden" name="param_returnUrl" value="/cooperation/selectDayReportMyDList.do"/>	              
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
	
						
</form>	                
 <!-- 레이어 수정 화면 끝 -->
 
</body>
</html>
