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
	var chk = document.frm.workSt;

	if ((chk[0].checked || chk[1].checked) == false) {
		alert("재직자 혹은 퇴직자를 선택해주세요.");
		return;
	}
	
	document.frm.submit();
}
function allSearch() {
	var chk = document.frm.workSt;

	chk[0].checked = true;
	chk[1].checked = false;
	
	document.frm.searchCondition.value = "1";
	document.frm.searchKeyword.value = "";
	document.frm.submit();
}
function view(userNo) {
	document.subFrm.no.value = userNo;
	document.subFrm.action = '<c:url value="${rootPath}/member/selectPositionHistoryList.do"/>';
	document.subFrm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;
	if (n == 0) {
		document.frm.rankId.style.display = "";
	}
	else if (n == 1) {
		document.frm.rankId.style.display = "none";
		document.getElementById("usrNm").style.display = "";
		document.getElementById("orgNm").style.display = "none";
		document.getElementById("orgTree").style.display = "none";
	}
	else if (n == 2) {
		document.frm.rankId.style.display = "none";
		document.getElementById("usrNm").style.display = "none";
		document.getElementById("orgNm").style.display = "";
		document.getElementById("orgTree").style.display = "";
	}
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
						<li class="stitle">인사발령현황 조회</li>
						<li class="navi">홈 > 인사정보 > 사원정보 > 인사발령</li>
					</ul>
				</div>	
				
				<span class="stxt">임직원의 인사발령 내역을 조회할 수 있습니다.</span>
				
				<!-- S: section -->
				<div class="section01">
				
					<!-- 상단 검색창 시작 -->
					<form name="frm" method="POST" action="${rootPath}/member/selectPositionHistorySearch.do" onsubmit="search(); return false;">
					<input type="hidden" name="searchOrgId" id="orgId"/>
					<fieldset>
						<legend>상단 검색</legend>
						<div class="top_search04 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td class="search_left">
										검색범위 :
										<input type="checkbox" name="workSt" value="W,L" <c:if test="${searchVO.working || searchVO.leaved || empty searchVO.workSt}">checked="checked"</c:if> /> 재직자
										<span class="pL7"></span>
										<input type="checkbox" name="workSt" value="R" <c:if test="${searchVO.retired}">checked="checked"</c:if> /> 퇴직자
									</td>
								</tr>
								<tr>
									<td class="search_right">
										<label><input type="radio" name="searchCondition" value="0" onclick="selRadio(0);" <c:if test="${searchVO.searchCondition == 0}">checked="checked"</c:if>>직급</label>
										<select name="rankId" class="span_3">
											<option value="">선택</option>
											<c:forEach items="${rankList}" var="rank">
												<option value="${rank.code}" <c:if test="${rank.code == searchVO.rankId}">selected="selected"</c:if> ><c:out value="${rank.codeNm}"/></option>
											</c:forEach>
										</select><span class="pL7"></span>
										<label><input type="radio" name="searchCondition" value="1" onclick="selRadio(1);" <c:if test="${searchVO.searchCondition == 1}">checked="checked"</c:if>>사용자</label><span class="pL7"></span>
										<label><input type="radio" name="searchCondition" value="2" onclick="selRadio(2);" <c:if test="${searchVO.searchCondition == 2}">checked="checked"</c:if>>부서</label>
										<input type="text" name="searchUserNm" id="usrNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}" />
										<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" onfocus="orgGen('orgNm','orgId',0);" readonly="readonly" style="display:none"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);" style="display:none"/>
										<input type="image" src="${imagePath}/admin/btn/btn_search02.gif" />
										<a href="javascript:allSearch();"><img src="${imagePath}/admin/btn/btn_allview.gif" alt="전체보기"/></a>
									</td>
								</tr>
							</tbody>
							</table>
	                    </div>
	                </fieldset>
					</form>
					<script>selRadio("${searchVO.searchCondition}");</script>
	                <!-- 상단 검색창 끝 -->
						
					<!-- 게시판 시작 -->
					<p class="th_stitle">개인별 최종 인사발령 내역</p>
					<div class="boardList">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>인사발령 이력</caption>
						<colgroup>
							<col class="col50" />
							<col class="col70" />
							<col class="col60" />
							<col class="col40" />
							<col class="col90" />
							<col class="col250" />
							<col class="col70" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">이름</th>
							<th scope="col">발령일자</th>
							<th scope="col">발령사항</th>
							<th scope="col">직급</th>
							<th scope="col">소속회사</th>
							<th scope="col">부서</th>
							<th scope="col">보직</th>
							<th scope="col">비고</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result">
								<tr>
									<td class="txt_center"><a href="javascript:view('${result.userNo}');">${result.userNm}</a></td>
									<td class="txt_center">${result.chngDtPrint}&nbsp;</td>
									<td class="txt_center">${result.chngCodePrint }&nbsp;</td>
									<td class="txt_center">${result.aftRankNm}&nbsp;</td>
									<td class="txt_center">${result.aftCompNm}&nbsp;</td>
									<td class="txt_center">${result.aftOrgnztNm}&nbsp;</td>
									<td class="txt_center">${result.aftPositionPrint}&nbsp;</td>
									<td class="txt_center">${result.note}&nbsp;</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>	
					<!-- 게시판 끝  -->
					<form name="subFrm" method="POST">
						<input type="hidden" name="no" />
					</form>
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
