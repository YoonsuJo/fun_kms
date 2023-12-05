<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="commBoard" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function update() {
	document.board.nttCn.value = myeditor.outputBodyHTML();
	if (!validateCommBoard(document.board)) {
		return;
	}
	document.board.action = "<c:url value='${rootPath}/community/updateBoardArticle.do'/>";
	document.board.submit();					
}
function fn_egov_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "";
	}
}
function listArticle() {
	document.board.action = "<c:url value='${rootPath}/community/selectBoardList.do'/>";
	document.board.submit();
}
</script>
</head>

<body>

<div id="wrap">
	<%@ include file="../include/top_inc.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
<%-- 		<%@ include file="left.jsp"%>  --%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">게시물 수정</li>
							<li class="navi">홈 > 커뮤니티 > 게시판</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						
						<p class="th_stitle">자유게시판</p>
						
						<!-- 게시판 시작  -->
						<form:form commandName="commBoard" name="board" method="post" enctype="multipart/form-data" >
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/community/forUpdateBoardArticle.do'/>"/>
						<input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
						<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
						<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
						<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
						<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
						<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
						<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
						<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
						<input type="hidden" name="tmplatId" value="<c:out value='${bdMexHmstr.tmplatId}'/>" />
						<input type="hidden" name="exDt" value="<c:out value='99991231'/>" />
						<input type="hidden" name="exHm" value="<c:out value='${result.exHm}'/>" />
						
						<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
						<input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />
												
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="자유게시판 게시물 수정페이지입니다.">
		                    <caption>자유게시판 게시물수정</caption>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                        <th class="write_info">제목</th>
			                        <th class="write_info2">
			                        	<input type="text" class="write_input" name="nttSj" value='<c:out value="${result.nttSj}" />'/>
			                        </th>
		                        </tr>
								<tr>
									<th class="write_info">첨부파일</th>
									<th class="write_info2">
										<c:if test="${not empty result.atchFileId}">
											<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.atchFileId}" />
											</c:import>
										</c:if>	
										<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
											<c:if test="${result.atchFileId == ''}">
												<input type="hidden" name="fileListCnt" value="0" />
											</c:if>
											<div id="file_upload_posbl"  style="display:none;" >	
												<input name="file_1" id="egovComFileUploader" type="file" />
												<div id="egovComFileList"></div>
											</div>
											<div id="file_upload_imposbl"  style="display:none;" >
												<spring:message code="common.imposbl.fileupload" />
											</div>		    
													   	
											<script type="text/javascript">
											var existFileNum = document.board.fileListCnt.value;	    
											var maxFileNum = document.board.posblAtchFileNumber.value;
											
											if (existFileNum=="undefined" || existFileNum ==null) {
												existFileNum = 0;
											}
											if (maxFileNum=="undefined" || maxFileNum ==null) {
												maxFileNum = 0;
											}		
											var uploadableFileNum = maxFileNum - existFileNum;
											if (uploadableFileNum<0) {
												uploadableFileNum = 0;
											}				
											if (uploadableFileNum != 0) {
												fn_egov_check_file('Y');
												var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
												multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
											} else {
												fn_egov_check_file('N');
											}			
											</script>
										</c:if>
									</th>
		                        </tr>	                        
		                    </thead>
		                    <tbody>
		                    	<tr>
			                    	<td colspan="2">
			                    		<textarea rows="9" cols="100" name="nttCn" id="nttCn"><c:out value="${result.nttCn}" escapeXml="false" /></textarea>
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
		                	<a href="javascript:update();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		                	<a href="javascript:listArticle();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->
					</div>
					<!-- E: section -->
				</div>
				<!-- E: center -->				
<%--            <%@ include file="include/right.jsp"%>  --%>
			</div>
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
