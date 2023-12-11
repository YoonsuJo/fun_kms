<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function viewBoard(nttId, bbsId, readBool) {
	document.subForm.nttId.value = nttId;
	document.subForm.bbsId.value = bbsId;
	document.subForm.readBool.value = readBool;
	document.subForm.action = "<c:url value='${rootPath}/community/selectBoardArticle.do'/>";
	document.subForm.submit();
}


function viewMail(mailId) {
	document.subForm.mailId.value = mailId;
	document.subForm.action = "<c:url value='${rootPath}/community/selectMail.do'/>";
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
							<li class="stitle">커뮤니티 현황</li>
							<li class="navi">홈 > 커뮤니티 > 커뮤니티현황</li>
						</ul>
					</div>
					
					<span class="stxt">커뮤니티의 게시물 현황을 확인할 수 있습니다.</span>
	
					<!-- S: section -->
					<div class="section01">
	
						<p class="th_stitle">자유게시판 최근/미열람 목록 <span class="th_plus"><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000001">더보기</a></span></p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="자유게시판 최근 미열람 목록입니다.">
							<caption>자유게시판 최근/미열람 목록 </caption>
							<colgroup>
								<col width="px" />
								<col class="col120" />
								<col class="col90" />
								<col class="col50" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">등록일시</th>
									<th scope="col">조회수</th>								
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultMap.freeList}" var="result">
									<tr>
										<td>
<!--											<a href="javascript:viewBoard('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>','<c:out value="${result.readBool}"/>');">-->
											<a href="<c:url value='${rootPath}/community/selectBoardArticle.do?bbsId=${result.bbsId}&nttId=${result.nttId}&reedBool=${result.readBool}'/>">
												<c:if test="${result.replyAt == 'Y'}"><c:forEach begin="1" end="${result.replyLc}">&nbsp;&nbsp;</c:forEach><img src="${imagePath}/board/icon_re.gif" /></c:if>
												<c:choose>
													<c:when test="${result.readBool == 'Y'}"><c:out value="${result.nttSj}"/> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:when>
													<c:otherwise><span class="txt_red"><c:out value="${result.nttSj}"/></span> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:otherwise>
												</c:choose>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" printId="true"/></td>
										<td class="txt_center"><c:out value="${result.frstRegisterPnttm}"/></td>
										<td class="txt_center"><c:out value="${result.inqireCo}"/></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
	
						<p class="th_stitle">사내메일 최근/미열람 목록 <span class="th_plus"><a href="${rootPath}/community/selectRecieveMailList.do">더보기</a></span></p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="사내메일 최근 미열람 목록입니다.">
							<caption>사내메일 최근/미열람 목록</caption>
							<colgroup>
								<col class="col120" />
								<col width="px" />
								<col class="col120" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">보낸사람</th>
								<th scope="col">제목</th>
								<th scope="col">수신일시</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultMap.mailList}" var="result">
									<tr>
										<td class="txt_center"><print:user userNo="${result.senderNo}" userNm="${result.senderNm}" userId="${result.senderId}" printId="true"/></td>
										<td>
											<a href="javascript:viewMail('<c:out value="${result.mailId}"/>');">
											<c:choose>
												<c:when test="${empty result.readDt || result.readDt == ''}">
													<span class="txt_red"><c:out value="${result.mailSj}"/></span>
												</c:when>
												<c:otherwise>
													<c:out value="${result.mailSj}"/>
												</c:otherwise>
											</c:choose>
											</a>
										</td>
										<td class="txt_center"><c:out value="${result.sendDt}"/></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						
						<p class="th_stitle">토론 최근/미열람 목록 <span class="th_plus"><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000029">더보기</a></span></p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="토론 최근 미열람 목록입니다.">
							<caption>토론 최근/미열람 목록 </caption>
							<colgroup>
								<col width="px" />
								<col class="col120" />
								<col class="col90" />
								<col class="col50" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">등록일시</th>
								<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultMap.discussList}" var="result">
									<tr>
										<td>
<!--											<a href="javascript:viewBoard('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>','<c:out value="${result.readBool}"/>');">-->
												<a href="<c:url value='${rootPath}/community/selectBoardArticle.do?bbsId=${result.bbsId}&nttId=${result.nttId}&reedBool=${result.readBool}'/>">
												<c:if test="${result.replyAt == 'Y'}"><c:forEach begin="1" end="${result.replyLc}">&nbsp;&nbsp;</c:forEach><img src="${imagePath}/board/icon_re.gif" /></c:if>
												<c:choose>
													<c:when test="${result.readBool == 'Y'}"><c:out value="${result.nttSj}"/> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:when>
													<c:otherwise><span class="txt_red"><c:out value="${result.nttSj}"/></span> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:otherwise>
												</c:choose>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" printId="true"/></td>
										<td class="txt_center"><c:out value="${result.frstRegisterPnttm}"/></td>
										<td class="txt_center"><c:out value="${result.inqireCo}"/></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>

						<form name="subForm" method="post" action="<c:url value='${rootPath}/community/selectMail.do'/>">
							<input type="hidden" name="bbsId" />
							<input type="hidden" name="nttId" />
							<input type="hidden" name="readBool" />
							<input type="hidden" name="mailId" />
							<input name="readChk" type="hidden" value="Y"/>
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
