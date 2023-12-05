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
							<li class="stitle">법인차량 예약 상세정보</li>
							<li class="navi">홈 > 업무지원 > 각종신청 > 법인차량 사용신청</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
		                    <div class="scheduleDate mB20">
		                		<ul>
			                		<li class="li_left">
			               	 			<a href="${rootPath}/support/selectCarRsvInfoList.do?searchDate=${searchVO.searchDate}&moveDate=-1" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
			                			<span class="option_txt"><input type="text" class="span_4 calGen" name="searchDate" value="${searchVO.searchDate}"></span>
										<a href="${rootPath}/support/selectCarRsvInfoList.do?searchDate=${searchVO.searchDate}&moveDate=1" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
			                		</li>
		                		</ul>
							</div>
		                </fieldset>
		            	<!--// 상단 검색창 끝 -->
		            	
						<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup><col class="col5" /><col class="col80" /><col class="col60" /><col class="col60" /><col class="col100" /><col class="col60" /><col class="col60" /><col class="col80" /><col width="px" /><col class="col40" /><col class="col5" /></colgroup>
						<thead>
							<tr>
							<th class="th_left"> </th>
							<th scope="col">차량구분</th>
							<th scope="col">사용자</th>
							<th scope="col">예약자</th>
							<th scope="col">사용기간</th>
							<th scope="col">사용목적</th>
							<th scope="col">행선지</th>
							<th scope="col">운행예정거리</th>
							<th scope="col">비고</th>
							<th scope="col">&nbsp;</th>
							<th class="th_right"> </th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result">
								<tr>
									<td class="txt_center" colspan="2">${result.carTyp}<br/>(${result.carId})</td>
									<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${result.stDtPrint} ${result.stTm}시 ~ ${result.edDtPrint} ${result.edTm}시</td>
									<td class="txt_center">${result.purposePrint}</td>
									<td class="txt_center">${result.destination}</td>
									<td class="txt_center">${result.runLength} km</td>
									<td class="txt_center">${result.rsvNote}</td>
									<td class="txt_center" colspan="2">
										<c:if test="${user.userNo == result.userNo || user.userNo == result.writerNo || user.admin}">
											<a href="${rootPath}/support/updateCarRsvView.do?no=${result.no}"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
											<a href="${rootPath}/support/deleteCarRsv.do?no=${result.no}"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
						</div>
						<!-- 버튼 시작 -->
		                <div class="btn_area mT20">
		                	<a href="${rootPath}/support/insertCarRsvView.do"><img src="${imagePath}/btn/btn_carUseReserve.gif"/></a>
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
