<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>

				<!-- 날짜 선택창 시작 -->
					<div class="month">
						<ul>
							<li>
								<a href="javascript:chngYear(-1)"><img src="${imagePath}/btn/btn_first.gif" alt="처음페이지" /></a>
								<a href="javascript:chngMonth(-1)" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
							</li>
							<li class="txtB_Black">${calendarInfo.calYear}. ${calendarInfo.calMonth}</li>
							<li>
								<a href="javascript:chngMonth(1)" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
								<a href="javascript:chngYear(1)"><img src="${imagePath}/btn/btn_end.gif" alt="마지막 페이지"></a>
							</li>
						</ul>
					</div>
	            <!--// 날짜 선택창 끝 -->
	            
					<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>일정공유</caption>						
						<thead>
							<tr>
								<th><img src="${imagePath}/inc/calendar_sun.gif"/></th>
								<th><img src="${imagePath}/inc/calendar_mon.gif"/></th>
								<th><img src="${imagePath}/inc/calendar_tue.gif"/></th>
								<th><img src="${imagePath}/inc/calendar_wed.gif"/></th>
								<th><img src="${imagePath}/inc/calendar_thur.gif"/></th>
								<th><img src="${imagePath}/inc/calendar_fri.gif"/></th>
								<th><img src="${imagePath}/inc/calendar_sat.gif"/></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<c:set var="isFirstDay" value="true"/>
								<c:forEach items="${calendarInfo.calList}" var="result">
									<c:if test="${isFirstDay == true}"> <!-- 첫날이면 빈칸만들기~ -->
										<c:forEach begin="1" end="${calendarInfo.firstDay-1}">
											<td>&nbsp;</td>
										</c:forEach>
										<c:set var="isFirstDay" value="false"/>
									</c:if>
									
									<td id="td_${result.date}" onclick="chngDate('<c:out value="${result.date}" />');"
										<c:if test="${result.date == calendarInfo.date}">class="Date"</c:if> >
										<c:choose>
											<c:when test="${result.day == 1}"><span class="txt_red"><c:out value="${result.dd}" /></span></c:when>
											<c:when test="${result.day == 7}"><span class="txt_blue2"><c:out value="${result.dd}" /></span></c:when>
											<c:otherwise><c:out value="${result.dd}" /></c:otherwise>
										</c:choose>
									</td>
									
									
									<c:if test="${result.dd == calendarInfo.lastDate}">
										<c:forEach begin="${result.day+1}" end="7">
											<td>&nbsp;</td>
										</c:forEach>
									</c:if>
									
									<c:if test="${result.day == 7 || result.date == calendarInfo.lastDate}"> <!-- 토요일 -->
										<c:out value="</tr>" escapeXml="false"/>
										<c:out value="<tr>" escapeXml="false"/>
									</c:if>
								</c:forEach>
							</tr>	
						</tbody>
					</table>
