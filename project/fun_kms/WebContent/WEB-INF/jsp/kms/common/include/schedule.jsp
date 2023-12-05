<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
					<div class="schedule_tab">
						<ul>
							<li class="on"  id="tab_1" onclick="chngSchedule(1);" style="cursor:pointer;">일정</li>
							<li class="off" id="tab_2" onclick="chngSchedule(2);" style="cursor:pointer;">할일</li>
						</ul>
					</div>
					<div class="schedule_con" id="sche_1">
						<dl>
							<dt>${scheduleInfo.date}<span class="arrow_down02"><a href="${rootPath}/community/addScheduleView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></span></dt>
							<dd class="detail_schedule">
								<c:forEach items="${scheduleInfo.scheList}" var="sc">
									<ul onmouseover="showTooltip(this);" onmouseout="hideTooltip(this);">
										<input type="hidden" name="scheTmTyp" value="${sc.scheTmTyp}"/>
										<input type="hidden" name="scheTmFrom" value="${sc.scheTmFrom}"/>
										<input type="hidden" name="scheTmTo" value="${sc.scheTmTo}"/>
										<div name="scheCn" style="display:none;">${sc.scheCn}</div>
										<input type="hidden" name="userNm" value="${sc.userNm}"/>
										<input type="hidden" name="scheOrgnztNm" value="${sc.scheOrgnztNm}"/>
										<input type="hidden" name="scheTyp" value="${sc.scheTyp}"/>
										<div name="scheSj" style="display:none;"><print:strShort length="16" str="${sc.scheSj}"/></div>
										<li>
											<c:choose>
												<c:when test="${sc.scheTyp == 'C'}">
													<img src="${imagePath}/community/ico_schedule_01.gif" />
												</c:when>
												<c:when test="${sc.scheTyp == 'T'}">
													<img src="${imagePath}/community/ico_schedule_02.gif" />
												</c:when>
												<c:when test="${sc.scheTyp == 'P'}">
													<img src="${imagePath}/community/ico_schedule_03.gif" />
												</c:when>
												<c:otherwise>
													<img src="${imagePath}/community/ico_schedule_04.gif" />
												</c:otherwise>
											</c:choose>
											<%--<print:strShort length="16" str="${sc.scheSj}"/> --%>
										</li>
										<li class="sdetail">
											<c:if test=""></c:if>
											<ul <c:if test="${sc.scheTyp == 'C' || sc.scheTyp == 'T' || sc.scheTyp == 'P'}">class="cursorPointer" onclick="javascript:goSchedule();"</c:if>>
												<li>
													<c:choose>
														<c:when test="${sc.scheTmTyp == 0}">하루종일</c:when>
														<c:otherwise><c:out value="${sc.scheTmFrom}" /> ~ <c:out value="${sc.scheTmTo}" /></c:otherwise>
													</c:choose>
												</li>
												<li><print:strShort length="10" str="${sc.scheSj}"/></li>
											</ul>
										</li>
										<li class="sdetail_btn" style="display:none;">
											<c:if test="${user.no == sc.userNo}">
												<a href="javascript:modifySchedule2('<c:out value="${sc.scheId}"/>');"><img src="${imagePath}/btn/btn_plus02.gif" /></a>
												<a href="javascript:deleteSchedule2('<c:out value="${sc.scheId}"/>');"><img src="${imagePath}/btn/btn_minus02.gif" /></a>
											</c:if>
										</li>
									</ul>
								</c:forEach>
							</dd>
						</dl>
					</div>
					<div class="schedule_con" id="sche_2" style="display:none">
						<dl>
							<dt>${scheduleInfo.date}<span class="arrow_down02"><a href="javascript:writeTask2()"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></span></dt>
							<dd class="detail_schedule02">
								<c:forEach items="${taskList}" var="task">
								<ul class="Worklist">
									<c:choose>
										<c:when test="${task.taskDuedate < today && task.taskDuedate != ''}">
											<li class="WorkTitle txtB_red" >${task.taskSjShort}
											<span class="adBtn"><a href="javascript:writeDayReport2('${task.taskId}')"><img src="${imagePath}/btn/btn_plus02.gif" /></a></span>
											</li>
											<li class="txt_red2">완료예정일 : ${task.taskDuedatePrint}</li>
	                   					</c:when>
	                   					<c:when test="${task.taskDuedate == today}">
											<li class="WorkTitle txtB_blue2">${task.taskSjShort}
											<span class="adBtn"><a href="javascript:writeDayReport2('${task.taskId}')"><img src="${imagePath}/btn/btn_plus02.gif" /></a></span>
											</li>
											<li class="txt_blue3">완료예정일 : ${task.taskDuedatePrint}</li>
	                   					</c:when>
	                   					<c:otherwise>
											<li class="WorkTitle txtB_Black">${task.taskSjShort}
											<span class="adBtn"><a href="javascript:writeDayReport2('${task.taskId}')"><img src="${imagePath}/btn/btn_plus02.gif" /></a></span>
											</li>
											<li class="txt_grey">완료예정일 : ${task.taskDuedatePrint}</li>
	                   					</c:otherwise>
									</c:choose>
								</ul>
								</c:forEach>
							</dd>
						</dl>
					</div>
