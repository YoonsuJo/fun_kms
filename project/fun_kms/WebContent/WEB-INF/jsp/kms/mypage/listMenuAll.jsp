<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
			<div id="center">
				<div class="path_navi">
					<ul>
						<li class="stitle">전체메뉴 (기존메뉴)</li>
						<li class="navi">홈 > 전체메뉴</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
					<!-- 업무공유 시작 -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
						</colgroup>
						<thead>
							<tr>
								<th>업무공유</th>
								<th>전자결재</th>
								<th>커뮤니티</th>
								<th>경영정보</th>
							</tr>
						</thead>
						<tbody id="tableBody">
								<tr>
									<td class="txt_left" valign="top">
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
							</ul>
						</li>
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
									</td>
									<td class="txt_left" valign="top">
					<ul class="menu_list">
						<li><a href="/approval/appr_NewDraft.do">기안하기</a>
							<ul class="smenu">
								<li><a href="/approval/approvalL.do?mode=1">저장된 문서</a></li>
								<li><a href="/approval/appr_NewDraft.do">새로 작성하기</a></li>
								<li><a href="/approval/selectCardSpendList.do">법인카드 미상신 내역</a></li>
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
									</td>
									<td class="txt_left" valign="top">
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
									<a href="${rootPath}/support/bpManualWrite.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
								</li>																
								<li>
									<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000081">상품정보 
									</a>
									<c:if test="${(user.orgnztId == 'ORGAN_00000000000151') || (user.position == 'H') || (user.isAdmin == 'Y') }">
										<a href="${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000081"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
									</c:if>
								</li>
								<li>
									<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000083">제안게시판 
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
							</ul>
						</li>
					</ul>
									</td>
									<td class="txt_left" valign="top">
					<ul class="menu_list">
						<li><a href="${rootPath}/management/monthResultStatistic.do">경영분석</a>
							<ul class="smenu">
								<li><a href="#" onclick="javascript:MM_openBrWindow('${rootPath}/management/saleResultStatistic.do', '_SALE_STATISTIC_POP_', 'width=1040px,height=803px,scrollbars=yes');">사업부 월간실적</a></li>
								<li><a href="#" onclick="javascript:MM_openBrWindow('${rootPath}/management/perfResultStatistic.do', '_PERF_STATISTIC_POP_', 'width=1030px,height=803px,scrollbars=yes');">수행부 월간실적</a></li>
								<li><a href="#" onclick="javascript:MM_openBrWindow('${rootPath}/management/commResultStatistic.do', '_COMM_STATISTIC_POP_', 'width=1030px,height=803px,scrollbars=yes');">공통비운영 월간실적</a></li>
								<li><a href="${rootPath}/management/stepResultStatistic.do">다단계 성과분석</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/monthResultStatistic.do">사업실적</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/monthResultStatistic.do?searchRecalcYn=Y">월간사업실적 (실시간)</a></li>
								<li><a href="${rootPath}/management/monthResultStatistic.do">월간사업실적 (전일집계)</a></li>
								<li><a href="${rootPath}/management/projectResultStatistic.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">프로젝트별 실적</a></li>
								<li><a href="${rootPath}/management/planResultStatistic.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">판관비운용실적</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/fund/chckOrgSalesList.do">채권관리(경영기획)</a>
							<ul class="smenu">
								<li><a href="${rootPath}/fund/chckOrgSalesList.do">부서별 매출vs계산서</a></li>
								<li><a href="${rootPath}/fund/invoiceList.do?searchMode=1">계산서 발행처리</a></li>
								<li><a href="${rootPath}/fund/invoiceList.do?searchMode=2">계산서 수금등록</a></li>
								<li><a href="${rootPath}/management/salesList.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">매출건관리</a></li>
								<li><a href="${rootPath}/management/innerSalesList.do">사내매출내역</a></li>
								<li><a href="${rootPath}/management/outerPurchaseList.do?searchType=ORG">사외매입내역</a></li>
								<li><a href="${rootPath}/management/bondOrg.do">채권관리(과거)</a></li>
								<li><a href="${rootPath}/management/collectionFullL.do">수금내역(과거)</a></li>
							</ul>
						<li><a href="${rootPath}/fund/chckOrgSalesList.do">채권관리(사업부)</a>
							<ul class="smenu">
								<li><a href="${rootPath}/fund/invoiceList.do?searchMode=0">계산서 발행요청</a></li>
								<li><a href="${rootPath}/fund/chckOrgSalesList.do">채권관리종합(사업부)</a></li>
								<li><a href="${rootPath}/fund/bizCollectList.do">수금관리(사업부)</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/selectExpenseStatistic.do">경비관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/selectExpenseStatistic.do">경비지출내역</a></li>
							</ul>
						</li>
