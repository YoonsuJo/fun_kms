<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>
function register() {
	document.board.action = "<c:url value='${rootPath}/mobile/support/insertBoardArticle.do'/>";
	<c:if test="${isReply == 'Y'}">
	document.board.action = "<c:url value='${rootPath}/mobile/support/replyBoardArticle.do'/>";
	</c:if>
	document.board.submit();					
}

function goBack(){
	history.back();
}
</script>
<div id="showhidden"></div>
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>공지사항등록</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;"><font class="fontShadow"><a href="javascript:goBack();" alt="">뒤로</a></font></div>
</ul>
<div id="viw">
<!-- S:콘텐츠 들어가는곳 -->
<hr class="hr_e1e1e1" />
<form:form commandName="commBoard" name="board" method="post" > <!-- enctype="multipart/form-data" -->
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
<input type="hidden" name="exDt" value="<c:out value='99991231'/>" />
<input type="hidden" name="exHm" value="<c:out value='${result.exHm}'/>" />

<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
<input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />

<table cellspacing="0" border="1" summary="" class="office_f">
	<caption></caption>
	<colgroup>
		<col width="80px">
		<col width="*">
		<col width="40px">
	</colgroup>
	<tbody>
		<tr>
			<th scope="col">제목</th>
			<td scope="col" colspan="2">
				<input type="text" style="width:98%" name="nttSj" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder="">
			</td>
		</tr>
		<tr>
			<td scope="col" colspan="3"><textarea rows="9" cols="100" name="nttCn" placeholder="내용을 입력해주세요."style="width:98%" ></textarea></td>
		</tr>
	</tbody>
</table>
</form:form>

<p style="margin:10px 0px 50px 0px">
<a href="javascript:goBack();"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
<a href="javascript:register();"><button class="bgBtn shadowBtn btnreply" id="searchpoppp" style="float:right; margin-right:10px; width:50px">등록</button></a>
</p>
<br/>
</div>
<!-- E:콘텐츠 들어가는곳 -->
<jsp:include page="../include/footer.jsp"></jsp:include>