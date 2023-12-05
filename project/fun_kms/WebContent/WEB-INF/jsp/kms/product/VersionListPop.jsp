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

//TENY_170704 
// 선택된 버전의 모듈을 구성품과 연결하는 기능
function saveVersionRelation() {
	
	document.fm.action = '<c:url value="/product/saveVersionRelation.do" />';
	document.fm.submit();
}

</script>
</head>

<body>
<div id="pop_board1">
	<div id="pop_top">
	<ul>
		<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
		<li class="popTitle">구성품 버전 목록</li>
	</ul>
	</div>
	<div class="pop_con16">
		<div class="pop_board1">
			<input type="button" value="닫기" class="mL10 fr btn_gray" onclick="javascript:window.close();"/>
			<input type="button" value="저장" class="mL10 fr btn_gray" onclick="javascript:saveVersionRelation();"/>
			<p class="th_stitle">버전 목록</p>
			<form:form name="fm" id="fm" commandName="fm" method="POST" >
				<input type="hidden" name="searchNo" value="${fm.searchNo}"/>						<!-- 리스트된 버전들의 모듈 No -->
				<input type="hidden" name="searchVersionNo" value="${fm.searchVersionNo}"/>		<!-- 선택된 버전을 사용한 모듈의 버전 -->
				<div class="boardList02 mB20">
					<table cellpadding="0" cellspacing="0" >
					<colgroup>
						<col class="col30"/>
						<col class="col100"/>
						<col class="col400"/>
						<col class="col60"/>
						<col class="col60"/>
						<col class="col80"/>
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th scope="col">버전</th>
							<th scope="col">버전명</th>
							<th scope="col">등록자</th>
							<th scope="col">등록일</th>
							<th scope="col">배포일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${verVOList}" var="vo" varStatus="vs">
							<tr>
							<c:if test="${vs.count == 1}">
								<td class="txt_center"><input type="radio" name="verNo" checked value="${vo.no}"/></td>
							</c:if>
							<c:if test="${vs.count != 1}">
								<td class="txt_center"><input type="radio" name="verNo" value="${vo.no}"/></td>
							</c:if>
								<td class="txt_center">${vo.version}</td>
								<td class="pL10"><a href="javascript:viewVersion('${vo.no}');">${vo.versionName}</a></td>
								<td class="txt_center">${vo.writerName}</td>
								<td class="txt_center">${vo.regDatetime}</td>
								<td class="txt_center">${vo.publishDate}</td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(verVOList) == 0}">
							<tr>
								<td colspan="6" class="txt_center td_last">구성품의 등록된 버전이 없습니다.</td>
							</tr>
						</c:if>	
					</tbody>
					</table>
				</div>
			</form:form>
		</div>	
	</div>
</div>

</body>
</html>
