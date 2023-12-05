<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="BusiContact" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function update() {
	document.frm.bcCn.value = myeditor.outputBodyHTML();
	if (!addedValidateBusi()) {
		return;
	}
	if (!validateBusiContact(document.frm)) {
		return;
	}
	document.frm.submit();					
}

function addedValidateBusi() {
	var bcSj = document.frm.bcSj.value;
	if (bcSj.indexOf('\'') > -1 || bcSj.indexOf('"') > -1) {
		alert('특수문자 \', " 은 입력할 수 없습니다.');
		return false;	
	}
	return true;
}

function cancel() {
	document.frm.action = "<c:url value='${rootPath}/cooperation/selectBusinessContact.do'/>";
	document.frm.submit();
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

function checkSmsYn(obj) {
	if (obj.checked)
		document.getElementById('smsYn').value = 'Y';
	else
		document.getElementById('smsYn').value = 'N';
}

function checkCommentYn(obj) {
	if (obj.checked)
		document.getElementById('commentYn').value = 'Y';
	else
		document.getElementById('commentYn').value = 'N';
}

//2013.08.20 김대현 PUSH 적용
function checkPushYn(obj) {
	if (obj.checked)
		document.getElementById('pushYn').value = 'Y';
	else
		document.getElementById('pushYn').value = 'N';
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
							<li class="stitle">업무연락 작성하기</li>
							<li class="navi">홈 > 업무공유 > 협업 > 업무연락</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">

						<!-- 게시판 시작  -->
						<form:form name="frm" commandName="BusiContact" action="${rootPath}/cooperation/updateBusinessContact.do" enctype="multipart/form-data">
						<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
						<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
						<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
						<input type="hidden" name="includeUnderProject" value="${searchVO.includeUnderProject}"/>
						<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
						<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
						<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
						<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/cooperation/updateBusinessContactView.do'/>"/>
						<input type="hidden" name="bcId" value="${result.bcId}"/>
						<input type="hidden" name="attachFileId" value="${result.attachFileId}"/>
						<input type="hidden" name="userNo" value="${result.userNo}"/>
						
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>업무연락 작성하기</caption>
							<colgroup>
								<col class="col100" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
									<th class="write_info">제목</th>
									<th class="write_info2"><input type="text" name="bcSj" class="write_input" value="${result.bcSj}"/></th>
								</tr>
								<tr>
			                    	<th class="write_info">작성자</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12 userNameAuto userValidateCheck" name="writerMix" id="writerMix"
											value="${result.userNm}(${result.userId})" <c:if test="${!user.admin}">readonly</c:if> />
										<c:if test="${user.admin}">
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('writerMix',1)"/>
										</c:if>
			                    	</th>
		                        </tr>
								<tr>
									<th class="write_info">수신자</th>
									<th class="write_info2">
										<input type="text" class="span_12 userNamesAuto userValidateCheck" name="recUserMixes" id="recUserMixes"
											value="<c:forEach items="${result.recieveList}" var="rec">${rec.userNm}(${rec.userId}), </c:forEach>" />
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recUserMixes',0)" />
									</th>
								</tr>
								<tr>
									<th class="write_info">참조자</th>
									<th class="write_info2">
										<input type="text" class="span_12 userNamesAuto userValidateCheck" name="refUserMixes" id="refUserMixes"
											value="<c:forEach items="${result.referenceList}" var="ref">${ref.userNm}(${ref.userId}), </c:forEach>" />
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('refUserMixes',0)" />
									</th>
								</tr>
								<tr>
									<th class="write_info">프로젝트</th>
									<th class="write_info2">
										<input type="text" class="span_12" name="prjNm" id="prjNm" value="${result.prjNm}" readonly="readonly" onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjId',1)"/>
										<input type="hidden" class="span_12" name="prjId" id="prjId" value="${result.prjId}"/>
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
									</th>
								</tr>
								<!--<tr>
									<th class="write_info">SMS 연동</th>
									<th class="write_info2">
										<input type="hidden" name="smsYn" id="smsYn" value="N" />-->
<!-- ${result.smsYn } 2013-05-13 수정할때는 기본상태를 해제상태 N으로 변경 -->
										<!--<label>
										<input type="checkbox" class="cursorPointer check" onclick="javascript:checkSmsYn(this);" 
											<c:if test="${result.smsYn == 'Y'}">disable="disabled 해제함"</c:if> value="Y"/>--> 
<!-- <c:if test="${result.smsYn == 'Y'}">checked="checked"</c:if> --><!--											
										수신자, 참조자에게 업무연락이 수신되었음을  SMS로 알립니다.</label>
									</th>
								</tr>-->
								<!-- //2013.08.20 김대현 PUSH 적용 -->								
								<tr>
									<th class="write_info">PUSH 연동</th>
									<th class="write_info2">
										<input type="hidden" name="pushYn" id="pushYn" value="N" />
										<label>
										<input type="checkbox" class="cursorPointer check" onclick="javascript:checkPushYn(this);" 
											<c:if test="${result.pushYn == 'Y'}">disable="disabled 해제함"</c:if> value="Y"/> 
										수신자, 참조자에게 업무연락이 수신되었음을  PUSH로 알립니다.</label>
									</th>
								</tr>
																
								<tr>
			                    	<th class="write_info">댓글 허용</th>
			                    	<th class="write_info2">
			                    		<input type="hidden" name="commentYn" id="commentYn" value="${result.commentYn }" />
			                    		<label>
										<input type="checkbox" class="cursorPointer check" onclick="javascript:checkCommentYn(this);" value="Y" 
											<c:if test="${result.commentYn == 'Y'}">checked="checked"</c:if> />										
			                    		댓글작성을 허용합니다.</label>
			                    	</th>
		                        </tr>
								<tr>
									<th class="write_info">첨부파일</th>
									<th class="write_info2">
										<c:if test="${not empty result.attachFileId}">
											<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.attachFileId}" />
											</c:import>
										</c:if>
										<c:if test="${result.attachFileId == ''}">
											<input type="hidden" name="fileListCnt" value="0" />
										</c:if>
										<div id="file_upload_posbl"  style="display:none;" >	
											<input type="file" name="file_1" id="egovComFileUploader" class="write_input"/>
											<div id="egovComFileList"></div>
										</div>
										<div id="file_upload_imposbl"  style="display:none;" >
											<spring:message code="common.imposbl.fileupload" />
										</div>			

										<script type="text/javascript">
										var existFileNum = document.frm.fileListCnt.value;
										var maxFileNum = 3;
										
										if (existFileNum=="undefined" || existFileNum ==null) {
											existFileNum = 0;
										}
										var uploadableFileNum = maxFileNum - existFileNum;
										if (uploadableFileNum<0) {
											uploadableFileNum = 0;
										}
										if (uploadableFileNum != 0) {
											fn_egov_check_file('Y');
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum , 'write_input');
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										} else {
											fn_egov_check_file('N');
										}
										</script>
									</th>
								</tr>							
							</thead>
							<tbody>
								<tr>
									<td colspan="2">
										<textarea rows="9" cols="100" name="bcCn" id="bcCn"><c:out value="${result.bcCn}" escapeXml="false"/></textarea>
										<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'bcCn';
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
							<a href="javascript:cancel();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
