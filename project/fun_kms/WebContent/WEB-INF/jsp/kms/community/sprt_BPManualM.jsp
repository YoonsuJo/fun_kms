<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod2.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<script>
$(function(){
	$('#btn_modify').click(function(){
		if($('#subject').val() == ""){
			alert("제목은 필수 입력값입니다.");
			$('#subject').focus();
			return false;
		}
		if($('#gubunNo').val() == ""){
			alert("업무구분은 필수 입력값입니다.");
			$('#gubunNo').focus();
			return false;
		}
		document.frm.content.value = myeditor.outputBodyHTML();
		if($('#content').val() == ""){
			alert("내용은 필수 입력값입니다.");
			$('#content').focus();
			return false;
		}
		
		$('#frm').attr('action', '${rootPath}/support/bpManualModifyP.do');
		$('#frm').submit();
	});
	$('#btn_cancel').click(function(){
		$('#frm').attr('action', '${rootPath}/support/bpManualView.do');
		$('#frm').submit();
	});
	$('#btn_insertGubun').click(function(){
		var popup = window.open("${rootPath}/support/bpManualGubunList.do", "_GUBUN_ADD_POP_","width=560px,height=570px,scrollbars=yes");
		popup.focus();
	});
});
function fn_egov_check_file(flag, id) {
	if (flag=="Y") {
		$('#file_upload_posbl'+id).attr('style', 'display:block');
		$('#file_upload_imposbl'+id).attr('style', 'display:none');			
	} else {
		$('#file_upload_posbl'+id).attr('style', 'display:none');
		$('#file_upload_imposbl'+id).attr('style', 'display:block');
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
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">게시글 수정하기</li>
							<li class="navi">홈 > 업무지원 > 업무처리지원</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">
						<p class="th_stitle">업무처리절차</p>

						<!-- 게시판 시작  -->
						<form id="frm" name="frm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="bpmNo" value="${bpmVO.bpmNo}"/>
						<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/support/bpManualModify.do?ibpmNo=${bpmVO.bpmNo}'/>"/>
						
						<input type="hidden" id="cntFile1" name="cntFile1" value="0"/>
						<input type="hidden" id="cntFile2" name="cntFile2" value="0"/>
						
						<input type="hidden" id="fileSn" name="fileSn" >
						<input type="hidden" id="atchFileId" name="atchFileId" value="${atchFileId}">
						
						<input type="hidden" name="tempAtchFile1" value="${result.atchFileId2}">
						<input type="hidden" name="tempAtchFile2" value="${result.atchFileId}">
						
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
			                        <th class="write_info2"><input type="text" name="subject" class="write_input" value="${result.subject }"/></th>
		                        </tr>
		                        <tr>
		                        	<th class="write_info">상태</th>
			                    	<th class="write_info2">
			                    		<label><input type="radio" name="useStatus" value="Y" <c:if test="${result.useStatus == 'Y'}">checked="checked"</c:if>/>유효문서</label>
			                    		<label><input type="radio" name="useStatus" value="N" <c:if test="${result.useStatus == 'N'}">checked="checked"</c:if>/>무효문서</label>
			                    	</th>
		                        </tr>
		                        <tr>
		                        	<th class="write_info">업무 구분</th>
			                        <th class="write_info2">
			                        	<select id="gubunNo" name="gubunNo">
			                        		<option value="">-- 업무 구분 --</option>
			                        		<c:forEach items="${gubunList}" var="gubunList">
											<option value="${gubunList.gubunNo}" <c:if test="${gubunList.gubunNo == result.gubunNo}">selected</c:if>>${gubunList.gubunNm}</option>
											</c:forEach>
			                        	</select>
			                        	<img src="${imagePath}/btn/btn_registBpm.gif" class="cursorPointer" id="btn_insertGubun"/>
			                        </th>
			                    </tr>
		                        <tr>
			                    	<th class="write_info">업무절차</th>
			                    	<th class="write_info2">
			                    		
										<c:if test="${not empty result.atchFileId2}">
											<c:import url="${rootPath}/selectFileInfsForUpdate2.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.atchFileId2}" />
											</c:import>
										</c:if>	
										<c:if test="${empty result.atchFileId2}">
											<input type="hidden" id="fileListCnt_${result.atchFileId2}" name="fileListCnt" value="0" />
										</c:if>
										<div id="file_upload_posbl1"  style="display:none;" >	
											<input type="file" name="file_1" id="egovComFileUploader" class="write_input"/>
											<div id="egovComFileList"></div>
										</div>
										<div id="file_upload_imposbl1"  style="display:none;" >
											<spring:message code="common.imposbl.fileupload" />
										</div>
										<script type="text/javascript">
										var fileId = '${result.atchFileId2}';
										var existFileNum = $('#fileListCnt_'+fileId).val();
										var maxFileNum = 3;
										
										if (existFileNum=="undefined" || existFileNum ==null) {
											existFileNum = 0;
										}
										var uploadableFileNum = maxFileNum - existFileNum;
										if (uploadableFileNum<0) {
											uploadableFileNum = 0;
										}
										if (uploadableFileNum != 0) {
											fn_egov_check_file('Y', "1");
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum , 'write_input' , 1, 'cntFile2', 2);
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										} else {
											fn_egov_check_file('N', "1");
										}
										</script>
									</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">양식</th>
			                    	<th class="write_info2">
										<c:if test="${not empty result.atchFileId}">
											<c:import url="${rootPath}/selectFileInfsForUpdate2.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.atchFileId}" />
											</c:import>
										</c:if>	
										<c:if test="${empty result.atchFileId}">
											<input type="text" id="fileListCnt_${result.atchFileId}" name="fileListCnt" value="0" />
										</c:if>
										<div id="file_upload_posbl2"  style="display:none;" >	
											<input type="file" id="egovComFileUploader2" class="write_input"/>
											<div id="egovComFileList2"></div>
										</div>
										<div id="file_upload_imposbl2"  style="display:none;" >
											<spring:message code="common.imposbl.fileupload" />
										</div>
										<script type="text/javascript">
										var fileId2 = '${result.atchFileId}';
										var existFileNum2 = $('#fileListCnt_'+fileId2).val();
										var maxFileNum2 = 3;
										
										if (existFileNum2=="undefined" || existFileNum2 ==null) {
											existFileNum2 = 0;
										}
										var uploadableFileNum2 = maxFileNum2 - existFileNum2;
										if (uploadableFileNum2<0) {
											uploadableFileNum2 = 0;
										}
										if (uploadableFileNum2 != 0) {
											fn_egov_check_file('Y', "2");
											var multi_selector2 = new MultiSelector( document.getElementById( 'egovComFileList2' ), uploadableFileNum2 , 'write_input', 1, 'cntFile1', 1);
											multi_selector2.addElement( document.getElementById( 'egovComFileUploader2' ) );
										} else {
											fn_egov_check_file('N', "2");
										}
										</script>
										<span>※ 첨부파일의 최대 용량은 70MB입니다.<br>※ 첨부파일은 각각 최대 3개씩 첨부가능 합니다.</span>
									</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                    	<tr>
			                    	<td colspan="2">
			                    		<textarea rows="9" cols="100" name="content" id="content"><c:out value="${result.content}" escapeXml="false"/></textarea>
			                    		<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'content';
											myeditor.run();
										</script>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<img src="${imagePath}/btn/btn_modify.gif" class="cursorPointer" id="btn_modify"/>
		                	<img src="${imagePath}/btn/btn_cancel.gif" class="cursorPointer" id="btn_cancel"/>
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