<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(moveMonth) {
	document.frm.moveMonth.value = moveMonth;
	document.frm.submit();
}
function showUserHistory(searchUserMix, elem) {
	
	var scrolled = $(window).scrollTop();
	var position = $(elem).offset();
	var left = position.left + 70;
	var top = position.top + 30 - scrolled ;
		
	$.post("/ajax/management/selectInputResultPerson.do?searchCondition=0&searchUserMix=" + encodeURIComponent(searchUserMix) 
			+ "&searchDate=" + encodeURIComponent(document.frm.searchDate.value),function(data){
		$("#tab1").html(data);
		$("#tab1").show();
		$("#tab1").dialog( { 
			height: 394
			,width: 599
			,position: [left, top]
			,closeOnEscape: true 
			,resizable: true
			,draggable: true
			//,modal: true
			,autoOpen: true				
		});		
	});		
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
						<li class="stitle">프로젝트별 인력투입 상세내역</li>
						<li class="navi">홈 > 경영정보 > 인력투입관리 > 프로젝트별 투입실적</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
			    <!-- 상단 검색창 시작 -->
			    	<form name="frm" method="POST" action="${rootPath}/management/selectInputResultProjectDetail.do" onsubmit="search(0); return false;">
					<input type="hidden" name="moveMonth" value="0"/>
					<input type="hidden" name="searchDate" value="${searchVO.searchDate}"/>
					<input type="hidden" name="searchPrjId" id="prjId" value="${searchVO.searchPrjId}"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
			            	<table cellpadding="0" cellspacing="0" summary="">
		                    <caption>상단 검색</caption>
		                    <colgroup>
		                    	<col class="col120"/>
		                    	<col class="px" />
		                    	<col class="col80" />
		                    </colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td>
			                    		<a href="javascript:search(-1)" class=""><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
			                			<span class="option_txt">${fn:substring(searchVO.searchDate,0,4)}년 ${fn:substring(searchVO.searchDate,4,6)}월</span>
										<a href="javascript:search(1)" class=""><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
			                    	</td>
			                    	<td class="search_right">
			                    		<span class="option_txt">프로젝트 </span>
										<input type="text" name="searchPrjNm" id="prjNm" class="search_txt03" onfocus="prjGen('prjNm','prjId',1);" readonly="readonly" value="${searchVO.searchPrjNm}"/>
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1);"/><span class="pL7"></span>
										<label><input type="checkbox" name="includeUnderPrj" value="Y" <c:if test="${searchVO.includeUnderPrj == 'Y'}">checked="checked"</c:if>/> 하위포함</label>
			                    	</td>
			                    	<td class="search_right">
										<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(0); return false;"/>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>							
	                </fieldset>
	                </form>
	                 
	            <!--// 상단 검색창 끝 -->
	            
	                   
	            <!-- 게시판 시작  -->
					<div class="boardList02 mB5">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>프로젝트별 인력투입 상세내역</caption>
	                    <colgroup>
	                    	<col width="px"/>
	                    	<col class="col70" />
	                    	<col class="col70" />
	                    	<col class="col70" />
	                   	 	<col class="col70" />
                    		<col class="col90" />
	                    	<col class="col90" />
	                    </colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>프로젝트</th>
	                    		<th>이름</th>
	                    		<th>투입시간</th>
	                    		<th>참여율</th>
	                    		<th>인건비</th>
	                    		<th>휴일근무일수</th>
	                    		<th class="td_last">휴일근무수당</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:set var="drTmSum" value="0"/>
	                    	<c:set var="drSalarySum" value="0"/>
	                    	<c:set var="holTmSum" value="0"/>
	                    	<c:set var="holSalarySum" value="0"/>
	                    	
	                    	<c:forEach items="${resultList}" var="result">
		                    	<c:forEach items="${result.inputResultProjectDetailList}" var="irpd" varStatus="c">
		                    	<tr>
		                    		<c:if test="${c.count == 1}">
			                    	<td class="txt_center" rowspan="${fn:length(result.inputResultProjectDetailList)}">
			                    		<span class="txtB_grey"></span>
			                    		<print:project prjId="${result.prjId}" prjNm="${result.prjNm}" prjCd="${result.prjCd}"/>
			                    	</td>
		                    		</c:if>
			                    	<td class="txt_center"
			                    	onclick="javascript:showUserHistory('${irpd.userNm}(${irpd.userId })', this)">
<!--			                    	<print:user userNo="${irpd.userNo}" userNm="${irpd.userNm}"/>-->
			                    		<span class="cursorPointer"> ${irpd.userNm} </span>
			                    	</td>
			                    	<td class="txt_center">${irpd.drTm}</td>
			                    	<td class="txt_center">${irpd.drTmPercent}%</td>
			                    	<td class="txt_center">
				                    	<c:if test="${user.isLeader == 'Y' || user.isSalaryadmin == 'Y'}">${irpd.drSalaryPrint}</c:if>
				                    	<c:if test="${user.isLeader == 'N' && user.isSalaryadmin == 'N'}">***,***</c:if>
			                    	</td>
			                    	<td class="txt_center">${irpd.holTm}</td>
			                    	<td class="td_last txt_center">${irpd.holSalaryPrint}</td>
		                    	</tr>
		                    	</c:forEach>
		                    	<tr>
			                    	<td class="txt_center bG" colspan="2">소계</td>
			                    	<td class="txt_center bG">${result.drTmSum}</td>
			                    	<c:set var="drTmSum" value="${result.drTmSum + drTmSum }"/>
			                    	<td class="txt_center bG">-</td>
			                    	<td class="txt_center bG">${result.drSalarySumPrint}</td>
			                    	<c:set var="drSalarySum" value="${result.drSalarySum + drSalarySum }"/>
			                    	<td class="txt_center bG">${result.holTmSum}</td>
			                    	<c:set var="holTmSum" value="${result.holTmSum + holTmSum }"/>
			                    	<td class="td_last txt_center bG">${result.holSalarySumPrint}</td>
			                    	<c:set var="holSalarySum" value="${result.holSalarySum + holSalarySum }"/>
		                    	</tr>   
	                    	</c:forEach>
	                    	
	                    		<tr>		                    		
			                    	<td class="txt_center bG01" colspan="2">총계</td>
			                    	<td class="txt_center bG01">${drTmSum}</td>
			                    	<td class="txt_center bG01">-</td>
			                    	<td class="txt_center bG01"><print:currency cost="${drSalarySum}"/></td>
			                    	<td class="txt_center bG01">${holTmSum}</td>
			                    	<td class="td_last txt_center bG01"><print:currency cost="${holSalarySum}"/></td>
		                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					* 임원 이상만 개인별 인건비 조회가 가능합니다.
					
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

<!-- for hidden dialog -->
<div id="tab1">
</div>

</body>
</html>
