<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>


<script>

function fn_egov_insert_commentList() {
	if (document.frm.commentCn.value.length > 65535) {
		alert("답글이 너무 깁니다.");
		return;
	} else if (document.frm.commentCn.value == "") {
		alert('덧글 내용을 입력하세요.');
		return;
	}
	document.frm.action = "<c:url value='${rootPath}/mobile/support/insertComment.do'/>";
	document.frm.submit();
}

function fn_egov_updt_commentList() {
	//alert("mobile");
	document.frm.modified.value = "true";
	document.frm.action = "<c:url value='${rootPath}/mobile/support/updateComment.do'/>";
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

/*
function fn_egov_selectCommentForupdt(commentNo, index) {
	document.frm.commentNo.value = commentNo;
	document.frm.action = "<c:url value='${rootPath}/mobile/support/selectBoardArticle.do'/>";
	document.frm.submit();
}*/

function fn_egov_select_commentList() {
	//document.frm.subPageIndex.value = pageNo; 
	document.frm.commentNo.value = '';
	document.frm.action = "<c:url value='${rootPath}/mobile/support/selectBoardArticle.do'/>";
	document.frm.submit();
}

function goBack(){
	history.back();
}
</script>

<div id="showhidden"></div>
	<ul class="sectionttl bgTop">
		<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
		<li>댓글쓰기</li>
		<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;"><font class="fontShadow"><a href="javascript:goBack();" data-rel="back" >뒤로</a></font></div>
	</ul>

<!-- S:콘텐츠 들어가는곳 -->
	
	<form name="frm" method="post">
	
		<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
		<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
			
		<input name="commentNo" type="hidden" value="<c:out value='${resultComment.commentNo}'/>">
		<input name="modified" type="hidden" value="false">
	
		<input name="confirmPassword" type="hidden">
		
		<c:if test="${anonymous != 'true'}">
		<input type="hidden" name="commentPassword" value="dummy">	<!-- validator 처리를 위해 지정 -->
		</c:if>

		<hr class="hr_e1e1e1" />
		<div class="reply_commd" style="margin-bottom:8px;">
		<textarea name="commentCn" placeholder="내용을 입력해 주세요."><c:out value="${resultComment.commentCn}" /></textarea>
		</div>
	
		<p>
			<a href="javascript:fn_egov_select_commentList()"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
	
		<c:choose>
			<c:when test="${resultComment.commentNo == ''}">
			<a href="javascript:fn_egov_insert_commentList();"><button class="bgBtn shadowBtn btnreply" style="float:right; margin-left:10px; width:50px">등록</button></a>
			</c:when>
			<c:otherwise>
				<a href="javascript:fn_egov_updt_commentList()"><button class="bgBtn shadowBtn btnreply" style="float:right; margin-right:10px; width:50px">수정</button></a>
			</c:otherwise>
		</c:choose>
		</p>
		
	</form>

<!-- E:콘텐츠 들어가는곳 -->

	<c:if test="${not empty subMsg}">
	<script>
		alert("<c:out value='${subMsg}'/>");
	</script>
	</c:if>

<jsp:include page="../include/footer.jsp"></jsp:include>