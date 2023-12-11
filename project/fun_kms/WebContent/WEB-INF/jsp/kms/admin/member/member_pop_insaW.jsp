<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/adminMultiFile.js'/>" ></script>
<script>
function upload() {
	document.frm.submit();
}
</script>
</head>

<body onload="opener.location.reload();">
<div id="pop_file02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/admin/inc/pop_bullet.gif" /></li>
			<li class="popTitle">인사정보파일등록</li>
		</ul>
 	</div>
 	
 	<div id="pop_con05">
 		<form name="frm" method="POST" enctype="multipart/form-data" action="<c:url value='${rootpath}/admin/member/uploadInsa.do' />">
		<input type="hidden" name="userNo" value="<c:out value="${commandMap.no}" />"/>
		<input type="hidden" name="returnUrl" value="<c:url value="${rootPath}/admin/member/popInsa.do" />"/>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col80" /><col width="px"/></colgroup>
 			<tbody>
				<tr>
					<td class="subtitle">종류</td>
					<td class="subtitle2">
						<input type="text" name="fileTyp"/>
					</td>
				</tr>
				<tr>
					<td class="subtitle" >첨부파일</td>
					<td class="subtitle2">
						<input name="file_1" id="egovComFileUploader" type="file"/>
						<div id="egovComFileList"></div>
						<script type="text/javascript">
							var maxFileNum = 1;
							var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
							multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
						</script>
					</td>
				</tr>
				<tr>
					<td class="subtitle">비고</td>
					<td class="subtitle2" >
						<input type="text" name="note"/>
					</td>
				</tr> 
 			</tbody>
 		</table>
		</form>
		
 	    <div class="pop_btn_area">
 	    	<a href="javascript:upload();"><img src="${imagePath}/admin/btn/btn_regist.gif"/></a>
        </div>
	</div>
</div>
</body>
</html>
