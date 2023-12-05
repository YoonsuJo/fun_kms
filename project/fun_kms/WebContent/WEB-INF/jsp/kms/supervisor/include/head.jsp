<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- S: header -->
	<div id="header">
		<div id="logo_util">
			<h1><img src="${imagePath}/inc/top_logo.gif" alt="KMS 지식관리시스템"/></h1>

			<div class="search">
				<ul>
					<li class="option_txt">사원<span class="pL7"></span><input type="radio" name="search" value="employee"><span class="pL7"></span>정보<span class="pL7"></span><input type="radio" name="search" value="information" checked></li>
					<li class="search_box"><input type="text" name="search_txt" class="search_txt"/></li>
					<li><img src="${imagePath}/btn/btn_search.gif" alt="검색"/></li>
				</ul>
			</div>

			<div class="utility">
				<ul>
					<li><img src="${imagePath}/inc/util_admin.gif" alt="관리자페이지"/></li>
					<li><img src="${imagePath}/inc/util_mail.gif" alt="웹메일"/></li>
					<li><img src="${imagePath}/inc/util_video.gif" alt="화상회의"/></li>
					<li><img src="${imagePath}/inc/util_logo.gif" alt="도사/새하페이지"/></li>
				</ul>
			</div>
		</div>
		<div id="gnb_menu">
			<!-- S: GNB -->
			<ul id="gnbmenu">
				<li class="gnb_first"><a href="#" id="top1m1"><img src="${imagePath}/inc/gnb/gnb01.gif" alt="현황판" /></a>
					<div id="snbmenu_m1">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu01m1">기안하기</li>
									<li id="snbmenu01m2">결재하기</li>
									<li id="snbmenu01m3">결재현황보기</li>
									<li id="snbmenu01m4">완료문서보기</li>
									<li id="snbmenu01m5">보관된문서</li>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>
				</li>
				<li><a href="#" id="top1m2"><img src="${imagePath}/inc/gnb/gnb02.gif" alt="업무공유" /></a>
					<div id="snbmenu_m2">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu02m1">기안하기</li>
									<li id="snbmenu02m2">결재하기</li>
									<li id="snbmenu02m3">결재현황보기</li>
									<li id="snbmenu02m4">완료문서보기</li>
									<li id="snbmenu02m5">보관된문서</li>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
				<li><a href="../approval/appr_AllL.jsp" id="top1m3"><img src="${imagePath}/inc/gnb/gnb03.gif" alt="전자결재" /></a>
					<div id="snbmenu_m3">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu03m1"><a href="../approval/appr_UsedFormL.jsp">기안하기</a></li>
									<li id="snbmenu03m2"><a href="../approval/appr_AcceptL.jsp">결재하기</a></li>
									<li id="snbmenu03m3"><a href="../approval/appr_ApprovalDraftL.jsp">결재현황보기</a></li>
									<li id="snbmenu03m4"><a href="../approval/appr_CompDraftL.jsp">완료문서보기</a></li>
									<li id="snbmenu03m5"><a href="../approval/appr_WritingDraftL.jsp">보관된문서</a></li>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>
				</li>
				<li><a href="../community/comm_AllL.jsp" id="top1m4"><img src="${imagePath}/inc/gnb/gnb04.gif" alt="커뮤니티" /></a>
					<div id="snbmenu_m4">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu04m1"><a href="../community/comm_UnreadL.jsp">게시판</a></li>
									<li id="snbmenu04m2"><a href="#">일정공유</a></li>
									<li id="snbmenu04m3"><a href="../community/comm_InboxL.jsp">사내메일</a></li>
									<li id="snbmenu04m4"><a href="../community/comm_InmessageL.jsp">쪽지</a></li>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>
				</li>
				<li><a href="#" id="top1m5"><img src="${imagePath}/inc/gnb/gnb05.gif" alt="경영정보" /></a>
					<div id="snbmenu_m5">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu05m1">기안하기</li>
									<li id="snbmenu05m2">결재하기</li>
									<li id="snbmenu05m3">결재현황보기</li>
									<li id="snbmenu05m4">완료문서보기</li>
									<li id="snbmenu05m5">보관된문서</li>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
				<li><a href="#" id="top1m6"><img src="${imagePath}/inc/gnb/gnb06.gif" alt="업무지원" /></a>
					<div id="snbmenu_m6">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu06m1">자원관리</li>
									<li id="snbmenu06m2">각종신청</li>
									<li id="snbmenu06m3">업무처리지원</li>
									<li id="snbmenu06m4">운영참여</li>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
				<li class="gnb_last"><a href="#" id="top1m7"><img src="${imagePath}/inc/gnb/gnb07.gif" alt="인사정보" /></a>
					<div id="snbmenu_m7">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu07m1">사원정보</li>
									<li id="snbmenu07m2">근무현황</li>
									<li id="snbmenu07m3">복리후생</li>
									<li id="snbmenu07m4">근태정보</li>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
			</ul>

			<!-- E: GNB -->
			<!-- S: LOGIN_INFO -->
			<ul class="login_info">
				<li class="mem_txt">문성숙님</li>
				<li class="login_time">(08:00)</li>
				<li><img src="${imagePath}/btn/btn_mypage.gif" alt="MYPAGE"/></li>
				<li><img src="${imagePath}/btn/btn_logout.gif" alt="LOGOUT"/></li>
			</ul>
			<!-- E: LOGIN_INFO -->
		</div>
	</div>
	<!-- E: header -->
