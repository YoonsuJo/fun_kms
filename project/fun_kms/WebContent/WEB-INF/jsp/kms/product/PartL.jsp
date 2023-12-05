<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search() {
	document.fm.method = "POST";
	document.fm.action = "<c:url value='${rootPath}/product/listPart.do'/>";
	document.fm.submit();
}

function writePart() {
	var POP_NAME = "_PRODUCT_WRITE_PRODUCT_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/product/writePartPop.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function viewPart(no) {
	document.fm.searchNo.value = no.toString();
	document.fm.no.value = no.toString();
	document.fm.method = "POST";
	document.fm.action = "<c:url value='${rootPath}/product/viewPart.do'/>";
	document.fm.submit();
}

function partDown(partNo, sortNo, idx){
	var nextIdx = idx + 1;
	var nextPartNo = $('#partNo' + nextIdx).val();
	var nextSortNo = $('#sortNo' + nextIdx).val();

	$.ajax({
		url: "/product/movePartDownAjax.do",
		data: {
			partNo: partNo,
			sortNo: sortNo,
			nextPartNo: nextPartNo,
			nextSortNo: nextSortNo,
			type:"P"
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			if (!data.RETURN.equals('OK')) {
				alert('순서변경이 적절하게 이루어지지 않았습니다');
				return false;
			} else {
				location.reload();
			}
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("순서변경중 에러가 발생하였습니다.");
  	 	}
	});
	
	return;
}

function deletePart(partNo, count){
	if(confirm("선택하신 구성품을 삭제하시겠습니까?") != true)
		return;
	
	$.ajax({
		url: "/product/deletePartAjax.do",
		data: {
			no: partNo,
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			if (!data.RETURN.equals('OK')) {
				alert('구성품 삭제가 적절하게 이루어지지 않았습니다');
				return false;
			} else {
				$('#trNo_' + count).remove();
				// location.reload();
			}
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("구성품 삭제중 에러가 발생하였습니다.");
  	 	}
	});
	
	return;
}
</script>
</head>

<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">구성품 관리</li>
							<li class="navi">제품관리 > 구성품</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
					
						<div id="busiContactD">
						 <form name="fm" id="fm" methos="POST" >
						 	<input type="hidden" name="searchIsFirst" value="N"/>
							<input type="hidden" name="searchNo" id="searchNo" value="0"/>
							<input type="hidden" name="no" id="no" value="0"/>
							<fieldset>
								<div class="top_search07">
								<table cellpadding="0" cellspacing="0" >
								<caption>상단 검색</caption>
								<colgroup>
									<col class="col100"/>
									<col class="col300"/>
									<col class="col100"/>
									<col class="col300"/>
									<col class="col80"/>
								</colgroup>
								<tbody>
									<tr>
										<th class="fr pT5 pR5 txtB_Black">구분 : </th>
										<td >
										<c:choose>
											<c:when test="${fm.searchTypeP == 'Y'}" >
												<input type="checkbox" name="searchTypeP" checked value="Y">구성품(Part)
											</c:when>
											<c:otherwise>
												<input type="checkbox" name="searchTypeP" value="Y">구성품(Part)
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${fm.searchTypeM == 'Y'}" >
												<input type="checkbox" name="searchTypeM" checked value="Y"> 모듈(Module)
											</c:when>
											<c:otherwise>
												<input type="checkbox" name="searchTypeM" value="Y"> 모듈(Module)
											</c:otherwise>
										</c:choose>
										</td>
										<th class="fr pT5 pR5 txtB_Black"></th>
										<td >
										<c:choose>
											<c:when test="${fm.searchIncludeDel == 'Y'}" >
												<span class="w50"></span><input type="checkbox" name="searchIncludeDel" checked value="Y">삭제 포함
											</c:when>
											<c:otherwise>
												<span class="w50"></span><input type="checkbox" name="searchIncludeDel" value="Y">삭제 포함
											</c:otherwise>
										</c:choose>
										</td>
										<td class="txt_center">
											<input type="button" value="조건검색" class="btn_gray w70" onclick="javascript:search();"/>
										</td>
									</tr>
									<tr>
										<th class="fr pT5 pR5 txtB_Black">구성품 명 : </th>
										<td >
											<input type="text" name="searchName" value="${fm.searchName}"/>
										</td>
										<th class="fr pT5 pR5 txtB_Black">단축명 : </th>
										<td >
											<input type="text" name="searchNickName" value="${fm.searchNickName}"/>
										</td>
										<td class="txt_center">
										</td>
									</tr>
									<tr>
										<th class="fr pT5 pR5 txtB_Black">담당자 : </th>
										<td colspan="4">
											<input type="text" class="search_txt02 w400 userNameAuto userValidateCheckAuth" name="searchAdminMixes" id="searchAdminMixes" value="${fm.searchAdminMixes}"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchAdminMixes', 1, null, null, '1');" />
										</td>
									</tr>
								</tbody>
								</table>
								</div>
							</fieldset>
						</form>
						</div><br/>
						<!--// 상단 검색창 끝 -->

					<p class="th_stitle">구성품(part) 목록
						<span class="th_plus02">
						<c:if test="${user.isAdmin == 'Y' || pVO.adminNo ==  user.no || user.isProductadmin == 'Y'}"> 
							<input type="button" value="구성품 등록" class="btn_gray" onclick="javascript:writePart();"/>	
						</c:if>					
						</span>
					</p>
					<c:set var = "totCnt" value = "${fn:length(ppVOList)}" />
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40"/>
							<col class="col100"/>
							<col class="col400"/>
							<col class="col60"/>
							<col class="col60"/>
							<col class="col60"/>
							<col class="col30"/>
							<col class="col20"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th scope="col">단축명</th>
								<th scope="col">구성품명</th>
								<th scope="col">담당자</th>
								<th scope="col">등록일</th>
								<th scope="col">구분</th>
								<th scope="col">순서</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ppVOList}" var="vo" varStatus="vs">
								<tr id="trNo_${vs.count}">
									<input type="hidden" id="partNo${vs.count}" value="${vo.no}"/>
									<input type="hidden" id="sortNo${vs.count}" value="${vo.sortNo}"/>
									<td class="txt_center"><c:out value="${vs.count}"/></td>
									<td class="txt_center">${vo.nickName}</td>
									<td class="pL10"><a href="javascript:viewPart('${vo.no}');">${vo.partNm}</a></td>
									<td class="txt_center">${vo.adminNm}</td>
									<td class="txt_center"><fmt:formatDate value="${vo.regDt}" pattern="yy.MM.dd"/></td>
									<td class="txt_center">${vo.typeStr}</td>
									<td class="txt_center">
									<c:if test="${fn:length(ppVOList) != vs.count}">
										<img src="${imagePath}/btn/btn_down.gif" alt="아래로"  onclick="partDown('${vo.no}', '${vo.sortNo}', ${vs.count});"/>
									</c:if>
									</td>
									<td>
										<img src="${imagePath}/btn/btn_del.gif" alt="삭제" onclick="deletePart('${vo.no}', '${vs.count}');"/>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(ppVOList) == 0}">
								<tr>
									<td colspan="8" class="txt_center td_last">등록된 구성품이 없습니다.</td>
								</tr>
							</c:if>	
						</tbody>
						</table>
					</div>
				</div>
				<!-- E: section -->
	
				</div>
				<!-- E: center -->	
				<%@ include file="../include/right.jsp"%>
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
