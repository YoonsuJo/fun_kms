<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script type="text/javascript">
function search(moveDate) {
	document.frm.moveDate.value = moveDate;
	document.frm.action = '<c:url value="${rootPath}/management/fundMonthly.do" />';
	document.frm.submit();
}
function searchDaily(date) {
	date = "" + (date > 9 ? date : "0" + date);
	document.frm.searchDate.value = document.frm.searchDate.value.substring(0, 6) + date;
	document.frm.action = '<c:url value="${rootPath}/management/fundDaily.do" />';
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
						<li class="stitle">월간보고</li>
						<li class="navi">홈 > 경영정보 > 자금보고 > 월간보고</li>
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
	               	 			<a href="javascript:search(-30);" class="pR10"><img src="/images/btn/btn_prev.gif" alt="이전 페이지"></a>
	                			<span class="option_txt"><input type="text" class="input01 span_4 calGen" name="searchDate" value="${searchDate}"/></span>
								<a href="javascript:search(30);" class="pL10"><img src="/images/btn/btn_next.gif" alt="다음 페이지"></a>
	                		</li>
	                		<li class="li_right">
	                			<!-- S: 셀렉트 박스 -->
								<span class="select_r5">
								<select name="companyCd">
										<c:forEach items="${companyList}" var="company">
											<option
												value="${company.code}"
												<c:if test="${company.code == companyCd}">selected="selected"</c:if>
											>
												${company.codeNm}
											</option>
										</c:forEach>
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
						<li class="th_stitle04 mB10">월간보고</li>
						<li class="th_navi04">기간 : <span><print:date date="${startDate}" /></span>&nbsp;~&nbsp;<span><print:date date="${endDate}" /></span>&nbsp;/&nbsp;단위 : 원</li>
					</ul>
           		 	<!-- 게시판 시작  -->
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>월간보고</caption>
	                   <colgroup>
	                    	<col width="80px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col">일자</th>
                    			<th scope="col">기초</th>
                    			<th scope="col">입금</th>
                    			<th scope="col">출금</th>
                    			<th scope="col">출금예정</th>
                    			<th scope="col">잔액</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${totalList}" var="result" varStatus="c">
	                    	<tr>
		                    	<td class="txt_center brS bc01"><a href="javascript:searchDaily('${result.date }');">${result.date }</a></td>
		                    	<td class="txt_center"><print:currency cost="${result.base}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.depositSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.withdrawSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.withdrawPlanSum}" /></td>
		                    	<td class="txt_center"><print:currency cost="${result.result}" /></td>
	                    	</tr>
	                    	</c:forEach>
	                    	<tr>
		                    	<td class="txt_center brS bc01">계</td>
		                    	<td class="txt_center bc01"><print:currency cost="${sumBase}" /></td>
		                    	<td class="txt_center bc01"><print:currency cost="${sumDepositSum}" /></td>
		                    	<td class="txt_center bc01"><print:currency cost="${sumWithdrawSum}" /></td>
		                    	<td class="txt_center bc01"><print:currency cost="${sumWithdrawPlanSum}" /></td>
		                    	<td class="txt_center bc01"><print:currency cost="${sumResult}" /></td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->

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
