<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function equipSearch(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = '<c:url value="${rootPath}/support/selectEquipList.do" />';
	document.frm.submit();
}
function equipView(equip_no) {
	//document.frm.equip_no.value = equip_no;
	//document.frm.action = '<c:url value="${rootPath}/support/selectEquipView.do" />';
	document.frm.action = '<c:url value="${rootPath}/support/selectEquipView.do?equip_no=' + equip_no + '"/>';
	document.frm.submit();
}
function searchType(type,clearYn){
	if(type == 0){
		document.getElementById("searchSelectBox").style.display = "";
		document.getElementById("searchKeywordBox").style.display = "none";
	}else if(type == 1){
		document.getElementById("searchSelectBox").style.display = "none";
		document.getElementById("searchKeywordBox").style.display = "";
	}else if(type == 2){
		document.getElementById("searchSelectBox").style.display = "none";
		document.getElementById("searchKeywordBox").style.display = "";
	}

	if(clearYn == 'Y'){
		document.frm.searchSelect.value = "";
		document.frm.searchKeyword.value = "";
	}
}

function equipDelete(equip_no){
	if(confirm("장비 사용이력도 같이 삭제 됩니다. 정말 삭제하시겠습니까?")){
		document.frm.equip_no.value = equip_no;
		document.frm.action = '<c:url value="${rootPath}/support/deleteEquip.do" />';
		document.frm.submit();
	}
}

//[2014.6.25/김동우]검색 조건에 따라, 초성검색 지원여부 조절
function clickSearchCondition() {
	var condition = $('.bot_search input[name=searchCondition]:checked').val();
	var searchKeyword = $('.bot_search input[name=searchKeyword]');
	if (condition == 2) {
		searchKeyword.addClass('userNameAutoHead');
		$('#usrTree').show();
	}
	else {
		searchKeyword.removeClass('userNameAutoHead');
		$('#usrTree').hide();
		removeAutoComplete(searchKeyword);
	}
}

//자르기(usrGen 으로 데이터 가져왔을때, 사용자명만 잘라내기)
function cutUsrGenName() {
	var searchKeyword = $('.bot_search input[name=searchKeyword]');
	var val = searchKeyword.val();
	val = val.substring(0, val.indexOf('('));
	searchKeyword.val(val);
}

$(document).ready(function() {
	clickSearchCondition();
});
</script>
</head>

<body onload="searchType('${searchVO.searchCondition}','N');">

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
							<li class="stitle">전산장비 관리</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 전산장비 관리</li>
						</ul>
					</div>
					<!-- S: section -->
					<div class="section01">
						<!-- 상단 검색창 시작 -->
						<form name="frm" action ="<c:url value='${rootPath}/support/selectEquipList.do'/>" method="post">
						<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
