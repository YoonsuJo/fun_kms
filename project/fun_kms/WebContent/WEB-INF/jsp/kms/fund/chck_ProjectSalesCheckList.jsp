
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
	document.invcStatVOFm.pageIndex.value = pageIndex;
	document.invcStatVOFm.action = '<c:url value="${rootPath}/fund/chckProjectSalesCheckList.do" />';
	document.invcStatVOFm.submit();
}

function searchList(){
	document.invcStatVOFm.pageIndex.value = 1;
	document.invcStatVOFm.action = '<c:url value="${rootPath}/fund/chckProjectSalesCheckList.do" />';
	document.invcStatVOFm.submit();
}

function viewProject(prjId){
	/*
	var form = $('#searchVO');
	form.attr("action", "/fund/selectProjectPopV.do?prjId="+prjId);
	form.submit();
	*/
	
	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
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

	var popup = window.open("/fund/chckProjectBondCheckView.do?prjId="+prjId + "&prjName=" + prjName, "_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function addOrgIdEvent() {

	$('#orgnztIdSel').change(function(){
		OrgIdEvent(this);
	});

	function OrgIdEvent(selector) {
		var option = selector.children(':selected');
		$('#orgnztId').val(option.val());			
	};
}


</script>
<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">계산서 발행 관리(프로젝트별 매출 vs 계산서 발행 현황)</li>
							<li class="navi">홈 > 경영정보 > 매출관리 > 계산서 발행 관리</li>
						</ul>
					</div> <!-- div class="path_navi" -->
	
					<span class="stxt"></span>

					<!-- S: section -->
					<div class="section01">
						
					<form:form commandName="invcStatVOFm" id="invcStatVOFm" name="invcStatVOFm" method="post"  >
						<input type="hidden" name="pageIndex" 			id="pageIndex" value="${invcStatVO.pageIndex}"/>
						<input type="hidden" name="searchCondition" 	id="searchCondition" value="Y"/>
						<input type="hidden" name="orgnztId" id="orgId" value="${invcStatVO.orgnztId}"/>
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col class="col100" />
								<col class="col100" />
								<col class="col100" />
								<col class="col100" />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<select  name="orgnztIdSel" id="orgnztIdSel" class="orgidsel w150" >
											<option value="" > 전 체 </option>
											<c:forEach items="${rstOrgnztList}" var="rstOrgnzt" varStatus="c">
											<c:choose>
												<c:when test="${rstOrgnzt.orgnztId == invcStatVO.orgnztId}">
													<option value="${rstOrgnzt.orgnztId}" selected > ${rstOrgnzt.orgnztName} </option>
												</c:when>
												<c:otherwise>
													<option value="${rstOrgnzt.orgnztId}" > ${rstOrgnzt.orgnztName} </option>
												</c:otherwise>
											</c:choose>
											</c:forEach>
										</select>
									</td>
									<td>
										<input type="text" class="input03 w100 calGen"  readonly="readonly" name="toDate" id="toDate" value="${invcStatVO.toDate}"/>&nbsp;까지 매출
									</td>
									<td>
										<label>목록수 </label><input type="text" name="recordCountPerPage" class="input01 span_5" value="${invcStatVO.recordCountPerPage}" />
									</td>
									<td class="search_right">
										<img src="../../images/btn/btn_search02.gif" class="search_btn02 cursorPointer" alt="검색" onclick="searchList();"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
	                	<!-- 상단 검색창 끝 -->
                	</form:form>
						
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col30" />
		                    	<col class="col300" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col70" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th >번호</th>
		                    		<th >프로젝트명</th>
		                    		<th><span class="tooltip" >계약매출액</span></th>
		                    		<th><span class="tooltip" >미발행금액</span></th>
		                    		<th><span class="tooltip" >진행매출액</span></th>
		                    		<th><span class="tooltip" >미발행금액</span></th>
		                    		<th><span class="tooltip" >계산서발행액</span></th>
		                    		<th><span class="tooltip" onmouseover="bindTooltip(this, '4688', '250');">미수금액</span></th>
		                    	</tr>
		                    </thead>
		                    <tfoot>
		                    	<tr>
			                    	<td class="txt_center" colspan="2">합계</td>
			                    	<td class="txt_right "><print:currency cost="${rstInvcStatVOSum.contractSales}"/></td>
			                    	<td class="txt_right "><print:currency cost="${rstInvcStatVOSum.contractSales - rstInvcStatVOSum.invPrjPrice}"/></td>
			                    	<td class="txt_right "><print:currency cost="${rstInvcStatVOSum.progressiveSales}"/></td>
			                    	<td class="txt_right "><print:currency cost="${rstInvcStatVOSum.progressiveSales - rstInvcStatVOSum.invPrjPrice}"/></td>
			                    	<td class="txt_right "><print:currency cost="${rstInvcStatVOSum.invPrjSum}"/></td>
			                    	<td class="txt_right "><print:currency cost="${rstInvcStatVOSum.invPrjSum - rstInvcStatVOSum.invPrjCollect}"/></td>
		                    	</tr>
		                    </tfoot>
		                    <tbody>
		                    	<c:forEach items="${rstInvcStatVOList}" var="result" varStatus="c">
		                    	<tr>
									<td class="txt_center"><a href="javascript:viewProject('${result.prjId}' );">
										<c:out value="${(paginationInfo.totalRecordCount) - ((invcStatVO.pageIndex-1) * paginationInfo.recordCountPerPage + c.count) + 1}"/></a></td>
			                    	<td class="txt_left pL7"><a href="javascript:viewProjectSales('${result.prjId}', '${result.prjName}' );">${result.prjName}</a></td>

			                    	<td class="txt_right "><print:currency cost="${result.contractSales}"/></td>
			                    	<td class="txt_right "><print:currency cost="${result.contractSales - result.invPrjPrice}"/></td>
			                    	<td class="txt_right "><print:currency cost="${result.progressiveSales}"/></td>
			                    	<td class="txt_right "><print:currency cost="${result.progressiveSales - result.invPrjPrice}"/></td>
			                    	<td class="txt_right "><print:currency cost="${result.invPrjSum}"/></td>
			                    	<td class="txt_right "><print:currency cost="${result.invPrjSum - result.invPrjCollect}"/></td>
		                    	</tr>
		                    	</c:forEach>
		                    </tbody>
		                    </table>
							<p class="th_plus03">* 미발행 금액이 마이너스이면 계산서를 초과발행한 것임.</p>
						</div>  <!-- class="boardList02 mB20" -->
						<div class="paginate">
							<ui:pagination paginationInfo="${paginationInfo}" jsFunction="invoiceListPaging" type="image"/>
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
