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

function saveProduct() {
	document.fm.action = '<c:url value="/product/saveProduct.do" />';
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
			<c:when test="${(pVO.no == null) || (pVO.no == 0)}" ><li class="popTitle">제품 정보 등록</li></c:when>
			<c:otherwise><li class="popTitle">제품 정보 수정</li></c:otherwise>
		</c:choose>
	</ul>
	</div>
	<div class="pop_con16">
		<div class="pop_board1">
			<input type="button" value="닫기" class="mL10 fr btn_gray" onclick="javascript:window.close();"/>
			<input type="button" value="저장" class="mL10 fr btn_gray" onclick="javascript:saveProduct();"/>
			<p class="th_stitle">제품 정보</p>
			<form:form name="fm" id="fm" commandName="fm" method="POST" >
		<c:choose>
			<c:when test="${(pVO.no == null) || (pVO.no == 0)}" >
				<input type="hidden" name="no" value="0"/>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="no" value="${pVO.no}"/>
			</c:otherwise>
		</c:choose>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col100" />
					<col class="col500" />
				</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="title">제품코드</td>
						<td class="pL5"><input type="productCode" name="productCode" class="w400 pL5" value="${pVO.productCode}"/></td>
					</tr>
					<tr>
						<td class="title">제품명</td>
						<td class="pL5"><input type="productNm" name="productNm" class="w400 pL5" value="${pVO.productNm}"/></td>
					</tr>
					<tr>
						<td class="title">담당자</td>
						<td class="pL5">
			<c:choose>
				<c:when test="${(pVO.adminNo == null) || (pVO.adminNo == 0)}" >
							<input type="text" class="pL5 w200 userNameAuto" name="adminMixes" id="adminMixes" value=""/>
				</c:when>
				<c:otherwise>
							<input type="text" class="pL5 w200 userNameAuto txt_center" name="adminMixes" id="adminMixes" value="${pVO.adminNm}(${pVO.adminId})"/>
				</c:otherwise>
			</c:choose>
							<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('adminMixes',1)"/>
						</td>
					</tr>
					<tr>
						<td class="title">제품설명</td>
						<td class="pL5 pT5 pB5 ">
							<textarea  class="w98p" name="productCn" rows="20" style="resize:both">${pVO.productCn }</textarea>
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
