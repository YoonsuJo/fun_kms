<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>
function writeComment() {
	if(document.commentFrm.bcCommentCn.value == ""){
		alert('답글 내용을 입력하세요.');
		return;
	}

	document.commentFrm.action = "${rootPath}/mobile/cooperation/insertBusinessContactComment.do";
	document.commentFrm.submit();
}

function goBack(){
	history.back();
}
</script>

<div id="showhidden"></div>
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>댓글쓰기</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;"><font class="fontShadow"><a href="javascript:goBack();" alt="">뒤로</a></font></div>
</ul>
<!-- S:콘텐츠 들어가는곳 -->

<hr class="hr_e1e1e1" />
<div class="reply_commd" style="margin-bottom:8px;">
<form name="commentFrm" method="POST">
<input type="hidden" name="bcId" value="${bcId}"/>
<textarea name="bcCommentCn" placeholder="내용을 입력해 주세요." rows="6" cols="85"></textarea>
</form>
</div>

<p>
<a href="javascript:goBack();"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
<a href="javascript:writeComment();"><button class="bgBtn shadowBtn btnreply" style="float:right; margin-right:10px; width:50px">등록</button></a>
</p>
<br/>
</div>
<!-- E:콘텐츠 들어가는곳 -->
<jsp:include page="../include/footer.jsp"></jsp:include>