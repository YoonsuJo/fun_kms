<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
//고객사관리 수정화면이동
function modifyArticle(no) {
	document.frm.no.value = no;
	document.frm.action = "<c:url value='${rootPath}/cooperation/modifyClient.do'/>";
	document.frm.submit();
}
//고객사관리 삭제
function deleteArticle(no) {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.no.value = no;
		document.frm.action = "<c:url value='${rootPath}/cooperation/deleteClient.do'/>";
		document.frm.submit();
	}
}
//상담하기로 이동
function moveConsultArticle() {
	opener.frm.directConsult.value = 'Y';
	opener.frm.action = "<c:url value='${rootPath}/cooperation/writeConsultManage.do?directInsert=Y&no=${result.no}'/>";
	opener.frm.submit();
	window.close();
}
</script>
</head>

<body>
	<div id="pop_regist07">
	<div id="pop_top">
		 <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">고객사 상세보기</li>
		</ul>
	</div>
	<div class="pop_con14">
		
		<div class="pop_board mB20">
		<form:form commandName="frm" name="frm" method="post">
		<input type="hidden" name="no" />
		<table cellpadding="0" cellspacing="0">
			<colgroup>
				<col class="col100" />
				<col width="px"/>
			</colgroup>
			<tbody>
				<tr>
					<td class="title" >고 객 사</td>
					<td class="pL10">${result.custNm}</td>
				</tr>
				<tr>
					<td class="title" >고 객 명</td>
					<td class="pL10">${result.custManager}</td>
				</tr>
				<tr>
					<td class="title" >연 락 처</td>
					<td class="pL10">${result.custTelno}</td>
				</tr>
				<tr>
					<td class="title" >이 메 일</td>
					<td class="pL10">${result.custEmail}</td>
				</tr>
				<tr>
					<td class="title" >기타정보</td>
					<td class="pL10">
						<textarea name="etcInfo" class="height_130" style="width:390px;" readonly>${result.etcInfo}</textarea>
					</td>
					
				</tr>
			</tbody>
		</table>
		</form:form>
		</div>
		
		<div class="pop_btn_area">
			<a href="javascript:moveConsultArticle()"><img src="${imagePath}/btn/btn_goConsul.gif" alt="상담하기"/></a>
			<a href="javascript:modifyArticle('${result.no}');"><img src="${imagePath}/btn/btn_modify.gif" alt="수정"/></a>
			<a href="javascript:deleteArticle('${result.no}');"><img src="${imagePath}/btn/btn_delete.gif" alt="삭제"/></a>
			<img src="${imagePath}/btn/btn_close.gif" alt="창닫기" class="cursorPointer" onclick="window.close();">
		</div>
		
	</div>
</div>

</body>
</html>
