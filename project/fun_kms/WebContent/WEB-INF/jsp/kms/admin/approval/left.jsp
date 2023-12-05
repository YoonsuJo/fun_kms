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
					<h3><a href="/approval/main.do">전자결재</a><div class="arrow_down"><img src="${imagePath}/inc/arrow_down01.gif" alt="화살표"/></div></h3>
					<ul class="menu_list">
						<li><a href="/approval/appr_NewDraft.do">기안하기</a>
							<ul class="smenu">
								<!--  <li><a href="appr_UsedFormL.jsp">사용했던 양식</a> </li>-->
								<li><a href="/approval/approvalL.do?mode=1">저장된 문서</a></li>
								<li><a href="/approval/appr_NewDraft.do">새로 작성하기</a></li>
							</ul>
						</li>
						<li><a href="/approval/approvalL.do?mode=2">결재하기</a>
							<ul class="smenu">
								<li><a href="/approval/approvalL.do?mode=2">승인할문서</a></li>
								<li><a href="/approval/approvalL.do?mode=12">참조할문서</a></li>
								<li><a href="/approval/approvalL.do?mode=13">처리할문서</a></li>
								<li><a href="/approval/approvalL.do?mode=5">반려된문서</a></li>
							</ul>
						</li>
						<li><a href="/approval/approvalL.do?mode=7">결재현황보기</a>
							<ul class="smenu">
								<li><a href="/approval/approvalL.do?mode=3">기안한 문서</a></li>
								<li><a href="/approval/approvalL.do?mode=7">결재이전문서</a></li>
								<li><a href="/approval/approvalL.do?mode=4">결재이후문서</a></li>
							</ul>
						</li>
						<li><a href="/approval/approvalL.do?mode=14">완료문서검색</a>
							<ul class="smenu">
								<li><a href="/approval/approvalL.do?mode=14">모든 결재문서</a></li>
								<li><a href="/approval/approvalL.do?mode=10">기안한 문서</a></li>
								<li><a href="/approval/approvalL.do?mode=11">결재한 문서</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<!-- E: left -->
<script type="text/javascript">
	initTopMenu();//1,2차메뉴롤오버함수할당
</script>

