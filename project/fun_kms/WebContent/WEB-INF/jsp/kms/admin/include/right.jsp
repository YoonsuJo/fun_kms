<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<span id="right_arrow"><a href="#" onclick="javascript:hidden_right()"><img src="${imagePath}/inc/arrow_right.gif"/></a></span>
			<!-- S: right -->
			<div id="right" style="display:block">
				<!--달력-->
				<div class="calendar">
					<img src="${imagePath}/inc/calendar.gif"/>
				</div>
				<!--일정/할일-->
				<div class="schedule">
					<dl>
						<dt>2011.08.04 (목) <div class="arrow_down02"><img src="${imagePath}/inc/arrow_down02.gif"></div></dt>
						<dd>
							<ul class="detail_schedule">
								<li>일정
									<ul class="sdetail">
										<li> - 바비큐파티</li>
										<li> - 건강검진</li>
									</ul>
								</li>
								<li>할일
									<ul class="sdetail">
										<li> - KMS 화면설계</li>
										<li> - 파일서버 정리</li>
									</ul>
								</li>
							</ul>
						</dd>
					</dl>
				</div>
				<!--확장기능-->
				<div class="skill">
					<dl>
						<dt>
							<ul class="right_title">
								<li class="title_txt">확장기능</li>
								<li class="btn_plus"><img src="${imagePath}/btn/btn_plus.gif"/></li>
							</ul>
						</dt>
						<dd>
							<dl class="skill_bn">
								<dt><img src="${imagePath}/inc/bn01.gif"/></dt>
								<dd>지인관리</dd>
							</dl>
							<dl class="skill_bn">
								<dt><img src="${imagePath}/inc/bn02.gif"/></dt>
								<dd>경영통계</dd>
							</dl>
							<dl class="skill_bn">
								<dt><img src="${imagePath}/inc/bn03.gif"/></dt>
								<dd>상담관리</dd>
							</dl>
						</dd>
						<dd class="2ndline">
							<dl class="skill_bn">
								<dt><img src="${imagePath}/inc/bn04.gif"/></dt>
								<dd>당직일지</dd>
							</dl>
							<dl class="skill_bn">
								<dt><img src="${imagePath}/inc/bn05.gif"/></dt>
								<dd>KMS교육</dd>
							</dl>
							<dl class="skill_bn">
								<dt><img src="${imagePath}/inc/bn06.gif"/></dt>
								<dd>업적평가</dd>
							</dl>
						</dd>
					</dl>
				</div>
				<!--나의메뉴-->
				<div class="mymenu">
					<dl>
						<dt>
							<ul class="right_title">
								<li class="title_txt">나의메뉴</li>
								<li class="btn_plus"><img src="${imagePath}/btn/btn_plus.gif"/></li>
							</ul>
						</dt>
						<dd>나의업무보고</dd>
						<dd>업무연락</dd>
						<dd>전자결재작성</dd>
						<dd>자유게시판</dd>
					</dl>
				</div>
			</div>
			<!-- E: right -->