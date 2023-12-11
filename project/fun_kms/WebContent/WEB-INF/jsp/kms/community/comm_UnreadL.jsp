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
	document.frm.action = "<c:url value='${rootPath}/community/selectUnreadBoardList.do'/>";
	document.frm.submit();	
}

function view(nttId, bbsId) {
	document.subForm.nttId.value = nttId;
	document.subForm.bbsId.value = bbsId;
	document.subForm.action = "<c:url value='${rootPath}/community/selectBoardArticle.do'/>";
	document.subForm.submit();
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
			<div id="center" style="padding-bottom:80px">
				<div class="path_navi">
					<ul>
						<li class="stitle">읽지 않은 게시물</li>
						<li class="navi">홈 > 커뮤니티 > 게시판 > 미열람게시물</li>
					</ul>
				</div>

				<!-- S: section -->
				<div class="section01">
					<p class="th_stitle_right">
						<a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000031"><span class="txtS_bold">[공지사항]</span></a>&nbsp;
						<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000001"><span class="txtS_bold">[자유게시판]</span></a>&nbsp;
						<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000082"><span class="txtS_bold">[첫출근인사말]</span></a>&nbsp;
						<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000083"><span class="txtS_bold">[제안게시판]</span></a>&nbsp;
						<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000085"><span class="txtS_bold">[솔루션게시판]</span></a>
					</p>
					<p class="th_stitle">미열람게시물</p>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="미열람게시물 목록입니다.">
						<caption>미열람게시물</caption>
						<colgroup>
							<col class="col40" />
							<col class="col80" />
							<col width="px" />
							<col class="col120" />
							<col class="col120" />
							<col class="col50" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일시</th>
							<th scope="col">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td class="txt_center"><c:out value="${result.bbsNm}" /></td>
									<td>
<!--								<a href="javascript:view('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>')">-->
									<c:if test="${result.bbsTyCode == 'COMM'}">
									<a href="<c:url value='${rootPath}/community/selectBoardArticle.do?bbsId=${result.bbsId}&nttId=${result.nttId}'/>">
									</c:if>
									<c:if test="${result.bbsTyCode == 'SPRT'}">
									<a href="<c:url value='${rootPath}/support/selectBoardArticle.do?bbsId=${result.bbsId}&nttId=${result.nttId}'/>">
									</c:if>
									
									<span class="txt_red"><c:out value="${result.nttSj}"/></span> 
									<span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></a>
									</td>
									<td class="txt_center"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" printId="true"/></td>
									<td class="txt_center"><c:out value="${result.frstRegisterPnttm}"/></td>
									<td class="txt_center"><c:out value="${result.inqireCo}"/></td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<div class="btn_area">
						<a href="/community/addBoardArticle.do?bbsId=BBSMSTR_000000000031"><span class="txtS_bold">[공지등록]</span></a>&nbsp;
						<a href="/community/addBoardArticle.do?bbsId=BBSMSTR_000000000001"><span class="txtS_bold">[자유글등록]</span></a>&nbsp;
						<a href="${rootPath}/community/selectUnreadBoardBatch.do"><img class="cursorPointer" id="batchRead" src="${imagePath}/btn/btn_batchRead.gif"/></a>
					</div>
					
					<!-- 페이징 시작 -->
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />
					</div>
					<!-- 페이징 끝 -->
					
					<form name="frm" action ="<c:url value='${rootPath}/community/selectUnreadBoardList.do'/>" method="post">
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					</form>
					<form name="subForm" method="post" action="<c:url value='${rootPath}/community/selectBoardArticle.do'/>">
						<input type="hidden" name="bbsId" />
						<input type="hidden" name="nttId" />
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name="fromUnread" value="Y"/>
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
