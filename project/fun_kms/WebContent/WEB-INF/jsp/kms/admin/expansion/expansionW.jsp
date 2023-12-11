<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="Expansion" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if (!validateExpansion(document.frm)) {
		return;
	}
	document.frm.submit();					
}
function listArticle() {
	document.frm.action = "<c:url value='${rootPath}/admin/expansion/selectExpansionList.do'/>";
	document.frm.submit();
}
function selRadio(obj) {
	var usrList = document.getElementById("usrList");
	var usrTree = document.getElementById("usrTree");
	
	if (obj.value == "A") {
		usrList.disabled = true;
		usrTree.className = "";
		usrTree.onclick = "";
	}
	else if (obj.value == "L") {
		usrList.disabled = false;
		usrTree.className = "cursorPointer";
		usrTree.onclick = new Function("usrGen('usrList',0);");
	}
}
</script>
</head>

<body>
<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">확장기능 등록</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<form:form commandName="Expansion" name="frm" method="POST" action="${rootPath}/admin/expansion/insertExpansion.do" enctype="multipart/form-data">
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>확장기능 등록</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">제목</td>
			                    	<td class="pL10"><input type="text" name="expSj" class="span_22" /></td>
		                    	</tr>
								<tr>
								    <td class="title">아이콘</td>
									<td class="pL10">
										<input name="file_1" id="egovComFileUploader" type="file" class="write_input"/>
										<div id="egovComFileList"></div>
										<script type="text/javascript">
											var maxFileNum = 1;
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										</script>
									</td>
 								</tr>
 								<tr>
								    <td class="title">설명</td>
									<td class="pL10 pT5 pB5">
										<textarea name="expCn" id="expCn" class="span_23 height_35"></textarea>
									</td>
 								</tr>
 								<tr>
								    <td class="title">URL</td>
									<td class="pL10">
										<input type="text" name="linkUrl" class="span_22" />
									</td>
 								</tr>
 								<tr>
								    <td class="title">팝업여부</td>
									<td class="pL10">
										<label><input type="radio" name="popYn" value="Y" checked="checked"> 사용</label>
										<label><input type="radio" name="popYn" value="N"> 사용안함</label>
									</td>
 								</tr> 
								<tr>
									<td class="title">팝업사이즈</td>
									<td class="pL10">
										가로 : <input type="text" name="popWidth" class="span_1"/> px
										<span class="pL20"></span>
										세로 : <input type="text" name="popHeight" class="span_1"/> px
										<span class="pL20">** 팝업여부가 [사용]일 때만 유효</span>
									</td>
								</tr>
 								<tr>
								    <td class="title">사용여부</td>
									<td class="pL10">
										<label><input type="radio" name="useAt" value="Y" checked="checked"> 사용</label>
										<label><input type="radio" name="useAt" value="N"> 사용안함</label>
									</td>
 								</tr> 
 								<tr>
								    <td class="title" rowspan="2">접근권한</td>
									<td class="pL10">
										<label><input type="radio" name="access" value="A" onclick="selRadio(this);" checked="checked" /> 누구나 접근</label> 
										<label><input type="radio" name="access" value="L" onclick="selRadio(this);" /> 허용된 사용자만 접근</label>
									</td>
 								</tr>
 								<tr>
									<td class="pL10">
										<input type="text" name="accessUser" id="usrList" class="span_22 userNamesAuto userValidateCheck" disabled="disabled"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="usrTree" />
									</td>
 								</tr>                       	
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						</form:form>
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		                	<a href="javascript:listArticle();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->						
						
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
