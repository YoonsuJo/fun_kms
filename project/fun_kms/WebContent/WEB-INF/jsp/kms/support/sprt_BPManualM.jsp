<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
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
function fn_egov_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "";
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
			                        	<input type="button" id="btn_insertGubun" value="업무구분 등록"/>
			                        </th>
			                    </tr>
		                        <tr>
			                    	<th class="write_info">업무절차</th>
			                    	<th class="write_info2">
										<c:if test="${not empty result.atchFileId}">
											<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.atchFileId}" />
											</c:import>
										</c:if>	
										<c:if test="${empty result.atchFileId}">
											<input type="hidden" name="fileListCnt" value="0" />
										</c:if>
										<div id="file_upload_posb"  style="display:none;" >	
											<input type="file" name="file_1" id="egovComFileUploader" class="write_input"/>
											<div id="egovComFileList"></div>
										</div>
										<div id="file_upload_imposb"  style="display:none;" >
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