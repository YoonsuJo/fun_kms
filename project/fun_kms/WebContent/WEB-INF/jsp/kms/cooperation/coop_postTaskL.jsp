<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>
<script>
function viewTask(taskId) {
	document.frm.taskId.value = taskId;
	document.frm.action = "${rootPath}/cooperation/selectTaskInfo.do";
	document.frm.submit();
}
</script>

<p class="th_stitle mB10">향후작업</p>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>프로젝트 현황</caption>
	<colgroup>
		<col class="col90" />
		<col class="col90" />
		<col width="px"/>
	 	<col width="px"/>
		<col class="col80" />
	</colgroup>
	<thead>
		<tr>
			<th>시작일</th>
			<th>완료일</th>
			<th>프로젝트</th>
			<th>작업</th>
			<th class="td_last">&nbsp;</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
		<tr>
		 	<td class="txt_center">${result.taskStartdatePrint} ${result.taskStarttimePrint}</td>
		 	<td class="txt_center">${result.taskDuedatePrint} ${result.taskDuetimePrint}</td>
		 	<td class="pL10"><print:project prjId="${result.prjId}" prjCd="${result.prjCd}" prjNm="${result.prjNm}"/></td>
		 	<td>
		 		<ul>
		 			<li class="txtB_Black"><a href="javascript:viewTask('${result.taskId}');">${result.taskSjPrint}</a></li>
		 			<li><c:out value="${result.taskCnPrint}" escapeXml="false"/></li>
		 		</ul>
		 	</td>
		 	<td class="td_last txt_center">
		 		<a href="javascript:writeDayReport('${result.taskId}','${searchVO.param_userNo}','${todayDate}');"><img src="${imagePath}/btn/btn_result.gif"/></a>
		 	</td>
		</tr>               			                    			                    	
		</c:forEach>
	</tbody>
</table>
