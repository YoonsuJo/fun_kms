<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
var POP_NAME = "_DAY_REPORT_POP_";

function updateDayReport(taskId, no) {
	var popup = window.open("about:blank",POP_NAME,"width=560px,height=570px,scrollbars=yes");
	
	document.drFrm.taskId.value = taskId;
	document.drFrm.no.value = no;
	document.drFrm.action = "${rootPath}/cooperation/updateDayReportView.do";
	document.drFrm.target = POP_NAME;

	document.drFrm.submit();
	popup.focus();
}
function deleteDayReport(taskId, no, userNo) {
	if (confirm("삭제하시겠습니까?")) {
		document.drFrm.taskId.value = taskId;
		document.drFrm.no.value = no;
		document.drFrm.userNo.value = userNo;
		document.drFrm.action = "${rootPath}/cooperation/deleteDayReportPop.do";
		document.drFrm.submit();
	}
}
function writeDayReport(taskId,userNo,searchDate) {
	var popup = window.open("${rootPath}/cooperation/insertDayReportView.do?taskId=" + taskId + "&userNo=" + userNo + "&searchDate=" + searchDate,POP_NAME,"width=560px,height=570px,scrollbars=yes");
	popup.focus();
}
function closePop() {
	opener.location.reload();
	window.close();
}
</script>
</head>

<body>
<div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">작업 진행내역</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 	
       	<p class="th_stitle">진행내역	</p>
		<div class="boardList02 mB20">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
            <caption>프로젝트 현황</caption>
            <colgroup>
	            <col class="col90" />
	            <col class="col60" />
	            <col width="px"/>
	            <col class="col70" />
            </colgroup>
            <thead>
            	<tr>
            		<th>날짜</th>
            		<th>시간</th>
            		<th>내용</th>
            		<th class="td_last">변경</th>
            	</tr>
            </thead>
            <tbody>
            	<c:if test="">
            		<tr>
            			<td class="txt_center td_last" colspan="4">등록된 나의업무보고가 없습니다.</td>
            		</tr>
            	</c:if>
            	<c:forEach items="${resultList}" var="result">
	           		<tr>
	           			<td class="txt_center">${result.dayReportDtPrint}</td>
	           			<td class="txt_center">${result.dayReportTm} 시간</td>
	           			<td class="pL5">${result.dayReportCnPrint}<br/>
	           				<c:if test="${!empty result.attachFileId}">
		           				<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${result.attachFileId}" />
								</c:import>
							</c:if>
						</td>
	           			<td class="txt_center td_last">
	           				<c:if test="${user.admin || user.no == result.userNo}">
                    		<a href="javascript:updateDayReport('${result.taskId}','${result.no}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
                    		<a href="javascript:deleteDayReport('${result.taskId}','${result.no}', '${result.userNo}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
	           				</c:if>
	           			</td>
	           		</tr>
            	</c:forEach>
            </tbody>
            </table>
            
            <form name="drFrm" method="POST">
           		<input type="hidden" name="taskId"/>
           		<input type="hidden" name="no"/>
           		<input type="hidden" name="userNo" value="${searchVO.userNo}"/>
           		<input type="hidden" name="param_userNo" value="${searchVO.userNo}"/>
           		<input type="hidden" name="date" value="${searchVO.date}"/>
           		<input type="hidden" name="param_returnUrl" value="/cooperation/selectDayReportList.do"/>
           	</form>
		</div>
		
		<div class="pop_btn_area04">
			<a href="javascript:writeDayReport('${param.taskId}','${param.userNo}','${param.date}');"><img src="${imagePath}/btn/btn_result.gif" /></a>
			<a href="javascript:closePop();"><img src="${imagePath}/btn/btn_close.gif" /></a>
		</div>
	</div>
</div>
	
</body>
</html>
