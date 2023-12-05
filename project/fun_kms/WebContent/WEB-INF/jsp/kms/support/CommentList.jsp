<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>
<% 
 /**
  * @Class Name : EgovCommentList.jsp
  * @Description : 댓글
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.06.29   한성곤          최초 생성
  *
  *  @author 공통컴포넌트개발팀 한성곤
  *  @since 2009.06.29
  *  @version 1.0 
  *  @see
  *  
  */
%>
<c:if test="${type == 'head'}">
<script type="text/javascript">
function fn_egov_insert_commentList() {
	if (document.frm.commentCn.value.length > 65535) {
		alert("답글이 너무 깁니다.");
		return;
	} else if (document.frm.commentCn.value == "") {
		alert('덧글 내용을 입력하세요.');
		return;
	}
	document.frm.action = "<c:url value='${rootPath}/support/insertComment.do'/>";
	document.frm.submit();
}

function fn_egov_updt_commentList() {	
	document.frm.modified.value = "true";
	document.frm.action = "<c:url value='${rootPath}/support/updateComment.do'/>";
	document.frm.submit();
}

function fn_egov_selectCommentForupdt(commentNo, index) {
	//alert("support"); Ajax로 수정필요
	document.frm.commentNo.value = commentNo;
	document.frm.action = "<c:url value='${rootPath}/support/selectBoardArticle.do'/>";
	document.frm.submit();

	//Ajax 부분, submit 다음이라 실행 안됨
	document.frm.commentCn.focus();
	document.commentFrm.no.value = no;
	$.post("${rootPath}/cooperation/updateBusinessContactCommentView.do?type=body", $("#commentFrm").serialize(),
			function(data){
				$('#commentArea').html(data); 
				document.commentFrm.bcCommentCn.focus();
			}
		);
}

function fn_egov_deleteCommentList(commentNo, index) {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.modified.value = "true";
		document.frm.commentNo.value = commentNo;
		document.frm.action = "<c:url value='${rootPath}/support/deleteComment.do'/>";
		document.frm.submit();
	}
}

function fn_egov_select_commentList(pageNo) {
	document.frm.subPageIndex.value = pageNo; 
	document.frm.commentNo.value = '';
	document.frm.action = "<c:url value='${rootPath}/support/selectBoardArticle.do'/>";
	document.frm.submit();
}

window.onload=function() {

	var commentCn = "${searchVO.commentCn}";
	//alert(commentCn); //이건 왜 안들어오는거지?
	var commentNo = "${searchVO.commentNo}";
	//alert(commentNo); 잘 들어옴
	
	if(commentNo != null && commentNo != ""){
		document.frm.commentCn.focus();
	}
};

</script>
</c:if>

<c:if test="${type == 'body'}">	
<input name="subPageIndex" type="hidden" value="<c:out value='${searchVO.subPageIndex}'/>">
<input name="commentNo" type="hidden" value="<c:out value='${searchVO.commentNo}'/>">
<input name="modified" type="hidden" value="false">

<input name="confirmPassword" type="hidden">

<c:if test="${anonymous != 'true'}">
<input type="hidden" name="commentPassword" value="dummy">	<!-- validator 처리를 위해 지정 -->
</c:if>

<div class="replyW mT20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>댓글달기</caption>
		<colgroup>
			<col class="col100" />
			<col width="px" />
			<col class="col80" />
		</colgroup>
		<tr>
			<td class="writer">
				<print:user userNo="${user.no}" userNm="${user.userNm}" userId="${user.userId}" printId="false"/>
			</td>
			<td class="pL10 pT5 pB5">
				<textarea name="commentCn" class="textarea height_70"  cols="50" rows="4" ><c:out value="${searchVO.commentCn}" /></textarea> 
			</td>
			<td class="last pL10">
				<c:choose>
					<c:when test="${searchVO.commentNo == ''}">
						<a href="javascript:fn_egov_insert_commentList()"><img src="${imagePath}/btn/btn_regist02.gif"/></a>
					</c:when>
					<c:otherwise>
						<a href="javascript:fn_egov_updt_commentList()"><img src="${imagePath}/btn/btn_regist02.gif"/></a>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td class="writer last">첨부파일</td>
			<td class="pL10 last" colspan="2"><input type="file" name="attach_file" class="write_input07" /></td>
		</tr>
	</table>
</div>

<c:if test="${fn:length(resultList) != 0}">
	<div class="replyL mT20" style="margin-bottom: 15px;">
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			<caption>댓글보기</caption>
			<colgroup>
				<col class="col100" />
				<col width="px" />
				<col class="col150" />
			</colgroup>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="writer">
		    			<b><print:user userNo="${result.wrterNo}" userNm="${result.wrterNm}" userId="${result.wrterId}" printId="false"/></b>
					</td>
					<td class="txt">
						<!--<c:out value="${result.commentCnPrint}" escapeXml="false"/>-->
						<print:textarea text="${result.commentCnPrint}"/>
					
						<c:if test="${not empty result.atchFileId}"><br/><br/></c:if>
						<c:import url="/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${result.atchFileId}" />
							<c:param name="param_isComment" value="true" />
						</c:import>
					</td>
					<td class="date">
						<c:out value="${result.lastUpdaterPnttm}" />
						<c:if test="${result.frstRegisterId == user.stringNo}">
							<span class="btn_plus">
								<a href="javascript:fn_egov_selectCommentForupdt('<c:out value="${result.commentNo}" />', '<c:out value="${status.index}" />');">
								<img src="${imagePath}/btn/btn_plus02.gif" /></a>
								<a href="javascript:fn_egov_deleteCommentList('<c:out value="${result.commentNo}" />', '<c:out value="${status.index}" />');">
								<img src="${imagePath}/btn/btn_minus02.gif" /></a>
							</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</c:if>

</c:if>
<c:if test="${not empty subMsg}">
<script>
	alert("<c:out value='${subMsg}'/>");
</script>
</c:if>
