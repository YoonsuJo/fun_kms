
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>
$(document).ready(function() {
	addOrgIdEvent();  
	
});


function invoiceListPaging(pageIndex) {
	document.bondCheckFm.pageIndex.value = pageIndex;
	document.bondCheckFm.action = '<c:url value="${rootPath}/fund/chckProjectBondCheckList.do" />';
	document.bondCheckFm.submit();
}

function searchList(){
	$('#orgnztId').val();
	document.bondCheckFm.action = '<c:url value="${rootPath}/fund/chckProjectBondCheckList.do" />';
	document.bondCheckFm.submit();
}

function viewProject(prjId){
	/*
	var form = $('#searchVO');
	form.attr("action", "/fund/selectProjectPopV.do?prjId="+prjId);
	form.submit();
	*/
	
	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=950px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function viewTotalSales(prjId, prjName){
	/*
	var form = $('#searchVO');
	form.attr("action", "/fund/selectProjectPopV.do?prjId="+prjId);
	form.submit();
	*/
	
	var popup = window.open("/fund/chckTotalSalesList.do?prjId="+prjId + "&prjName=" + prjName, "_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}
function viewGenSales(prjId, prjName){
	/*
	var form = $('#searchVO');
	form.attr("action", "/fund/selectProjectPopV.do?prjId="+prjId);
	form.submit();
	*/
	
	var popup = window.open("/fund/chckGenSalesList.do?prjId="+prjId + "&prjName=" + prjName, "_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function viewProjectSales(prjId, prjName){

	var popup = window.open("/fund/chckProjectBondCheckView.do?prjId="+prjId + "&prjName=" + prjName, 
			"_POP_PROJECT_SALES","width=1000px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function addOrgIdEvent() {

	$('.select01').change(function(){
		OrgIdEvent(this);
	});

	function OrgIdEvent(selector) {
		var option = selector.children('selected');
		$('#orgnztId').val(option.val());			
	};
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
							<li class="stitle">채권 현황(프로젝트별)</li>
							<li class="navi">홈 > 경영정보 > 매출관리 > 채권 관리(사업부용)</li>
						</ul>
					</div> <!-- div class="path_navi" -->
	
					<span class="stxt">금액을 클릭하면 해당 부서의 프로젝트별 채권관리 상세정보 페이지로 이동합니다.</span>

					<!-- S: section -->
					<div class="section01">
						
					<form:form commandName="bondCheckFm" id="bondCheckFm" name="bondCheckFm" method="post"  >
						<input type="hidden" name="searchCondition" 	id="searchCondition" value="Y"/>
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col class="col300" />
								<col class="col200" />
								<col class="col300" />
								<col class="col200" />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<select  name="orgnztId" id="orgnztId" class="select01 w150" >
											<option value="" > 전 체 </option>
											<c:forEach items="${rstOrgnztList}" var="rstOrgnzt" varStatus="c">
											<c:choose>
												<c:when test="${rstOrgnzt.orgnztId == bcFm.orgnztId}">
													<option value="${rstOrgnzt.orgnztId}" selected > ${rstOrgnzt.orgnztName}</option>
												</c:when>
												<c:otherwise>
													<option value="${rstOrgnzt.orgnztId}" > ${rstOrgnzt.orgnztName} </option>
												</c:otherwise>
											</c:choose>
											</c:forEach>
										</select>
									</td>
									<td>
										<c:choose>
											<c:when test="${bcFm.inclBondZero == 'Y'}">
												<label>미수금 0 포함 : </label> <input type="checkbox" class="check" name="inclBondZero" id="inclBondZero" value="Y" checked="checked" /> 
											</c:when>
											<c:otherwise>
												<label>미수금 0 포함 : </label> <input type="checkbox" class="check" name="inclBondZero" id="inclBondZero" value="Y" /> 
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<span class="pL70"></span><label>기준일 : </label><input type="text" class="input03 w100 calGen"  readonly="readonly" name="fromDate" id="fromDate" value="${bcFm.fromDate}"/>
									</td>
									<td class="search_right" >
										<img src="../../images/btn/btn_search02.gif" class="search_btn02 cursorPointer" alt="검색" onclick="searchList();"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
                	</form:form>
						
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col30" />
		                    	<col class="col300" />
<!--  총발생액은 일단 가린다 
		                    	<col class="col80" />
-->
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col80" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th >번호</th>
		                    		<th >프로젝트명</th>
<!--  총발생액은 일단 가린다 
		                    		<th><span class="tooltip" >총발행액</span></th>
-->
		                    		<th><span class="tooltip" >전월미수잔액</span></th>
		                    		<th><span class="tooltip" >금월발생액</span></th>
		                    		<th><span class="tooltip" >금월수금액</span></th>
		                    		<th><span class="tooltip" onmouseover="bindTooltip(this, '4688', '250');">미수금액</span></th>
		                    	</tr>
		                    	<tr>
		                    		<th ></th>
		                    		<th >합계</th>
<!--  총발생액은 일단 가린다 
		                    		<th><span class="tooltip" >총발행액</span></th>
-->
		                    		<th><print:currency cost="${(bcVOSum.totalPrjSum - bcVOSum.totalPrjCollect) - (bcVOSum.monthPrjSum - bcVOSum.monthPrjCollect)}"/></th>
		                    		<th><print:currency cost="${bcVOSum.monthPrjSum}"/></th>
		                    		<th><print:currency cost="${bcVOSum.monthPrjCollect}"/></th>
		                    		<th><print:currency cost="${bcVOSum.totalPrjSum - bcVOSum.totalPrjCollect}"/></th>
		                    	</tr>
		                    </thead>
		                    <tfoot>
		                    	<tr>
			                    	<td class="txt_center" colspan="2">합계</td>
<!--  총발생액은 일단 가린다 
			                    	<td class="txt_right pR10"><print:currency cost="${bcVOSum.totalPrjSum}"/></td>
-->
			                    	<td class="txt_right pR10"><print:currency cost="${(bcVOSum.totalPrjSum - bcVOSum.totalPrjCollect) - (bcVOSum.monthPrjSum - bcVOSum.monthPrjCollect)}"/></td>
			                    	<td class="txt_right pR10"><print:currency cost="${bcVOSum.monthPrjSum}"/></td>
			                    	<td class="txt_right pR10"><print:currency cost="${bcVOSum.monthPrjCollect}"/></td>
			                    	<td class="txt_right pR10"><print:currency cost="${bcVOSum.totalPrjSum - bcVOSum.totalPrjCollect}"/></td>
		                    	</tr>
		                    </tfoot>
		                    <tbody>
		                    	<c:forEach items="${bcVOList}" var="vo" varStatus="c">
		                    	<tr>
									<td class="txt_center"><a href="javascript:viewProject('${vo.prjId}' );">
										<c:out value="${c.count}"/></a></td>
			                    	<td class="txt_left pL7"><a href="javascript:viewProjectSales('${vo.prjId}', '${vo.prjName}' );">${vo.prjName}</a></td>

<!--  총발생액은 일단 가린다 
			                    	<td class="txt_right pR10"><print:currency cost="${vo.totalPrjSum}"/></td>
-->
			                    	<td class="txt_right pR10"><print:currency cost="${(vo.totalPrjSum - vo.totalPrjCollect) - (vo.monthPrjSum - vo.monthPrjCollect)}"/></td>
			                    	<td class="txt_right pR10"><print:currency cost="${vo.monthPrjSum}"/></td>
			                    	<td class="txt_right pR10"><print:currency cost="${vo.monthPrjCollect}"/></td>
			                    	<td class="txt_right pR10"><print:currency cost="${vo.totalPrjSum - vo.totalPrjCollect}"/></td>
		                    	</tr>
		                    	</c:forEach>
		                    </tbody>
		                    </table>
							<p class="th_plus03">* 미수금 금액이 마이너스이면 초과 수금임.</p>
						</div>  <!-- class="boardList02 mB20" -->
				<div class="btn_area">
				</div>

					</div>	<!-- E: section -->
				</div>	<!-- E: center -->				
				<%@ include file="../include/right.jsp"%>
			</div>	<!-- E: centerBg -->
		</div>	<!-- E: contents -->
	</div>  <!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div> <!-- id=wrap -->
</body>
</html>
