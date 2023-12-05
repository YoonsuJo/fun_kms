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
<validator:javascript formName="commMail" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function sendMail() {
	document.mail.mailCn.value = myeditor.outputBodyHTML();
	if (!validateCommMail(document.mail)) {
		return;
	}
	if (confirm('<spring:message code="common.send.msg" />')) {
		document.mail.isSend.value = "Y";
		document.mail.action = "<c:url value='${rootPath}/community/sendMail.do'/>";
		document.mail.submit();					
	}
}
function saveMail() {
	document.mail.mailCn.value = myeditor.outputBodyHTML();
	if (!validateCommMail(document.mail)) {
		return;
	}
	if (confirm('<spring:message code="common.save.msg" />')) {
		document.mail.isSend.value = "N";
		document.mail.action = "<c:url value='${rootPath}/community/sendMail.do'/>";
		document.mail.submit();					
	}
}
function deleteMail() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.mail.action = "<c:url value='${rootPath}/community/deleteSendMailList.do'/>";
		document.mail.submit();					
	}
}
function cancelMail() {
	history.back();
}
function fn_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "block";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "block";
	}
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
				<div id="center" style="padding-bottom:80px">
					<div class="path_navi">
						<ul>
							<li class="stitle">사내메일 작성</li>
							<li class="navi">홈 > 커뮤니티 > 사내메일 > 작성하기</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 게시판 시작  -->
						<form:form commandName="commMail" name="mail" method="post" enctype="multipart/form-data" >
						<c:if test="${boolSavedMail == 'true'}"> 
							<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/community/forwardMail.do?${mailId}'/>"/>
						</c:if>
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input name="isSend" type="hidden" />
		                <c:if test="${result.isSend == 'N'}">
						<input name="mailId" type="hidden" value="${result.mailId}"/>
						</c:if>
						
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="사내메일을 작성합니다.">
		                    <caption>사내메일 작성</caption>
		                    <colgroup>
		                    	<col class="col100" />
		                    	<col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                        <th class="write_info">제목</th>
			                        <th class="write_info2"><input type="text" class="write_input" name="mailSj"
			                        <c:choose>
			                        	<c:when test="${result.isSend == 'N'}">value='<c:out value="${result.mailSj}" escapeXml="false" />'</c:when>
			                        	<c:when test="${reply == 'Y'}">value='<c:out value="RE: ${orgMailSj}" escapeXml="false" />'</c:when>
			                        	<c:when test="${forward == 'Y'}">value='<c:out value="FW: ${orgMailSj}" escapeXml="false" />'</c:when>
			                        </c:choose>
			                        />
			                        </th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">받는사람</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="write_input userNamesAuto userValidateCheck span_23" name="recieverList" id="recieverList"
			                    		<c:choose>
			                    			<c:when test="${reply == 'Y' || result.isSend == 'N'}">value='<c:out value="${result.recieverList}" escapeXml="false" />'</c:when> 
			                    			<c:when test="${not empty searchVO.recieverNo}">value="${searchVO.recieverNm}(${searchVO.recieverId})"</c:when>
			                    		</c:choose>
			                    		/>
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recieverList',0);">
			                    	</th>
		                        </tr>
		                        <!--
		                         <tr>
			                    	<th class="write_info">SMS 전송</th>
			                    	<th class="write_info2">
				                    	<label>
					                    	<input type="checkbox" name="smsSend" id="smsSend" value="Y" <c:if test="${result.smsSend == 'Y'}">checked="checked"</c:if>/> 
					                    	문자메시지로 메일 도착을 알려줍니다.<br>문자나라 서버가 응답하지 않는 경우 전송실패 상태가 됩니다.-->
<!-- 안내 : 문자나라 서버가 응답하지 않는 경우 문자 발송이 안되며 오류페이지가 나올 수 있습니다.-->
				                    	<!--</label>
			                    	</th>			                    	
		                        </tr>-->
