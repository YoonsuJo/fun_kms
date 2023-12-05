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
					<h3><a href="${rootPath}/management/monthResultStatistic.do">경영정보</a><div class="arrow_down"><img src="${imagePath}/inc/arrow_down01.gif" alt="화살표" /></div></h3>
					<ul class="menu_list">
						<li><a href="${rootPath}/management/monthResultStatistic.do">경영분석</a>
							<ul class="smenu">
								<li><a href="#" onclick="javascript:MM_openBrWindow('${rootPath}/management/saleResultStatistic.do', '_SALE_STATISTIC_POP_', 'width=1040px,height=803px,scrollbars=yes');">사업부 월간실적</a></li>
								<li><a href="#" onclick="javascript:MM_openBrWindow('${rootPath}/management/perfResultStatistic.do', '_PERF_STATISTIC_POP_', 'width=1030px,height=803px,scrollbars=yes');">수행부 월간실적</a></li>
								<li><a href="#" onclick="javascript:MM_openBrWindow('${rootPath}/management/commResultStatistic.do', '_COMM_STATISTIC_POP_', 'width=1030px,height=803px,scrollbars=yes');">공통비운영 월간실적</a></li>
								 
							</ul>
						</li>
						<li><a href="${rootPath}/management/monthResultStatistic.do">사업실적</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/monthResultStatistic.do?searchRecalcYn=Y">월간사업실적 (실시간)</a></li>
								<li><a href="${rootPath}/management/monthResultStatistic.do">월간사업실적 (전일집계)</a></li>
								<li><a href="${rootPath}/management/projectResultStatistic.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">프로젝트별 실적</a></li>
								<li><a href="${rootPath}/management/planResultStatistic.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">판관비운용실적</a></li>
								<li><a href="${rootPath}/management/stepResultStatistic.do">다단계 성과분석</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/selectAnnualBusinessPlan.do">사업계획</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/selectAnnualBusinessPlan.do">연간사업계획</a></li>
								<li><a href="${rootPath}/management/prjPlanCostList.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">프로젝트별 예산</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/salesList.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">매출관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/salesList.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">매출건관리</a></li>
								<li><a href="${rootPath}/management/innerSalesList.do">사내매출내역</a></li>
								<li><a href="${rootPath}/management/outerPurchaseList.do?searchType=ORG">사외매입내역</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/fund/chckOrgSalesList.do">채권관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/fund/chckOrgSalesList.do">채권관리</a></li>
								<li><a href="${rootPath}/fund/chckProjectSalesCheckList.do">수금내역</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/bondOrg.do">채권관리(과거)</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/bondOrg.do">채권관리</a></li>
								<li><a href="${rootPath}/management/collectionFullL.do">수금내역</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/selectExpenseStatistic.do">경비관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/selectExpenseStatistic.do">경비지출내역</a></li>
								<!-- <li><a href="javascript:alert('준비중입니다.');">법인카드사용내역</a></li> -->
							</ul>
						</li>
						<li><a href="${rootPath}/management/selectInputResultPerson.do">인력투입관리</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/selectInputResultPlanPersonStatus.do">개인별 투입 계획 현황</a></li>
								<li><a href="${rootPath}/management/selectInputResultPlanPerson.do">개인별 투입 계획/실적</a></li>
								<li><a href="${rootPath}/management/selectInputResultPlanProject.do?searchCondition=1&searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">프로젝트별 투입 계획/실적</a></li>
								<li><a href="${rootPath}/management/selectInputResultPerson.do">개인별 투입실적</a></li>
								<li><a href="${rootPath}/management/selectInputResultDept.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">부서별 투입실적</a></li>
								<li><a href="${rootPath}/management/selectInputResultProject.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">프로젝트별 투입실적</a></li>
								<!-- <li><a href="${rootPath}/management/prjInputPlanMgmt.do">프로젝트 투입계획</a></li> -->
							</ul>
						</li>
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
					</ul>
				</div>
			</div>
			<!-- E: left -->
<script type="text/javascript">
	initTopMenu();//1,2차메뉴롤오버함수할당
</script>