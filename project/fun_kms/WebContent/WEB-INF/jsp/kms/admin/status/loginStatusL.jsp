	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script>
$(document).ready(function(){
	;
});
function search(moveYear){
	document.frm.moveYear.value = moveYear;
	document.frm.action = '<c:url value="${rootPath}/admin/status/loginStatusL.do" />';
	document.frm.submit();
}
function statusView(searchUserNo, searchMonth){
	document.frm.searchUserNo.value = searchUserNo;
	document.frm.searchMonth.value = searchMonth;
	document.frm.action = '<c:url value="${rootPath}/admin/status/loginStatusV.do" />';
	document.frm.submit();
}

function excelDown() {
	// todo
	var form = $('#frm1');
	if(form.find('[name=startDt]').val() == null || form.find('[name=startDt]').val().length<8 ||
			form.find('[name=endDt]').val() == null || form.find('[name=endDt]').val().length<8){
		alert("시작일/종료일을 입력하여 주십시오.");
		return; 
	}
	document.frm1.action = "/admin/status/loginStatusExcel.do";
	document.frm1.submit();
}
</script>
</head>

<body>

<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">로그인 현황</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						<p class="th_stitle">기간별 로그인현황 엑셀 출력</p>
						<form name="frm1" id="frm1" method="POST">
							<div class="boardWrite02 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>댓글달기</caption>
									<colgroup>
										<col width="120" />
										<col width="px" />
										<col width="120" />
										<col width="px" />
									</colgroup>
									<tr>
										<td class="title">시작일</td>
										<td class="pL10"><input type="text" name="startDt" class="span_5 calGen txt_center" value="${firstDate}" /></td>
										<td class="title">종료일</td>
										<td class="pL10"><input type="text" name="endDt" class="span_5 calGen txt_center" value="${todayDate}" /></td>
									</tr>
									<tr>
										<td class="title">엑셀출력</td>
										<td class="txt_right" colspan="3"><a href="javascript:excelDown();"><img src="/images/btn/btn_excelSave.gif"/></a></td>
									</tr>
								</table>
							</div>
						</form>
					</div>
					<!-- E: section -->	


					<!-- S: section -->
					<div class="section01">
					<p class="th_stitle">월별 로그인현황</p>
					<!-- 상단 검색창 시작 -->
					<form name="frm" action="${rootPath}/admin/status/loginStatusL.do" method="POST" onsubmit="search(0); return false;">
					<input type="hidden" name="searchDate" value="${searchDate}"/>
					<input type="hidden" name="moveYear" value="0"/>
					<input type="hidden" name="searchUserNo"/>
					<input type="hidden" name="searchMonth"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td class="txt_right">
			            	 		<a href="javascript:search(-1);"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
									${fn:substring(searchDate, 0, 4)}년
									<a href="javascript:search(1);" class="pR10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
								</td>
							</tr>
						</tbody>
						</table>
			            </div>
			        </fieldset>
					</form>
			       	<!-- 상단 검색창 끝 -->
	            
           		 	<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col30" />
	                    	<col class="col140" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
                    	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>번호</th>
	                    		<th>이름</th>
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
	                    		<th class="td_last">12월</th>
	                    	</tr>
	                    	
	                    </thead>
	                    <tbody>
	                    	<c:choose>
	                    	<c:when test="${empty resultList}">
	                    		<tr>
	                    			<td class="txt_center td_last" colspan="13">※ 해당 년도의 사용자 로그인 내역이 없습니다.</td>
	                    		</tr>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<c:forEach items="${resultList}" var="result" varStatus="vs">
			                    	<tr>
			                    		<td class="txt_center">${vs.count}</td>
				                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}" printId="true"/></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '01' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}01');">${result.month01}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '02' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}02');">${result.month02}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '03' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}03');">${result.month03}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '04' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}04');">${result.month04}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '05' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}05');">${result.month05}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '06' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}06');">${result.month06}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '07' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}07');">${result.month07}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '08' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}08');">${result.month08}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '09' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}09');">${result.month09}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '10' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}10');">${result.month10}</a></td>
				                    	<td class="txt_center<c:if test="${fn:substring(searchDate, 4, 6) == '11' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}11');">${result.month11}</a></td>
				                    	<td class="txt_center td_last<c:if test="${fn:substring(searchDate, 4, 6) == '12' && thisYear}"> TdBg1</c:if>"><a href="javascript:statusView(${result.userNo},'${fn:substring(searchDate, 0, 4)}12');">${result.month12}</a></td>
			                    	</tr>
		                    	</c:forEach>
	                    	</c:otherwise>
	                    	</c:choose>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
		                
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
