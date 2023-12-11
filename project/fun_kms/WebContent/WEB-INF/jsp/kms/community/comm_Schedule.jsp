<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function goYear(year) {
	document.schedule.scheYear.value = new Number(document.schedule.scheYear.value) + year;
	document.schedule.submit();
}
function goMonth(month) {
	document.schedule.moveMonth.value = month;
	document.schedule.submit();
}
function view(date) {
	document.schedule.scheDate.value = date;
	document.schedule.action = "<c:url value='${rootPath}/community/scheduleList.do'/>";
	document.schedule.submit();
}
function showLayer(scheId, obj) {
	var act = new yAjax("${rootPath}/ajax/getScheduleXml.do", "POST");
	act.send = "scheId=" + scheId;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var title = xml.getValue("title",0);
		var time = xml.getValue("time",0);
		var write = xml.getValue("write",0);
		var content = xml.getValue("content",0);
		document.getElementById("TT").innerHTML = title;
		document.getElementById("TM").innerHTML = time;
		document.getElementById("WR").innerHTML = write;
		document.getElementById("CN").innerHTML = content;
	};
	act.action();

	var position = $(obj).position();
	var height = $(obj).height();
	var width = $(obj).width();
	
	document.getElementById("detail_schedule").style.top = position.top + height + "px";
	document.getElementById("detail_schedule").style.left = position.left + width + "px";
	
	document.getElementById("detail_schedule").style.display="";
}
function hideLayer() {
	document.getElementById("detail_schedule").style.display="none";
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
							<li class="stitle">일정 공유</li>
							<li class="navi">홈 > 커뮤니티 > 일정공유 > 주요일정</li>
						</ul>
					</div>					
					
					<span class="stxt">직원들과 일정을 공유하는 곳입니다.<br/>
										날짜를 선택하여 상세 일정을 확인하거나 새로운 일정을 동록할 수 있습니다.
					</span>
	
					<!-- S: section -->
					<div class="section01">			
						
						<form name="schedule" method="POST" action="<c:url value="${rootPath}/community/scheduleCalendar.do"/>">
							<input type="hidden" name="scheYear" value="<c:out value='${searchVO.scheYear}'/>" />
							<input type="hidden" name="scheMonth" value="<c:out value='${searchVO.scheMonth}'/>" />
							<input type="hidden" name="scheDate" />
							<input type="hidden" name="moveMonth" value="0" />
							<input type="hidden" name="moveDate" value="0" />
						</form>
					
					<!-- 회사 일정 시작 -->	            
		            	<p class="th_stitle">일정공유</p>					
						<div class="scheduleDate02 mB20">
							<div class="month">						
								<ul>
									<li class="li_left"></li>
									<li class="txt01">
										<span class="schedule_date">
											<a href="javascript:goYear(-1);"><img src="${imagePath}/btn/btn_first.gif" alt="이전 년도" /></a>
			                				<a href="javascript:goMonth(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 달"></a>
			                				<span class="option_txt"><c:out value="${searchVO.scheYear}" />년 <c:out value="${searchVO.scheMonth}" />월</span>
											<a href="javascript:goMonth(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 달"></a>
			                				<a href="javascript:goYear(1);"><img src="${imagePath}/btn/btn_end.gif" alt="다음 년도"></a>
		                				</span>
									</li>
									<li class="txt02">
										<span class="schedule_date2">
											<img src="${imagePath}/community/ico_schedule_01.gif" /> 회사일정
											<img src="${imagePath}/community/ico_schedule_02.gif" /> 팀별일정
											<img src="${imagePath}/community/ico_schedule_03.gif" /> 개인일정
										</span>
									</li>
									<li class="li_right"></li>
								</ul>
							</div>
													
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
									<c:set var="isFirstDay" value="true"/>
									<c:forEach items="${resultList}" var="result">
										<c:if test="${isFirstDay == true}"> <!-- 첫날이면 빈칸만들기~ -->
											<c:forEach begin="1" end="${firstDay-1}" var="a">
												<td  <c:if test="${a == 1}">class="tbody_left" </c:if>>&nbsp;</td>
											</c:forEach>
											<c:set var="isFirstDay" value="false"/>
										</c:if>
										
										<td id="td_${result.date}" onclick="view('<c:out value="${result.date}" />');" style="cursor:pointer;"
												class='<c:if test="${result.day == 1}">tbody_left</c:if> <c:if test="${result.day == 7}">tbody_right</c:if>
												<c:if test="${fn:length(result.scheduleList) > 0 && result.holiday == false}">day_check</c:if>'>
											<c:choose>
												<c:when test="${result.day == 1}"><span class="txt_red"><c:out value="${result.date}" /></span></c:when>
												<c:when test="${result.day == 7}"><span class="txt_blue2"><c:out value="${result.date}" /></span></c:when>
												<c:otherwise><span>${result.date}</span></c:otherwise>
											</c:choose>
											<div class="holiday">
												<c:if test="${result.holiday}">
													
												</c:if>
												<c:forEach items="${result.scheduleList}" var="s">
													<p style="cursor:pointer;" onmouseover="showLayer('${s.scheId}',this.parentNode.parentNode);" onmouseout="hideLayer();" >
														<c:choose>
															<c:when test="${s.scheTyp == 'C'}">
																<img src="${imagePath}/community/ico_schedule_01.gif" /> <c:out value="${s.scheSjShort}" />
															</c:when>
															<c:when test="${s.scheTyp == 'T'}">
																<img src="${imagePath}/community/ico_schedule_02.gif" /> <c:out value="${s.scheSjShort}" />
															</c:when>
															<c:when test="${s.scheTyp == 'P'}">
																<img src="${imagePath}/community/ico_schedule_03.gif" /> <c:out value="${s.scheSjShort}" />
															</c:when>
															<c:otherwise>
															</c:otherwise>
														</c:choose>
													</p>
												</c:forEach>
											</div>
										</td>
										
										
										<c:if test="${result.date == lastDate}">
											<c:forEach begin="${result.day+1}" end="7" var="tmp">
												<td <c:if test="${tmp == 7}">class="tbody_right"</c:if> >&nbsp;</td>
											</c:forEach>
										</c:if>
										
										<c:if test="${result.day == 7 || result.date == lastDate}"> <!-- 토요일 -->
											<c:out value="</tr>" escapeXml="false"/>
											<c:out value="<tr>" escapeXml="false"/>
										</c:if>
										
									</c:forEach>
								</tr>
							</tbody>
							</table>
						</div>
						
						<div id="detail_schedule" style="display:none;">
							<dl>
								<dt id="TT">정기현 과장 애기 돌잔치</dt>
								<dd>
								 	<ul class="layer_left">
								 		<li>시&nbsp;&nbsp;&nbsp;간</li>
								 		<li>작성자</li>
								 		<li>내&nbsp;&nbsp;&nbsp;용</li>
								 	</ul>
								 	<ul class="layer_right">
								 		<li id="TM">14:30~15:30</li>
								 		<li id="WR">안태규</li>
								 		<li id="CN">정기현과장 딸 정시원 돌잔치정기현과장 딸 정시원 돌잔치정기현과장 딸 정시원 돌잔치</li>
								 	</ul>
								</dd>
							</dl>
						</div>
						<!-- 회사 일정 끝 -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<a href="${rootPath}/community/addScheduleView.do"><img src="${imagePath}/btn/btn_regist.gif"/></a>
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
