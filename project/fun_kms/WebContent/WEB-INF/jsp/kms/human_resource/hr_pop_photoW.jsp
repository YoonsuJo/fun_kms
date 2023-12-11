<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<link rel="stylesheet" href="${commonPath}/css/admin_default.css" type="text/css" media="all" />
<script type="text/javascript" src="<c:url value='${commonPath}/js/adminMultiFile.js'/>" ></script>
<script>
function fn_egov_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "";
	}
}
function upload() {
	document.frm.submit();
}
</script>
</head>

<body onload="opener.location.reload();">
<div id="pop_file">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/admin/inc/pop_bullet.gif" /></li>
			<li class="popTitle">${commandMap.title}</li>
		</ul>
 	</div>
 	
 	<div id="pop_file_con">
 		<form name="frm" method="POST" enctype="multipart/form-data" action="<c:url value='${rootpath}/member/uploadPhoto.do' />">
		<input type="hidden" name="no" value="<c:out value="${commandMap.no}" />"/>
		<input type="hidden" name="picTyp" value="<c:out value="${commandMap.picTyp}" />"/>
		<input type="hidden" name="fileListCnt" value="<c:out value="${commandMap.fileListCnt}" />"/>
		<input type="hidden" name="returnUrl" value="<c:url value="${rootPath}/member/popPhoto.do" />"/>
 		<ul>
 			<li>
	 			<c:if test="${not empty commandMap.picId}">
					<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" value="${commandMap.picId}" />
					</c:import>
				</c:if>	
				<c:if test="${commandMap.picId == ''}">
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
 			</li>
 			<li class="file_btn"><a href="javascript:upload();"><img src="${imagePath}/admin/btn/btn_regist.gif"/></a></li>
 		</ul>
 		</form>
 	</div>
</div>

</body>
</html>
