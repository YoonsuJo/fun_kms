<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="print" uri="print" %>

<script type="text/javascript">



function fn_egov_selectCommentForupdt(commentNo, index) {
	document.frm.commentNo.value = commentNo;
	document.frm.action = "<c:url value='${rootPath}/mobile/support/goAddReplyComment.do'/>";
	document.frm.submit();
}

function fn_egov_deleteCommentList(commentNo, index) {
	//if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.modified.value = "true";
		document.frm.commentNo.value = commentNo;
		document.frm.action = "<c:url value='${rootPath}/mobile/support/deleteComment.do'/>";
		document.frm.submit();
	//}
}

function fn_egov_select_commentList(pageNo) {
	document.frm.subPageIndex.value = pageNo; 
	document.frm.commentNo.value = '';
	document.frm.action = "<c:url value='${rootPath}/mobile/support/selectBoardArticle.do'/>";
	document.frm.submit();
}
</script>

	
	<c:if test="${type == 'body'}">
	
	<input name="subPageIndex" type="hidden" value="<c:out value='${searchVO.subPageIndex}'/>">
	<input name="commentNo" type="hidden" value="">
	<input name="no" type="hidden" value="">
	
	<input name="modified" type="hidden" value="false">
	<input name="confirmPassword" type="hidden">

	<c:if test="${anonymous != 'true'}">
	<input type="hidden" name="commentPassword" value="dummy">	<!-- validator 처리를 위해 지정 -->
	</c:if>
	
	<c:if test="${fn:length(resultList) != 0}">
		<div id="commd">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<hr>
				<div class="reply"> 
					<dl> 
						<dt>
						
						<span><em class="texte"><a href="${rootPath}/mobile/member/selectMember.do?userId=${result.wrterId}"><c:out value="${result.wrterNm}" escapeXml="false"/></a>(<c:out value="${result.wrterId}" escapeXml="false"/>)</em></span> 
						<em class="textz">| <c:out value="${result.lastUpdaterPnttm}" /></em>
						<span class="btn_md">
							<c:if test="${result.frstRegisterId == user.stringNo}">
							   <div class="workm" style="position:absolute; right:0px; top:2px; width:30px;">
							   <a href="javascript:fn_egov_selectCommentForupdt('<c:out value="${result.commentNo}" />', '<c:out value="${status.index}" />');">수정</a>&nbsp;
							   </div>
							   <div class="workm" style="position:absolute; right:40px; top:2px; width:30px;">
							   <a href="javascript:fn_egov_deleteCommentList('<c:out value="${result.commentNo}" />', '<c:out value="${status.index}" />');">삭제</a>&nbsp;
							   </div>
							</c:if>
						</span>
						</dt> 
						<dd class="userText">
							<c:out value="${result.commentCnPrint}" escapeXml="false"/>
							<c:if test="${not empty result.atchFileId}"><br/><br/></c:if>
							<c:import url="${rootPath}/selectFileInfsForMobile.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${result.atchFileId}" />
								<c:param name="param_isComment" value="true" />
							</c:import>		
						</dd>
					</dl>
				</div>
			</c:forEach>
		</div>
	
	</c:if>


</c:if>

<c:if test="${not empty subMsg}">
<script>
	alert("<c:out value='${subMsg}'/>");
</script>
</c:if>
