<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="MyMenu" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
if ("${retMessage}" == "success") {
	opener.location.reload();
}

function saveMenu() {
	document.fm.action = '<c:url value="${rootPath}/menu/saveMenu.do" />';
	document.fm.submit();
}
function popClose() {
	this.close();
}
</script>
</head>

<body>
<div id="pop_reg_div01">
 	<div id="pop_top">
		<ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">메뉴 등록</li>
		</ul>
 	</div>
	<!-- S: section -->
	<div class="pop_reg_div02">
			
		<!-- 게시판 시작  -->						
		<p class="th_stitle">메뉴 정보</p>
		<div class="boardWrite02 mB20">
		<form:form name="fm" method="POST" action="${rootPath}/menu/insertMenu.do">
			<input type="hidden" name="no" id="no" value="${mVO.no}"/>
			<input type="hidden" name="orgnztId" id=orgnztId value="${mVO.orgnztId}"/>
			<input type="hidden" name="type" id=type value="${mVO.type}"/>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col120" />
					<col width="px" />
				</colgroup>
				<tbody>
					<tr> 
						<td class="title">제목</td>
						<td class="pL10" ><input type="text" name="title" class="span_23" value="${mVO.title}" /></td>
					</tr>
					<tr>
						<td class="title">URL</td>
						<td class="pL10" ><input type="text" name="url" class="span_23" value="${mVO.url}" /></td>
					</tr>
				</tbody>
			</table>
		</form:form>
		</div>
			<!-- 게시판 끝  -->
			
		<!-- 버튼 시작 -->
			<div class="btn_area">
				<a href="javascript:saveMenu();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
			<a href="javascript:popClose();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
			</div>
			<!-- 버튼 끝 -->
</body>
</html>
