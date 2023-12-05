<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function gameCall() {
	var game = window.open('http://222.112.235.135/game/startV.jsp?id=${user.userId}&no=${user.no}','_DOSA_GAME_WINDOW','width=810px, height=595px, scrollbars=no');
	game.focus();
}
</script>
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
					<h3><a href="${rootPath}/community/selectAllBoardList.do">커뮤니티</a>
						<div class="arrow_down"><img src="${imagePath}/inc/arrow_down01.gif" alt="화살표"/></div></h3>
					<ul class="menu_list">
						<li><a href="javascript:gameCall();">한마음이벤트</a>
							<ul class="smenu">
								<li><a href="javascript:gameCall();">한마음게임</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/community/selectUnreadBoardList.do">게시판</a>
							<ul class="smenu">
								<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000031">공지사항 [${commList.bbsmstr000000000031}]</a>
									<a href="${rootPath}/support/addBoardArticle.do?bbsId=BBSMSTR_000000000031"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
							<c:if test="${ user.isAdmin == 'Y' }">
								<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000033">알림공지 [${commList.bbsmstr000000000033}]</a>
									<a href="${rootPath}/support/addBoardArticle.do?bbsId=BBSMSTR_000000000033"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>	
							</c:if>							
								<li><a href="${rootPath}/community/selectUnreadBoardList.do">미열람게시물 [${commList.comm}]</a></li>
								<li><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000001">자유게시판 [${commList.bbsmstr000000000001}]</a>
									<a href="${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000001"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
								
								<li><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000082">첫출근인사말</a></li>
						 	
								<li><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000029">토론 [${commList.bbsmstr000000000029}]</a>
									<a href="${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000029"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
								<li><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000030">경조사 [${commList.bbsmstr000000000030}]</a>
									<a href="${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000030"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
								<li><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000034">개발TIP [${commList.bbsmstr000000000034}]</a>
									<a href="${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000034"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>								
								<li><a href="${rootPath}/support/bpManualList.do">업무절차게시판</a>
									<a href="${rootPath}/support/bpManualWrite.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>																
							
									<!-- 
									20130923 김대현 상품정보 게시판 추가
									boardVO.bbsId == 'BBSMSTR_000000000081' 상품정보 게시판
									user.orgnztId=='ORGAN_00000000000151' 전략기획연구소
									user.position=='H' 팀장
									user.isAdmin=='Y' 관리자
									 -->
								<li>
									<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000081">상품정보 
									<c:if test="${commList.bbsmstr000000000081 == null}">
									[0]
									</c:if>
									<c:if test="${commList.bbsmstr000000000081 != null}">
									[${commList.bbsmstr000000000081}]
									</c:if>
									</a>
									<c:if test="${user.orgnztId == 'ORGAN_00000000000151'
									|| user.position == 'H'
									|| user.isAdmin == 'Y' }">
										<a href="${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000081"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
									</c:if>
								</li>
								
								
								<li>
									<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000083">제안게시판 
									<c:if test="${commList.bbsmstr000000000083 == null}">
									[0]
									</c:if>
									<c:if test="${commList.bbsmstr000000000083 != null}">
									[${commList.bbsmstr000000000083}]
									</c:if>
									</a>
									<a href="${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000083"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
								</li>
								
									
							</ul>
						</li>
						<li><a href="${rootPath}/community/scheduleCalendar.do">일정공유</a>
							<ul class="smenu">
								<li><a href="${rootPath}/community/scheduleCalendar.do">주요일정</a><a href="${rootPath}/community/addScheduleView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/community/selectRecieveMailList.do">사내메일</a>
							<ul class="smenu">
								<li><a href="${rootPath}/community/sendMailView.do">작성하기</a></li>
								<li><a href="${rootPath}/community/selectRecieveMailList.do">받은편지  [${commList.mailRecieve}/${commList.mailRecieveAll}]</a></li>
								<li><a href="${rootPath}/community/selectSendMailList.do">보낸편지 [${commList.mailSend}]</a></li>
								<li><a href="${rootPath}/community/selectSaveMailList.do">작성중인 편지 [${commList.mailSave}]</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/community/selectRecieveNoteList.do">쪽지</a>
							<ul class="smenu">
								<li><a href="#" onclick="window.open('${rootPath}/community/sendNoteView.do', '_POP_NOTE_WRITE_', 'top=0px, left=0px, width=500px, height=415px, scrollbars=yes')">작성하기</a></li>
								<li><a href="${rootPath}/community/selectRecieveNoteList.do">받은쪽지 [${commList.noteRecieve}/${commList.noteRecieveAll}]</a></li>
								<li><a href="${rootPath}/community/selectSendNoteList.do">보낸쪽지 [${commList.noteSend}]</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000061">운영참여</a>
							<ul class="smenu">
								<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000062">건의/제안</a> <a href="${rootPath}/support/addBoardArticle.do?bbsId=BBSMSTR_000000000062"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
								<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000061">한마음 개선요청</a> <a href="${rootPath}/support/addBoardArticle.do?bbsId=BBSMSTR_000000000061"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
<!--								<li><a href="javascript:alert('준비중입니다.');">설문</a></li>-->
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<!-- E: left -->

<script type="text/javascript">
	initTopMenu();//1,2차메뉴롤오버함수할당
</script>
