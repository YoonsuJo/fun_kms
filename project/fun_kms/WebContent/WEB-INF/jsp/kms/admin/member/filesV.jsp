<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function pop_insa() {
	var popName = "_POP_INSA_";
	document.frm2.action = "${rootPath}/admin/member/popInsa.do";
	document.frm2.target = popName;
	var popup = window.open("about:blank", popName, 'top=0px, left=0px, width=340px, height=225px');
	document.frm2.submit();
	popup.focus();
}
function pop_photo(typ) {
	var popName = "_POP_PHOTO_";
	document.frm.action = "${rootPath}/admin/member/popPhoto.do";
	document.frm.target = popName;
	if (typ == 1) {
		document.frm.picTyp.value = "picFileId";
		document.frm.picId.value = "${result.member.picFileId}";
	}else if (typ == 2) {
		document.frm.picTyp.value = "picFileId2";
		document.frm.picId.value = "${result.member.picFileId2}";
	}
	var popup = window.open("about:blank", popName, 'top=0px, left=0px, width=340px, height=140px');
	document.frm.submit();
	popup.focus();
}
function deleteInsa(no) {
	document.frm3.userNo.value = no;
	document.frm3.submit();
}

</script>
</head>

<body style="overflow:hidden;">
	<c:set value="${result.member}" var="info" />
	<c:set value="${result.insaFileList}" var="insaList" />
	
	<form name="frm" method="POST" action="<c:url value='${rootPath}/admin/member/updtMember.do'/>">
	<input type="hidden" name="picTyp" />
	<input type="hidden" name="picId" />
	<input type="hidden" name="no" value="<c:out value="${info.no}" />"/>
	<!-- 게시판 시작  -->
	<div class="boardWrite02 mB20">
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>사원정보 수정</caption>
		<colgroup><col class="col120" /><col style="width:60px;"/><col /></colgroup>
		<tbody>
			<tr>
			    <td class="title" rowspan="2">사진</td>
			    <td class="title3">소개사진</td>
			    <td class="pL10" id="picFileId">
					<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" value="${info.picFileId}" />
					</c:import>
					<input type="hidden" name="picFileId" value="${info.picFileId}"/>
					<a href="javascript:pop_photo(1);"><img src="${imagePath}/admin/btn/btn_modify02.gif"/></a>
			    </td>
			</tr>
			<tr>
			    <td class="title3">증명사진</td>
			    <td class="pL10" id="picFileId2">
					<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" value="${info.picFileId2}" />
					</c:import>
					<input type="hidden" name="picFileId2" value="${info.picFileId2}"/>
					<a href="javascript:pop_photo(2);"><img src="${imagePath}/admin/btn/btn_modify02.gif"/></a>
			    </td>
           	</tr>
		</tbody>
		</table>
	</div>
	</form>
	
	<form name="frm2" method="POST" action="<c:url value='${rootPath}/admin/member/updtMember.do'/>">
	<input type="hidden" name="no" value="<c:out value="${info.no}" />"/>
	<!-- 게시판 시작  -->
	<div class="boardWrite02">
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			<caption>사원정보 수정</caption>
			<colgroup><col class="col120" /><col class="col150" /><col class="col180" /><col class="col150" /><col width="*" /></colgroup>
			<tbody>
				<tr>
					<td class="title" rowspan="${fn:length(insaList) + 1}">인사정보파일</td>
					<td class="title2">종류</td>
					<td class="title2">첨부파일</td>
					<td class="title2">비고</td>
					<td class="title2">&nbsp;</td>
				</tr>
				<c:forEach items="${insaList}" var="insa">
					<tr>
						<td class="pL10"><c:out value="${insa.fileTyp}" /></td>
						<td class="pL10">
							<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${insa.atchFileId}" />
							</c:import>
						</td>
						<td class="pL10"><c:out value="${insa.note}" /></td>
						<td class="btn">
							<a href="javascript:deleteInsa('<c:out value="${insa.no}" />')"><img src="${imagePath}/admin/btn/btn_delete03.gif"/></a>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5" style="text-align:center">
						<a href="javascript:pop_insa();"><img src="${imagePath}/admin/btn/btn_add03.gif"/></a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</form>
	
	<form name="frm3" method="POST" action="<c:url value='${rootPath}/admin/member/deleteInsa.do'/>">
		<input type="hidden" name="no" value="<c:out value="${info.no}" />"/>
		<input type="hidden" name="userNo" />
	</form>
</body>
</html>
