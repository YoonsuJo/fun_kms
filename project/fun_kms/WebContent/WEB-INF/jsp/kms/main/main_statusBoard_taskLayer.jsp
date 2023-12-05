<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="../include/ajax_inc.jsp"%>

<dl>
	<dt><print:project prjCd="${task.prjCd}" prjId="${task.prjId}" prjNm="${task.prjNm}"/></dt>
	<dd class="title">${task.taskSjPrint}</dd>
	<dd>완료예정일 : ${task.taskDuedate}</dd>
	<dd>${task.taskCn}</dd>
	<c:forEach items="${task.taskContentList}" var="taskCnt">
	<dd class="add_link">[${taskCnt.taskCntTypPrint}] ${taskCnt.taskCntSj}</dd>
	</c:forEach>
</dl>
