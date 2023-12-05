<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>
<script>
$(document).ready(function() {
	$('#writeB').hide();
	$('#insertB').hide();
	$('#modifyB').hide();
	$('#updateB').show();
	$('#deleteB').hide();
	$('#recoverB').hide();
	$('#cancelB').show();
});
</script>
				<input type="hidden" name="titleNo" value="${result.titleNo }"/>
				<input type="hidden" name="posblAtchFileNumber" value="5" />
				<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/support/ruleL.do?titleNo=${result.titleNo }'/>"/>
					<div class="boardWrite" style="margin:0;">
					<table cellpadding="0" cellspacing="0" summary="토론게시판 게시물 작성페이지입니다.">
	                <caption>토론게시판 게시물 작성</caption>
	                <colgroup>
		            	<col class="col100" />
		            	<col width="px" />
		            </colgroup>
	                <thead>
		                <tr>
			            	<th class="write_info">제목</th>
			            	<th class="write_info2"><input type="text" class="write_input07" name="sj" value="${result.sj }"/></th>
			            </tr>
			            <tr>
				            <th class="write_info">첨부파일</th>
				            <th class="write_info2">
							<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${result.atchFileId}" />
							</c:import>
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
							var existFileNum = document.rule.fileListCnt.value;	    
							var maxFileNum = document.rule.posblAtchFileNumber.value;
							
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
						</th>
	                </tr>	                        
	                </thead>
	                <tbody>
		                <tr>
				            <td colspan="2">
				            <textarea rows="9" cols="100" name="cn" id="cn">${result.cn }</textarea>
				            <script type="text/javascript" language="javascript">
								var myeditor = new cheditor();
								myeditor.config.editorHeight = '400px';
								myeditor.config.editorWidth = '100%';
								myeditor.inputForm = 'cn';
								myeditor.run();
							</script>
				            </td>
		                </tr>
	                </tbody>
	            	</table>
					</div>