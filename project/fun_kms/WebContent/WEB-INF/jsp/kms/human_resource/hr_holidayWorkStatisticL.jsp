<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;

	if (n == 0) {
		document.frm.searchUserNm.value = "${searchVO.searchUserNm}";
		document.frm.searchOrgNm.value = "";
		document.frm.searchOrgId.value = "";
		
		document.frm.searchUserNm.style.display = "";
		document.frm.searchOrgNm.style.display = "none";
		document.frm.searchOrgId.style.display = "none";
		document.getElementById("usrTree").style.display = "";
		document.getElementById("orgTree").style.display = "none";
	}
	else if (n == 1) {
		document.frm.searchUserNm.value = "";
		document.frm.searchOrgNm.value = "${searchVO.searchOrgNm}";
		document.frm.searchOrgId.value = "${searchVO.searchOrgId}";
		
		document.frm.searchUserNm.style.display = "none";
		document.frm.searchOrgNm.style.display = "";
		document.frm.searchOrgId.style.display = "";
		document.getElementById("usrTree").style.display = "none";
		document.getElementById("orgTree").style.display = "";
	}
}
function search(moveYear) {
	document.frm.searchYear.value = new Number("${searchVO.searchYear}") + moveYear;
	document.frm.submit();
}
function searchAll() {
	document.frm.searchUserNm.value = "";
	document.frm.searchOrgNm.value = "";
	document.frm.searchOrgId.value = "";
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
						<li class="stitle">휴일근무 통계</li>
						<li class="navi">홈 > 인사정보 > 근무현황 > 휴일근무내역</li>
					</ul>
				</div>
				
				<span class="stxt">휴일근무 내역을 년도별로 조회할 수 있습니다.</span>
				<span class="stxt_btn"><a href="${rootPath}/approval/approvalW.do?templtId=5"><img src="${imagePath}/btn/btn_holidayWork.gif"/></a></span>
				<!-- S: section -->
				<div class="section01">
				
			   		<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST" action="${rootPath}/member/selectHolidayWorkStatisticList.do" onsubmit="search(0); return false;">
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
					<input type="hidden" name="searchMonth"/>
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
	                			<label><input type="radio" name="searchCondition" value="0" onclick="selRadio(0);"/> 사용자</label>
	                			<label><input type="radio" name="searchCondition" value="1" onclick="selRadio(1);"/> 부서</label><span class="pL7"></span>
								<input type="text" class="search_txt02 userNameAuto" name="searchUserNm" id="usrNm" value="${searchVO.searchUserNm }" />
								<input type="text" class="search_txt02" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0);"/>
								<img src="${imagePath}/btn/btn_tree.gif" id="usrTree" class="cursorPointer" onclick="usrGen('usrNm', 1);"/>
								<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm', 'orgId', 0);"/>
								<input type="image" src="${imagePath}/btn/btn_search02.gif"/>
								<img src="${imagePath}/btn/btn_allview.gif" alt="전체보기" class="cursorPointer" onclick="searchAll();"/>
	                		</li>
	                		</ul>
						</div>
	                </fieldset>
			   		</form>
			   		<script type="text/javascript">
			   		selRadio("${searchVO.searchCondition}");
			   		</script>
	            	<!--// 상단 검색창 끝 -->
	            	
	            	<p class="th_stitle">월별 휴일근무 통계</p>
		            <!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col50" />
	                    	<col width="px" />
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
	                    	<col class="col50" />
	                   	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th rowspan="2">이름</th>
	                    		<th rowspan="2">소속부서</th>
	                    		<th colspan="12">${searchVO.searchYear}년도 월별 휴일근무일수</th>
	                    		<th class="td_last" rowspan="2">합계</th>
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
	                    	<tr>
	                    		<th colspan="2">합계</th>
	                    		<th>${sum.hol01}일</th>
	                    		<th>${sum.hol02}일</th>
	                    		<th>${sum.hol03}일</th>
	                    		<th>${sum.hol04}일</th>
	                    		<th>${sum.hol05}일</th>
	                    		<th>${sum.hol06}일</th>
	                    		<th>${sum.hol07}일</th>
	                    		<th>${sum.hol08}일</th>
	                    		<th>${sum.hol09}일</th>
	                    		<th>${sum.hol10}일</th>
	                    		<th>${sum.hol11}일</th>
	                    		<th>${sum.hol12}일</th>
	                    		<th class="td_last">${sum.holSum}일</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.userNm}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.orgnztNm}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol01}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol02}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol03}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol04}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol05}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol06}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol07}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol08}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol09}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol10}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol11}일</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.hol12}일</a></td>
			                    	<td class="td_last txt_center"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do?searchUserNo=${result.userNo}">${result.holSum}일</a></td>
		                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
	                </div>
					<!--// 게시판  끝  -->
					
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
