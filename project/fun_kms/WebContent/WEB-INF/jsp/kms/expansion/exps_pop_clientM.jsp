<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>(주)도전하는사람들 한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="ConsultClient" staticJavascript="false"	xhtml="true" cdata="false" />
<script type="text/javascript">
function customerUpdate() {
	if (!validateConsultClient(document.frm)) {
		return;
	}
	
	// ValidEmail
	var email = document.frm.custEmail.value;
	if (email.length > 0) {
		if (!isValidEmail(document.frm.custEmail.value)) {
			alert('유효하지 않은 이메일입니다.');
			return;
		}
	}
	
	document.frm.action = "<c:url value='${rootPath}/cooperation/updateClient.do'/>";
	document.frm.submit();
}
</script>
</head>

<body>
	<div id="pop_regist07">
	<div id="pop_top">
		 <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">고객사 수정</li>
		</ul>
	</div>
	<div class="pop_con14">
		
		<div class="pop_board mB20">
		<form:form commandName="frm" name="frm" method="post">
		<input type="hidden" name="no" value="${result.no}"/>
		<table cellpadding="0" cellspacing="0">
			<colgroup>
				<col class="col100" />
				<col width="px"/>
			</colgroup>
			<tbody>
				<tr>
					<td class="title" >고 객 사(*)</td>
					<td class="pL10">
						<input type="text" name="custNm" class="input01 span_12" value="${result.custNm}"/>
					</td>
				</tr>
				<tr>
					<td class="title" >고 객 명(*)</td>
					<td class="pL10">
						<input type="text" name="custManager" class="input01 span_12" value="${result.custManager}"/>
					</td>
				</tr>
				<tr>
					<td class="title" >연 락 처(*)</td>
					<td class="pL10">
						<input type="text" name="custTelno" class="input01 span_12" value="${result.custTelno}"/>
					</td>
				</tr>
				<tr>
					<td class="title" >이 메 일</td>
					<td class="pL10">
						<input type="text" name="custEmail" class="input01 span_12" value="${result.custEmail}"/>
					</td>
				</tr>
				<tr>
					<td class="title" >기타정보</td>
					<td class="pL10">
						<textarea name="etcInfo" class="height_130" style="width:390px;">${result.etcInfo}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		</form:form>
		</div>
		
		<div class="pop_btn_area">
			<a href="javascript:customerUpdate()"><img src="${imagePath}/btn/btn_regist.gif" alt="등록"/></a>
			<img src="${imagePath}/btn/btn_close.gif" alt="창닫기" class="cursorPointer" onclick="window.close();">
		</div>
		
	</div>
</div>

</body>
</html>
