<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="commBoard" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	document.board.nttCn.value = myeditor.outputBodyHTML();
	if (!validateCommBoard(document.board)) {
		return;
	}
	document.board.action = "<c:url value='${rootPath}/community/insertBoardArticle.do'/>";
	<c:if test="${isReply == 'Y'}">
	document.board.action = "<c:url value='${rootPath}/community/replyBoardArticle.do'/>";
	</c:if>
	document.board.submit();
}
function listArticle() {
	document.board.action = "<c:url value='${rootPath}/community/selectBoardList.do'/>";
	document.board.submit();
}
</script>
</head>

<body>
<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">
							<c:choose>
								<c:when test="${bdMstr.bbsId=='BBSMSTR_000000000002'}">관리자 게시판</c:when>
								<c:when test="${bdMstr.bbsId=='BBSMSTR_000000000003'}">도움말 툴팁 게시판</c:when>
							</c:choose>
							</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<p class="th_stitle">
						<c:choose>
							<c:when test="${bdMstr.bbsId=='BBSMSTR_000000000002'}">관리자 게시판</c:when>
							<c:when test="${bdMstr.bbsId=='BBSMSTR_000000000003'}">도움말 툴팁 게시판</c:when>
						</c:choose>
						</p>
						
						<!-- 게시판 시작  -->
						<form:form commandName="commBoard" name="board" method="post" enctype="multipart/form-data" >
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
						
						<c:if test="${isReply == 'Y'}">
							<input type="hidden" name="replyAt" value="Y" />
							<input type="hidden" name="nttId" value="<c:out value='${searchVO.nttId}'/>" />
							<input type="hidden" name="parnts" value="<c:out value='${searchVO.parnts}'/>" />
							<input type="hidden" name="sortOrdr" value="<c:out value='${searchVO.sortOrdr}'/>" />
							<input type="hidden" name="replyLc" value="<c:out value='${searchVO.replyLc}'/>" />
						</c:if>
						
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="자유게시판 게시물 작성페이지입니다.">
							<caption>자유게시판 게시물 작성</caption>
							<colgroup>
								<col class="col100" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
									<th class="write_info1">제목</th>
									<th class="write_info3">
										<input type="text" class="write_input" name="nttSj" <c:if test="${isReply == 'Y'}">value="RE: <c:out value='${result.nttSj}'/>"</c:if> />
										<br/><form:errors path="nttSj" />
									</th>
								</tr>
								<tr>
									<th class="write_info">첨부파일</th>
									<th class="write_info2">
										<input name="file_1" id="egovComFileUploader" type="file" class="write_input"/>
										<div id="egovComFileList"></div>
										<script type="text/javascript">
											var maxFileNum = document.board.posblAtchFileNumber.value;
											if(maxFileNum==null || maxFileNum==""){
												maxFileNum = 3;
											}
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										</script>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="2">
										<textarea rows="9" cols="100" name="nttCn" id="nttCn"></textarea>
										<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'nttCn';
											myeditor.run();
										</script>
									</td>
								</tr>
							</tbody>
							</table>
						</div>
						</form:form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area02">
							<a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
							<a href="javascript:listArticle();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
						</div>
						<!-- 버튼 끝 -->
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>