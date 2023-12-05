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
	document.frm.action = '<c:url value="${rootPath}/management/fundDaily.do" />';
	document.frm.submit();
}
function searchMonthly() {
	document.frm.action = '<c:url value="${rootPath}/management/fundMonthly.do" />';
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
						<li class="stitle">일자별 조회</li>
						<li class="navi">홈 > 경영정보 > 자금관리 > 월간자금보고 > 일자별 조회</li>
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
	               	 			<a href="javascript:search(-1);" class="pR10"><img src="/images/btn/btn_prev.gif" alt="이전 페이지"></a>
	                			<span class="option_txt"><input type="text" class="input01 span_4 calGen" name="searchDate" value="${searchDate}"/></span>
								<a href="javascript:search(1);" class="pL10"><img src="/images/btn/btn_next.gif" alt="다음 페이지"></a>
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
						<li class="th_stitle04 mB10">일자별 조회</li>
						<li class="th_navi04"><span><print:date date="${searchDate}" /></span>&nbsp;/&nbsp;단위 : 원</li>
					</ul>
           		 	<!-- 게시판 시작  -->
					<div class="boardList03 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>일자별 조회</caption>
	                    <colgroup>
	                    	<col width="50px" />
	                    	<col width="100px" />
	                    	<col width="80px" />
	                    	<col width="px" />
	                    	<col width="100px" />
	                    	<col width="60px" />
	                    	<col width="50px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col">구분</th>
                    			<th scope="col">통장</th>
                    			<th scope="col">프로젝트</th>
                    			<th scope="col">내역</th>
                    			<th scope="col">금액</th>
                    			<th scope="col">현금흐름</th>
                    			<th scope="col"></th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<!-- 입금 -->
	                    	<c:choose>
	                    	<c:when test="${empty depositList}">
	                    		<tr>
			                    	<td class="txt_center lineB brS">입금</td>
			                    	<td class="txt_center lineB" colspan="6">
			                    		※ 등록된 입금 내역이 없습니다.
			                    	</td>
		                    	</tr>
	                    	</c:when>
		                    <c:otherwise>
		                    	<c:forEach items="${depositList}" var="deposit" varStatus="c">
		                    	<tr>
			                    	<c:if test="${c.count == 1}"><td class="txt_center brS lineB" rowspan="${depositListSize + 1}">입금</td></c:if>
			                    	<td class="txt_center lineN">${deposit.bankBookNm }</td>
			                    	<td class="txt_center lineN">${deposit.prjCd }</td>
			                    	<td class="lineN">${deposit.note } </td>
			                    	<td class="txt_center lineN"><print:currency cost="${deposit.expense }" /></td>
			                    	<td class="txt_center lineN">${deposit.accountNm }</td>
			                    	<td class="txt_center lineN"> </td>
		                    	</tr>
		                    	</c:forEach>
		                    	<tr>
		                    		<td class="txt_center lineB bc01">계</td>
			                    	<td class="txt_center lineB bc01" colspan="5"><print:currency cost="${depositSum }"/></td>
		                    	</tr>
		                    </c:otherwise>
		                    </c:choose>
	                    	 
	                    	<!-- 출금 -->
	                    	<c:choose>
	                    	<c:when test="${empty withdrawList}">
	                    		<tr>
			                    	<td class="txt_center lineB brS">출금</td>
			                    	<td class="txt_center lineB" colspan="6">
			                    		※ 등록된 출금 내역이 없습니다.
			                    	</td>
		                    	</tr>
	                    	</c:when>
		                    <c:otherwise>
		                    	<c:forEach items="${withdrawList}" var="withdraw" varStatus="c">
		                    	<tr>
			                    	<c:if test="${c.count == 1}"><td class="txt_center brS lineB" rowspan="${withdrawListSize + 1}">출금</td></c:if>
			                    	<td class="txt_center lineN">${withdraw.bankBookNm }</td>
			                    	<td class="txt_center lineN">${withdraw.prjCd }</td>
			                    	<td class="lineN">${withdraw.note } </td>
			                    	<td class="txt_center lineN"><print:currency cost="${withdraw.expense }" /></td>
			                    	<td class="txt_center lineN">${withdraw.accountNm }</td>
			                    	<td class="txt_center lineN"> </td>
		                    	</tr>
		                    	</c:forEach>
		                    	<tr>
		                    		<td class="txt_center lineB bc01">계</td>
			                    	<td class="txt_center lineB bc01" colspan="5"><print:currency cost="${withdrawSum }"/></td>
		                    	</tr>
		                    </c:otherwise>
		                    </c:choose>
	                    	
	                    	
	                    	<!-- 출금예정 -->
	                    	<c:choose>
	                    	<c:when test="${empty withdrawPlanList}">
	                    		<tr>
			                    	<td class="txt_center lineB brS">출금<br/>예정</td>
			                    	<td class="txt_center lineB" colspan="6">
			                    		※ 등록된 출금예정 내역이 없습니다.
			                    	</td>
		                    	</tr>
	                    	</c:when>
		                    <c:otherwise>
		                    	<c:forEach items="${withdrawPlanList}" var="withdrawPlan" varStatus="c">
		                    	<tr>
			                    	<c:if test="${c.count == 1}"><td class="txt_center brS lineB" rowspan="${withdrawPlanListSize + 1}">출금예정</td></c:if>
			                    	<td class="txt_center lineN">${withdrawPlan.bankBookNm }</td>
			                    	<td class="txt_center lineN">${withdrawPlan.prjCd }</td>
			                    	<td class="lineN">${withdrawPlan.note } </td>
			                    	<td class="txt_center lineN"><print:currency cost="${withdrawPlan.expense }" /></td>
			                    	<td class="txt_center lineN">${withdrawPlan.accountNm }</td>
			                    	<td class="txt_center lineN"> </td>
		                    	</tr>
		                    	</c:forEach>
		                    	<tr>
		                    		<td class="txt_center lineB bc01">계</td>
			                    	<td class="txt_center lineB bc01" colspan="5"><print:currency cost="${withdrawPlanSum }"/></td>
		                    	</tr>
		                    </c:otherwise>
		                    </c:choose>
		                    
	                    </tbody>
	                    </table>
					</div>
					
					<!-- 증감테이블 -->
					<div class="boardWrite03 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>증감 (전체)</caption>
	                    <colgroup>
	                    	<col width="100px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<tbody>
	                    	<tr>
		                    	<td class="title">증&nbsp;감</td>
		                    	<td class="txt_center"><print:currency cost="${depositSum - withdrawSum}"/></td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					<!-- 대체테이블 -->
					<div class="boardList03 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>대체 (전체)</caption>
	                    <colgroup>
	                    	<col width="50px" />
	                    	<col width="100px" />
	                    	<col width="80px" />
	                    	<col width="px" />
	                    	<col width="100px" />
	                    	<col width="60px" />
	                    	<col width="50px" />
                    	</colgroup>
                    	<tbody>
	                    	<!-- 대체입금 -->
	                    	<c:choose>
	                    	<c:when test="${empty transferDepositList}">
	                    		<tr>
			                    	<td class="txt_center lineB brS">대체<br/>입금</td>
			                    	<td class="txt_center lineB" colspan="6">
			                    		※ 등록된 대체입금 내역이 없습니다.
			                    	</td>
		                    	</tr>
	                    	</c:when>
		                    <c:otherwise>
		                    	<c:forEach items="${transferDepositList}" var="transferDeposit" varStatus="c">
		                    	<tr>
			                    	<c:if test="${c.count == 1}"><td class="txt_center brS lineB" rowspan="${transferDepositListSize + 1}">대체<br/>입금</td></c:if>
			                    	<td class="txt_center lineN">${transferDeposit.bankBookNm }</td>
			                    	<td class="txt_center lineN">${transferDeposit.prjCd }</td>
			                    	<td class="lineN">${transferDeposit.note } </td>
			                    	<td class="txt_center lineN"><print:currency cost="${transferDeposit.expense }" /></td>
			                    	<td class="txt_center lineN"> </td>
			                    	<td class="txt_center lineN"> </td>
		                    	</tr>
		                    	</c:forEach>
		                    	<tr>
		                    		<td class="txt_center lineB bc01">계</td>
			                    	<td class="txt_center lineB bc01" colspan="5"><print:currency cost="${transferDepositSum }"/></td>
		                    	</tr>
		                    </c:otherwise>
		                    </c:choose>
		                    
		                    <!-- 대체입금 -->
	                    	<c:choose>
	                    	<c:when test="${empty transferWithdrawList}">
	                    		<tr>
			                    	<td class="txt_center lineB brS">대체<br/>출금</td>
			                    	<td class="txt_center lineB" colspan="6">
			                    		※ 등록된 대체출금 내역이 없습니다.
			                    	</td>
		                    	</tr>
	                    	</c:when>
		                    <c:otherwise>
		                    	<c:forEach items="${transferWithdrawList}" var="transferWithdraw" varStatus="c">
		                    	<tr>
			                    	<c:if test="${c.count == 1}"><td class="txt_center brS lineB" rowspan="${transferWithdrawListSize + 1}">대체<br/>출금</td></c:if>
			                    	<td class="txt_center lineN">${transferWithdraw.bankBookNm }</td>
			                    	<td class="txt_center lineN">${transferWithdraw.prjCd }</td>
			                    	<td class="lineN">${transferWithdraw.note } </td>
			                    	<td class="txt_center lineN"><print:currency cost="${transferWithdraw.expense }" /></td>
			                    	<td class="txt_center lineN"> </td>
			                    	<td class="txt_center lineN"> </td>
		                    	</tr>
		                    	</c:forEach>
		                    	<tr>
		                    		<td class="txt_center lineB bc01">계</td>
			                    	<td class="txt_center lineB bc01" colspan="5"><print:currency cost="${transferWithdrawSum }"/></td>
		                    	</tr>
		                    </c:otherwise>
		                    </c:choose>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    	<img src="../../images/btn/btn_list.gif" onclick="javascript:searchMonthly();" class="cursorPointer"/>
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
