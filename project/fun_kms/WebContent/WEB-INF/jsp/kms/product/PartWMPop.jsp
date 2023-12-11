<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>
var chk = false;
var chkErrorChk = "";

function savePart() {
	document.fm.action = '<c:url value="/product/savePart.do" />';
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
			<c:when test="${(ppVO.no == null) || (ppVO.no == 0)}"><li class="popTitle">구성품 정보 등록</li></c:when>
			<c:otherwise><li class="popTitle">구성품 정보 수정</li></c:otherwise>
		</c:choose>
	</ul>
	</div>
	<div class="pop_con16">
		<div class="pop_board1">
			<input type="button" value="닫기" class="mL10 fr btn_gray" onclick="javascript:window.close();"/>
			<input type="button" value="저장" class="mL10 fr btn_gray" onclick="javascript:savePart();"/>
			<p class="th_stitle">구성품 정보</p>
			<form:form name="fm" id="fm" commandName="fm" method="POST" >
		<c:choose>
			<c:when test="${(ppVO.no == null) || (ppVO.no == 0)}" >
				<input type="hidden" name="no" value="0"/>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="no" value="${ppVO.no}"/>
			</c:otherwise>
		</c:choose>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col100" />
					<col class="col500" />
				</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="title">구성품코드</td>
						<td class="pL5"><input type="text" name="nickName" class="w200 pL5" value="${ppVO.nickName}"/><span class="pL20"></span> 
						<c:choose>
							<c:when test="${(ppVO.no == null) || (ppVO.no == 0)}" >
								<input type="radio" name="type" checked value="P">구성품(Part)
								<input type="radio" name="type"  value="M"> 모듈(Module)
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${ppVO.type == 'P'}" >
										<input type="radio" name="type" checked value="P">구성품(Part)
										<input type="radio" name="type"  value="M"> 모듈(Module)
									</c:when>
									<c:when test="${ppVO.type == 'M'}" >
										<input type="radio" name="type" value="P">구성품(Part)
										<input type="radio" name="type" checked value="M"> 모듈(Module)
									</c:when>
									<c:otherwise>
										<input type="radio" name="type" value="P">구성품(Part)
										<input type="radio" name="type" value="M"> 모듈(Module)
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					<tr>
						<td class="title">구성품명</td>
						<td class="pL5"><input type="text" name="partNm" class="w400 pL5" value="${ppVO.partNm}"/></td>
					</tr>
					<tr>
						<td class="title">담당자</td>
						<td class="pL5">
			<c:choose>
				<c:when test="${(ppVO.adminNo == null) || (ppVO.adminNo == 0)}">
							<input type="text" class="pL5 w200 userNameAuto " name="adminMixes" id="adminMixes" value=""/>
				</c:when>
				<c:otherwise>
							<input type="text" class="pL5 w200 userNameAuto " name="adminMixes" id="adminMixes" value="${ppVO.adminNm}(${ppVO.adminId})"/>
				</c:otherwise>
			</c:choose>
							<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('adminMixes',1)"/>
						</td>
					</tr>
					<tr>
						<td class="title">설  명</td>
						<td class="pL5 pT5 pB5 ">
							<textarea  class="w98p" name="partCn" rows="20" style="resize:both">${ppVO.partCn }</textarea>
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
