<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function del(no) {
	if (confirm("삭제하시겠습니까?")) {
		document.scrapForm.no.value = no;
		document.scrapForm.action = "<c:url value='${rootPath}/mypage/deleteScrap.do'/>";
		document.scrapForm.submit();
	}
}

function scrapSearch(pageIndex) {
	document.scrapForm.pageIndex.value = pageIndex;
	document.scrapForm.action = "<c:url value='${rootPath}/mypage/getScrapList.do'/>";
	document.scrapForm.submit();
}

function openScrap(typ, articleId, bbsId) {

	if (typ == 'BBS') {
		// window.open("${rootPath}/mypage/selectBoardArticle.do?nttId=" + articleId + "&bbsId=" + bbsId, "newWindow", "top=0px,left=0px");
		document.bbsForm.nttId.value = articleId;
		document.bbsForm.bbsId.value = bbsId;
		document.bbsForm.action = "${rootPath}/mypage/selectBoardArticle.do";
		document.bbsForm.submit();
	} else if (typ == 'MAIL') {
		// window.open("${rootPath}/community/selectMail.do?mailId=" + articleId, "newWindow", "top=0px,left=0px");
		document.mailForm.mailId.value = articleId;
		document.mailForm.action = "${rootPath}/community/selectMail.do";
		document.mailForm.submit();
	} else if (typ == 'BUSI') {
		// window.open("${rootPath}/cooperation/selectBusinessContact.do?bcId=" + articleId, "newWindow", "top=0px,left=0px");
		document.busiForm.bcId.value = articleId;
		document.busiForm.action = "${rootPath}/cooperation/selectBusinessContact.do";
		document.busiForm.submit();
	} else {
		return;
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
						<li class="stitle">스크랩</li>
						<li class="navi">마이페이지 > 스크랩</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
					<p class="th_stitle">스크랩</p>
					
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>스크랩</caption>
						<colgroup>
							<col class="col50"/>
							<col class="col100" />
							<col width="px"/>
							<col class="col110"/>
							<col class="col50"/>
						</colgroup>
						<thead>
							<tr>
								<th>순번</th>
								<th>종류</th>
								<th>제목</th>
								<th>작성자</th>
								<th class="td_last">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty resultList }">
									<tr><td colspan="5" class="td_last txt_center" >※ 등록하신 스크랩이 없습니다.</td></tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${resultList}" var="result" varStatus="c">
										<tr>
											<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + c.count) + 1}"/></td>
											<td class="txt_center">${result.title}</td>
											<td class="txt_center">
												<a href="javascript:openScrap('${result.typ}', '${result.articleId}', '${result.bbsId}');">${result.sj}</a>
											</td>
											<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}" printId="true"/></td>
											<td class="txt_center td_last">
												<a href="javascript:del('${result.no}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
						</table>
					</div>
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" jsFunction="scrapSearch" type="image"/>
					</div>

					<form name="scrapForm" method="post" action="<c:url value='${rootPath}/mypage/getScrapList.do'/>">
						<input type="hidden" name="no" />
						<input type="hidden" name="pageIndex" />
					</form>
					<form name="bbsForm" method="post" action="" target="blank">
						<input type="hidden" name="nttId" />
						<input type="hidden" name="bbsId" />
					</form>
					<form name="mailForm" method="post" action="" target="blank">
						<input type="hidden" name="mailId" />
					</form>
					<form name="busiForm" method="post" action="" target="blank">
						<input type="hidden" name="bcId" />
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
