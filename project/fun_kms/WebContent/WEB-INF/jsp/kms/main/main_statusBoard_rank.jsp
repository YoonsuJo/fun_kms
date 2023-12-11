<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search() {
	document.frm.submit();
}
</script>
</head>

<body style="overflow-X:hidden">

<div id="wrap">
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents2">
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
			<div id="center_rank">
				<div class="path_navi">
					<ul>
						<li class="stitle">랭킹보기 </li>
						<li class="navi">홈 > 랭킹보기&nbsp;&nbsp;</li>
					</ul>
				</div>	
				
				<!-- S: section -->
				<div class="section01">
				
					<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST" action="${rootPath}/main/rankList.do" onsubmit="search(0); return false;">
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
	                		<li class="li_left">
	                			<span class="option_txt"><input type="text" class="input01 span_4 calGen" name="searchStartDate" value="${searchStartDate}"/></span>&nbsp;~&nbsp;
	                			<span class="option_txt"><input type="text" class="input01 span_4 calGen" name="searchEndDate" value="${searchEndDate}"/></span>
	                		</li>
	                		<li class="li_right">
	                			<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(); return false;"/>
	                		</li>
	                		</ul>
						</div>
	                </fieldset>
			   		</form>
	            	<!--// 상단 검색창 끝 -->
				
				
					<!-- 전체순위 시작  -->
	             	<div class="s_rank1">
						<p class="th_stitle">종합</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>건의/제안 상세 정보</caption>
							<colgroup>
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">순위</th>
								<th scope="col">이름</th>
								<th scope="col">총점</th>
								<th scope="col">커뮤<br/>니티</th>
								<th scope="col">일일<br/>업무</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${totalList}" var="result" varStatus="c">
								<!-- <tr <c:if test="${result.itsMe == '1' }">class="TrBg2"</c:if>> -->
									<tr class="TrBg<c:choose><c:when test="${result.itsMe == '1' }">0</c:when><c:otherwise>1</c:otherwise></c:choose>">
										<td class="txt_center">${result.rank }위</td>
										<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center">${result.totalPoint }</td>
										<td class="txt_center">${result.communityTotalPoint }</td>
										<td class="txt_center">${result.reportTotalPoint }</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					</div>
					<!-- 전체순위 끝 -->
					<!-- 커뮤니티 시작  -->
	             	<div class="s_rank2">
						<p class="th_stitle">커뮤니티</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>건의/제안 상세 정보</caption>
							<colgroup>
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">순위</th>
								<th scope="col">이름</th>
								<th scope="col">총점</th>
								<th scope="col">게시물<br/>작성</th>
								<th scope="col">덧글<br/>작성</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${communityList}" var="result" varStatus="c">
									<tr class="TrBg<c:choose><c:when test="${result.itsMe == '1' }">0</c:when><c:otherwise>1</c:otherwise></c:choose>">
										<td class="txt_center">${result.rank }위</td>
										<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center">${result.communityTotalPoint }</td>
										<td class="txt_center">${result.communityAtt1Point }</td>
										<td class="txt_center">${result.communityAtt2Point }</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					</div>
					<!-- 커뮤니티 끝 -->
					<!-- 나의업무보고 시작  -->
	             	<div class="s_rank3">
						<p class="th_stitle">나의업무보고</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>건의/제안 상세 정보</caption>
							<colgroup>
								<col width="px" />
								<col width="px" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">순위</th>
								<th scope="col">이름</th>
								<th scope="col">실적<br/>등록</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${reportList}" var="result" varStatus="c">
									<tr class="TrBg<c:choose><c:when test="${result.itsMe == '1' }">0</c:when><c:otherwise>1</c:otherwise></c:choose>">
										<td class="txt_center">${result.rank }위</td>
										<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center">${result.reportTotalPoint }</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					</div>
					<!-- 나의업무보고 끝 -->
					<!-- 나의업무보고 시작  -->
	             	<div class="s_rank4">
						<p class="th_stitle">한마음게임</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>한마음게임</caption>
							<colgroup>
								<col width="px" />
								<col width="px" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">순위</th>
								<th scope="col">이름</th>
								<th scope="col">최고<br/>점수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${gameList}" var="result" varStatus="c">
									<tr class="TrBg<c:choose><c:when test="${result.itsMe == '1' }">0</c:when><c:otherwise>1</c:otherwise></c:choose>">
										<td class="txt_center">${result.rank }위</td>
										<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center">${result.gameTotalPoint }</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					</div>
					<!-- 나의업무보고 끝 -->

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
</div>
</body>
</html>
