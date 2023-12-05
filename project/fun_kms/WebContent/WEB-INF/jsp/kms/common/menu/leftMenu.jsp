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
				</div>
			</div>
			<!-- E: left -->
<script type="text/javascript">
initTopMenu();//1,2차메뉴롤오버함수할당
</script>