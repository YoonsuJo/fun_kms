<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<!-- S: left -->
			<div id="left">
				<!--체크리스트-->
				<div class="left_chk" id="chkList">
					<c:import url="${rootPath}/common/getCheckList.do">
					</c:import>
				</div>
				<ul class="left_bg">
					<li class="left_bg_left"></li>
					<li class="left_bg_right"></li>
				</ul>
				<div class="left_menu">
					<h3><a href="${rootPath}/member/selectMemberMain.do">인사정보</a><div class="arrow_down"><img src="${imagePath}/inc/arrow_down01.gif" alt="화살표"/></div></h3>
					<ul class="menu_list">
						<c:if test="${user.isNegoYn=='Y' }">
							<li><a href="${rootPath}/member/selectEmpContract.do">연봉정보</a>
								<ul class="smenu">
<!--									<li><a href="${rootPath}/member/mem_pop_AbilityChart01.jsp">능력고과</a></li>	-->																						
									<li><a href="${rootPath}/member/selectMemberSalaryNego.do">연봉협상</a></li>
									<c:if test="${user.isSalaryadmin=='Y' }">
										<li><a href="${rootPath}/member/selectEmpContract.do">연봉계약서</a></li>
									</c:if>
								</ul>
							</li>		
						</c:if>
						<c:if test="${user.isSalaryadmin=='Y' }">
							<li><a href="${rootPath}/admin/salary/salaryRealCEOMain.do">대표이사 업무</a>
								<ul class="smenu">
									<li><a href="${rootPath}/admin/salary/salaryRealCEOMain.do">사원연봉결정</a></li>
								</ul>
							</li>
						</c:if>
						
						<li><a href="${rootPath}/member/selectMemberList.do">사원정보</a>
							<ul class="smenu">
								<li><a href="${rootPath}/member/selectMemberList.do">사원조회</a></li>
								<li><a href="${rootPath}/member/selectMemberCareerList.do">이력관리</a></li>
								<li><a href="${rootPath}/member/selectPositionHistoryList.do">인사발령</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/member/dailyWorkStateStatistic.do">근무현황</a>
							<ul class="smenu">								
								<li><a href="${rootPath}/member/dailyWorkStateStatistic.do">일일근태기록</a></li>
								<li><a href="${rootPath}/member/selectAbsenceState.do">현재시각 부재자 현황</a> <a href="${rootPath}/member/insertAbsenceView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
								<li><a href="${rootPath}/member/workStateStatistic.do">근태통계</a></li>
								<li><a href="${rootPath}/member/selectOvertimeList.do">연장근무통계</a></li>
								<li><a href="${rootPath}/member/selectOvertimeView.do">연장근무내역</a> <a href="${rootPath}/member/insertOvertimeView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>								
								<li><a href="${rootPath}/member/selectVacationSummaryView.do">휴가사용내역</a> <a href="${rootPath}/approval/approvalW.do?templtId=2"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
								<li><a href="${rootPath}/member/selectHolidayWorkStatisticView.do">휴일근무내역</a> <a href="${rootPath}/approval/approvalW.do?templtId=5"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/member/selectSelfDevView.do">복리후생</a>
							<ul class="smenu">
								<li><a href="${rootPath}/member/selectSelfDevView.do">자기개발비 사용내역</a></li>
								<!-- <li><a href="${rootPath}/member/diningMoneyStatisticView.do">팀장경비 사용내역</a></li> -->
							</ul>
						</li>
						<li><a href="${rootPath}/member/selectMemberCareerList.do">이력관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/member/selectMemberCareerList.do">이력관리 조회</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<!-- E: left -->
<script type="text/javascript">
	initTopMenu();//1,2차메뉴롤오버함수할당
</script>