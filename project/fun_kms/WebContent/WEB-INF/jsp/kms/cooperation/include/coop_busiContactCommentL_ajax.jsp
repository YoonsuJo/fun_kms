<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<c:forEach items="${resultList}" var="result">
	<tr class="busiComm">
		<td class="writer"><print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}" printId="false"/></td>
		<td class="txt">
			<!--<c:out value="${result.bcCommentCnPrint}" escapeXml="false"/>-->
			<print:textarea text="${result.bcCommentCnPrint}"/>
		
			<c:if test="${not empty result.attachFileId}">
			<p style="margin-top:10px;">
			<c:import url="/selectFileInfs.do" charEncoding="utf-8">
				<c:param name="param_atchFileId" value="${result.attachFileId}" />
				<c:param name="param_isComment" value="true" />
			</c:import>
			</p>
			</c:if>
		</td>
		<td class="date">${result.udtDt}
			<c:if test="${result.userNo == user.no}">
			<span class="btn_plus">
				<a href="javascript:commentUpdateView('${result.no}');"><img src="${imagePath}/btn/btn_plus02.gif" /></a>
				<a href="javascript:commentDelete('${result.no}');"><img src="${imagePath}/btn/btn_minus02.gif" /></a>
			</span>
			</c:if>
		</td>
	</tr>
</c:forEach>
