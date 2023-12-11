<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "<c:url value='${rootPath}/admin/selectBoardList.do'/>";
	document.frm.submit();	
}

function view(nttId, bbsId, readBool) {
	document.subForm.nttId.value = nttId;
	document.subForm.bbsId.value = bbsId;
	document.subForm.readBool.value = readBool;
	document.subForm.action = "<c:url value='${rootPath}/admin/selectBoardArticle.do'/>";
	document.subForm.submit();
}

function selRadio(i) {
	if (i == 2) {
		document.frm.searchWrd.className = "search_txt02 userNameAuto";
	}
	else {
		document.frm.searchWrd.className = "search_txt02";
	}
}

function selectPageUnit(cnt) {
	$('input[name=pageUnit]').val(cnt);
	
	// Cookie에 페이지 조회 줄수 담기(30일 보관)
	setCookie('hanmam_board_pageunit', cnt, 30);
	
	search(1);
}
</script>
</head>

<body>

<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">
							<c:choose>
								<c:when test="${boardVO.bbsId=='BBSMSTR_000000000002'}">관리자 게시판</c:when>
								<c:when test="${boardVO.bbsId=='BBSMSTR_000000000003'}">도움말 툴팁 게시판</c:when>
							</c:choose>
							</li>
						</ul>
					</div>
					
					<span class="stxt">
					<c:choose>
						<c:when test="${boardVO.bbsId=='BBSMSTR_000000000002'}">관리자 게시판입니다.</c:when>
						<c:when test="${boardVO.bbsId=='BBSMSTR_000000000003'}">도움말 툴팁 게시판입니다.</c:when>
					</c:choose>
					</span>
				
					<!-- S: section -->
					<div class="section01">
						<form name="frm" action ="<c:url value='${rootPath}/admin/selectBoardList.do'/>" method="post">
						<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
						<input type="hidden" name="nttId"  value="0" />
						<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
						<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="bot_search mB10">
								<ul>
									<li class="option_txt">
										<label><input type="radio" name="searchCnd" value="0" onclick="selRadio(0);" <c:if test="${searchVO.searchCnd == '0'}">checked="checked"</c:if> > 제목</label><span class="pL7"></span>
										<label><input type="radio" name="searchCnd" value="1" onclick="selRadio(1);" <c:if test="${searchVO.searchCnd == '1'}">checked="checked"</c:if> > 제목+내용</label><span class="pL7"></span>
										<label><input type="radio" name="searchCnd" value="2" onclick="selRadio(2);" <c:if test="${searchVO.searchCnd == '2'}">checked="checked"</c:if> > 작성자</label>
									</li>
									<li class="search_box"><input type="text" name="searchWrd" class="search_txt02 span_11" value='<c:out value="${searchVO.searchWrd}"/>' /></li>
									<li><img src="${imagePath}/btn/btn_search02.gif" alt="검색" style="cursor:pointer;" onclick="search('1'); return false;"/></li>
								</ul>
							</div>
						</fieldset>
						<!-- 상단 검색창 끝 -->
						</form>
						
						<!-- 상단 바 시작 -->
						<div>
							<select class="select01" onchange="selectPageUnit(this.options[this.selectedIndex].value)">
								<option value="15" <c:if test="${paginationInfo.recordCountPerPage==15}">selected="selected"</c:if> >15줄</option>
								<option value="30" <c:if test="${paginationInfo.recordCountPerPage==30}">selected="selected"</c:if> >30줄</option>
								<option value="50" <c:if test="${paginationInfo.recordCountPerPage==50}">selected="selected"</c:if> >50줄</option>
							</select>
							<span class="txtB_Black mR20">총 : ${paginationInfo.totalRecordCount}건</span>
						</div>
						<!-- 상단 바 끝 -->
						
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="자유게시판 목록입니다.">
							<caption>자유게시판</caption>
							<colgroup>
								<col class="col5" />
								<col class="col40" />
								<col width="px" />
								<col class="col120" />
								<col class="col120" />
								<col class="col50" />
								<col class="col5" />
							</colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">등록일</th>
								<th scope="col">조회수</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<tr>
										<td class="txt_center" colspan="2">
										<c:choose>
											<c:when test="${boardVO.bbsId=='BBSMSTR_000000000002'}">
												<c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/>
											</c:when>
											<c:when test="${boardVO.bbsId=='BBSMSTR_000000000003'}">
												<c:out value="${result.nttId}"/>
											</c:when>
										</c:choose>
										</td>
										<td>
<!--											<a href="javascript:view('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>','<c:out value="${result.readBool}"/>');">-->	
											 <a href="<c:url value='${rootPath}/admin/selectBoardArticle.do?bbsId=${result.bbsId}&nttId=${result.nttId}&reedBool=${result.readBool}'/>">
												<c:if test="${result.replyAt == 'Y'}"><c:forEach begin="1" end="${result.replyLc}">&nbsp;&nbsp;</c:forEach><img src="${imagePath}/board/icon_re.gif" /></c:if>
												<c:choose>
													<c:when test="${result.readBool == 'Y'}"><c:out value="${result.nttSj}"/> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:when>
													<c:otherwise><span class="txt_red"><c:out value="${result.nttSj}"/></span> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:otherwise>
												</c:choose>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" printId="true"/></td>
										<td class="txt_center"><c:out value="${result.frstRegisterPnttm}"/></td>
										<td class="txt_center" colspan="2"><c:out value="${result.inqireCo}"/></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						
						<!-- 페이징 시작 -->
						<div class="paginate">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />
						</div>
						
						<!-- 하단 바 시작 -->
						<div class="pB10">
							<select class="select01" onchange="selectPageUnit(this.options[this.selectedIndex].value)">
								<option value="15" <c:if test="${paginationInfo.recordCountPerPage==15}">selected="selected"</c:if> >15줄</option>
								<option value="30" <c:if test="${paginationInfo.recordCountPerPage==30}">selected="selected"</c:if> >30줄</option>
								<option value="50" <c:if test="${paginationInfo.recordCountPerPage==50}">selected="selected"</c:if> >50줄</option>
							</select>
							<span class="txtB_Black mR20">총 : ${paginationInfo.totalRecordCount}건</span>
						</div>
						<!-- 하단 바 끝 -->
					
						<!-- 페이징 끝 -->
						<form name="subForm" method="post" action="<c:url value='${rootPath}/admin/selectBoardArticle.do'/>">
							<input type="hidden" name="bbsId" />
							<input type="hidden" name="nttId" />
							<input type="hidden" name="readBool" />
							<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
							<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
							<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
							<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
						</form>
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<a href="${rootPath}/admin/addBoardArticle.do?bbsId=${boardVO.bbsId}"><img src="${imagePath}/btn/btn_regist.gif"/></a>
						</div>
						<!-- 버튼 끝 -->
					</div>
					<!-- E: section -->
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>