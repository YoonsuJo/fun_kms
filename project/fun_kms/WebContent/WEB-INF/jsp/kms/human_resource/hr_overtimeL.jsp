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
	document.frm.searchYear.value = new Number(document.frm.searchYear.value) + i;
	document.frm.action = '<c:url value="${rootPath}/member/selectOvertimeList.do" />';
	document.frm.submit();
}
function search(i) {
	document.frm.searchYear.value = new Number(document.frm.searchYear.value) + i;
	document.frm.userNo.value = "";
	document.frm.action = '<c:url value="${rootPath}/member/selectOvertimeList.do" />';
	document.frm.submit();
}
function allSearch() {
	document.frm.userNo.value = "";
	document.frm.searchKeyword.value = "";
	document.frm.action = '<c:url value="${rootPath}/member/selectOvertimeList.do" />';
	document.frm.submit();
}
function view(userNo) {
	document.frm.userNo.value = userNo;
	document.frm.action = '<c:url value="${rootPath}/member/selectOvertimeView.do" />';
	document.frm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;

	var orgTree = document.getElementById("orgTree");
	var orgNm = document.getElementById("orgNm");
	var usrNm = document.getElementById("usrNm");
	
	if (n == 0) {
		orgTree.style.display = "none";
		orgNm.style.display = "none";
		usrNm.style.display = "";
	}
	else if (n == 1) {
		orgTree.style.display = "";
		orgNm.style.display = "";
		usrNm.style.display = "none";
	}
}
function clickOrderBy(n){
	document.frm.orderBy.value = n;
	search(0);
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
						<li class="stitle">연장근무 통계</li>
						<li class="navi">홈 > 인사정보 > 근무현황 > 연장근무내역</li>
					</ul>
				</div>	
				
				<span class="stxt">연장근무(야근) 내역을 조회할 수 있습니다.</span>
				<span class="stxt_btn"><a href="${rootPath}/member/insertOvertimeView.do"><img src="${imagePath}/btn/btn_overtime.gif"/></a></span>
				
				<!-- S: section -->
				<div class="section01">
				<!-- 상단 검색창 시작 -->
					<form name="frm" method="POST" action="${rootPath}/member/selectOvertimeList.do" onsubmit="search(0); return false;">
	            	<input type="hidden" name="searchYear" value="${searchVO.searchYear}" />
	            	<input type="hidden" name="userNo" value="${searchVO.userNo}" />
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<input type="hidden" name="orderBy" id="orderBy" value="${searchVO.orderBy}"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="scheduleDate mB20">
							<ul>
							<li class="li_left">
				   	 			<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
								<span class="option_txt">${searchVO.searchYear}년</span>
								<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
							</li>
							<li class="li_right">
								<input type="radio" name="searchCondition" value="0" onclick="selRadio(0);" <c:if test="${searchVO.searchCondition == '0'}">checked="checked"</c:if>>사용자<span class="pL7"></span>
								<input type="radio" name="searchCondition" value="1" onclick="selRadio(1);" <c:if test="${searchVO.searchCondition == '1'}">checked="checked"</c:if>>부서<span class="pL7"></span>
								<input type="text" name="searchUserNm" id="usrNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}"/>
								<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0);"/>
								<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);"/>
								<input type="image" src="${imagePath}/btn/btn_search02.gif"/>
								<input type="image" src="${imagePath}/btn/btn_allview.gif" alt="전체보기" onclick="allSearch(); return false;"/>
							</li>
							</ul>
						</div>
					</fieldset>
					</form>
					<script>selRadio("${searchVO.searchCondition}");</script>
				<!-- 상단 검색창 끝 -->
				
	            <!-- 월별 연장근무 통계 시작  -->	
            		<p class="th_stitle">월별 연장근무 통계</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup><col class="col10" /><col class="col10" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col10" /></colgroup>
	                    <thead>
	                    	<tr>
	                    		<th rowspan="2">이름</th>
	                    		<th rowspan="2">소속부서</th>
	                    		<th colspan="12">${searchVO.searchYear}년도 월별 연장근무일수 (시간)</th>
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
	                    	<tr class="height_th">
	                    		<th colspan="2">합계<br/>(시간)</th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_1'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_1'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_1');">${sum.cnt1}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_1'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_1'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_1');">(${sum.sum1})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_2'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_2'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_2');">${sum.cnt2}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum2'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum2'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_2');">(${sum.sum2})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_3'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_3'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_3');">${sum.cnt3}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_3'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_3'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_3');">(${sum.sum3})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_4'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_4'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_4');">${sum.cnt4}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_4'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_4'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_4');">(${sum.sum4})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_5'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_5'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_5');">${sum.cnt5}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_5'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_5'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_5');">(${sum.sum5})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_6'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_6'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_6');">${sum.cnt6}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_6'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_6'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_6');">(${sum.sum6})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_7'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_7'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_7');">${sum.cnt7}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_7'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_7'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_7');">(${sum.sum7})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_8'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_8'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_8');">${sum.cnt8}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_8'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_8'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_8');">(${sum.sum8})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_9'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_9'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_9');">${sum.cnt9}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_9'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_9'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_9');">(${sum.sum9})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_10'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_10'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_10');">${sum.cnt10}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_10'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_10'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_10');">(${sum.sum10})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_11'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_11'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_11');">${sum.cnt11}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_11'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_11'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_11');">(${sum.sum11})</a></span></th>
	                    		<th>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'cnt_12'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt_12'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt_12');">${sum.cnt12}일</a></span><br/>
	                    		<span 
								<c:if test="${searchVO.orderBy != 'sum_12'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum_12'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum_12');">(${sum.sum12})</a></span></th>
	                    		<th class="td_last">
	                    		<span 
	                    		<c:if test="${searchVO.orderBy != 'cnt'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'cnt'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('cnt');">${sum.cnt}일</a></span><br/>
								<span 
								<c:if test="${searchVO.orderBy != 'sum'}">class="th_a1"</c:if> 
								<c:if test="${searchVO.orderBy == 'sum'}">class="th_a2"</c:if> >
								<a href="javascript:clickOrderBy('sum');">(${sum.sum})</a></span>
								</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result">
		                    	<tr class="height_td">
			                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
			                    	<td class="txt_center"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt1}일<br/>(${result.sum1})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt2}일<br/>(${result.sum2})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt3}일<br/>(${result.sum3})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt4}일<br/>(${result.sum4})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt5}일<br/>(${result.sum5})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt6}일<br/>(${result.sum6})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt7}일<br/>(${result.sum7})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt8}일<br/>(${result.sum8})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt9}일<br/>(${result.sum9})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt10}일<br/>(${result.sum10})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt11}일<br/>(${result.sum11})</a></td>
			                    	<td class="txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt12}일<br/>(${result.sum12})</a></td>
			                    	<td class="td_last txt_center"><a href="javascript:view('${result.userNo}')">${result.cnt}일<br/>(${result.sum})</a></td>
		                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
					<!--// 월별 연장근무 통계  끝  -->
	            	
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
