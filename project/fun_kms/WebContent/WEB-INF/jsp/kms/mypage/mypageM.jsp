<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="MyMenu" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function update() {
	if (!validateMyMenu(document.frm)) {
		return;
	}
	document.frm.action = '<c:url value="${rootPath}/mypage/updateMymenu.do" />';
	document.frm.submit();
}
function del() {
	if (confirm("삭제하시겠습니까?")) {
		document.frm.action = '<c:url value="${rootPath}/mypage/deleteMymenu.do" />';
		document.frm.submit();
	}
}
function list() {
	document.frm.action = '<c:url value="${rootPath}/mypage/MymenuList.do" />';
	document.frm.submit();
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
						<li class="stitle">나의메뉴</li>
						<li class="navi">홈 > 인사정보</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
					<form:form commandName="MyMenu" name="frm" method="POST">
						<input type="hidden" name="no" value="${result.no}" />
						<!-- 게시판 시작  -->
						<p class="th_stitle">나의메뉴 수정</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공통코드</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">제목</td>
			                    	<td class="pL10" ><input type="text" name="menuSj" value="${result.menuSj}" class="span_23" /></td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">URL</td>
			                    	<td class="pL10" ><input type="text" name="linkUrl" value="${result.linkUrl}" class="span_23" /></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
					</form:form>
						
					<!-- 버튼 시작 -->
	                <div class="btn_area">
	                	<a href="javascript:update();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
	                	<a href="javascript:del();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
	                	<a href="javascript:list();"><img src="${imagePath}/btn/btn_list.gif"/></a>
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
