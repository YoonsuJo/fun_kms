<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function goMonth(month) {
	document.schedule.moveMonth.value = month;
	document.schedule.submit();
}
function goDate(date) {
	document.schedule.moveDate.value = date;
	document.schedule.submit();
}
function modifySchedule(scheId) {
	document.subForm.scheId.value = scheId;
	document.subForm.action = "<c:url value='${rootPath}/community/modifySchedule.do' />";
	document.subForm.submit();
}
function deleteSchedule(scheId) {
	document.subForm.scheId.value = scheId;
	document.subForm.action = "<c:url value='${rootPath}/community/deleteSchedule.do' />";
	document.subForm.submit();
}
function toCalendar() {
	document.schedule.action = "<c:url value='${rootPath}/community/scheduleCalendar.do' />";
	document.schedule.submit();
}
function addSchedule() {
	document.schedule.action = "<c:url value='${rootPath}/community/addScheduleView.do' />";
	document.schedule.submit();
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
						<li class="stitle">상세 일정</li>
						<li class="navi">홈 > 커뮤니티 > 일정공유 > 주요일정</li>
					</ul>
				</div>				
				
				<!-- S: section -->
				<div class="section01">
						
				<!-- 날짜 선택창 시작 -->
                    <div class="scheduleDate mB20">
                		<a href="javascript:goMonth(-1);"><img src="${imagePath}/btn/btn_first.gif" alt="처음페이지" /></a>
                		<a href="javascript:goDate(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
                		<span class="option_txt"><c:out value="${searchVO.scheYear}" />년 <c:out value="${searchVO.scheMonth}" />월 <c:out value="${searchVO.scheDate}" />일</span>
						<a href="javascript:goDate(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
                		<a href="javascript:goMonth(1);"><img src="${imagePath}/btn/btn_end.gif" alt="마지막 페이지"></a>
					</div>
	            <!-- 날짜 선택창 끝 -->
	            
	            <!-- 회사 일정 시작 -->	            
	            	<p class="th_stitle">회사일정</p>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="회사일정 목록입니다.">
						<caption>회사일정</caption>
						<colgroup>
							<col class="col90" />
							<col class="col120" />
							<col width="px" />
							<col class="col120" />
							<col class="col90" />						
						</colgroup>
						<thead>
							<tr>
							<th scope="col">시간</th>
							<th scope="col">제목</th>
							<th scope="col">세부내용</th>
							<th scope="col">작성자</th>
							<th scope="col">수정/삭제</th>							
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty companySchedule}">
								<tr>
									<td colspan="5" class="txt_center">회사일정이 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${companySchedule}" var="cS">
								<tr>
									<td class="txt_center">
										<c:choose>
											<c:when test="${cS.scheTmTyp == 0}">하루종일</c:when>
											<c:otherwise><c:out value="${cS.scheTmFrom}" /> ~ <c:out value="${cS.scheTmTo}" /></c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center"><c:out value="${cS.scheSj}" /></td>
									<td>${cS.scheCn}</td>
									<td class="txt_center"><print:user userNo="${cS.userNo}" userNm="${cS.userNm}" userId="${cS.userId}" printId="true"/></td>
									<td class="txt_center">
										<c:if test="${user.admin || cS.userNo == user.no}">
										<span class="mR5"><a href="javascript:modifySchedule('<c:out value="${cS.scheId}"/>');"><img src="${imagePath}/btn/btn_plus02.gif"/></a></span>
										<span><a href="javascript:deleteSchedule('<c:out value="${cS.scheId}"/>');"><img src="${imagePath}/btn/btn_minus02.gif"/></a></span>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<!-- 회사 일정 끝 -->
					
					<!-- 부서 일정 시작 -->	            
	            	<p class="th_stitle">부서일정</p>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="부서일정 목록입니다.">
						<caption>부서일정</caption>
						<colgroup>
							<col class="col90" />
							<col class="col120" />
							<col class="col120" />
							<col width="px" />
							<col class="col120" />
							<col class="col90" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">시간</th>
							<th scope="col">제목</th>
							<th scope="col">부서</th>
							<th scope="col">세부내용</th>
							<th scope="col">작성자</th>
							<th scope="col">수정/삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty teamSchedule}">
								<tr>
									<td colspan="6" class="txt_center">부서일정이 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${teamSchedule}" var="tS">
								<tr>
									<td class="txt_center">
										<c:choose>
											<c:when test="${tS.scheTmTyp == 0}">하루종일</c:when>
											<c:otherwise><c:out value="${tS.scheTmFrom}" /> ~ <c:out value="${tS.scheTmTo}" /></c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center"><c:out value="${tS.scheSj}" /></td>
									<td class="txt_center"><c:out value="${tS.scheOrgnztNm}" /></td>
									<td>${tS.scheCn}</td>
									<td class="txt_center"><print:user userNo="${tS.userNo}" userNm="${tS.userNm}" userId="${tS.userId}" printId="true"/></td>
									<td class="txt_center">
										<c:if test="${user.admin || tS.userNo == user.no}">
										<span class="mR5"><a href="javascript:modifySchedule('<c:out value="${tS.scheId}"/>');"><img src="${imagePath}/btn/btn_plus02.gif"/></a></span>
										<span><a href="javascript:deleteSchedule('<c:out value="${tS.scheId}"/>');"><img src="${imagePath}/btn/btn_minus02.gif"/></a></span>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<!-- 부서 일정 끝 -->
					
					<!-- 개인 일정 시작 -->	            
	            	<p class="th_stitle">개인일정</p>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="개인일정 목록입니다.">
						<caption>개인일정</caption>
						<colgroup>	
							<col class="col90" />
							<col class="col150" />
							<col width="px" />
							<col class="col90" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">시간</th>
							<th scope="col">제목</th>
							<th scope="col">세부내용</th>
							<th scope="col">수정/삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty privateSchedule}">
								<tr>
									<td colspan="4" class="txt_center">개인일정이 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${privateSchedule}" var="pS">
								<tr>
									<td class="txt_center">
										<c:choose>
											<c:when test="${pS.scheTmTyp == 0}">하루종일</c:when>
											<c:otherwise><c:out value="${pS.scheTmFrom}" /> ~ <c:out value="${pS.scheTmTo}" /></c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center"><c:out value="${pS.scheSj}" /></td>
									<td>${pS.scheCn}</td>
									<td class="txt_center">
										<c:if test="${user.admin || pS.userNo == user.no}">
										<span class="mR5"><a href="javascript:modifySchedule('<c:out value="${pS.scheId}"/>');"><img src="${imagePath}/btn/btn_plus02.gif"/></a></span>
										<span><a href="javascript:deleteSchedule('<c:out value="${pS.scheId}"/>');"><img src="${imagePath}/btn/btn_minus02.gif"/></a></span>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<!-- 개인 일정 끝 -->
					
					
					<form name="schedule" method="POST" action="<c:url value="${rootPath}/community/scheduleList.do"/>">
						<input type="hidden" name="scheYear" value="<c:out value='${searchVO.scheYear}'/>" />
						<input type="hidden" name="scheMonth" value="<c:out value='${searchVO.scheMonth}'/>" />
						<input type="hidden" name="scheDate" value="<c:out value='${searchVO.scheDate}'/>" />
						<input type="hidden" name="moveMonth" value="0" />
						<input type="hidden" name="moveDate" value="0" />
						<input type="hidden" name="date" value="<c:out value='${searchVO.scheYear}'/><c:out value='${searchVO.scheMonth}'/><c:out value='${searchVO.scheDate}'/>" />
					</form>
					
					<form name="subForm" method="POST" action="<c:url value="${rootPath}/community/modifySchedule.do"/>">
						<input type="hidden" name="scheId" />
					</form>
										
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<ul>
                			<li><a href="javascript:addSchedule();"><img src="${imagePath}/btn/btn_regist.gif"/></a></li>
                			<li><a href="javascript:toCalendar();"><img src="${imagePath}/btn/btn_list.gif"/></a></li>
                		</ul>
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
