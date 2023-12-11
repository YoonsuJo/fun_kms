<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function articleSearch(pageIndex) {
	document.articleForm.pageIndex.value = pageIndex;
	document.articleForm.action = "<c:url value='${rootPath}/mypage/MyArticleList.do'/>";
	document.articleForm.submit();
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
						<li class="stitle">내 게시물</li>
						<li class="navi">마이페이지 > 내 게시물</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
					<p class="th_stitle">내가 작성한 게시물</p>
					
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>내 게시물</caption>
						<colgroup>
							<col class="col40" />
							<col class="col120" />
							<col width="px" />
							<col class="col120" />
							<col class="col50" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">종류</th>
							<th scope="col">제목</th>
							<th scope="col">등록일</th>
							<th scope="col" class="td_last">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + c.count) + 1}"/></td>
									<td class="txt_center">${result.bbsNm}</td>
									<td class="pL10">
										<a href="${rootPath}/mypage/selectBoardArticle.do?nttId=${result.nttId}&bbsId=${result.bbsId}" target="blank">${result.nttSj}</a>
									</td>
									<td class="txt_center"><c:out value="${result.frstRegisterPnttm}"/></td>
									<td class="txt_center td_last"><c:out value="${result.inqireCo}"/></td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" jsFunction="articleSearch" type="image"/>
					</div>

					<form name="articleForm" method="post" action="<c:url value='${rootPath}/mypage/MyArticleList.do'/>">
						<input type="hidden" name="pageIndex" />
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