<!-- //2013.08.20 김대현 PUSH 적용  -->
		                         <tr>
			                    	<th class="write_info">PUSH 전송</th>
			                    	<th class="write_info2">
				                    	<label>
					                    	<input type="checkbox" name="pushSend" id="pushSend" value="Y" <c:if test="${result.pushSend == 'Y'}">checked="checked"</c:if>/> 
					                    	PUSH로 메일 도착을 알려줍니다.
				                    	</label>
			                    	</th>			                    	
		                        </tr>
		                        		                        
		                        <tr>
			                    	<th class="write_info">첨부파일</th>
			                    	<th class="write_info2">
			                    		<c:choose>
			                    			<c:when test="${forward == 'Y' || result.isSend == 'N'}">
												<c:if test="${not empty result.atchFileId}">												
													<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
														<c:param name="param_atchFileId" value="${result.atchFileId}" />
													</c:import>
												</c:if>	
												<c:if test="${result.atchFileId == ''}">
													<input type="hidden" name="fileListCnt" value="0" />
												</c:if>
												<div id="file_upload_posbl"  style="display:none;" >	
													<input name="file_1" id="fileUploader" type="file" class="write_input"/>
													<div id="fileList"></div>
												</div>
												<div id="file_upload_imposbl"  style="display:none;" >
													<spring:message code="common.imposbl.fileupload" />
												</div>		    
															   	
												<script type="text/javascript">
												var existFileNum = document.mail.fileListCnt.value;
												if (existFileNum=="undefined" || existFileNum ==null) {
													existFileNum = 0;
												}
												var maxFileNum = 3;
												var uploadableFileNum = maxFileNum - existFileNum;
												if (uploadableFileNum < 0) {
													uploadableFileNum = 0;
												}				
												if (uploadableFileNum != 0) {
													fn_check_file('Y');
													var multi_selector = new MultiSelector( document.getElementById( 'fileList' ), uploadableFileNum ,'write_input');
													multi_selector.addElement( document.getElementById( 'fileUploader' ) );
												} else {
													fn_check_file('N');
												}			
												</script>
			                    			</c:when>
			                    			<c:otherwise>
												<input name="file_1" id="fileUploader" type="file" class="write_input"/>
												<div id="fileList"></div>
												<script type="text/javascript">
													var maxFileNum = 3;
													var multi_selector = new MultiSelector( document.getElementById( 'fileList' ), maxFileNum ,'write_input');
													multi_selector.addElement( document.getElementById( 'fileUploader' ) );
												</script>
			                    			</c:otherwise>
			                    		</c:choose>
			                    		<span>※ 첨부파일의 최대 용량은 70MB입니다.</span>
			                    	</th>
		                        </tr>	                        
		                    </thead>
		                    <tbody>
		                    	<tr>
			                    	<td colspan="2">
			                    		<textarea rows="9" cols="100" name="mailCn" id="mailCn">
			                    		<c:choose>
				                    		<c:when test="${result.isSend == 'N'}"><c:out value="${result.mailCn}" escapeXml="false" /></c:when>
				                    		<c:when test="${reply == 'Y' || forward == 'Y'}">
				                    			<c:out
				                    				value="<br/><br/>========== 원본 메시지 ==========<br/>보낸사람: ${orgSenderNm}(${orgSenderId})
				                    				<br/>받는사람: ${orgReceiverList}<br/>송신일시: ${orgSendDt}<br/>제목: ${orgMailSj}<br/><br/>${orgMailCn}"
				                    				escapeXml="false"
				                    			/>
				                    		</c:when>
			                    		</c:choose>
			                    		</textarea>
			                    		<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'mailCn';
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
		                	<a href="javascript:sendMail();"><img src="${imagePath}/btn/btn_send.gif"/></a>
		                	<a href="javascript:saveMail();"><img src="${imagePath}/btn/btn_save.gif"/></a>
		                	<c:if test="${result.isSend == 'N'}">
			                	<a href="javascript:deleteMail();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
		                	</c:if>
		                	<a href="javascript:cancelMail();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
