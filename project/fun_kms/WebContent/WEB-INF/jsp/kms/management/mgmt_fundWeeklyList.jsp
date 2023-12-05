<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script type="text/javascript">
function search(moveDate) {
	document.frm.moveDate.value = moveDate;
	document.frm.action = '<c:url value="${rootPath}/management/fundWeekly.do" />';
	document.frm.submit();
}
function searchDetail() {
	document.frm.action = '<c:url value="${rootPath}/management/fundWeeklyDetail.do" />';
	document.frm.submit();
}
</script>

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
						<li class="stitle">주간자금보고</li>
						<li class="navi">홈 > 경영정보 > 자금관리 > 주간자금보고</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST" action="/member/dailyWorkStateStatistic.do" onsubmit="search(0); return false;">
			   		<input type="hidden" name="moveDate" value="0"/>
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
	                		<li class="li_left">
	               	 			<a href="javascript:search(-7);" class="pR10"><img src="/images/btn/btn_prev.gif" alt="이전 페이지"></a>
	                			<span class="option_txt"><input type="text" class="input01 span_4 calGen" name="searchDate" value="${searchDate}"/></span>
								<a href="javascript:search(7);" class="pL10"><img src="/images/btn/btn_next.gif" alt="다음 페이지"></a>
	                		</li>
	                		<li class="li_right">
	                			<!-- S: 셀렉트 박스 -->
								<span class="select_r5">
								<select name="companyCd">
										<c:if test="${user.isFundAdmin == 'Y'}">
											<option value="uprism" selected="selected">유프리즘</option>
										</c:if>
										<c:if test="${user.isFundAdmin != 'Y'}">
										<c:forEach items="${companyList}" var="company">
											<option
												value="${company.code}"
												<c:if test="${company.code == companyCd}">selected="selected"</c:if>
											>
												${company.codeNm}
											</option>
										</c:forEach>
										</c:if>
								</select>
								</span>
								<!-- E: 셀렉트 박스 -->
								
								<input type="image" src="/images/btn/btn_search02.gif" alt="검색" onclick="search(0); return false;"/>
	                		</li>
	                		</ul>
						</div>
	                </fieldset>
			   		</form>
	            	<!--// 상단 검색창 끝 -->
	           		<ul>
						<li class="th_stitle04 mB10">주간보고</li>
						<li class="th_navi04">단위 : 원</li>
					</ul>
           		 	<!-- 게시판 시작  -->
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>주간보고</caption>
	                   <colgroup>
	                    	<col width="50px" />
	                    	<col width="120px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col" colspan="2"><a href="javascript:searchDetail();"><span><print:date date="${startDate}" printType="S" /></span> ~ <span><print:date date="${endDate}" printType="S" /></span></a></th>
                    			<th scope="col">이월</th>
                    			<th scope="col">입금</th>
                    			<th scope="col">출금</th>
                    			<th scope="col">출금예정</th>
                    			<th scope="col">잔액</th>
                    			<th scope="col">증감</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${normalList}" var="result" varStatus="c">
	                    	<tr>
		                    	<c:if test="${c.count == 1}"><td class="txt_center brS" rowspan="${normalListSize + 1}">보통<br/>예금</td></c:if>
		                    	<td class="txt_center brS">${result.bankBook}</td>
		                    	<td class="txt_center"><print:currency cost="${result.base}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.depositSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.withdrawSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.withdrawPlanSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.result}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.total}" /></td>
	                    	</tr>
	                    	</c:forEach>
	                    	<tr>
		                    	<td class="txt_center brS bc01">계</td>
		                    	<td class="txt_center"><print:currency cost="${sumBase}" /></td>
		                    	<td class="txt_center"><print:currency cost="${sumDepositSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${sumWithdrawSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${sumWithdrawPlanSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${sumResult}" /></td>
		                    	<td class="txt_center"><print:currency cost="${sumTotal}" /></td>
	                    	</tr>
	                    	<c:forEach items="${cashList}" var="result" varStatus="c">
	                    	<tr>
		                    	<c:if test="${c.count == 1}"><td class="txt_center brS" colspan="2" rowspan="${cashListSize }">현금</td></c:if>
		                    	<td class="txt_center"><print:currency cost="${result.base}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.depositSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.withdrawSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.withdrawPlanSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.result}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.total}" /></td>
	                    	</tr>
	                    	</c:forEach>
	                    	<tr>
		                    	<td class="txt_center brS bc01" colspan="2">보통예금 / 현금 계</td>
		                    	<td class="txt_center"><print:currency cost="${totalBase}" /></td>
		                    	<td class="txt_center"><print:currency cost="${totalDepositSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${totalWithdrawSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${totalWithdrawPlanSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${totalResult}" /></td>
		                    	<td class="txt_center"><print:currency cost="${totalTotal}" /></td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<img src="../../images/btn/btn_weekly.gif" onclick="javascript:searchDetail();" class="cursorPointer"/>
               	    </div>
                 	<!-- 버튼 끝 -->

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
