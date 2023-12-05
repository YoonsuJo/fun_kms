<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>
<script>
$(document).ready(function() {
	$('#writeB').hide();
	$('#insertB').show();
	$('#modifyB').hide();
	$('#updateB').hide();
	$('#deleteB').hide();
	$('#recoverB').hide();
	$('#cancelB').show();
});
</script>
				<input type="hidden" name="posblAtchFileNumber" value="5" />
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
			            	<th class="write_info2"><input type="text" class="write_input07" name="sj" /></th>
			            </tr>
			            <tr>
				            <th class="write_info">첨부파일</th>
				            <th class="write_info2">
							<input name="file_1" id="egovComFileUploader" type="file" class="write_input07"/>
							<div id="egovComFileList"></div>
							<script type="text/javascript">
								var maxFileNum = document.rule.posblAtchFileNumber.value;
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
				            <textarea rows="9" cols="100" name="cn" id="cn"></textarea>
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