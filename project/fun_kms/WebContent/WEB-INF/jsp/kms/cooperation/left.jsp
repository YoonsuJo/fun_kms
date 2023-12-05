<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<!-- S: left -->
			<div id="left">
				<!--체크리스트-->
				<div class="left_chk" id="chkList">
					<c:import url="${rootPath}/common/getCheckList.do">
					</c:import>
				</div>
				<!--체크리스트-->
				<ul class="left_bg">
					<li class="left_bg_left"></li>
					<li class="left_bg_right"></li>
				</ul>

				<div class="left_menu">
					<h3><a href="${rootPath}/cooperation/selectDayReport.do">업무공유</a>
						<div class="arrow_down"><img src="${imagePath}/inc/arrow_down01.gif" alt="화살표"/></div></h3>
					<ul class="menu_list">
						<li><a href="${rootPath}/cooperation/selectDayReport.do">업무계획/실적</a>
							<ul class="smenu">
								<li><a href="${rootPath}/cooperation/selectDayReportMyList.do">나의업무</a></li>
								<li><a href="${rootPath}/cooperation/selectDayReportMyDList.do">업무실적 조회</a></li>
								<li><a href="${rootPath}/cooperation/selectDayReportOrderList.do">업무지시 현황</a></li>
								<!-- <li><a href="${rootPath}/cooperation/selectDayReport.do">나의업무현황</a></li>  -->
								<!-- <li><a href="${rootPath}/cooperation/selectProcessList.do">업무진행내역</a></li>  -->
								<li><a href="${rootPath}/cooperation/selectWeekReportList.do">주간업무보고</a></li>
								<li><a href="${rootPath}/cooperation/searchProcessList.do">업무진행내역 검색</a></li>
								<c:if test="${user.isDayreportuserlist=='Y' || user.isAdmin=='Y' }">
									<li><a href="${rootPath}/cooperation/selectDayReportUserList.do">업무일지 작성현황</a></li>
								</c:if>	
<!-- 
ORGAN_00000000000151 전략기획연구소			
ORGAN_00000000000007 웹서비스개발팀
 -->
 
						


							</ul>
						</li>
						
<!-- 			
ORGAN_00000000000012 솔루션개발연구소
ORGAN_00000000000035 솔루션개발1팀
ORGAN_00000000000036 기반기술팀
ORGAN_00000000000037 플랫폼개발1팀
ORGAN_00000000000081 웹플랫폼팀
ORGAN_00000000000082 솔루션기획팀
ORGAN_00000000000151 전략기획연구소
ORGAN_00000000000171 솔루션개발2팀
ORGAN_00000000000182 쏘몬연구소
ORGAN_00000000000183 서버개발그룹
ORGAN_00000000000184 서버개발팀
ORGAN_00000000000185 서비스개발팀
ORGAN_00000000000186 단말개발팀
ORGAN_00000000000186 기획팀
 ORGAN_00000000000007 웹서비스개발팀
 -->
 
 <!-- 
						
						<c:if test="${user.orgnztId=='ORGAN_00000000000151'
						|| user.userNm=='양윤정'	
						|| user.userNm=='정현석'
						|| user.userNm=='김승곤'	
						|| user.userNm=='최종수'																												
						|| user.isAdmin=='Y' }">
						<li><a href="${rootPath}/cooperation/selectMissionMyList.do">Mission-Clear</a>
							<ul class="smenu">
								<li><a href="${rootPath}/cooperation/selectMissionMyList.do">나의 미션</a></li>
								<li><a href="${rootPath}/cooperation/selectMissionStatList.do">미션 미처리 현황</a></li>
								<li><a href="${rootPath}/cooperation/selectMissionSearchList.do?type=search">미션 검색</a></li>		
								<li><a href="${rootPath}/cooperation/selectMissionSearchList.do?type=prj">프로젝트별 미션</a></li>							
							</ul>
						</li>
						</c:if>
 -->						
						<li><a href="${rootPath}/cooperation/selectBusinessContactList.do">협업</a>
							<ul class="smenu">
								<li><a href="${rootPath}/cooperation/selectBusinessContactList.do">업무연락</a></li>
								<li><a href="${rootPath}/cooperation/selectMeetingRoomList.do">회의실</a></li>
								<c:if test="${user.isAdmin=='Y' || user.no==9 || user.no==131}">	<!-- 모든 회의실 조회(김태연 부장, 박현준 과장) -->
								<li><a href="${rootPath}/cooperation/selectMeetingRoomList.do?inputType=all" title="특정 인원만 조회가능">모든 회의실 보기</a></li>
								</c:if>
								<li><a href="${rootPath}/cooperation/selectPrjBoardMain.do">프로젝트 게시판</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/cooperation/selectProjectList.do">프로젝트 관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/cooperation/selectProjectList2.do">프로젝트 검색</a></li>
								<li><a href="${rootPath}/cooperation/selectProjectList.do">프로젝트 현황</a></li>
								<li><a href="${rootPath}/cooperation/selectProjectDetailList.do?searchPrjType=S">진행중인 영업현황</a></li>
								<li><a href="${rootPath}/cooperation/selectProjectDetailList.do?searchPrjType=B">진행중인 사업현황</a></li>
								<li><a href="${rootPath}/cooperation/selectProjectDetailList.do?searchPrjType=P">진행중인 수행현황</a></li>								
							</ul>
						</li>
						<li><a href="${rootPath}/cooperation/selectCustomerList.do">정보공유</a>
							<ul class="smenu">
<!--								<li><a href="javascript:alert('준비중입니다.');">자료공유</a></li>-->								
								<li><a href="${rootPath}/cooperation/selectCustomerList.do">고객사정보</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/cooperation/selectSalesProjectList.do">영업관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/cooperation/selectSalesProjectList.do">나의 영업건</a></li>
								<li><a href="${rootPath}/cooperation/selectSalesProjectListAll.do">영업건 관리</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<!-- E: left -->
<script type="text/javascript">
	initTopMenu();//1,2차메뉴롤오버함수할당
	top2menuHide(4);//페이지로드시현재위치1차메뉴활성
</script>