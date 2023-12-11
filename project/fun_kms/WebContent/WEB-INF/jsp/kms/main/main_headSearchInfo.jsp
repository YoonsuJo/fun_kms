<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<link rel="stylesheet" href="${commonPath}/css/main.css" type="text/css" media="all" />
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
		<%@ include file="left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">정보 통합검색 결과</li>
							<li class="navi">홈 > 정보 통합검색 결과</li>
						</ul>
					</div>
					
					<span class="stxt">현재는 게시판과 업무연락만 검색합니다. 다른 컨텐츠 검색은 향후 추가 예정입니다.</span>
					<!-- S: section -->
					<div class="section01">
					
						<p class="th_stitle">게시판</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup><col class="col5" /><col class="col40" /><col class="col100" /><col width="px" /><col class="col80" /><col class="col120" /><col class="col60" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"> </th>
								<th scope="col">번호</th>
								<th scope="col">종류</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">등록일시</th>
								<th scope="col">조회수</th>
								<th class="th_right"> </th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${bbsList}" var="bbs" varStatus="c">
									<tr>
										<td class="txt_center" colspan="2"><c:out value="${(bbsSearchVO.pageIndex-1) * bbsSearchVO.pageSize + c.count}"/></td>
										<td class="txt_center"><c:out value="${bbs.bbsNm}" /></td>
										<td>
											<a href="${rootPath}/community/selectBoardArticle.do?nttId=<c:out value="${bbs.nttId}"/>&bbsId=<c:out value="${bbs.bbsId}"/>">
												<c:if test="${bbs.replyAt == 'Y'}"><c:forEach begin="1" end="${bbs.replyLc}">&nbsp;&nbsp;</c:forEach><img src="${imagePath}/board/icon_re.gif" /></c:if>
												<c:choose>
													<c:when test="${bbs.readBool == 'Y'}"><c:out value="${bbs.nttSj}"/></c:when>
													<c:otherwise><span class="txt_red"><c:out value="${bbs.nttSj}"/></span></c:otherwise>
												</c:choose>
												<span class="txt_reply">[<c:out value="${bbs.commentCount}"/>]</span>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${bbs.frstRegisterId}" userNm="${bbs.ntcrNm}" userId="${bbs.ntcrId}" printId="true"/></td>
										<td class="txt_center"><c:out value="${bbs.frstRegisterPnttm}"/></td>
										<td class="txt_center" colspan="2"><c:out value="${bbs.inqireCo}"/></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					
						<!-- 하단 숫자 시작 -->
						<div class="paginate">
							<ui:pagination paginationInfo="${bbsPaginationInfo}" type="image" jsFunction="bbsSearch" />
						</div>
						<!-- 하단 숫자 끝 -->
					
						<p class="th_stitle">업무연락</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup><col class="col5" /><col class="col40" /><col class="col100" /><col width="px" /><col class="col80" /><col class="col120" /><col class="col120" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"> </th>
								<th scope="col">번호</th>
								<th scope="col">프로젝트코드</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">작성일시</th>
								<th scope="col">변경일시</th>
								<th class="th_right"> </th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${bcList}" var="bc" varStatus="c">
									<tr>
										<td class="txt_center" colspan="2"><c:out value="${(bcSearchVO.pageIndex-1) * bcSearchVO.pageSize + c.count}"/></td>
										<td class="txt_center">${bc.prjCd}</td>
										<td class="pL10">
											<a href="${rootPath}/cooperation/selectBusinessContact.do?bcId=${bc.bcId}">
												<c:choose>
													<c:when test="${bc.readYn == 'Y'}">${bc.bcSj}</c:when>
													<c:otherwise><span class="txt_red">${bc.bcSj}</span></c:otherwise>
												</c:choose>
												<span class="txt_reply">[${bc.commentCnt}]</span>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${bc.userNo}" userNm="${bc.userNm}"/></td>
										<td class="txt_center">${bc.regDt}</td>
										<td class="txt_center" colspan="2">${bc.modDt}</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					
						<!-- 하단 숫자 시작 -->
						<div class="paginate">
							<ui:pagination paginationInfo="${bcPaginationInfo}" type="image" jsFunction="bcSearch" />
						</div>
						<!-- 하단 숫자 끝 -->
					
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
