<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
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
							<li class="stitle">사용자 통합검색 결과</li>
							<li class="navi">홈 > 사용자 통합검색 결과</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
					
						<p class="th_stitle">검색된 사용자 : 총 ${fn:length(resultList)}명</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col40" />
								<col class="col70" />
								<col class="col80" />
								<col class="col70" />
								<col width="px" />
								<col class="col80" />
								<col class="col100" />
								<col class="col50"/>
								<col class="col80" />
								<col class="col5" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">사번</th>
								<th scope="col">이름</th>
								<th scope="col">ID</th>
								<th scope="col">직급</th>
								<th scope="col">소속부서</th>
								<th scope="col">휴대전화</th>
								<th scope="col">내선</th>
								<th scope="col">상태</th>
								<th class="th_right" colspan="2"> </th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result">
									<tr>
										<td class="txt_center">
										<a href="${rootPath}/member/selectMemberMain.do?no=${result.no}">
										${result.sabun}</a></td>
										<td class="txt_center">
										<print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center">
										<a href="${rootPath}/member/selectMemberMain.do?no=${result.no}">
										${result.userId}</a></td>
										<td class="txt_center">
										<a href="${rootPath}/member/selectMemberMain.do?no=${result.no}">
										${result.rankNm}</a></td>
										<td class="txt_center">
										<a href="${rootPath}/member/selectMemberMain.do?no=${result.no}">
										<!-- 2013.07.24 김대현 전체소속경로로 표시 -->
										<!-- ${result.orgnztNm} -->
										${result.orgnztNmFullLong}
										</a></td>
										<td class="txt_center">
										<a href="${rootPath}/member/selectMemberMain.do?no=${result.no}">
										${result.moblphonNo}</a></td>
										<td class="txt_center">
										<a href="${rootPath}/member/selectMemberMain.do?no=${result.no}">
										${result.offmTelnoInner}</a></td>
										<td class="txt_center">
										<a href="${rootPath}/member/selectMemberMain.do?no=${result.no}">
										${result.workStPrint}</a></td>
										<td class="txt_center" colspan="2">
										<a href="${rootPath}/member/selectMemberMain.do?no=${result.no}">
										<img src="${imagePath }/btn/btn_detailInfo.gif"/>
										</a></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					
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
