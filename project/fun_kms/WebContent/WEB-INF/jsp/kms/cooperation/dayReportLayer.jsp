<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>
<dl>
	<dt>[${result.prjCd}] ${result.prjNm} <p>${result.taskSjPrint}</p></dt>
	<dd>
		<c:forEach items="${result.dayReportList}" var="dr">
			<ul>
				<li>${dr.dayReportDtPrint} (${dr.dayReportTm}시간)</li>
				<li class="Rcon"><c:out value="${dr.dayReportCnPrint}" escapeXml="false"/></li>
			</ul>
		</c:forEach>
	</dd>
</dl>
