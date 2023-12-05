<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

<c:if test="${type == 'head'}">
<script>
//덧글 새로 인서트
function commentRegister() {
	if(document.commentFrm.cn.value == ""){
		alert('덧글 내용을 입력하세요.');
		return;
	}
	document.commentFrm.action = "${rootPath}/cooperation/insertConsultComment.do";
	document.commentFrm.submit();
}

//덧글 수정
function commentUpdateView(no) {
	document.commentFrm.no.value = no;
	
	$.post("${rootPath}/cooperation/updateConsultCommentView.do?type=body", $("#commentFrm").serialize(),
		function(data){
			$('#commentArea').html(data);
			document.commentFrm.cn.focus();
		}
	);
}
//덧글 업데이트
function commentUpdate() {
	document.commentFrm.action = "${rootPath}/cooperation/updateConsultComment.do";
	document.commentFrm.submit();
}
//덧글 삭제
function commentDelete(no) { 
	if (confirm('<spring:message code="common.delete.msg" />')) {
		$.post("${rootPath}/cooperation/deleteConsultComment.do?consult_no=${searchVO.consult_no}&useAt=N&no=" + no,
			function(data){
				$('#commentArea').html(data);
			}
		);
	}
}

</script>
</c:if>

<c:if test="${type == 'body' || type == 'pop'}">

<c:if test="${fn:length(resultList) != 0}">
<div class="replyL mT20">
	<!-- <p class="th_stitle">처리 내용</p> -->
	
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
					<print:textarea text="${result.cn}" />
					<c:if test="${not empty result.atchFileId}">
					<p style="margin-top:10px;">
					<c:import url="/selectFileInfs.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" value="${result.atchFileId}" />
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

<c:if test="${type != 'pop'}">
<div class="replyW mT20">
	<form id="commentFrm" name="commentFrm" method="POST" enctype="multipart/form-data">
	<%-- <input type="hidden" name="bcId" value="${searchVO.bcId}"/>--%>
	<input type="hidden" name="consult_no" value="${searchVO.consult_no}"/>
	<input type="hidden" name="no" value="${commentVO.no}"/>
	<input type="hidden" name="commentNo" value="${commentVO.no}"/>
	<input type="hidden" name="returnUrl" value="${rootPath}/cooperation/selectConsultManage.do"/>
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>댓글달기</caption>
		<colgroup>
			<col class="col100" />
			<col width="px" />
			<col class="col80" />
		</colgroup>
		<tr>
			<td class="writer">
				<print:user userNo="${user.userNo}" userNm="${user.userNm}" userId="${user.userId}" printId="false"/>
			</td>
			<td class="pL10 pT5 pB5">
				<textarea name="cn" class="textarea height_70" cols="50" rows="6" ><c:out value="${commentVO.cn}" escapeXml="false"/></textarea>
			</td>
			<td class="last pL10">
				<c:choose>
					<c:when test="${empty commentVO.cn || commentVO.cn == ''}">
						<a href="javascript:commentRegister();"><img src="${imagePath}/btn/btn_regist02.gif"/></a>
					</c:when>
					<c:otherwise>
						<a href="javascript:commentUpdate();"><img src="${imagePath}/btn/btn_modify02.gif"/></a>
					</c:otherwise>
				</c:choose>
				<!-- 댓글등록시 화살표 
				<ul class="arrow">
					<li><img src="${imagePath}/btn/btn_arrow_top.gif" onClick="javascript:fn_egov_resize_commentCn('up');"/></li>
					<li class="dotline"></li>
					<li><img src="${imagePath}/btn/btn_arrow_down.gif" onClick="javascript:fn_egov_resize_commentCn('down');"/></li>
				</ul>
				-->
			</td>
		</tr>
		<tr>
			<td class="writer last">첨부파일</td>
			<td class="pL10 last" colspan="2">
				<c:choose>
					<c:when test="${empty commentVO}">
						<input name="file_1" id="egovComFileUploader" type="file" class="span_95p"/>
						<div id="egovComFileList"></div>
						<script type="text/javascript">
							var maxFileNum = 1;
							var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum ,'write_input');
							multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
						</script>
					</c:when>
					<c:otherwise>
						<c:if test="${not empty commentVO.atchFileId}">
							<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${commentVO.atchFileId}" />
							</c:import>
						</c:if>	
						<c:if test="${commentVO.atchFileId == ''}">
							<input type="hidden" name="fileListCnt" value="0" />
						</c:if>
						<div id="file_upload_posbl"  style="display:none;" >	
							<input name="file_1" id="egovComFileUploader" type="file" class="span_95p"/>
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
</c:if>