<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>

function saveVersion() {
	document.fm.action = '<c:url value="/product/saveVersion.do" />';
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
			<c:when test="${(pvVO == null) || (pvVO.no == 0)}" ><li class="popTitle">버전 등록</li></c:when>
			<c:otherwise><li class="popTitle">버전 수정</li></c:otherwise>
		</c:choose>
	</ul>
	</div>
	<div class="pop_con16">
		<div class="pop_board1">
			<form:form name="fm" id="fm" commandName="fm" method="POST" >
			<input type="button" value="닫기" class="mL10 fr btn_gray" onclick="javascript:window.close();"/>
			<input type="button" value="저장" class="mL10 fr btn_gray" onclick="javascript:saveVersion();"/>
			<p class="th_stitle">버전 정보</p>
			<input type="hidden" name="partNo" id="partNo" value="${pvVO.partNo}"/>
			<input type="hidden" name="partNm" id="partNm" value="${pvVO.partNm}"/>
			<input type="hidden" name="no" value="${pvVO.no}"/>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col100" />
					<col class="col200" />
					<col class="col100" />
					<col class="col200" />
				</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="title">구성품명</td>
						<td class="pL5" colspan="3">${pvVO.partNm}</td>
					</tr>
					<tr>
						<td class="title">버젼</td>
						<td class="txt_center"><input type="text" name="version" id="version" class="w200 pL5" value="${pvVO.version}"/></td>
						<td class="title">배포일</td>
						<td class=" txt_center"><input type="text" name="publishDate" id="publishDate" class="w200 calGen txt_center" value="${pvVO.publishDate}"/></td>
					</tr>
					<tr>
						<td class="title">버젼명</td>
						<td class="pL5" colspan="3"><input type="text" name="versionName" id="versionName" class="pL5 w98p" value="${pvVO.versionName}"/></td>
					</tr>
					<tr>
						<td class="title">버젼설명</td>
						<td class="pL5 pT5 pB5 " colspan="3">
						<c:choose>
							<c:when test="${(pvVO == null) || (pvVO.no == 0)}" >
								<textarea  class="w98p h400" name="contents" rows="25" style="resize:both">
1. 배포 목적

2. 주요 수정 내용

</textarea>
							</c:when>
							<c:otherwise>
								<textarea  class="w98p h400" name="contents" rows="25" style="resize:both">${pvVO.contents }</textarea>
							</c:otherwise>
						</c:choose>
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
