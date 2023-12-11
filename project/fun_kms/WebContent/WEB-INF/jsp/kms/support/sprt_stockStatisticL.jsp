<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function moveYear(i) {
	document.frm.year.value = new Number(document.frm.year.value) + i;
	document.frm.action = '<c:url value="${rootPath}/support/stockStatsL.do?type=${type}" />';
	document.frm.submit();
}
</script>
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
						<li class="stitle">월별현황</li>
						<li class="navi">홈 > 업무지원 > 재고현황 > ${subTitle}</li>
					</ul>
				</div>	
							
				<span class="stxt">${subTitle}을 조회할 수 있습니다.</span>
					
				<!-- S: section -->
				<div class="section01">
				<!-- 상단 검색창 시작 -->
					<form name="frm" method="POST" action="${rootPath}/member/selectOvertimeList.do" onsubmit="search(0); return false;">
	            	<input type="hidden" name="year" value="${year}" />
					<fieldset>
					<legend>상단 검색</legend>
						<div class="scheduleDate mB20">
							<ul>
							<li class="li_left">
				   	 			<a href="javascript:moveYear(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
								<span class="option_txt">${year}년</span>
								<a href="javascript:moveYear(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
							</li>
							</ul>
						</div>
					</fieldset>
					</form>
				<!-- 상단 검색창 끝 -->
	            <!-- 월별 연장근무 통계 시작  -->
            		<ul>
						<li class="th_stitle04 mB10">${subTitle}</li>
						<c:choose>
						<c:when test="${type == 'sale'}">
							<li class="th_navi04"><a href="${rootPath}/support/stockStatsL.do?type=sell">구 월별 판매현황 바로가기</a></li>
						</c:when>
						<c:when test="${type == 'buy'}">
							<li class="th_navi04"><a href="${rootPath}/support/stockStatsL.do?type=buy">구 월별 구매현황 바로가기</a></li>
						</c:when>
						<c:otherwise>
							<li class="th_navi04"><a href="${rootPath}/support/stockStatsL.do?type=stock">구 월별 재고현황 바로가기</a></li>
						</c:otherwise>
						</c:choose>
					</ul>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col10" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col40" />
	                    	<col class="col10" />
	                    </colgroup>
	                    <thead>
	                    	<tr>
	                    		<th rowspan="2">구분</th>
	                    		<th colspan="12">${year}년도 ${subTitle}  [단위:천원]</th>
	                    		<th rowspan="2" class="td_last">합계</th>
	                    	</tr>
	                    	<tr>
	                    		<th>1월</th>
	                    		<th>2월</th>
	                    		<th>3월</th>
	                    		<th>4월</th>
	                    		<th>5월</th>
	                    		<th>6월</th>
	                    		<th>7월</th>
	                    		<th>8월</th>
	                    		<th>9월</th>
	                    		<th>10월</th>
	                    		<th>11월</th>
	                    		<th>12월</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result">
		                    	<tr class="height_td">
			                    	<td class="txt_center">${result.itemName}</td>
			                    	<td class="txt_center">${result.cnt01}<br/><print:currency cost="${result.price01}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt02}<br/><print:currency cost="${result.price02}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt03}<br/><print:currency cost="${result.price03}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt04}<br/><print:currency cost="${result.price04}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt05}<br/><print:currency cost="${result.price05}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt06}<br/><print:currency cost="${result.price06}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt07}<br/><print:currency cost="${result.price07}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt08}<br/><print:currency cost="${result.price08}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt09}<br/><print:currency cost="${result.price09}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt10}<br/><print:currency cost="${result.price10}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt11}<br/><print:currency cost="${result.price11}" divideBy="1000"/></td>
			                    	<td class="txt_center">${result.cnt12}<br/><print:currency cost="${result.price12}" divideBy="1000"/></td>
			                    	<td class="td_last txt_center">${result.cnt}<br/><print:currency cost="${result.price}" divideBy="1000"/></td>
		                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
					<!--// 월별 구매/판매/재고 통계  끝  -->
	            	
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