<!-- 
						<li><a href="${rootPath}/management/selectInputResultPerson.do">인력투입관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/selectInputResultPlanPersonStatus.do">개인별 투입 계획 현황</a></li>
								<li><a href="${rootPath}/management/selectInputResultPlanPerson.do">개인별 투입 계획/실적</a></li>
								<li><a href="${rootPath}/management/selectInputResultPlanProject.do?searchCondition=1&searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">프로젝트별 투입 계획/실적</a></li>
								<li><a href="${rootPath}/management/selectInputResultPerson.do">개인별 투입실적</a></li>
								<li><a href="${rootPath}/management/selectInputResultDept.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">부서별 투입실적</a></li>
								<li><a href="${rootPath}/management/selectInputResultProject.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">프로젝트별 투입실적</a></li>
								<li><a href="${rootPath}/management/prjInputPlanMgmt.do">프로젝트 투입계획</a></li> 
							</ul>
						</li>
-->
						<li><a href="${rootPath}/management/contractL.do?searchTyp=W">계약건관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/contractL.do?searchTyp=W">수주계약</a></li>
								<li><a href="${rootPath}/management/contractL.do?searchTyp=O">발주계약</a></li>
							</ul>
						</li>
						<c:if test="${user.admin }">
						<li><a href="${rootPath}/management/fundWeekly.do">자금관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/fundWeekly.do">주간자금보고</a></li>
								<li><a href="${rootPath}/management/fundMonthly.do">월간자금보고</a></li>
							</ul>
						</li>
						</c:if>
						<li><a href="${rootPath}/management/selectAnnualBusinessPlan.do">사업계획</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/selectAnnualBusinessPlan.do">연간사업계획</a></li>
								<li><a href="${rootPath}/management/prjPlanCostList.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">프로젝트별 예산</a></li>
							</ul>
						</li>
					</ul>
									</td>
								</tr>
						</tbody>
						</table>
					</div>
					<!-- 업무공유 끝  -->
					
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
						</colgroup>
						<thead>
							<tr>
								<th>상품관리</th>
								<th>업무지원</th>
								<th>인사관리</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="tableBody">
								<tr>
									<td class="txt_left" valign="top">
					<ul class="menu_list">
						<li><a href="${rootPath}/cooperation/selectConsultManageList.do">상담관리</a>
							<a href="${rootPath}/cooperation/writeConsultManage.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
							<ul class="smenu">
								<li><a href="${rootPath}/cooperation/writeConsultManage.do">상담접수</a></li>
								<li><a href="${rootPath}/cooperation/selectConsultManageListMine.do">상담처리</a></li>
								<li><a href="${rootPath}/cooperation/selectConsultManageList.do">상담결과</a></li>
								<li><a href="${rootPath}/cooperation/consultStatusList2.do">상담통계</a></li>
								<li><a href="${rootPath}/cooperation/selectClientList.do">고객사관리</a></li>
							</ul>
						</li>
					</ul>
					<ul class="menu_list">
						<li><a href="${rootPath}/product/selectProductRequestMain.do?requestType=E">기능오류 관리</a>
							<a href="${rootPath}/product/insertProductRequestView.do?productId=${productVO.productId}&requestType=E"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
							<ul class="smenu">
								<li>
								</li>
							</ul>
						</li>
						<li><a href="${rootPath}/product/selectProductRequestMain.do">요구사항 관리</a>
							<a href="${rootPath}/product/insertProductRequestView.do?productId=${productVO.productId}"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
							<ul class="smenu">
								<li>
								</li>
							</ul>
						</li>
						<li><a href="${rootPath}/product/selectProductMain.do">제품 개발 관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/product/selectProductInfo.do?}">${productVO.productNm}</a></li>
							</ul>
						</li>
					</ul>
									</td>
									<td class="txt_left"  valign="top">
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
								<li><a href="${rootPath}/support/selectIpList.do">사내 IP 관리</a></li>
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
									</td>
									<td class="txt_left" valign="top">
					<ul class="menu_list">
						<c:if test="${user.isNegoYn=='Y' }">
							<li><a href="${rootPath}/member/selectEmpContract.do">연봉정보</a>
								<ul class="smenu">
