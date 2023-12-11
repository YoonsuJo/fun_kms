<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(moveYear) {
	document.frm.searchYear.value = new Number("${searchVO.searchYear}") + moveYear;
	document.frm.submit();
}
function searchAll() {
	document.frm.searchOrgNm.value = "";
	document.frm.searchOrgId.value = "";
	document.frm.searchUserNm.value = "";
	document.frm.submit();
}
function selRadio(i) {
	document.frm.searchCondition[i].checked = true;

	var orgNm = document.getElementById("orgNm");
	var orgId = document.getElementById("orgId");
	var usrNm = document.getElementById("usrNm");
	var usrTree = document.getElementById("usrTree");
	var orgTree = document.getElementById("orgTree");

	if (i == 0) {
		orgNm.value = "";
		orgId.value = "";
		usrNm.value = "${searchVO.searchUserNm}";
		orgNm.style.display = "none";
		orgId.style.display = "none";
		usrNm.style.display = "";
		orgTree.style.display = "none";
		usrTree.style.display = "";
	}
	else if (i == 1) {
		orgNm.value = "${searchVO.searchOrgNm}";
		orgId.value = "${searchVO.searchOrgId}";
		usrNm.value = "";
		orgNm.style.display = "";
		orgId.style.display = "";
		usrNm.style.display = "none";
		orgTree.style.display = "";
		usrTree.style.display = "none";
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
						<li class="stitle">자기개발비 사용 통계</li>
						<li class="navi">홈 > 인사정보 > 복리후생 > 자기개발비 사용내역</li>
					</ul>
				</div>
				
				<span class="stxt">자기개발비 사용 내역을 년도별로 조회할 수 있습니다.</span>
				<span class="stxt_btn"><a href="${rootPath}/approval/approvalW.do?templtId=11"><img src="${imagePath}/btn/btn_myDvlpRequest.gif"/></a></span>
				<!-- S: section -->
				<div class="section01">
				
			   		<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST" action="${rootPath}/member/selectSelfDevStatistic.do" onsubmit="search(0); return false;">
					<input type="hidden" name="searchOrgId" id="orgId" />
					<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
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
		                			<label><input type="radio" class="radio" name="searchCondition" value="0" onclick="selRadio(0);"/> 사용자</label>
		                			<label><input type="radio" class="radio" name="searchCondition" value="1" onclick="selRadio(1);"/> 부서</label><span class="pL7"></span>
									<input type="text" class="search_txt02 userNameAuto" name="searchUserNm" id="usrNm"/>
									<input type="text" class="search_txt02" name="searchOrgNm" id="orgNm" onfocus="orgGen('orgNm','orgId',0)" readonly="readonly"/>
									<img src="${imagePath}/btn/btn_tree.gif" id="usrTree" class="cursorPointer" onclick="usrGen('usrNm',1);"/>
									<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);"/>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(0); return false;"/>
									<img src="${imagePath}/btn/btn_allview.gif" alt="전체보기" class="cursorPointer" onclick="searchAll();"/>
									<script>selRadio("${searchVO.searchCondition}");</script>
		                		</li>
	                		</ul>
						</div>
	                </fieldset>
			   		</form>
	            	<!--// 상단 검색창 끝 -->
	            	
	            	<p class="th_stitle">자기개발비 사용 통계</p>
		            <!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col60" />
	                    	<col class="col80" />
	                    	<col width="px" />
	                    	<col class="col80" />
	                    	<col class="col80" />
	                    	<col class="col80" />
	                   	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th rowspan="2"><span
									<c:if test="${searchVO.orderBy != 'name'}">class="th_a1"</c:if> 
									<c:if test="${searchVO.orderBy == 'name'}">class="th_a2"</c:if> >
									<a href="javascript:clickOrderBy('name');">이름</a></span></th>
	                    		<th rowspan="2"><span
									<c:if test="${searchVO.orderBy != 'org'}">class="th_a1"</c:if> 
									<c:if test="${searchVO.orderBy == 'org'}">class="th_a2"</c:if> >
									<a href="javascript:clickOrderBy('org');">소속부서</a></span></th>
	                    		<th rowspan="2"><span
									<c:if test="${searchVO.orderBy != 'selfDev'}">class="th_a1"</c:if> 
									<c:if test="${searchVO.orderBy == 'selfDev'}">class="th_a2"</c:if> >
									<a href="javascript:clickOrderBy('selfDev');">할당금액</a></span></th>
	                    		<th rowspan="2"><span
									<c:if test="${searchVO.orderBy != 'used'}">class="th_a1"</c:if> 
									<c:if test="${searchVO.orderBy == 'used'}">class="th_a2"</c:if> >
									<a href="javascript:clickOrderBy('used');">사용금액</a></span></th>
	                    		<th colspan="2" class="td_last">잔액</th>
	                    	</tr>
	                    	<tr>
	                    		<th><span
									<c:if test="${searchVO.orderBy != 'fullLeft'}">class="th_a1"</c:if> 
									<c:if test="${searchVO.orderBy == 'fullLeft'}">class="th_a2"</c:if> >
									<a href="javascript:clickOrderBy('fullLeft');">전액</a></span></th>
	                    		<th class="td_last"><span
									<c:if test="${searchVO.orderBy != 'halfLeft'}">class="th_a1"</c:if> 
									<c:if test="${searchVO.orderBy == 'halfLeft'}">class="th_a2"</c:if> >
									<a href="javascript:clickOrderBy('halfLeft');">반액</a></span></th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
			                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
			                    	<td class="txt_center"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectSelfDevView.do?userNo=${result.userNo}">${result.selfDev}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectSelfDevView.do?userNo=${result.userNo}">${result.usedPrint}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/selectSelfDevView.do?userNo=${result.userNo}">${result.fullLeft}</a></td>
			                    	<td class="td_last txt_center"><a href="${rootPath}/member/selectSelfDevView.do?userNo=${result.userNo}">${result.halfLeft}</a></td>
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
