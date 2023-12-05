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
function register() {
	document.board.nttCn.value = myeditor.outputBodyHTML();
	if (!validateCommBoard(document.board)) {
		return;
	}
	if (document.board.orgnztId.value == "") {
		alert("프로젝트를 선택해주세요.");
		return;
	}
	document.board.action = "<c:url value='${rootPath}/cooperation/insertOrgBoard.do'/>";
	document.board.submit();					
}
function listArticle() {
	document.board.action = "<c:url value='${rootPath}/cooperation/selectOrgBoardList.do?orgnztId=${searchVO.orgnztId}'/>";
	document.board.submit();
}
</script>
</head>

<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">게시물 작성</li>
							<li class="navi">협업 > 부서게시판</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">
						
						<p class="th_stitle">부서게시판</p>
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
						
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                        <th class="write_info">제목</th>
			                        <th class="write_info2">
			                        	<input type="text" class="write_input pL5" name="nttSj" />
			                        	<br/><form:errors path="nttSj" />
			                        </th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">부서</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="write_input pL5" name="orgNm" id="orgNm" readonly="readonly" onclick="orgGen('orgNm','orgnztId',1);" value="${searchVO.searchOrgNm}"/>
										<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('orgNm','orgnztId',1);" class="cursorPointer"/>
			                    		<input type="hidden" class="write_input" name="orgnztId" id="orgnztId" value="${searchVO.orgnztId}"/>
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
				<%@ include file="../include/right.jsp"%>
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