<!--									<li><a href="${rootPath}/member/mem_pop_AbilityChart01.jsp">능력고과</a></li>	-->																						
									<li><a href="${rootPath}/member/selectMemberSalaryNego.do">연봉협상</a></li>
									<c:if test="${user.isSalaryadmin=='Y' }">
										<li><a href="${rootPath}/member/selectEmpContract.do">연봉계약서</a></li>
									</c:if>
								</ul>
							</li>		
						</c:if>
						<c:if test="${user.isSalaryadmin=='Y' }">
							<li><a href="${rootPath}/admin/salary/salaryRealCEOMain.do">대표이사 업무</a>
								<ul class="smenu">
									<li><a href="${rootPath}/admin/salary/salaryRealCEOMain.do">사원연봉결정</a></li>
								</ul>
							</li>
						</c:if>
						
						<li><a href="${rootPath}/member/selectMemberList.do">사원정보</a>
							<ul class="smenu">
								<li><a href="${rootPath}/member/selectMemberList.do">사원조회</a></li>
								<li><a href="${rootPath}/member/selectMemberCareerList.do">이력관리</a></li>
								<li><a href="${rootPath}/member/selectPositionHistoryList.do">인사발령</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/member/dailyWorkStateStatistic.do">근무현황</a>
							<ul class="smenu">								
								<li><a href="${rootPath}/member/dailyWorkStateStatistic.do">일일근태기록</a></li>
								<li><a href="${rootPath}/member/selectAbsenceState.do">현재시각 부재자 현황</a> <a href="${rootPath}/member/insertAbsenceView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
								<li><a href="${rootPath}/member/workStateStatistic.do">근태통계</a></li>
								<li><a href="${rootPath}/member/selectOvertimeList.do">연장근무통계</a></li>
								<li><a href="${rootPath}/member/selectOvertimeView.do">연장근무내역</a> <a href="${rootPath}/member/insertOvertimeView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>								
								<li><a href="${rootPath}/member/selectVacationSummaryView.do">휴가사용내역</a> <a href="${rootPath}/approval/approvalW.do?templtId=2"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
								<li><a href="${rootPath}/member/selectHolidayWorkStatisticView.do">휴일근무내역</a> <a href="${rootPath}/approval/approvalW.do?templtId=5"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/member/selectSelfDevView.do">복리후생</a>
							<ul class="smenu">
								<li><a href="${rootPath}/member/selectSelfDevView.do">자기개발비 사용내역</a></li>
								<!-- <li><a href="${rootPath}/member/diningMoneyStatisticView.do">팀장경비 사용내역</a></li> -->
							</ul>
						</li>
						<li><a href="${rootPath}/member/selectMemberCareerList.do">이력관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/member/selectMemberCareerList.do">이력관리 조회</a></li>
							</ul>
						</li>
					</ul>
									</td>
									<td class="txt_left">
									</td>
								</tr>
						</tbody>
						</table>
					</div>
				<!-- E: section -->
			</div>
			<!-- E: center -->
			<%@ include file="../include/right.jsp"%>
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
