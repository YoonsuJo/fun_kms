<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>
var chk = false;
var chkErrorChk = "";

function saveReview() {
	document.fm.action = '<c:url value="/request/saveReview.do" />';
	document.fm.submit();
}

function deleteReview() {
	if(!confirm("삭제하시겠습니까?")) return;
	document.fm.action = '<c:url value="/request/deleteReview.do" />';
	document.fm.submit();
}

</script>
</head>

<body>
<div id="pop_board1">
	<div id="pop_top">
	<ul>
		<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
		<c:choose>
			<c:when test="${mode == 'M' }" ><li class="popTitle">작업 수정</li></c:when>
			<c:otherwise><li class="popTitle">작업 등록</li></c:otherwise>
		</c:choose>
	</ul>
	</div>
	<div class="pop_con16">
		<div class="pop_board1">
			<input type="button" value="닫기" class="mL10 fr btn_gray" onclick="javascript:window.close();"/>
			<input type="button" value="저장" class="mL10 fr btn_gray" onclick="javascript:saveReview();"/>
			<c:if test="${mode == 'M' }"><input type="button" value="삭제" class="mL10 fr btn_gray" onclick="javascript:deleteReview();"/></c:if>
			<p class="th_stitle">작업내용</p>
			<form:form name="fm" id="fm" commandName="fm" method="POST" >
		<c:choose>
			<c:when test="${mode == 'M' }" ><input type="hidden" name="no" value="${rvVO.no}"/></c:when>
			<c:otherwise><input type="hidden" name="no" value="0"/></c:otherwise>
		</c:choose>
				<input type="hidden" name="reqNo" value="${reqNo}"/>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col80" />
					<col class="col500" />
				</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="pL5 pT5 pB5 " colspan="2">
							<textarea  class="w98p" name="contents" rows="20" style="resize:both">${rvVO.contents }</textarea>
						</td>
					</tr>
 				</tbody>
			</table>
			</form:form>
		</div>	
	</div>
</div>

</body>
</html>
