<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
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
							<li class="stitle">법인차량관리</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 법인차량 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col100" />
							<col class="col80" />
							<col class="col40" />
							<col width="px" />
							<col class="col120" />
							<col class="col80" />
							<col class="col70" />
							<col class="col70" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">차종</th>
							<th scope="col">차량번호</th>
							<th scope="col">사용자</th>
							<th scope="col">보험회사</th>
							<th scope="col">보험회사 연락처</th>
							<th scope="col">보험 만료일</th>
							<th scope="col">보험연령</th>
							<th scope="col">면허종류</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result">
								<tr>
									<td class="txt_center"><a href="${rootPath}/support/selectCarInfo.do?carId=${result.carId}">${result.carTyp}</a></td>
									<td class="txt_center"><a href="${rootPath}/support/selectCarInfo.do?carId=${result.carId}">${result.carId}</a></td>
									<td class="txt_center">${result.userPrint}</td>
									<td class="txt_center">${result.insComp}</td>
									<td class="txt_center">${result.insCallNo}</td>
									<td class="txt_center">${result.insEdatePrint}</td>
									<td class="txt_center">만 ${result.insAge}세</td>
									<td class="txt_center">${result.insLicTypPrint}</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
						</div>
						<!-- 버튼 시작 -->
		                <div class="btn_area mT20">
		                	<c:if test="${user.admin}">
		                		<a href="${rootPath}/support/insertCarInfoView.do"><img src="${imagePath}/btn/btn_carRegist.gif"/></a>
		                	</c:if>
		                	<a href="${rootPath}/support/insertCarFixInfoView.do"><img src="${imagePath}/btn/btn_repairRegist.gif"/></a>
		                	<a href="${rootPath}/support/insertCarRsvView.do"><img src="${imagePath}/btn/btn_carUseRegist.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->					
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
