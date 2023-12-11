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

// TENY_170704
// 본 페이지는 하나의 구성품이 사용하는 하부 구성품들을 선택하기위하여 구성품 목록을 보여주는 페이지이다
// 이때 사용자는 관련된 구성품들을 선택하여 저장 버튼을 선택하게 된다.
// 본 함수는 선택된 구성품 목록을 상위 구성품과 연결관계를 저장하는 기능을 한다.
function saveSelectedSubPartList() {
	var chk = document.getElementsByName("chck");
	var partNoList = "";
	
	for(var i=0; i<chk.length; i++) {
		if (chk[i].checked) {
			if (partNoList != "") {
				partNoList += ",";
			}
			partNoList += chk[i].value;
		}
	}
	if (partNoList == "") {
		alert("선택된 구성품이 없습니다.");
		return;
	}
	document.fm.partNoList.value = partNoList;
	document.fm.action = '<c:url value="/product/saveSubPartList.do" />';
	document.fm.submit();
}

/* 전체 선택 체크박스 */
function allChckChange(obj) {
	var chk = document.getElementsByName("chck");
	if (obj.checked) {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=true;
		}
	}
	else {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=false;
		}
	}
}

</script>
</head>

<body>
<div id="pop_board1">
	<div id="pop_top">
	<ul>
		<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
		<li class="popTitle">구성품(part, module) 목록</li>
	</ul>
	</div>
	<div class="pop_con16">
		<div class="pop_board1">
			<input type="button" value="닫기" class="mL10 fr btn_gray" onclick="javascript:window.close();"/>
			<input type="button" value="저장" class="mL10 fr btn_gray" onclick="javascript:saveSelectedSubPartList();"/>
			<p class="th_stitle">구성품 정보</p>
			<form:form name="fm" id="fm" commandName="fm" method="POST" >
				<input type="hidden" name="searchNo" value="${fm.searchNo}"/>
				<input type="hidden" name="partNoList" value=""/>
					<c:set var = "totCnt" value = "${fn:length(ppVOList)}" />
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col20"/>
							<col class="col40"/>
							<col class="col100"/>
							<col class="col400"/>
							<col class="col60"/>
							<col class="col60"/>
							<col class="col60"/>
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="checkAll" onclick="javascript:allChckChange(this);" /></th>
								<th>번호</th>
								<th scope="col">단축명</th>
								<th scope="col">구성품명</th>
								<th scope="col">담당자</th>
								<th scope="col">등록일</th>
								<th scope="col">구분</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ppVOList}" var="vo" varStatus="vs">
								<tr>
									<td class="txt_center"><input type="checkbox" name="chck" value="${vo.no}"/></td>
									<td class="txt_center"><c:out value="${vs.count}"/></td>
									<td class="txt_center">${vo.nickName}</td>
									<td class="pL10"><a href="javascript:viewPart('${vo.no}');">${vo.partNm}</a></td>
									<td class="txt_center">${vo.adminNm}</td>
									<td class="txt_center"><fmt:formatDate value="${vo.regDt}" pattern="yy.MM.dd"/></td>
									<td class="txt_center">${vo.typeStr}</td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(ppVOList) == 0}">
								<tr>
									<td colspan="6" class="txt_center td_last">등록된 구성품이 없습니다.</td>
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
