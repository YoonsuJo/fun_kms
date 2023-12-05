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
					<h3><a href="appr_AllL.jsp">솔루션 납품</a><div class="arrow_down"><img src="../images/inc/arrow_down01.gif" alt="화살표"/></div></h3>
					<ul class="menu_list">
						<li><a href="appr_UsedFormL.jsp">솔루션 납품 설치</a>
							<ul class="smenu">
								<li><a href="/equipInstall/equipInstallL.do">설치 현황</a></li>
								<li><a href="/equipInstall/equipInstallW.do">설치요청 작성하기</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<!-- E: left -->
			<script type="text/javascript">//메뉴시작위치선정
         
			var sMenuTopMain = "";
			var sMenuTopSub = "";
			 
			</script><noscript></noscript>
			 
			
			<script type="text/javascript">initTopMenu();//1,2차메뉴롤오버함수할당</script><noscript></noscript>
			<script type="text/javascript">top2menuHide(3);//페이지로드시현재위치1차메뉴활성</script><noscript></noscript>