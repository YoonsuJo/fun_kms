<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}
function view(nttId, readBool) {
	document.subForm.nttId.value = nttId;
	document.subForm.readBool.value = readBool;
	document.subForm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;
	
	var searchKeyword = document.getElementById("searchKeyword");
	var orgId = document.getElementById("orgId");
	var orgNm = document.getElementById("orgNm");
	var userNm = document.getElementById("userNm");
	var orgTree = document.getElementById("orgTree");
	var usrTree = document.getElementById("usrTree");

	if (n == "0") {
		orgNm.style.display = "";
		searchKeyword.style.display = "none";
		userNm.style.display = "none";
		orgTree.style.display = "";
		usrTree.style.display = "none";

		orgId.value = "${searchVO.searchOrgId}";
		orgNm.value = "${searchVO.searchOrgNm}";
		searchKeyword.value = "";
		userNm.value = "";
	}
	else if (n == "1") {
		orgNm.style.display = "none";
		searchKeyword.style.display = "";
		userNm.style.display = "none";
		orgTree.style.display = "none";
		usrTree.style.display = "none";

		orgNm.value = "";
		searchKeyword.value = "${searchVO.searchKeyword}";
		userNm.value = "";
	}
	else if (n == "2") {
		orgNm.style.display = "none";
		searchKeyword.style.display = "";
		userNm.style.display = "none";
		orgTree.style.display = "none";
		usrTree.style.display = "none";

		orgNm.value = "";
		searchKeyword.value = "${searchVO.searchKeyword}";
		userNm.value = "";
	}
	else if (n == "3") {
		orgNm.style.display = "none";
		searchKeyword.style.display = "none";
		userNm.style.display = "";
		orgTree.style.display = "none";
		usrTree.style.display = "";

		orgNm.value = "";
		searchKeyword.value = "";
		userNm.value = "${searchVO.searchUserNm}";
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
							<li class="stitle">주간업무보고</li>
							<li class="navi">홈 > 업무보고 > 업무계획/실적 > 주간업무보고</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<form name="frm" id="frm" method="POST" action="${rootPath}/cooperation/selectWeekReportList.do" onsubmit="search(1); return false;">
						<input type="hidden" name="bbsId"  value="BBSMSTR_000000000071" />
						<input type="hidden" name="nttId"  value="0" />
						<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
						<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
						<input type="hidden" name="pageIndex"/>
						<input type="hidden" name="searchOrgId" id="orgId"/>
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="bot_search mB10">
								<ul>
									<li class="option_txt">
										<input type="radio" name="searchCondition" value="0" onclick="selRadio(0);" <c:if test="${searchVO.searchCondition == 0}">checked="checked"</c:if>> 보고부서<span class="pL7"></span>
										<input type="radio" name="searchCondition" value="1" onclick="selRadio(1);" <c:if test="${searchVO.searchCondition == 1}">checked="checked"</c:if>> 제목<span class="pL7"></span>
										<input type="radio" name="searchCondition" value="2" onclick="selRadio(2);" <c:if test="${searchVO.searchCondition == 2}">checked="checked"</c:if>> 제목+내용<span class="pL7"></span>
										<input type="radio" name="searchCondition" value="3" onclick="selRadio(3);" <c:if test="${searchVO.searchCondition == 3}">checked="checked"</c:if>> 작성자
									</li>
									<li class="search_box">
										<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" readonly="readonly" onclick="orgGen('orgNm','orgId',0);"/>
										<input type="text" name="searchKeyword" id="searchKeyword" class="search_txt02"/>
										<input type="text" name="searchUserNm" id="userNm" class="search_txt02 userNameAuto"/>
										<img id="orgTree" src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('orgNm','orgId',0);" class="cursorPointer"/>
										<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('userNm',1);" class="cursorPointer"/>
									</li>
									<li class="search_btn"><input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(1); return false;" style="cursor:pointer"/></li>
								</ul>
							</div>
						</fieldset>
						<!-- 상단 검색창 끝 -->
						</form>
						<script>selRadio("${searchVO.searchCondition}");</script>
						
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col40" />
								<col class="col120" />
								<col width="px" />
								<col class="col80" />
								<col class="col60" />
								<col class="col110" />
								<col class="col50" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">번호</th>
								<th scope="col">보고부서</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">보고일</th>
								<th scope="col">등록일</th>
								<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<tr>
										<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
										<td class="txt_center">${result.orgnztNm}</td>
										<td>
<!--											<a href="javascript:view('<c:out value="${result.nttId}"/>','<c:out value="${result.readBool}"/>');">-->
											<a href="<c:url value='${rootPath}/cooperation/selectWeekReport.do?bbsId=${result.bbsId}&nttId=${result.nttId}&reedBool=${result.readBool}
											&bbsTyCode=${bdMstr.bbsTyCode}&bbsAttrbCode=${bdMstr.bbsAttrbCode}
											&pageIndex=${searchVO.pageIndex}&searchCondition=${searchVO.searchCondition}&searchKeyword=${searchVO.searchKeyword}
											&searchOrgNm=${searchVO.searchOrgNm}&searchUserNm=${searchVO.searchUserNm}'/>">															
												<c:choose>
													<c:when test="${result.readBool == 'Y'}"><c:out value="${result.nttSj}"/> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:when>
													<c:otherwise><span class="txt_red"><c:out value="${result.nttSj}"/></span> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:otherwise>
												</c:choose>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" printId="false"/></td>
										<td class="txt_center"><print:date date="${result.exDt}" printType="S"/></td>
										<td class="txt_center"><print:date date="${result.frstRegisterPnttm}" printType="yyMMDDHHMM"/></td>
										<td class="txt_center"><c:out value="${result.inqireCo}"/></td>
									</tr>
								</c:forEach>
								<c:if test="${empty resultList}">
									<tr>
										<td class="txt_center" colspan="6">등록된 글이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
							</table>
						</div>
						
						<!-- 하단 숫자 시작 -->
						<div class="paginate">
							<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
						</div>
						<!-- 하단 숫자 끝 -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<a href="${rootPath}/cooperation/insertWeekReportView.do"><img src="${imagePath}/btn/btn_regist.gif"/></a>
						</div>
						<!-- 버튼 끝 -->
					</div>
					<!-- E: section -->
	
					<form name="subForm" method="post" action="${rootPath}/cooperation/selectWeekReport.do">
						<input type="hidden" name="nttId" />
						<input type="hidden" name="readBool" />
						<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
						<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
						<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
						<input type="hidden" name="searchOrgNm" value="<c:out value='${searchVO.searchOrgNm}'/>"/>
						<input type="hidden" name="searchUserNm" value="<c:out value='${searchVO.searchUserNm}'/>"/>
					</form>
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
