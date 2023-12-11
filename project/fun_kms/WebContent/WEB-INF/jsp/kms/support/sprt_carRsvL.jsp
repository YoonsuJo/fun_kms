<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function showDetail(no, obj) {
	$('#detail_schedule02').html('');
	var position = $(obj).position();
	var width = $(obj).width();
	
	$.post("/ajax/selectCarRsvInfo.do?no=" + no,
			function(data){
				$('#detail_schedule02').html(data);
			}
	);

	document.getElementById("detail_schedule02").style.top = position.top + 10 + "px";
	document.getElementById("detail_schedule02").style.left = position.left + width - 10 + "px";
	$('#detail_schedule02').show();
}
function hideDetail() {
	$('#detail_schedule02').hide();
}
function search(moveMonth) {
	document.frm.moveMonth.value = moveMonth;
	document.frm.submit();
}
function setCarImg() {
	$('.corpCar').each(function() {
		var carImg = $('.carList').find('#' + $(this).attr('carId')).find('img').clone();
		var tmp = $(this).html();
		$(this).html(carImg);
		$(this).append(tmp);
	});
}
$(document).ready(function() {
	setCarImg();
});
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
							<li class="stitle">법인차량 예약현황</li>
							<li class="navi">홈 > 업무지원 > 각종신청 > 법인차량 사용신청</li>
						</ul>
					</div>					
	
					<!-- S: section -->
					<div class="section01">			
						<div class="carList mB10">
							<ul>
								<c:forEach items="${carList}" var="car">
									<li id="${car.carId}">
										<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${car.imgFileId}" />
										</c:import>										
									</li>
									<p class="th_stitle mT10 mB10">${car.carTyp}(${car.carId})</p>
								</c:forEach>
							</ul>
						</div>
						<!-- 회사 일정 시작 -->
						<div class="scheduleDate02 mB20">
							<form name="frm" action="${rootPath}/support/selectCarRsvCalendar.do" method="POST">
							<input type="hidden" name="searchDate" value="${searchVO.searchDate}"/>
							<input type="hidden" name="moveMonth"/>
							<div class="month">						
								<ul>
									<li class="li_left"></li>
									<li class="li_center">
										<span class="schedule_date">
			                				<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
			                				<span class="option_txt">${fn:substring(searchVO.searchDate,0,4)}년 ${fn:substring(searchVO.searchDate,4,6)}월</span>
											<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
		                				</span>
									</li>
									<li class="li_right"></li>
								</ul>
							</div>
							</form>
													
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>일정공유</caption>						
							<thead>
								<tr>
									<th><span class="txtB_red">일</span><span class="txt_red2">(Sun)</span></th>
									<th>월<span class="txt_grey">(Mon)</span></th>
									<th>화<span class="txt_grey">(Tue)</span></th>
									<th>수<span class="txt_grey">(Wed)</span></th>
									<th>목<span class="txt_grey">(Thu)</span></th>
									<th>금<span class="txt_grey">(Fri)</span></th>
									<th><span class="txtB_blue2">토</span><span class="txt_blue3">(Sat)</span></th>
								</tr>
								<tr>
									<th colspan="7" class="white_line"></th>
								</tr>
							</thead>
							
							<tbody>
								<tr class="grey_line">
									<c:forEach items="${resultList}" var="result">
										<c:if test="${result.firstDate == true}"> <!-- 첫날이면 빈칸만들기~ -->
											<c:forEach begin="1" end="${result.day-1}" var="a">
												<td  <c:if test="${a == 1}">class="tbody_left" </c:if>>&nbsp;</td>
											</c:forEach>
										</c:if>
										
										<td id="td_${result.date}" onclick="location.href='selectCarRsvInfoList.do?searchDate=${result.dateString}'"
											class='cursorPointer
											<c:if test="${result.day == 1}">tbody_left</c:if>
											<c:if test="${result.day == 7}">tbody_right</c:if>
											<c:if test="${today == result.dateString}">day_check</c:if>' >
											<c:choose>
												<c:when test="${result.day == 1}"><span class="txt_red"><c:out value="${result.date}" /></span></c:when>
												<c:when test="${result.day == 7}"><span class="txt_blue2"><c:out value="${result.date}" /></span></c:when>
												<c:otherwise><span>${result.date}</span></c:otherwise>
											</c:choose>
											<c:forEach items="${result.carRsvList}" var="rsv">
												<div class="corpCar" carId="${rsv.carId}" onmouseover="showDetail('${rsv.no}', this);" onmouseout="hideDetail();">
													${rsv.userNm}
												</div>
											</c:forEach>
										</td>
										
										
										<c:if test="${result.lastDate}">
											<c:forEach begin="${result.day + 1}" end="7" var="tmp">
												<td <c:if test="${tmp == 7}">class="tbody_right"</c:if> >&nbsp;</td>
											</c:forEach>
										</c:if>
										
										<c:if test="${result.day == 7 || result.lastDate}"> <!-- 토요일 -->
											<c:out value="</tr>" escapeXml="false"/>
											<c:out value="<tr>" escapeXml="false"/>
										</c:if>
										
									</c:forEach>
								</tr>
							</tbody>
							</table>
						</div>
						
						<div id="detail_schedule02" style="display:none">
						</div>
						<!-- 회사 일정 끝 -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<a href="${rootPath}/support/insertCarRsvView.do"><img src="${imagePath}/btn/btn_carUseReserve.gif" class="search_btn02"/></a>
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
