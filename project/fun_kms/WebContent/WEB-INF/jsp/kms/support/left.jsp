<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
					<h3><a href="${rootPath}/support/selectCarList.do">업무지원</a><div class="arrow_down"><img src="${imagePath}/inc/arrow_down01.gif" alt="화살표"/></div></h3>					
					<ul class="menu_list">					
						<li><a href="${rootPath}/support/selectCarList.do">자원관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/support/selectCarList.do">법인차량 관리</a></li>
								<li><a href="${rootPath}/support/selectCarRsvCalendar.do">법인차량 예약현황</a></li>
								<li><a href="${rootPath}/support/selectCardList.do">법인카드 관리</a></li>
								<li><a href="${rootPath}/support/selectEquipList.do">전산장비 관리</a></li>
								<c:if test="${user.admin}">
								<li><a href="${rootPath}/support/selectEquipTypeList.do">전산장비종류 관리</a></li>
								</c:if>
							</ul>
						</li>
						<li>각종신청
							<ul class="smenu">
								<li><a href="${rootPath}/fund/invoiceList.do?searchMode=0">계산서 발행요청</a></li>
								<li><a href="${rootPath}/support/selectCarRsvCalendar.do">법인차량 사용신청</a></li>
<!--  								<li><a href="${rootPath}/support/selectRecruitList.do">채용요청</a> <a href="${rootPaht }/approval/approvalW.do?templtId=4"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li> -->
<!--								<li><a href="javascript:alert('준비중입니다.');">명함신청</a> <a href="javascript:alert('준비중입니다.');"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>-->
<!--								<li>명함신청<img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></li>-->
							</ul>
						</li>										
						<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000050">업무처리지원</a>
							<ul class="smenu">
								<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000053">업무처리절차</a></li>
								<li><a href="${rootPath}/support/ruleL.do">제반규정</a></li>					
								<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000050">회사자료</a></li>
								<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000051">솔루션자료</a></li>
								<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000052">각종양식</a></li>																			
							</ul>
						</li>						
						<li><a href="${rootPath}/support/stockL.do">재고 현황</a>
							<ul class="smenu">
								<li><a href="${rootPath}/support/stockL.do">전체 현황</a></li>
								<li><a href="${rootPath}/support/stockL.do?searchType=stock">재고 현황</a></li>
								<li><a href="${rootPath}/support/stockL.do?searchType=sale">판매 현황</a></li>
								<li><a href="${rootPath}/support/stockStatisticL.do?type=buy">월별 구매 현황</a></li>
								<li><a href="${rootPath}/support/stockStatisticL.do?type=sale">월별 판매 현황</a></li>
								<li><a href="${rootPath}/support/stockStatisticL.do?type=stock">월별 재고 현황</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/support/stockW.do">재고 관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/support/stockW.do">재고 입고</a></li>
								<li><a href="${rootPath}/support/stockL.do?searchType=stock">출고목록저장</a></li>
								<li><a href="${rootPath}/support/stockR.do">재고 출고</a></li>
								<li><a href="${rootPath}/support/stockC.do">재고 변동</a></li>
								<li><a href="${rootPath}/support/stockCategoryL.do">구분 관리</a></li>
								<li><a href="${rootPath}/support/stockItemL.do">품목 관리</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<!-- E: left -->
<script type="text/javascript">
	initTopMenu();//1,2차메뉴롤오버함수할당
</script>