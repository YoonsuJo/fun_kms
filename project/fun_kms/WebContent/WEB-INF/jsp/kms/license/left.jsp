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
					<h3><a href="${rootPath}/license/licenseList.do">라이선스 관리</a><div class="arrow_down"><img src="${imagePath}/inc/arrow_down01.gif" alt="화살표"/></div></h3>
					<ul class="menu_list">
						<li><a href="${rootPath}/license/licenseList.do">라이선스 관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/license/licenseList.do">라이선스 조회</a>
								<a href="${rootPath}/license/licenseIssue.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>			
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