<!--						<input name="equip_no" type="hidden"/>-->
						<fieldset>
						
						<!-- 버튼 시작 -->
						<div class="btn_area" style="margin:48px 18px 0px 0px;">
							<c:if test="${user.admin}">
								<a href="${rootPath}/support/insertEquipView.do"><img src="${imagePath}/btn/btn_regist.gif" /></a>
							</c:if>
						</div>
						<!-- 버튼 끝 -->
						
						<legend>상단 검색</legend>
							<div class="bot_search mB10">
								<ul>
									<li class="option_txt">
										<label>종류<span class="pL7"></span><input type="radio" name="searchCondition" onclick="searchType(0,'Y'); clickSearchCondition();" value="0" <c:if test="${searchVO.searchCondition == '0'}">checked="checked"</c:if> ></label><span class="pL7"></span>
										<label>모델명<span class="pL7"></span><input type="radio" name="searchCondition" onclick="searchType(1,'Y'); clickSearchCondition();" value="1" <c:if test="${searchVO.searchCondition == '1'}">checked="checked"</c:if> ></label><span class="pL7"></span>
										<label>사용자<span class="pL7"></span><input type="radio" name="searchCondition" onclick="searchType(2,'Y'); clickSearchCondition();" value="2" <c:if test="${searchVO.searchCondition == '2'}">checked="checked"</c:if> ></label>
									</li>
									<li class="search_box" id="searchSelectBox">
										<select name="searchSelect" onchange="equipSearch('1');">
											<option value="" <c:if test="${searchVO.searchSelect == ''}">checked="checked"</c:if>>전체</option>
											<c:forEach items="${equipTypeList}" var="equipType">
											<option value="${equipType.type_value}" <c:if test="${searchVO.searchSelect == equipType.type_value}">selected="selected"</c:if>>${equipType.type_name}</option>
											</c:forEach>
										</select>
									</li>
									<li class="search_box" id="searchKeywordBox" style="display:none">
										<input type="text" name="searchKeyword" id="searchKeyword" class="searchCondition" value='<c:out value="${searchVO.searchKeyword}"/>'/>
										<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchKeyword',1,cutUsrGenName);" class="cursorPointer">
									</li>
									<li><img src="${imagePath}/btn/btn_search02.gif" alt="검색" style="cursor:pointer;" onclick="equipSearch('1'); return false;"/></li>
								</ul>
							</div>
						</fieldset>
						</form>
						<!-- 상단 검색창 끝 -->
						
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
								<caption>공지사항</caption>
								<colgroup>
									<col class="col90" />
									<col class="col80" />
									<col />
									<col class="col70" />
									<col class="col80" />
									<col class="col50" />
									<col class="col70" />
									<col class="col50" />
									<col class="col30" />
								</colgroup>
								<thead>
									<tr>
									<th scope="col">종류</th>
									<th scope="col">관리번호</th>
									<th scope="col">모델명</th>
									<th scope="col">사용자</th>
									<th scope="col">부서</th>
									<th scope="col">직급</th>
									<th scope="col">사용처</th>
									<th scope="col">비고</th>
									<th scope="col">&nbsp;</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList}" var="result" varStatus="status">
										<tr class="cursorPointer">
											<td onclick="equipView('${result.equip_no}');" class="txt_center">
												<c:forEach items="${equipTypeList}" var="equipType">
												<c:if test="${result.equip_type == equipType.type_value}">${equipType.type_name}</c:if>
												</c:forEach>
											</td>
											<td onclick="equipView('${result.equip_no}');" class="txt_center">${result.serial_no}</td>
											<td onclick="equipView('${result.equip_no}');" class="txt_center">${result.model}</td>
											<td onclick="equipView('${result.equip_no}');" class="txt_center">${result.user_nm}</td>
											<td onclick="equipView('${result.equip_no}');" class="txt_center">${result.orgnztNm}</td>
											<td onclick="equipView('${result.equip_no}');" class="txt_center">${result.rankNm}</td>
											<td onclick="equipView('${result.equip_no}');" class="txt_center">${result.place}</td>
											<td onclick="equipView('${result.equip_no}');" class="txt_center">
												<c:choose>
													<c:when test="${result.status == '1-public'}">공용</c:when>
													<c:when test="${result.status == '2-personal'}">개인용</c:when>
													<c:when test="${result.status == '3-server'}">서버용</c:when>
													<c:when test="${result.status == '4-repair'}">수리중</c:when>
													<c:when test="${result.status == '5-extra'}">여분</c:when>
													<c:when test="${result.status == '6-disuse'}">폐기</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</td>
											<td class="txt_center">
												<c:if test="${user.admin}">
													<a href="${rootPath}/support/updateEquipInfoView.do?equip_no=${result.equip_no}"><img src="${imagePath}/btn/btn_plus02.gif" class="cursorPoineter" /></a>
													<a href="javascript:equipDelete('${result.equip_no}');"><img src="${imagePath}/btn/btn_minus02.gif" class="cursorPoineter" /></a>
												</c:if>
											 </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<c:if test="${user.admin}">
								<a href="${rootPath}/support/insertEquipView.do"><img src="${imagePath}/btn/btn_regist.gif" /></a>
							</c:if>
						</div>
						<!-- 버튼 끝 -->
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
