<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function search() {
	document.frm.submit();
}
function excelDown() {
	document.frm.action = "/cooperation/selectDayReportUserListExcel1.do";
	document.frm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;

	var usrMix = document.getElementById("usrMix");
	var orgNm = document.getElementById("orgNm");
	var usrTree = document.getElementById("usrTree");
	var orgTree = document.getElementById("orgTree");

	if (n == 0) {
		document.frm.searchUserMix.value = "${searchVO.searchUserMix}";
		document.frm.searchOrgNm.value = "";
		document.frm.searchOrgId.value = "";
		usrMix.style.display = "";
		orgNm.style.display = "none";
		usrTree.style.display = "";
		orgTree.style.display = "none";
	} else if (n == 1) {
		document.frm.searchUserMix.value = "";
		document.frm.searchOrgNm.value = "${searchVO.searchOrgNm}";
		document.frm.searchOrgId.value = "${searchVO.searchOrgId}";
		usrMix.style.display = "none";
		orgNm.style.display = "";
		usrTree.style.display = "none";
		orgTree.style.display = "";
	}
}

var tDate = new Date();
var today = getDate(tDate);
var lastMonth = getDate(tDate, -31);

function dateSetToday(){	
	document.frm.searchDateFrom.value = today; 
	document.frm.searchDateTo.value = today;
}
function dateSetInit(){ //1주일
	document.frm.searchDateFrom.value = ${searchVO.searchDateInit }; 
	document.frm.searchDateTo.value = today;
}
function dateSetMonth(){ //월선택
	var df = document.frm.searchDateFrom.value; 
	document.frm.searchDateFrom.value = getFirstDayOfMonth(df);
	document.frm.searchDateTo.value = getLastDayOfMonth(df);
	var t = document.getElementById("messageTarget");
	displayMessageSimple("시작일 기준월단위 선택 ", "txtB_grey", t);
}
function checkDateFrom(){ //월선택 기능으로 통합. 사용안함. 두번째 방식
	var df = document.frm.searchDateFrom.value; 
	var dt = document.frm.searchDateTo.value;
	var t = document.getElementById("messageTarget");
	var dd = getDateDiff(dt, df);
	if(dd > 30){
		dt = getDate(df, 30);
		displayMessageSimple("30일 간격으로 검색", "txtB_grey", t);
		document.frm.searchDateTo.value = dt;
	}
}
function checkDateTo(){ //월선택 기능으로 통합. 사용안함. 두번째 방식
	var df = document.frm.searchDateFrom.value;
	var dt = document.frm.searchDateTo.value;
	var t = document.getElementById("messageTarget");
	var dd = getDateDiff(dt, df);	
	if(dd > 30){
		df = getDate(dt, -30);
		displayMessageSimple("30일 간격으로 검색", "txtB_grey", t);
		document.frm.searchDateFrom.value = df;
	}
}
function checkDateOld() { //월선택 기능으로 통합. 사용안함. 처음 제약조건.
	var df = document.frm.searchDateFrom.value; 
	var dt = document.frm.searchDateTo.value;
	var t = document.getElementById("messageTarget");
	if(dt > today){
		displayMessageSimple("오늘 이후 날짜 선택불가", "txtB_grey", t);
		document.frm.searchDateTo.value = today;
	}
	if(df < lastMonth){
		displayMessageSimple("1달 이전 날짜 선택불가", "txtB_grey", t);
		document.frm.searchDateFrom.value = lastMonth;
	}
}
var openedLayerName;
function hideLayer() {
	$('#'+openedLayerName).dialog( "close" );
}
function fixLayer() {
	openedLayerName = "";
}
function showLayer(layerName, obj) {
	var scrolled = $(window).scrollTop();
	var position = $(obj).offset();
	var left = position.left + 65;
	var top = position.top + 28 - scrolled ;	

	hideLayer();
	openedLayerName = layerName;
	
	$('#'+layerName).dialog( {	
		height: 147
		,width: 249
		,position : [left, top]
		,closeOnEscape: true 
		,resizable: true
		,draggable: true
		//,modal: true
		,autoOpen: true
		//,beforeClose: function(event, ui) { alert(1);}     
	});
}
function moveDetail(searchDate, searchUserNm){
	//document.location.href = "${rootPath}/cooperation/selectDayReport.do?searchDate=" + searchDate + "&searchUserNm=" + encodeURIComponent(searchUserNm);			
	window.open("${rootPath}/cooperation/selectDayReport.do?searchDate=" + searchDate + "&searchUserNm=" + encodeURIComponent(searchUserNm));
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
						<li class="stitle">업무일지 작성현황</li>
						<li class="navi">홈 > 업무공유 > 업무계획/실적 > 업무일지 작성현황</li>
					</ul>
				</div>
				
				<div id="messageTarget">
				</div>
				
				<!-- S: section -->
				<div class="section01">
			   		<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST" action="${rootPath}/cooperation/selectDayReportUserList.do" onsubmit="search(); return false;">
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<input type="hidden" name="searchUserNo" value="0"/>
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
		                		<li class="li_left">
		                			기간 :
		                			<input type="text" class="input01 span_4 calGen" name="searchDateFrom" value="${searchVO.searchDateFrom}"/>
<!--		                			onchange="checkDateFrom();"/>-->
		                			~
		                			<input type="text" class="input01 span_4 calGen" name="searchDateTo" value="${searchVO.searchDateTo}"/>
<!--		                			onchange="checkDateTo();"/>-->
		                		</li>
		                		<li class="li_right">	                		
		                			<span class="button"><input type="button" value="당일" onclick="javascript:dateSetToday();" ></span>
		                			<span class="button"><input type="button" value="이번주" onclick="javascript:dateSetInit();" ></span>
		                			<span class="button"><input type="button" value="한달" onclick="javascript:dateSetMonth();" ></span>
		                			<label><input type="radio" class="radio" name="searchCondition" value="0" onclick="selRadio(0);"/> 사용자</label>
									<label><input type="radio" class="radio" name="searchCondition" value="1" onclick="selRadio(1);"/> 부서</label><span class="pL7"></span>
									<input type="text" class="search_txt02 userNameAuto" name="searchUserMix" id="usrMix"/>
									<input type="text" class="search_txt02" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}" 
									readonly="readonly" onclick="orgGen('orgNm', 'orgId', 0, '${orgnztId }' );"/>
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="usrTree" onclick="usrGen('usrMix', 0, null, null, '1');"/>
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="orgTree" onclick="orgGen('orgNm', 'orgId', 0, '${orgnztId }');"/>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색"/>
		                		</li>
	                		</ul>
	                		<script type="text/javascript">selRadio("${searchVO.searchCondition}");</script>
						</div>
	                </fieldset>
			   		</form>
	            	<!--// 상단 검색창 끝 -->
	            	
	            	<div id="description">				
		            	당일(기본): 익일 오전 6시까지 작성한 업무실적 중 300자 미만인 업무실적<br/>
		            	당일(상세): 익일 오전 6시까지 작성한 업무실적 중 300자 이상인 업무실적<br/>
		            	기한초과: 익일 오전 6시 이후 작성한 업무실적<br/>
		            	미작성: 미작성한 업무실적<br/>
	            	</div>
	            	
		            <!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table border="0" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>업무일지 작성현황 테이블</caption>
	                    <colgroup>
	                    	<col class="col60" />
	                    	<col class="col120" />
	                    	<col class="col35" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                   	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th rowspan="2">이름</th>
	                    		<th rowspan="2">소속부서</th>
	                    		<th rowspan="2">작성유효일수</th>
	                    		<th colspan="3">작성</th>	                    		
	                    		<th rowspan="2" class="td_last">미작성</th>
	                    	</tr>
	                    	<tr>
	                    		<th>당일(기본)</th>
	                    		<th>당일(상세)</th>
	                    		<th>기한초과</th>	                    		
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result" varStatus="i">
	                    	<c:if test="${i.count%2==0}"> <c:set var="bgColor" value="bG02"/> </c:if>
	                    	<c:if test="${i.count%2==1}"> <c:set var="bgColor" value="bG04"/> </c:if>   
		                    	<tr>
			                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
			                    	<td class="txt_center">${result.orgnztNm}</td>
			                    	<td class="bG txt_center">
