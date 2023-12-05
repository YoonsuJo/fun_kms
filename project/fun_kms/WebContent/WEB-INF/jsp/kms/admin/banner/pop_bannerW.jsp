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
	document.frm.action = "<c:url value='${rootPath}/admin/banner/insertBanner.do'/>";
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
 	<div id="pop_con06">
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col120" /><col width="px" /></colgroup>
 			<tbody>
				<tr>
					<td class="subtitle">제목</td>
					<td class="subtitle2"><input type="text" name="bnrSj" class="span_12" /></td>
				</tr>
				<tr>
					<td class="subtitle" >링크페이지 URL</td>
					<td class="subtitle2"><input type="text" name="linkUrl" class="span_12" /></td>
				</tr>
				<tr>
					<td class="subtitle" >이미지</td>
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
					<td class="subtitle">팝업여부</td>
					<td class="subtitle2">
						<input type="radio" name="popYn" value="Y"/> 예
						<input type="radio" name="popYn" value="N" /> 아니오
					</td>
				</tr>
				<tr>
					<td class="subtitle">팝업사이즈</td>
					<td class="subtitle2">
						가로 : <input type="text" name="popWidth" class="span_1"/> px
						<span class="pL20"></span>
						세로 : <input type="text" name="popHeight" class="span_1"/> px
					</td>
				</tr>
				<tr>
					<td class="subtitle" >사용여부</td>
					<td class="subtitle2">
					<input type="radio" name="useAt" value="Y" /> 예
					<input type="radio" name="useAt" value="N" /> 아니오
					</td>
				</tr>
				<tr>
					<td class="subtitle" >게시기간</td>
					<td class="subtitle2">
						<input type="text" name="ntceSdt" class="calGen" maxlength="8" /> ~ <input type="text" name="ntceEdt" class="calGen" maxlength="8" />
					</td>
				</tr>
				<tr>
					<td class="subtitle">설명</td>
					<td class="subtitle2">
						<textarea name="bnrCn" class="span_12 height_35"></textarea>					
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
