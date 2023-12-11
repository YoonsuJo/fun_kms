<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function updateTask() {
	//var popup = window.open("${rootPath}/cooperation/updateTaskView.do?taskId=${result.taskId}","_TASK_POP_","width=570px,height=450px,scrollbars=yes,resizable=yes");
	var popup = window.open("${rootPath}/cooperation/updateTaskView.do?taskId=${result.taskId}","_TASK_POP_","width=754px,height=786px,scrollbars=yes,resizable=yes");
	popup.focus();
}
function deleteTask() {
	if (confirm("이 업무를 삭제하면 그동안의 작업진행내역도 함께 삭제됩니다.\r\n정말로 삭제하시겠습니까?")) {
		document.frm.action = "${rootPath}/cooperation/deleteTask.do";
		document.frm.submit();
	}
}
function goBack() {
	document.frm.submit();
}

function writeDayReport() {
	var popup = window.open("${rootPath}/cooperation/insertDayReportView.do?taskId=${result.taskId}&userNo=${result.userNo}&searchDate=${searchVO.searchDate}","_TASK_POP_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}
function updateDayReport(no) {
	var POP_NAME = "_DAY_REPORT_POP_";

	var popup = window.open("about:blank",POP_NAME,"width=560px,height=570px,scrollbars=yes");
	
	document.drFrm.no.value = no;
	document.drFrm.action = "${rootPath}/cooperation/updateDayReportView.do";
	document.drFrm.target = POP_NAME;

	document.drFrm.submit();
	popup.focus();
}
function deleteDayReport(no) {
	if (confirm("삭제하시겠습니까?")) {
		document.drFrm.no.value = no;
		document.drFrm.action = "${rootPath}/cooperation/deleteDayReport.do";
		document.drFrm.submit();
	}
}

function delTaskContent(no) {
	if (confirm("삭제하시겠습니까?")) {
		document.tcFrm.no.value = no;
		document.tcFrm.action = "${rootPath}/cooperation/deleteTaskContent.do";
		document.tcFrm.submit();
	}
}
function updateState(taskState) {
	document.stateFrm.taskState.value = taskState;
	document.stateFrm.action = "${rootPath}/cooperation/updateTaskState2.do";
	document.stateFrm.submit();
}


function connect() {
	var POP_NAME = "_POP_TASK_CONTENT_";
	document.connectFrm.target = POP_NAME;
	document.connectFrm.action = "${rootPath}/cooperation/insertTaskContentView.do";
	
	var popup = window.open("about:blank",POP_NAME,"width=754px,height=784px,scrollbars=yes,resizable=yes");
	document.connectFrm.submit();
	popup.focus();
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
						<li class="stitle">작업 상세정보</li>
						<li class="navi">홈 > 업무공유  > 업무계획/실적  > 나의업무</li>
					</ul>
				</div>	
				
				
				<!-- S: section -->
				<div class="section01">
                
				<!-- 게시판 시작  -->
				<p class="th_stitle">작업 개요</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>작업 개요</caption>
		                    <colgroup>
		                    <col class="col80" />
		                    <col width="px"/>
		                    <col class="col80" />
		                    <col width="px"/>
		                    <col class="col80" />
		                    <col width="px"/>
		                    </colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">프로젝트</td>
			                    	<td class="pL10" colspan="5"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}"/></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">작업명</td>
			                    	<td class="pL10" colspan="5">${result.taskSjPrint}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">담당자</td>
			                    	<td class="pL10" ><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
			                    	<td class="title">등록자</td>
			                    	<td class="pL10" colspan="3"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">기간</td>
			                    	
			                    	
			                    	
			                    	<c:set var="sYear" value="${fn:substring(result.taskStartdatePrint,0,4)}" />
			                    	<c:set var="eYear" value="${fn:substring(result.taskDuedatePrint,0,4)}" />
			                    	<td class="pL10" >${fn:substring(result.taskStartdatePrint,5,10)} ~ 
			                    	<c:if test="${sYear != eYear}">${eYear}.</c:if>${fn:substring(result.taskDuedatePrint,5,10)}</td>
		                    		<td class="title">상태</td>
			                    	<td class="pL10">
			                    		<span class="txt_blue">${result.taskStatePrint}</span>
			                    	</td>
			                    	<td class="title">계속보기</td>
			                    	<td class="pL10" >${result.alwaysViewYn}</td>
			                   </tr>
		                    	<tr>
			                    	<td class="title">내용</td>
			                    	<td class="pL10 pT5 pB5" colspan="5"><c:out value="${result.taskCnPrint}" escapeXml="false"/></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						<!--// 게시판 끝  -->
					
					<!-- 버튼 시작 -->
		                <div class="btn_area04">
                    		<a href="javascript:connect();"><img src="${imagePath}/btn/btn_connect.gif"/></a>
                    		<c:if test="${user.no == result.userNo || user.no == result.leaderNo || user.no == result.writerNo || user.admin}">
                    		<c:choose>
                    		<c:when test="${result.process}">
			                	<a href="javascript:updateState('C');"><img src="${imagePath}/btn/btn_complete.gif"/></a>
		                	</c:when>
                    		<c:when test="${result.complete}">
			                	<a href="javascript:updateState('P');"><img src="${imagePath}/btn/btn_uncomplete02.gif"/></a>
		                	</c:when>
                    		</c:choose>
                    			<a href="javascript:updateTask();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
			                	<a href="javascript:deleteTask();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
		                	</c:if>
		                	<a href="javascript:goBack();"><img src="${imagePath}/btn/btn_back.gif"/></a>
		                </div>
	                <!-- 버튼 끝 -->
	            	
	            	<!-- 게시판 시작  -->
	            	<p class="th_stitle">관련자료</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>프로젝트 현황</caption>
	                    <colgroup><col class="col90" /><col width="px"/><col class="col90" /><col class="col100" /><col class="col70" /></colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>종류</th>
	                    		<th>제목</th>
	                    		<th>등록자</th>
	                    		<th>등록일</th>
	                    		<th class="td_last"></th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${result.taskContentList}" var="tc">
		                    	<tr>
			                    	<td class="txt_center">${tc.taskCntTypPrint}</td>
			                    	<td class="pL10"><a href="${tc.linkUrl}">${tc.taskCntSj}</a></td>
			                    	<td class="txt_center"><print:user userNo="${tc.userNo}" userNm="${tc.userNm}"/></td>
			                    	<td class="txt_center">${tc.taskCntRegDt}</td>
			                    	<td class="td_last txt_center">
			                    		<c:if test="${user.no == result.userNo || user.admin}">
			                    			<a href="javascript:delTaskContent('${tc.no}');"><img src="${imagePath}/btn/btn_delete.gif"/></a>
			                    		</c:if>
			                    	</td>
		                    	</tr>
	                    	</c:forEach>
	                    	<c:if test="${empty result.taskContentList}">
	                    		<tr>
	                    			<td colspan="5" class="txt_center">등록된 관련자료가 없습니다.</td>
	                    		</tr>
	                    	</c:if>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판  끝  -->
					
					<!-- 게시판 시작  -->
	            	<p class="th_stitle">진행내역
						<c:if test="${user.no == result.userNo || user.admin}">
							<span class="th_plus02"><img src="${imagePath}/btn/btn_result.gif" onclick="writeDayReport()" style="cursor:pointer"/></span>
						</c:if>
	            	</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>프로젝트 현황</caption>
	                    <colgroup><col class="col90" /><col class="col100" /><col width="px"/><col class="col70" /></colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>날짜</th>
	                    		<th>시간</th>
	                    		<th>내용</th>
	                    		<th class="td_last">변경</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${result.dayReportList}" var="dr">
		                    	<tr>
			                    	<td class="txt_center">${dr.dayReportDtPrint}</td>
			                    	<td class="txt_center">${dr.dayReportTm} 시간</td>
			                    	<td class="pL10"><c:out value="${dr.dayReportCnPrint}" escapeXml="false"/><br/>
			                    		<c:if test="${!empty dr.attachFileId}">
											<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${dr.attachFileId}" />
											</c:import>
										</c:if>
			                    	</td>
			                    	<td class="td_last txt_center">
			                    		<c:if test="${user.no == result.userNo || user.admin}">
				                    		<a href="javascript:updateDayReport('${dr.no}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
				                    		<a href="javascript:deleteDayReport('${dr.no}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
			                    		</c:if>
			                    	</td>
		                    	</tr>
	                    	</c:forEach>
	                    	<c:if test="${empty result.dayReportList}">
	                    		<tr>
	                    			<td colspan="4" class="txt_center">등록된 나의업무보고가 없습니다.</td>
	                    		</tr>
	                    	</c:if>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판  끝  -->
					


					<!-- 게시판 시작  
					
					프로젝트 변경 = CP
		담당자 변경 - CL 
		시작일 변경 - CS 
		예정일 변경 - CD 
		예정 시간 변경 - CDT
		
		시작일 변경 - CS 
		내용 수정 - CC
		미완료 - P
		완료처리 - C 	
		-->
		
		

															
	            	<p class="th_stitle">변경 이력</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>프로젝트 현황</caption>
	                    <colgroup><col class="col90" /><col class="col100" /><col width="px"/><col class="col70" /></colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>등록일</th>
	                    		<th>진행내역</th>
	                    		<th>변경내역</th>
	                    		<th class="td_last">등록자</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${taskHistoryList}" var="taskHistory">
		                    	<tr>
			                    	<td class="txt_center">${taskHistory.regDt}</td>
			                    	<td class="txt_center">
									<c:choose>
									<c:when test="${taskHistory.historyStat == 'CP'}">
									프로젝트 변경	
									</c:when>
									<c:when test="${taskHistory.historyStat == 'CL'}">
									담당자 변경
									</c:when>
									<c:when test="${taskHistory.historyStat == 'CS'}">
									시작일 변경	
									</c:when>
									<c:when test="${taskHistory.historyStat == 'CST'}">
									시작 시간 변경
									</c:when>	
									<c:when test="${taskHistory.historyStat == 'CD'}">
									예정일 변경	
									</c:when>
									<c:when test="${taskHistory.historyStat == 'CDT'}">
									예정 시간 변경
									</c:when>	
									<c:when test="${taskHistory.historyStat == 'CS'}">
									시작일 변경
									</c:when>
									<c:when test="${taskHistory.historyStat == 'CC'}">
									내용 수정
									</c:when>
									<c:when test="${taskHistory.historyStat == 'P'}">
									미완료
									</c:when>
									<c:when test="${taskHistory.historyStat == 'C'}">
									완료
									</c:when>										
									<c:otherwise>
									${taskHistory.historyStat}
									</c:otherwise>
									</c:choose> 
									</td>
			                    	<td class="pL10">${taskHistory.historyCn}</td>
			                    	<td class="td_last txt_center">${taskHistory.writerNm}</td>
		                    	</tr>
	                    	</c:forEach>
	                    	<c:if test="${empty taskHistoryList}">
	                    		<tr>
	                    			<td colspan="4" class="txt_center">등록된 변경내역이 없습니다.</td>
	                    		</tr>
	                    	</c:if>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판  끝  -->
		
		
	            	
	            	<form name="stateFrm" method="GET">
	            		<input type="hidden" name="taskId" value="${result.taskId}"/>
	            		<input type="hidden" name="searchDate" value="${searchVO.searchDate}"/>
	            		<input type="hidden" name="searchUserNo" value="${searchVO.searchUserNo}"/>
	            		<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
	            		<input type="hidden" name="param_returnUrl" value="${searchVO.param_returnUrl}"/>
	                   	<input type="hidden" name="searchType" value="${searchVO.searchType}"/>			    			    	
				    	<input type="hidden" name="includeEnd" value="${searchVO.includeEnd}"/>
	            		<input type="hidden" name="taskState"/>
	            	</form>
	            	
	            	<form name="drFrm" method="POST">
	            		<input type="hidden" name="taskId" value="${result.taskId}"/>
	            		<input type="hidden" name="searchDate" value="${searchVO.searchDate}"/>
	            		<input type="hidden" name="searchDateFrom" value="${searchVO.searchDateFrom}"/>		    	
			    		<input type="hidden" name="searchDateTo" value="${searchVO.searchDateTo}"/>
	            		<input type="hidden" name="searchUserNo" value="${searchVO.searchUserNo}"/>
	            		<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
	            		<input type="hidden" name="param_returnUrl" value="${searchVO.param_returnUrl}"/>
	                 	<input type="hidden" name="searchType" value="${searchVO.searchType}"/>			    			    	
				    	<input type="hidden" name="includeEnd" value="${searchVO.includeEnd}"/>
	            		<input type="hidden" name="no"/>
	            	</form>

	            	<form name="tcFrm" method="POST">
	            		<input type="hidden" name="taskId" value="${result.taskId}"/>
	            		<input type="hidden" name="searchDate" value="${searchVO.searchDate}"/>
	            		<input type="hidden" name="searchDateFrom" value="${searchVO.searchDateFrom}"/>		    	
			    		<input type="hidden" name="searchDateTo" value="${searchVO.searchDateTo}"/>
	            		<input type="hidden" name="searchUserNo" value="${searchVO.searchUserNo}"/>
	            		<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
	            		<input type="hidden" name="param_returnUrl" value="${searchVO.param_returnUrl}"/>	 
		            	<input type="hidden" name="searchType" value="${searchVO.searchType}"/>			    			    	
				    	<input type="hidden" name="includeEnd" value="${searchVO.includeEnd}"/>
	            		<input type="hidden" name="no"/>
	            	</form>

	            	<form name="frm" method="GET" action="${rootPath}${searchVO.param_returnUrl}">
	            		<input type="hidden" name="taskId" value="${result.taskId}"/>
	            		<input type="hidden" name="searchDate" value="${searchVO.searchDate}"/>
	            		<input type="hidden" name="searchDateFrom" value="${searchVO.searchDateFrom}"/>		    	
			    		<input type="hidden" name="searchDateTo" value="${searchVO.searchDateTo}"/>
	            		<input type="hidden" name="searchUserNo" value="${searchVO.searchUserNo}"/>
	            		<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
	            		<input type="hidden" name="param_returnUrl" value="${searchVO.param_returnUrl}"/>	 
		            	<input type="hidden" name="searchType" value="${searchVO.searchType}"/>			    			    	
				    	<input type="hidden" name="includeEnd" value="${searchVO.includeEnd}"/>
	            	</form>
	            	
	            	<form name="connectFrm" method="POST">
	            		<input type="hidden" name="taskContentTyp" value="TA"/>
		    			<input type="hidden" name="title" value="${result.taskSj}"/>
		    			<input type="hidden" name="userNm" value="${result.userNm}"/>
		    			<input type="hidden" name="regDt" value="${result.regDt}"/>
		    			<input type="hidden" name="linkUrl" value="${rootPath}/cooperation/selectTaskInfo.do?taskId=${result.taskId}"/>
		      			<input type="hidden" name="taskId" value="${result.taskId}"/>
		            </form>
		                
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