<!--			                    	<a href="${rootPath}/cooperation/selectDayReport.do?searchDate=${searchVO.searchDateTo}&searchUserNm=${result.userNm}(${result.userId})">-->
			                    	<a href="${rootPath}/cooperation/selectDayReportUser.do?mode=0&searchDateFrom=${searchVO.searchDateFrom}&searchDateTo=${searchVO.searchDateTo}&searchUserNo=${result.userNo}"
			                    	target="_blank">
			                    		${result.dateCnt}</a></td>
			                    	<td class="${bgColor } txt_center">
<!--			                    	<a href="${rootPath}/cooperation/selectDayReport.do?searchDate=${searchVO.searchDateTo}&searchUserNm=${result.userNm}(${result.userId})">-->
			                    	<a href="${rootPath}/cooperation/selectDayReportUser.do?mode=1&searchDateFrom=${searchVO.searchDateFrom}&searchDateTo=${searchVO.searchDateTo}&searchUserNo=${result.userNo}"
			                    	target="_blank">
			                    		<c:if test="${result.normal == 0}"> - </c:if>
			                    		<c:if test="${result.normal > 0}">${result.normal}</c:if>
			                    		</a></td>
			                    	<td class="${bgColor } txt_center">
<!--			                    	<a href="${rootPath}/cooperation/selectDayReport.do?searchDate=${searchVO.searchDateTo}&searchUserNm=${result.userNm}(${result.userId})">-->
			                    	<a href="${rootPath}/cooperation/selectDayReportUser.do?mode=2&searchDateFrom=${searchVO.searchDateFrom}&searchDateTo=${searchVO.searchDateTo}&searchUserNo=${result.userNo}"
			                    	target="_blank">
			                    		<c:if test="${result.over == 0}"> - </c:if>
			                    		<c:if test="${result.over > 0}">${result.over}</c:if>
			                    		</a></td>
			                    	<td class="${bgColor } txt_center">
