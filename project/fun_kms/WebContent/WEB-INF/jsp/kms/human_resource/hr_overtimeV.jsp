<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function loadOvertimeDetail(userNo,month) {
	$.post("/member/selectOvertimeDetail.do?searchYear=${searchVO.searchYear}&searchMonth=" + month + "&userNo=" + userNo,
			function(data){
				$('#overtimeDetail').html(data);
			}
	);
}
function moveYear(i) {
	document.frm.searchYear.value = new Number(document.frm.searchYear.value) + i;
	document.frm.action = '<c:url value="${rootPath}/member/selectOvertimeView.do" />';
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
function updateOT(wsId) {
	document.subFrm.wsId.value = wsId;
	document.subFrm.action = '<c:url value="${rootPath}/member/updateOvertimeView.do" />';
	document.subFrm.submit();
}
function deleteOT(userNo,month,wsId) {
	if (confirm("삭제하시겠습니까?")) {
		document.subFrm.wsId.value = wsId;
		document.subFrm.searchMonth.value = month;
		document.subFrm.userNo.value = userNo;
		document.subFrm.action = '<c:url value="${rootPath}/member/deleteOvertime.do" />';
		document.subFrm.submit();
	}
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
							<li class="stitle">연장근무 상세내역</li>
							<li class="navi">홈 > 인사정보> 근무현황 > 연장근무내역</li>
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
					<fieldset>
					<legend>상단 검색</legend>
						<div class="scheduleDate mB20">
							<ul>
							<li class="li_left">
				   	 			<a href="javascript:moveYear(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
								<span class="option_txt">${searchVO.searchYear}년</span>
								<a href="javascript:moveYear(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
							</li>
							<li class="li_right">
								<input type="radio" name="searchCondition" value="0" onclick="selRadio(0);" <c:if test="${searchVO.searchCondition == '0'}">checked="checked"</c:if>>사용자<span class="pL7"></span>
								<input type="radio" name="searchCondition" value="1" onclick="selRadio(1);" <c:if test="${searchVO.searchCondition == '1'}">checked="checked"</c:if>>부서<span class="pL7"></span>
								<input type="text" name="searchUserNm" id="usrNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}"/>
								<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0);"/>
								<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);"/>
								<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="Search(0); return false;"/>
								<input type="image" src="${imagePath}/btn/btn_allview.gif" alt="전체보기" onclick="allSearch(); return false;"/>
							</li>
							</ul>
						</div>
					</fieldset>
					</form>
					<script>selRadio("${searchVO.searchCondition}");</script>
					<!-- 상단 검색창 끝 -->
		            	
		            <!-- 게시판 시작  -->	
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
		                    </thead>
		                    <tbody>
		                    	<tr>
			                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
			                    	<td class="txt_center"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/></td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','01');">${result.cnt1}일<br/>(${result.sum1})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','02');">${result.cnt2}일<br/>(${result.sum2})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','03');">${result.cnt3}일<br/>(${result.sum3})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','04');">${result.cnt4}일<br/>(${result.sum4})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','05');">${result.cnt5}일<br/>(${result.sum5})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','06');">${result.cnt6}일<br/>(${result.sum6})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','07');">${result.cnt7}일<br/>(${result.sum7})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','08');">${result.cnt8}일<br/>(${result.sum8})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','09');">${result.cnt9}일<br/>(${result.sum9})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','10');">${result.cnt10}일<br/>(${result.sum10})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','11');">${result.cnt11}일<br/>(${result.sum11})</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','12');">${result.cnt12}일<br/>(${result.sum12})</td>
			                    	<td class="td_last txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','');">${result.cnt}일<br/>(${result.sum})</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						
						<p class="th_stitle">연장근무 상세내역</p>
						<div class="boardList02 mB20" id="overtimeDetail">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col60" />
		                    	<col class="col100" />
		                    	<col class="col90" />
		                    	<col width="px" />
		                    	<col class="col60" />
		                    	<col class="col60" />
		                    	<col class="col70" />
		                    	<col class="col40" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>이름</th>
		                    		<th>날짜</th>
		                    		<th>시간</th>
		                    		<th>사유</th>
		                    		<th>등록자</th>
		                    		<th>비고</th>
		                    		<th>등록일시</th>
		                    		<th class="td_last">변경</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach items="${detailList}" var="result">
			                    	<tr>
				                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>				                    	
				                    	<td class="txt_center">${result.wsBgnDe}</td>
				                    	<td class="txt_center">18:00 ~ ${result.wsBgnTm}:00</td>
				                    	<td class="txt_center"><print:textarea text="${result.wsPurpose}" /></td>
				                    	<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
				                    	<td class="txt_center">				                    	 				                    	 
				                    	 <c:if test="${result.isRegBeforeTen == 'Y'}">10시이전</c:if>
<!--				                    	 <c:if test="${result.isRegBefore == 'Y'}">미리등록</c:if>-->
				                    	 <c:if test="${result.isInnerNetwork == 'N'}">외부등록 </c:if>				                    	 
				                    	</td>				                    	
				                    	<td class="txt_center">${result.regDt}</td>
				                    	<td class="td_last txt_center">
				                    		<a href="javascript:updateOT('${result.wsId}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
				                    		<a href="javascript:deleteOT('${result.userNo}','${searchVO.searchMonth}','${result.wsId}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
				                    	</td>
			                    	</tr>
		                    	</c:forEach>
		                    	<c:if test="${empty detailList}">
		                    		<tr>
		                    			<td class="txt_center td_last" colspan="6">조회된 데이터가 없습니다.</td>
		                    		</tr>
		                    	</c:if>                   			                    			                    	
		                    </tbody>
		                    </table>
						</div>
						<!--// 게시판  끝  -->
		            	<form name="subFrm" method="POST">
		            		<input type="hidden" name="wsId"/>
		            		<input type="hidden" name="searchMonth"/>
		            		<input type="hidden" name="userNo"/>
		            	</form>
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
