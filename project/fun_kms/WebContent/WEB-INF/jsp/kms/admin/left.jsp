<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ include file="../include/ajax_inc.jsp"%>
			<!-- S: left -->
			<div id="left">
				<!--관리자페이지-->				
				<div class="left_chk">
					<h2>
						관리자페이지
						<a href="/statusBoard.do"><div class="replay">
							<img src="${imagePath}/btn/btn_replay.gif" alt="새로고침"/></div>
						</a>
					</h2>
				</div>
				<ul class="left_bg">
					<li class="left_bg_left"></li>
					<li class="left_bg_right"></li>
				</ul>
				<div class="left_menu">
					<ul class="menu_list">
						<li>사용 현황</a>
							<ul class="smenu">
								<li><a href="${rootPath}/admin/status/loginStatusL.do">개인별 로그인 현황</a></li>
							</ul>
						</li>
						<li><a href="/admin/approval/approvalL.do">전자결재 관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/admin/approval/approvalL.do">양식설정관리</a></li>
								<li>표준보고양식 관리(진행예정)</li>
<!--								<li><a href="javascript:alert('진행예정입니다.');">표준보고양식 관리</a></li>-->
								<li><a href="${rootPath}/admin/approval/selectAccountList.do">계정과목 관리</a></li>
								<li><a href="${rootPath}/admin/approval/selectPresetList.do">지출결의서 프리셋 관리</a></li>
								<li><a href="${rootPath}/admin/approval/selectCardSpendList.do">법인카드 사용내역 관리</a></li>
								<li><a href="${rootPath}/admin/approval/selectSelfdevList.do">자기개발비 한도 관리</a></li>
								<c:if test="${user.isHmdev == 'Y'}">
									<li><a href="${rootPath}/admin/approval/selectVacationList.do">전직원 일괄 휴가 처리</a></li>
								</c:if>
							</ul>
						</li>	
						<li><a href="${rootPath}/admin/score/scorePolicyMain.do">점수 관리</a></li>


						<script>
							function openPop(url,target,opt) {
							var popup = window.open(url,target,opt);
								popup.focus();
						}
						</script>

<%--						<li><a href="#">알림톡 관리</a>--%>
<%--							<ul class="smenu">--%>
<%--								<li><a href="javascript:openPop('http://www.allimtalk.com/app/msgHistory_pop.do','_blank','width=820, height=750');">전송 이력</a></li>--%>
<%--								<li><a href="javascript:openPop('http://www.allimtalk.com/statistics/msgOfApp_pop.do','_blank','width=700, height=750');">전송 통계</a></li>--%>
<%--								<li><a href="javascript:openPop('http://www.allimtalk.com/statistics/statsRecOfDay.do','_blank','width=1900, height=840');">수신 현황(일별)</a></li>															--%>
<%--							</ul>--%>
<%--						</li>--%>


						<li><a href="${rootPath}/admin/salary/salaryMain.do">인건비 관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/admin/salary/salaryMain.do">인건비관리</a></li>
								<li><a href="${rootPath}/admin/salary/salaryHolMain.do">휴일근무수당관리</a></li>
								<c:if test="${user.isSalaryadmin=='Y' }">
									<li><a href="${rootPath}/admin/salary/salaryRealMain.do">사원연봉관리</a></li>
									<li><a href="${rootPath}/admin/salary/memberEvaluationMain.do">사원평가관리</a></li>
									<li><a href="${rootPath}/admin/salary/selectEmpContractList.do">사원연봉계약서관리</a></li>									
									<li><a href="${rootPath}/admin/salary/salaryRealCEOMain.do">사원연봉결정(대표이사 업무)</a></li>
								</c:if>								
							</ul>
						</li>
						
						<li><a href="${rootPath}/admin/member/selectMemberList.do">사용자 관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/admin/member/selectMemberList.do">사용자 관리</a></li>
								<li><a href="${rootPath}/admin/member/selectMemberList2.do">사용자 인사목록</a></li>
								<li><a href="${rootPath}/admin/member/selectMemberListSecOrg.do">사용자 겸직관리</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/admin/organ/OrganList.do">조직 설정</a>
							<ul class="smenu">
								<li><a href="${rootPath}/admin/organ/OrganList.do">조직 관리</a></li>
								<li><a href="${rootPath}/admin/organ/statisticSector.do">구분별 실적 집계단위 설정</a></li>
								<li><a href="${rootPath}/admin/organ/busiSector.do">부서실적 집계단위 설정</a></li>
							</ul>
						</li>
						<!-- <li><a href="javascript:alert('진행예정중입니다.');">조직정책설정</a></li> -->
						<li><a href="${rootPath}/admin/banner/selectBannerList.do">배너 관리</a></li>
						<li><a href="${rootPath}/admin/expansion/selectExpansionList.do">확장기능 관리</a></li>
						
						<c:if test="${user.isAuthadmin=='Y' }">
							<li><a href="${rootPath}/admin/authority/authMain.do">권한 관리</a></li>
						</c:if>
						
						<li><a href="${rootPath}/admin/holiday/holidayList.do">휴일 관리</a></li>
						<li><a href="${rootPath}/admin/selectBoardList.do?bbsId=BBSMSTR_000000000002">관리자 게시판</a>
							<ul class="smenu">
								<li><a href="${rootPath}/admin/selectBoardList.do?bbsId=BBSMSTR_000000000002">관리자 게시판</a></li>
								<li><a href="${rootPath}/admin/selectBoardList.do?bbsId=BBSMSTR_000000000003">도움말 툴팁 게시판</a></li>
							</ul>
						</li>
						
						<!-- <li><a href="${rootPath}/admin/dining/selectDiningList.do">팀장경비 관리</a></li> -->
						<li><a href="${rootPath}/admin/statistics/dayReport.do">통계자료 출력</a>
							<ul class="smenu">
								<li><a href="${rootPath}/admin/statistics/dayReport.do">업무실적 입력현황</a></li>
								<li><a href="${rootPath}/admin/statistics/holidayWork.do">휴일근무내역</a></li>
								<li><a href="${rootPath}/admin/statistics/expense.do">경비지출내역</a></li>
								<li><a href="${rootPath}/admin/statistics/carReservation.do">법인차량 사용신청내역</a></li>
								<li><a href="${rootPath}/admin/statistics/complexProjectReport.do">개인별 프로젝트투입율 및 프로젝트실적</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/admin/project/projectListForDelete.do">프로젝트 관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/admin/project/projectListForDelete.do">프로젝트 삭제</a></li>
								<li><a href="${rootPath}/admin/project/selectProjectList.do">프로젝트 검색</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/admin/codeDetail/codeL2.do">관리자 상세코드관리</a></li><!--/sym/ccm/ccc/EgovCcmCmmnClCodeList.do-->
						<c:if test="${user.userId=='admin' || user.isHmdev == 'Y'}">
							<li><a href="${rootPath}/admin/code/codeL.do">코드 관리</a></li><!--/sym/ccm/ccc/EgovCcmCmmnClCodeList.do-->
							<li><a href="${rootPath}/admin/codeDetail/codeL.do">코드 상세관리</a></li><!--/sym/ccm/ccc/EgovCcmCmmnClCodeList.do-->
							<li><a href="${rootPath}/admin/dbManage/schemaChangeL.do">DB 관리</a>
								<ul class="smenu">
									<li><a href="${rootPath}/admin/dbManage/schemaChangeL.do">스키마 변경 점검</a></li>
								</ul>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
			<!-- E: left -->
