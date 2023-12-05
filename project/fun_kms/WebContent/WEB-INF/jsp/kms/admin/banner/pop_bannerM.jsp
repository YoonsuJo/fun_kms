<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/adminMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="KmsBanner" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if(!validateKmsBanner(document.frm)) {
		return;
	}
	document.frm.action = "<c:url value='${rootPath}/admin/banner/updtBanner.do'/>";
	document.frm.submit();
}
</script>
</head>

<body><div id="pop_banner">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/admin/inc/pop_bullet.gif" /></li>
			<li class="popTitle">배너등록</li>
		</ul>
 	</div>
 	
	<form:form commandName="KmsBanner" name="frm" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="bnrId" value="${result.bnrId}" /> 
	<input type="hidden" name="returnUrl" value="${rootPath}/admin/banner/updtBannerView.do" /> 
	<input type="hidden" name="bnrFileId" value="${result.bnrFileId}" /> 
 	<div id="pop_con06">
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col120" /><col class="col180" /><col width="px"/></colgroup>
 			<tbody>
				<tr>
					<td class="subtitle">제목</td>
					<td class="subtitle2" colspan="2"><input type="text" name="bnrSj" class="span_12" value="<c:out value='${result.bnrSj}'/>" /></td>
				</tr>
				<tr>
					<td class="subtitle">링크페이지 URL</td>
					<td class="subtitle2" colspan="2"><input type="text" name="linkUrl" class="span_12" value="<c:out value='${result.linkUrl}'/>" /></td>
				</tr>
				<tr>
					<td class="subtitle">이미지</td>
					<td class="subtitle2" colspan="2">
						<c:if test="${not empty result.bnrFileId}">
							<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${result.bnrFileId}" />
							</c:import>
						</c:if>	
						<c:if test="${result.bnrFileId == ''}">
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
						var existFileNum = document.frm.fileListCnt.value;	    
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
							var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
							multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
						} else {
							fn_egov_check_file('N');
						}			
						</script>
					</td>
				</tr>
				<tr>
					<td class="subtitle">팝업여부</td>
					<td class="subtitle2">
						<input type="radio" name="popYn" value="Y" <c:if test="${result.popYn == 'Y'}" >checked="checked"</c:if> /> 예
						<input type="radio" name="popYn" value="N" <c:if test="${result.popYn == 'N'}" >checked="checked"</c:if> /> 아니오
					</td>
					<td class="bannerImg" rowspan="2" >
						<c:choose>
							<c:when test="${empty result.bnrFileId || result.bnrFileId == ''}">
								이미지없음
							</c:when>
							<c:otherwise>
								<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${result.bnrFileId}" />
								</c:import>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td class="subtitle">팝업사이즈</td>
					<td class="subtitle2" colspan="2">
						가로 : <input type="text" name="popWidth" class="span_1" value="<c:out value='${result.popWidth}'/>" />
						<span class="pL10"></span>
						세로 : <input type="text" name="popHeight" class="span_1" value="<c:out value='${result.popHeight}'/>" />
					</td>
				</tr>
				<tr>
					<td class="subtitle" >사용여부</td>
					<td class="subtitle2" colspan="2">
					<input type="radio" name="useAt" value="Y" <c:if test="${result.useAt == 'Y'}" >checked="checked"</c:if> /> 예
					<input type="radio" name="useAt" value="N" <c:if test="${result.useAt == 'N'}" >checked="checked"</c:if> /> 아니오
					</td>
				</tr>
				<tr>
					<td class="subtitle" >게시기간</td>
					<td class="subtitle2" colspan="2" >
						<input type="text" name="ntceSdt" class="calGen" maxlength="8" value="<c:out value='${result.ntceSdt}'/>" />
						~
						<input type="text" name="ntceEdt" class="calGen" maxlength="8" value="<c:out value='${result.ntceEdt}'/>" />
					</td>
				</tr>
				<tr>
					<td class="subtitle">설명</td>
					<td class="subtitle2" colspan="2" >
						<textarea name="bnrCn" class="span_12 height_35"><c:out value='${result.bnrCn}' escapeXml="false"/></textarea>					
					</td>
				</tr> 
 			</tbody>
 		</table>
 		
		<div class="pop_btn_area">
			<a href="javascript:register();"><img src="${imagePath}/admin/btn/btn_regist.gif"/></a>
            <a href="javascript:self.close();"><img src="${imagePath}/admin/btn/btn_cancel.gif"/></a>
		</div>
 	</div>
 	</form:form>
</div>

</body>
</html>