<!--			                    	<a href="${rootPath}/cooperation/selectDayReport.do?searchDate=${searchVO.searchDateTo}&searchUserNm=${result.userNm}(${result.userId})">-->
			                    	<a href="${rootPath}/cooperation/selectDayReportUser.do?mode=3&searchDateFrom=${searchVO.searchDateFrom}&searchDateTo=${searchVO.searchDateTo}&searchUserNo=${result.userNo}"
			                    	target="_blank">			                    		
			                    		<c:if test="${result.late == 0}"> - </c:if>
			                    		<c:if test="${result.late > 0}"><span class="txt_red">${result.late}</span></c:if>
			                    		</a></td>
			                    	<td class="${bgColor } txt_center">
<!--			                    	<a href="${rootPath}/cooperation/selectDayReport.do?searchDate=${searchVO.searchDateTo}&searchUserNm=${result.userNm}(${result.userId})">-->
			                    	<a href="${rootPath}/cooperation/selectDayReportUser.do?mode=4&searchDateFrom=${searchVO.searchDateFrom}&searchDateTo=${searchVO.searchDateTo}&searchUserNo=${result.userNo}"
			                    	target="_blank">
			                    		<c:if test="${result.noinput == 0}"> - </c:if>
			                    		<c:if test="${result.noinput > 0}"><span class="txt_red">${result.noinput}</span></c:if>
			                    		</a></td>			                    	
		                    	</tr>
		                    	
		                    	<!-- 추가정보 레이어  //사장님 보시고 사용안함으로 변경-->
		                    	<c:set var="normalDate" value="${fn:split(result.normalDate, ',')}" />
	                    		<div id="normal${result.userNo }" style="display:none; z-index:5; ">
	                    			<print:user userNo="${result.userNo}" userNm="${result.userNm}"/> : 당일(기본 300자 미만)<br/>
	                    			<c:forEach items="${normalDate}" var="n" varStatus="i">
									<a href="${rootPath}/cooperation/selectDayReport.do?searchDate=${n}&searchUserNm=${result.userNm}(${result.userId})" target="_blank">
										${n }</a><br/>
									</c:forEach>
								</div>
								<c:set var="overDate" value="${fn:split(result.overDate, ',')}" />
								<div id="over${result.userNo }" style="display:none; z-index:5">
									<print:user userNo="${result.userNo}" userNm="${result.userNm}"/> : 당일(상세 300자 이상)<br/>
									<c:forEach items="${overDate}" var="n" varStatus="i">
									<a href="${rootPath}/cooperation/selectDayReport.do?searchDate=${n}&searchUserNm=${result.userNm}(${result.userId})" target="blank">
										${n }</a><br/>
									</c:forEach>								
								</div>
								<c:set var="lateDate" value="${fn:split(result.lateDate, ',')}" />
								<div id="late${result.userNo }" style="display:none; z-index:5">
									<print:user userNo="${result.userNo}" userNm="${result.userNm}"/> : 기한초과(익일 6시 이후)<br/>
									<c:forEach items="${lateDate}" var="n" varStatus="i">
									<a href="${rootPath}/cooperation/selectDayReport.do?searchDate=${n}&searchUserNm=${result.userNm}(${result.userId})" target="blank">									
										${n }</a><br/>
									</c:forEach>
								</div>
								<c:set var="noinputDate" value="${fn:split(result.noinputDate, ',')}" />
								<div id="noinput${result.userNo }" style="display:none; z-index:5">
									<print:user userNo="${result.userNo}" userNm="${result.userNm}"/> : 미작성<br/>	
									<c:forEach items="${noinputDate}" var="n" varStatus="i">
									<a href="javascript:moveDetail('${n}', '${result.userNm}(${result.userId})');">
										${n }</a><br/>
									</c:forEach>																									
								</div>
								<!-- 추가정보 레이어  끝  -->	
	                    	</c:forEach>
	                    </tbody>
	                    <tfoot>
<!--	                    	<tr>-->
<!--		                    	<td class="T13B txt_center" colspan="2">종합</td>-->
<!--		                    	<td class="bG txt_center">${resultSum.dateCnt}</td>-->
<!--		                    	<td class="txt_center">${resultSum.normal}</td>-->
<!--		                    	<td class="txt_center">${resultSum.over}</td>-->
<!--		                    	<td class="txt_center">${resultSum.late}</td>-->
<!--		                    	<td class="txt_center">${resultSum.noinput}</td>		                    	-->
<!--	                    	</tr>-->
	                    </tfoot>
	                    </table>
	                </div>
	                
	                <div class="btn_area">
	                	<a href="javascript:excelDown();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>
	                </div>
	                
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
				