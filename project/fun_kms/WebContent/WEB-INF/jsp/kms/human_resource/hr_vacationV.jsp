<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function loadVacationDetail(userNo, vacTyp) {
	//$.post("/member/selectVacationSummaryDetail.do?searchYear=${searchVO.searchYear}&vacTyp=" + vacTyp + "&userNo=" + userNo,
	$.post("/member/selectVacationSummaryDetail.do?searchDate=${searchVO.searchDate}&vacTyp=" + vacTyp + "&userNo=" + userNo,
		function(data){
			$('#vacationSummaryDetail').html(data);
		}
	);
}

window.onload = function(){
	loadVacationDetail(${result.userNo}, '');
}

function modifyAppVac(docId) {

	if (${result.userNo} != ${user.userNo} && ${user.admin} == false) {
		alert('휴가사용내역은 본인만 수정할 수 있습니다.');
		return;
	}
	
	var url = '${rootPath}/approval/approvalRW.do?docId=' + docId + '&reWriteTyp=1';	
	var action = '<c:url value="' + url + '"/>';	
	document.frm.action = action;	
	document.frm.submit();
}
function moveYear(i) {
	var searchDate = document.frm.searchDate.value;
	document.frm.searchDate.value = new Number(searchDate.substring(0,4)) + i + "" + searchDate.substring(4,8);
	document.frm.action = '<c:url value="${rootPath}/member/selectVacationSummaryView.do" />';
	document.frm.submit();
}
function search(i) {
	if(document.frm.searchCondition[0].checked){
		var searchDate = document.frm.searchDate.value;
		document.frm.searchDate.value = new Number(searchDate.substring(0,4)) + i + "" + searchDate.substring(4,8);
		document.frm.action = '<c:url value="${rootPath}/member/selectVacationSummaryView.do" />';
		document.frm.submit();
	}else{
		var searchDate = document.frm.searchDate.value;
		document.frm.searchDate.value = new Number(searchDate.substring(0,4)) + i + "" + searchDate.substring(4,8);
		document.frm.userNo.value = "";
		document.frm.action = '<c:url value="${rootPath}/member/selectVacationSummaryList.do" />';
		document.frm.submit();
	}

}
function allSearch() {
	document.frm.userNo.value = "";
	document.frm.searchUserNm.value = "";
	document.frm.searchOrgNm.value = "";
	document.frm.action = '<c:url value="${rootPath}/member/selectVacationSummaryList.do" />';
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
function showVacTyp(docId){
	$("#vacTypDocId").val(docId);
	$('#vacationTypChange').show();
	$('#selectVacTyp').focus();	
}
function vactyp(){
	var text = $("#selectVacTyp > option:selected").val();	
	$("#vacTyp").val(text);	
}
function modifyAppVacTyp(){	
	var vacTyp = $("#selectVacTyp > option:selected").val();
	var docId = $("#vacTypDocId").val();
	
	if(vacTyp == ""){
		alert("휴가종류를 선택해주세요");
		$('#selectVacTyp').focus();
		return;
	}
	
	var url = '${rootPath}/member/updateVactyp.do?docId=' + docId + '&vacTyp=' + vacTyp;	
	var action = '<c:url value="' + url + '"/>';	
	document.formVacTyp.action = action;	
	document.formVacTyp.submit();
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
							<li class="stitle"> 휴가사용 상세내역</li>
							<li class="navi">홈 > 인사정보> 근무현황 > 휴가사용내역</li>
						</ul>
					</div>	
					
					<span class="stxt">휴가사용 내역을 년도별로 조회할 수 있습니다. </span>
					<span class="stxt_btn"><a href="${rootPath}/approval/approvalW.do?templtId=2"><img src="${imagePath}/btn/btn_vacation02.gif"/></a></span>
					
					<!-- S: section -->
					<div class="section01">
						
					<!-- 상단 검색창 시작 -->
						<form name="frm" method="POST" action="${rootPath}/member/selectVacationSummaryList.do" onsubmit="search(0); return false;">
		            	<input type="hidden" name="userNo" value="${searchVO.userNo}" />
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="scheduleDate mB20">
								<ul>
								<li class="li_left">
					   	 			<a href="javascript:moveYear(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
									<span class="option_txt"><input type="text" name="searchDate" class="calGen" value="${searchVO.searchDate}" style="width:50px;" maxlength="8" /></span>
									<a href="javascript:moveYear(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
								</li>
								<li class="li_left" style="margin-left:10px;">
									<span class="option_txt"> 조회 날짜 : <input type="text" value="${result.startVacation}" style="width:70px;" maxlength="8" readonly/> ~
									<input type="text" value="${result.endVacation}" style="width:70px;" maxlength="8" readonly/></span>
								</li>								
								<li class="li_right">
									<input type="radio" name="searchCondition" value="0" onclick="selRadio(0);" <c:if test="${searchVO.searchCondition == '0'}">checked="checked"</c:if>>사용자<span class="pL7"></span>
									<input type="radio" name="searchCondition" value="1" onclick="selRadio(1);" <c:if test="${searchVO.searchCondition == '1'}">checked="checked"</c:if>>부서<span class="pL7"></span>
									<input type="text" name="searchUserNm" id="usrNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}" onfocus="usrGen('usrNm',1)"/>
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
		            	
		            <!-- 게시판 시작  -->	
		            	<p class="th_stitle">월별 휴가사용 통계</p>
		            	<div class="th_txt">근속년수 1년 미만인 경우 1개월 개근시 1일의 연차휴가가 발생합니다. 
		            	<br/>근속년수 1년 이상인 경우 매년 15일의 연차휴가가 부여되며, 2년에 한번씩 1일을 가산합니다.</div>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
			                    <col width="px" />
			                    <col width="px" />
			                    <col width="px" />
			                    <col width="px" />
			                    <!-- <col width="px" /> -->
			                    <!-- <col width="px" /> -->
			                    <col width="px" />
			                    <col width="px" />
			                    <col width="px" />
			                    <col width="px" />
			                    <col width="px" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
		                    		<th rowspan="2">이름</th>
		                    		<th rowspan="2">입사일</th>
		                    		<th rowspan="2">소속부서</th>
		                    		<th rowspan="2">근속기간</th>
		                    		<th colspan="1">지급일수</th>
		                    		<th colspan="5" class="td_last">사용일수</th>
		                    	</tr>
		                    	<tr>
		                    		<th>연차</th>
		                    		<!-- <th>하계</th> -->
		                    		<th>연차</th>
		                    		<!-- <th>하계</th> -->
		                    		<th>경조</th>
		                    		<th>특별</th>
		                    		<th>기타</th>
		                    		<th class="td_last">계</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<tr>
			                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
			                    	<td class="txt_center">${result.compinDt}</td>
			                    	<td class="txt_center">${result.orgnztNm}</td>
			                    	<td class="txt_center">${result.workLength}</td>
			                    	<td class="txt_center">${result.vacCnt}</td>
			                    	<%-- <td class="txt_center">${result.sumVacCnt}</td> --%>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','1')">${result.cntNm}</td>
			                    	<%-- <td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','5')">${result.cntSv}</td> --%>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','2')">${result.cntHs}</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','3')">${result.cntSpcl}</td>
			                    	<td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','4')">${result.cntEtc}</td>
			                    	<td class="td_last txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','')">${result.cntAll}</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						
						<p class="th_stitle">휴가사용 상세내역</p>
						<div class="boardList02 mB20" id="vacationSummaryDetail">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col250" /><col class="col70" /><col class="col70" /><col width="px" /><col class="col40" /></colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>기간</th>
		                    		<th>종류</th>
		                    		<th>일수</th>
		                    		<th>사유</th>
		                    		<th class="td_last">변경</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach items="${resultList}" var="result">
			                    	<tr>
				                    	<td class="txt_center">${result.st} ~ ${result.ed}</td>
				                    	<td class="txt_center">${result.vacTyp}</td>
				                    	<td class="txt_center">${result.sumDate}</td>
				                    	<td class="txt_center">${result.content}</td>
				                    	<td class="td_last txt_center">
				                    		<img src="${imagePath}/btn/btn_plus02.gif"/>
				                    	</td>
			                    	</tr>
		                    	</c:forEach>
		                    	<c:if test="${empty resultList}">
			                    	<tr>
			                    		<td class="txt_center td_last" colspan="5">조회된 휴가사용내역이 없습니다.</td>
			                    	</tr>
		                    	</c:if>
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
