<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

<c:if test="${type == 'head'}">
<script>
function commentRegister() {
	if(document.commentFrm.mtCommentCn.value == ""){
		alert('덧글 내용을 입력하세요.');
		return;
	}
	document.commentFrm.action = "${rootPath}/cooperation/insertMeetingRoomComment.do";
	document.commentFrm.submit();
}
function commentUpdateView(no) {
	document.commentFrm.no.value = no;
	
	$.post("${rootPath}/cooperation/updateMeetingRoomCommentView.do?type=body", $("#commentFrm").serialize(),
		function(data){
			$('#commentArea').html(data);
			document.commentFrm.mtCommentCn.focus();
		}
	);
}
function commentUpdate() {
	document.commentFrm.action = "${rootPath}/cooperation/updateMeetingRoomComment.do";
	document.commentFrm.submit();
}
function commentDelete(no) {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		$.post("${rootPath}/cooperation/deleteMeetingRoomComment.do?mtId=${searchVO.mtId}&useAt=N&no=" + no,
			function(data){
				$('#commentArea').html(data);
			}
		);
	}
}
</script>
</c:if>

<c:if test="${type == 'body'}">

<!-- 20130827 변경 -->
<c:if test="${printIncComment != 'on'}">
	<div class="replyW mT20">
		<form id="commentFrm" name="commentFrm" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="mtId" value="${searchVO.mtId}"/>
		<input type="hidden" name="no" value="${mtComment.no}"/>
		<input type="hidden" name="commentNo" value="${mtComment.no}"/>
		<input type="hidden" name="returnUrl" value="${rootPath}/cooperation/selectMeetingRoom.do"/>
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			<caption>댓글달기</caption>
			<colgroup>
				<col class="col100" />
				<col width="px" />
				<col class="col80" />
			</colgroup>
			<tr>
				<td class="writer"><print:user userNo="${user.userNo}" userNm="${user.userNm}" userId="${user.userId}" printId="false"/></td>
				<td class="pL10 pT5 pB5"><textarea name="mtCommentCn" class="textarea height_70" rows="6" cols="85"><c:out value="${mtComment.mtCommentCn}" escapeXml="false"/></textarea></td>
				<td class="last">
					<div class="pL10 mB10" >
					<c:choose>
						<c:when test="${empty mtComment.mtCommentCn || mtComment.mtCommentCn == ''}">
							<a href="javascript:commentRegister();"><img src="${imagePath}/btn/btn_regist02.gif"/></a>
						</c:when>
						<c:otherwise>
							<a href="javascript:commentUpdate();"><img src="${imagePath}/btn/btn_modify02.gif"/></a>
						</c:otherwise>
					</c:choose>
					</div>
					<label>
						<input type="checkbox" name="push_yn" value="Y"> PUSH 전송
					</label>
				</td>
			</tr>
			<tr>
				<td class="writer last">첨부파일</td>
				<td class="pL10 last" colspan="2">
					<c:choose>
						<c:when test="${empty mtComment}">
							<input name="file_1" id="egovComFileUploader" type="file" class="write_input"/>
							<div id="egovComFileList"></div>
							<script type="text/javascript">
								var maxFileNum = 1;
								var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum ,'write_input');
								multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
							</script>
						</c:when>
						<c:otherwise>
							<c:if test="${not empty mtComment.attachFileId}">
								<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${mtComment.attachFileId}" />
								</c:import>
							</c:if>	
							<c:if test="${mtComment.attachFileId == ''}">
								<input type="hidden" name="fileListCnt" value="0" />
							</c:if>
							<div id="file_upload_posbl"  style="display:none;" >	
								<input name="file_1" id="egovComFileUploader" type="file" class="write_input"/>
								<div id="egovComFileList"></div>
							</div>
							<div id="file_upload_imposbl"  style="display:none;" >
								<spring:message code="common.imposbl.fileupload" />
							</div>		    
			
							<script type="text/javascript">
								var existFileNum = document.commentFrm.fileListCnt.value;
								var maxFileNum = 1;
								
								if (existFileNum=="undefined" || existFileNum ==null) {
									existFileNum = 0;
								}
								var uploadableFileNum = maxFileNum - existFileNum;
								if (uploadableFileNum<0) {
									uploadableFileNum = 0;
								}
								if (uploadableFileNum != 0) {
									fn_egov_check_file('Y');
									var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum ,'write_input');
									multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
								} else {
									fn_egov_check_file('N');
								}
							</script>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
		</form>
	</div>
</c:if>

<c:if test="${fn:length(resultList) != 0}">
	<div class="replyL mT20">
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			<caption>댓글보기</caption>
			<colgroup>
			<col class="col100" />
			<col width="px" />
			<col class="col150" />
			</colgroup>
			<c:forEach items="${resultList}" var="result">
				<tr>
					<td class="writer"><print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}" printId="false"/></td>
					<td class="txt">
				
						<!--<c:out value="${result.mtCommentCnPrint}" escapeXml="false"/>-->
						<print:textarea text="${result.mtCommentCnPrint}"/>
						<c:if test="${not empty result.attachFileId}">
						<p style="margin-top:10px;">
						<c:import url="/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${result.attachFileId}" />
							<c:param name="param_isComment" value="true" />
						</c:import>
						</p>
						</c:if>
					</td>
					<td class="date">${result.udtDt}
						<c:if test="${result.userNo == user.no}">
						<span class="btn_plus">
							<a href="javascript:commentUpdateView('${result.no}');"><img src="${imagePath}/btn/btn_plus02.gif" /></a>
							<a href="javascript:commentDelete('${result.no}');"><img src="${imagePath}/btn/btn_minus02.gif" /></a>
						</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</c:if>
</c:if>