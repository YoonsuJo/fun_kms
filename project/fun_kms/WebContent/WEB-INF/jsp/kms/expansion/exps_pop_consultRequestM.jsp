<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>(주)도전하는사람들 한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function requestIdUpdate() {
	document.frm.action = "<c:url value='${rootPath}/cooperation/updateConsultRequestId.do'/>";
	document.frm.submit();
}
function openProductManage() {
	//var popup = window.open("/cooperation/selectClient.do?no="+no,"_POP_PRODUCTCLIENT_");
	var popup = window.open("/product/selectProductRequestMain.do?requestType=E","_blank");
	popup.focus();
}
</script>
</head>

<body>
	<div id="pop_regist08">
	<div id="pop_top">
		 <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">상품관리번호 등록</li>
		</ul>
	</div>
	<div class="pop_con15">
		
		<div>
			<p>※ 등록방법</p>
			<ol class="pL10">
				<li>1. [기능오류관리] 버튼 클릭</li>
				<li>2. 기등록된 상품관리번호 불러오기</li>
				<li>3. [등록] 버튼 클릭</li>
			</ol>
		</div>
		
		<div class="pop_board mB20">
		<form:form commandName="frm" name="frm" method="post">
		<input type="hidden" name="consult_no" value="${result.consult_no }"/>
		<table cellpadding="0" cellspacing="0">
			<colgroup><col class="col100" /><col width="px"/></colgroup>
			<tbody>
				<tr>
					<td class="title" >상품관리번호</td>
					<td class="pL10">
						<input type="text" name="request_id" class="input01 span_17" value="${result.request_id}"/>
					</td>					
				</tr>
			</tbody>
		</table>
		</form:form>
		</div>
		
		<div>
			<input type="button" value="기능오류관리" class="btn_gray" onclick="openProductManage();"/>
		</div>
		
		<div class="pop_btn_area">
			<a href="javascript:requestIdUpdate()"><img src="${imagePath}/btn/btn_regist.gif"/></a>
			<img src="${imagePath}/btn/btn_close.gif" alt="창닫기" class="cursorPointer" onclick="window.close();">
		</div>
		
	</div>
</div>

</body>
</html>
